Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437F82ECFB
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:49:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzt-0002Yb-UX; Tue, 16 Jan 2024 05:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzf-0002Ly-H4
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:31 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzb-0007GT-At
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:30 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3376f71fcbbso7568745f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402104; x=1706006904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyOwG4WQxCYCmv49/v3pgH2X31CfXDHb6k8UyDxPtFQ=;
 b=i6oP3CXthWsveDCf1utHp4a9okovov6bCcI7Ukca9NcwEFhJu0/V7O8Cu732QWRPu+
 7heRGMwzEbhoEpQVJH5cTS2C/ZKpzvZtlug7AeMBACrXIgU6rAqrvn5fDdVOh/ycUEin
 H7M+CpcIFgfxeMnBXADZgDB0Sx61qugEd1n/eHMbQM99/Di0S8YZTmd3URmIHZkdToeY
 cLvZPNRXN+oj77OvtmIjqBon54Iung+1S4KPVDLn96qR1hZ0yoRUpbu26PTLllWv4Ezq
 mAI5jSQ7MeuRbvd5SBr8ZiSIx+kdaDm4TkCvFskpJrU7CQNqZVDlL5eoFda3D0H00pTt
 QBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402104; x=1706006904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyOwG4WQxCYCmv49/v3pgH2X31CfXDHb6k8UyDxPtFQ=;
 b=tE8By/IENdpVhankvInwKN7RlxH71u1RcZQlAIxRcByJbiWL6e6MqXOyqM4vicXJGA
 PhriqpzfKBtDYwuawrnc44CzD8sGMk+VRl4NUom/VYaPUA5a0jh9zZLLhIk7orf9n+B4
 ak72jG+xyAne7zUFehgl4olxRjwCkY+CI+428RduyeqNNUBk/t0e6zuGnyOQam4J5rnW
 7dpEZn5gVt6P5l/xBbLIS7JPVHsmtu5ej+j43gup7s4ib0foHAIUhnRgXgnc6XhhHWzQ
 Oe8FM9X/rqPiP32rL1/Fm0pwmKcReeLboXleTl9ztWETglzYsfUOFsCVY9H2pwkFI2Hq
 TQaA==
X-Gm-Message-State: AOJu0YweBIXDN9fExRrrv192o2brKRUFsn+nLZHY/1/7q69qCTr+iTyH
 bo07qTPNsYgONipiOe2R0v2UnbUHw8sgOw==
X-Google-Smtp-Source: AGHT+IELZT/4Dx3zm9fWY3E7MwopcOQr5DypIhXL8FPGdqEBJI/2ZEd8LT+75KYNb/5a0sWY52u7hw==
X-Received: by 2002:a05:600c:1994:b0:40e:4794:f225 with SMTP id
 t20-20020a05600c199400b0040e4794f225mr2284135wmq.9.1705402104321; 
 Tue, 16 Jan 2024 02:48:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l39-20020a05600c1d2700b0040e50d82af5sm18996568wms.32.2024.01.16.02.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53CE75F90B;
 Tue, 16 Jan 2024 10:48:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 19/22] contrib/plugins: extend execlog to track register changes
Date: Tue, 16 Jan 2024 10:48:06 +0000
Message-Id: <20240116104809.250076-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

With the new plugin register API we can now track changes to register
values. Currently the implementation is fairly dumb which will slow
down if a large number of register values are being tracked. This
could be improved by only instrumenting instructions which mention
registers we are interested in tracking.

Example usage:

  ./qemu-aarch64 -D plugin.log -d plugin \
     -cpu max,sve256=on \
     -plugin contrib/plugins/libexeclog.so,reg=sp,reg=z\* \
     ./tests/tcg/aarch64-linux-user/sha512-sve

will display in the execlog any changes to the stack pointer (sp) and
the SVE Z registers.

Message-Id: <20240103173349.398526-41-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Based-On: <20231025093128.33116-19-akihiko.odaki@daynix.com>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 81dcd43a612..3a0962723d7 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -497,6 +497,14 @@ arguments if required::
   $ qemu-system-arm $(QEMU_ARGS) \
     -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
 
+This plugin can also dump registers when they change value. Specify the name of the
+registers with multiple ``reg`` options. You can also use glob style matching if you wish::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,reg=\*_el2,reg=sp -d plugin
+
+Be aware that each additional register to check will slow down execution quite considerably.
+
 - contrib/plugins/cache.c
 
 Cache modelling plugin that measures the performance of a given L1 cache
@@ -583,4 +591,3 @@ The following API is generated from the inline documentation in
 include the full kernel-doc annotations.
 
 .. kernel-doc:: include/qemu/qemu-plugin.h
-
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index f262e5555eb..c20e88a6941 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2021, Alexandre Iooss <erdnaxe@crans.org>
  *
- * Log instruction execution with memory access.
+ * Log instruction execution with memory access and register changes
  *
  * License: GNU GPL, version 2 or later.
  *   See the COPYING file in the top-level directory.
@@ -15,30 +15,29 @@
 
 #include <qemu-plugin.h>
 
+typedef struct {
+    struct qemu_plugin_register *handle;
+    GByteArray *last;
+    GByteArray *new;
+    const char *name;
+} Register;
+
+typedef struct CPU {
+    /* Store last executed instruction on each vCPU as a GString */
+    GString *last_exec;
+    /* Ptr array of Register */
+    GPtrArray *registers;
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
-
-/*
- * Expand last_exec array.
- *
- * As we could have multiple threads trying to do this we need to
- * serialise the expansion under a lock.
- */
-static void expand_last_exec(int cpu_index)
-{
-    g_rw_lock_writer_lock(&expand_array_lock);
-    while (cpu_index >= last_exec->len) {
-        GString *s = g_string_new(NULL);
-        g_ptr_array_add(last_exec, s);
-    }
-    g_rw_lock_writer_unlock(&expand_array_lock);
-}
+static GPtrArray *rmatches;
 
 /**
  * Add memory read or write information to current instruction log
@@ -50,8 +49,8 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
 
     /* Find vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
-    g_assert(cpu_index < last_exec->len);
-    s = g_ptr_array_index(last_exec, cpu_index);
+    g_assert(cpu_index < num_cpus);
+    s = cpus[cpu_index].last_exec;
     g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Indicate type of memory access */
@@ -77,28 +76,46 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
  */
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
-    GString *s;
+    CPU *cpu;
 
-    /* Find or create vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
-    if (cpu_index >= last_exec->len) {
-        g_rw_lock_reader_unlock(&expand_array_lock);
-        expand_last_exec(cpu_index);
-        g_rw_lock_reader_lock(&expand_array_lock);
-    }
-    s = g_ptr_array_index(last_exec, cpu_index);
+    g_assert(cpu_index < num_cpus);
+    cpu = &cpus[cpu_index];
     g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Print previous instruction in cache */
-    if (s->len) {
-        qemu_plugin_outs(s->str);
+    if (cpu->last_exec->len) {
+        if (cpu->registers) {
+            for (int n = 0; n < cpu->registers->len; n++) {
+                Register *reg = cpu->registers->pdata[n];
+                int sz;
+
+                g_byte_array_set_size(reg->new, 0);
+                sz = qemu_plugin_read_register(cpu_index, reg->handle, reg->new);
+                g_assert(sz == reg->last->len);
+
+                if (memcmp(reg->last->data, reg->new->data, sz)) {
+                    GByteArray *temp = reg->last;
+                    g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
+                    /* TODO: handle BE properly */
+                    for (int i = sz; i >= 0; i--) {
+                        g_string_append_printf(cpu->last_exec, "%02x",
+                                               reg->new->data[i]);
+                    }
+                    reg->last = reg->new;
+                    reg->new = temp;
+                }
+            }
+        }
+
+        qemu_plugin_outs(cpu->last_exec->str);
         qemu_plugin_outs("\n");
     }
 
     /* Store new instruction in cache */
     /* vcpu_mem will add memory access information to last_exec */
-    g_string_printf(s, "%u, ", cpu_index);
-    g_string_append(s, (char *)udata);
+    g_string_printf(cpus[cpu_index].last_exec, "%u, ", cpu_index);
+    g_string_append(cpus[cpu_index].last_exec, (char *)udata);
 }
 
 /**
@@ -167,8 +184,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                              QEMU_PLUGIN_MEM_RW, NULL);
 
             /* Register callback on instruction */
-            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
-                                                   QEMU_PLUGIN_CB_NO_REGS, output);
+            qemu_plugin_register_vcpu_insn_exec_cb(
+                insn, vcpu_insn_exec,
+                rmatches ? QEMU_PLUGIN_CB_R_REGS : QEMU_PLUGIN_CB_NO_REGS,
+                output);
 
             /* reset skip */
             skip = (imatches || amatches);
@@ -177,17 +196,86 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
+static Register *init_vcpu_register(int vcpu_index,
+                                    qemu_plugin_reg_descriptor *desc)
+{
+    Register *reg = g_new0(Register, 1);
+    int r;
+
+    reg->handle = desc->handle;
+    reg->name = g_strdup(desc->name);
+    reg->last = g_byte_array_new();
+    reg->new = g_byte_array_new();
+
+    /* read the initial value */
+    r = qemu_plugin_read_register(vcpu_index, reg->handle, reg->last);
+    g_assert(r > 0);
+    return reg;
+}
+
+static registers_init(int vcpu_index)
+{
+    GPtrArray *registers = g_ptr_array_new();
+    g_autoptr(GArray) reg_list = qemu_plugin_get_registers(vcpu_index);
+
+    if (reg_list && reg_list->len) {
+        /*
+         * Go through each register in the complete list and
+         * see if we want to track it.
+         */
+        for (int r = 0; r < reg_list->len; r++) {
+            qemu_plugin_reg_descriptor *rd = &g_array_index(
+                reg_list, qemu_plugin_reg_descriptor, r);
+            for (int p = 0; p < rmatches->len; p++) {
+                g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
+                if (g_pattern_match_string(pat, rd->name)) {
+                    Register *reg = init_vcpu_register(vcpu_index, rd);
+                    g_ptr_array_add(registers, reg);
+                }
+            }
+        }
+    }
+    cpus[num_cpus].registers = registers;
+}
+
+/*
+ * Initialise a new vcpu/thread with:
+ *   - last_exec tracking data
+ *   - list of tracked registers
+ *   - initial value of registers
+ *
+ * As we could have multiple threads trying to do this we need to
+ * serialise the expansion under a lock.
+ */
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_rw_lock_writer_lock(&expand_array_lock);
+
+    if (vcpu_index >= num_cpus) {
+        cpus = g_realloc_n(cpus, vcpu_index + 1, sizeof(*cpus));
+        while (vcpu_index >= num_cpus) {
+            cpus[num_cpus].last_exec = g_string_new(NULL);
+
+            /* Any registers to track? */
+            if (rmatches && rmatches->len) {
+                registers_init(vcpu_index);
+            }
+            num_cpus++;
+        }
+    }
+
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
@@ -212,6 +300,18 @@ static void parse_vaddr_match(char *match)
     g_array_append_val(amatches, v);
 }
 
+/*
+ * We have to wait until vCPUs are started before we can check the
+ * patterns find anything.
+ */
+static void add_regpat(char *regpat)
+{
+    if (!rmatches) {
+        rmatches = g_ptr_array_new();
+    }
+    g_ptr_array_add(rmatches, g_strdup(regpat));
+}
+
 /**
  * Install the plugin
  */
@@ -224,9 +324,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
      * we don't know the size before emulation.
      */
     if (info->system_emulation) {
-        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
-    } else {
-        last_exec = g_ptr_array_new();
+        cpus = g_new(CPU, info->system.max_vcpus);
     }
 
     for (int i = 0; i < argc; i++) {
@@ -236,13 +334,16 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
             parse_vaddr_match(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "reg") == 0) {
+            add_regpat(tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
         }
     }
 
-    /* Register translation block and exit callbacks */
+    /* Register init, translation block and exit callbacks */
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
-- 
2.39.2


