Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA0AEB64A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 13:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DP-0005On-65; Fri, 27 Jun 2025 07:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7DB-0005Dc-Qy
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D4-0007DW-47
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so14751175e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023531; x=1751628331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6UmG/qOpQ+wr6fHJ9f8B6S5TAjmqDK30lDqng/ncfc=;
 b=UNjD4iGxtC5mZP9SqmI6aIXLPUkUcAmbqOgo864J6z96vjJ4Xj5tI/CfVbjQHDnw6z
 6LR+avtJQaJYRApjLOvtpRaMMhKcMGNLx/WnwlKga5XqrlMFITwlGY3iwXIBBNDfFcli
 ilkHFtG8ffX1aUH4w2q/qf/ccz7/qTuyojhD05KVPOSYGZVVPprCtOeI2b+FAurZ4b+a
 IClkilreIigPsfrA5KVsmzMhfZlEjJck5d8PM11dl99zSZsLvfJLAEliDCTKFgu3cFSZ
 MiH7Hl6gxUFQ0PsRb6UENHDR4tQhT9idzqkC4go6U5XXG0fUFVEYGe00mW+Ifb596DeZ
 6V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023531; x=1751628331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6UmG/qOpQ+wr6fHJ9f8B6S5TAjmqDK30lDqng/ncfc=;
 b=fNk8YashJLT7sXscOV5EKaLF04Ut8FGhatMN5Y3ZyQRa46R1Yy2oyS5qEo0+Mbhwc1
 sC2b679torPfs+vZVE8/ff9CRE8fVBijvOdEdvfXzmVQsK+ZeFW2UOWA9exvfmdQNsNi
 IY/g6jeyHykuawVnu8es0E4MMummqNP+dtImtWn63UNrlfFqFMpDOSlgqZuR2nDRpAVz
 Rp88PDYgg0Rcz7SMisSIat4lNThI+1FlWpDW2PNHpsGbYoEmdvKi+eCuc0mzIk6Jchh0
 9mcz3T3NtlT8lypfKMWWkzibV3X6SSJ+kPVqCWWnPOgMeLiD0vPAKVtUxxoAYJoTKemi
 +iFA==
X-Gm-Message-State: AOJu0Yy8dinFtIoIUJadW4+YiXN6dVAhneH9pdq8JTdmP7ACAv9xsAsd
 JW8X0loW+DNU8je1qYH9rFNvsh9GlI6U8LPNBs+JD5MHmAoJUKNUbX2KlnjLYaR8uPM=
X-Gm-Gg: ASbGncuIrIB6K3GpJLVySxuChg68FCgY5Le/sD1BNNuD0zKlruTkrMocPXhov0rKS1n
 jK9fIM3R0jUWAkBQJtJZwslDzASbP9L9McZ91cMgLQcElQVNuJQMBd33slPxIOIe/AOi62qP4/Q
 mnFHoY+RAONS1HXST9GvNKQutTZhZejhHBxTeezE4kUOp5KUuu1/MD71TG9VA5BwF1B4v5lLuLi
 WQ2jny4oVttkOt6xTRmjEAIpuADFFvibfdxOs/gfq+QBBomcD3RV/CQDXkJpzF4CrT1nK7YR7/+
 7t5CmGK7asfmVkD4zP/iughiiIQkszIWLNsrVlsHTpg4Z7HFW3siCVxToB3qI64=
X-Google-Smtp-Source: AGHT+IH52oYny8bIzT97ubxSqX6q3JJ3jR+zRLAz207VK/d6uf3VquB537sEhM9gKizGFL93PY0uuA==
X-Received: by 2002:a05:600c:34c8:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-4538ee607edmr30762215e9.18.1751023531437; 
 Fri, 27 Jun 2025 04:25:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c800eaasm2489362f8f.37.2025.06.27.04.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4CB6F5F914;
 Fri, 27 Jun 2025 12:25:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 11/15] plugins: Add patcher plugin and test
Date: Fri, 27 Jun 2025 12:25:07 +0100
Message-ID: <20250627112512.1880708-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch adds a plugin that exercises the virtual and hardware memory
read-write API functions added in a previous patch. The plugin takes a
target and patch byte sequence, and will overwrite any instruction
matching the target byte sequence with the patch.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-8-rowanbhart@gmail.com>
[AJB: tweak Makefile, use uintptr_t for pointer stuffing]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/patch.c                 | 251 ++++++++++++++++++++++
 tests/tcg/x86_64/system/patch-target.c    |  22 ++
 tests/tcg/Makefile.target                 |   7 +-
 tests/tcg/plugins/meson.build             |   2 +-
 tests/tcg/x86_64/Makefile.softmmu-target  |   9 +
 tests/tcg/x86_64/system/validate-patch.py |  39 ++++
 6 files changed, 328 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
new file mode 100644
index 0000000000..111c5c1f16
--- /dev/null
+++ b/tests/tcg/plugins/patch.c
@@ -0,0 +1,251 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This plugin patches instructions matching a pattern to a different
+ * instruction as they execute
+ *
+ */
+
+#include "glib.h"
+#include "glibconfig.h"
+
+#include <qemu-plugin.h>
+#include <string.h>
+#include <stdio.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static bool use_hwaddr;
+static GByteArray *target_data;
+static GByteArray *patch_data;
+
+/**
+ * Parse a string of hexadecimal digits into a GByteArray. The string must be
+ * even length
+ */
+static GByteArray *str_to_bytes(const char *str)
+{
+    size_t len = strlen(str);
+
+    if (len == 0 || len % 2 != 0) {
+        return NULL;
+    }
+
+    GByteArray *bytes = g_byte_array_new();
+    char byte[3] = {0};
+    guint8 value = 0;
+
+    for (size_t i = 0; i < len; i += 2) {
+        byte[0] = str[i];
+        byte[1] = str[i + 1];
+        value = (guint8)g_ascii_strtoull(byte, NULL, 16);
+        g_byte_array_append(bytes, &value, 1);
+    }
+
+    return bytes;
+}
+
+static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
+{
+    uintptr_t addr = (uintptr_t) userdata;
+    g_autoptr(GString) str = g_string_new(NULL);
+    g_string_printf(str, "patching: @0x%"
+                    PRIxPTR "\n",
+                    addr);
+    qemu_plugin_outs(str->str);
+
+    enum qemu_plugin_hwaddr_operation_result result =
+        qemu_plugin_write_memory_hwaddr(addr, patch_data);
+
+
+    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
+        g_autoptr(GString) errmsg = g_string_new(NULL);
+        g_string_printf(errmsg, "Failed to write memory: %d\n", result);
+        qemu_plugin_outs(errmsg->str);
+        return;
+    }
+
+    GByteArray *read_data = g_byte_array_new();
+
+    result = qemu_plugin_read_memory_hwaddr(addr, read_data,
+                                            patch_data->len);
+
+    qemu_plugin_outs("Reading memory...\n");
+
+    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
+        g_autoptr(GString) errmsg = g_string_new(NULL);
+        g_string_printf(errmsg, "Failed to read memory: %d\n", result);
+        qemu_plugin_outs(errmsg->str);
+        return;
+    }
+
+    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
+        qemu_plugin_outs("Failed to read back written data\n");
+    }
+
+    qemu_plugin_outs("Success!\n");
+
+    return;
+}
+
+static void patch_vaddr(unsigned int vcpu_index, void *userdata)
+{
+    uintptr_t addr = (uintptr_t) userdata;
+    uint64_t hwaddr = 0;
+    if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
+        qemu_plugin_outs("Failed to translate vaddr\n");
+        return;
+    }
+    g_autoptr(GString) str = g_string_new(NULL);
+    g_string_printf(str, "patching: @0x%"
+                    PRIxPTR " hw: @0x%" PRIx64 "\n",
+                    addr, hwaddr);
+    qemu_plugin_outs(str->str);
+
+    qemu_plugin_outs("Writing memory (vaddr)...\n");
+
+    if (!qemu_plugin_write_memory_vaddr(addr, patch_data)) {
+        qemu_plugin_outs("Failed to write memory\n");
+        return;
+    }
+
+    qemu_plugin_outs("Reading memory (vaddr)...\n");
+
+    g_autoptr(GByteArray) read_data = g_byte_array_new();
+
+    if (!qemu_plugin_read_memory_vaddr(addr, read_data, patch_data->len)) {
+        qemu_plugin_outs("Failed to read memory\n");
+        return;
+    }
+
+    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
+        qemu_plugin_outs("Failed to read back written data\n");
+    }
+
+    qemu_plugin_outs("Success!\n");
+
+    return;
+}
+
+/*
+ * Callback on translation of a translation block.
+ */
+static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    g_autoptr(GByteArray) insn_data = g_byte_array_new();
+    uintptr_t addr = 0;
+
+    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
+
+        if (use_hwaddr) {
+            uint64_t hwaddr = 0;
+            if (!qemu_plugin_translate_vaddr(vaddr, &hwaddr)) {
+                qemu_plugin_outs("Failed to translate vaddr\n");
+                continue;
+            }
+            /*
+             * As we cannot emulate 64 bit systems on 32 bit hosts we
+             * should never see the top bits set, hence we can safely
+             * cast to uintptr_t.
+             */
+            g_assert(hwaddr <= UINTPTR_MAX);
+            addr = (uintptr_t) hwaddr;
+        } else {
+            g_assert(vaddr <= UINTPTR_MAX);
+            addr = (uintptr_t) vaddr;
+        }
+
+        g_byte_array_set_size(insn_data, qemu_plugin_insn_size(insn));
+        qemu_plugin_insn_data(insn, insn_data->data, insn_data->len);
+
+        if (insn_data->len >= target_data->len &&
+            !memcmp(insn_data->data, target_data->data,
+                    MIN(target_data->len, insn_data->len))) {
+            if (use_hwaddr) {
+                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
+                                                     QEMU_PLUGIN_CB_NO_REGS,
+                                                     (void *) addr);
+            } else {
+                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
+                                                     QEMU_PLUGIN_CB_NO_REGS,
+                                                     (void *) addr);
+            }
+        }
+    }
+}
+
+static void usage(void)
+{
+    fprintf(stderr, "Usage: <lib>,target=<bytes>,patch=<new_bytes>"
+            "[,use_hwaddr=true|false]");
+}
+
+/*
+ * Called when the plugin is installed
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+
+    use_hwaddr = true;
+    target_data = NULL;
+    patch_data = NULL;
+
+    if (argc > 4) {
+        usage();
+        return -1;
+    }
+
+    for (size_t i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "use_hwaddr") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &use_hwaddr)) {
+                fprintf(stderr,
+                        "Failed to parse boolean argument use_hwaddr\n");
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "target") == 0) {
+            target_data = str_to_bytes(tokens[1]);
+            if (!target_data) {
+                fprintf(stderr,
+                         "Failed to parse target bytes.\n");
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "patch") == 0) {
+            patch_data = str_to_bytes(tokens[1]);
+            if (!patch_data) {
+                fprintf(stderr, "Failed to parse patch bytes.\n");
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "Unknown argument: %s\n", tokens[0]);
+            usage();
+            return -1;
+        }
+    }
+
+    if (!target_data) {
+        fprintf(stderr, "target argument is required\n");
+        usage();
+        return -1;
+    }
+
+    if (!patch_data) {
+        fprintf(stderr, "patch argument is required\n");
+        usage();
+        return -1;
+    }
+
+    if (target_data->len != patch_data->len) {
+        fprintf(stderr, "Target and patch data must be the same length\n");
+        return -1;
+    }
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
+
+    return 0;
+}
diff --git a/tests/tcg/x86_64/system/patch-target.c b/tests/tcg/x86_64/system/patch-target.c
new file mode 100644
index 0000000000..8c2b6f4ba7
--- /dev/null
+++ b/tests/tcg/x86_64/system/patch-target.c
@@ -0,0 +1,22 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test target increments a value 100 times. The patcher converts the
+ * inc instruction to a nop, so it only increments the value once.
+ *
+ */
+#include <minilib.h>
+
+int main(void)
+{
+    ml_printf("Running test...\n");
+    unsigned int x = 0;
+    for (int i = 0; i < 100; i++) {
+        asm volatile (
+            "inc %[x]"
+            : [x] "+a" (x)
+        );
+    }
+    ml_printf("Value: %d\n", x);
+    return 0;
+}
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 95ff76ea44..af68f11664 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -151,7 +151,12 @@ ifeq ($(CONFIG_PLUGIN),y)
 PLUGIN_SRC=$(SRC_PATH)/tests/tcg/plugins
 PLUGIN_LIB=../plugins
 VPATH+=$(PLUGIN_LIB)
-PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
+# Some plugins need to be disabled for all tests to avoid exponential explosion.
+# For example, libpatch.so only needs to run against the arch-specific patch
+# target test, so we explicitly run it in the arch-specific Makefile.
+DISABLE_PLUGINS=libpatch.so
+PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
+	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 029342282a..61a007d9e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index d3e09708a5..3e30ca9307 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -33,3 +33,12 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
+
+ifeq ($(CONFIG_PLUGIN),y)
+run-plugin-patch-target-with-libpatch.so:		\
+	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
+run-plugin-patch-target-with-libpatch.so:		\
+	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
+run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
+EXTRA_RUNS+=run-plugin-patch-target-with-libpatch.so
+endif
diff --git a/tests/tcg/x86_64/system/validate-patch.py b/tests/tcg/x86_64/system/validate-patch.py
new file mode 100755
index 0000000000..700950eae5
--- /dev/null
+++ b/tests/tcg/x86_64/system/validate-patch.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+#
+# validate-patch.py: check the patch applies
+#
+# This program takes two inputs:
+#   - the plugin output
+#   - the binary output
+#
+# Copyright (C) 2024
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+from argparse import ArgumentParser
+
+def main() -> None:
+    """
+    Process the arguments, injest the program and plugin out and
+    verify they match up and report if they do not.
+    """
+    parser = ArgumentParser(description="Validate patch")
+    parser.add_argument('test_output',
+                        help="The output from the test itself")
+    parser.add_argument('plugin_output',
+                        help="The output from plugin")
+    args = parser.parse_args()
+
+    with open(args.test_output, 'r') as f:
+        test_data = f.read()
+    with open(args.plugin_output, 'r') as f:
+        plugin_data = f.read()
+    if "Value: 1" in test_data:
+        sys.exit(0)
+    else:
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
+
-- 
2.47.2


