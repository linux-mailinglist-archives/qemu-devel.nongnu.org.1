Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2D8239D7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:49:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs5-0008Ky-Lk; Wed, 03 Jan 2024 19:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBs1-0008JW-4U
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:02 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrs-0007V9-Nt
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:54 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7818487b1d3so1874985a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329151; x=1704933951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6QJbyNGuVRLGZ8vbfrugWybx1mGgwwJhrzz8rgJs0I=;
 b=BwW/XJ2Z60Z8SUEx4pWRHICj/4p8bvI2quLw4KniNigKQFe3Excf8wb9IrJ4jzwjJ9
 oi1Btv+glTOQYeh3/o9cbeKk5dO9lWlEODnkrh7d/XbkADD15uRdvNEV/LbUrh1BLhLp
 +Qlizf3e4HoL8Vbatrt/8hLGOTW4Sv96eojbf+dWJMLOJfcdpLiYbbTbSCPufinQ5NvB
 ZOTluzllEK9+S46+lfThFO32UZxYg3E6q9x4YfSlifwyvzOP62F5aAXngr3AXjLWcSkz
 4EzSl5WZCp48m8S46HFGimhVa8Yk8vNgCzWJQSkFSUs8S21GXaS1eHJzd+AvERgW4hYB
 ao4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329151; x=1704933951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6QJbyNGuVRLGZ8vbfrugWybx1mGgwwJhrzz8rgJs0I=;
 b=nFET3u0nDnbDhDb5WHGUrSfgDY0NwhNaoqlKJzihiY9dEaTYwx8x8FU3I9npYlcEf3
 9R0sNBMrDoE0WU73w8t86S0/pLcIdXgLrpEaIAKtrPdP4cixM7HrLh9LbQP10EvwGLLO
 24AbTDCgH2gwICu9jsBRKwrOW1fs207W+vyJzQa3KjalTzii4Gh4pqxsY7EauC8zNjZy
 ZMxYpryxMjBn2tGV50fSGPWtom9p0JpfJEoIA3kjD+tYbJhurnT/GRCjwIcPSzWh2Rcv
 inKPPiNiZ9QCYX+Wg1Ob0L+pKPA2PXQ6yB8RDef4Zuwre4yzcVKb4nr8Vk25KV0PL58o
 qNDg==
X-Gm-Message-State: AOJu0Yz3H457QZeAc6SOIiOr+9+T1nY6HX8E460xn7sOFuRMgyocKqJN
 zDTiodNVodCmG8qYBqng/1+M1Oi0YHRKKzakK5wA9TEZdug=
X-Google-Smtp-Source: AGHT+IH2TtesTCRW4SBxx93ZrHfEPAxCub7H02gGPKudEYpI//NOkjQup5ZqvSxNF8PfViREW5U9hQ==
X-Received: by 2002:a05:620a:2689:b0:781:2b9d:f155 with SMTP id
 c9-20020a05620a268900b007812b9df155mr25072008qkp.29.1704329151374; 
 Wed, 03 Jan 2024 16:45:51 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:50 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 16/20] migration/multifd: Enable set normal page ratio test
 hook in multifd.
Date: Thu,  4 Jan 2024 00:44:48 +0000
Message-Id: <20240104004452.324068-17-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72f.google.com
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
 include/qemu/dsa.h             |  5 ++++-
 migration/migration-hmp-cmds.c |  7 +++++++
 migration/multifd.c            | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index fe7772107a..ac3d8b51f4 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -38,7 +38,7 @@ typedef struct dsa_batch_task {
     QemuSemaphore sem_task_complete;
     DsaTaskType task_type;
     DsaTaskStatus status;
-    int batch_size;
+    uint32_t batch_size;
     bool *results;
     QSIMPLEQ_ENTRY(dsa_batch_task) entry;
 } dsa_batch_task;
@@ -50,6 +50,9 @@ struct batch_task {
     ram_addr_t *addr;
     /* Zero page checking results */
     bool *results;
+    /* Set normal page ratio test hook. */
+    uint32_t normal_page_index;
+    uint32_t normal_page_counter;
 #ifdef CONFIG_DSA_OPT
     struct dsa_batch_task *dsa_batch;
 #endif
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 761d6d54de..8219d112d6 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -356,6 +356,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
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
index 6e73d995b0..cfae5401a9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -683,6 +683,37 @@ int multifd_send_sync_main(QEMUFile *f)
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
+    struct batch_task *batch_task = p->batch_task;
+
+    /* Set normal page test hook is disabled. */
+    if (multifd_normal_page_ratio > 100) {
+        return;
+    }
+
+    for (int i = 0; i < p->pages->num; i++) {
+        if (batch_task->normal_page_counter < multifd_normal_page_ratio) {
+            /* Turn a zero page into a normal page. */
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
@@ -748,6 +779,8 @@ static void multifd_zero_page_check(MultiFDSendParams *p)
         set_normal_pages(p);
     }
 
+    multifd_normal_page_test_hook(p);
+
     for (int i = 0; i < p->pages->num; i++) {
         uint64_t offset = p->pages->offset[i];
         bool zero_page = p->batch_task->results[i];
-- 
2.30.2


