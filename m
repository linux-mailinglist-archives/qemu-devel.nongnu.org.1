Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C376E6CB
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWTc-0003PS-0J; Thu, 03 Aug 2023 07:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRWTW-0003Nc-Ea
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:26:38 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRWTO-0007Nk-Q5
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:26:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 62112C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1691061988; bh=xBDOqP9s1nriIwIVrKfZDadALxLZQVscglrGJWfoiFk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ZlAmOUjPE8MjEey0b/6cqxo9gZG5/OjmPeH3Y61lnLB4WXCIQ8ZrFooQS10hssEmI
 gU5q4kBuTlACWxRgdTLGa5aRUBlkvkI3wA8ooJYSsawAtOeXeT6nvo8hserUUNMmIS
 1IeCKhvUV8XoP06uQDozCjQzaLl2RYCITapoJ8VYLdFKYbxRRjz7xspH7NxG30L0o0
 5IAIN9xc9lb9VQa3g80zr/qjjLJjo0QPhuRTFx46x9iuz65aL3Ifl1aOsoBB/B18C9
 /lTBy6o3ZXWMkGnlcn+SizQaDwFIQ8kPlk4B8eSNTzykKBsjzwiDCNxHsrVs4qPP2N
 M9bXO8EHFQgxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1691061988; bh=xBDOqP9s1nriIwIVrKfZDadALxLZQVscglrGJWfoiFk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=s31qcZhbsj3s/8nUDnTnFSHLjC/9tNTVq3Qoxh8ijFpBifVRjo0zLNfFFk20gZqh8
 WXnyMJtBmedWJnL+Ij9EOSNdgxUsYeX7bk8+clD2Ct3ysl5FxC2/x/AKR7FJsLJpAY
 CgY2A9iZ1n1VS+PgG7xUBptYIhJgnlZiLacTHS5oZY6MlRb3xRjyhZivSbbAemYmvs
 vWhzm2JDsqfAWeQFAl1BM/KunTUDcE5vVi6MzPanIjLsuIt67Ay+dz4PPwXZHxyH4+
 CCAOHavB6UzOAJZYI+tQy53NUy/t2RExeWUGHoyr6O4QJdscshi8HpMXNuE5kLgn+m
 c6oqurLbInJwg==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <alex.bennee@linaro.org>, Aleksandr Anenkov <a.anenkov@yadro.com>
Subject: [PATCH] Add api to read CPU registers in TCG plugins
Date: Thu, 3 Aug 2023 14:25:50 +0300
Message-ID: <20230803112551.14803-1-m.tyutin@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Aleksandr Anenkov <a.anenkov@yadro.com>

This commit:
- adds a plugin API to read the registers of the current CPU
- introduces qemu_plugin_reg_ctx structure for faster data gathering of
  a set of registers without memory reallocation
- adds an example plugin showing how to work with this API
- fixes for GDB that read wrong register 'eflags' value
- minor performance improvements when reading registers from GDB

In this commit, we rely on the already written register
reading code that QEMU for GDB has.

Why is the GDB code used
Each CPU architecture contains its own set of registers.
At the same time, QEMU does not contain a unified code architecture
for working with registers in various CPU architectures.
Each implementation of the CPU architecture in QEMU locates, reads,
and writes registers differently. In addition, each register has
its own specifics for reading and writing. Fortunately,
the GDB part of QEMU code already contains something unified
and complete. So in terms of simplicity and minimal code
changes of QEMU, we're just reusing what's already in GDB.
It works without having to run the GDB server.

How it works
The existing GDB code in QEMU already knows how to read registers
by register number, but cannot do it by register name.
QEMU has xml files using GDB Target Description Format to describe
targets sourceware.org/gdb/onlinedocs/gdb/Target-Description-Format.html
from where GDB gets information about all registers. It only remained
to "teach" QEMU to read register names from these files the way GDB
itself does it and remember them in order to convert back to numbers
from the user API.

Signed-off-by: Aleksandr Anenkov <a.anenkov@yadro.com>
---
 contrib/plugins/Makefile     |   1 +
 contrib/plugins/registers.c  | 231 +++++++++++++++++++++++++++++
 gdb-xml/i386-32bit.xml       |   9 ++
 gdb-xml/i386-64bit.xml       |  17 +++
 gdbstub/gdbstub.c            | 280 +++++++++++++++++++++++++++++++++--
 include/exec/gdbstub.h       |  36 +++++
 include/hw/core/cpu.h        |   3 +
 include/qemu/qemu-plugin.h   | 105 ++++++++++++-
 plugins/api.c                | 223 ++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  10 ++
 target/arm/cpu.c             |   2 +
 target/arm/gdbstub.c         |   2 +-
 target/i386/cpu.c            |   6 +-
 target/i386/gdbstub.c        |  25 +++-
 target/riscv/cpu.c           |   3 +
 target/riscv/gdbstub.c       |   3 +-
 16 files changed, 933 insertions(+), 23 deletions(-)
 create mode 100644 contrib/plugins/registers.c

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index b2b9db9f51..e14c07ddcc 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -21,6 +21,7 @@ NAMES += lockstep
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
+NAMES += registers
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/contrib/plugins/registers.c b/contrib/plugins/registers.c
new file mode 100644
index 0000000000..ae40a27f5f
--- /dev/null
+++ b/contrib/plugins/registers.c
@@ -0,0 +1,231 @@
+/*
+ * Log register states
+ *
+ * Copyright (c) 2022 YADRO.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <glib.h>
+#include <inttypes.h>
+#include <stdlib.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* Print report to file every N instructions */
+#define REPORT_BUF_N_INSN 1000000
+
+typedef enum target_t {
+    UNKNOWN_TARGET,
+    X86_64_TARGET,
+    RISCV64_TARGET
+} target_t;
+
+target_t target = UNKNOWN_TARGET;
+bool system_emulation = false;
+
+const char *const X86_64_REGS[] = { "rax", "rbx", "rcx", "rdx", "rsi", "rdi",
+                                    "rbp", "rsp", "rip", "eflags", "xmm0", "ymm0h" };
+const char *const RISCV64_REGS[] = { "zero", "ra", "sp", "gp", "tp", "t0",
+                                     "a0", "a1", "ft0", "vstart" };
+
+/*
+ * Each vcpu has its own independent data set, which is only initialized once
+ */
+typedef struct vcpu_cache {
+    struct qemu_plugin_reg_ctx *reg_ctx;
+    GString *report;
+    size_t report_counter;
+    unsigned int vcpu_index;
+} vcpu_cache;
+
+vcpu_cache *caches = NULL;
+
+static void print_register_values(GString *report, const void *data, size_t size)
+{
+    if (size == 4) {
+        g_string_append_printf(report, "%08x", *(uint32_t *)data);
+    }
+    else if (size == 8) {
+        g_string_append_printf(report, "%016" PRIx64, *(uint64_t *)data);
+    }
+    else if (size % sizeof(uint64_t) == 0) {
+        const uint64_t *vec = (uint64_t *)data;
+        int i, vec_length = size / sizeof(uint64_t);
+        for (i = 0; i < vec_length; i++) {
+            g_string_append_printf(report, "%016" PRIx64 " ", vec[i]);
+        }
+    }
+    else {
+        qemu_plugin_outs("Unknown register\n");
+        exit(EXIT_FAILURE);
+    }
+}
+
+static void print_avail_register_names(vcpu_cache *cache)
+{
+    char *buf = NULL;
+    size_t buf_size = 0, bytes_written = 0;
+
+    buf_size = qemu_plugin_get_available_reg_names(NULL, 0);
+    g_assert(buf_size > 0);
+
+    buf = g_new0(char, buf_size);
+    bytes_written = qemu_plugin_get_available_reg_names(buf, buf_size);
+    g_assert(bytes_written == buf_size);
+
+    g_string_append_printf(cache->report, "vcpu=%u, available registers: %s", cache->vcpu_index, buf);
+    g_string_append_printf(cache->report, "\n");
+    g_free(buf);
+}
+
+static void init_vcpu_cache(unsigned int vcpu_index, vcpu_cache *cache)
+{
+    if (cache->reg_ctx != NULL)
+        return;
+
+    cache->report = g_string_new("");
+    cache->report_counter = 0;
+    cache->vcpu_index = vcpu_index;
+
+    print_avail_register_names(cache);
+
+    if (target == X86_64_TARGET) {
+        cache->reg_ctx = qemu_plugin_reg_create_context(X86_64_REGS,
+            sizeof(X86_64_REGS) / sizeof(X86_64_REGS[0]));
+    }
+    else if (target == RISCV64_TARGET) {
+        cache->reg_ctx = qemu_plugin_reg_create_context(RISCV64_REGS,
+            sizeof(RISCV64_REGS) / sizeof(RISCV64_REGS[0]));
+    }
+    else {
+        g_assert_not_reached();
+    }
+
+    if (cache->reg_ctx == NULL) {
+        qemu_plugin_outs("Failed to create context\n");
+        exit(EXIT_FAILURE);
+    }
+}
+
+static void free_vcpu_cache(vcpu_cache *cache)
+{
+    if (cache == NULL)
+        return;
+
+    if (cache->report)
+        g_string_free(cache->report, true);
+    qemu_plugin_reg_free_context(cache->reg_ctx);
+}
+
+/**
+ * Log registers on instruction execution
+ */
+static void vcpu_insn_exec(unsigned int vcpu_index, void *udata)
+{
+    vcpu_cache *cache = &caches[vcpu_index];
+    init_vcpu_cache(vcpu_index, cache);
+
+    qemu_plugin_regs_load(cache->reg_ctx);
+
+    size_t i, n_regs = qemu_plugin_n_regs(cache->reg_ctx);
+    for (i = 0; i < n_regs; i++) {
+        const void *data = qemu_plugin_reg_ptr(cache->reg_ctx, i);
+        size_t size = qemu_plugin_reg_size(cache->reg_ctx, i);
+        const char *name = qemu_plugin_reg_name(cache->reg_ctx, i);
+        g_string_append_printf(cache->report, "vcpu=%u, %s=", vcpu_index, name);
+        print_register_values(cache->report, data, size);
+        g_string_append_printf(cache->report, ", size=%ld\n", size);
+    }
+
+    cache->report_counter++;
+    if (cache->report_counter >= REPORT_BUF_N_INSN) {
+        qemu_plugin_outs(cache->report->str);
+        g_string_erase(cache->report, 0, cache->report->len);
+        cache->report_counter = 0;
+    }
+}
+
+/**
+ * On translation block new translation
+ *
+ * QEMU converts code by translation block (TB). By hooking here we can then hook
+ * a callback on each instruction.
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    struct qemu_plugin_insn *insn;
+
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < n; i++) {
+        insn = qemu_plugin_tb_get_insn(tb, i);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
+                                               QEMU_PLUGIN_CB_R_REGS, NULL);
+    }
+}
+
+static int get_n_max_vcpus(void)
+{
+    return (system_emulation) ? qemu_plugin_n_max_vcpus() : 1;
+}
+
+/**
+ * On plugin exit, print report and free memory
+ */
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    if (caches != NULL) {
+        int n_cpus = get_n_max_vcpus();
+        int i;
+        for (i = 0; i < n_cpus; i++) {
+            if (caches[i].report)
+                qemu_plugin_outs(caches[i].report->str);
+            free_vcpu_cache(&caches[i]);
+        }
+        g_free(caches);
+    }
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    if (!system_emulation && vcpu_index > 0) {
+        qemu_plugin_outs("Multithreading in user-mode is not supported\n");
+        exit(EXIT_FAILURE);
+    }
+}
+
+/**
+ * Install the plugin
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    if (strcmp(info->target_name, "x86_64") == 0)
+        target = X86_64_TARGET;
+    else if (strcmp(info->target_name, "riscv64") == 0)
+        target = RISCV64_TARGET;
+    else {
+        qemu_plugin_outs("Unknown architecture\n");
+        return -1;
+    }
+    system_emulation = info->system_emulation;
+
+    caches = g_new0(vcpu_cache, get_n_max_vcpus());
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/gdb-xml/i386-32bit.xml b/gdb-xml/i386-32bit.xml
index 7a66a02b67..84b872a329 100644
--- a/gdb-xml/i386-32bit.xml
+++ b/gdb-xml/i386-32bit.xml
@@ -189,4 +189,13 @@
   <reg name="xmm7" bitsize="128" type="vec128"/>
 
   <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
+
+  <reg name="ymm0h" bitsize="128" type="uint128"/>
+  <reg name="ymm1h" bitsize="128" type="uint128"/>
+  <reg name="ymm2h" bitsize="128" type="uint128"/>
+  <reg name="ymm3h" bitsize="128" type="uint128"/>
+  <reg name="ymm4h" bitsize="128" type="uint128"/>
+  <reg name="ymm5h" bitsize="128" type="uint128"/>
+  <reg name="ymm6h" bitsize="128" type="uint128"/>
+  <reg name="ymm7h" bitsize="128" type="uint128"/>
 </feature>
diff --git a/gdb-xml/i386-64bit.xml b/gdb-xml/i386-64bit.xml
index 6d88969211..3b8f437ff2 100644
--- a/gdb-xml/i386-64bit.xml
+++ b/gdb-xml/i386-64bit.xml
@@ -213,4 +213,21 @@
   <reg name="xmm15" bitsize="128" type="vec128"/>
 
   <reg name="mxcsr" bitsize="32" type="x64_mxcsr" group="vector"/>
+
+  <reg name="ymm0h" bitsize="128" type="uint128"/>
+  <reg name="ymm1h" bitsize="128" type="uint128"/>
+  <reg name="ymm2h" bitsize="128" type="uint128"/>
+  <reg name="ymm3h" bitsize="128" type="uint128"/>
+  <reg name="ymm4h" bitsize="128" type="uint128"/>
+  <reg name="ymm5h" bitsize="128" type="uint128"/>
+  <reg name="ymm6h" bitsize="128" type="uint128"/>
+  <reg name="ymm7h" bitsize="128" type="uint128"/>
+  <reg name="ymm8h" bitsize="128" type="uint128"/>
+  <reg name="ymm9h" bitsize="128" type="uint128"/>
+  <reg name="ymm10h" bitsize="128" type="uint128"/>
+  <reg name="ymm11h" bitsize="128" type="uint128"/>
+  <reg name="ymm12h" bitsize="128" type="uint128"/>
+  <reg name="ymm13h" bitsize="128" type="uint128"/>
+  <reg name="ymm14h" bitsize="128" type="uint128"/>
+  <reg name="ymm15h" bitsize="128" type="uint128"/>
 </feature>
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index ce8b42eb15..bf4d54f95e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -351,12 +351,32 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
     }
 }
 
+static const char *get_feature_xml_from_cpu(CPUState *cpu, const char *xmlname)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    size_t len = strlen(xmlname);
+
+    if (cc->gdb_get_dynamic_xml) {
+        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
+        if (xml) {
+            return xml;
+        }
+    }
+
+    const char *name = NULL;
+    int i;
+    for (i = 0; ; i++) {
+        name = xml_builtin[i][0];
+        if (!name || (strncmp(name, xmlname, len) == 0 && strlen(name) == len))
+            break;
+    }
+    return name ? xml_builtin[i][1] : NULL;
+}
+
 static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
     size_t len;
-    int i;
-    const char *name;
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
@@ -365,7 +385,6 @@ static const char *get_feature_xml(const char *p, const char **newp,
         len++;
     *newp = p + len;
 
-    name = NULL;
     if (strncmp(p, "target.xml", len) == 0) {
         char *buf = process->target_xml;
         const size_t buf_sz = sizeof(process->target_xml);
@@ -397,26 +416,257 @@ static const char *get_feature_xml(const char *p, const char **newp,
         }
         return buf;
     }
-    if (cc->gdb_get_dynamic_xml) {
-        char *xmlname = g_strndup(p, len);
-        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
 
-        g_free(xmlname);
-        if (xml) {
-            return xml;
+    char *xmlname = g_strndup(p, len);
+    const char *xml = get_feature_xml_from_cpu(cpu, xmlname);
+    g_free(xmlname);
+    return xml;
+}
+
+typedef struct reg_table_data {
+    int bitsize;
+    int regnum;
+} reg_table_data;
+
+typedef struct xml_parser_data {
+    CPUState *cpu;
+    int next_regnum;
+} xml_parser_data;
+
+#ifdef DEBUG
+static void validate_regnums_in_reg_table(gpointer key,
+                                          gpointer value,
+                                          gpointer userdata)
+{
+    const int *regnum = userdata;
+    const reg_table_data *reg_data = value;
+    if (reg_data->regnum == *regnum) {
+        error_report("Error inserting register: \
+                      table already contains register '%s' \
+                      with the same register number %d", \
+                      (const gchar *)key, reg_data->regnum);
+        exit(EXIT_FAILURE);
+    }
+}
+#endif
+
+/*
+ * Handle the start of a <reg> element.
+ * Here we are parsing an XML file which is a Gdb Target description format
+*/
+static void xml_start_reg(GMarkupParseContext *context,
+                          const gchar *elem_name,
+                          const gchar **attr_names,
+                          const gchar **attr_values,
+                          gpointer user_data,
+                          GError **error)
+{
+    if (strcmp(elem_name, "reg") != 0)
+        return;
+
+    const char *name;
+    int regnum, bitsize = 0, i;
+    int exist_regnum, exist_bitsize = 0;
+
+    xml_parser_data *parser_data = (xml_parser_data *)user_data;
+    CPUClass *cc = parser_data->cpu->cc;
+    regnum = parser_data->next_regnum;
+
+    i = 0;
+    name = NULL;
+    /* Each register has required attributes 'name' and 'bitsize',
+       as well as an optional attribute 'regnum'.*/
+    while (attr_names[i] != NULL) {
+        /* The register’s name; it must be unique within the target description */
+        if (strcmp(attr_names[i], "name") == 0) {
+            name = attr_values[i];
         }
+        /* The register’s number. If omitted, a register’s number is one greater
+        than that of the previous register (either in the current feature
+        or in a preceding feature); the first register in the target description
+        defaults to zero. This register number is used to read or write the register */
+        else if (strcmp(attr_names[i], "regnum") == 0) {
+            // Should we set regnum as is or use base_regnum + regnum instead?
+            regnum = atoi(attr_values[i]);
+        }
+        else if (strcmp(attr_names[i], "bitsize") == 0) {
+            bitsize = atoi(attr_values[i]);
+        }
+        i++;
     }
-    for (i = 0; ; i++) {
-        name = xml_builtin[i][0];
-        if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
-            break;
+
+    if (name == NULL || name[0] == '\0') {
+        error_report("Register in xml file does not contain a name");
+        exit(EXIT_FAILURE);
     }
-    return name ? xml_builtin[i][1] : NULL;
+
+    if (regnum < parser_data->next_regnum) {
+        error_report("Bad gdb register numbering for register '%s', "
+                     "expected %d got %d", name, parser_data->next_regnum, regnum);
+        exit(EXIT_FAILURE);
+    }
+
+    if (g_hash_table_contains(cc->gdb_reg_names, name)) {
+        gdb_find_register_num_and_bitsize(parser_data->cpu, name, &exist_regnum, &exist_bitsize);
+        error_report("Gdb register '%s' with num %d, already exists with num %d", name, regnum, exist_regnum);
+        exit(EXIT_FAILURE);
+    }
+
+    parser_data->next_regnum = regnum + 1;
+
+#ifdef DEBUG
+    /* Check that regnum is unique in table */
+    g_hash_table_foreach(cc->gdb_reg_names, validate_regnums_in_reg_table, &regnum);
+#endif
+
+    /* memory will be freed automatically when table is destroyed */
+    reg_table_data *reg_data = g_new0(reg_table_data, 1);
+    reg_data->bitsize = bitsize;
+    reg_data->regnum = regnum;
+    g_hash_table_insert(cc->gdb_reg_names, g_strdup(name), reg_data);
+}
+
+static void parse_target_xml(xml_parser_data *data, const char *xml)
+{
+    if (!xml)
+        return;
+
+    GMarkupParser *parser;
+    GMarkupParseContext *context;
+    GError *error = NULL;
+
+    parser = g_new0(GMarkupParser, 1);
+    parser->start_element = xml_start_reg;
+
+    context = g_markup_parse_context_new(parser, 0, data, 0);
+    g_markup_parse_context_parse(context, xml, strlen(xml), &error);
+    g_markup_parse_context_free(context);
+    if (error != NULL){
+        error_report("Failed to parse xml file: %s", error->message);
+        g_error_free(error);
+    }
+    g_free(parser);
+}
+
+static const char *get_target_xml(CPUState *cpu)
+{
+    CPUClass *cc = cpu->cc;
+    if (cc->gdb_core_xml_file == NULL)
+        return NULL;
+    return get_feature_xml_from_cpu(cpu, cc->gdb_core_xml_file);
+}
+
+/**
+ * Allocates the global @gdb_reg_names hash table only once
+ */
+static void init_register_names_table(CPUState *cpu)
+{
+    CPUClass *cc = cpu->cc;
+    if (cc->gdb_reg_names) {
+        return;
+    }
+
+    cc->gdb_reg_names = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                              g_free, g_free);
+
+    xml_parser_data *data = g_new0(xml_parser_data, 1);
+    data->cpu = cpu;
+    data->next_regnum = 0;
+
+    const char *xml = get_target_xml(cpu);
+    if (xml) {
+        parse_target_xml(data, xml);
+    }
+
+    /* parse additional xml files */
+    GDBRegisterState *r;
+    for (r = cpu->gdb_regs; r; r = r->next) {
+        if (r && r->xml) {
+            const char *xml = get_feature_xml_from_cpu(cpu, r->xml);
+            if (xml) {
+                parse_target_xml(data, xml);
+            }
+        }
+    }
+
+    g_free(data);
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+size_t gdb_get_available_reg_names(CPUState *cpu, char *buf, size_t buf_size)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    init_register_names_table(cpu);
+
+    size_t total_bytes = 0, table_size;
+    guint keys_arr_len = 0, i;
+    gpointer *keys_arr;
+    const bool buf_exists = (buf && buf_size > 0);
+
+    table_size = g_hash_table_size(cc->gdb_reg_names);
+    if (table_size == 0)
+        return total_bytes;
+
+    keys_arr = g_hash_table_get_keys_as_array(cc->gdb_reg_names, &keys_arr_len);
+    for (i = 0; i < keys_arr_len; i++) {
+        char *key;
+        size_t key_len, bytes_needed;
+
+        key = keys_arr[i];
+        key_len = strlen(key);
+        if (key_len == 0)
+            continue;
+
+        bytes_needed = key_len + 1; // string + delimiter
+
+        if (!buf_exists) {
+            total_bytes += bytes_needed;
+            continue; // just count how many bytes are needed
+        }
+
+        if (total_bytes + bytes_needed > buf_size) {
+            break; // not enough space for copying a new string + delimiter
+        }
+
+        memcpy(buf + total_bytes, key, key_len);
+        buf[total_bytes + key_len] = ',';
+        total_bytes += bytes_needed;
+    }
+
+    if (buf_exists) {
+        buf[total_bytes - (total_bytes > 0)] = '\0';
+    }
+
+    return total_bytes;
+}
+
+bool gdb_find_register_num_and_bitsize(CPUState *cpu,
+                                       const char *name,
+                                       int *reg,
+                                       int *bitsize)
+{
+    CPUClass *cc = cpu->cc;
+    init_register_names_table(cpu);
+
+    if (!cc->gdb_reg_names)
+        return false;
+
+    gpointer orig_key, val;
+    bool res = g_hash_table_lookup_extended(cc->gdb_reg_names, name,
+                                            &orig_key, &val);
+    if (res == false || val == NULL) {
+        return false;
+    }
+
+    reg_table_data *data = (reg_table_data *)val;
+    *reg = data->regnum;
+    *bitsize = data->bitsize;
+
+    return true;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+{
+    CPUClass *cc = cpu->cc;
     CPUArchState *env = cpu->env_ptr;
     GDBRegisterState *r;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 7d743fe1e9..0b9a6168cc 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -41,4 +41,40 @@ extern bool gdb_has_xml;
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
 extern const char *const xml_builtin[][2];
 
+/**
+ * gdb_get_available_reg_names() - write the names of all
+ * available registers for the current CPU to destination buffer
+ * @cpu: CPU
+ * @buf: destination buffer to write data, can be NULL
+ * @buf_size: destination buffer size, can be 0
+ *
+ * The register names in the buffer are separated by commas
+ * 
+ * Returns: the size of the data in bytes written to the buffer.
+ * Or if @buf is NULL, the size of the buffer needed to write data
+ */
+size_t gdb_get_available_reg_names(CPUState *cpu, char *buf, size_t buf_size);
+
+/**
+ * gdb_find_register_num_and_bitsize: use to find CPU register by name
+ * @cpu: CPU
+ * @name: register name
+ * @reg: a pointer to store register number
+ * @bitsize: a pointer to store register bitsize
+ *
+ * Returns: true if found, false otherwise
+ */
+bool gdb_find_register_num_and_bitsize(CPUState *cpu, const char *name,
+                                       int *reg, int *bitsize);
+
+/**
+ * gdb_read_register: read register data
+ * @cpu: CPU
+ * @buf: a pointer to store register data
+ * @reg: register number according to the GDB Target Description Format
+ *
+ * Returns: register data size in bytes
+ */
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fdcbe87352..65fa6d54d7 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -164,6 +164,7 @@ struct CPUClass {
     vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);
 
     const char *gdb_core_xml_file;
+    GHashTable *gdb_reg_names;
     gchar * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_dynamic_xml)(CPUState *cpu, const char *xmlname);
 
@@ -329,6 +330,8 @@ struct CPUState {
     DeviceState parent_obj;
     /* cache to avoid expensive CPU_GET_CLASS */
     CPUClass *cc;
+    /* cache to avoid expensive arch casts like X86_CPU */
+    ArchCPU *arch;
     /*< public >*/
 
     int nr_cores;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..fa3b1b6fb8 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -51,7 +51,7 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -394,6 +394,109 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
  */
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
 
+#define QEMU_PLUGIN_REGISTERS_ENABLED
+
+/**
+ * qemu_plugin_find_reg() - find register by name
+ * @name: register name
+ * @regnum: a pointer to store register number
+ *
+ * Returns: true if found, false otherwise
+ */
+bool qemu_plugin_find_reg(const char *name, int *regnum);
+
+/**
+ * qemu_plugin_get_available_reg_names() - write the names of all
+ * available registers for the current CPU to destination buffer
+ * @buf: destination buffer to write data, can be NULL
+ * @buf_size: destination buffer size, can be 0
+ *
+ * The register names in the buffer are separated by commas
+ * 
+ * Returns: the size of the data in bytes written to the buffer.
+ * Or if @buf is NULL, the size of the buffer needed to write data
+ */
+size_t qemu_plugin_get_available_reg_names(char *buf, size_t buf_size);
+
+/**
+ * qemu_plugin_read_reg() - return register data
+ * @regnum: register number
+ * @size: a pointer to store allocated memory size
+ *
+ * Returns: allocated memory containing register data,
+ * memory must be freed manually using g_free()
+ */
+const void *qemu_plugin_read_reg(int regnum, size_t *size);
+
+/** struct qemu_plugin_reg_ctx - Opaque handle for register context */
+struct qemu_plugin_reg_ctx;
+
+/**
+ * qemu_plugin_n_regs() - query helper for number of registers in context
+ * @ctx: register context
+ *
+ * Returns: number of registers in context
+ */
+size_t qemu_plugin_n_regs(const struct qemu_plugin_reg_ctx *ctx);
+
+/**
+ * qemu_plugin_reg_create_context() - create a context for working with registers
+ * @names: array with register names
+ * @len: array length
+ *
+ * Limitation: cannot be called from init_cpu callback
+ * 
+ * Returns: opaque handle to register context
+ */
+struct qemu_plugin_reg_ctx *
+qemu_plugin_reg_create_context(const char *const *names,
+                               size_t len);
+
+/**
+ * qemu_plugin_reg_free_context() - free the register context
+ * @ctx: register context
+ */
+void qemu_plugin_reg_free_context(struct qemu_plugin_reg_ctx *ctx);
+
+/**
+ * qemu_plugin_reg_name() - query helper for register name in context
+ * @ctx: register context
+ * @idx: register index
+ *
+ * Returns: returns register name
+ */
+const char *qemu_plugin_reg_name(const struct qemu_plugin_reg_ctx *ctx, size_t idx);
+
+/**
+ * qemu_plugin_reg_ptr() - query helper for a pointer to register data in context
+ * @ctx: register context
+ * @idx: register index
+ *
+ * Returns: pointer to register data
+ */
+const void *qemu_plugin_reg_ptr(const struct qemu_plugin_reg_ctx *ctx, size_t idx);
+
+/**
+ * qemu_plugin_reg_size() - query helper for register size in context
+ * @ctx: register context
+ * @idx: register index
+ *
+ * Returns: size of register data in bytes 
+ */
+size_t qemu_plugin_reg_size(const struct qemu_plugin_reg_ctx *ctx, size_t idx);
+
+/**
+ * qemu_plugin_regs_load() - load data from all registers
+ * and store them in context
+ * @ctx: register context
+ *
+ * This call does not require qemu_plugin_reg_ptr()
+ * or qemu_plugin_reg_size() to be called again,
+ * because the data will be overwritten in the context at the same positions.
+ * So it's just an update call
+ */
+void qemu_plugin_regs_load(struct qemu_plugin_reg_ctx *ctx);
+
 /**
  * typedef qemu_plugin_meminfo_t - opaque memory transaction handle
  *
diff --git a/plugins/api.c b/plugins/api.c
index 2078b16edb..f758b491a6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,9 +39,12 @@
 #include "qemu/log.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
+#include "exec/gdbstub.h"
+#include "exec/log.h"
 #include "exec/ram_addr.h"
 #include "disas/disas.h"
 #include "plugin.h"
+#include "sysemu/hw_accel.h"
 #ifndef CONFIG_USER_ONLY
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
@@ -244,6 +247,226 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn)
     return sym[0] != 0 ? sym : NULL;
 }
 
+/*
+ * CPU registers
+ *
+ * These queries allow the plugin to retrieve information about current
+ * CPU registers
+ */
+
+static void check_reg_architecture_support(void) {
+    if (strcmp(TARGET_NAME, "x86_64") != 0 && strcmp(TARGET_NAME, "riscv64") != 0 &&
+        strcmp(TARGET_NAME, "aarch64") != 0) {
+        error_report("Unsupported architecture: %s", TARGET_NAME);
+        abort();
+    }
+}
+
+bool qemu_plugin_find_reg(const char *name, int *regnum)
+{
+    CPUState *cpu = current_cpu;
+    if (name == NULL || cpu == NULL)
+        return false;
+
+    check_reg_architecture_support();
+
+    int num = 0, bitsize = 0;
+    bool found = gdb_find_register_num_and_bitsize(cpu, name,
+                                                   &num, &bitsize);
+    if (regnum)
+        *regnum = num;
+    return found;
+}
+
+size_t qemu_plugin_get_available_reg_names(char *buf, size_t buf_size)
+{
+    check_reg_architecture_support();
+    return gdb_get_available_reg_names(current_cpu, buf, buf_size);
+}
+
+const void *qemu_plugin_read_reg(int regnum, size_t *size)
+{
+    CPUState *cpu = current_cpu;
+    if (cpu == NULL)
+        return NULL;
+
+    check_reg_architecture_support();
+
+    cpu_synchronize_state(cpu);
+    GByteArray *arr = g_byte_array_new();
+    gdb_read_register(cpu, arr, regnum);
+    if (size)
+        *size = arr->len;
+    return g_byte_array_free(arr, false);
+}
+
+struct qemu_plugin_reg_ctx {
+    CPUState *cpu;
+
+    size_t *regnums;
+    size_t *bitsizes;
+    gchar **names;
+
+    /* cache the initial position of the register data
+    in the general data array */
+    size_t *offsets;
+
+    /* the actual number of registers in the context.
+       This number may be less than requested if any of the registers
+       was not found */
+    size_t n_regs;
+
+    /* contains registers one by one */
+    GByteArray *data;
+
+    /* remember how much memory was actually allocated for the data.
+       This value is used to check that the length of the array has not changed
+       after reading the registers. it mustn't happen */
+    size_t alloc_data_len;
+};
+
+size_t qemu_plugin_n_regs(const struct qemu_plugin_reg_ctx *ctx)
+{
+    return (ctx) ? ctx->n_regs : 0;
+}
+
+struct qemu_plugin_reg_ctx *
+qemu_plugin_reg_create_context(const char *const *names, size_t len)
+{
+    size_t reqested_len, actual_len, total_bitsize, i;
+    struct qemu_plugin_reg_ctx *ctx;
+    CPUState *cpu = current_cpu;
+    if (cpu == NULL)
+        return NULL;
+
+    check_reg_architecture_support();
+
+    reqested_len = len;
+    ctx = g_new0(struct qemu_plugin_reg_ctx, 1);
+    ctx->cpu = cpu;
+    ctx->regnums = g_new0(size_t, reqested_len);
+    ctx->bitsizes = g_new0(size_t, reqested_len);
+    ctx->names = g_new0(gchar*, reqested_len);
+    ctx->offsets = g_new0(size_t, reqested_len);
+
+    actual_len = 0;
+    total_bitsize = 0;
+    for (i = 0; i < reqested_len; i++) {
+        int reg = 0, bitsize = 0;
+        bool found = gdb_find_register_num_and_bitsize(ctx->cpu, names[i],
+                                                       &reg, &bitsize);
+        if (!found)
+            continue;
+
+        ctx->regnums[actual_len] = reg;
+        ctx->bitsizes[actual_len] = bitsize;
+        ctx->names[actual_len] = g_strdup(names[i]);
+        ctx->offsets[actual_len] = total_bitsize;
+        actual_len++;
+        total_bitsize += bitsize;
+    }
+    ctx->n_regs = actual_len;
+
+    if (actual_len == 0) {
+        qemu_plugin_reg_free_context(ctx);
+        return NULL;
+    }
+
+    if ((total_bitsize % CHAR_BIT) != 0) {
+        error_report("Unexpected register bitsize: %ld", total_bitsize);
+        abort();
+    }
+    ctx->alloc_data_len = total_bitsize / 8;
+    ctx->data = g_byte_array_sized_new(ctx->alloc_data_len);
+
+    return ctx;
+}
+
+void qemu_plugin_reg_free_context(struct qemu_plugin_reg_ctx *ctx)
+{
+    int i;
+    if (ctx == NULL)
+        return;
+
+    if (ctx->data)
+        g_byte_array_free(ctx->data, true);
+
+    g_free(ctx->offsets);
+    for (i = 0; i < ctx->n_regs; i++) {
+        g_free(ctx->names[i]);
+    }
+    g_free(ctx->names);
+    g_free(ctx->bitsizes);
+    g_free(ctx->regnums);
+    g_free(ctx);
+    ctx = NULL;
+}
+
+static inline bool reg_context_is_valid(const struct qemu_plugin_reg_ctx *ctx)
+{
+    return ctx && ctx->data;
+}
+
+static inline bool reg_index_is_valid(const struct qemu_plugin_reg_ctx *ctx,
+                                      size_t idx)
+{
+    return idx < ctx->n_regs && idx <= INT_MAX;
+}
+
+const char *qemu_plugin_reg_name(const struct qemu_plugin_reg_ctx *ctx,
+                                 size_t idx)
+{
+    if (!reg_context_is_valid(ctx) || !reg_index_is_valid(ctx, idx))
+        return NULL;
+
+    return ctx->names[idx];
+}
+
+const void *qemu_plugin_reg_ptr(const struct qemu_plugin_reg_ctx *ctx,
+                                size_t idx)
+{
+    if (!reg_context_is_valid(ctx) || !reg_index_is_valid(ctx, idx))
+        return NULL;
+
+    size_t offset = ctx->offsets[idx] / CHAR_BIT;
+    return (uint8_t *)ctx->data->data + offset;
+}
+
+size_t qemu_plugin_reg_size(const struct qemu_plugin_reg_ctx *ctx,
+                            size_t idx)
+{
+    if (!reg_context_is_valid(ctx) || !reg_index_is_valid(ctx, idx))
+        return 0;
+
+    if ((ctx->bitsizes[idx] % CHAR_BIT) != 0) {
+        error_report("Unexpected register bitsize: %ld", ctx->bitsizes[idx]);
+        abort();
+    }
+
+    return ctx->bitsizes[idx] / CHAR_BIT;
+}
+
+void qemu_plugin_regs_load(struct qemu_plugin_reg_ctx *ctx)
+{
+    g_byte_array_set_size(ctx->data, 0);
+    cpu_synchronize_state(ctx->cpu);
+    size_t i;
+    for (i = 0; i < ctx->n_regs; i++) {
+        int size = gdb_read_register(ctx->cpu, ctx->data, ctx->regnums[i]);
+        int bitsize = size * 8;
+        if (bitsize != ctx->bitsizes[i]) {
+            error_report("Expected data size after reading register %s: %ld, got %u",
+                     ctx->names[i], ctx->bitsizes[i], bitsize);
+            abort();
+        }
+    }
+    if (ctx->data->len != ctx->alloc_data_len) {
+        error_report("Expected data size after reading registers: %ld, got %u",
+                     ctx->alloc_data_len, ctx->data->len);
+        abort();
+    }
+}
+
 /*
  * The memory queries allow the plugin to query information about a
  * memory access.
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549..c6539888ac 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -20,6 +20,16 @@
   qemu_plugin_n_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_find_reg;
+  qemu_plugin_get_available_reg_names;
+  qemu_plugin_read_reg;
+  qemu_plugin_n_regs;
+  qemu_plugin_reg_create_context;
+  qemu_plugin_reg_free_context;
+  qemu_plugin_reg_name;
+  qemu_plugin_reg_ptr;
+  qemu_plugin_reg_size;
+  qemu_plugin_regs_load;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
   qemu_plugin_register_vcpu_exit_cb;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e5..b04c8b155f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1584,6 +1584,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     ARMCPU *cpu = ARM_CPU(dev);
+    /* cache the arch class for the hotpath */
+    cs->arch = (struct ArchCPU *)cpu;
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
     int pagebits;
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index f421c5d041..7f561655cf 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -39,7 +39,7 @@ typedef struct RegisterSysregXmlParam {
 
 int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
+    ARMCPU *cpu = (ARMCPU *)cs->arch;
     CPUARMState *env = &cpu->env;
 
     if (n < 16) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..19e4c7722e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7210,6 +7210,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     X86CPU *cpu = X86_CPU(dev);
+    /* cache the arch class for the hotpath */
+    cs->arch = (struct ArchCPU *)cpu;
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
@@ -7964,10 +7966,10 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->gdb_arch_name = x86_gdb_arch_name;
 #ifdef TARGET_X86_64
     cc->gdb_core_xml_file = "i386-64bit.xml";
-    cc->gdb_num_core_regs = 66;
+    cc->gdb_num_core_regs = 82;
 #else
     cc->gdb_core_xml_file = "i386-32bit.xml";
-    cc->gdb_num_core_regs = 50;
+    cc->gdb_num_core_regs = 58;
 #endif
     cc->disas_set_info = x86_disas_set_info;
 
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index ebb000df6a..47b96afa94 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -49,12 +49,13 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 #define IDX_NB_SEG      (6 + 3)
 #define IDX_NB_CTL      6
 #define IDX_NB_FP       16
+#define IDX_NB_YMM      16
 /*
  * fpu regs ----------> 8 or 16
  */
 #define IDX_NB_MXCSR    1
 /*
- *          total ----> 8+1+1+9+6+16+8+1=50 or 16+1+1+9+6+16+16+1=66
+ *          total ----> 8+1+1+9+6+16+8+1+8=58 or 16+1+1+9+6+16+16+1+16=82
  */
 
 #define IDX_IP_REG      CPU_NB_REGS
@@ -64,6 +65,7 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 #define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
 #define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
 #define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
+#define IDX_YMM_REGS    (IDX_MXCSR_REG + IDX_NB_MXCSR)
 
 #define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
 #define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
@@ -98,9 +100,10 @@ static int gdb_write_reg_cs64(uint32_t hflags, uint8_t *buf, target_ulong *val)
 
 int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    X86CPU *cpu = X86_CPU(cs);
+    X86CPU *cpu = (X86CPU *)cs->arch;
     CPUX86State *env = &cpu->env;
 
+    uint32_t eflags;
     uint64_t tpr;
 
     /* N.B. GDB can't deal with changes in registers or sizes in the middle
@@ -134,6 +137,14 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
                                   env->xmm_regs[n].ZMM_Q(1),
                                   env->xmm_regs[n].ZMM_Q(0));
         }
+    }
+    else if (n >= IDX_YMM_REGS && n < IDX_YMM_REGS + IDX_NB_YMM) {
+        n -= IDX_YMM_REGS;
+        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
+            return gdb_get_reg128(mem_buf,
+                                  env->xmm_regs[n].ZMM_Q(3),
+                                  env->xmm_regs[n].ZMM_Q(2));
+        }
     } else {
         switch (n) {
         case IDX_IP_REG:
@@ -147,7 +158,8 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
                 return gdb_get_reg32(mem_buf, env->eip);
             }
         case IDX_FLAGS_REG:
-            return gdb_get_reg32(mem_buf, env->eflags);
+            eflags = cpu_compute_eflags(env);
+            return gdb_get_reg32(mem_buf, eflags);
 
         case IDX_SEG_REGS:
             return gdb_get_reg32(mem_buf, env->segs[R_CS].selector);
@@ -285,6 +297,13 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->xmm_regs[n].ZMM_Q(1) = ldq_p(mem_buf + 8);
             return 16;
         }
+    } else if (n >= IDX_YMM_REGS && n < IDX_YMM_REGS + IDX_NB_YMM) {
+        n -= IDX_YMM_REGS;
+        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
+            env->xmm_regs[n].ZMM_Q(2) = ldq_p(mem_buf);
+            env->xmm_regs[n].ZMM_Q(3) = ldq_p(mem_buf + 8);
+            return 32;
+        }
     } else {
         switch (n) {
         case IDX_IP_REG:
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6b93b04453..4a549c9986 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1391,7 +1391,10 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
 
 static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
 {
+    CPUState *cs = CPU(dev);
     RISCVCPU *cpu = RISCV_CPU(dev);
+    /* cache the arch class for the hotpath */
+    cs->arch = (struct ArchCPU *)cpu;
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 524bede865..596df1931c 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -49,7 +49,7 @@ static const struct TypeSize vec_lanes[] = {
 
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
+    RISCVCPU *cpu = (RISCVCPU *)cs->arch;
     CPURISCVState *env = &cpu->env;
     target_ulong tmp;
 
@@ -169,6 +169,7 @@ static int riscv_gdb_get_csr(CPURISCVState *env, GByteArray *buf, int n)
             return gdb_get_regl(buf, val);
         }
     }
+    g_assert_not_reached();
     return 0;
 }
 
-- 
2.34.1


