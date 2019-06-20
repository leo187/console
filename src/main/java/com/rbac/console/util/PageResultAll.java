package com.rbac.console.util;

import java.io.Serializable;
import java.util.List;

/**
 * 封装的分页POJO类
 */
public class PageResultAll<E> implements Serializable {

    private static final long serialVersionUID = 7522755991538233964L;
    private int pageNum;
    private int pageSize;
    private int startRow;
    private int endRow;
    private long total;
    private int pages;
    private String orderBy;
    private List<E> result;

    /**
     * Page的构造函数
     * @param pageNum
     * @param pageSize
     * @author 高波
     */
    public PageResultAll(int pageNum, int pageSize, String orderBy) {
        this.orderBy = orderBy;
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.startRow = pageNum > 0 ? (pageNum - 1) * pageSize : 0;
        this.endRow = pageNum * pageSize;
    }

    public int getPageNum() {
        return pageNum;
    }
    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public int getStartRow() {
        return startRow;
    }
    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }
    public int getEndRow() {
        return endRow;
    }
    public void setEndRow(int endRow) {
        this.endRow = endRow;
    }
    public long getTotal() {
        return total;
    }
    public void setTotal(long total) {
        this.total = total;
        if(pageSize != 0){
            if(total%pageSize==0){
                this.pages=(int) (total/pageSize);
            }else{
                this.pages=(int) (total/pageSize)+1;
            }
        }
    }
    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public int getPages() {
        return pages;
    }
    public void setPages(int pages) {
        this.pages = pages;
    }
    public List<E> getResult() {
        return result;
    }
    public void setResult(List<E> result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return "Page{" +
                "pageNum=" + pageNum +
                ", pageSize=" + pageSize +
                ", startRow=" + startRow +
                ", endRow=" + endRow +
                ", total=" + total +
                ", pages=" + pages +
                '}';
    }
}
