Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F0715FB5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yTL-0001he-83; Tue, 30 May 2023 08:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3yT3-0001Z0-Tu
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3yT2-0000py-El
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvR5bgkmZDgLIWYppPBjRPR0iSGa5MAU0MoILu94rXA=;
 b=ObTYlSf7rdchpO37eLPbkB3L83PAn7YaoNbTfk6UqNTF+9dr7+Hl9U/Vd6nsjGizfhdHeB
 MpYItkjlcSI4GnEcVTcRC+YV8SaocxyL65e2SiqLBLHIN1Z1uCqucjUpGJlwUQqMpDnkZi
 dHM3wvXjBmrXKS43vcNbE3tBJZ+WI58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-tMihpy6YN8y4O50JhL07nw-1; Tue, 30 May 2023 08:28:44 -0400
X-MC-Unique: tMihpy6YN8y4O50JhL07nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CE79856F75;
 Tue, 30 May 2023 12:28:42 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C72740CFD46;
 Tue, 30 May 2023 12:28:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 15/16] migration: Remove transferred atomic counter
Date: Tue, 30 May 2023 14:28:12 +0200
Message-Id: <20230530122813.2674-16-quintela@redhat.com>
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

After last commit, it is a write only variable.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-stats.h | 4 ----
 migration/multifd.c         | 3 ---
 migration/ram.c             | 1 -
 3 files changed, 8 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 68f3939188..05290ade76 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -97,10 +97,6 @@ typedef struct {
      * Number of bytes sent through RDMA.
      */
     Stat64 rdma_bytes;
-    /*
-     * Total number of bytes transferred.
-     */
-    Stat64 transferred;
     /*
      * Number of pages transferred that were full of zeros.
      */
diff --git a/migration/multifd.c b/migration/multifd.c
index 0bf5958a9c..b297d1cb62 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -188,7 +188,6 @@ static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     stat64_add(&mig_stats.multifd_bytes, size);
-    stat64_add(&mig_stats.transferred, size);
     return 0;
 }
 
@@ -715,7 +714,6 @@ static void *multifd_send_thread(void *opaque)
                     break;
                 }
                 stat64_add(&mig_stats.multifd_bytes, p->packet_len);
-                stat64_add(&mig_stats.transferred, p->packet_len);
             } else {
                 /* Send header using the same writev call */
                 p->iov[0].iov_len = p->packet_len;
@@ -729,7 +727,6 @@ static void *multifd_send_thread(void *opaque)
             }
 
             stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
-            stat64_add(&mig_stats.transferred, p->next_packet_size);
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
diff --git a/migration/ram.c b/migration/ram.c
index 0675421f4e..cdf7783d65 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -443,7 +443,6 @@ void ram_transferred_add(uint64_t bytes)
     } else {
         stat64_add(&mig_stats.downtime_bytes, bytes);
     }
-    stat64_add(&mig_stats.transferred, bytes);
 }
 
 struct MigrationOps {
-- 
2.40.1


