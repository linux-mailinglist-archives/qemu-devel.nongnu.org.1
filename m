Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0277B52E6
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:23:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHv2-0007Sx-QC; Mon, 02 Oct 2023 08:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHux-0007Pz-TQ
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHuw-0007dN-5i
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696249253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qb+zkZpQvU5Tk7Zq0C6WCPbkDPM5+cat98QhtHWM+zI=;
 b=Szdb+NrOACcRvFVA1FD3Ln3f0KDRP61q08Mh0/Lgdgzh6xUGKnkvwUTvWeRSeXp1VHetrD
 QnWYGpralUch1fBXcbcnZpJl8NPsWHw6zJwiNVBt6xQjZtADasLgSR2FavfSvLUk8fI/Jy
 29bK1axFKKaHuZ68FMs04dCzTlhzNVE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-ueEIq3G1Nfump2NSxYdVaA-1; Mon, 02 Oct 2023 08:20:50 -0400
X-MC-Unique: ueEIq3G1Nfump2NSxYdVaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4F4829AB400;
 Mon,  2 Oct 2023 12:20:49 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16C772156701;
 Mon,  2 Oct 2023 12:20:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 13/13] migration/rdma: Simplify the function that saves a page
Date: Mon,  2 Oct 2023 14:20:21 +0200
Message-ID: <20231002122021.231959-14-quintela@redhat.com>
In-Reply-To: <20231002122021.231959-1-quintela@redhat.com>
References: <20231002122021.231959-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I know, I know, the interface is as bad as it gets.  I think that now
it is a bit clearer, but this needs to be done some other way.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230515195709.63843-16-quintela@redhat.com>
---
 migration/qemu-file.h | 14 ++++++--------
 migration/qemu-file.c | 12 ++++++------
 migration/ram.c       | 10 +++-------
 migration/rdma.c      | 19 +++----------------
 4 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 57b00c8562..03e718c264 100644
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
@@ -142,9 +141,8 @@ void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
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
index 5c43fa34e7..5e8207dae4 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -322,14 +322,14 @@ void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data)
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
index c6238f7a8b..99cff591a3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1186,23 +1186,19 @@ static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
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
index 9007261b5c..5748c9045b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3240,13 +3240,12 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
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
@@ -3278,18 +3277,6 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
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
2.41.0


