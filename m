Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9596703E08
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:00:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeLF-00028T-G4; Mon, 15 May 2023 15:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKw-0001Ql-6c
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKu-0005YH-Nr
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wpd/wbmeDwX8T87oWYgGSnRA9O+pyRhF35RG1ynYdxk=;
 b=NTobFA7Pe0qu16vqRXd0lqZ30g/qSJV1yxwsRPqaXsM7zT5fMG4AIfpAZCCDPzbzcfRRq4
 uTD3Mgqh2axmmigt2U9nSU5BS60QN95/9DQ2IV9J1DvrrKKUd9QwSZo4OpIyszDg4ymawC
 C6QODyV+kqj2AH1zkCoNYPEECpWLpgs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-e0FTZLZdMTyp9czNajJEMw-1; Mon, 15 May 2023 15:58:19 -0400
X-MC-Unique: e0FTZLZdMTyp9czNajJEMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E479B3C0CF0A;
 Mon, 15 May 2023 19:58:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25087492B00;
 Mon, 15 May 2023 19:58:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 14/16] migration: Remove unused qemu_file_credit_transfer()
Date: Mon, 15 May 2023 21:57:07 +0200
Message-Id: <20230515195709.63843-15-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

After this change, nothing abuses QEMUFile to account for data
transferrefd during migration.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 8 --------
 migration/qemu-file.c | 5 -----
 2 files changed, 13 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index e649718492..37f42315c7 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -122,14 +122,6 @@ bool qemu_file_buffer_empty(QEMUFile *file);
  */
 int coroutine_mixed_fn qemu_peek_byte(QEMUFile *f, int offset);
 void qemu_file_skip(QEMUFile *f, int size);
-/*
- * qemu_file_credit_transfer:
- *
- * Report on a number of bytes that have been transferred
- * out of band from the main file object I/O methods. This
- * accounting information tracks the total migration traffic.
- */
-void qemu_file_credit_transfer(QEMUFile *f, size_t size);
 int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 23a21e2331..72e130631d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -411,11 +411,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     return len;
 }
 
-void qemu_file_credit_transfer(QEMUFile *f, size_t size)
-{
-    f->total_transferred += size;
-}
-
 /** Closes the file
  *
  * Returns negative error value if any error happened on previous operations or
-- 
2.40.1


