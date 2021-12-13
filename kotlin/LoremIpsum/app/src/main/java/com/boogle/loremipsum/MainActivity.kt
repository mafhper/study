package com.boogle.loremipsum

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import com.boogle.loremipsum.R.id.tvResult

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Code goes here
        // Acessar o elemento que está no layout XML

        val tvResult = findViewById<TextView>(R.id.tvResult)

        // Definindo a variavel btEnviar
        val btEnviar = findViewById<Button>(R.id.btEnviar)



        // Criando um listener para o botão enviar

        btEnviar.setOnClickListener {
            // Definindo o texto
            tvResult.text = "@mafhper"
        }
    }
}