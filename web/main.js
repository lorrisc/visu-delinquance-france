var map = L.map("map").setView([46.603354, 1.888334], 6);
var tooltips_container = document.querySelector("#tooltips");
map.attributionControl.remove();

L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {}).addTo(map);

fetch("contour-des-departements.geojson")
    .then(function (response) {
        return response.json();
    })
    .then(function (data) {
        L.geoJSON(data, {
            style: function (feature) {
                return {
                    fillColor: "#ff0000",
                    color: "#000000",
                    weight: 1,
                };
            },
            onEachFeature: function (feature, layer) {
                // create tooltip
                let tooltip = createElement("div", tooltips_container);
                let tooltip_departement = createElement("p", tooltip, "", [], {}, "Département : ");
                let tooltip_departement_nom = createElement("span", tooltip_departement, "", [], {}, feature.properties.nom);

                // over departement
                layer.on("mouseover", function (e) {
                    // tooltip
                    tooltip.classList.add("visible");

                    function handleMouseMove(e) {
                        tooltip.style.left = e.clientX + 10 + "px";
                        tooltip.style.top = e.clientY - tooltip.offsetHeight / 2 + "px";
                    }

                    document.addEventListener("mousemove", handleMouseMove);

                    // color
                    layer.setStyle({
                        fillColor: "#00ff00",
                    });

                    // reset
                    layer.on("mouseout", function () {
                        tooltip.classList.remove("visible");
                        layer.setStyle({
                            fillColor: "#ff0000",
                        });
                        document.removeEventListener("mousemove", handleMouseMove);
                    });
                });
            },
        }).addTo(map);
    })
    .catch(function (error) {
        console.error("Une erreur s'est produite lors du chargement des données GeoJSON :", error);
    });
