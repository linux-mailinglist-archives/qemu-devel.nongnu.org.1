Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E673EE5D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuIu-0003i3-BS; Mon, 26 Jun 2023 18:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIM-0002RD-2e
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:52 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIJ-0005yd-Iy
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:49 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b05d63080cso135017fac.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816966; x=1690408966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9ZyFl+Qr39+h4sTEYsjjQIPZ2uoHg8GO4lNDOMrVM0=;
 b=ogm1k4KMD45/ULu4H2ChKTBDk1NvtavI4O4VbVhARpsGP483bK0lQsK970sVzBmp8F
 OeSjMtCkchsiYrR1OxVvw7f7qxBMuvxTXDkoI2x4xh+Jq9wpAjL+kws7htY4ON49e9cT
 V+Feqjv4vzR7/INpo2PxBoGocgILWDoeSCNEw66P/uq8tunrj7b/AGEq+g0aOcOmHLp5
 0dhBy0QiRuGiFm08KfON1MYs24ejdYCgK2EMkdK8zpfasmCKxiveubaZ2kBMtmn9jzPL
 7gaqNdpmNozppX9fvrLqus3gF8GagdS8LELK94Au9BEK/cBnl2wjBvIQvMYdQVn2QMR5
 FN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816966; x=1690408966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9ZyFl+Qr39+h4sTEYsjjQIPZ2uoHg8GO4lNDOMrVM0=;
 b=dHadlQMcKUfLwKnVHEZoWQHlRRA5XrTQoygJ8tixBkp9FC8V5q8yRaOWzmxJeyw4xU
 iHbsELMTjnrVNW5UDFZ6p9o+HYEDzzYabLq0QsY8r11u7St0pb0SkKOp2fvAmrj89w1Q
 Lt1PYrOTe61rsL+Fi9TP873Dn1fyIK6Ix6ag8X74oKaEe2K+IwIZwJvOiypu/ak1PR33
 xsrxQv1sVwebO0jrOqAAYO9OrNIVg4CrAD5keEfr8vI6WDkn/SEwDSTddDPsfNDCWaXo
 sJJPMo6PQ+/z9LJdauqOm7gHk1sJe4YD+Nx3dkcH5giKtFVCuHMgptDK/WB3jDW77xwN
 Yo4Q==
X-Gm-Message-State: AC+VfDz1NP9Q4aspQoHDwk6rCe43tiPPV+tKhz9X/P/fm04dldD5K/mQ
 EOcgkw1+7tvF1Iv+hmb4p6GcHjl+CSE7IdpfHzA=
X-Google-Smtp-Source: ACHHUZ4V/aDdKIFUhzu9NbqUJ30qjEFnnEd0Ls80BpdoPJBsaGLku5pY/jsRUhUrPZCVhUfA0Kwz+A==
X-Received: by 2002:a05:6870:b285:b0:1a2:a842:c405 with SMTP id
 c5-20020a056870b28500b001a2a842c405mr20038373oao.48.1687816966212; 
 Mon, 26 Jun 2023 15:02:46 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:02:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 11/19] target/riscv/cpu: add misa_ext_info_arr[]
Date: Mon, 26 Jun 2023 19:02:01 -0300
Message-ID: <20230626220209.22142-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220209.22142-1-dbarboza@ventanamicro.com>
References: <20230626220209.22142-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2e.google.com
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 60 ++++++++++++++++++++++++++--------------------
 target/riscv/cpu.h | 11 ++++++++-
 2 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 641bec3573..0e5d8b05a2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1566,33 +1566,41 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
+const MISAExtInfo misa_ext_info_arr[] = {
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
+
+#define MISA_CFG(_bit, _enabled) \
+    {.name = misa_ext_info_arr[_bit].name, \
+     .description = misa_ext_info_arr[_bit].description, \
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
index cc20ee25a7..d4cab2722b 100644
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
@@ -56,6 +59,12 @@
 #define RVJ RV('J')
 #define RVG RV('G')
 
+typedef struct misa_ext_info {
+    const char *name;
+    const char *description;
+} MISAExtInfo;
+
+extern const MISAExtInfo misa_ext_info_arr[];
 
 /* Privileged specification version */
 enum {
-- 
2.41.0


