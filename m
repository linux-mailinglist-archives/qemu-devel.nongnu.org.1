Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB83715E27
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xwG-0005FA-2k; Tue, 30 May 2023 07:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwD-00059T-Mt
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwC-0000B5-2t
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnyAA9s9nlbOP4s4QiV5AOGRl4whSPxnpnIDwFHEs9I=;
 b=hPqWuAwOQ0cPKmPk3D7LkuN2H6wt5RMfDGjzfnNy5Jx5KuRRFAN3wwTJnhzokmrLPi4evY
 eV4Ig87UCvqAcPBmz+PycZfVmBhPeQz61/flhFzwB6eeVUfaHHg5ivHgYL+dUUj+PIjuKK
 O7Sot3h04UipXIYqqCk+uoMuEu7TqMo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-VnvJUhoRNR-h7svxpJDn1Q-1; Tue, 30 May 2023 07:54:48 -0400
X-MC-Unique: VnvJUhoRNR-h7svxpJDn1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B85762A5957B
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:54:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A598840C6EC4;
 Tue, 30 May 2023 11:54:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 11/21] migration/rdma: Simplify the function that saves a page
Date: Tue, 30 May 2023 13:54:19 +0200
Message-Id: <20230530115429.1998-12-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index da0dfd7072..eab0cb2710 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1144,23 +1144,19 @@ static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
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


