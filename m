Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0201D715E24
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xw8-00057y-76; Tue, 30 May 2023 07:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xw6-00055E-1P
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xw3-00008l-MC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j428coaIRiHiCDE2P6IQUI8TpAu8vNrqJ4vgCs3KdUw=;
 b=JfcD7UKoUEAWXL49xxHVwr2wnmCWK1lzQR+8Xea9jp7FtbZ99Y7zY/U4L6VdYbReVWHQW9
 1MEINMWOWGSnQnUpfnPvaa53t7Aqu4DdYzojGgcZ5Byxb0SDhhOFvA2EqffQtQAmh5dYOC
 dVBIn0O9s6XD6jE7IqXNAjil2zf3DfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-JkAstht7PQe0Ivl_cGWQGA-1; Tue, 30 May 2023 07:54:41 -0400
X-MC-Unique: JkAstht7PQe0Ivl_cGWQGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 763EB811E78
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:54:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 635C440C6EC4;
 Tue, 30 May 2023 11:54:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 06/21] migration: Don't abuse qemu_file transferred for RDMA
Date: Tue, 30 May 2023 13:54:14 +0200
Message-Id: <20230530115429.1998-7-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Just create a variable for it, the same way that multifd does.  This
way it is safe to use for other thread, etc, etc.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230515195709.63843-11-quintela@redhat.com>
---
 migration/migration-stats.h |  4 ++++
 migration/migration-stats.c |  5 +++--
 migration/rdma.c            | 22 ++++++++++++++++++++--
 migration/trace-events      |  2 +-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index ac2260e987..2358caad63 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -89,6 +89,10 @@ typedef struct {
      * Maximum amount of data we can send in a cycle.
      */
     Stat64 rate_limit_max;
+    /*
+     * Number of bytes sent through RDMA.
+     */
+    Stat64 rdma_bytes;
     /*
      * Total number of bytes transferred.
      */
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index f98c8260be..79eea8d865 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -61,8 +61,9 @@ void migration_rate_reset(QEMUFile *f)
 uint64_t migration_transferred_bytes(QEMUFile *f)
 {
     uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
+    uint64_t rdma = stat64_get(&mig_stats.rdma_bytes);
     uint64_t qemu_file = qemu_file_transferred(f);
 
-    trace_migration_transferred_bytes(qemu_file, multifd);
-    return qemu_file + multifd;
+    trace_migration_transferred_bytes(qemu_file, multifd, rdma);
+    return qemu_file + multifd + rdma;
 }
diff --git a/migration/rdma.c b/migration/rdma.c
index 2e4dcff1c9..074456f9df 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2122,9 +2122,18 @@ retry:
                     return -EIO;
                 }
 
+                /*
+                 * TODO: Here we are sending something, but we are not
+                 * accounting for anything transferred.  The following is wrong:
+                 *
+                 * stat64_add(&mig_stats.rdma_bytes, sge.length);
+                 *
+                 * because we are using some kind of compression.  I
+                 * would think that head.len would be the more similar
+                 * thing to a correct value.
+                 */
                 stat64_add(&mig_stats.zero_pages,
                            sge.length / qemu_target_page_size());
-
                 return 1;
             }
 
@@ -2232,8 +2241,17 @@ retry:
 
     set_bit(chunk, block->transit_bitmap);
     stat64_add(&mig_stats.normal_pages, sge.length / qemu_target_page_size());
+    /*
+     * We are adding to transferred the amount of data written, but no
+     * overhead at all.  I will asume that RDMA is magicaly and don't
+     * need to transfer (at least) the addresses where it wants to
+     * write the pages.  Here it looks like it should be something
+     * like:
+     *     sizeof(send_wr) + sge.length
+     * but this being RDMA, who knows.
+     */
+    stat64_add(&mig_stats.rdma_bytes, sge.length);
     ram_transferred_add(sge.length);
-    qemu_file_credit_transfer(f, sge.length);
     rdma->total_writes++;
 
     return 0;
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a1ea..54ae5653fd 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -187,7 +187,7 @@ process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 
 # migration-stats
-migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd) "qemu_file %" PRIu64 " multifd %" PRIu64
+migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
 
 # channel.c
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-- 
2.40.1


