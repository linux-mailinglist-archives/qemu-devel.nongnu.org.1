Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1362715FBD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:32:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yT0-0001Ub-0f; Tue, 30 May 2023 08:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySs-0001Nk-Rn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySl-0000g9-HA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDtFey+ZTmtNcB+HUHyNurCy6qQRYHksRYSDgfGv/Z8=;
 b=LMHEKXfsBE/wnBbei+73s5NBchdgEoc2tmvI5p+Ojm2xR7+dBwlrk4mZDc3nBkW6+PyXg/
 i3zLUI5LVOrAniUD654ExAQ520cQSBDQrXzLsv/SnqnkY5djsl+uagWDopfRA8DYD+whZm
 trpOdQEzustl5iXb5FTuIwb62ZcNnxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-VtoWSckxO82GEpYgbqZClw-1; Tue, 30 May 2023 08:28:26 -0400
X-MC-Unique: VtoWSckxO82GEpYgbqZClw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78BF1811E78;
 Tue, 30 May 2023 12:28:26 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1768240CFD4A;
 Tue, 30 May 2023 12:28:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 06/16] qemu_file: Use a stat64 for qemu_file_transferred
Date: Tue, 30 May 2023 14:28:03 +0200
Message-Id: <20230530122813.2674-7-quintela@redhat.com>
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

This way we can read it from any thread.
I checked that it gives the same value than the current one.  We never
use to qemu_files at the same time.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-stats.h | 4 ++++
 migration/qemu-file.c       | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 2358caad63..b7795e7914 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -81,6 +81,10 @@ typedef struct {
      * Number of bytes sent during precopy stage.
      */
     Stat64 precopy_bytes;
+    /*
+     * Number of bytes transferred with QEMUFile.
+     */
+    Stat64 qemu_file_transferred;
     /*
      * Amount of transferred data at the start of current cycle.
      */
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 5ff3bc40fd..ac7a303142 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -286,6 +286,7 @@ void qemu_fflush(QEMUFile *f)
         } else {
             uint64_t size = iov_size(f->iov, f->iovcnt);
             f->total_transferred += size;
+            stat64_add(&mig_stats.qemu_file_transferred, size);
         }
 
         qemu_iovec_release_ram(f);
@@ -628,7 +629,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)
 
 uint64_t qemu_file_transferred_noflush(QEMUFile *f)
 {
-    uint64_t ret = f->total_transferred;
+    uint64_t ret = stat64_get(&mig_stats.qemu_file_transferred);
     int i;
 
     g_assert(qemu_file_is_writable(f));
@@ -644,7 +645,7 @@ uint64_t qemu_file_transferred(QEMUFile *f)
 {
     g_assert(qemu_file_is_writable(f));
     qemu_fflush(f);
-    return f->total_transferred;
+    return stat64_get(&mig_stats.qemu_file_transferred);
 }
 
 void qemu_put_be16(QEMUFile *f, unsigned int v)
-- 
2.40.1


