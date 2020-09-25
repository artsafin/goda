package goda

import "fmt"

func (lrp ListRowsParams) WithQuery(column, value string) ListRowsParams {
	query := fmt.Sprintf("\"%s\":\"%s\"", column, value)
	return ListRowsParams{
		Query:          &query,
		SortBy:         lrp.SortBy,
		UseColumnNames: lrp.UseColumnNames,
		ValueFormat:    lrp.ValueFormat,
		VisibleOnly:    lrp.VisibleOnly,
		Limit:          lrp.Limit,
		PageToken:      lrp.PageToken,
	}
}

func (lrp ListRowsParams) WithSortBy(sortBy RowsSortBy) ListRowsParams {
	return ListRowsParams{
		Query:          lrp.Query,
		SortBy:         &sortBy,
		UseColumnNames: lrp.UseColumnNames,
		ValueFormat:    lrp.ValueFormat,
		VisibleOnly:    lrp.VisibleOnly,
		Limit:          lrp.Limit,
		PageToken:      lrp.PageToken,
	}
}
