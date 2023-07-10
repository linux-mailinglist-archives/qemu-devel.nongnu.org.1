Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D48B74D5CF
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:38:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6X-0006bZ-Au; Mon, 10 Jul 2023 08:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6R-0005zA-8b
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:55 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6P-00051y-92
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:55 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3461163c0b6so23381745ab.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992492; x=1691584492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rCbC6nBf0+mL06J2H3q2MAMea7Jf/miqMDxYhvf9x8=;
 b=PXjHI/1Ww40Y9zHXtNIHN0IifpGa8N+DoRmq57mxfZ+tIkkOUJqqolXfCa0zn8OFgj
 BdOJL9CWfJn4EJSqvndZnrmgf8aOvNXpPmwpVnvQyCykNLGt5GqIJSp1bghqHl94NWni
 Zb4h8119CswfdwX4hxfKeat+FRjkan5TWtsQuRAc4oq5CMFt+5n1Dh8kFKBvUNWv4cBe
 cnD2OGlg3Ha1jE3ez9utWJwFfnIsjI00RvANbAHdHN9Y3et4wfq2M0TH2PJp/8EzgXWS
 f+MlSG/pGtgIauNIOeV93jXbyho4Nr9Y+Kt3y2wYeXfkOaffiPlCYjJsfFknibrDFAG/
 szWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992492; x=1691584492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rCbC6nBf0+mL06J2H3q2MAMea7Jf/miqMDxYhvf9x8=;
 b=EkKsDsmYmEIUUeZO0C5tNGqoth0CUmPXc36cvy/8Jgb3ebpwFf3ZitD4/OvWpv4vgX
 yy3VIyyWdp11C/410aYwkgDsu6EVRvepEpC4RSKHmwadsFn79gz4idaLdmaNAbgUYdin
 rx//g830q7J5iobd5gfK39Lb0h1t+ivvAPNB4cQr2IFy09iI2L3Hfd/naIINTNYIETeA
 8ApfHcsiqJqoYiEOyHLmTWPg8o+lHbYfHwJjllaN0nq72u/l1BxSHpI4Zt02GDISKCg6
 YQ6nwM/ToP8zARLaomE9guo6WgsBpSqgMjRyR+h46MKeXtPW7TyAbMY5cShFeNGmc0tU
 vo9A==
X-Gm-Message-State: ABy/qLZALJk1wZMPiKvKoIdMRdkhF69rNLNVmfgutztye7prw9ahqaA3
 oqvamkrhVAckpeDhvFU9A587tVSliTp3FA==
X-Google-Smtp-Source: APBJJlG863j+seZm9i+LoeeKA+hePHo8/RSv7MUDn5eJk5LKUveh9bQpWJ3nNqQ3+YHp+i6a+fcROQ==
X-Received: by 2002:a92:911:0:b0:345:d6d4:f9f3 with SMTP id
 y17-20020a920911000000b00345d6d4f9f3mr7773156ilg.17.1688992491932; 
 Mon, 10 Jul 2023 05:34:51 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/54] target/riscv/cpu: add misa_ext_info_arr[]
Date: Mon, 10 Jul 2023 22:31:55 +1000
Message-Id: <20230710123205.2441106-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12b.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Next patch will add KVM specific user properties for both MISA and
multi-letter extensions. For MISA extensions we want to make use of what
is already available in misa_ext_cfgs[] to avoid code repetition.

misa_ext_info_arr[] array will hold name and description for each MISA
extension that misa_ext_cfgs[] is declaring. We'll then use this new
array in KVM code to avoid duplicating strings. Two getters were added
to allow KVM to retrieve the 'name' and 'description' for each MISA
property.

There's nothing holding us back from doing the same with multi-letter
extensions. For now doing just with MISA extensions is enough.

It is worth documenting that even using the __bultin_ctz() directive to
populate the misa_ext_info_arr[] we are forced to assign 'name' and
'description' during runtime in riscv_cpu_add_misa_properties(). The
reason is that some Gitlab runners ('clang-user' and 'tsan-build') will
throw errors like this if we fetch 'name' and 'description' from the
array in the MISA_CFG() macro:

../target/riscv/cpu.c:1624:5: error: initializer element is not a
                              compile-time constant
    MISA_CFG(RVA, true),
    ^~~~~~~~~~~~~~~~~~~
../target/riscv/cpu.c:1619:53: note: expanded from macro 'MISA_CFG'
    {.name = misa_ext_info_arr[MISA_INFO_IDX(_bit)].name, \
             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~

gcc and others compilers/builders were fine with that change. We can't
ignore failures in the Gitlab pipeline though, so code was changed to
make every runner happy.

As a side effect, misa_ext_cfg[] is no longer a 'const' array because
it must be set during runtime.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |   7 ++-
 target/riscv/cpu.c | 110 +++++++++++++++++++++++++++++++++------------
 2 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3081603464..6ea22e0eea 100644
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
+const char *riscv_get_misa_ext_description(uint32_t bit);
 
 /* Privileged specification version */
 enum {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0e1265bb17..35ba220c8f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1636,33 +1636,83 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
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
+#define MISA_INFO_IDX(_bit) \
+    __builtin_ctz(_bit)
+
+#define MISA_EXT_INFO(_bit, _propname, _descr) \
+    [MISA_INFO_IDX(_bit)] = {.name = _propname, .description = _descr}
+
+static const MISAExtInfo misa_ext_info_arr[] = {
+    MISA_EXT_INFO(RVA, "a", "Atomic instructions"),
+    MISA_EXT_INFO(RVC, "c", "Compressed instructions"),
+    MISA_EXT_INFO(RVD, "d", "Double-precision float point"),
+    MISA_EXT_INFO(RVF, "f", "Single-precision float point"),
+    MISA_EXT_INFO(RVI, "i", "Base integer instruction set"),
+    MISA_EXT_INFO(RVE, "e", "Base integer instruction set (embedded)"),
+    MISA_EXT_INFO(RVM, "m", "Integer multiplication and division"),
+    MISA_EXT_INFO(RVS, "s", "Supervisor-level instructions"),
+    MISA_EXT_INFO(RVU, "u", "User-level instructions"),
+    MISA_EXT_INFO(RVH, "h", "Hypervisor"),
+    MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
+    MISA_EXT_INFO(RVV, "v", "Vector operations"),
+    MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
+};
+
+static int riscv_validate_misa_info_idx(uint32_t bit)
+{
+    int idx;
+
+    /*
+     * Our lowest valid input (RVA) is 1 and
+     * __builtin_ctz() is UB with zero.
+     */
+    g_assert(bit != 0);
+    idx = MISA_INFO_IDX(bit);
+
+    g_assert(idx < ARRAY_SIZE(misa_ext_info_arr));
+    return idx;
+}
+
+const char *riscv_get_misa_ext_name(uint32_t bit)
+{
+    int idx = riscv_validate_misa_info_idx(bit);
+    const char *val = misa_ext_info_arr[idx].name;
+
+    g_assert(val != NULL);
+    return val;
+}
+
+const char *riscv_get_misa_ext_description(uint32_t bit)
+{
+    int idx = riscv_validate_misa_info_idx(bit);
+    const char *val = misa_ext_info_arr[idx].description;
+
+    g_assert(val != NULL);
+    return val;
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
@@ -1670,7 +1720,11 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
-        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+        int bit = misa_cfg->misa_bit;
+
+        misa_cfg->name = riscv_get_misa_ext_name(bit);
+        misa_cfg->description = riscv_get_misa_ext_description(bit);
 
         object_property_add(cpu_obj, misa_cfg->name, "bool",
                             cpu_get_misa_ext_cfg,
-- 
2.40.1


