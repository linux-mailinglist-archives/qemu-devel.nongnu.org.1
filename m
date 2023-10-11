Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB87C4E8B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVR5-0007ne-Bg; Wed, 11 Oct 2023 05:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQs-0007Km-CJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQq-0004z0-1c
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UUqrPxurB/yFGVCPLxz5loYTOvoChypsemoRrX4mPc=;
 b=hOCCPkDkYcbKuZ2bLGjfsVWf6LVJNiHhZ4LAlLs39qCaNqhREdtOTwY/h2Q7nbxSaCmEgD
 IUg3gIF5h2Etik9Inn41DTVp78PSIHtMo9q+PRIdME4g2LxCxE71Vw4g+PPpcse3VHKHP3
 illBadQP052VBA3jIfLOBWoSP6UEDL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-1rUJLK06P3GPnwu-SdK-tw-1; Wed, 11 Oct 2023 05:22:55 -0400
X-MC-Unique: 1rUJLK06P3GPnwu-SdK-tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 410F2811E7D;
 Wed, 11 Oct 2023 09:22:55 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80EDE1C060AE;
 Wed, 11 Oct 2023 09:22:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 24/65] migration/rdma: Ditch useless numeric error codes in
 error messages
Date: Wed, 11 Oct 2023 11:21:22 +0200
Message-ID: <20231011092203.1266-25-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-18-armbru@redhat.com>
---
 migration/rdma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 35b0129ae6..c4197c6437 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1476,7 +1476,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
     }
 
     if (ret < 0) {
-        error_report("ibv_poll_cq return %d", ret);
+        error_report("ibv_poll_cq failed");
         return ret;
     }
 
@@ -2226,7 +2226,7 @@ retry:
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
             error_report("rdma migration: failed to make "
-                         "room in full send queue! %d", ret);
+                         "room in full send queue!");
             return ret;
         }
 
@@ -2819,7 +2819,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     ret = qemu_rdma_write_flush(rdma);
     if (ret < 0) {
         rdma->error_state = ret;
-        error_setg(errp, "qemu_rdma_write_flush returned %d", ret);
+        error_setg(errp, "qemu_rdma_write_flush failed");
         return -1;
     }
 
@@ -2839,7 +2839,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
 
             if (ret < 0) {
                 rdma->error_state = ret;
-                error_setg(errp, "qemu_rdma_exchange_send returned %d", ret);
+                error_setg(errp, "qemu_rdma_exchange_send failed");
                 return -1;
             }
 
@@ -2929,7 +2929,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
 
         if (ret < 0) {
             rdma->error_state = ret;
-            error_setg(errp, "qemu_rdma_exchange_recv returned %d", ret);
+            error_setg(errp, "qemu_rdma_exchange_recv failed");
             return -1;
         }
 
@@ -3271,7 +3271,7 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
      */
     ret = qemu_rdma_write(rdma, block_offset, offset, size);
     if (ret < 0) {
-        error_report("rdma migration: write error! %d", ret);
+        error_report("rdma migration: write error");
         goto err;
     }
 
@@ -3287,7 +3287,7 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
         ret = qemu_rdma_poll(rdma, rdma->recv_cq, &wr_id_in, NULL);
 
         if (ret < 0) {
-            error_report("rdma migration: polling error! %d", ret);
+            error_report("rdma migration: polling error");
             goto err;
         }
 
@@ -3303,7 +3303,7 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
         ret = qemu_rdma_poll(rdma, rdma->send_cq, &wr_id_in, NULL);
 
         if (ret < 0) {
-            error_report("rdma migration: polling error! %d", ret);
+            error_report("rdma migration: polling error");
             goto err;
         }
 
@@ -3478,13 +3478,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
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


