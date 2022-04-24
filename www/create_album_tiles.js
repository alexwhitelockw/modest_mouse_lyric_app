// Function used to create tiles on the page. Tiles are randomly filled based on
// a colour palette provided.
function create_squares() {
    document.getElementById("album-grid").innerHTML = "";
    let col_pal = ["#F2F2F2", "#D9D9D9", "#BFBFBF", "#737373", "#404040"]
    let height = document.getElementById("album-grid").offsetHeight; //window.innerHeight;
    let width = document.getElementById("album-grid").offsetWidth;
    let square_x = Math.floor(width / 100);
    let square_y = Math.floor(height / 100);
    for (let i = 0; i != square_x * square_y; i++) {
        let new_square = document.createElement("div");
        new_square.style.backgroundColor = col_pal[Math.floor(Math.random() * col_pal.length)];
        new_square.className = "tile";
        document.getElementById("album-grid").appendChild(new_square);
    }
    document.getElementById('album-grid').style.width = square_x * 100 + 'px';
};

// Randomly rotate a tile to reveal a random Modest Mouse Album image.
function flip_square() {
    const album_images = [
        "https://i.scdn.co/image/ab67616d00001e022416b406e0189c838c939bcf",
        "https://i.scdn.co/image/ab67616d00001e02ec0240f3581605ecae347c76",
        "https://i.scdn.co/image/ab67616d00001e02ed8a70a92499e619895646e8",
        "https://i.scdn.co/image/ab67616d00001e02bca897e548afce575f1660fc",
        "https://i.scdn.co/image/ab67616d00001e02cc68329bfbf34037df965dc1",
        "https://i.scdn.co/image/ab67616d00001e02f70395784775be1d949a1808",
        "https://i.scdn.co/image/ab67616d00001e028f7128431367ce70f773651c",
        "https://i.scdn.co/image/ab67616d00001e027bbcb94c9c076a133188bdbd",
        "https://i.scdn.co/image/ab67616d00001e026d36f5f881bb591a529e259b",
        "https://i.scdn.co/image/ab67616d00001e02384c4e86d7001ca9f10808db"
    ];

    let squares = document.getElementsByClassName("tile");
    let random_square = squares[Math.floor(Math.random() * squares.length)];
    let random_album = album_images[Math.floor(Math.random() * album_images.length)]
    random_square.animate([{
            transform: "rotateX(180deg)",
            perspective: "800px"
        },
        {
            backgroundImage: `url(${random_album})`,
            backgroundSize: "100px"
        }
    ], {
        duration: 3e3,
        iterations: 2,
        direction: "alternate"
    });
}

//window.onload = create_squares;
//window.onresize = create_squares;
window.setInterval(flip_square, 4e3);
window.addEventListener("load", create_squares);
window.addEventListener('resize', create_squares);