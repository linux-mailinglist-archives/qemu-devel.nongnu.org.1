Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4B7C81EB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:24:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEMp-0005ne-RZ; Fri, 13 Oct 2023 05:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMn-0005kJ-7D; Fri, 13 Oct 2023 05:21:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMl-00072v-Ld; Fri, 13 Oct 2023 05:21:56 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A3E4C48F33;
 Fri, 13 Oct 2023 11:21:51 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v3 8/9] blockjob: query driver-specific info via a new 'query'
 driver method
Date: Fri, 13 Oct 2023 11:21:42 +0200
Message-Id: <20231013092143.365296-9-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013092143.365296-1-f.ebner@proxmox.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v3:
    * Unlock job mutex while calling the driver's handler for query.

 blockjob.c                   | 6 ++++++
 include/block/blockjob_int.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/blockjob.c b/blockjob.c
index f8cf6e58e2..9c1cf2ba78 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -376,6 +376,7 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
 {
     BlockJobInfo *info;
     uint64_t progress_current, progress_total;
+    const BlockJobDriver *drv = block_job_driver(job);
 
     GLOBAL_STATE_CODE();
 
@@ -405,6 +406,11 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
                         g_strdup(error_get_pretty(job->job.err)) :
                         g_strdup(strerror(-job->job.ret));
     }
+    if (drv->query) {
+        job_unlock();
+        drv->query(job, info);
+        job_lock();
+    }
     return info;
 }
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f604985315..4ab88b3c97 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -72,6 +72,11 @@ struct BlockJobDriver {
      * Change the @job's options according to @opts.
      */
     void (*change)(BlockJob *job, BlockJobChangeOptions *opts, Error **errp);
+
+    /*
+     * Query information specific to this kind of block job.
+     */
+    void (*query)(BlockJob *job, BlockJobInfo *info);
 };
 
 /*
-- 
2.39.2



