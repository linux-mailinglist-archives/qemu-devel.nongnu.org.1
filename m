Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B57804E3
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:42:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJP-0003zp-Ay; Thu, 17 Aug 2023 23:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJN-0003rq-Qk
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJK-00068V-ST
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6887ccba675so403515b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329885; x=1692934685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlrESM4ziTyPXcQLr/4nUdtI4NUuljRvjepiBoMTe8o=;
 b=kkAKcbG0t5HHNzKnGmHL7CQ+OqbPsJBRy6xjmjtlKAHYC7pvqyRtffpUTtVFWIl2Sy
 QdjUjIIlVA+g157GSljw8vKl4c7AI94TEqvVpGwg1rEGQ4dO0FsbVyGhZhtDLegK2tYJ
 C+m6S3NixDmyAjA0KtcYht7SdklRArB5nI672QV4iN7Yt+vIvFSFjKy6+np+jFm6MZjh
 CVr5vWZohCP3vzH1rNLq2FHFx1gqVzyeYos4pK2EpYq/kXLpSF+PISIHry4AMH1D/Hfa
 Ae2+W6Hp7YhLVLIPgyd+ihOqlPiv0hmQEgmAB9VHGbKHEs6YMhYcN7q+6RXen3nmj3yG
 3OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329885; x=1692934685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlrESM4ziTyPXcQLr/4nUdtI4NUuljRvjepiBoMTe8o=;
 b=QtRsH6LMI+RTu8z+JfLGdzfB9jfuz81gdiUjoIkP340WuoqkFL0rqwiErSBYqpKuIF
 Ri3g+kge4wGrIt9MOMnU5tx4OaXiBT62a0Rwb0CjL5nqQjhuXPFBWB+5NH7wh7o9C06E
 MDu7YDi4RfW7SMvdYsn4HA0Zen3XeFMXpGGsGUjE9afg6MQXM4xd1E0tteIwy8FyZkVF
 UFxF5Qgy/rBhBdcQsOQez+FODiNJC+6DKDSOtO4Pe2ofA6LM/+b6gKpxrlyJ5RCwHEiE
 EwsmAcraPG16NO0lDMqUj1jUgy7Kj83QdNihNn/oE9Pi7MYauzGFNH/wNrx7F/zzFI4R
 344Q==
X-Gm-Message-State: AOJu0YwWldA+9jva3nQKrjA8LNaFgwWOn0RkDVr59g/yMJkfDP/F+mv8
 FHJZHJpa0gcNK/BfVO22tvsXlA==
X-Google-Smtp-Source: AGHT+IEo3tGZg7/r+OfsV51hdYg4hColRUNNOuACQtnQZ4vXcSrWueFr6KNvkr5keK2CkkjsXVb5RQ==
X-Received: by 2002:a05:6a00:2d8e:b0:682:a62a:ec36 with SMTP id
 fb14-20020a056a002d8e00b00682a62aec36mr1644669pfb.15.1692329885689; 
 Thu, 17 Aug 2023 20:38:05 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:38:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RESEND v5 24/26] contrib/plugins: Allow to log registers
Date: Fri, 18 Aug 2023 12:36:43 +0900
Message-ID: <20230818033648.8326-25-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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
 docs/devel/tcg-plugins.rst |  10 ++-
 contrib/plugins/execlog.c  | 140 ++++++++++++++++++++++++++++---------
 2 files changed, 117 insertions(+), 33 deletions(-)

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
index 82dc2f584e..aa05840fd0 100644
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
@@ -177,17 +209,53 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
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
@@ -224,9 +292,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
      * we don't know the size before emulation.
      */
     if (info->system_emulation) {
-        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
-    } else {
-        last_exec = g_ptr_array_new();
+        cpus = g_new(CPU, info->system.max_vcpus);
     }
 
     for (int i = 0; i < argc; i++) {
@@ -236,13 +302,23 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


