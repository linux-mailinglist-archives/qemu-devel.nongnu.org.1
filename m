Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C4082ED10
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:51:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzq-0002UN-JS; Tue, 16 Jan 2024 05:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzi-0002Q1-4O
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:34 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzb-0007HD-LV
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:33 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33765009941so7974145f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402106; x=1706006906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeAIY9ILFwzXziTWSktM6a0wpE6bikgIUyQ7HG+yeNc=;
 b=FV+IyuXaU+rcN57uq41ItpYG393tEKPQFB7CuNu+le47FKMuZLIwg8YChiE+knTa5L
 yebKEVGZgB5yJR44tu/Ove0XhO2lE6BNCz5SDwIFoTzg4UPfoUPSa7tBGkK37kLddke8
 SwsiXXKY3Xii/pvqYIkIZ4gkhulc8vgfx2G9ecEgwdvM+MX2LmxCANhk1pFOhHcVNkWz
 +hiCavi+AI8KZuDcdD3Zw1hW2q2DgHe1WjGTHex/21rQiM/Bz5t3DpB7IrcN/ps6lsdg
 QLFFu8l5ZI6xiJgkUzn+YjQtTVHImqHu1NbhyhO16igFnrUEtHbvMJST9KL03890eEG1
 MrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402106; x=1706006906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeAIY9ILFwzXziTWSktM6a0wpE6bikgIUyQ7HG+yeNc=;
 b=Uv03qXmKgBGoOYnwdpTrAIlAu8viHSMEWFQGMhu4mzkoQr6/TFuY+1gSEvNrzZq0xK
 iyiuP3fU9azZErN/UKF1TW4OOMyLMEbjBNjmE5dLryM8ZaSYvu5YiTMqjl0t0dhjQw4I
 krGIzvfB3vGJ+WWoYQz0UF70Jm5i4Em6HQ5iyvcn0i57k4MtVkGBlSAkvkXOVhiycn7e
 5tb9A3yCosG0pqYvVJQVFRF46/Nk3UuqQandpI3HORWpHE7F7nclcfkurm6Q/6/qfpjg
 Yamskdpc6xnXjkGHgSWHXB7jX3FfOODlIyWrJcfJzfNLx60soj/WwLegVZo2PxHC5Ft0
 eqRg==
X-Gm-Message-State: AOJu0YyrJ4Mvn0cOPNIheaEobjeIhIcgEiLB6gWQIz5eD4dQPEcczcPr
 OKkeL2iAmpFpt/E9H4+KrnXeZI/C84dRzw==
X-Google-Smtp-Source: AGHT+IEaKYy2pmGl8uRTOzwVnmJfYasMWUYXYHZpExbEU4w2uoKfVTlYXLL84plNFV/C4xh4D5ppOw==
X-Received: by 2002:adf:ec92:0:b0:336:7b7f:781a with SMTP id
 z18-20020adfec92000000b003367b7f781amr4090239wrn.25.1705402106319; 
 Tue, 16 Jan 2024 02:48:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i6-20020adfb646000000b003378d89737fsm13901658wre.46.2024.01.16.02.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 685EB5F926;
 Tue, 16 Jan 2024 10:48:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 20/22] contrib/plugins: optimise the register value tracking
Date: Tue, 16 Jan 2024 10:48:07 +0000
Message-Id: <20240116104809.250076-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

This adds an additional flag which attempts to optimise the register
tracking by only instrumenting instructions which are likely to change
its value. This relies on the disassembler showing up the register
names in disassembly so is only enabled when asked for.

Message-Id: <20240103173349.398526-42-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 3a0962723d7..fa7421279f5 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -503,7 +503,15 @@ registers with multiple ``reg`` options. You can also use glob style matching if
   $ qemu-system-arm $(QEMU_ARGS) \
     -plugin ./contrib/plugins/libexeclog.so,reg=\*_el2,reg=sp -d plugin
 
-Be aware that each additional register to check will slow down execution quite considerably.
+Be aware that each additional register to check will slow down
+execution quite considerably. You can optimise the number of register
+checks done by using the rdisas option. This will only instrument
+instructions that mention the registers in question in disassembly.
+This is not foolproof as some instructions implicitly change
+instructions. You can use the ifilter to catch these cases:
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,ifilter=msr,ifilter=blr,reg=x30,reg=\*_el1,rdisas=on
 
 - contrib/plugins/cache.c
 
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index c20e88a6941..5a4de1c93be 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -27,6 +27,7 @@ typedef struct CPU {
     GString *last_exec;
     /* Ptr array of Register */
     GPtrArray *registers;
+    int index;
 } CPU;
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -38,6 +39,9 @@ static GRWLock expand_array_lock;
 static GPtrArray *imatches;
 static GArray *amatches;
 static GPtrArray *rmatches;
+static bool disas_assist;
+static GMutex add_reg_name_lock;
+static GPtrArray *all_reg_names;
 
 /**
  * Add memory read or write information to current instruction log
@@ -72,9 +76,14 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
 }
 
 /**
- * Log instruction execution
+ * Log instruction execution, outputting the last one.
+ *
+ * vcpu_insn_exec() is a copy and paste of vcpu_insn_exec_with_regs()
+ * without the checking of register values when we've attempted to
+ * optimise with disas_assist.
  */
-static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+
+static CPU *get_cpu(int cpu_index)
 {
     CPU *cpu;
 
@@ -83,29 +92,42 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     cpu = &cpus[cpu_index];
     g_rw_lock_reader_unlock(&expand_array_lock);
 
+    return cpu;
+}
+
+static void insn_check_regs(CPU *cpu)
+{
+    for (int n = 0; n < cpu->registers->len; n++) {
+        Register *reg = cpu->registers->pdata[n];
+        int sz;
+
+        g_byte_array_set_size(reg->new, 0);
+        sz = qemu_plugin_read_register(cpu->index, reg->handle, reg->new);
+        g_assert(sz == reg->last->len);
+
+        if (memcmp(reg->last->data, reg->new->data, sz)) {
+            GByteArray *temp = reg->last;
+            g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
+            /* TODO: handle BE properly */
+            for (int i = sz; i >= 0; i--) {
+                g_string_append_printf(cpu->last_exec, "%02x",
+                                       reg->new->data[i]);
+            }
+            reg->last = reg->new;
+            reg->new = temp;
+        }
+    }
+}
+
+/* Log last instruction while checking registers */
+static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
+{
+    CPU *cpu = get_cpu(cpu_index);
+
     /* Print previous instruction in cache */
     if (cpu->last_exec->len) {
         if (cpu->registers) {
-            for (int n = 0; n < cpu->registers->len; n++) {
-                Register *reg = cpu->registers->pdata[n];
-                int sz;
-
-                g_byte_array_set_size(reg->new, 0);
-                sz = qemu_plugin_read_register(cpu_index, reg->handle, reg->new);
-                g_assert(sz == reg->last->len);
-
-                if (memcmp(reg->last->data, reg->new->data, sz)) {
-                    GByteArray *temp = reg->last;
-                    g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
-                    /* TODO: handle BE properly */
-                    for (int i = sz; i >= 0; i--) {
-                        g_string_append_printf(cpu->last_exec, "%02x",
-                                               reg->new->data[i]);
-                    }
-                    reg->last = reg->new;
-                    reg->new = temp;
-                }
-            }
+            insn_check_regs(cpu);
         }
 
         qemu_plugin_outs(cpu->last_exec->str);
@@ -114,8 +136,44 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 
     /* Store new instruction in cache */
     /* vcpu_mem will add memory access information to last_exec */
-    g_string_printf(cpus[cpu_index].last_exec, "%u, ", cpu_index);
-    g_string_append(cpus[cpu_index].last_exec, (char *)udata);
+    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
+    g_string_append(cpu->last_exec, (char *)udata);
+}
+
+/* Log last instruction while checking registers, ignore next */
+static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
+{
+    CPU *cpu = get_cpu(cpu_index);
+
+    /* Print previous instruction in cache */
+    if (cpu->last_exec->len) {
+        if (cpu->registers) {
+            insn_check_regs(cpu);
+        }
+
+        qemu_plugin_outs(cpu->last_exec->str);
+        qemu_plugin_outs("\n");
+    }
+
+    /* reset */
+    cpu->last_exec->len = 0;
+}
+
+/* Log last instruction without checking regs, setup next */
+static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+{
+    CPU *cpu = get_cpu(cpu_index);
+
+    /* Print previous instruction in cache */
+    if (cpu->last_exec->len) {
+        qemu_plugin_outs(cpu->last_exec->str);
+        qemu_plugin_outs("\n");
+    }
+
+    /* Store new instruction in cache */
+    /* vcpu_mem will add memory access information to last_exec */
+    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
+    g_string_append(cpu->last_exec, (char *)udata);
 }
 
 /**
@@ -128,6 +186,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     struct qemu_plugin_insn *insn;
     bool skip = (imatches || amatches);
+    bool check_regs_this = rmatches;
+    bool check_regs_next = false;
 
     size_t n = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < n; i++) {
@@ -148,7 +208,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         /*
          * If we are filtering we better check out if we have any
          * hits. The skip "latches" so we can track memory accesses
-         * after the instruction we care about.
+         * after the instruction we care about. Also enable register
+         * checking on the next instruction.
          */
         if (skip && imatches) {
             int j;
@@ -156,6 +217,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                 char *m = g_ptr_array_index(imatches, j);
                 if (g_str_has_prefix(insn_disas, m)) {
                     skip = false;
+                    check_regs_next = rmatches;
                 }
             }
         }
@@ -170,8 +232,39 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             }
         }
 
+        /*
+         * Check the disassembly to see if a register we care about
+         * will be affected by this instruction. This relies on the
+         * dissembler doing something sensible for the registers we
+         * care about.
+         */
+        if (disas_assist && rmatches) {
+            check_regs_next = false;
+            gchar *args = g_strstr_len(insn_disas, -1, " ");
+            for (int n = 0; n < all_reg_names->len; n++) {
+                gchar *reg = g_ptr_array_index(all_reg_names, n);
+                if (g_strrstr(args, reg)) {
+                    check_regs_next = true;
+                    skip = false;
+                }
+            }
+        }
+
+        /*
+         * We now have 3 choices:
+         *
+         * - Log insn
+         * - Log insn while checking registers
+         * - Don't log this insn but check if last insn changed registers
+         */
+
         if (skip) {
-            g_free(insn_disas);
+            if (check_regs_this) {
+                qemu_plugin_register_vcpu_insn_exec_cb(insn,
+                                                       vcpu_insn_exec_only_regs,
+                                                       QEMU_PLUGIN_CB_R_REGS,
+                                                       NULL);
+            }
         } else {
             uint32_t insn_opcode;
             insn_opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
@@ -184,15 +277,28 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                              QEMU_PLUGIN_MEM_RW, NULL);
 
             /* Register callback on instruction */
-            qemu_plugin_register_vcpu_insn_exec_cb(
-                insn, vcpu_insn_exec,
-                rmatches ? QEMU_PLUGIN_CB_R_REGS : QEMU_PLUGIN_CB_NO_REGS,
-                output);
+            if (check_regs_this) {
+                qemu_plugin_register_vcpu_insn_exec_cb(
+                    insn, vcpu_insn_exec_with_regs,
+                    QEMU_PLUGIN_CB_R_REGS,
+                    output);
+            } else {
+                qemu_plugin_register_vcpu_insn_exec_cb(
+                    insn, vcpu_insn_exec,
+                    QEMU_PLUGIN_CB_NO_REGS,
+                    output);
+            }
 
             /* reset skip */
             skip = (imatches || amatches);
         }
 
+        /* set regs for next */
+        if (disas_assist && rmatches) {
+            check_regs_this = check_regs_next;
+        }
+
+        g_free(insn_disas);
     }
 }
 
@@ -200,10 +306,11 @@ static Register *init_vcpu_register(int vcpu_index,
                                     qemu_plugin_reg_descriptor *desc)
 {
     Register *reg = g_new0(Register, 1);
+    g_autofree gchar *lower = g_utf8_strdown(desc->name, -1);
     int r;
 
     reg->handle = desc->handle;
-    reg->name = g_strdup(desc->name);
+    reg->name = g_intern_string(lower);
     reg->last = g_byte_array_new();
     reg->new = g_byte_array_new();
 
@@ -213,7 +320,7 @@ static Register *init_vcpu_register(int vcpu_index,
     return reg;
 }
 
-static registers_init(int vcpu_index)
+static void registers_init(int vcpu_index)
 {
     GPtrArray *registers = g_ptr_array_new();
     g_autoptr(GArray) reg_list = qemu_plugin_get_registers(vcpu_index);
@@ -228,9 +335,20 @@ static registers_init(int vcpu_index)
                 reg_list, qemu_plugin_reg_descriptor, r);
             for (int p = 0; p < rmatches->len; p++) {
                 g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
-                if (g_pattern_match_string(pat, rd->name)) {
+                g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
+                if (g_pattern_match_string(pat, rd->name) ||
+                    g_pattern_match_string(pat, rd_lower)) {
                     Register *reg = init_vcpu_register(vcpu_index, rd);
                     g_ptr_array_add(registers, reg);
+
+                    /* we need a list of regnames at TB translation time */
+                    if (disas_assist) {
+                        g_mutex_lock(&add_reg_name_lock);
+                        if (!g_ptr_array_find(all_reg_names, reg->name, NULL)) {
+                            g_ptr_array_add(all_reg_names, reg->name);
+                        }
+                        g_mutex_unlock(&add_reg_name_lock);
+                    }
                 }
             }
         }
@@ -254,6 +372,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     if (vcpu_index >= num_cpus) {
         cpus = g_realloc_n(cpus, vcpu_index + 1, sizeof(*cpus));
         while (vcpu_index >= num_cpus) {
+            cpus[num_cpus].index = vcpu_index;
             cpus[num_cpus].last_exec = g_string_new(NULL);
 
             /* Any registers to track? */
@@ -336,6 +455,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             parse_vaddr_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "reg") == 0) {
             add_regpat(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "rdisas") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &disas_assist)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+            all_reg_names = g_ptr_array_new();
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.39.2


