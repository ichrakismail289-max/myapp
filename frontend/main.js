document.getElementById("deployBtn").addEventListener("click", async () => {
    const framework = document.getElementById("framework").value;
    const git_url = document.getElementById("git_url").value;

    const response = await fetch("http://127.0.0.1:5000/deploy", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ framework, git_url })
    });

    const data = await response.json();
    document.getElementById("result").textContent = 
        "Terraform Output:\n" + data.terraform_output + 
        "\n\nSSH Output:\n" + data.ssh_output;
    alert("Déploiement terminé ! Vérifie la section ci-dessous pour les logs.");
});
