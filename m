Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381937EAA2C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:43:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBD-0007B4-Fi; Tue, 14 Nov 2023 00:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBA-0007AW-HA
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:40 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mB8-0001Rk-5P
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:40 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778927f2dd3so268541385a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940497; x=1700545297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Nmx9BzmrBNJxBIGmirn1Vxg5B7bMVOoZGw0h67pPtY=;
 b=MoHKJF9lW0d811oRA3mzAXcEdCSso6A6p5z9x/4Ugi4gPOBshpEpk75Pt+wfiVnOEn
 yU0NaGBR/GPsxhCZ4udaY49KC5H0ESDzXQ4XSlrb6BaN0zIlq+a2srxxiAe+L3rQsg6l
 1hVpj3eL+NqZV0+hcL5u5sE2k9y2vHNTA4ATnuzsmCCzbW32xbn2D8tDQoxUGZM76gS3
 ZAYpwzukddIr8l1255MZBKUN3I+rtCQO+tNTFnRskR9L8xP9mP/WaUyTbyZtAXZCdsbG
 onPk2x1p+nOH+EGf+qjf3cYYDp97CeLl/2Tx0Sn34DGT5Eh8WbUswcseaQX63ClMpaQL
 18jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940497; x=1700545297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Nmx9BzmrBNJxBIGmirn1Vxg5B7bMVOoZGw0h67pPtY=;
 b=QHuA/F+JAnTYWAhme3fCXBHpxClS8I9TkCV9QvvWKHaEPfkLff/5pZwjqrlUBOiSHy
 sjuquEbIWnV8Lb1vXyQ3yvGRbEYP40dlDNG9ksvUwQd/2iHYcGn1Zx6QpBJQb05thg1Y
 JPcM4r/V6oje0/oyHW5himwNXYkzJalZ+0nehuCuBUoGqu3fCRBpq8TpK4Gdkf2pBhlx
 cbc3Ri2LkXq96640KwL5IZkH+ElPrCoqCDmORYn5IySU5OwC8x62adk3/pNs2mSmXsSw
 vjf8B+TktradRv2uK4SyLXcEkHVm74XT2m1H1g88FyW9wgH2lpKcU+6/beibZPX6TW0U
 SZBA==
X-Gm-Message-State: AOJu0YwTTCfIa7QRzm2bMGxN55fwpd0TmVBZ50/jCIxFqAt1Tb97k5bd
 Rv+Asi+KfV+3D8Xo+fZdmEX/lA==
X-Google-Smtp-Source: AGHT+IHF6WtckOoHIkPzxrodqYoZXm45X5ILsL/ALx/rVgjVpPptR2LHeg8c1/Yah86qG1rBVC77jw==
X-Received: by 2002:ae9:c314:0:b0:76f:93e:4b2f with SMTP id
 n20-20020ae9c314000000b0076f093e4b2fmr1118983qkg.38.1699940497313; 
 Mon, 13 Nov 2023 21:41:37 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:37 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 04/20] So we use multifd to transmit zero pages.
Date: Tue, 14 Nov 2023 05:40:16 +0000
Message-Id: <20231114054032.1192027-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x733.google.com
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

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Leonardo Bras <leobras@redhat.com>
---
 migration/multifd.c |  7 ++++---
 migration/options.c | 13 +++++++------
 migration/ram.c     | 45 ++++++++++++++++++++++++++++++++++++++-------
 qapi/migration.json |  1 -
 4 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 1b994790d5..1198ffde9c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
+#include "qemu/cutils.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
@@ -459,7 +460,6 @@ static int multifd_send_pages(QEMUFile *f)
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
-
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
@@ -684,7 +684,7 @@ static void *multifd_send_thread(void *opaque)
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
     /* qemu older than 8.2 don't understand zero page on multifd channel */
-    bool use_zero_page = !migrate_use_main_zero_page();
+    bool use_multifd_zero_page = !migrate_use_main_zero_page();
     int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
 
@@ -713,6 +713,7 @@ static void *multifd_send_thread(void *opaque)
             RAMBlock *rb = p->pages->block;
             uint64_t packet_num = p->packet_num;
             uint32_t flags;
+
             p->normal_num = 0;
             p->zero_num = 0;
 
@@ -724,7 +725,7 @@ static void *multifd_send_thread(void *opaque)
 
             for (int i = 0; i < p->pages->num; i++) {
                 uint64_t offset = p->pages->offset[i];
-                if (use_zero_page &&
+                if (use_multifd_zero_page &&
                     buffer_is_zero(rb->host + offset, p->page_size)) {
                     p->zero[p->zero_num] = offset;
                     p->zero_num++;
diff --git a/migration/options.c b/migration/options.c
index 00c0c4a0d6..97d121d4d7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -195,6 +195,7 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
     DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
+    DEFINE_PROP_MIG_CAP("x-main-zero-page", MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
     DEFINE_PROP_MIG_CAP("x-background-snapshot",
             MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
 #ifdef CONFIG_LINUX
@@ -288,13 +289,9 @@ bool migrate_multifd(void)
 
 bool migrate_use_main_zero_page(void)
 {
-    //MigrationState *s;
-
-    //s = migrate_get_current();
+    MigrationState *s = migrate_get_current();
 
-    // We will enable this when we add the right code.
-    // return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
-    return true;
+    return s->capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
 }
 
 bool migrate_pause_before_switchover(void)
@@ -457,6 +454,7 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
     MIGRATION_CAPABILITY_RETURN_PATH,
     MIGRATION_CAPABILITY_MULTIFD,
+    MIGRATION_CAPABILITY_MAIN_ZERO_PAGE,
     MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
     MIGRATION_CAPABILITY_AUTO_CONVERGE,
     MIGRATION_CAPABILITY_RELEASE_RAM,
@@ -534,6 +532,9 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not yet compatible with multifd");
             return false;
         }
+        if (new_caps[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE]) {
+            error_setg(errp, "Postcopy is not yet compatible with main zero copy");
+        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
diff --git a/migration/ram.c b/migration/ram.c
index 8c7886ab79..f7a42feff2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2059,17 +2059,42 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
     if (save_zero_page(rs, pss, offset)) {
         return 1;
     }
-
     /*
-     * Do not use multifd in postcopy as one whole host page should be
-     * placed.  Meanwhile postcopy requires atomic update of pages, so even
-     * if host page size == guest page size the dest guest during run may
-     * still see partially copied pages which is data corruption.
+     * Do not use multifd for:
+     * 1. Compression as the first page in the new block should be posted out
+     *    before sending the compressed page
+     * 2. In postcopy as one whole host page should be placed
      */
-    if (migrate_multifd() && !migration_in_postcopy()) {
+    if (!migrate_compress() && migrate_multifd() && !migration_in_postcopy()) {
+        return ram_save_multifd_page(pss->pss_channel, block, offset);
+    }
+
+    return ram_save_page(rs, pss);
+}
+
+/**
+ * ram_save_target_page_multifd: save one target page
+ *
+ * Returns the number of pages written
+ *
+ * @rs: current RAM state
+ * @pss: data about the page we want to send
+ */
+static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
+{
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
+    int res;
+
+    if (!migration_in_postcopy()) {
         return ram_save_multifd_page(pss->pss_channel, block, offset);
     }
 
+    res = save_zero_page(rs, pss, offset);
+    if (res > 0) {
+        return res;
+    }
+
     return ram_save_page(rs, pss);
 }
 
@@ -2982,9 +3007,15 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
-    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+
+    if (migrate_multifd() && !migrate_use_main_zero_page()) {
+        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
+    } else {
+        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+    }
 
     qemu_mutex_unlock_iothread();
+
     ret = multifd_send_sync_main(f);
     qemu_mutex_lock_iothread();
     if (ret < 0) {
diff --git a/qapi/migration.json b/qapi/migration.json
index 09e4393591..9783289bfc 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -531,7 +531,6 @@
 #     and can result in more stable read performance.  Requires KVM
 #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
-#
 # @main-zero-page: If enabled, the detection of zero pages will be
 #                  done on the main thread.  Otherwise it is done on
 #                  the multifd threads.
-- 
2.30.2


