### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ c4762a58-ea79-11eb-182d-f9478bb8e494
begin 
	using Pkg; Pkg.activate(".")
	using Distributions, StaticArrays, StatsBase, Random, Plots, PlutoUI
end

# ╔═╡ f8070f4b-8863-4ede-9c6a-5842fbd74bc1
Normal(1,0.2)

# ╔═╡ b7808e37-ecdd-4395-b6a3-9be7fb9ccc0c
Normal(100,0.2) |> rand

# ╔═╡ 39c68ea6-7aff-4d2f-83b3-f58de753fd71
abstract type KBanditStrategy end 

# ╔═╡ a17d522a-00d1-49aa-a50f-02a4d965b968
[1.0,2.0,3.0] |> typeof

# ╔═╡ b406eadc-72a1-466a-bf83-b9e55c9b49ad
mutable struct KBanditProblem{K}
	estimates::Vector{Float64}
	true_values::Vector{Float64}
	rewards::Float64
	strategy::KBanditStrategy
	action_reward_probabilities::Vector{Normal{Float64}}
	time::Int64
	problem_size::Int64 # ¿cuántos bandidos / máquinas vamos a tener.
	function KBanditProblem{K}(strategy::KBanditStrategy) where K
		estimates = fill(0,K)
		rewards = 0
		true_values = randn(K)
		action_reward_probabilities = []
		for μ ∈ true_values
			distribución_actual = Normal(μ, 1)
			push!(action_reward_probabilities, distribución_actual)
		end
		time = 0
		problem_size = K
		return new(estimates, true_values, rewards, strategy, action_reward_probabilities, time, problem_size)
	end
end

# ╔═╡ 1f5c8a1f-4db9-497e-9029-a89f9ef3879d
abstract type AbstractGreedyStrategy <: KBanditStrategy end

# ╔═╡ 15be2458-841f-4ad9-a8d2-6283f8e52748
struct GreedyStrategy <: AbstractGreedyStrategy end

# ╔═╡ 02545c13-c621-4b19-8d2c-ba11328ca8c2
struct ϵ_GreedyStrategy <: AbstractGreedyStrategy 
	ϵ::Float64
end

# ╔═╡ 5664250b-936d-4a04-888b-6d9991589c5e
function get_max_set(estimates::Vector{Float64})
	currect_max, currect_max_index = findmax(estimates)
	max_indices_set = Set()
	for i ∈ currect_max_index:length(estimates)
		push!(max_indices_set, i)
	end
	return max_indices_set
end

# ╔═╡ 86a2f3e4-771f-4565-82ac-cdd21b6df0d9
function act(estimates::Vector{Float64}, strategy::GreedyStrategy)
	max_set = get_max_set(estimates)
	return rand(max_set)
end

# ╔═╡ 8fdff319-9591-4aba-b4dc-0cca8da49069
function act(estimates::Vector{Float64}, strategy::ϵ_GreedyStrategy)
	weights = ProbabilityWeights([strategy.ϵ, 1 - strategy.ϵ])
	i_am_greedy = sample([false, true], weights)
	if i_am_greedy 
		max_set = get_max_set(estimates)
		return rand(max_set)
	else
		return rand(1:length(estimates))
	end
end

# ╔═╡ 1e96ef75-378f-4d8d-b86a-9c2262ccbb84
function step!(problem::KBanditProblem)
	N = problem.time
	
	# Tomas decisión en base al vector de estimaciones y mi estrategia
	action = act(problem.estimates, problem.strategy)
	
	# Recibir el reward por la acción
	reward_probability_distribution = problem.action_reward_probabilities[action]
	reward = rand(reward_probability_distribution, 1)[1]
	
	# actualizando nuestros parámetros
	problem.estimates[action] = (N*problem.estimates[action] + reward) / (N+1)
	
	# Llevando rastro del reward total
	problem.rewards += reward
	return reward, action
end

# ╔═╡ bdb6fcdd-e0df-475c-a510-e93836d52fa5
function run(problem::KBanditProblem, N::Integer)
	rewards = []
	cummulative_rewards = []
	actions = []
	current_cummulative_rewards = 0
	
	# Realizar todos los pasos de simulación
	for _ ∈ 1:N
		current_reward, action = step!(problem)
		
		# Guardar estadísticas de retroalimentación
		current_cummulative_rewards += current_reward
		push!(rewards, current_reward)
		push!(actions, action)
		push!(cummulative_rewards, current_cummulative_rewards)
	end

	best_reward = N * max([elem.μ for elem ∈ problem.action_reward_probabilities]...)
	return rewards, actions, cummulative_rewards, best_reward
end

# ╔═╡ 40913df7-bf02-4b44-81d9-3afb76695bea
@bind ϵ Slider(0.0:0.01:1.0, show_value = true)

# ╔═╡ cee15657-237a-45b8-b4e0-ff4068b01ca4
problem = KBanditProblem{10}(ϵ_GreedyStrategy(ϵ))

# ╔═╡ 73d0b5c4-70cb-4792-8742-952055cccf3b
result = run(problem, 1000);

# ╔═╡ 55c69c7c-99b9-452d-b671-8848d81e2ca1
begin
	plot(result[2])
end

# ╔═╡ 688957ad-c493-4fe2-9624-b3837722e08d
fill(0,10)

# ╔═╡ 79bba391-fe37-45b8-b70e-3fabeef44342
randn(10)

# ╔═╡ 7cfa0f3b-42e1-4f91-872a-a94bb469a5eb
KBanditProblem(problem_size = 10)

# ╔═╡ Cell order:
# ╠═c4762a58-ea79-11eb-182d-f9478bb8e494
# ╠═f8070f4b-8863-4ede-9c6a-5842fbd74bc1
# ╠═b7808e37-ecdd-4395-b6a3-9be7fb9ccc0c
# ╠═39c68ea6-7aff-4d2f-83b3-f58de753fd71
# ╠═a17d522a-00d1-49aa-a50f-02a4d965b968
# ╠═b406eadc-72a1-466a-bf83-b9e55c9b49ad
# ╠═1f5c8a1f-4db9-497e-9029-a89f9ef3879d
# ╠═15be2458-841f-4ad9-a8d2-6283f8e52748
# ╠═02545c13-c621-4b19-8d2c-ba11328ca8c2
# ╠═1e96ef75-378f-4d8d-b86a-9c2262ccbb84
# ╠═86a2f3e4-771f-4565-82ac-cdd21b6df0d9
# ╠═8fdff319-9591-4aba-b4dc-0cca8da49069
# ╠═5664250b-936d-4a04-888b-6d9991589c5e
# ╠═bdb6fcdd-e0df-475c-a510-e93836d52fa5
# ╠═40913df7-bf02-4b44-81d9-3afb76695bea
# ╠═55c69c7c-99b9-452d-b671-8848d81e2ca1
# ╠═73d0b5c4-70cb-4792-8742-952055cccf3b
# ╠═cee15657-237a-45b8-b4e0-ff4068b01ca4
# ╠═688957ad-c493-4fe2-9624-b3837722e08d
# ╠═79bba391-fe37-45b8-b70e-3fabeef44342
# ╠═7cfa0f3b-42e1-4f91-872a-a94bb469a5eb
