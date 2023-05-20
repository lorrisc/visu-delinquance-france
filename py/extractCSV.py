# Extraction du fichier CSV contenant les données de base vers d'autre fichier CSV representant les tables de la base de données

import pandas as pd

if __name__ == '__main__':
    df_data = pd.read_csv("py/input/donnee-dep-data.gouv-2022-geographie2022-produit-le2023-02-09.csv", sep=";")

    # year
    df_year = df_data[["annee"]].drop_duplicates().reset_index(drop=True)
    df_year["yr_id"] = df_year.index + 1
    df_year.rename(columns={"annee": "yr_lib"}, inplace=True)

    # department
    df_department = df_data[["Code.département"]].drop_duplicates().reset_index(drop=True)
    df_department["dp_id"] = df_department.index + 1
    df_department.rename(columns={"Code.département": "dp_code"}, inplace=True)

    # class
    df_class = df_data[["classe"]].drop_duplicates().reset_index(drop=True)
    df_class["cl_id"] = df_class.index + 1
    df_class.rename(columns={"classe": "cl_lib"}, inplace=True)

    # merge
    df_assoc = pd.merge(df_data, df_year, left_on="annee", right_on="yr_lib", how="left")
    df_assoc = pd.merge(df_assoc, df_department, left_on="Code.département", right_on="dp_code", how="left")
    df_assoc = pd.merge(df_assoc, df_class, left_on="classe", right_on="cl_lib", how="left")

    df_assoc = df_assoc.drop(columns=["classe","annee","Code.département","Code.région", "unité.de.compte",
       "millPOP", "millLOG", "POP", "LOG","yr_lib", "dp_code", "cl_lib"])

    # save
    outputPath = "py/output/"

    df_year.to_csv(outputPath+"year.csv", sep=";", index=False)
    df_department.to_csv(outputPath+"department.csv", sep=";", index=False)
    df_class.to_csv(outputPath+"class.csv", sep=";", index=False)

    df_assoc.to_csv(outputPath+"census.csv", sep=";", index=False)