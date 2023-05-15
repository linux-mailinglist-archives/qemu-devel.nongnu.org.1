Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB3703E05
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeLF-00025B-7J; Mon, 15 May 2023 15:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKz-0001ci-Jv
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKx-0005ZV-U6
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0xWEIKpsTavsJwcCEf3C5p/wD4gGvVFo6Epfs0gtWE=;
 b=iUPgC9lSQQah4tlzVMr6wns+LwTCiNM7KSxS4Y3O6Z7BhySQTcTFEIURjuEwgb+/8yaL2Y
 teBp8lH/brZhPH6SIqwkVJluDf7GeSy/zqNG8c7G39mlblprpH1p9YVaF2CAyyVMQ+xi+w
 RT2E9joemnS6kz4BkByN2s4DOGF/wTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-5GcHYF1xN-mPvOKZ2K3nSg-1; Mon, 15 May 2023 15:58:24 -0400
X-MC-Unique: 5GcHYF1xN-mPvOKZ2K3nSg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 142A5868900;
 Mon, 15 May 2023 19:58:23 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE2D492B02;
 Mon, 15 May 2023 19:58:19 +0000 (UTC)
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
Subject: [PATCH v2 15/16] migration/rdma: Simplify the function that saves a
 page
Date: Mon, 15 May 2023 21:57:08 +0200
Message-Id: <20230515195709.63843-16-quintela@redhat.com>
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

When we sent a page through QEMUFile hooks (RDMA) there are three
posiblities:
- We are not using RDMA. return RAM_SAVE_CONTROL_DELAYED and
  control_save_page() returns false to let anything else to proceed.
- There is one error but we are using RDMA.  Then we return a negative
  value, control_save_page() needs to return true.
- Everything goes well and RDMA start the sent of the page
  asynchronously.  It returns RAM_SAVE_CONTROL_DELAYED and we need to
  return 1 for ram_save_page_legacy.

Clear?

I know, I know, the interfaz is as bad as it gets.  I think that now
it is a bit clearer, but this needs to be done some other way.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 14 ++++++--------
 migration/qemu-file.c | 12 ++++++------
 migration/ram.c       | 10 +++-------
 migration/rdma.c      | 19 +++----------------
 4 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 37f42315c7..ed77996201 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -49,11 +49,10 @@ typedef int (QEMURamHookFunc)(QEMUFile *f, uint64_t flags, void *data);
  * This function allows override of where the RAM page
  * is saved (such as RDMA, for example.)
  */
-typedef size_t (QEMURamSaveFunc)(QEMUFile *f,
-                                 ram_addr_t block_offset,
-                                 ram_addr_t offset,
-                                 size_t size,
-                                 uint64_t *bytes_sent);
+typedef int (QEMURamSaveFunc)(QEMUFile *f,
+                              ram_addr_t block_offset,
+                              ram_addr_t offset,
+                              size_t size);
 
 typedef struct QEMUFileHooks {
     QEMURamHookFunc *before_ram_iterate;
@@ -146,9 +145,8 @@ void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
 #define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
-size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
-                             ram_addr_t offset, size_t size,
-                             uint64_t *bytes_sent);
+int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                          ram_addr_t offset, size_t size);
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 72e130631d..32ef5e9651 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -336,14 +336,14 @@ void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data)
     }
 }
 
-size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
-                             ram_addr_t offset, size_t size,
-                             uint64_t *bytes_sent)
+int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                          ram_addr_t offset, size_t size)
 {
     if (f->hooks && f->hooks->save_page) {
-        int ret = f->hooks->save_page(f, block_offset,
-                                      offset, size, bytes_sent);
-
+        int ret = f->hooks->save_page(f, block_offset, offset, size);
+        /*
+         * RAM_SAVE_CONTROL_* are negative values
+         */
         if (ret != RAM_SAVE_CONTROL_DELAYED &&
             ret != RAM_SAVE_CONTROL_NOT_SUPP) {
             if (ret < 0) {
diff --git a/migration/ram.c b/migration/ram.c
index 2d3927a15f..f9fcbb3bb8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1173,23 +1173,19 @@ static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
 static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
                               ram_addr_t offset, int *pages)
 {
-    uint64_t bytes_xmit = 0;
     int ret;
 
-    *pages = -1;
     ret = ram_control_save_page(pss->pss_channel, block->offset, offset,
-                                TARGET_PAGE_SIZE, &bytes_xmit);
+                                TARGET_PAGE_SIZE);
     if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
         return false;
     }
 
-    if (bytes_xmit) {
-        *pages = 1;
-    }
-
     if (ret == RAM_SAVE_CONTROL_DELAYED) {
+        *pages = 1;
         return true;
     }
+    *pages = ret;
     return true;
 }
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 416dec00a2..12d3c23fdc 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3239,13 +3239,12 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
  *
  *    @size : Number of bytes to transfer
  *
- *    @bytes_sent : User-specificed pointer to indicate how many bytes were
+ *    @pages_sent : User-specificed pointer to indicate how many pages were
  *                  sent. Usually, this will not be more than a few bytes of
  *                  the protocol because most transfers are sent asynchronously.
  */
-static size_t qemu_rdma_save_page(QEMUFile *f,
-                                  ram_addr_t block_offset, ram_addr_t offset,
-                                  size_t size, uint64_t *bytes_sent)
+static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
+                               ram_addr_t offset, size_t size)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
@@ -3277,18 +3276,6 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
         goto err;
     }
 
-    /*
-     * We always return 1 bytes because the RDMA
-     * protocol is completely asynchronous. We do not yet know
-     * whether an  identified chunk is zero or not because we're
-     * waiting for other pages to potentially be merged with
-     * the current chunk. So, we have to call qemu_update_position()
-     * later on when the actual write occurs.
-     */
-    if (bytes_sent) {
-        *bytes_sent = 1;
-    }
-
     /*
      * Drain the Completion Queue if possible, but do not block,
      * just poll.
-- 
2.40.1


