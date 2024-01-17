Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC21830204
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ21x-0008PC-H5; Wed, 17 Jan 2024 04:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ21v-0008P0-JJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ21t-0006Yz-RK
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705482972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMbVFPYQsHSfFzRUkbmyU6bwmA69o3lKHeITiDBmUpM=;
 b=CIQr4UApYPVIYFcb2/ArXkRuPLDiXELjKOkczi4gqvft+QGEQvZTl7SrvyvCZs/bDEDczH
 D+x+wItNEpwqbjSIeuuXvkLhjYxsipbsdGWPgpVFyZKy4RBQoyC8Sk5zuh7u5T9tG1ihU4
 +sO6BDlTNPXH2lJJLc5HRJfap77999g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-q8vuVMoWMai_ExTome83Dw-1; Wed, 17 Jan 2024 04:16:10 -0500
X-MC-Unique: q8vuVMoWMai_ExTome83Dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2818D82DFE6
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:16:10 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DE2E2166B32;
 Wed, 17 Jan 2024 09:16:05 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com
Subject: [PATCH 1/4] reset: qemu_register_reset_one()
Date: Wed, 17 Jan 2024 17:15:56 +0800
Message-ID: <20240117091559.144730-2-peterx@redhat.com>
In-Reply-To: <20240117091559.144730-1-peterx@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

Cleanup the code to use a single entrance on register reset hooks.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/reset.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/core/reset.c b/hw/core/reset.c
index d3263b613e..8cf60b2b09 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -39,23 +39,26 @@ typedef struct QEMUResetEntry {
 static QTAILQ_HEAD(, QEMUResetEntry) reset_handlers =
     QTAILQ_HEAD_INITIALIZER(reset_handlers);
 
-void qemu_register_reset(QEMUResetHandler *func, void *opaque)
+static void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
+                                    bool skip_snap)
 {
     QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
 
     re->func = func;
     re->opaque = opaque;
+    re->skip_on_snapshot_load = skip_snap;
     QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
 }
 
-void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
+void qemu_register_reset(QEMUResetHandler *func, void *opaque)
 {
-    QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
+    /* By default, do not skip during load of a snapshot */
+    qemu_register_reset_one(func, opaque, false);
+}
 
-    re->func = func;
-    re->opaque = opaque;
-    re->skip_on_snapshot_load = true;
-    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
+void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
+{
+    qemu_register_reset_one(func, opaque, true);
 }
 
 void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
-- 
2.43.0


