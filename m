Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446257C4EEC
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQR-0007Fi-Im; Wed, 11 Oct 2023 05:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQQ-0007FE-2L
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQN-0004uC-G9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bo7QwZ0MKk+k0ttCNzlUByG595hIdsxJFbTYd05gw1o=;
 b=Arzr7x1WWUSWRRg24czmf29jwylfZ/4OIRSRbElhN1lcCGMACRCOtJWuskkHV3JR1ccR65
 kWk2oAmpuZXAXIvGmhHxGDB94jWDAoLVxM0pDdDheoLVm/jLe04SEE0y4HF2HgHLnrZHBM
 Fik4a1YgH7SqgrdRNbJkpFgP3+rA9qA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-VgsCUk1ANfa7G6_x1cIjtg-1; Wed, 11 Oct 2023 05:22:35 -0400
X-MC-Unique: VgsCUk1ANfa7G6_x1cIjtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DC19858F1C;
 Wed, 11 Oct 2023 09:22:35 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 841911C060AE;
 Wed, 11 Oct 2023 09:22:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 14/65] migration/rdma: Clean up two more harmless signed vs.
 unsigned issues
Date: Wed, 11 Oct 2023 11:21:12 +0200
Message-ID: <20231011092203.1266-15-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-8-armbru@redhat.com>
---
 migration/rdma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ff8e475f59..1aac50b0de 100644
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
@@ -1961,7 +1961,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
  * control-channel message.
  */
 static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
-                                int expecting)
+                                   uint32_t expecting)
 {
     RDMAControlHeader ready = {
                                 .len = 0,
@@ -2784,8 +2784,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     RDMAContext *rdma;
     int ret;
     ssize_t done = 0;
-    size_t i;
-    size_t len = 0;
+    size_t i, len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
@@ -2870,8 +2869,8 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
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


