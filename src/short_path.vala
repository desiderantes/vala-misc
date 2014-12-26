using GLib;

struct Node {

    public double x;
    public double y;

    public Node(double x, double y) {
        this.x = x;
        this.y = y;

    }
}

struct Edge{

    public Node src;
    public Node dst;
    public double weight;

    public Edge(Node src, Node dst) {
        this.src = src;
        this.dst = dst;
        weight = GLib.Math.sqrt(GLib.Math.pow(src.x - dst.x, 2) + GLib.Math.pow(src.y - dst.y, 2));
    }

    public bool contains(Node node) {
        return (node == src || node == dst);
    }
}

struct CaseSolver {

    public Gee.ArrayList<Node?> nodes;
    private Gee.ArrayList<Edge?> edges;

    public CaseSolver(Gee.ArrayList<Node?> nodes) {
        this.nodes = nodes;
        edges = new Gee.ArrayList<Edge?>();
        foreach (Node node in nodes) {
            for (int i = nodes.index_of(node); i < nodes.size; i++) {
                edges.add(Edge(node, nodes.get(i)));
            }
        }
    }

    public Gee.ArrayList<Node?> conjunto(Node node, Gee.ArrayList<Gee.ArrayList<Node?>> sets) {

        foreach (Gee.ArrayList<Node?> arr in sets) {
            if (arr.contains(node)) {
                return arr;
            }
        }
        return new Gee.ArrayList<Node?>();
    }

    public double solve() {
        edges.sort((a,b)=>{ 
				if(a.weight > b.weight){ 
					return 1;
				}else if(a.weight < b.weight){ 
					return -1;
				} else{ 
					return 0;
				}
		});
        var sets = new Gee.ArrayList<Gee.ArrayList<Node?>>();
        var solution = new Gee.ArrayList<Edge?>();
        foreach (Node nod in nodes) {
            var to_add = new Gee.ArrayList<Node?>();
            to_add.add(nod);
            sets.add(to_add);
        }
        foreach (Edge e in edges) {
            Gee.ArrayList<Node?> a = conjunto(e.src, sets);
            Gee.ArrayList<Node?> b = conjunto(e.dst, sets);
            if (a != b) {
                solution.add(e);
                a.add_all(b);
                sets.remove(b);
            }
        }

        double sol = 0.0;
        foreach (Edge e in solution) {
            sol += e.weight;
        }
        return sol;
    }
}


static int main(string[] args){
	var nodes = new Gee.ArrayList<Node?>();
	nodes.add(Node (1.0,1.0));
	nodes.add(Node (2.0,2.0));
	nodes.add(Node (2.0,4.0));
	var case_solver = CaseSolver(nodes);
	print("%.2lf",case_solver.solve());
	return 0;

}