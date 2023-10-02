Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D77B52EA
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHuo-0007MP-U6; Mon, 02 Oct 2023 08:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHum-0007LX-AC
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHuk-0007Um-Mp
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696249241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ferd7TxCvB2SnRgf0fytdwG50Om2VRGJZksL23h0oFs=;
 b=NCfg56xBKuahXgWr3PbSxUplrQ29JxtgIuW3JDIXxHZsP1af7YKR1/g9GLeMpuH7mFslZ4
 GVlfNFKToE7WuIZNyEt2fz+V19iZYkivAjdjvtOJuBmt8iZ6pqj3JAzh2v4KS7YIO3igNF
 DuhB7PKCSp4AOndnzU879EDTgIPb0sQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-EzVfv6VLM5SRu4d9xFB6wQ-1; Mon, 02 Oct 2023 08:20:40 -0400
X-MC-Unique: EzVfv6VLM5SRu4d9xFB6wQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D11B3C1992B;
 Mon,  2 Oct 2023 12:20:40 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F0FC2156701;
 Mon,  2 Oct 2023 12:20:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 08/13] migration: Don't abuse qemu_file transferred for RDMA
Date: Mon,  2 Oct 2023 14:20:16 +0200
Message-ID: <20231002122021.231959-9-quintela@redhat.com>
In-Reply-To: <20231002122021.231959-1-quintela@redhat.com>
References: <20231002122021.231959-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 095d6d75bb..84e11e6dd8 100644
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
index a2a3db35b1..2a3c784328 100644
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
index 4666f19325..63483732ce 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -191,7 +191,7 @@ process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 
 # migration-stats
-migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd) "qemu_file %" PRIu64 " multifd %" PRIu64
+migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
 
 # channel.c
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-- 
2.41.0


