Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8E7D58CE
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKRS-0001rK-M4; Tue, 24 Oct 2023 12:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvKRQ-0001m2-JY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvKRO-00060L-QM
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698165577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eSFHElIPLcUUx+qwRAnBhmuHbmbvLs+hVW2DDPETeTA=;
 b=VTceSXWTT7okLx60kuB7Jt9n9cflGFhLRrPpu5e06Fz7D5Lz0TZUwnh3KUGxs/orRVMfD3
 2x34wva7kZvUfIADrl+vVOJu8FE051Tw3LV6PBSYzpddjwKTlTx17DpneoG6zNggywAHba
 d/WcnT40KDq1VdhfYt08UmAFjioa3iY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-hcsJFVteMWOM9qf0cENpBg-1; Tue, 24 Oct 2023 12:39:36 -0400
X-MC-Unique: hcsJFVteMWOM9qf0cENpBg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d3f71f49cso14826686d6.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165575; x=1698770375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eSFHElIPLcUUx+qwRAnBhmuHbmbvLs+hVW2DDPETeTA=;
 b=jQ5NHS/12SDtsNz4IirCHVigdAy0tRpQWsV/O8fnkQshHquteHidnn8gMWdS+StKKx
 x1kVyOj5EOLOqB+ep3il7VMlkJa8H/qTLn7FS7q7Rf6KhX6SPzvG6J8b3Iyx5fe4or8L
 yTG/0TJ5zTzEIpl6dVdeGykzafFyGLAdikyossAGf4GzhX4NdGywJrfiB88uKnIIR2FD
 EPoUvuCEO5STICvTqnQy6t/t6x/mnw4jGP2z/JHbq0dOfqLtlOYpHeigmxvbp3nfR3cG
 7ZqRcIrOweLEWExUhSghDZaNNYskZeUjG6Nwgf7pNNtgg9okAqJXJ7JGbNV4TTg6eo0Y
 OyAQ==
X-Gm-Message-State: AOJu0YxgYfje5Xzm4sp3RYblWzWejmWtqWm9vzuXO6jPYDx9DvZHwdOB
 XtOPLvL+RigDQfZP2v59w3sskpJbif33gv7l9a+u69OKHxHBrJ8NXRzBOgnxyZoosxRzz0tnvYi
 4eH882jyoPup3BFTOZMwJwMhp5Ab/0H93zzmZmX65aVxGh03nqLTc7ZnMb0Pd66LAS9vZIbHB
X-Received: by 2002:a05:620a:2790:b0:775:7921:732e with SMTP id
 g16-20020a05620a279000b007757921732emr12368836qkp.3.1698165575260; 
 Tue, 24 Oct 2023 09:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVOM8S+W1LmlBXScOvLOrE06ZnmuWlgu8G63xPn6lQHQc9B7yJMbG/CKnx6wcOyvyu/x5IgA==
X-Received: by 2002:a05:620a:2790:b0:775:7921:732e with SMTP id
 g16-20020a05620a279000b007757921732emr12368814qkp.3.1698165574906; 
 Tue, 24 Oct 2023 09:39:34 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05620a410100b00767177a5bebsm3557352qko.56.2023.10.24.09.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:39:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3] migration: Stop migration immediately in RDMA error paths
Date: Tue, 24 Oct 2023 12:39:33 -0400
Message-ID: <20231024163933.516546-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
---

v3:
- in ram_save_complete() return directly with retval, drop the "ret<0"
  check after the loop [Juan]

This patch is based on Thomas's patch:

[PATCH v2] migration/ram: Fix compilation with -Wshadow=local
https://lore.kernel.org/r/20231024092220.55305-1-thuth@redhat.com

Above patch should have been queued by both Markus and Juan.
---
 migration/ram.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 212add4481..6cb8b5cd2f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3034,11 +3034,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
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
@@ -3104,6 +3106,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
+            goto out;
         }
 
         t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -3208,8 +3211,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
-        int rdma_reg_ret;
-
         if (!migration_in_postcopy()) {
             migration_bitmap_sync_precopy(rs, true);
         }
@@ -3217,6 +3218,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
+            return ret;
         }
 
         /* try transferring iterative blocks of memory */
@@ -3232,24 +3234,21 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
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
 
         ram_flush_compressed_data(rs);
 
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


