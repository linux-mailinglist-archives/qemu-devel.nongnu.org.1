Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401B98239DA
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:50:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs4-0008K1-52; Wed, 03 Jan 2024 19:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrj-0008Gm-B1
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:45 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrg-0007Pr-P3
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:43 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78106c385a1so2837885a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329139; x=1704933939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdtuMx+hCXHJ7yF7rxR+ZT1nD3kzDEaFEFHB7QDZgpo=;
 b=MnN5OQexPatKr8WHSwcIcu+npqA4K9QJHJf5eY1Tc5XtMta3zWzOTt7IF2z7wui/JF
 LCxtg8mRwBF5PGl1eOHyeecQ7YuMjZJrpjfzihXbROnz4uLwqZ/v5g5JE11Bo5w7PkOD
 ijqLQLMrUxFGCqrJw9+qIzvPzF03Ujq2vR4diA+Z4MwKLUqnqKmIVjsJsqSVzjYjtfOP
 4G5ttDmi2aRrvwM5LxfC3eOV1LC9MNiUfP4Vg4IMGkgmqYpsvFygIKMfEL03yjPNixvP
 LeK1iHVhBV7bPq4eqXWGKPBZ1FRaGz4c7pYvIhQ133OJwzxcUHzx6EZx/K1RqJQS/4w7
 s9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329139; x=1704933939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdtuMx+hCXHJ7yF7rxR+ZT1nD3kzDEaFEFHB7QDZgpo=;
 b=VbLv6SGv1llrJ97V/K40oFzuWMMezqmqCfIXYQpuj8P02RFRzVdLkc41cn1ZLHN9GL
 kAZCVGppwVO3v68NmO68+d/2clKC3TP/IL/nWSiX0x4q6fM7b72ih/KHQimiDjahAldH
 7UZAwW8MeKm3wWWiQLIacrd3/YC1lEsMQmzvsSZktFOB6rLrb1YMMQTZtnLjcHdq48dK
 SN+1csfroIO80nsFEzh9umb92c2wORKCaM56LfjYYn99Ki2K/tJomrvXF8383rr5wbQN
 8B4FH6nNJ0LiXTChLQiuSYVU8Uh+7LXL7ZFohRzPRvKsaNpmUMBk6Yf5XNzPLjX44rCC
 1WIw==
X-Gm-Message-State: AOJu0YzQrg6puiJt0Ajj1VE8w7AXnw9dqgR6D5lMn+lXfsrLGfyjGC8l
 0HdWI9Tt5SBADzAEy2/30yA7u46TeWmLcg==
X-Google-Smtp-Source: AGHT+IE9f5mceRPAF4CSn5istewr74V0Uo7slawDWCgONKZfREhKhA2JFvbKwRAQ/11hek2s1p0Tug==
X-Received: by 2002:a05:620a:229:b0:77d:51cb:de61 with SMTP id
 u9-20020a05620a022900b0077d51cbde61mr19214957qkm.40.1704329139326; 
 Wed, 03 Jan 2024 16:45:39 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:39 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
	Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v3 04/20] So we use multifd to transmit zero pages.
Date: Thu,  4 Jan 2024 00:44:36 +0000
Message-Id: <20240104004452.324068-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72e.google.com
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
 migration/options.c | 17 +++++++++--------
 migration/ram.c     | 45 ++++++++++++++++++++++++++++++++++++++-------
 qapi/migration.json |  1 -
 4 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 756673029d..eece85569f 100644
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
index 0f6bd78b9f..180698a8f5 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -195,6 +195,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
     DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
+    DEFINE_PROP_MIG_CAP("x-main-zero-page",
+            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
     DEFINE_PROP_MIG_CAP("x-background-snapshot",
             MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
 #ifdef CONFIG_LINUX
@@ -288,15 +290,9 @@ bool migrate_multifd(void)
 
 bool migrate_use_main_zero_page(void)
 {
-    /* MigrationState *s; */
-
-    /* s = migrate_get_current(); */
+    MigrationState *s = migrate_get_current();
 
-    /*
-     * We will enable this when we add the right code.
-     * return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
-     */
-    return true;
+    return s->capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
 }
 
 bool migrate_pause_before_switchover(void)
@@ -459,6 +455,7 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
     MIGRATION_CAPABILITY_RETURN_PATH,
     MIGRATION_CAPABILITY_MULTIFD,
+    MIGRATION_CAPABILITY_MAIN_ZERO_PAGE,
     MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
     MIGRATION_CAPABILITY_AUTO_CONVERGE,
     MIGRATION_CAPABILITY_RELEASE_RAM,
@@ -536,6 +533,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not yet compatible with multifd");
             return false;
         }
+        if (new_caps[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE]) {
+            error_setg(errp,
+                    "Postcopy is not yet compatible with main zero copy");
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
index 80c4b13516..4c7a42e364 100644
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


