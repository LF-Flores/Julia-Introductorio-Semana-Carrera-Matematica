### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ c4762a58-ea79-11eb-182d-f9478bb8e494
begin 
	using Pkg; Pkg.activate(".")
	using Distributions, StaticArrays, StatsBase, Random, Plots, PlutoUI
end

# ╔═╡ f8070f4b-8863-4ede-9c6a-5842fbd74bc1
Normal(1,0.2)

# ╔═╡ b7808e37-ecdd-4395-b6a3-9be7fb9ccc0c
Normal(100,0.2) |> rand

# ╔═╡ d5cf7e67-3b68-49f1-b736-497b7848c077
random.distributions.normal.sample.hacéesto.aquello

# ╔═╡ 39c68ea6-7aff-4d2f-83b3-f58de753fd71
abstract type KBanditStrategy end 

# ╔═╡ a17d522a-00d1-49aa-a50f-02a4d965b968
[1.0,2.0,3.0] |> typeof

# ╔═╡ b406eadc-72a1-466a-bf83-b9e55c9b49ad
struct KBanditProblem{K}
	estimates::Vector{Float64}
	true_values::Vector{Float64}
	rewards::Float64
	strategy::KBanditStrategy
	action_reward_probabilities::Vector{Normal{Float64}}
	time::Int64
	problem_size::Int64 # ¿cuántos bandidos / máquinas vamos a tener.
	function KBanditProblem{K}  ()
		...
	end
end

# ╔═╡ 7cfa0f3b-42e1-4f91-872a-a94bb469a5eb
KBanditProblem(problem_size = 10)

# ╔═╡ Cell order:
# ╠═c4762a58-ea79-11eb-182d-f9478bb8e494
# ╠═f8070f4b-8863-4ede-9c6a-5842fbd74bc1
# ╠═b7808e37-ecdd-4395-b6a3-9be7fb9ccc0c
# ╠═d5cf7e67-3b68-49f1-b736-497b7848c077
# ╠═39c68ea6-7aff-4d2f-83b3-f58de753fd71
# ╠═a17d522a-00d1-49aa-a50f-02a4d965b968
# ╠═b406eadc-72a1-466a-bf83-b9e55c9b49ad
# ╠═7cfa0f3b-42e1-4f91-872a-a94bb469a5eb
