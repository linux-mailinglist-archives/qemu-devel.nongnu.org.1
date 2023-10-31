Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 477057DC8ED
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:03:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkek-0001vT-Uy; Tue, 31 Oct 2023 05:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkeR-0001fY-HP
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkeP-00074z-Re
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P38lkBR2tXfHat2gPQMUxrdNBlKPaKNGbHcoKTIPWWE=;
 b=VdMPWZw5mgoxXfq+8OtZuhErVTaFW2fz1Zr7q/VenHThZoDfxLYrLRdWbTIVPcdezdvtIY
 6x9bNMj8Vlptnb8rhDfVo7Ol79NbqopdAHbnnsQXe5GFn9prqsg1fQwDLPjLHjjzTdHb3l
 P5aolA+maKqpeS1ZEo8o7URYmpbMW3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-PlgYXqqZMuyiIrT1aaYYXQ-1; Tue, 31 Oct 2023 05:03:00 -0400
X-MC-Unique: PlgYXqqZMuyiIrT1aaYYXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87532811E8D;
 Tue, 31 Oct 2023 09:02:59 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 093281C060B0;
 Tue, 31 Oct 2023 09:02:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 26/38] migration: Stop migration immediately in RDMA error paths
Date: Tue, 31 Oct 2023 10:01:30 +0100
Message-ID: <20231031090142.13122-27-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

In multiple places, RDMA errors are handled in a strange way, where it only
sets qemu_file_set_error() but not stop the migration immediately.

It's not obvious what will happen later if there is already an error.  Make
all such failures stop migration immediately.

Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231024163933.516546-1-peterx@redhat.com>
---
 migration/ram.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 024dedb6b1..20e6153114 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2973,11 +2973,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
+        return ret;
     }
 
     ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
+        return ret;
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
@@ -3043,6 +3045,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
+            goto out;
         }
 
         t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -3147,8 +3150,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
-        int rdma_reg_ret;
-
         if (!migration_in_postcopy()) {
             migration_bitmap_sync_precopy(rs, true);
         }
@@ -3156,6 +3157,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
+            return ret;
         }
 
         /* try transferring iterative blocks of memory */
@@ -3171,24 +3173,21 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
                 break;
             }
             if (pages < 0) {
-                ret = pages;
-                break;
+                qemu_mutex_unlock(&rs->bitmap_mutex);
+                return pages;
             }
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
         compress_flush_data();
 
-        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
-        if (rdma_reg_ret < 0) {
-            qemu_file_set_error(f, rdma_reg_ret);
+        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return ret;
         }
     }
 
-    if (ret < 0) {
-        return ret;
-    }
-
     ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
     if (ret < 0) {
         return ret;
-- 
2.41.0


