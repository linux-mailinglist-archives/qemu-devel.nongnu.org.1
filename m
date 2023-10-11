Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 092857C4F01
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQU-0007Gp-HN; Wed, 11 Oct 2023 05:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQT-0007GC-2A
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQR-0004uz-JR
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvLagL/oDhBiMoSmeIabLCdT0Q9b08KUMXOZx9Tf0nw=;
 b=C14rEI4j04hESLdV3sG33DR9VkDuPcfAQlhMWaVRdxVZ5kQQG0gJ1lIhwpLkSkx6D8fj3Z
 vgZn3bEzDtWIJlLVAbvJ2TwYd7N8lJ6su/vLd2Bi8e866ZfOGD8VugN6vBsJQgBGF+Rd6H
 /TpTb9Rd5zB9NAFew9vD0kxoegWKh2Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-he9qPc7fMS6wbBYmPv0G9Q-1; Wed, 11 Oct 2023 05:22:39 -0400
X-MC-Unique: he9qPc7fMS6wbBYmPv0G9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DA6E1C02167;
 Wed, 11 Oct 2023 09:22:39 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1BB1C060AE;
 Wed, 11 Oct 2023 09:22:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 16/65] migration/rdma: Fix qemu_rdma_accept() to return failure
 on errors
Date: Wed, 11 Oct 2023 11:21:14 +0200
Message-ID: <20231011092203.1266-17-quintela@redhat.com>
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

qemu_rdma_accept() returns 0 in some cases even when it didn't
complete its job due to errors.  Impact is not obvious.  I figure the
caller will soon fail again with a misleading error message.

Fix it to return -1 on any failure.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-10-armbru@redhat.com>
---
 migration/rdma.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 1159f990af..8fd1b314b5 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3360,6 +3360,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     if (cm_event->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
         rdma_ack_cm_event(cm_event);
+        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3372,6 +3373,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
+            ret = -1;
             goto err_rdma_dest_wait;
         }
 
@@ -3383,10 +3385,11 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     network_to_caps(&cap);
 
     if (cap.version < 1 || cap.version > RDMA_CONTROL_VERSION_CURRENT) {
-            error_report("Unknown source RDMA version: %d, bailing...",
-                            cap.version);
-            rdma_ack_cm_event(cm_event);
-            goto err_rdma_dest_wait;
+        error_report("Unknown source RDMA version: %d, bailing...",
+                     cap.version);
+        rdma_ack_cm_event(cm_event);
+        ret = -1;
+        goto err_rdma_dest_wait;
     }
 
     /*
@@ -3416,9 +3419,10 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     if (!rdma->verbs) {
         rdma->verbs = verbs;
     } else if (rdma->verbs != verbs) {
-            error_report("ibv context not matching %p, %p!", rdma->verbs,
-                         verbs);
-            goto err_rdma_dest_wait;
+        error_report("ibv context not matching %p, %p!", rdma->verbs,
+                     verbs);
+        ret = -1;
+        goto err_rdma_dest_wait;
     }
 
     qemu_rdma_dump_id("dest_init", verbs);
@@ -3475,6 +3479,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
         error_report("rdma_accept not event established");
         rdma_ack_cm_event(cm_event);
+        ret = -1;
         goto err_rdma_dest_wait;
     }
 
-- 
2.41.0


