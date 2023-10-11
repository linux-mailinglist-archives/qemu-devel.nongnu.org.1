Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5177C5E81
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfvo-0005GT-Q3; Wed, 11 Oct 2023 16:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvm-0005EL-8b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvk-00033f-Oz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkeaZK6VYgRr9u+laAr7zDd9jA0PYLOfVUvIKZcQa3I=;
 b=hgByzzWc/oym3YUZuCJ2bjK/0nyjeSJ0p3XsL686a2uR4UCvWofnMYf3h//BPICjsbtQO8
 yBEVu54qpB1XG7vEFNAQ19dUFcLzlF7NLRgYWnRoRg5f4xBsmg4MHKfiXiqWnMerfvEWvV
 3VQCO6ZPyI+hGAA0I5cmWxIjQfJWqIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-mPdUnkByMNSnenn9bFnWKg-1; Wed, 11 Oct 2023 16:35:40 -0400
X-MC-Unique: mPdUnkByMNSnenn9bFnWKg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4545C185A7B2;
 Wed, 11 Oct 2023 20:35:40 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA157492B06;
 Wed, 11 Oct 2023 20:35:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 07/13] qemu-file: Remove QEMUFileHooks
Date: Wed, 11 Oct 2023 22:35:21 +0200
Message-ID: <20231011203527.9061-8-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-1-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

The only user was rdma, and its use is gone.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 4 ----
 migration/qemu-file.c | 6 ------
 migration/rdma.c      | 9 ---------
 3 files changed, 19 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 60510a2819..0b22d8335f 100644
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
index 745eaf7a5b..3fb25148d1 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -38,7 +38,6 @@
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
 
 struct QEMUFile {
-    const QEMUFileHooks *hooks;
     QIOChannel *ioc;
     bool is_writable;
 
@@ -133,11 +132,6 @@ QEMUFile *qemu_file_new_input(QIOChannel *ioc)
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
index bf16990f91..ca2a15be99 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4004,13 +4004,6 @@ err:
     return -1;
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
@@ -4062,7 +4055,6 @@ static QEMUFile *rdma_new_input(RDMAContext *rdma)
     rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
     rioc->rdmain = rdma;
     rioc->rdmaout = rdma->return_path;
-    qemu_file_set_hooks(rioc->file, &rdma_read_hooks);
 
     return rioc->file;
 }
@@ -4074,7 +4066,6 @@ static QEMUFile *rdma_new_output(RDMAContext *rdma)
     rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
     rioc->rdmaout = rdma;
     rioc->rdmain = rdma->return_path;
-    qemu_file_set_hooks(rioc->file, &rdma_write_hooks);
 
     return rioc->file;
 }
-- 
2.41.0


