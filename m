Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9031749940
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM4C-0005cW-8f; Thu, 06 Jul 2023 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM49-0005aX-1N
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:25 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM47-00075I-56
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:24 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1b06ea7e7beso621177fac.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638701; x=1691230701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvW410UcZK4dQQaC9i0QCClAX6qE4qbAIfvVzFOsM2o=;
 b=fWXTc723sX43dMFEzK99QhOVI2xq9ICsyyEVXWSgj/NaAHWARDl90/U+1jxd5qrCeq
 Zo5r7RJJBFGBc/3WQBwmwNOi/zCC0FO7/9kXGhdaKt8tWriHbP5W4asUtqdDRqcUYpcU
 i6K0F9nWBrTMbC0IR0VRCGjo69ua7aX4vS+4qCDNhMwVwy9//E6Cu6SDq4iD/vz4xlYM
 g9IB96NsX0btWkIQ5ezw9nkgeQsNb1WxL5eMOgiKCLw+EnSTAh46K1P9qrrHuth9XfGx
 mYHTBB1sB+zvhwT40JW7sAtw190rhG0YX1kylUiA+2txf6Lls+kk5WAzCEv8R4OATh93
 66cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638701; x=1691230701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvW410UcZK4dQQaC9i0QCClAX6qE4qbAIfvVzFOsM2o=;
 b=j5ML1ykSLv1PgRxSIb8yaxItMW2FJWsIYApyeRducWvksED6iKGgHaKOIw5HsKvwNn
 a0JcESmnuVbcZB4PcZCINf5KFGdMX/fgSsQQtdYvGrUQkx+x9lLT7NPSqHfcuYz0sTQ7
 xu6PEBQR9VfKmSl6ThxUAIuCDhJcbJsLwaMIuZbUXZqTd+u7E0sGzXJ60J5MCEgZft4q
 iad41D9fO0ZVoIASStt5Zm1uPTLuOPtHlYHld7JtgXzrHX274Vc6HwAAKn0Fh8dz/M7b
 mk3IxjdnC6Uci/wwfQuT6OxBkF9LAKG9TlO5FzV8hI5dHxxfzKg9WIvdX5w8ub6Bqpql
 K0Vw==
X-Gm-Message-State: ABy/qLbiguiYX+cB5fxc6/OxYf9xlanIT0jLIZQsBV42dFmTi5qsNWzv
 7pqfKS4AYxL2mfJGBCsqAAzeItdgeecl4F1YP0w=
X-Google-Smtp-Source: APBJJlFnOmshBSulcrFSDjK7n8bcZGBYUZyXQNAS9p+FfHq4ze5WlL6eFsT6vgFjsVheXSH8wmbLNw==
X-Received: by 2002:a05:6870:1f8f:b0:1b0:1e3f:1369 with SMTP id
 go15-20020a0568701f8f00b001b01e3f1369mr2535083oac.57.1688638701623; 
 Thu, 06 Jul 2023 03:18:21 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:18:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 11/20] target/riscv/cpu: add misa_ext_info_arr[]
Date: Thu,  6 Jul 2023 07:17:29 -0300
Message-ID: <20230706101738.460804-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706101738.460804-1-dbarboza@ventanamicro.com>
References: <20230706101738.460804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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
---
 target/riscv/cpu.c | 110 +++++++++++++++++++++++++++++++++------------
 target/riscv/cpu.h |   7 ++-
 2 files changed, 88 insertions(+), 29 deletions(-)

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
-- 
2.41.0


