package com.jhs.exam.exam2.repository;

import java.util.List;

import com.jhs.exam.exam2.container.ContainerComponent;
import com.jhs.exam.exam2.dto.Article;
import com.jhs.mysqliutil.MysqlUtil;
import com.jhs.mysqliutil.SecSql;

public class ArticleRepository implements ContainerComponent {
	public void init() {
		
	}
	
	public int write(int boardId, int memberId, String title, String body) {
		SecSql sql = new SecSql();
		sql.append("INSERT INTO article");
		sql.append("SET regDate = NOW()");
		sql.append(", updateDate = NOW()");
		sql.append(", boardId = ?", boardId);
		sql.append(", memberId = ?", memberId);
		sql.append(", title = ?", title);
		sql.append(", `body` = ?", body);

		int id = MysqlUtil.insert(sql);

		return id;
	}

	public List<Article> getForPrintArticles(int boardId, String searchKeywordTypeCode, String searchKeyword,
			int limitFrom, int limitTake) {
		SecSql sql = new SecSql();
		sql.append("SELECT A.*");
		sql.append(", IFNULL(M.nickname, '삭제된회원') AS extra__writerName");
		sql.append("FROM article AS A");
		sql.append("LEFT JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("WHERE 1");

		if (searchKeyword != null && searchKeyword.length() > 0) {
			switch (searchKeywordTypeCode) {
			case "title,body":
				sql.append("AND (");
				sql.append("A.title LIKE CONCAT('%', ?, '%')", searchKeyword);
				sql.append("OR");
				sql.append("A.body LIKE CONCAT('%', ?, '%')", searchKeyword);
				sql.append(")");
				break;
			case "body":
				sql.append("AND A.body LIKE CONCAT('%', ?, '%')", searchKeyword);
				break;
			case "title":
			default:
				sql.append("AND A.title LIKE CONCAT('%', ?, '%')", searchKeyword);
				break;
			}
		}

		if (boardId != 0) {
			sql.append("AND A.boardId = ?", boardId);
		}

		sql.append("ORDER BY A.id DESC");
		sql.append("LIMIT ?, ?", limitFrom, limitTake);

		return MysqlUtil.selectRows(sql, Article.class);
	}

	public Article getForPrintArticleById(int id) {
		SecSql sql = new SecSql();
		sql.append("SELECT A.*");
		sql.append("FROM article AS A");
		sql.append("WHERE A.id = ?", id);

		return MysqlUtil.selectRow(sql, Article.class);
	}

	public int delete(int id) {
		SecSql sql = new SecSql();
		sql.append("DELETE FROM article");
		sql.append("WHERE id = ?", id);

		return MysqlUtil.delete(sql);
	}

	public int modify(int id, String title, String body) {
		SecSql sql = new SecSql();
		sql.append("UPDATE article");
		sql.append("SET updateDate = NOW()");

		if (title != null) {
			sql.append(", title = ?", title);
		}

		if (body != null) {
			sql.append(", body = ?", body);
		}

		sql.append("WHERE id = ?", id);

		return MysqlUtil.update(sql);
	}

	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		SecSql sql = new SecSql();
		sql.append("SELECT COUNT(*) AS cnt");
		sql.append("FROM article AS A");
		sql.append("WHERE 1");

		if (searchKeyword != null && searchKeyword.length() > 0) {
			switch (searchKeywordTypeCode) {
			case "title,body":
				sql.append("AND (");
				sql.append("A.title LIKE CONCAT('%', ?, '%')", searchKeyword);
				sql.append("OR");
				sql.append("A.body LIKE CONCAT('%', ?, '%')", searchKeyword);
				sql.append(")");
				break;
			case "body":
				sql.append("AND A.body LIKE CONCAT('%', ?, '%')", searchKeyword);
				break;
			case "title":
			default:
				sql.append("AND A.title LIKE CONCAT('%', ?, '%')", searchKeyword);
				break;
			}
		}

		if (boardId != 0) {
			sql.append("AND A.boardId = ?", boardId);
		}

		return MysqlUtil.selectRowIntValue(sql);
	}
}
