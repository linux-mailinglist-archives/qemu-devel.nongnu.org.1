Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AAC7C5E76
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfvw-0005Ho-4m; Wed, 11 Oct 2023 16:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvs-0005HJ-Io
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvp-00035F-VY
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRK5ENGEPeGTzcHGfH3u9nvv9hiBkyVzSRFra10gAkg=;
 b=RCnXCOr5VcM6PzcqK2mzOyYSrkgE26eNfqhflmGBaLTVmXYTKmyJtoGRCKp7FGHl+UoKIG
 hZUUeLCsDdxPUwCnLqIEOiEWJZrHWvXxjTZRqvfhGveA7CAcey3FiGh5bMsIo25AZf5EG3
 drLWYhaqG7q0Xj+6Zk0hY43MZ0wAMDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-VnciLxV0P-KlsMPZ5A-25A-1; Wed, 11 Oct 2023 16:35:41 -0400
X-MC-Unique: VnciLxV0P-KlsMPZ5A-25A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F27E811E88;
 Wed, 11 Oct 2023 20:35:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88223492B06;
 Wed, 11 Oct 2023 20:35:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 08/13] migration/rdma: Move rdma constants from qemu-file.h
 to rdma.h
Date: Wed, 11 Oct 2023 22:35:22 +0200
Message-ID: <20231011203527.9061-9-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-1-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 17 -----------------
 migration/rdma.h      | 16 ++++++++++++++++
 migration/ram.c       |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 0b22d8335f..a29c37b0d0 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -29,13 +29,6 @@
 #include "exec/cpu-common.h"
 #include "io/channel.h"
 
-/*
- * Constants used by ram_control_* hooks
- */
-#define RAM_CONTROL_SETUP     0
-#define RAM_CONTROL_ROUND     1
-#define RAM_CONTROL_FINISH    3
-
 QEMUFile *qemu_file_new_input(QIOChannel *ioc);
 QEMUFile *qemu_file_new_output(QIOChannel *ioc);
 int qemu_fclose(QEMUFile *f);
@@ -101,16 +94,6 @@ void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 
-/* Whenever this is found in the data stream, the flags
- * will be passed to ram_control_load_hook in the incoming-migration
- * side. This lets before_ram_iterate/after_ram_iterate add
- * transport-specific sections to the RAM migration data.
- */
-#define RAM_SAVE_FLAG_HOOK     0x80
-
-#define RAM_SAVE_CONTROL_NOT_SUPP -1000
-#define RAM_SAVE_CONTROL_DELAYED  -2000
-
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 
 #endif
diff --git a/migration/rdma.h b/migration/rdma.h
index 09a16c1e3c..1ff3718a76 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -24,6 +24,22 @@ void rdma_start_outgoing_migration(void *opaque, const char *host_port,
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp);
 
+/*
+ * Constants used by rdma return codes
+ */
+#define RAM_CONTROL_SETUP     0
+#define RAM_CONTROL_ROUND     1
+#define RAM_CONTROL_FINISH    3
+
+/*
+ * Whenever this is found in the data stream, the flags
+ * will be passed to rdma functions in the incoming-migration
+ * side.
+ */
+#define RAM_SAVE_FLAG_HOOK     0x80
+
+#define RAM_SAVE_CONTROL_NOT_SUPP -1000
+#define RAM_SAVE_CONTROL_DELAYED  -2000
 
 #ifdef CONFIG_RDMA
 int qemu_rdma_registration_handle(QEMUFile *f);
diff --git a/migration/ram.c b/migration/ram.c
index fd5c61c739..f9bbd17028 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -89,7 +89,7 @@
 #define RAM_SAVE_FLAG_EOS      0x10
 #define RAM_SAVE_FLAG_CONTINUE 0x20
 #define RAM_SAVE_FLAG_XBZRLE   0x40
-/* 0x80 is reserved in qemu-file.h for RAM_SAVE_FLAG_HOOK */
+/* 0x80 is reserved in rdma.h for RAM_SAVE_FLAG_HOOK */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
 #define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
 /* We can't use any flag that is bigger than 0x200 */
-- 
2.41.0


