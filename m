Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17E741AF3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEclT-0002MU-Q1; Wed, 28 Jun 2023 17:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclR-0002LG-OF
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:31:49 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclP-0008BD-Q2
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:31:49 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5634d8d1db0so7154eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987906; x=1690579906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOGk9I4ks6MkoJNJ0fveqeJuF6GTzx35Xwf8L/QdrDk=;
 b=Eu+3NE8hwGmY99vOhCt09yDSwwR5cVwJuD9qzpGIBh0u355ge+WcwAgiOFkzc6wpqn
 fsoFkPILtjhd/QP0cP6tTpkFImcmTmTBgIULYnelKzVdhZ62PG2zIlceL12BRm2yAfMC
 IHEcbz2E5estq2g8xmaph6Lze6ED4Ty6ESQbfs/UDvor43M2AsB0VoaSiTnSaNv47qi4
 Ae1Zn3Js+UNCdiB/7sqTyn9PwLH3Awd4lok+u4jx9l/EEcT07S7v3giGPbWcgOGpQc4v
 Laj3qe8GhY0kPt8dm+7SjEuWhe7TKEr2zUCL2oFwuUZZaL/T/RRQYYclq2ItqXTO1aRa
 cGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987906; x=1690579906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOGk9I4ks6MkoJNJ0fveqeJuF6GTzx35Xwf8L/QdrDk=;
 b=X8hraTJchD/+u02HQviX85HcgztZITmc/HpYXNmkpe35k/4xub4XCs0EGSb48fOzXw
 u9wCaM+Pc5ALpW/qBBkdO5gx5scve2sFQEj9pX95iQXww2yeCizL2+TVmR3nBmz3u2fK
 0SlVnOUatI5Wh2Aeihnl5Kc3MJIWKHL+COd8ruwJyhi3Dl+pWy3yekb1qJL1EYztX3rC
 pYnp99Ncg+4iYSA/R4iWhcDEOR1Xl50EkaDcEisl5cM8fH6rK3x6F66ihHlPRaZR/SCK
 lqeFzw8FkTXFZaSFUWptT+Cw/GvW6WAYqMb0tKCKOW5D5r767yT5E6NTHhZJsCRXNKgD
 YGsw==
X-Gm-Message-State: AC+VfDwQVJSziOUTgSYO3pmy4asaqgkpEOOw1cNPnkVSUtgU+khFvsG1
 DlZDikba1VroO6M98MEz3TnV+R9qhTTv5rvEJG4=
X-Google-Smtp-Source: ACHHUZ5Av2yaiA2VRFU1RDmsL5kmbD1b4+YXXDkTzzETnKH4bQ9WopWzVsR+mSHLN5flHV2WA/Eifw==
X-Received: by 2002:a4a:d548:0:b0:565:bf28:ee72 with SMTP id
 q8-20020a4ad548000000b00565bf28ee72mr24816oos.0.1687987906032; 
 Wed, 28 Jun 2023 14:31:46 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:31:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 11/20] target/riscv/cpu: add misa_ext_info_arr[]
Date: Wed, 28 Jun 2023 18:30:24 -0300
Message-ID: <20230628213033.170315-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
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

misa_ext_info_arr[] array will hold name and description for each MISA
extension that misa_ext_cfgs[] is declaring. We'll then use this new
array in KVM code to avoid duplicating strings.

There's nothing holding us back from doing the same with multi-letter
extensions. For now doing just with MISA extensions is enough.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 83 ++++++++++++++++++++++++++++++----------------
 target/riscv/cpu.h |  7 +++-
 2 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2485e820f8..90dd2078ae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1558,33 +1558,57 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
-static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
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
+typedef struct misa_ext_info {
+    const char *name;
+    const char *description;
+} MISAExtInfo;
+
+#define MISA_EXT_INFO(_idx, _propname, _descr) \
+    [(_idx - 'A')] = {.name = _propname, .description = _descr}
+
+static const MISAExtInfo misa_ext_info_arr[] = {
+    MISA_EXT_INFO('A', "a", "Atomic instructions"),
+    MISA_EXT_INFO('C', "c", "Compressed instructions"),
+    MISA_EXT_INFO('D', "d", "Double-precision float point"),
+    MISA_EXT_INFO('F', "f", "Single-precision float point"),
+    MISA_EXT_INFO('I', "i", "Base integer instruction set"),
+    MISA_EXT_INFO('E', "e", "Base integer instruction set (embedded)"),
+    MISA_EXT_INFO('M', "m", "Integer multiplication and division"),
+    MISA_EXT_INFO('S', "s", "Supervisor-level instructions"),
+    MISA_EXT_INFO('U', "u", "User-level instructions"),
+    MISA_EXT_INFO('H', "h", "Hypervisor"),
+    MISA_EXT_INFO('J', "x-j", "Dynamic translated languages"),
+    MISA_EXT_INFO('V', "v", "Vector operations"),
+    MISA_EXT_INFO('G', "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
+};
+
+const char *riscv_get_misa_ext_name(uint32_t bit)
+{
+    return misa_ext_info_arr[ctz32(bit)].name;
+}
+
+const char *riscv_get_misa_ext_descr(uint32_t bit)
+{
+    return misa_ext_info_arr[ctz32(bit)].description;
+}
+
+#define MISA_CFG(_bit, _enabled) \
+    {.misa_bit = _bit, .enabled = _enabled}
+
+static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
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
@@ -1592,7 +1616,10 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
-        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+
+        misa_cfg->name = riscv_get_misa_ext_name(misa_cfg->misa_bit);
+        misa_cfg->description = riscv_get_misa_ext_descr(misa_cfg->misa_bit);
 
         object_property_add(cpu_obj, misa_cfg->name, "bool",
                             cpu_get_misa_ext_cfg,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index cc20ee25a7..acae118b9b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -41,7 +41,10 @@
 
 #define RV(x) ((target_ulong)1 << (x - 'A'))
 
-/* Consider updating misa_ext_cfgs[] when adding new MISA bits here */
+/*
+ * Consider updating misa_ext_info_arr[] and misa_ext_cfgs[]
+ * when adding new MISA bits here.
+ */
 #define RVI RV('I')
 #define RVE RV('E') /* E and I are mutually exclusive */
 #define RVM RV('M')
@@ -56,6 +59,8 @@
 #define RVJ RV('J')
 #define RVG RV('G')
 
+const char *riscv_get_misa_ext_name(uint32_t bit);
+const char *riscv_get_misa_ext_descr(uint32_t bit);
 
 /* Privileged specification version */
 enum {
-- 
2.41.0


