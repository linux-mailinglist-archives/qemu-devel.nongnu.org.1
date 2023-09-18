Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A57A4B44
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSV-00035U-BU; Mon, 18 Sep 2023 10:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSO-00030W-8y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002aU-RH
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gKm2qrf+GH5KZE38eTbjf2ovKGdCdKcFO05pLacnCo=;
 b=FChVYoQNFjbbAZMMoyV0i8fY132BqWVvk/s6IobG7iRJky7P4EryMSDbOlwjglVuwrHD/c
 Zoq8c3exVQAFXgtJLuPdGutu4jF246HuVntSONqr00dxJHBkhqjt81NmqD9pMVvfPBhc3/
 igVP6TbvDKcTaoNgdMNAp9i+mqNVGYI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-u_0F94rWOrW6LcneloqyIg-1; Mon, 18 Sep 2023 10:42:09 -0400
X-MC-Unique: u_0F94rWOrW6LcneloqyIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 244731C05144
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01F6B20268CC
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 004DC21E690F; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 08/52] migration/rdma: Fix qemu_rdma_accept() to return
 failure on errors
Date: Mon, 18 Sep 2023 16:41:22 +0200
Message-ID: <20230918144206.560120-9-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

qemu_rdma_accept() returns 0 in some cases even when it didn't
complete its job due to errors.  Impact is not obvious.  I figure the
caller will soon fail again with a misleading error message.

Fix it to return -1 on any failure.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 177d73a2ba..4339fcc7b2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3352,6 +3352,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     if (cm_event->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
         rdma_ack_cm_event(cm_event);
+        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3364,6 +3365,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
+            ret = -1;
             goto err_rdma_dest_wait;
         }
 
@@ -3375,10 +3377,11 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -3408,9 +3411,10 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -3467,6 +3471,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
         error_report("rdma_accept not event established");
         rdma_ack_cm_event(cm_event);
+        ret = -1;
         goto err_rdma_dest_wait;
     }
 
-- 
2.41.0


