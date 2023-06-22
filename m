Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6F73A26D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKos-0007kK-IF; Thu, 22 Jun 2023 09:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKok-0007bl-PM
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:49 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoi-0001aY-8y
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:46 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1a998a2e7a6so7217438fac.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687442262; x=1690034262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0BHcPcpvZozn5N7EuikKbo84QzIdNxUzJnyKgfeQv4=;
 b=SCOqhIH/bhFZXcl0iP2/HtAPQ/hpJ4wzr6v0AB03QhMFgvsN9UxFIfpu80T6HsPU+T
 dz0LZXAbIRuhHYLDZimFv59ich1T9CqJqqqNUguRHf+216VEi8PjuXc40ooHEwhq6HO2
 1Z16DiTUvcKRVodpVmKcZLomJHA3T2WGH5Gs1rt1BZ4EYUiw2GbOSrolB14IzB03miTF
 oOtziO2r9vNyAi3xw9IQXdI1u9Y2HmdipOQBUuMylGWBj24ytZzL4DS/2oQtbaqmOI3g
 YUMkwwBVZQcN3DZvvS0z2jtJ076+49zlep76li8KFwQbgq69/lhWKm0Js7KUYUah8LAg
 eAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687442262; x=1690034262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0BHcPcpvZozn5N7EuikKbo84QzIdNxUzJnyKgfeQv4=;
 b=j6jhb6ZxKcWOdMuluEz2qx2XpBuD57lpBIXqodMeEDsNcPSgGG+uXVjiREDb8DGnjk
 roBvKx1SqbXPuoFpJytwa2Q06v+YqLyfJM5C9U223skmN1d0BRbDh/LLioCiE07ilUqn
 RsOkpf0nG99OPtzGKuD0CdQGjC+cL1+5+r1K3coVfnGOovskCMR1MXEmJEYs5etn2b8/
 L3+HMzglmSxs/cFl1t7WQcDu4fk4kTM8NiMcTe3uKjYZuJo5h5uB8mtN93mKzwZJxuL3
 CDRh503nKuG7/Vny0K0yPAIdXtnNGGOzDr06XDzb4cTvi/jNX4WQFGONeZW+i5V//6ac
 5K8Q==
X-Gm-Message-State: AC+VfDyGqXv7eWDCuO/hnNLu5FEmORV94QWxLQPsCkkD2wGzPcrzIRjX
 cmhfZUNypIH1nfXErf42ClUJxDnPFSNVH08eWaE=
X-Google-Smtp-Source: ACHHUZ4HU8r7ZWucYWCAeyzlYO/dwxyUECw48UTDULAmyzzwq5pRcUOPSGJzsJB9V/9htRmpba5MFw==
X-Received: by 2002:a05:6870:e3c6:b0:18b:1936:30ee with SMTP id
 y6-20020a056870e3c600b0018b193630eemr8189910oad.56.1687442262703; 
 Thu, 22 Jun 2023 06:57:42 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a4aa446000000b00562f06fb5easm156677ool.11.2023.06.22.06.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 06:57:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 11/19] target/riscv/cpu: add misa_ext_info_arr[]
Date: Thu, 22 Jun 2023 10:56:52 -0300
Message-ID: <20230622135700.105383-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622135700.105383-1-dbarboza@ventanamicro.com>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x32.google.com
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
index e3e08d315f..3e08c8da51 100644
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


