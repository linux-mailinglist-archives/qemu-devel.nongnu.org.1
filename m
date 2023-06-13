Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A988872ED7F
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 23:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9B7N-00028U-6F; Tue, 13 Jun 2023 16:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B7H-00027n-QD
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:52 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B7F-0006lW-V9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:51 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-39cd0c3e8deso2132443b6e.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686689988; x=1689281988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dm9P/uUTs4MZ/sIEWKFivbNK7+MeEV1c5lZeWHAirE=;
 b=my29xTiGSZ0o+EDUbInF1MH+oXijkbRVJ6n3GTkyGoDM00AEqJjlUGSlXNueWWgCUh
 e7xCu87/0uYKruSWA8kpH7+Z95Cw+2Km57CPG8fEW432MgbQLWdvl/KUmiR1NUWmScQn
 wgETCm1r1tI1TRHuv2eAKatfztK8MQZvMVSpa76zclFLSfHweRr8djVXJTZX+dibIuB+
 BLqXSJuKmS8SiWf9tdtxCo1idf+HBbXxRJohUUhUf7GoEYqa4ccKvuMX1ZXSqpn/abuT
 07LCqDHNu1MdPmwu7y05fzuthQjJ8zMT3i/MGBvQQmgP2eAvaMCpFYyf+N6wL2JPZreh
 TURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686689988; x=1689281988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dm9P/uUTs4MZ/sIEWKFivbNK7+MeEV1c5lZeWHAirE=;
 b=L034FPRynQ30XkVTYzaUGVCZ4G66RBv1LCHCdUBopbc86o6k8ZpkD1gyTLCtekAAZr
 YmpqAYHdLBVy6bE76ZrQaWsglbUx6LDjd2bJCi7WWX9pJ1WIgOYyiQddNn0wi0RGFEs/
 9sfHgyhzcfbMuI+SwFyLXcNOR8Ifot/YrSbYXr1eP1wb7CbSBvfElEuknDowJVUI3R2B
 slfGnMUbrpVHVFc02eDNQ29QGz69L7XmcGqo4ck8l93dPosNSLxPQ4fxeO2s/5Wd9Ago
 XTzN+bHLUjWljXAcsCKvcXr4TmFz+f5OqytAZlanXG/HTSI/vZnJj4CP4TI7wdkAEakT
 clsg==
X-Gm-Message-State: AC+VfDzi55JxTnyoDslwsvyR/LOt7pFu/rL108NswcVi1kVSQuRe8Z3l
 K+DCC0ek3R3T+sx/jVwjYY8DTUF0hku5Pa5ySQA=
X-Google-Smtp-Source: ACHHUZ4bafB2LDVm22U926k2U+KwzhxaRXRXju2gtRrUrLxORIXYrvwHnWLeC/nl7sMCayHwBpg46g==
X-Received: by 2002:a05:6808:f91:b0:398:f76:36a5 with SMTP id
 o17-20020a0568080f9100b003980f7636a5mr9469574oiw.56.1686689988215; 
 Tue, 13 Jun 2023 13:59:48 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 q82-20020acaf255000000b003982a8a1e3fsm5619514oih.51.2023.06.13.13.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 13:59:47 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 11/18] target/riscv/cpu: add misa_ext_infos[]
Date: Tue, 13 Jun 2023 17:58:50 -0300
Message-Id: <20230613205857.495165-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613205857.495165-1-dbarboza@ventanamicro.com>
References: <20230613205857.495165-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x232.google.com
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

Next patch will add KVM specific user properties for both MISA and
multi-letter extensions. For MISA extensions we want to make use of what
is already available in misa_ext_cfgs[] to avoid code repetition.

The new misa_ext_infos[] array will hold name and description for each
MISA extension that misa_ext_cfgs[] is declaring. We'll then use this
new array in KVM code to avoid duplicating strings.

There's nothing holding us back from doing the same with multi-letter
extensions. For now doing just with MISA extensions is enough.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 44 ++++++++++++++++++--------------------------
 target/riscv/cpu.h | 22 +++++++++++++++++++++-
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0b25d53bbe..edaf052f25 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1562,33 +1562,25 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
+#define MISA_CFG(_bit, _enabled) \
+    {.name = misa_ext_infos[_bit].name, \
+     .description = misa_ext_infos[_bit].description, \
+     .misa_bit = _bit, .enabled = _enabled}
+
 static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
-    {.name = "a", .description = "Atomic instructions",
-     .misa_bit = RVA, .enabled = true},
-    {.name = "c", .description = "Compressed instructions",
-     .misa_bit = RVC, .enabled = true},
-    {.name = "d", .description = "Double-precision float point",
-     .misa_bit = RVD, .enabled = true},
-    {.name = "f", .description = "Single-precision float point",
-     .misa_bit = RVF, .enabled = true},
-    {.name = "i", .description = "Base integer instruction set",
-     .misa_bit = RVI, .enabled = true},
-    {.name = "e", .description = "Base integer instruction set (embedded)",
-     .misa_bit = RVE, .enabled = false},
-    {.name = "m", .description = "Integer multiplication and division",
-     .misa_bit = RVM, .enabled = true},
-    {.name = "s", .description = "Supervisor-level instructions",
-     .misa_bit = RVS, .enabled = true},
-    {.name = "u", .description = "User-level instructions",
-     .misa_bit = RVU, .enabled = true},
-    {.name = "h", .description = "Hypervisor",
-     .misa_bit = RVH, .enabled = true},
-    {.name = "x-j", .description = "Dynamic translated languages",
-     .misa_bit = RVJ, .enabled = false},
-    {.name = "v", .description = "Vector operations",
-     .misa_bit = RVV, .enabled = false},
-    {.name = "g", .description = "General purpose (IMAFD_Zicsr_Zifencei)",
-     .misa_bit = RVG, .enabled = false},
+    MISA_CFG(RVA, true),
+    MISA_CFG(RVC, true),
+    MISA_CFG(RVD, true),
+    MISA_CFG(RVF, true),
+    MISA_CFG(RVI, true),
+    MISA_CFG(RVE, false),
+    MISA_CFG(RVM, true),
+    MISA_CFG(RVS, true),
+    MISA_CFG(RVU, true),
+    MISA_CFG(RVH, true),
+    MISA_CFG(RVJ, false),
+    MISA_CFG(RVV, false),
+    MISA_CFG(RVG, false),
 };
 
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e3e08d315f..6d2acea478 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -41,7 +41,7 @@
 
 #define RV(x) ((target_ulong)1 << (x - 'A'))
 
-/* Consider updating misa_ext_cfgs[] when adding new MISA bits here */
+/* Consider updating misa_ext_infos[] when adding new MISA bits here */
 #define RVI RV('I')
 #define RVE RV('E') /* E and I are mutually exclusive */
 #define RVM RV('M')
@@ -56,6 +56,26 @@
 #define RVJ RV('J')
 #define RVG RV('G')
 
+typedef struct misa_ext_info {
+    const char *name;
+    const char *description;
+} MISAExtInfo;
+
+static const MISAExtInfo misa_ext_infos[] = {
+    [RVA] = {"a", "Atomic instructions"},
+    [RVC] = {"c", "Compressed instructions"},
+    [RVD] = {"d", "Double-precision float point"},
+    [RVF] = {"f", "Single-precision float point"},
+    [RVI] = {"i", "Base integer instruction set"},
+    [RVE] = {"e", "Base integer instruction set (embedded)"},
+    [RVM] = {"m", "Integer multiplication and division"},
+    [RVS] = {"s", "Supervisor-level instructions"},
+    [RVU] = {"u", "User-level instructions"},
+    [RVH] = {"h", "Hypervisor"},
+    [RVJ] = {"x-j", "Dynamic translated languages"},
+    [RVV] = {"v", "Vector operations"},
+    [RVG] = {"g", "General purpose (IMAFD_Zicsr_Zifencei)"},
+};
 
 /* Privileged specification version */
 enum {
-- 
2.40.1


