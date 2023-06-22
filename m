Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1BC739574
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9rQ-00028A-IB; Wed, 21 Jun 2023 22:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qr-0000GA-2x
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qn-0005Fj-UV
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTz/G5BiFE58fQISpbQndXC0ldXtbuPPgD/w277DDSU=;
 b=iKiJwPUQMGFcWpU+vMHZjNm/KsVJAhJcvxnFL5quo/5elFrl6JyzpqEixPtsGdPhNrcQbp
 wgs4UScK7xiLxzAj5IHSyAW7YtP9SHBLvfnm+6HUF2T7bUgzILVK8ozvGHDrgWwQXiMoi9
 n/THTxo354IFp/zQ8vX+LehNWdrlD1M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-FV47GfIbMFav2-_C0merOg-1; Wed, 21 Jun 2023 22:15:04 -0400
X-MC-Unique: FV47GfIbMFav2-_C0merOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5256229AA3BA;
 Thu, 22 Jun 2023 02:15:04 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B5AA112132C;
 Thu, 22 Jun 2023 02:15:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 30/30] migration/rdma: Split qemu_fopen_rdma() into
 input/output functions
Date: Thu, 22 Jun 2023 04:13:20 +0200
Message-Id: <20230622021320.66124-31-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230530183941.7223-17-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h |  1 -
 migration/qemu-file.c | 12 ------------
 migration/rdma.c      | 39 +++++++++++++++++++--------------------
 3 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 8b8b7d27fe..47015f5201 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -102,7 +102,6 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f);
  */
 void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
                            bool may_free);
-bool qemu_file_mode_is_not_valid(const char *mode);
 
 #include "migration/qemu-file-types.h"
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d30bf3c377..19c33c9985 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -100,18 +100,6 @@ int qemu_file_shutdown(QEMUFile *f)
     return 0;
 }
 
-bool qemu_file_mode_is_not_valid(const char *mode)
-{
-    if (mode == NULL ||
-        (mode[0] != 'r' && mode[0] != 'w') ||
-        mode[1] != 'b' || mode[2] != 0) {
-        fprintf(stderr, "qemu_fopen: Argument validity check failed\n");
-        return true;
-    }
-
-    return false;
-}
-
 static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 {
     QEMUFile *f;
diff --git a/migration/rdma.c b/migration/rdma.c
index dd1c039e6c..ca430d319d 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4053,27 +4053,26 @@ static void qio_channel_rdma_register_types(void)
 
 type_init(qio_channel_rdma_register_types);
 
-static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
+static QEMUFile *rdma_new_input(RDMAContext *rdma)
 {
-    QIOChannelRDMA *rioc;
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
 
-    if (qemu_file_mode_is_not_valid(mode)) {
-        return NULL;
-    }
+    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
+    rioc->rdmain = rdma;
+    rioc->rdmaout = rdma->return_path;
+    qemu_file_set_hooks(rioc->file, &rdma_read_hooks);
 
-    rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
+    return rioc->file;
+}
 
-    if (mode[0] == 'w') {
-        rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
-        rioc->rdmaout = rdma;
-        rioc->rdmain = rdma->return_path;
-        qemu_file_set_hooks(rioc->file, &rdma_write_hooks);
-    } else {
-        rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
-        rioc->rdmain = rdma;
-        rioc->rdmaout = rdma->return_path;
-        qemu_file_set_hooks(rioc->file, &rdma_read_hooks);
-    }
+static QEMUFile *rdma_new_output(RDMAContext *rdma)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
+
+    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
+    rioc->rdmaout = rdma;
+    rioc->rdmain = rdma->return_path;
+    qemu_file_set_hooks(rioc->file, &rdma_write_hooks);
 
     return rioc->file;
 }
@@ -4099,9 +4098,9 @@ static void rdma_accept_incoming_migration(void *opaque)
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
@@ -4224,7 +4223,7 @@ void rdma_start_outgoing_migration(void *opaque,
 
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
-    s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
+    s->to_dst_file = rdma_new_output(rdma);
     migrate_fd_connect(s, NULL);
     return;
 return_path_err:
-- 
2.40.1


