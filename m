Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 544037690B9
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOZG-0007bD-LJ; Mon, 31 Jul 2023 04:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOZ0-0007Fx-EU
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:47:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOYx-0005Kh-WB
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:47:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68706d67ed9so2353435b3a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690793255; x=1691398055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPZLL2BQqlmuIWxUEHn0Sk9lpGxDteaJZxDIDmp8UqM=;
 b=Ntzl3L+Ycidt4E2sO5Qc+c7zR4Dphu4IUHgX7FrwOK8K/wXakETfwScShXAZfHuEuv
 UFtCEebyPjkdPA1SHJRqpP3gszGb/x5iZly137X5e47BUvHM5reb16bLn/05qimMfa4M
 C3/vCek/onHA+9m/wEKJuPikSKb7U4bLLgeGqYTPd8w8iSbfYdZQH1q2OQjxMSPiHGk1
 Ja2qVpiPPIrjuDFBG3NO+iYhHmAhAh4qCwj8UNnWZUFQ9ZBi2DtL2eI2oNCL94Kij21D
 WYQIW1nAlh+mXSisl3r8GhbRvVr6H9BTpcy2SX/Wjgcl7oigFEn5+mhBY3/VDUk/6ENn
 3epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690793255; x=1691398055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPZLL2BQqlmuIWxUEHn0Sk9lpGxDteaJZxDIDmp8UqM=;
 b=jEICsUWcq5E5dppRWmFH4n0KOxsf4IadT2l4d+60s6+SVaXlzVGOfDZOUSbq23BH3h
 SlGDZULL4ft7QVlJR0gnWIr7s4MohGggXQFP3VEfsyXJpPZRmj7KSJqxMq6NRlhqRMag
 7g3dC1A9C3Wwxg9hdSo5ASjWRBjPUNPc+6BSMu9oqL6h+aBCP0LTScn8rzWXqo8BZdwQ
 QpghDaKSxECjRzIMYNMrD1VoxtDT7OTwDnAnSlvsmgMuw0Xd3EjdAjugBgHSeKHdYtBB
 YvpPa/BEsjMf9nUsiro1t4SrBMcLvtuNKligo5otvgWt/tKPtF3hVWBihbxlUtMNUzhR
 nVOw==
X-Gm-Message-State: ABy/qLa7F4qbLWQRDcwnF8GYBSPxwTJV4ws311ufs+Q6jp69Sg/k88U/
 vK/92LRRbl2SZodTSO+MLE/DXg==
X-Google-Smtp-Source: APBJJlFcxshJrqA9zCwgmiIX33aC0EjZT2Dp52t6StvzwN1DIW87O7vpMOwB6ZtLuvZowEya52+lxA==
X-Received: by 2002:a05:6a00:15d4:b0:677:bdc:cd6b with SMTP id
 o20-20020a056a0015d400b006770bdccd6bmr11677189pfu.19.1690793254686; 
 Mon, 31 Jul 2023 01:47:34 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 u19-20020aa78493000000b00666e649ca46sm7075563pfn.101.2023.07.31.01.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:47:34 -0700 (PDT)
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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
 qemu-s390x@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 22/24] contrib/plugins: Allow to log registers
Date: Mon, 31 Jul 2023 17:43:49 +0900
Message-ID: <20230731084354.115015-23-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731084354.115015-1-akihiko.odaki@daynix.com>
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This demonstrates how a register can be read from a plugin.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/tcg-plugins.rst |  10 ++-
 contrib/plugins/execlog.c  | 130 ++++++++++++++++++++++++++++---------
 2 files changed, 108 insertions(+), 32 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 81dcd43a61..c9f8b27590 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -497,6 +497,15 @@ arguments if required::
   $ qemu-system-arm $(QEMU_ARGS) \
     -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
 
+This plugin can also dump a specified register. The specification of register
+follows `GDB standard target features <https://sourceware.org/gdb/onlinedocs/gdb/Standard-Target-Features.html>`__.
+
+Specify the name of the feature that contains the register and the name of the
+register with ``rfile`` and ``reg`` options, respectively::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,rfile=org.gnu.gdb.arm.core,reg=sp -d plugin
+
 - contrib/plugins/cache.c
 
 Cache modelling plugin that measures the performance of a given L1 cache
@@ -583,4 +592,3 @@ The following API is generated from the inline documentation in
 include the full kernel-doc annotations.
 
 .. kernel-doc:: include/qemu/qemu-plugin.h
-
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index ce67acf145..031ad67fbb 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -15,27 +15,42 @@
 
 #include <qemu-plugin.h>
 
+typedef struct CPU {
+    /* Store last executed instruction on each vCPU as a GString */
+    GString *last_exec;
+    GByteArray *reg_buf;
+
+    int reg;
+} CPU;
+
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-/* Store last executed instruction on each vCPU as a GString */
-static GPtrArray *last_exec;
+static CPU *cpus;
+static int num_cpus;
 static GRWLock expand_array_lock;
 
 static GPtrArray *imatches;
 static GArray *amatches;
 
+static char *rfile_name;
+static char *reg_name;
+
 /*
- * Expand last_exec array.
+ * Expand cpu array.
  *
  * As we could have multiple threads trying to do this we need to
  * serialise the expansion under a lock.
  */
-static void expand_last_exec(int cpu_index)
+static void expand_cpu(int cpu_index)
 {
-    g_rw_lock_writer_unlock(&expand_array_lock);
-    while (cpu_index >= last_exec->len) {
-        GString *s = g_string_new(NULL);
-        g_ptr_array_add(last_exec, s);
+    g_rw_lock_writer_lock(&expand_array_lock);
+    if (cpu_index >= num_cpus) {
+        cpus = g_realloc_n(cpus, cpu_index + 1, sizeof(*cpus));
+        while (cpu_index >= num_cpus) {
+            cpus[num_cpus].last_exec = g_string_new(NULL);
+            cpus[num_cpus].reg_buf = g_byte_array_new();
+            num_cpus++;
+        }
     }
     g_rw_lock_writer_unlock(&expand_array_lock);
 }
@@ -50,8 +65,8 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
 
     /* Find vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
-    g_assert(cpu_index < last_exec->len);
-    s = g_ptr_array_index(last_exec, cpu_index);
+    g_assert(cpu_index < num_cpus);
+    s = cpus[cpu_index].last_exec;
     g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Indicate type of memory access */
@@ -77,28 +92,35 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
  */
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
-    GString *s;
+    CPU cpu;
+    int n;
+    int i;
 
     /* Find or create vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
-    if (cpu_index >= last_exec->len) {
-        g_rw_lock_reader_unlock(&expand_array_lock);
-        expand_last_exec(cpu_index);
-        g_rw_lock_reader_lock(&expand_array_lock);
-    }
-    s = g_ptr_array_index(last_exec, cpu_index);
+    cpu = cpus[cpu_index];
     g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Print previous instruction in cache */
-    if (s->len) {
-        qemu_plugin_outs(s->str);
+    if (cpu.last_exec->len) {
+        qemu_plugin_outs(cpu.last_exec->str);
         qemu_plugin_outs("\n");
     }
 
     /* Store new instruction in cache */
     /* vcpu_mem will add memory access information to last_exec */
-    g_string_printf(s, "%u, ", cpu_index);
-    g_string_append(s, (char *)udata);
+    g_string_printf(cpu.last_exec, "%u, ", cpu_index);
+    g_string_append(cpu.last_exec, (char *)udata);
+
+    if (cpu.reg >= 0) {
+        g_string_append(cpu.last_exec, ", reg,");
+        n = qemu_plugin_read_register(cpu.reg_buf, cpu.reg);
+        for (i = 0; i < n; i++) {
+            g_string_append_printf(cpu.last_exec, " 0x%02X",
+                                   cpu.reg_buf->data[i]);
+        }
+        g_byte_array_set_size(cpu.reg_buf, 0);
+    }
 }
 
 /**
@@ -167,8 +189,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                              QEMU_PLUGIN_MEM_RW, NULL);
 
             /* Register callback on instruction */
-            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
-                                                   QEMU_PLUGIN_CB_NO_REGS, output);
+            qemu_plugin_register_vcpu_insn_exec_cb(
+                insn, vcpu_insn_exec,
+                rfile_name ? QEMU_PLUGIN_CB_R_REGS : QEMU_PLUGIN_CB_NO_REGS,
+                output);
 
             /* reset skip */
             skip = (imatches || amatches);
@@ -177,17 +201,53 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    int reg = 0;
+    bool found = false;
+
+    expand_cpu(vcpu_index);
+
+    if (rfile_name) {
+        int i;
+        int j;
+        int n;
+
+        qemu_plugin_register_file_t *rfiles =
+            qemu_plugin_get_register_files(vcpu_index, &n);
+
+        for (i = 0; i < n; i++) {
+            if (g_strcmp0(rfiles[i].name, rfile_name) == 0) {
+                for (j = 0; j < rfiles[i].num_regs; j++) {
+                    if (g_strcmp0(rfiles[i].regs[j], reg_name) == 0) {
+                        reg += j;
+                        found = true;
+                        break;
+                    }
+                }
+                break;
+            }
+
+            reg += rfiles[i].num_regs;
+        }
+
+        g_free(rfiles);
+    }
+
+    g_rw_lock_writer_lock(&expand_array_lock);
+    cpus[vcpu_index].reg = found ? reg : -1;
+    g_rw_lock_writer_unlock(&expand_array_lock);
+}
+
 /**
  * On plugin exit, print last instruction in cache
  */
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     guint i;
-    GString *s;
-    for (i = 0; i < last_exec->len; i++) {
-        s = g_ptr_array_index(last_exec, i);
-        if (s->str) {
-            qemu_plugin_outs(s->str);
+    for (i = 0; i < num_cpus; i++) {
+        if (cpus[i].last_exec->str) {
+            qemu_plugin_outs(cpus[i].last_exec->str);
             qemu_plugin_outs("\n");
         }
     }
@@ -224,9 +284,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
      * we don't know the size before emulation.
      */
     if (info->system_emulation) {
-        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
-    } else {
-        last_exec = g_ptr_array_new();
+        cpus = g_new(CPU, info->system.max_vcpus);
     }
 
     for (int i = 0; i < argc; i++) {
@@ -236,13 +294,23 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
             parse_vaddr_match(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "rfile") == 0) {
+            rfile_name = g_strdup(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "reg") == 0) {
+            reg_name = g_strdup(tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
         }
     }
 
+    if ((!rfile_name) != (!reg_name)) {
+        fputs("file and reg need to be set at the same time\n", stderr);
+        return -1;
+    }
+
     /* Register translation block and exit callbacks */
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
-- 
2.41.0


