Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4352277E2EF
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 15:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWGoH-0003ZB-Mf; Wed, 16 Aug 2023 09:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWGoF-0003Vf-Ks
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 09:43:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWGoC-0002IU-PQ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 09:43:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bdbbede5d4so43340375ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692193415; x=1692798215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ooo/7eLq9itYFqdnqUN26ru787FfDZXdivlCemb0cOg=;
 b=nUCDKArRqGVbsQ5Hzgmhfkz/hmvo0+n5RwjsRc7Z4L3wS3WM5LI8pU1rAnoXgYjQ/C
 qgcHFW+hduDk59OOH7wC4kpT7/8zx95VUr+QaMi2Mkp5T+uBA2rhjqWf0YIgcP653JNr
 gucC/qMFsgzP5g7Sg3GtgvFjOBOQjxpYw9OEa7XiwpYl7k5SpaP990iVPITwzURCcReX
 TqS/EM+LIhaDXY5m8NVO5EpnXZnHl/FlbSN8sbSh8mBHc5D9yxJTqaQs8/Peg6sFU6JE
 BF+pkG4mGUQp1SznvCBCk6y/8Ep2MnLmaAMy61u7+RPPxCD2MbtXSImspPfxeMo2wK7+
 7Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692193415; x=1692798215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ooo/7eLq9itYFqdnqUN26ru787FfDZXdivlCemb0cOg=;
 b=W+Mu0pZ4xL+NjNnNQyYUOvl3i+cslNSxdIkdZe7+6IAcezIYSLg0cZsYeheK6EkSRJ
 rkFf7xHeHBVOpxwPbUd6HiolUV0sVyPTyx08WBcbwTL6a9dqdi3DlUGIZCINfRVNeLDo
 umcawltg+Vwz08ObzzE99q1qgWXlE40Dar9a1xrUNKXriIOfXIbHkgr4fpQmwLnq1cgj
 Zsp8ZmaXpu7BHh3Vy+iPDS9sEn8QhzTZ3f/2VlIVuLj4TIQ86m8OmzDdaMfWPkWjvE3+
 2XM7hturILs/krMWHaT8F5lyNpJuz2BPlFX8Upi0ik5+o92HBv490iKZLSqOHZUJf+M2
 UELQ==
X-Gm-Message-State: AOJu0YzBu09GI1F/DZWrdacR+OhBV8p9cDmMzzblZR+jaxOZpkxZGYs9
 DM+flA/anR2Z6zLIPLkLELHcqg==
X-Google-Smtp-Source: AGHT+IGkKU+IfbA472bMTeH6Mvj9KprIuL9ogHkQ1onVBuXRaR0W0TdVChFbo8Xp605UBo2c1Gsyaw==
X-Received: by 2002:a17:902:7798:b0:1bd:d6b5:a54f with SMTP id
 o24-20020a170902779800b001bdd6b5a54fmr2066959pll.55.1692193415283; 
 Wed, 16 Aug 2023 06:43:35 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a637b43000000b0056601f864aesm928355pgn.2.2023.08.16.06.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 06:43:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 22/25] plugins: Allow to read registers
Date: Wed, 16 Aug 2023 22:39:32 +0900
Message-ID: <20230816133938.18310-23-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816133938.18310-1-akihiko.odaki@daynix.com>
References: <20230816133938.18310-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is based on GDB protocol to ensure interface stability.

The timing of the vcpu init hook is also changed so that the hook will
get called after GDB features are initialized.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/qemu-plugin.h   | 65 ++++++++++++++++++++++++++++++++++--
 plugins/api.c                | 40 ++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..214b12bfd6 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_QEMU_PLUGIN_H
 #define QEMU_QEMU_PLUGIN_H
 
+#include <glib.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include <stddef.h>
@@ -51,7 +52,7 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -218,8 +219,8 @@ struct qemu_plugin_insn;
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
  *
- * Note: currently unused, plugins cannot read or change system
- * register state.
+ * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
+ * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
@@ -664,4 +665,62 @@ uint64_t qemu_plugin_end_code(void);
  */
 uint64_t qemu_plugin_entry_code(void);
 
+/**
+ * struct qemu_plugin_register_file_t - register information
+ *
+ * This structure identifies registers. The identifiers included in this
+ * structure are identical with names used in GDB's standard target features
+ * with some extensions. For details, see:
+ * https://sourceware.org/gdb/onlinedocs/gdb/Standard-Target-Features.html
+ *
+ * A register is uniquely identified with the combination of a feature name
+ * and a register name or a register number. It is recommended to derive
+ * register numbers from feature names and register names each time a new vcpu
+ * starts.
+ *
+ * To derive the register number from a feature name and a register name,
+ * first look up qemu_plugin_register_file_t with the feature name, and then
+ * look up the register name in its @regs. The sum of the @base_reg and the
+ * index in the @reg is the register number.
+ *
+ * Note that @regs may have holes; some elements of @regs may be NULL.
+ */
+typedef struct qemu_plugin_register_file_t {
+    /** @name: feature name */
+    const char *name;
+    /** @regs: register names */
+    const char * const *regs;
+    /** @base_reg: the base identified number */
+    int base_reg;
+    /** @num_regs: the number of elements in @regs */
+    int num_regs;
+} qemu_plugin_register_file_t;
+
+/**
+ * qemu_plugin_get_register_files() - returns register information
+ *
+ * @vcpu_index: the index of the vcpu context
+ * @size: the pointer to the variable to hold the number of returned elements
+ *
+ * Returns an array of qemu_plugin_register_file_t. The user should g_free()
+ * the array once no longer needed.
+ */
+qemu_plugin_register_file_t *
+qemu_plugin_get_register_files(unsigned int vcpu_index, int *size);
+
+/**
+ * qemu_plugin_read_register() - read register
+ *
+ * @buf: the byte array to append the read register content to.
+ * @reg: the register identifier determined with
+ *       qemu_plugin_get_register_files().
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order.
+ */
+int qemu_plugin_read_register(GByteArray *buf, int reg);
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 2078b16edb..dd7ff5067b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -35,6 +35,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
 #include "tcg/tcg.h"
@@ -442,3 +443,42 @@ uint64_t qemu_plugin_entry_code(void)
 #endif
     return entry;
 }
+
+static void count_gdb_feature(void *opaque, const GDBFeature *feature,
+                              int base_reg)
+{
+    (*(int *)opaque)++;
+}
+
+static void map_gdb_feature(void *opaque, const GDBFeature *feature,
+                            int base_reg)
+{
+    qemu_plugin_register_file_t **cursor = opaque;
+    (*cursor)->name = feature->name;
+    (*cursor)->regs = feature->regs;
+    (*cursor)->base_reg = base_reg;
+    (*cursor)->num_regs = feature->num_regs;
+    (*cursor)++;
+}
+
+qemu_plugin_register_file_t *
+qemu_plugin_get_register_files(unsigned int vcpu_index, int *size)
+{
+    QEMU_IOTHREAD_LOCK_GUARD();
+
+    *size = 0;
+    gdb_foreach_feature(qemu_get_cpu(vcpu_index), count_gdb_feature, size);
+
+    qemu_plugin_register_file_t *files =
+        g_new(qemu_plugin_register_file_t, *size);
+
+    qemu_plugin_register_file_t *cursor = files;
+    gdb_foreach_feature(qemu_get_cpu(vcpu_index), map_gdb_feature, &cursor);
+
+    return files;
+}
+
+int qemu_plugin_read_register(GByteArray *buf, int reg)
+{
+    return gdb_read_register(current_cpu, buf, reg, true);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549..4ed9e70e47 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -42,4 +42,6 @@
   qemu_plugin_tb_vaddr;
   qemu_plugin_uninstall;
   qemu_plugin_vcpu_for_each;
+  qemu_plugin_get_register_files;
+  qemu_plugin_read_register;
 };
-- 
2.41.0


