Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A87B1E0C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwh-0003dF-4m; Thu, 28 Sep 2023 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwV-0003Vv-WB
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwN-0008Ev-Jy
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=th5lF0fRy6siYS5ymE+c23iKQTUNVusJVFX4L1/R2LA=;
 b=IO1If0rbPVEOdtO9cO1n+ti1wCP3LYMDFSbshjbD0fJ+179ZrHPBuP2bRHi6NiS7KvBpXU
 wDFN9vzG/FZJhZnT4q5zqu5WuQIOC9YCEfoXryB9TgAmA7FStEQmAd7fSPJbgkaWxKnxee
 U2U968qXkTXOeMvvSvOXY1OGyQPz2AY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-C6uWXKZBPE2rV64fhRhMeA-1; Thu, 28 Sep 2023 09:20:22 -0400
X-MC-Unique: C6uWXKZBPE2rV64fhRhMeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BE69101A53B;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD39E492B05;
 Thu, 28 Sep 2023 13:20:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D496B21E690F; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 07/53] migration/rdma: Clean up two more harmless signed
 vs. unsigned issues
Date: Thu, 28 Sep 2023 15:19:33 +0200
Message-ID: <20230928132019.2544702-8-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qemu_rdma_exchange_get_response() compares int parameter @expecting
with uint32_t head->type.  Actual arguments are non-negative
enumeration constants, RDMAControlHeader uint32_t member type, or
qemu_rdma_exchange_recv() int parameter expecting.  Actual arguments
for the latter are non-negative enumeration constants.  Change both
parameters to uint32_t.

In qio_channel_rdma_readv(), loop control variable @i is ssize_t, and
counts from 0 up to @niov, which is size_t.  Change @i to size_t.

While there, make qio_channel_rdma_readv() and
qio_channel_rdma_writev() more consistent: change the former's @done
to ssize_t, and delete the latter's useless initialization of @len.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 5f423f66f0..faca0ed998 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1801,7 +1801,7 @@ static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx)
  * Block and wait for a RECV control channel message to arrive.
  */
 static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
-                RDMAControlHeader *head, int expecting, int idx)
+                RDMAControlHeader *head, uint32_t expecting, int idx)
 {
     uint32_t byte_len;
     int ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RECV_CONTROL + idx,
@@ -1959,7 +1959,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
  * control-channel message.
  */
 static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
-                                int expecting)
+                                   uint32_t expecting)
 {
     RDMAControlHeader ready = {
                                 .len = 0,
@@ -2765,8 +2765,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     RDMAContext *rdma;
     int ret;
     ssize_t done = 0;
-    size_t i;
-    size_t len = 0;
+    size_t i, len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
@@ -2851,8 +2850,8 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     RDMAContext *rdma;
     RDMAControlHeader head;
     int ret = 0;
-    ssize_t i;
-    size_t done = 0, len;
+    ssize_t done = 0;
+    size_t i, len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmain);
-- 
2.41.0


