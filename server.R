library(data.table)
library(ggplot2)
library(shiny)

server <- function(input, output) {
  # Lyric Keyword Plots -----------------------------------
  
  output$tfidf_plot <- renderPlot({
    mm_lyrics_tfidf <-
      fread("data/shiny_data/modest_mouse_tfidf_lyrics.csv")
    ggplot(mm_lyrics_tfidf, aes(x = reorder(word, tf_idf), y = tf_idf)) +
      geom_col(colour = "#404040",
               fill = "#F2F2F2") +
      coord_flip() +
      labs(x = NULL,
           y = NULL) +
      facet_wrap(~ album_name, scales = "free", labeller = label_wrap_gen()) +
      theme_classic() +
      theme(
        text = element_text(family = "Courier",
                            size = 12),
        strip.background = element_rect(colour = "#404040",
                                        fill = "#F2F2F2"),
        panel.background = element_rect(colour = "#F2F2F2",
                                        fill = "#F2F2F2"),
        plot.background = element_rect(colour = "#F2F2F2",
                                       fill = "#F2F2F2")
      )
  })
  
  # Audio Feature Plot
  
  mm_track_audio_features <-
    fread("data/shiny_data/modest_mouse_audio_features.csv")
  
  plot_audio_features <- function(df) {
    ggplot(df, aes(x = reorder(track_name, value), y = value)) +
      geom_segment(aes(
        x = reorder(track_name, value),
        xend = reorder(track_name, value),
        y = 0,
        yend = value
      )) +
      geom_point(
        size = 5,
        color = "#404040",
        fill = "#404040",
        shape = 21,
        stroke = 2
      ) +
      coord_flip() +
      labs(x = NULL,
           y = NULL) +
      theme_classic() +
      theme(
        text = element_text(family = "Courier",
                            size = 14),
        strip.background = element_rect(colour = "#404040",
                                        fill = "#F2F2F2"),
        panel.background = element_rect(colour = "#F2F2F2",
                                        fill = "#F2F2F2"),
        plot.background = element_rect(colour = "#F2F2F2",
                                       fill = "#F2F2F2")
      )
  }
  
  output$track_recommendations <- renderPlot({
    mm_af_long <-
      melt(
        mm_track_audio_features,
        id.vars = c(
          "track_id",
          "id",
          "artist_name",
          "album_name",
          "release_date",
          "track_name",
          "track_number"
        ),
        variable.name = "audio_feature"
      )
    
    if (input$audio_feature == "positive") {
      return(
        mm_af_long[audio_feature == "valence" & value > .5] |>
          dplyr::slice_max(order_by = value, n = 10) |>
          plot_audio_features()
      )
    }
    
    else if (input$audio_feature == "negative") {
      return(
        mm_af_long[audio_feature == "valence" & value < .5] |>
          dplyr::slice_max(order_by = value, n = 10) |>
          plot_audio_features()
      )
    }
    
    mm_af_long[audio_feature == input$audio_feature] |>
      dplyr::slice_max(order_by = value, n = 10) |>
      plot_audio_features()
    
  })
  
  
}