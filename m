Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0E716C6C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q442o-0001gD-JQ; Tue, 30 May 2023 14:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442j-0001b6-NN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442h-0000oP-K1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXiaJLB0asswiz5Qce7G0O6vlzSxR/Ax4r2WPVp/2WM=;
 b=iENXysOr+Wr8MH7QuQm2bfFGAQJr4MQ72HhYuecI23o3fzed+EX3hlzuzHbcNUnlFb7WT6
 4aYeaw60de1bWGJxlWi6nJMFGz+KTX2ENqnvs+JE0KcIikwvZmJilgkm7PJypCWVbW11xj
 DdmNG4gMdaF1eNNIgEhsfLGJ2xuZF3g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-9uG4xK8mPtepbC6l5E1gbw-1; Tue, 30 May 2023 14:25:57 -0400
X-MC-Unique: 9uG4xK8mPtepbC6l5E1gbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E513101A531
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:25:57 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F7AD17103;
 Tue, 30 May 2023 18:25:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PULL 18/21] qemu-file: Remove QEMUFileHooks
Date: Tue, 30 May 2023 20:25:28 +0200
Message-Id: <20230530182531.6371-19-quintela@redhat.com>
In-Reply-To: <20230530182531.6371-1-quintela@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The only user was rdma, and its use is gone.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230509120700.78359-8-quintela@redhat.com>
---
 migration/qemu-file.h | 4 ----
 migration/qemu-file.c | 6 ------
 migration/rdma.c      | 9 ---------
 3 files changed, 19 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index c43c410168..c7c832d200 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -36,12 +36,8 @@
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-typedef struct QEMUFileHooks {
-} QEMUFileHooks;
-
 QEMUFile *qemu_file_new_input(QIOChannel *ioc);
 QEMUFile *qemu_file_new_output(QIOChannel *ioc);
-void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks);
 int qemu_fclose(QEMUFile *f);
 
 /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index a222daeaab..c94b667726 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -38,7 +38,6 @@
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
 
 struct QEMUFile {
-    const QEMUFileHooks *hooks;
     QIOChannel *ioc;
     bool is_writable;
 
@@ -147,11 +146,6 @@ QEMUFile *qemu_file_new_input(QIOChannel *ioc)
     return qemu_file_new_impl(ioc, false);
 }
 
-void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
-{
-    f->hooks = hooks;
-}
-
 /*
  * Get last error for stream f with optional Error*
  *
diff --git a/migration/rdma.c b/migration/rdma.c
index b506b86b47..b85259263a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4010,13 +4010,6 @@ err:
     return ret;
 }
 
-static const QEMUFileHooks rdma_read_hooks = {
-};
-
-static const QEMUFileHooks rdma_write_hooks = {
-};
-
-
 static void qio_channel_rdma_finalize(Object *obj)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(obj);
@@ -4075,12 +4068,10 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
         rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
         rioc->rdmaout = rdma;
         rioc->rdmain = rdma->return_path;
-        qemu_file_set_hooks(rioc->file, &rdma_write_hooks);
     } else {
         rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
         rioc->rdmain = rdma;
         rioc->rdmaout = rdma->return_path;
-        qemu_file_set_hooks(rioc->file, &rdma_read_hooks);
     }
 
     return rioc->file;
-- 
2.40.1


