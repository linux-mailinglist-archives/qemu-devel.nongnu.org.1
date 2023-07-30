Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F45768413
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 08:56:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ07n-00052y-Ku; Sun, 30 Jul 2023 02:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07P-00050k-0a; Sun, 30 Jul 2023 02:41:31 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07L-00066U-6J; Sun, 30 Jul 2023 02:41:29 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-76c8dd2ce79so189077785a.1; 
 Sat, 29 Jul 2023 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690699285; x=1691304085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxoiJ1KNHxU2qf88USj0WCY4QRM2Fyx05FkITUz6usI=;
 b=oldkp5AVVpNVmICrBqRCbvUQCGOi7dvyogptA6YwUdSagAkZu0AYKH06m+FSey9DfT
 7bMTQcmDQj3vuKVHQ+YnRSErrB4cvyrIX87gY7X+xyyil61Mrqc3RQcPvbFVxuYcy7Wp
 /qW0S/C4GpoMDSUwu8DV6UpkRtDhUHXHOaXvrcfCd/A5JGBmNhzbuAlafagMelai4p6R
 xhdm4rTuzBcWYousVcfSqkMwUe9VAJwQWssihZ9zVj4iN2qrCFfuN6zNaOClI875NxyM
 R2APp6pQu4i7RXj1I/Pj5/Uiq40C1nbDcuwK6VzL5LCLtDCycymSXRWZUcjxmoIanrKw
 C+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690699285; x=1691304085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxoiJ1KNHxU2qf88USj0WCY4QRM2Fyx05FkITUz6usI=;
 b=P2Ju9nX9RTt3bwPwVv+AKGX5RSLCbPpkF9mJADcuU5qo/RX0ltW/KUzy6GHOmc1/H+
 2TEb0Rjn0M5xTAS+9Ao4Hlyv7zFMQ/pzg2mTabKDX5YEQpKek4422h0Tmd3HimzsayDR
 39MadF1H0C4Y0MWnj8GkXPpzXsUL0LYBFzZ8df+nuOTcok/dx7RxR/+2GmMRu5xsePO2
 bbYhL/syE7dmHQqD4EI1DRoTSYUEnY7ZXVI1fIaU7zrXr1NuGHDvS46XenlLltmnt36e
 cuoIw/ShH2vRICd2D08UVNRe8RlZlqYLqTZfTj/ZBJLuyftTgyOLLt2KdsHblbgxs6os
 NMxQ==
X-Gm-Message-State: ABy/qLaRr3zl1Y9NqpzrcHBT/sCz3SZY+EToI+OfeDPWzRjYQ6b7hlQK
 /KAlzt8ToKq9qa2AdX7FYTncEAMLfy64mA==
X-Google-Smtp-Source: APBJJlHCLjie/HyFoHFEVb5YPQkKb/Wc3HTMeVr+qo5ep3msqKcuxyhF1fDsmqeLVp9OLQVwlplIfA==
X-Received: by 2002:a05:620a:4051:b0:767:197e:4417 with SMTP id
 i17-20020a05620a405100b00767197e4417mr9073351qko.3.1690699284793; 
 Sat, 29 Jul 2023 23:41:24 -0700 (PDT)
Received: from debian.hsd1.ma.comcast.net ([2601:182:cc00:77b0::aecb])
 by smtp.gmail.com with ESMTPSA id
 oq7-20020a05620a610700b00767c961eb47sm2347254qkn.43.2023.07.29.23.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 23:41:24 -0700 (PDT)
From: Dinah Baum <dinahbaum123@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dinah Baum <dinahbaum123@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PATCH v3 2/3] qapi,
 target/: Enable 'query-cpu-model-expansion' on all architectures
Date: Sun, 30 Jul 2023 02:40:56 -0400
Message-Id: <20230730064057.357598-3-dinahbaum123@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230730064057.357598-1-dinahbaum123@gmail.com>
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=dinahbaum123@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Only architectures that implement the command will return
results, others will return an error message as before.

Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
---
 cpu.c                            | 20 +++++++++++
 include/exec/cpu-common.h        |  7 ++++
 qapi/machine-target.json         | 60 --------------------------------
 qapi/machine.json                | 53 ++++++++++++++++++++++++++++
 target/arm/arm-qmp-cmds.c        |  7 ++--
 target/arm/cpu.h                 |  7 ++++
 target/i386/cpu-sysemu.c         |  7 ++--
 target/i386/cpu.h                |  6 ++++
 target/s390x/cpu.h               |  7 ++++
 target/s390x/cpu_models_sysemu.c |  6 ++--
 10 files changed, 110 insertions(+), 70 deletions(-)

diff --git a/cpu.c b/cpu.c
index 1c948d1161..a99d09cd47 100644
--- a/cpu.c
+++ b/cpu.c
@@ -292,6 +292,26 @@ void list_cpus(void)
 #endif
 }
 
+CpuModelExpansionInfo *get_cpu_model_expansion_info(CpuModelExpansionType type,
+                                                    CpuModelInfo *model,
+                                                    Error **errp)
+{
+    /* XXX: implement cpu_model_expansion for targets that still miss it */
+#if defined(cpu_model_expansion)
+    return cpu_model_expansion(type, model, errp);
+#else
+    error_setg(errp, "Could not query cpu model information");
+    return NULL;
+#endif
+}
+
+CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                                                     CpuModelInfo *model,
+                                                     Error **errp)
+{
+    return get_cpu_model_expansion_info(type, model, errp);
+}
+
 #if defined(CONFIG_USER_ONLY)
 void tb_invalidate_phys_addr(hwaddr addr)
 {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 87dc9a752c..653f8a9d2b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -6,6 +6,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
+#include "qapi/qapi-commands-machine.h"
 
 /**
  * vaddr:
@@ -167,4 +168,10 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 /* vl.c */
 void list_cpus(void);
 
+CpuModelExpansionInfo *get_cpu_model_expansion_info(CpuModelExpansionType type,
+                                                    CpuModelInfo *model,
+                                                    Error **errp);
+void list_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model, Error **errp);
+
 #endif /* CPU_COMMON_H */
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 3ee2f7ca6b..a658b1754b 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -139,66 +139,6 @@
   'returns': 'CpuModelBaselineInfo',
   'if': 'TARGET_S390X' }
 
-##
-# @CpuModelExpansionInfo:
-#
-# The result of a cpu model expansion.
-#
-# @model: the expanded CpuModelInfo.
-#
-# Since: 2.8
-##
-{ 'struct': 'CpuModelExpansionInfo',
-  'data': { 'model': 'CpuModelInfo' },
-  'if': { 'any': [ 'TARGET_S390X',
-                   'TARGET_I386',
-                   'TARGET_ARM' ] } }
-
-##
-# @query-cpu-model-expansion:
-#
-# Expands a given CPU model (or a combination of CPU model +
-# additional options) to different granularities, allowing tooling to
-# get an understanding what a specific CPU model looks like in QEMU
-# under a certain configuration.
-#
-# This interface can be used to query the "host" CPU model.
-#
-# The data returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU
-#   version.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine-type: CPU model may look different depending on the
-#   machine-type.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine options (including accelerator): in some architectures,
-#   CPU models may look different depending on machine and accelerator
-#   options.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu
-#   option and global properties may affect expansion of CPU models.
-#   Using query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support all expansion types.  s390x
-# supports "full" and "static". Arm only supports "full".
-#
-# Returns: a CpuModelExpansionInfo.  Returns an error if expanding CPU
-#     models is not supported, if the model cannot be expanded, if the
-#     model contains an unknown CPU definition name, unknown
-#     properties or properties with a wrong type.  Also returns an
-#     error if an expansion type is not supported.
-#
-# Since: 2.8
-##
-{ 'command': 'query-cpu-model-expansion',
-  'data': { 'type': 'CpuModelExpansionType',
-            'model': 'CpuModelInfo' },
-  'returns': 'CpuModelExpansionInfo',
-  'if': { 'any': [ 'TARGET_S390X',
-                   'TARGET_I386',
-                   'TARGET_ARM' ] } }
-
 ##
 # @CpuDefinitionInfo:
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 192c781310..f24e19815e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1768,3 +1768,56 @@
 ##
 { 'enum': 'CpuModelCompareResult',
   'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
+
+##
+# @CpuModelExpansionInfo:
+#
+# The result of a cpu model expansion.
+#
+# @model: the expanded CpuModelInfo.
+#
+# Since: 2.8
+##
+{ 'struct': 'CpuModelExpansionInfo',
+  'data': { 'model': 'CpuModelInfo' }}
+
+##
+# @query-cpu-model-expansion:
+#
+# Expands a given CPU model (or a combination of CPU model +
+# additional options) to different granularities, allowing tooling to
+# get an understanding what a specific CPU model looks like in QEMU
+# under a certain configuration.
+#
+# This interface can be used to query the "host" CPU model.
+#
+# The data returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU
+#   version.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine-type: CPU model may look different depending on the
+#   machine-type.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine options (including accelerator): in some architectures,
+#   CPU models may look different depending on machine and accelerator
+#   options.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu
+#   option and global properties may affect expansion of CPU models.
+#   Using query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support all expansion types.  s390x
+# supports "full" and "static". Arm only supports "full".
+#
+# Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU
+#     models is not supported, if the model cannot be expanded, if the
+#     model contains an unknown CPU definition name, unknown
+#     properties or properties with a wrong type.  Also returns an
+#     error if an expansion type is not supported.
+#
+# Since: 2.8
+##
+{ 'command': 'query-cpu-model-expansion',
+  'data': { 'type': 'CpuModelExpansionType', 'model': 'CpuModelInfo' },
+  'returns': 'CpuModelExpansionInfo'}
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index c8fa524002..295d690e93 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -22,6 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/boards.h"
+#include "cpu.h"
 #include "kvm_arm.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -99,9 +100,9 @@ static const char *cpu_model_advertised_features[] = {
     NULL
 };
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
+                                               CpuModelInfo *model,
+                                               Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
     const QDict *qdict_in = NULL;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda6..71b15d4884 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2740,6 +2740,13 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 
 #define cpu_list arm_cpu_list
 
+#ifdef CONFIG_SOFTMMU
+CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
+                                               CpuModelInfo *model,
+                                               Error **errp);
+#define cpu_model_expansion get_cpu_model_expansion
+#endif
+
 /* ARM has the following "translation regimes" (as the ARM ARM calls them):
  *
  * If EL3 is 64-bit:
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 28115edf44..c01c85839c 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -176,10 +176,9 @@ out:
     return xc;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
+                                               CpuModelInfo *model,
+                                               Error **errp)
 {
     X86CPU *xc = NULL;
     Error *err = NULL;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..699b987d12 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2249,6 +2249,12 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #endif
 
 #define cpu_list x86_cpu_list
+#ifdef CONFIG_SOFTMMU
+CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
+                                               CpuModelInfo *model,
+                                               Error **errp);
+#define cpu_model_expansion get_cpu_model_expansion
+#endif
 
 /* MMU modes definitions */
 #define MMU_KSMAP_IDX   0
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index eb5b65b7d3..932f8b642a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -804,6 +804,13 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
 /* cpu_models.c */
 void s390_cpu_list(void);
 #define cpu_list s390_cpu_list
+#ifdef CONFIG_SOFTMMU
+CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
+                                               CpuModelInfo *model,
+                                               Error **errp);
+#define cpu_model_expansion get_cpu_model_expansion
+#endif
+
 void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
                              const S390FeatInit feat_init);
 
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 63981bf36b..ef3845f11c 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -213,9 +213,9 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     }
 }
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
+                                               CpuModelInfo *model,
+                                               Error **errp)
 {
     Error *err = NULL;
     CpuModelExpansionInfo *expansion_info = NULL;
-- 
2.30.2


