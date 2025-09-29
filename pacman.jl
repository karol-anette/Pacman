using Agents

@agent struct Ghost(GridAgent(2))
    type::String = "Ghost"
end

1= libre
0= pared

matrix = [
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0;
    0 1 0 1 0 0 0 1 1 1 0 1 0 1 0 1 0;
    0 1 1 1 0 1 0 0 0 0 0 1 0 1 1 1 0;
    0 1 0 0 0 1 1 1 1 1 1 1 0 0 0 1 0;
    0 1 0 1 0 1 0 0 0 0 0 1 1 1 0 1 0;
    0 1 1 1 0 1 0 1 1 1 0 1 0 1 0 1 0;
    0 1 0 1 0 1 0 1 1 1 0 1 0 1 0 1 0;
    0 1 0 1 1 1 0 0 1 0 0 1 0 1 1 1 0;
    0 1 0 0 0 1 1 1 1 1 1 1 0 0 0 1 0;
    0 1 1 1 0 1 0 0 0 0 0 1 0 1 1 1 0;
    0 1 0 1 0 1 0 1 1 1 0 0 0 1 0 1 0;
    0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
]

function agent_step!(agent, model)
    #randomwalk!(agent, model)
    x, y = agent.pos
    movimientos = [(x+1, y), (x-1, y), (x, y+1), (x, y-1)]
    movimientos_validos = [(nx, ny) for (nx, ny) in movimientos if
        0 < nx <= size(matrix, 1) && 0 < ny <= size(matrix, 2) && matrix[nx, ny] == 1]
    if !isempty(movimientos_validos)
        agent.pos = rand(movimientos_validos)
end

function initialize_model()
    space = GridSpace((5,5); periodic = false, metric = :manhattan)
    model = StandardABM(Ghost, space; agent_step!)
    return model
end

model = initialize_model()
a = add_agent!(Ghost, pos= (3,3), model)

using CairoMakie

figure, _ = abmplot(model; agent_color = :magenta, agent_marker = :circle, as = 80) ; figure

#Run lines independently in terminal to see the plot
#npm run dev para que jale