Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5B76C8B6
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR7YT-0002lC-W6; Wed, 02 Aug 2023 04:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR7YQ-0002Sg-LY
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:50:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR7YM-0000HY-8Y
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:50:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686efb9ee0cso6345707b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 01:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690966197; x=1691570997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfIfeQaWJxnPxlVo3FqUH9rpNdT3zJyqvDQZ+p6vZ28=;
 b=oxIsKd3b0mKv/An/9BI/xVIplHD4gnHI9aDAI3Sv9qeRG4zDDcHmuoQO0Q5HOP2fVz
 P/mrjpwWwyXyAMrxgSx6fzxRhJNOeqe6cM77A72pDvc5mZHRCj6PV0QzKQ0QNNCVuxvL
 bN1yfOPwXQXZZNirYivOmTTlD2J5FCicF0ZQZSvBOEWWhxbuf9kMf/IrI4jowgT291Vp
 +NUT7bNR9lI9KTOXrDeLl8K9yKCnDtRA60E9LrhHuSsJjHhs3bEeqoR10mJuMxULyc1W
 uiCnyGUozyF1EQ5ytelUc2d6Phk54nHXs0WXuRFMYJoLu3/nyMosFTs6Z4e2uBWGJWD4
 7XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690966197; x=1691570997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfIfeQaWJxnPxlVo3FqUH9rpNdT3zJyqvDQZ+p6vZ28=;
 b=fkopIDbcCtG+1RTtg/9NnuKS9/ZFkeiHGAEPjKyILS5pedjcmGFXCSiRDR5zHuw031
 JTDlijltGJs8AVsDUY06/BPBjgWLvW0EvI2YPhxuhlIaBJl+untFvI5WAeeTwhlxMr4u
 EVZ7NWeB0AyyZRQi20/uA1GbU6rwybjQ7hecIgT82vi0ta3Rdpxqg/AqwWBtZCWZ7woQ
 B2gW3ttrcXCfX+zuZHIT/5Buwdkcs4c/U8wwZqWU6ci+oeomuo/RXsfe6aj6czwtbzRj
 euBa5ZM3TWohsZUPFQqOycAFm0J7sk/B4yW1C6oxHX+h2s/sAN9+MLtOoqf0/qBrwgOH
 9pIQ==
X-Gm-Message-State: ABy/qLZ7Ww1+aIo3SZZnE/BxZtgxcE+vMfzEo3SZdr/B+LWW3+xMLaOM
 WGDak3wQUf2+X0dxqqz7MYEzvw==
X-Google-Smtp-Source: APBJJlHy8SEY12BHWlQDHfGBH7m0AWrju65mWCO8TNxFTeolKNPjwm8lznyCbrEMQYCdPOryP5UuSQ==
X-Received: by 2002:a05:6a00:1795:b0:64d:46b2:9a58 with SMTP id
 s21-20020a056a00179500b0064d46b29a58mr18867563pfg.26.1690966197043; 
 Wed, 02 Aug 2023 01:49:57 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 j22-20020aa79296000000b00659b8313d08sm10592860pfa.78.2023.08.02.01.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 01:49:56 -0700 (PDT)
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
Subject: [PATCH v2 21/24] plugins: Allow to read registers
Date: Wed,  2 Aug 2023 17:46:09 +0900
Message-ID: <20230802084614.23619-22-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802084614.23619-1-akihiko.odaki@daynix.com>
References: <20230802084614.23619-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 cpu.c                        | 11 ------
 hw/core/cpu-common.c         | 10 ++++++
 plugins/api.c                | 40 ++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 5 files changed, 114 insertions(+), 14 deletions(-)

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
diff --git a/cpu.c b/cpu.c
index 1c948d1161..2552c85249 100644
--- a/cpu.c
+++ b/cpu.c
@@ -42,7 +42,6 @@
 #include "hw/core/accel-cpu.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
-#include "qemu/plugin.h"
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
@@ -148,11 +147,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
-    /* Plugin initialization must wait until cpu_index assigned. */
-    if (tcg_enabled()) {
-        qemu_plugin_vcpu_init_hook(cpu);
-    }
-
 #ifdef CONFIG_USER_ONLY
     assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
            qdev_get_vmsd(DEVICE(cpu))->unmigratable);
@@ -179,11 +173,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     }
 #endif
 
-    /* Call the plugin hook before clearing cpu->cpu_index in cpu_list_remove */
-    if (tcg_enabled()) {
-        qemu_plugin_vcpu_exit_hook(cpu);
-    }
-
     cpu_list_remove(cpu);
     /*
      * Now that the vCPU has been removed from the RCU list, we can call
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 549f52f46f..e06a70007a 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -211,6 +211,11 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
+    /* Plugin initialization must wait until the cpu is fully realized. */
+    if (tcg_enabled()) {
+        qemu_plugin_vcpu_init_hook(cpu);
+    }
+
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
@@ -218,6 +223,11 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
 
+    /* Call the plugin hook before clearing the cpu is fully unrealized */
+    if (tcg_enabled()) {
+        qemu_plugin_vcpu_exit_hook(cpu);
+    }
+
     /* NOTE: latest generic point before the cpu is fully unrealized */
     cpu_exec_unrealizefn(cpu);
 }
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


