function hello {  
        "Hello $args"
        $args
        $args.Count
}
# With params
function add($n1, $n2) {
$n1 + $n2
    
}
# Type casting to numbers
function addn([int]$n1, [int]$n2) {
    $n1 + $n2
        
    }

    function proper($word) {
     # Do something to cap words.        
    }

    # Other way to declare params
    function addparam {
        param (
            [int]$n1, [int]$n2
        )
        $n1 + $n2
    }

    #Switch Type param
    function get-soup {
        param (
         $soup='Cat', [switch]$please
        )
        if($please){
            "$soup soup for you."
        }
        else{
            "No $soup soup for you!!!"
        }
        
    }