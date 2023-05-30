Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 656E9716DF5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45Iz-0006XP-4F; Tue, 30 May 2023 15:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45Ix-0006Wz-EY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:51 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45Iv-0004Gs-PY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:51 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-392116ae103so3125713b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685476008; x=1688068008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHcIFF+On7XVAkK1In1iARALt5xOx5eVMu85enqtbhk=;
 b=o8KniyxcZo4x+nYoJrc0ZuToTqePJwhmxAZY1UiEKRwiTFtCh9yjR0a6sg8rJqxLVK
 0lLOgYzXJw1mO8tUsa3kmoqHBQf3lzcDA/zImoHi4/zO2QJHJgoPtEsrSQwXTzZiN6hP
 gI4UMTbNOEcLkMl67SJTM3ycUCYBjDealCg3pm08GEUH3Zy5mvBl85KfoV8XAquMbKtw
 XPeqMiljLVKiQZSQAZDOS2lwU1LSwRynTaqhmfD6TtF8Mdx0iOjyuFFLCo/DXExv6KVq
 HDBfVVLkV8zY12Z2Y72s660HJ9uHMYZdX8tk20XSHLSDTKDyo1P+kcukHmSm4p5Lo7+T
 C9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685476008; x=1688068008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHcIFF+On7XVAkK1In1iARALt5xOx5eVMu85enqtbhk=;
 b=e99M4B9/nWex5D6bIIncyjjCnYYIZBiuJ8LVfTtVgiiA8b0uIgOIiZo5EBaQgxhf39
 AjNvmNh00ZVeItEaVcRgHYWgqybgDBjPsWQl+lq83BsEgTMiee/ZXNqqoS48XrouGu0+
 nS/jdrg+glao33BX3Zx0kC02asCLPk4EclpD8185ZaZSWC1r9hmgYlNNpcJAVxKTTaDi
 HkJ8tnTx9u0U6NsneRQdeK3rsHYAkk9tWPzRsFHzlV4Soj1Bxt0/V0Pv3XbzN8OGF/Yi
 5RstnWHVGlInlvDKqlDTKzt/SAW16DnP7P991fea0a/sf7N6+5MMCh/cGQF1QZHDxO7W
 PW+g==
X-Gm-Message-State: AC+VfDwbHhE0n9lwSMH8YEy/ajDGHPBPyo2Y7v2dEP8qh7uezNplWl1k
 6Ac8uVJbMbhSPlT1vqIdHmJhRDev/MO7LLenuZY=
X-Google-Smtp-Source: ACHHUZ7I8Z8ziaTxI94QWIJDw9k3pXBKa0X0XlZrLtPd9t8uq24Z3Wm1pnEERwM/VjFp2TG/fWhyuw==
X-Received: by 2002:a05:6808:1453:b0:398:55f:6a50 with SMTP id
 x19-20020a056808145300b00398055f6a50mr2020040oiv.10.1685476008144; 
 Tue, 30 May 2023 12:46:48 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-121.static-corp.ajato.com.br. [200.162.225.121])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056870a48300b0019fa8728b05sm342214oal.39.2023.05.30.12.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:46:47 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 05/16] target/riscv/cpu.c: restrict 'marchid' value
Date: Tue, 30 May 2023 16:46:12 -0300
Message-Id: <20230530194623.272652-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530194623.272652-1-dbarboza@ventanamicro.com>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x234.google.com
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

'marchid' shouldn't be set to a different value as previously set for
named CPUs.

For all other CPUs it shouldn't be freely set either - the spec requires
that 'marchid' can't have the MSB (most significant bit) set and every
other bit set to zero, i.e. 0x80000000 is an invalid 'marchid' value for
32 bit CPUs.

As with 'mimpid', setting a default value based on the current QEMU
version is not a good idea because it implies that the CPU
implementation changes from one QEMU version to the other. Named CPUs
should set 'marchid' to a meaningful value instead, and generic CPUs can
set to any valid value.

For the 'veyron-v1' CPU this is the error thrown if 'marchid' is set to
a different val:

$ ./build/qemu-system-riscv64 -M virt -nographic -cpu veyron-v1,marchid=0x80000000
qemu-system-riscv64: can't apply global veyron-v1-riscv-cpu.marchid=0x80000000:
    Unable to change veyron-v1-riscv-cpu marchid (0x8000000000010000)

And, for generics CPUs, this is the error when trying to set to an
invalid val:

$ ./build/qemu-system-riscv64 -M virt -nographic -cpu rv64,marchid=0x8000000000000000
qemu-system-riscv64: can't apply global rv64-riscv-cpu.marchid=0x8000000000000000:
    Unable to set marchid with MSB (64) bit set and the remaining bits zero

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 53 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ed3b33343c..d6e23bfd83 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,11 +38,6 @@
 #include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
-
-#define RISCV_CPU_MARCHID   ((QEMU_VERSION_MAJOR << 16) | \
-                             (QEMU_VERSION_MINOR << 8)  | \
-                             (QEMU_VERSION_MICRO))
-
 static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
 
 struct isa_ext_data {
@@ -1722,8 +1717,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
-    DEFINE_PROP_UINT64("marchid", RISCVCPU, cfg.marchid, RISCV_CPU_MARCHID),
-
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
@@ -1854,6 +1847,48 @@ static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
     cpu->cfg.mimpid = value;
 }
 
+static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint64_t prev_val = cpu->cfg.marchid;
+    uint64_t value, invalid_val;
+    uint32_t mxlen = 0;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s marchid (0x%lx)",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    switch (riscv_cpu_mxl(&cpu->env)) {
+    case MXL_RV32:
+        mxlen = 32;
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        mxlen = 64;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    invalid_val = 1LL << (mxlen - 1);
+
+    if (value == invalid_val) {
+        error_setg(errp, "Unable to set marchid with MSB (%u) bit set "
+                         "and the remaining bits zero", mxlen);
+        return;
+    }
+
+    cpu->cfg.marchid = value;
+}
+
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -1893,6 +1928,10 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
                               cpu_set_mimpid,
                               NULL, NULL);
 
+    object_class_property_add(c, "marchid", "uint64", NULL,
+                              cpu_set_marchid,
+                              NULL, NULL);
+
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.40.1


