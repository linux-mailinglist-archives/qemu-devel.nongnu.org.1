Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B74CB7CCBE5
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspTW-0000JL-27; Tue, 17 Oct 2023 15:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspTF-0008B1-50
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:11:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspTB-00028z-Fe
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:11:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so26671465ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697569867; x=1698174667;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCJCzqQ6Ba4FCVkTkN3rupr67lFRisvbzNM+HnYlWm0=;
 b=wCx9+cBPBYOuPjhhIWhitqQNKYHxWc8VYomS3fNHu57li4ASil2QW831Fbio8Xxc1h
 OU9mp0PjAJ0N3MyuHE+wZrrxQgOwP/serpadBTHmpJ+61EOYCAcdBKCfgVZroXoGXLId
 R2ItszOzBe3mifMO8nSuh2DKLyYLKm+Et0JnlNLsEBFotHwMw2cIfZDESMkvRDDVUa+b
 /dS1Y2oQsy3wuYfMLJ4gUS68ZhkDUHEoEsF63TL4BB66+0dZ7lLIyKASK5KlMsSwdkeB
 1NCem0c/JQAk6c9Os5bl9X2GstH8coJKDWYbfeswcL9peMsmZW5NU1DJPx/Z5eOOC8lY
 PCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569867; x=1698174667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCJCzqQ6Ba4FCVkTkN3rupr67lFRisvbzNM+HnYlWm0=;
 b=V7duqywh/4/MDX3TcqDjbqEj33bcFEhjNoI3PSjMPym2zY4zXbnsGxQuEmnVgvUcBo
 83mNPX5or79eixECXZxIM+a5uNZUW8JWOE6xWJCAlKbtf67gReTZFmuIOfDp8guczkcv
 ErQOI1CXMyEGFQDFkIP5Zl1W7Tcj+1tHYVQhRr/q2zt02ezhE4HxIfOT9oWUmGuJ3x5M
 icjRwPVZzXqC1mBfpeCkYeCtVEYMQbzybN7+cuBG1dfJ8vBIFhr8FPbTalAxG02deA0P
 ixXuHSQJM3kUWW97TLJPKytD69TMEIr8hh53KubTuSJnzHIS+Kp+yB1nKQZd+okNlsvc
 +Gmw==
X-Gm-Message-State: AOJu0YwCnr5X2fm5Q97XAfMVjC2TForS/5pJL8NO65kAPaUjPa3VwE3I
 8MvVAADJlo0E/ktRIS3jL8KpAg==
X-Google-Smtp-Source: AGHT+IE7gB78VuywTB620M6mSBzPiFzPuZ9PMvjB3PRPpynrp5I2GDGDU9kB9POVfFALz+pv3d4eDA==
X-Received: by 2002:a17:903:7c4:b0:1ca:79b6:ce42 with SMTP id
 ko4-20020a17090307c400b001ca79b6ce42mr2800569plb.47.1697569867164; 
 Tue, 17 Oct 2023 12:11:07 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 21-20020a170902c21500b001c32fd9e412sm1959372pll.58.2023.10.17.12.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:11:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v13 18/18] contrib/plugins: Allow to log registers
Date: Wed, 18 Oct 2023 04:09:28 +0900
Message-ID: <20231017190931.16211-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190931.16211-1-akihiko.odaki@daynix.com>
References: <20231017190931.16211-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

This demonstrates how a register can be read from a plugin.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/tcg-plugins.rst |  10 +++-
 contrib/plugins/execlog.c  | 120 +++++++++++++++++++++++++++----------
 2 files changed, 97 insertions(+), 33 deletions(-)

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
index 82dc2f584e..f3e714c888 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -15,27 +15,43 @@
 
 #include <qemu-plugin.h>
 
+typedef struct CPU {
+    /* Store last executed instruction on each vCPU as a GString */
+    GString *last_exec;
+    GByteArray *reg_history[2];
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
     g_rw_lock_writer_lock(&expand_array_lock);
-    while (cpu_index >= last_exec->len) {
-        GString *s = g_string_new(NULL);
-        g_ptr_array_add(last_exec, s);
+    if (cpu_index >= num_cpus) {
+        cpus = g_realloc_n(cpus, cpu_index + 1, sizeof(*cpus));
+        while (cpu_index >= num_cpus) {
+            cpus[num_cpus].last_exec = g_string_new(NULL);
+            cpus[num_cpus].reg_history[0] = g_byte_array_new();
+            cpus[num_cpus].reg_history[1] = g_byte_array_new();
+            num_cpus++;
+        }
     }
     g_rw_lock_writer_unlock(&expand_array_lock);
 }
@@ -50,8 +66,8 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
 
     /* Find vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
-    g_assert(cpu_index < last_exec->len);
-    s = g_ptr_array_index(last_exec, cpu_index);
+    g_assert(cpu_index < num_cpus);
+    s = cpus[cpu_index].last_exec;
     g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Indicate type of memory access */
@@ -77,28 +93,42 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
  */
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
-    GString *s;
+    int n;
+    int i;
 
-    /* Find or create vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
-    if (cpu_index >= last_exec->len) {
-        g_rw_lock_reader_unlock(&expand_array_lock);
-        expand_last_exec(cpu_index);
-        g_rw_lock_reader_lock(&expand_array_lock);
-    }
-    s = g_ptr_array_index(last_exec, cpu_index);
-    g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Print previous instruction in cache */
-    if (s->len) {
-        qemu_plugin_outs(s->str);
+    if (cpus[cpu_index].last_exec->len) {
+        if (cpus[cpu_index].reg >= 0) {
+            GByteArray *current = cpus[cpu_index].reg_history[0];
+            GByteArray *last = cpus[cpu_index].reg_history[1];
+
+            g_byte_array_set_size(current, 0);
+            n = qemu_plugin_read_register(current, cpus[cpu_index].reg);
+
+            if (n != last->len || memcmp(current->data, last->data, n)) {
+                g_string_append(cpus[cpu_index].last_exec, ", reg,");
+                for (i = 0; i < n; i++) {
+                    g_string_append_printf(cpus[cpu_index].last_exec, " %02x",
+                                           current->data[i]);
+                }
+            }
+
+            cpus[cpu_index].reg_history[0] = last;
+            cpus[cpu_index].reg_history[1] = current;
+        }
+
+        qemu_plugin_outs(cpus[cpu_index].last_exec->str);
         qemu_plugin_outs("\n");
     }
 
     /* Store new instruction in cache */
     /* vcpu_mem will add memory access information to last_exec */
-    g_string_printf(s, "%u, ", cpu_index);
-    g_string_append(s, (char *)udata);
+    g_string_printf(cpus[cpu_index].last_exec, "%u, ", cpu_index);
+    g_string_append(cpus[cpu_index].last_exec, (char *)udata);
+
+    g_rw_lock_reader_unlock(&expand_array_lock);
 }
 
 /**
@@ -167,8 +197,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
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
@@ -177,17 +209,33 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    int reg = -1;
+
+    expand_cpu(vcpu_index);
+
+    if (rfile_name) {
+        int rfile = qemu_plugin_find_register_file(vcpu_index, rfile_name);
+        if (rfile >= 0) {
+            reg = qemu_plugin_find_register(vcpu_index, rfile, reg_name);
+        }
+    }
+
+    g_rw_lock_writer_lock(&expand_array_lock);
+    cpus[vcpu_index].reg = reg;
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
@@ -224,9 +272,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
      * we don't know the size before emulation.
      */
     if (info->system_emulation) {
-        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
-    } else {
-        last_exec = g_ptr_array_new();
+        cpus = g_new(CPU, info->system.max_vcpus);
     }
 
     for (int i = 0; i < argc; i++) {
@@ -236,13 +282,23 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
2.42.0


