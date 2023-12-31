Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2540E820E9C
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 22:23:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK3GD-0001Iw-TX; Sun, 31 Dec 2023 16:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2ut-00078Y-Kp
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:17 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2ur-0007OS-93
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:14 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-781753f52afso273902685a.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 13:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704056410; x=1704661210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgDAcZPCAo2TEHKw7RAzVC63QmD5BA9tquuYbmv13q8=;
 b=R5hqspMLVnxKAy75AGhAxozatZ3OTZLStrsg9K8g/ICVgMczn6m22+rsPC6TdF09RO
 4eZg4LpyOxSNyRaNCLvIOfqlsGofuBNWRJ+wDBRhOUUgfQPMwyzyPLVPK/bUH6HI/Rzc
 bmuzgUhhYF1Og0/TGK3yqKcx2/y/MsNsS9ctCMmxu+Zxz3Do3BJ2IL6MCGkMuMh3mkv9
 R244dBZzrzxK9WPMZkx2qK5Pm/R0jlX92zo4+H+18pCGOHTxoSYhTVDPxRMTxVZaY29a
 Tc+9Rgm8zaD3OjoLcFjYhHAvmllJJ4GSTF+GSG1A0weqIir6cmzdzDI+2CTuVjoKBLqc
 BDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704056410; x=1704661210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgDAcZPCAo2TEHKw7RAzVC63QmD5BA9tquuYbmv13q8=;
 b=CPuraxV85VBqeqvGYHlwvRu9hGG1OTUd7rUpv50aijjJCwWq34LwT2/tZLrQ6yFMIR
 Obr/vaSeswRVlmJSPauAaLNhkVYpKexwjZFVevn+BAbMAdE85TolM/nrS8FGlaUwClxZ
 LZVazT+46Ejl7CKYx6h3iGPfbp8c8jvcz4EQuyA9irf4BedaRpCeLqHXMVdAV4sAjjIE
 5TBs1aJLeGVTgIMZPQvqajQCLa8QKhCsVFfMCLb+REvTuGuvr5H7/yftmtbir4i7JEu9
 +jGfVEf4JGIA4EG5bVpMpskQEFu8C+LHXR8/6P5/QWrZtfafKg6MLd+pNzG1+C8jtzyj
 NV/A==
X-Gm-Message-State: AOJu0YwUMFh8+myMHjhP/qlCsLuFHwbYrCJaHolGMd0KAFG85tLZxo2A
 SsNC68sIOlw54NEucgikESACY5+iFixG6h1tezPMhyDvw/Y=
X-Google-Smtp-Source: AGHT+IFRVQdZuGK55MEDEqf4lIq/P/CKi91beolpQ8cnDNp64jaxP5FCfZ/km67ldmanxAQeoQ9+HQ==
X-Received: by 2002:a05:620a:5596:b0:77d:98aa:f7d3 with SMTP id
 vq22-20020a05620a559600b0077d98aaf7d3mr18338804qkn.13.1704056410335; 
 Sun, 31 Dec 2023 13:00:10 -0800 (PST)
Received: from n36-186-108.byted.org. ([147.160.184.90])
 by smtp.gmail.com with ESMTPSA id
 pb21-20020a05620a839500b007811da87cefsm8111750qkn.127.2023.12.31.13.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 13:00:10 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 peterx@redhat.com, quintela@redhat.com, peter.maydell@linaro.org,
 hao.xiang@bytedance.com
Cc: bryan.zhang@bytedance.com
Subject: [PATCH 3/5] migration: Introduce unimplemented 'qatzip' compression
 method
Date: Sun, 31 Dec 2023 20:58:02 +0000
Message-Id: <20231231205804.2366509-4-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Dec 2023 16:22:09 -0500
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

Adds support for 'qatzip' as an option for the multifd compression
method parameter, but copy-pastes the no-op logic to leave the actual
methods effectively unimplemented. This is in preparation of a
subsequent commit that will implement actually using QAT for compression
and decompression.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 hw/core/qdev-properties-system.c |  6 ++-
 migration/meson.build            |  1 +
 migration/multifd-qatzip.c       | 81 ++++++++++++++++++++++++++++++++
 migration/multifd.h              |  1 +
 qapi/migration.json              |  5 +-
 5 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..d8e48dcb0e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -658,7 +658,11 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd",
+                   "none/zlib/zstd"
+#ifdef CONFIG_QATZIP
+                   "/qatzip"
+#endif
+                   ,
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..e20f318379 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
   system_ss.add(files('block.c'))
 endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
+system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
new file mode 100644
index 0000000000..1733bbddb7
--- /dev/null
+++ b/migration/multifd-qatzip.c
@@ -0,0 +1,81 @@
+/*
+ * Multifd QATzip compression implementation
+ *
+ * Copyright (c) Bytedance
+ *
+ * Authors:
+ *  Bryan Zhang <bryan.zhang@bytedance.com>
+ *  Hao Xiang   <hao.xiang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/ramblock.h"
+#include "exec/target_page.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "options.h"
+#include "multifd.h"
+
+static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    return 0;
+}
+
+static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp) {};
+
+static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    MultiFDPages_t *pages = p->pages;
+
+    for (int i = 0; i < p->normal_num; i++) {
+        p->iov[p->iovs_num].iov_base = pages->block->host + p->normal[i];
+        p->iov[p->iovs_num].iov_len = p->page_size;
+        p->iovs_num++;
+    }
+
+    p->next_packet_size = p->normal_num * p->page_size;
+    p->flags |= MULTIFD_FLAG_NOCOMP;
+    return 0;
+}
+
+static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    return 0;
+}
+
+static void qatzip_recv_cleanup(MultiFDRecvParams *p) {};
+
+static int qatzip_recv_pages(MultiFDRecvParams *p, Error **errp)
+{
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+
+    if (flags != MULTIFD_FLAG_NOCOMP) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_NOCOMP);
+        return -1;
+    }
+    for (int i = 0; i < p->normal_num; i++) {
+        p->iov[i].iov_base = p->host + p->normal[i];
+        p->iov[i].iov_len = p->page_size;
+    }
+    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+}
+
+static MultiFDMethods multifd_qatzip_ops = {
+    .send_setup = qatzip_send_setup,
+    .send_cleanup = qatzip_send_cleanup,
+    .send_prepare = qatzip_send_prepare,
+    .recv_setup = qatzip_recv_setup,
+    .recv_cleanup = qatzip_recv_cleanup,
+    .recv_pages = qatzip_recv_pages
+};
+
+static void multifd_qatzip_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip_ops);
+}
+
+migration_init(multifd_qatzip_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..5600f7fc82 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -33,6 +33,7 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
+#define MULTIFD_FLAG_QATZIP (3 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index 6d5a4b0489..e3cc195aed 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -625,11 +625,14 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qatzip: use qatzip compression method.
+#
 # Since: 5.0
 ##
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
-            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
+            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
+            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'} ] }
 
 ##
 # @MigMode:
-- 
2.30.2


