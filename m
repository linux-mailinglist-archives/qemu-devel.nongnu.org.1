Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1F7B1E24
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwt-0003k1-P9; Thu, 28 Sep 2023 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwZ-0003a4-Bk
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwO-0008Fh-JG
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xhv0iR70EFAMzLYG63rT+nkJ2YI2Zd9BNqX1D8yfljI=;
 b=JBu/dLhiqlCPlXRyj+Rr3CEeEDlBGkGufdETYzYAiqDSjBbFFysb4QkAhPiXxk6rIKvdRo
 3TsN1s8k5k87YFix2K7Pq8I4bQUcu2X3IpYgO7KlNhBnaD60mSyiC/skNFpgfQuGbwer1O
 B+P2zDZVpQ8Rmnaalpxw1vqoZaxjKA8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-BmD9HoStNEK7lYPqV1uT1g-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: BmD9HoStNEK7lYPqV1uT1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32CFD38145A9;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E970B215670B;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F273E21E691C; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 17/53] migration/rdma: Ditch useless numeric error codes in
 error messages
Date: Thu, 28 Sep 2023 15:19:43 +0200
Message-ID: <20230928132019.2544702-18-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Several error messages include numeric error codes returned by failed
functions:

* ibv_poll_cq() returns an unspecified negative value.  Useless.

* rdma_accept and rdma_get_cm_event() return -1.  Useless.

* qemu_rdma_poll() returns either -1 or an unspecified negative
  value.  Useless.

* qemu_rdma_block_for_wrid(), qemu_rdma_write_flush(),
  qemu_rdma_exchange_send(), qemu_rdma_exchange_recv(),
  qemu_rdma_write() return a negative value that may or may not be an
  errno value.  While reporting human-readable errno
  information (which a number is not) can be useful, reporting an
  error code that may or may not be an errno value is useless.

Drop these error codes from the error messages.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index bba8c99fa9..0d2d119e6a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1476,7 +1476,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
     }
 
     if (ret < 0) {
-        error_report("ibv_poll_cq return %d", ret);
+        error_report("ibv_poll_cq failed");
         return ret;
     }
 
@@ -2215,7 +2215,7 @@ retry:
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
             error_report("rdma migration: failed to make "
-                         "room in full send queue! %d", ret);
+                         "room in full send queue!");
             return ret;
         }
 
@@ -2800,7 +2800,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     ret = qemu_rdma_write_flush(f, rdma);
     if (ret < 0) {
         rdma->error_state = ret;
-        error_setg(errp, "qemu_rdma_write_flush returned %d", ret);
+        error_setg(errp, "qemu_rdma_write_flush failed");
         return -1;
     }
 
@@ -2820,7 +2820,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
 
             if (ret < 0) {
                 rdma->error_state = ret;
-                error_setg(errp, "qemu_rdma_exchange_send returned %d", ret);
+                error_setg(errp, "qemu_rdma_exchange_send failed");
                 return -1;
             }
 
@@ -2910,7 +2910,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
 
         if (ret < 0) {
             rdma->error_state = ret;
-            error_setg(errp, "qemu_rdma_exchange_recv returned %d", ret);
+            error_setg(errp, "qemu_rdma_exchange_recv failed");
             return -1;
         }
 
@@ -3253,7 +3253,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
      */
     ret = qemu_rdma_write(f, rdma, block_offset, offset, size);
     if (ret < 0) {
-        error_report("rdma migration: write error! %d", ret);
+        error_report("rdma migration: write error");
         goto err;
     }
 
@@ -3280,7 +3280,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
         uint64_t wr_id, wr_id_in;
         int ret = qemu_rdma_poll(rdma, rdma->recv_cq, &wr_id_in, NULL);
         if (ret < 0) {
-            error_report("rdma migration: polling error! %d", ret);
+            error_report("rdma migration: polling error");
             goto err;
         }
 
@@ -3295,7 +3295,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
         uint64_t wr_id, wr_id_in;
         int ret = qemu_rdma_poll(rdma, rdma->send_cq, &wr_id_in, NULL);
         if (ret < 0) {
-            error_report("rdma migration: polling error! %d", ret);
+            error_report("rdma migration: polling error");
             goto err;
         }
 
@@ -3470,13 +3470,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     ret = rdma_accept(rdma->cm_id, &conn_param);
     if (ret) {
-        error_report("rdma_accept returns %d", ret);
+        error_report("rdma_accept failed");
         goto err_rdma_dest_wait;
     }
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
     if (ret) {
-        error_report("rdma_accept get_cm_event failed %d", ret);
+        error_report("rdma_accept get_cm_event failed");
         goto err_rdma_dest_wait;
     }
 
-- 
2.41.0


