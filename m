Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9C793802
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:22:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdof7-0003KI-3x; Wed, 06 Sep 2023 05:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdof4-0003Iz-Ii
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:22 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdof1-0005l2-MM
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:22 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c09f1f4610so559782a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991838; x=1694596638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUviRQA1sK0A4rpWZqbYotX2RmzhgK7a82GEIjW761U=;
 b=M7+PgIYuD+BCk23bG5nx0uw/syESxzQjyJoEtLrQkH3/Bpl3pntsNxWTHC4/nDQBYo
 ZY+D6Ju9CngFHEY13E6hMgG4bd3ph7dvJNTPiOY27BM3jTf7fgquesz1o/qiW5w5tzMz
 ZZr1TiQa8v1uAx9fm7Wa5H6iq7Hg1VvZSNmdNTPtmn+skqDoqXd7meMDSdFd1SQDQic1
 ozb7LMkKskMYVvFlF/iRyxw2lIOpTF/FAp3VtA/B18GgEygU0olF00hJwihvlQmRG8yy
 mgLpvqw1L32m0/VxK51p9fiFpmHiwBaDDo5AN3Bnhsma7C5kkNCR8N6YsGMEKRBrqRP1
 rX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991838; x=1694596638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUviRQA1sK0A4rpWZqbYotX2RmzhgK7a82GEIjW761U=;
 b=Qk1Tpa3vco4Cpm9VDL5uwWHZVFuAiY/NvhZMG9zM7p06Odmjorb3FGdVJElyd0yJ3C
 rNhoEGnANWz7vyXcDqSDmBK8LgK18I4hYxoCVg4BAdG5C45tgjPsgYwee3b52VQG8U+C
 UoVZ4Pg+ZwdjVEzNmpiBT10vUy/gL2yKhH85s5PUCuGWzvJuAcqd/w+qRIMH4psPFSBQ
 DO/eRVdtj2sNOux7/ihe8HMFCB93/CWgytmGJfvHo6QPqqIYUvsDhlxY8hGX6M0KXdyl
 9lz8ZdrSutSlLFgeIR52imDhePmY8H1UG9OWUknxr2bRu8tHqeXjH1IW8V6UFZ7+LSS1
 CQHQ==
X-Gm-Message-State: AOJu0YyWsMfXKX9EnFc6qhhMe0tvfWkKVrJW0qCDTc+S2fMycFv+D+v5
 h/4Jstm8zJ/0Xt7ksCns8zdwEfaiOh9z0OW7l4k=
X-Google-Smtp-Source: AGHT+IHHJ4BakLsSqcRaLPSHIpoQ31GrNdvqrjrOmsExPupkuwYYwuDhiUUjzvqTcsZxux1nz2b6+A==
X-Received: by 2002:a05:6830:1510:b0:6bd:bcd:43f8 with SMTP id
 k16-20020a056830151000b006bd0bcd43f8mr15413569otp.21.1693991838455; 
 Wed, 06 Sep 2023 02:17:18 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:17:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 07/19] target/riscv/cpu.c: mark extensions arrays as 'const'
Date: Wed,  6 Sep 2023 06:16:34 -0300
Message-ID: <20230906091647.1667171-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
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

We'll need to export these arrays to the accelerator classes in the next
patches. Mark them as 'const' now because they should not be modified at
runtime.

Note that 'riscv_cpu_options' will also be exported, but can't be marked
as 'const', because the properties are changed via
qdev_property_add_static().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c15bb572d4..50c2819d68 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1407,7 +1407,7 @@ typedef struct RISCVCPUMultiExtConfig {
     {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .enabled = _defval}
 
-static RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
+static const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
@@ -1469,7 +1469,7 @@ static RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
+static const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
     MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
     MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
@@ -1487,7 +1487,7 @@ static RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 };
 
 /* These are experimental so mark with 'x-' */
-static RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+static const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     /* ePMP 0.9.3 */
     MULTI_EXT_CFG_BOOL("x-epmp", epmp, false),
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
@@ -1558,7 +1558,7 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 }
 
 static void cpu_add_multi_ext_prop(Object *cpu_obj,
-                                   RISCVCPUMultiExtConfig *multi_cfg)
+                                   const RISCVCPUMultiExtConfig *multi_cfg)
 {
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
@@ -1594,11 +1594,13 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
 #endif
 
 static void riscv_cpu_add_multiext_prop_array(Object *obj,
-                                              RISCVCPUMultiExtConfig *array)
+                                        const RISCVCPUMultiExtConfig *array)
 {
+    const RISCVCPUMultiExtConfig *prop;
+
     g_assert(array);
 
-    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
+    for (prop = array; prop && prop->name; prop++) {
         cpu_add_multi_ext_prop(obj, prop);
     }
 }
@@ -1622,11 +1624,13 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
 }
 
 static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
-                                                 RISCVCPUMultiExtConfig *array)
+                                        const RISCVCPUMultiExtConfig *array)
 {
+    const RISCVCPUMultiExtConfig *prop;
+
     g_assert(array);
 
-    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
+    for (prop = array; prop && prop->name; prop++) {
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 }
@@ -1689,7 +1693,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    RISCVCPUMultiExtConfig *prop;
+    const RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
     set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
-- 
2.41.0


