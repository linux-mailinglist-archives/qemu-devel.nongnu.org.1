Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66672E686
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95Ta-0006Ga-6k; Tue, 13 Jun 2023 10:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TN-0006AF-E8
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TK-0007Y4-7m
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Km9j3t3TIEx5XuWqRvHZVsalsYUdrZyIS+jcGvqmWn4=;
 b=b7P2eU+0ENYGs7r4iyLC3U+ERVNmI+tUcXnUiQRToJa188Pd8dJLa4SNmcarDRhPDjZMjq
 hb8Mbp8Zumm47xNq1pOYaXTmDDoJXvB5MuOi4gr1wyDN/R8UWSeWLF3kb4Prao1evWuLFX
 Eocw9utlzVRu+39MvsZocV3Fxf8wGpw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-Xge9b1u4N9qxJzXmSS7oCg-1; Tue, 13 Jun 2023 10:58:09 -0400
X-MC-Unique: Xge9b1u4N9qxJzXmSS7oCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9F763C11CD5;
 Tue, 13 Jun 2023 14:58:05 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB6C540C6F5C;
 Tue, 13 Jun 2023 14:58:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 05/18] migration: Move compression_counters cleanup
 ram-compress.c
Date: Tue, 13 Jun 2023 16:57:44 +0200
Message-Id: <20230613145757.10131-6-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c    | 4 +---
 migration/ram-compress.c | 5 +++++
 migration/savevm.c       | 1 -
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 84551f040c..5105ad6825 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1628,11 +1628,9 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
 
     migrate_init(s);
     /*
-     * set mig_stats compression_counters memory to zero for a
-     * new migration
+     * set mig_stats memory to zero for a new migration
      */
     memset(&mig_stats, 0, sizeof(mig_stats));
-    memset(&compression_counters, 0, sizeof(compression_counters));
 
     return true;
 }
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 06254d8c69..a0f6a56470 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -430,6 +430,11 @@ int compress_threads_load_setup(QEMUFile *f)
         return 0;
     }
 
+    /*
+     * set compression_counters memory to zero for a new migration
+     */
+    memset(&compression_counters, 0, sizeof(compression_counters));
+
     thread_count = migrate_decompress_threads();
     decompress_threads = g_new0(QemuThread, thread_count);
     decomp_param = g_new0(DecompressParam, thread_count);
diff --git a/migration/savevm.c b/migration/savevm.c
index bc284087f9..aa31d29f23 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1621,7 +1621,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     migrate_init(ms);
     memset(&mig_stats, 0, sizeof(mig_stats));
-    memset(&compression_counters, 0, sizeof(compression_counters));
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
-- 
2.40.1


