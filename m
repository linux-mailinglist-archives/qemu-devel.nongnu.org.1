Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A90347CD8DE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SR-0007MP-1l; Wed, 18 Oct 2023 06:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SA-0007JJ-O0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3S8-0007gv-TT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zkT9Acnej87x6wRVG/5fD+gyy+jX5E1Wl9CdFy55FI=;
 b=i1Ug/J7BUbUEItMVpUDWyOKTAAehTbqmGf75Sy/J5a4ozyuns2uWLFYEOzn8gtdYr1hkkp
 4TX7HuxlZCcCL1SjjCD52Vs4TsHEaJ0/f4m5/lFbhmRqcq3laBve98BjdCMt2s6u/ZmmR1
 6s3whlDU8e0TfcHfnd321R3RGn8w6EQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-5wbV48ANOB238f2wbJHLcw-1; Wed, 18 Oct 2023 06:06:56 -0400
X-MC-Unique: 5wbV48ANOB238f2wbJHLcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDEA310201E3;
 Wed, 18 Oct 2023 10:06:55 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E73952026D4C;
 Wed, 18 Oct 2023 10:06:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 02/11] migration: Move compression_counters cleanup
 ram-compress.c
Date: Wed, 18 Oct 2023 12:06:42 +0200
Message-ID: <20231018100651.32674-3-quintela@redhat.com>
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20230613145757.10131-6-quintela@redhat.com>
---
 migration/migration.c    | 4 +---
 migration/ram-compress.c | 5 +++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 81862fcaa9..a808abd294 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1466,11 +1466,9 @@ int migrate_init(MigrationState *s, Error **errp)
     s->switchover_acked = false;
     s->rdma_migration = false;
     /*
-     * set mig_stats compression_counters memory to zero for a
-     * new migration
+     * set mig_stats memory to zero for a new migration
      */
     memset(&mig_stats, 0, sizeof(mig_stats));
-    memset(&compression_counters, 0, sizeof(compression_counters));
     migration_reset_vfio_bytes_transferred();
 
     return 0;
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
-- 
2.41.0


