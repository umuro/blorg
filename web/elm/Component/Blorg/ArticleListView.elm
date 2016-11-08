--
--
module Component.Blorg.ArticleListView
  exposing
    ( Model, init, initialModel
    , Msg
    , Event(GoToArticle)
    , update, view)

import Type.Blorg.Article exposing(..)

import Type.Blorg.Exts exposing(..)
import Type.Blorg.Event exposing(..)
import Type.Blorg.Page as Page

-- Import Html
import Html exposing (Html, text, p)
import Html.App
import Exts.Html exposing(..)
-- Import Material
import Material
import Material.Button as Button
import Material.Grid exposing (grid, cell, size, Device(..), noSpacing)
import Material.Icon as Icon
import Material.List as Lists
import Material.Options as Options exposing (css, styled, div, span, img)
import Material.Table as Table
import Material.Textfield as Textfield
import Material.Typography as Typo
import Material.Color as Color

import Html.Events
import String

-- MODEL

type alias Model =
  { articleList : ArticleList
  , mdl : Material.Model
      -- Boilerplate: model store for any and all Mdl components you use.
  }

init : ArticleList -> (Model, Cmd Msg)
init articleList =
  ( initialModel articleList
  , Cmd.none
  )

initialModel : ArticleList -> Model
initialModel articleList =
    Model articleList Material.model


-- ACTION, UPDATE

type Msg
  = ClickArticle Article
    | Mdl (Material.Msg Msg)
    -- Boilerplate: Msg clause for internal Mdl messages.

type Event 
  = GoToArticle Article

update : Msg -> Model -> (Model, Cmd Msg, Maybe Event)
update msg model =
  case msg of
    ClickArticle article ->
      let
        _ = Debug.log "ClickArticle" article
      in
        ( model, Cmd.none, Just (GoToArticle article))
    -- Boilerplate: Mdl action handler.
    Mdl msg' ->
      withEvent <| Material.update msg' model

-- VIEW

type alias Mdl =
  Material.Model

view : Model -> Html Msg
view model =
  div [ ]
  [ Lists.ul []
      (List.indexedMap (viewItem model.mdl) model.articleList)
  , Button.render Mdl [0 ] model.mdl
    [ Button.fab
    , Button.colored
    , Button.disabled
    , css "position" "absolute"
    , css "bottom" "1em"
    , css "right" "1em"
    ]
    [ Icon.i "add"]  
  ]
    
viewItem mdl index item =
  Lists.li
  [ ]
  [ Lists.content 
--     [ Options.attribute <| Html.Events.onClick (ClickArticle item) ] 
--     [ text item.title ] 
    [  ] 
    [ Button.render Mdl [index, 1 ] mdl
      [ Button.onClick (ClickArticle item)
      ]
      [  text item.title ]
    ] 
  ]
  
        
