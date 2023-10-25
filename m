Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC57D748F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjL-0000wp-Vi; Wed, 25 Oct 2023 15:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjK-0000wI-0y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:50 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjI-0006B7-9Y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:49 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-778a108ae49so102571885a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262787; x=1698867587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IWhl0rawXmMq+XYbVZ524V+XuPqJsOdn1fgEyYuj5I=;
 b=N9Pw7aQElmmryzUVZbrK18rKXV2lhGlO507t4e+8y8g5rKictmGxtx3H4z7WH/dXS1
 CTZtlEdtvLHXJlXna5JjyTUC9F2mNVJKGXm9iEK0sup5kFwtQfA6Jh1faqC/vjYikXLv
 oNKesgPMeFfsMep5ZTgo7+9Wt7PQV3f37bgo8eKJkyo1ihLZTtXvu3a2NdCJVio8Crjx
 ROX4OXuL4KMtOSQ66gwZNz5S4HBTWbEfBmKo8ce6/SehEldF2mtN/fQ2ZNeJN/vsf3PC
 sR4k26mPq4c4nZV4z/VIsIWC6zNlx9M0R248awkx2mBu0/aQPf/tGfbGSTN9vtIOadAJ
 SohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262787; x=1698867587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IWhl0rawXmMq+XYbVZ524V+XuPqJsOdn1fgEyYuj5I=;
 b=fu3VordpHllrpIbOyDbZZE40h1XS/fMo5gpQmlvc5PreuNwBwkRSmS5LyT2BAC1480
 aqPrT3XoDyHsCSCHSbiEsVBiovLkFhoQhQ+tT/W5MBscZOUBKqQGHaeXxr0KAIlavl2U
 6rInLbAtmyf0h+eu/w2HA6oZfOFSKXkdijPNn/nbWMyG40d+Vv6d4YRGqaVNZZbCaqzq
 ItlWJCmW1OX+SUq6NACcDkRKy10eBKzVFoEj2YyTdCJjh1tz99A0seeRfbT2K3xesF2K
 PxUcM4xSlA9kk0xWy2ovbS5nzaYcouQF/Rzz+TFFgrbp88gLJEU9mKylFrp4/hFl3j6B
 WVZw==
X-Gm-Message-State: AOJu0YyMn5ST0Bc2uQYawTZGDtKdotlYkc9UU3aVIKP7gv6DBZbSIbsH
 3UYDguJXskxLev7J4bqMDEM85w==
X-Google-Smtp-Source: AGHT+IH2Gm3n/5cgVIqNXsCqdxRLzA62xaairKL0zvpWrRXKqVVOUgT3XW/aPezAAZkoIVJ6jj6QHQ==
X-Received: by 2002:a05:620a:29d1:b0:774:2dc0:649b with SMTP id
 s17-20020a05620a29d100b007742dc0649bmr689518qkp.18.1698262787479; 
 Wed, 25 Oct 2023 12:39:47 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:47 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 12/16] migration/multifd: Enable set normal page ratio test
 hook in multifd.
Date: Wed, 25 Oct 2023 19:38:18 +0000
Message-Id: <20231025193822.2813204-13-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Test hook is disabled by default. To set it, a normal page ratio
between 0 and 100 are valid. If the ratio is set to 50, it means
at least 50% of all pages are sent as normal pages.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 include/qemu/dsa.h             |  7 ++++++-
 migration/migration-hmp-cmds.c |  7 +++++++
 migration/multifd.c            | 36 +++++++++++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 2 deletions(-)

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
index bdffe9e023..e1f110afbc 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -351,6 +351,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL),
             params->multifd_dsa_accel);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_NORMAL_PAGE_RATIO),
+            params->multifd_normal_page_ratio);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
@@ -646,6 +649,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 79fecbd3ae..a0bfb48a7e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -684,6 +684,37 @@ int multifd_send_sync_main(QEMUFile *f)
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
+    struct buffer_zero_batch_task *dsa_batch_task = p->dsa_batch_task;
+
+    // Set normal page test hook is disabled.
+    if (multifd_normal_page_ratio > 100) {
+        return;
+    }
+
+    for (int i = 0; i < p->pages->num; i++) {
+        if (dsa_batch_task->normal_page_counter < multifd_normal_page_ratio) {
+            // Turn a zero page into a normal page.
+            dsa_batch_task->results[i] = false;
+        }
+        dsa_batch_task->normal_page_index++;
+        dsa_batch_task->normal_page_counter++;
+
+        if (dsa_batch_task->normal_page_index >= 100) {
+            dsa_batch_task->normal_page_index = 0;
+            dsa_batch_task->normal_page_counter = 0;
+        }
+    }
+}
+
 static void set_page(MultiFDSendParams *p, bool zero_page, uint64_t offset)
 {
     RAMBlock *rb = p->pages->block;
@@ -704,7 +735,8 @@ static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
     assert(!dsa_is_running());
 
     for (int i = 0; i < p->pages->num; i++) {
-        p->dsa_batch_task->results[i] = buffer_is_zero(buf[i], p->page_size);
+        p->dsa_batch_task->results[i] =
+            buffer_is_zero(buf[i], p->page_size);
     }
 }
 
@@ -737,6 +769,8 @@ static void multifd_zero_page_check(MultiFDSendParams *p)
         buffer_is_zero_use_dsa(p);
     }
 
+    multifd_normal_page_test_hook(p);
+
     for (int i = 0; i < p->pages->num; i++) {
         uint64_t offset = p->pages->offset[i];
         bool zero_page = p->dsa_batch_task->results[i];
-- 
2.30.2


