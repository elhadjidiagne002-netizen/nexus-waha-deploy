FROM devlikeapro/waha:latest

# L'image officielle fixe NODE_OPTIONS=--max-old-space-size=16384, soit un tas
# de 16 Go — dimensionne pour un gros serveur. Sur l'instance Render qui
# heberge ce service (512 Mo), ce plafond n'est jamais atteint : Node ne
# declenche son ramasse-miettes qu'en approchant la limite qu'on lui donne,
# donc Render tue le conteneur pour depassement memoire bien avant que Node ne
# songe a liberer quoi que ce soit. Resultat : des redemarrages qui cassent la
# session WhatsApp (constate 2026-09-07, session en FAILED).
#
# 460 Mo laisse ~50 Mo au reste du processus (pile, buffers, modules natifs).
# A reajuster si le service passe sur un plan avec plus de RAM.
#
# Une variable NODE_OPTIONS definie cote Render ecraserait cette valeur : ne
# pas en ajouter une la-bas, sinon cette ligne devient silencieusement inerte.
ENV NODE_OPTIONS=--max-old-space-size=460
