Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A737E09E1
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:07:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0Qs-0003b6-OA; Fri, 03 Nov 2023 16:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Qp-0003XK-T7
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:06:16 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Qh-0006vj-Il
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:06:15 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c50d1b9f22so33604471fa.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699041966; x=1699646766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gobOZLUm4tucaoiLfVGUn6DQENUE7jBPnm4hmBlkNA=;
 b=yi0dlQqpJKxFeDRF79dgpSS7Vld4lhsOY6DCqsFdjwijkGO26pNJR5al7dylcN7he4
 PFXzKsfz67ZshKpoEMU11dDBAS18LulXoLzWp11+YB7Gcc2cHh4zh5nnZGU2snyvOkIk
 pnDLlpct2YMcnFoOd3qe7i6VGyZ5s/C8rAWaZgrh8DcQuUpDr9RbFKTeg+VpvIOOejzQ
 h888zcfKLMvLob0NNiQUP49LTrqb0CRiAqYePOWYeJkO0szruRgGHNzwhF1yxUrpn53k
 G28YAHR/z6J2/gUOrtIagehpys0uVC6/TzeV+EKZg78Vq451azvH8RzYmv8egu0P6RQ0
 VEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041966; x=1699646766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gobOZLUm4tucaoiLfVGUn6DQENUE7jBPnm4hmBlkNA=;
 b=v1EEOAGeSLLp9Lmk0WFN+SpqmV972aFyFeZsvncBRBlt7/j5q4zH01GlcgREyNXW8O
 ZQpF9sz/FWfskK4CkZOpCI20Fom/0Al167Ia7DpDmX/YaJy/toQuXTTjo4J/tSViZX6K
 /Ijwy9yjgQagc5AT6myWAP0rtsaPOp9SJGR1SlSl1IKzodVV2wYa/Vry0l9nshUq2qUw
 zWzOKnvbb4BBRz/1OUTtUeOEha3/PQDeSyZbqSrWUwOHFlE3H4ORg/MCyb4k2amMGgcp
 WoxfPwtP+p+AgPA8dQ9NOOykQP7WAzCOIlM0xZERiqTjutTHddoUEXUKxaJCQYWpWW3i
 2OBw==
X-Gm-Message-State: AOJu0YxXfKN/Cp5d/4mkLxTJQ9wMY/LUMzGulXo6vrc8hoEwsUYLzUFC
 iDMw7utMjL/XMYIx1GLaxmk5Les8DvCLy5ewoM/6PQ==
X-Google-Smtp-Source: AGHT+IF7Hf529Sxcdq8ZF3WQPfYB+xRGuuOq7U3ESZ5iugJ0IaIgYCb8LVpZ5fysidxCxTcMePXFSw==
X-Received: by 2002:a2e:155c:0:b0:2c6:ed6a:780f with SMTP id
 28-20020a2e155c000000b002c6ed6a780fmr5120801ljv.11.1699041965654; 
 Fri, 03 Nov 2023 13:06:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g23-20020a7bc4d7000000b004063cd8105csm3381219wmk.22.2023.11.03.13.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 13:06:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 850D56574D;
 Fri,  3 Nov 2023 19:59:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Brian Cain <bcain@quicinc.com>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 17/29] gdbstub: Simplify XML lookup
Date: Fri,  3 Nov 2023 19:59:44 +0000
Message-Id: <20231103195956.1998255-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103195956.1998255-1-alex.bennee@linaro.org>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Now we know all instances of GDBFeature that is used in CPU so we can
traverse them to find XML. This removes the need for a CPU-specific
lookup function for dynamic XMLs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231025093128.33116-11-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h |   6 +++
 gdbstub/gdbstub.c      | 118 +++++++++++++++++++++--------------------
 hw/core/cpu-common.c   |   5 +-
 3 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index bcaab1bc75..82a8afa237 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -27,6 +27,12 @@ typedef struct GDBFeatureBuilder {
 typedef int (*gdb_get_reg_cb)(CPUState *cpu, GByteArray *buf, int reg);
 typedef int (*gdb_set_reg_cb)(CPUState *cpu, uint8_t *buf, int reg);
 
+/**
+ * gdb_init_cpu(): Initialize the CPU for gdbstub.
+ * @cpu: The CPU to be initialized.
+ */
+void gdb_init_cpu(CPUState *cpu);
+
 /**
  * gdb_register_coprocessor() - register a supplemental set of registers
  * @cpu - the CPU associated with registers
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 4809c90c4a..5ecd1f23e6 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -352,6 +352,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
 {
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    GDBRegisterState *r;
     size_t len;
 
     /*
@@ -365,7 +366,6 @@ static const char *get_feature_xml(const char *p, const char **newp,
     /* Is it the main target xml? */
     if (strncmp(p, "target.xml", len) == 0) {
         if (!process->target_xml) {
-            GDBRegisterState *r;
             g_autoptr(GPtrArray) xml = g_ptr_array_new_with_free_func(g_free);
 
             g_ptr_array_add(
@@ -380,18 +380,12 @@ static const char *get_feature_xml(const char *p, const char **newp,
                     g_markup_printf_escaped("<architecture>%s</architecture>",
                                             cc->gdb_arch_name(cpu)));
             }
-            g_ptr_array_add(
-                xml,
-                g_markup_printf_escaped("<xi:include href=\"%s\"/>",
-                                        cc->gdb_core_xml_file));
-            if (cpu->gdb_regs) {
-                for (guint i = 0; i < cpu->gdb_regs->len; i++) {
-                    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-                    g_ptr_array_add(
-                        xml,
-                        g_markup_printf_escaped("<xi:include href=\"%s\"/>",
-                                                r->feature->xmlname));
-                }
+            for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+                r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+                g_ptr_array_add(
+                    xml,
+                    g_markup_printf_escaped("<xi:include href=\"%s\"/>",
+                                            r->feature->xmlname));
             }
             g_ptr_array_add(xml, g_strdup("</target>"));
             g_ptr_array_add(xml, NULL);
@@ -400,20 +394,11 @@ static const char *get_feature_xml(const char *p, const char **newp,
         }
         return process->target_xml;
     }
-    /* Is it dynamically generated by the target? */
-    if (cc->gdb_get_dynamic_xml) {
-        g_autofree char *xmlname = g_strndup(p, len);
-        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
-        if (xml) {
-            return xml;
-        }
-    }
-    /* Is it one of the encoded gdb-xml/ files? */
-    for (int i = 0; gdb_static_features[i].xmlname; i++) {
-        const char *name = gdb_static_features[i].xmlname;
-        if ((strncmp(name, p, len) == 0) &&
-            strlen(name) == len) {
-            return gdb_static_features[i].xml;
+    /* Is it one of the features? */
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (strncmp(p, r->feature->xmlname, len) == 0) {
+            return r->feature->xml;
         }
     }
 
@@ -508,12 +493,10 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
         return cc->gdb_read_register(cpu, buf, reg);
     }
 
-    if (cpu->gdb_regs) {
-        for (guint i = 0; i < cpu->gdb_regs->len; i++) {
-            r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
-                return r->get_reg(cpu, buf, reg - r->base_reg);
-            }
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
+            return r->get_reg(cpu, buf, reg - r->base_reg);
         }
     }
     return 0;
@@ -528,51 +511,70 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
         return cc->gdb_write_register(cpu, mem_buf, reg);
     }
 
-    if (cpu->gdb_regs) {
-        for (guint i = 0; i < cpu->gdb_regs->len; i++) {
-            r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
-                return r->set_reg(cpu, mem_buf, reg - r->base_reg);
-            }
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
+            return r->set_reg(cpu, mem_buf, reg - r->base_reg);
         }
     }
     return 0;
 }
 
+static void gdb_register_feature(CPUState *cpu, int base_reg,
+                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
+                                 const GDBFeature *feature)
+{
+    GDBRegisterState s = {
+        .base_reg = base_reg,
+        .get_reg = get_reg,
+        .set_reg = set_reg,
+        .feature = feature
+    };
+
+    g_array_append_val(cpu->gdb_regs, s);
+}
+
+void gdb_init_cpu(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const GDBFeature *feature;
+
+    cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
+
+    if (cc->gdb_core_xml_file) {
+        feature = gdb_find_static_feature(cc->gdb_core_xml_file);
+        gdb_register_feature(cpu, 0,
+                             cc->gdb_read_register, cc->gdb_write_register,
+                             feature);
+    }
+
+    cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
+}
+
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               const GDBFeature *feature, int g_pos)
 {
     GDBRegisterState *s;
     guint i;
+    int base_reg = cpu->gdb_num_regs;
 
-    if (cpu->gdb_regs) {
-        for (i = 0; i < cpu->gdb_regs->len; i++) {
-            /* Check for duplicates.  */
-            s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (s->feature == feature) {
-                return;
-            }
+    for (i = 0; i < cpu->gdb_regs->len; i++) {
+        /* Check for duplicates.  */
+        s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (s->feature == feature) {
+            return;
         }
-    } else {
-        cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
-        i = 0;
     }
 
-    g_array_set_size(cpu->gdb_regs, i + 1);
-    s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-    s->base_reg = cpu->gdb_num_regs;
-    s->get_reg = get_reg;
-    s->set_reg = set_reg;
-    s->feature = feature;
+    gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += feature->num_regs;
     if (g_pos) {
-        if (g_pos != s->base_reg) {
+        if (g_pos != base_reg) {
             error_report("Error: Bad gdb register numbering for '%s', "
-                         "expected %d got %d", feature->xml,
-                         g_pos, s->base_reg);
+                         "expected %d got %d", feature->xml, g_pos, base_reg);
         } else {
             cpu->gdb_num_g_regs = cpu->gdb_num_regs;
         }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index bab8942c30..2a2a6eb3eb 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -27,6 +27,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "exec/cpu-common.h"
+#include "exec/gdbstub.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
@@ -223,11 +224,10 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
-    CPUClass *cc = CPU_GET_CLASS(obj);
 
+    gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
-    cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
@@ -247,6 +247,7 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+    g_array_free(cpu->gdb_regs, TRUE);
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);
 }
-- 
2.39.2


