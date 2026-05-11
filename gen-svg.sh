ATHLETE="adamkadev"
TITLE="Adam Running"
TITLE_GRID="Over 10km Runs"
BIRTHDAY_MONTH="1997-02"
CURRENT_YEAR=$(date +%Y)

if [ ! -d "assets" ]; then
  mkdir assets
  echo "Created assets directory."
fi

echo "--- Start Data Syncing ---"

python3 run_page/run_page/garmin_sync.py YOUR_TOKEN  
python3 run_page/db_updater.py

echo "--- Generating All Years SVGs ---"

python3 run_page/gen_svg.py --from-db --title "$TITLE" --type github --github-style "align-firstday" --athlete "$ATHLETE" --special-distance 5 --special-distance2 10 --output assets/github.svg --use-localtime --min-distance 0.5
python3 run_page/gen_svg.py --from-db --title "$TITLE_GRID" --type grid --athlete "$ATHLETE" --output assets/grid.svg --special-distance 12 --special-distance2 15 --use-localtime --min-distance 10
python3 run_page/gen_svg.py --from-db --year all --generate-all-years --type github --github-style "align-firstday" --athlete "$ATHLETE" --special-distance 5 --special-distance2 10 --use-localtime --min-distance 0.5
python3 run_page/gen_svg.py --from-db --type circular --use-localtime
python3 run_page/gen_svg.py --from-db --type year_summary --output assets/year_summary.svg --athlete "$ATHLETE"

echo "Success!"