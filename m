Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7017716CB4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Gv-0001UN-1a; Tue, 30 May 2023 14:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44Gl-00013M-1n
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44Gi-0004Yb-Au
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685472027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9BRH7ZrNSb4xru9M4VnOUEfVp5yJ3S6DwScW9Xb9j8g=;
 b=IAKNBE0uY3bC4o/JbiveJ0tMpY1cgwihISQNuuZIbgd8QHc2yeKNVWlziGSddXS/yb5dhF
 l3Cql50CFXssTfIxrhoX9zTMcfeFEzBlVmDQJEghAononBs2zIFKOC2IkWRq4vc/PGcwW1
 ozMgTcokoI0S6/9IJ0oCMbgRveUeq1k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-iA0BjsGVOA6YzPcs1ekwNw-1; Tue, 30 May 2023 14:40:16 -0400
X-MC-Unique: iA0BjsGVOA6YzPcs1ekwNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55FC21C068C6;
 Tue, 30 May 2023 18:40:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2D07C154D2;
 Tue, 30 May 2023 18:40:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 16/20] migration/rdma: Split qemu_fopen_rdma() into
 input/output functions
Date: Tue, 30 May 2023 20:39:37 +0200
Message-Id: <20230530183941.7223-17-quintela@redhat.com>
In-Reply-To: <20230530183941.7223-1-quintela@redhat.com>
References: <20230530183941.7223-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

This is how everything else in QEMUFile is structured.
As a bonus they are three less lines of code.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 3ef35fc635..606837bd45 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4046,25 +4046,22 @@ static void qio_channel_rdma_register_types(void)
 
 type_init(qio_channel_rdma_register_types);
 
-static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
+static QEMUFile *rdma_new_input(RDMAContext *rdma)
 {
-    QIOChannelRDMA *rioc;
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
+    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
+    rioc->rdmain = rdma;
+    rioc->rdmaout = rdma->return_path;
 
-    if (qemu_file_mode_is_not_valid(mode)) {
-        return NULL;
-    }
+    return rioc->file;
+}
 
-    rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
-
-    if (mode[0] == 'w') {
-        rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
-        rioc->rdmaout = rdma;
-        rioc->rdmain = rdma->return_path;
-    } else {
-        rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
-        rioc->rdmain = rdma;
-        rioc->rdmaout = rdma->return_path;
-    }
+static QEMUFile *rdma_new_output(RDMAContext *rdma)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
+    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
+    rioc->rdmaout = rdma;
+    rioc->rdmain = rdma->return_path;
 
     return rioc->file;
 }
@@ -4090,9 +4087,9 @@ static void rdma_accept_incoming_migration(void *opaque)
         return;
     }
 
-    f = qemu_fopen_rdma(rdma, "rb");
+    f = rdma_new_input(rdma);
     if (f == NULL) {
-        fprintf(stderr, "RDMA ERROR: could not qemu_fopen_rdma\n");
+        fprintf(stderr, "RDMA ERROR: could not open RDMA for input\n");
         qemu_rdma_cleanup(rdma);
         return;
     }
@@ -4217,7 +4214,7 @@ void rdma_start_outgoing_migration(void *opaque,
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
     s->rdma_migration = true;
-    s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
+    s->to_dst_file = rdma_new_output(rdma);
     migrate_fd_connect(s, NULL);
     return;
 return_path_err:
-- 
2.40.1


