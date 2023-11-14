Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E6D7EAA37
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBx-0007dI-Qv; Tue, 14 Nov 2023 00:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBj-0007Ha-Jt
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:15 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBh-0001Zd-30
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:15 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-778927f2dd3so268557285a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940528; x=1700545328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPUuy0slv3M1LESng36bIPWqc+GaBXHR9iSzag4Sinc=;
 b=PHmLSMuFRxlRTX6xlIBbmpKPP2U56/UdwTCcq90eEybiwAuw6D1ibUBUyTA3CTszAG
 zGCehMvTrQOCf89og4iUSA6nSDTApV1rRLj6seTGsqMKY/k01dxiznO5zCaiGcG+oGVL
 DaHdsrizajweKscCiLFPOLdFV6k+W04y1eiBNQFvBw1Ife5jVvjUPGNpUH7cyWi2tlop
 46KdccVrVd/0yh82CNpd+brluKeIg1cOHeooB5B3dHkkLyGfKnk3oXwftwEnTkZpGzCn
 g0OVtYU94UPDNg1q8cDHpt6ET9dF0anGQjThDCiLoOhSA6hvpPKbtmIkAA4kC4BmUVqN
 4Uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940528; x=1700545328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPUuy0slv3M1LESng36bIPWqc+GaBXHR9iSzag4Sinc=;
 b=bNAgFxGzWAzql3IfzMmw14pzflrRp74x4rbg9QU1HeVtLSI/WXp/hMt3gBDVwLrxSb
 H+rDP1EV2yLg/X7w5jXSGDcjGmI3FM19Np7qhPto4oaYeHW6C/c3GURNQtD9tmnmgRss
 O8Q03lul80tXjiZPes4PXO7myHWdoLCr/nAYw6fifR6d2DFIuDRd02GaVvYVyoHZAZjo
 Xc+0JPUtE+sw2h7yDI9O5Pp18RqqX1T8ioIycA6woDxD5isjmsADaFA5f0ZyLWAVAgQY
 0xaymTnTckmcYxLykH9Ky0gdf8ANPDnUTTYof99ueBa1uSr6v02oRacrEEBw7YjyDESn
 au2A==
X-Gm-Message-State: AOJu0YyZC2PbSTMMDj92D8LgXgZyr26b2T+yFbpeNQ6C13HWshbbj/K5
 f4qI8qm//PKw+EWf9pHBhww1kA==
X-Google-Smtp-Source: AGHT+IEkf5jftCDG6OjFoEUmWdXGHaaaSc4zOmLF3rRppdSFLwNiLrp8/GrU+5ofeXTmRDq6YUYjiw==
X-Received: by 2002:a37:ef19:0:b0:777:27a5:d1e with SMTP id
 j25-20020a37ef19000000b0077727a50d1emr1276218qkk.41.1699940528592; 
 Mon, 13 Nov 2023 21:42:08 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:42:08 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 16/20] migration/multifd: Enable set normal page ratio test
 hook in multifd.
Date: Tue, 14 Nov 2023 05:40:28 +0000
Message-Id: <20231114054032.1192027-17-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Test hook is disabled by default. To set it, a normal page ratio
between 0 and 100 are valid. If the ratio is set to 50, it means
at least 50% of all pages are sent as normal pages.

Set the option:
migrate_set_parameter multifd-normal-page-ratio 60

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 include/qemu/dsa.h             |  7 ++++++-
 migration/migration-hmp-cmds.c |  7 +++++++
 migration/multifd.c            | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 3f8ee07004..bc7f652e0b 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -37,7 +37,10 @@ typedef struct buffer_zero_batch_task {
     enum dsa_task_type task_type;
     enum dsa_task_status status;
     bool *results;
-    int batch_size;
+    uint32_t batch_size;
+    // Set normal page ratio test hook.
+    uint32_t normal_page_index;
+    uint32_t normal_page_counter;
     QSIMPLEQ_ENTRY(buffer_zero_batch_task) entry;
 } buffer_zero_batch_task;
 
@@ -45,6 +48,8 @@ typedef struct buffer_zero_batch_task {
 
 struct buffer_zero_batch_task {
     bool *results;
+    uint32_t normal_page_index;
+    uint32_t normal_page_counter;
 };
 
 #endif
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index d9451744dd..788ce699ac 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -356,6 +356,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL),
             params->multifd_dsa_accel);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_NORMAL_PAGE_RATIO),
+            params->multifd_normal_page_ratio);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
@@ -675,6 +678,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         error_setg(&err, "The block-bitmap-mapping parameter can only be set "
                    "through QMP");
         break;
+    case MIGRATION_PARAMETER_MULTIFD_NORMAL_PAGE_RATIO:
+        p->has_multifd_normal_page_ratio = true;
+        visit_type_uint8(v, param, &p->multifd_normal_page_ratio, &err);
+        break;
     case MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD:
         p->has_x_vcpu_dirty_limit_period = true;
         visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
diff --git a/migration/multifd.c b/migration/multifd.c
index 2f635898ed..c9f9eef5b1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -687,6 +687,37 @@ int multifd_send_sync_main(QEMUFile *f)
     return 0;
 }
 
+static void multifd_normal_page_test_hook(MultiFDSendParams *p)
+{
+    /*
+     * The value is between 0 to 100. If the value is 10, it means at
+     * least 10% of the pages are normal page. A zero page can be made
+     * a normal page but not the other way around.
+     */
+    uint8_t multifd_normal_page_ratio =
+        migrate_multifd_normal_page_ratio();
+    struct buffer_zero_batch_task *batch_task = p->batch_task;
+
+    // Set normal page test hook is disabled.
+    if (multifd_normal_page_ratio > 100) {
+        return;
+    }
+
+    for (int i = 0; i < p->pages->num; i++) {
+        if (batch_task->normal_page_counter < multifd_normal_page_ratio) {
+            // Turn a zero page into a normal page.
+            batch_task->results[i] = false;
+        }
+        batch_task->normal_page_index++;
+        batch_task->normal_page_counter++;
+
+        if (batch_task->normal_page_index >= 100) {
+            batch_task->normal_page_index = 0;
+            batch_task->normal_page_counter = 0;
+        }
+    }
+}
+
 static void set_page(MultiFDSendParams *p, bool zero_page, uint64_t offset)
 {
     RAMBlock *rb = p->pages->block;
@@ -752,6 +783,8 @@ static void multifd_zero_page_check(MultiFDSendParams *p)
         set_normal_pages(p);
     }
 
+    multifd_normal_page_test_hook(p);
+
     for (int i = 0; i < p->pages->num; i++) {
         uint64_t offset = p->pages->offset[i];
         bool zero_page = p->batch_task->results[i];
-- 
2.30.2


