Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A520A7E3314
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Brd-0002kI-By; Mon, 06 Nov 2023 21:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrZ-0002jN-CI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:45 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrX-0002X3-MN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3542e328so35301465ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324242; x=1699929042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMNPsGEF9X/onZO1wRX7sF+sREAAR65um5/kddla50I=;
 b=QwoSPcptthLgoJMMcFMiM9SItyc/Fkp/eia0LWlgrUDIvx5MoI+8x7B5qWz1AYLzRw
 5X6oRQ8eenzW+GWLhqYkkCqWfd5zn0nKq7z40AeRy0pfTPQ5TOZv97iMoRRW/+2Rbvka
 lpnYm5GDH0kQyyjEKdLIgVcnPsVs39zjfZjVOrvs+xlnURguUcZjAda3mvuDa1JEHBEU
 I8VIljB7SaxeoxyD454VGMbrTXcnhcU4opcIm5gfgH5dSXF+CmC5klrWPoOdqmHhJ3qF
 2sFisP6fJopxzW4+ANhcAU6OPSPh103c+5BEBjhvmv+jPtivJqNXEXnzfK1VcpbXLgKE
 5eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324242; x=1699929042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMNPsGEF9X/onZO1wRX7sF+sREAAR65um5/kddla50I=;
 b=ZkPcLnTAP07S3jF7vi+sTq5DPfFS/7bg4e315BU7DVgZGRVrv/YhKVx5ECxue+H9h6
 frFDEW7rMDw7VbMvUAgwWT9Se1vVT0+8B9P1eXmXGkuyCyZak9HudDrpFeIVLZGzSwmE
 BGl9O3Nq0vMrz1nQhcfyRQlp4gqOh5IqNDp2pP3TGHhQ5P2pJ6HuA/8ehTOjQRDTHckm
 cioRhh+7vxalYx6vRoq8vriGrcyVkbI6sKYYVYUegpiXp+IS+Tfv3ZkW9BLIRy/wky/G
 2D2tskmcXpxFObcex7yhsTV39kfZJNPgKSUSjqy30qEh9EPEzAJOijM/RvabvtFQMNDL
 OtdA==
X-Gm-Message-State: AOJu0Yy6XopWKdyGs7eh+mKAhwhezmxh+YKR+cG3/5kK4pdKhpQOHEnc
 o5W+ypMg3vV8+x85r7Zuzu4OiKxojBXALw==
X-Google-Smtp-Source: AGHT+IEWlbQLako7y1ZTSL3OTt3dV9dNKDdyEa8fFHx6IkdFTpudmblOKmwTOUdL1HYplSdEof1ZHA==
X-Received: by 2002:a17:902:f112:b0:1cc:4072:22c6 with SMTP id
 e18-20020a170902f11200b001cc407222c6mr17566398plb.24.1699324241762; 
 Mon, 06 Nov 2023 18:30:41 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/49] target/riscv/kvm/kvm-cpu.c: add missing property
 getters()
Date: Tue,  7 Nov 2023 12:29:09 +1000
Message-ID: <20231107022946.1055027-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

We got along without property getters in the KVM driver because we never
needed them. But the incoming query-cpu-model-expansion API will use
property getters and setters to retrieve the CPU characteristics.

Add the missing getters for the KVM driver for both MISA and
multi-letter extension properties. We're also adding an special getter
for absent multi-letter properties that KVM doesn't implement that
always return false.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231018195638.211151-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 40 +++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6e1678542b..6bf035f39c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -140,6 +140,19 @@ static KVMCPUConfig kvm_misa_ext_cfgs[] = {
     KVM_MISA_CFG(RVM, KVM_RISCV_ISA_EXT_M),
 };
 
+static void kvm_cpu_get_misa_ext_cfg(Object *obj, Visitor *v,
+                                     const char *name,
+                                     void *opaque, Error **errp)
+{
+    KVMCPUConfig *misa_ext_cfg = opaque;
+    target_ulong misa_bit = misa_ext_cfg->offset;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    bool value = env->misa_ext_mask & misa_bit;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void kvm_cpu_set_misa_ext_cfg(Object *obj, Visitor *v,
                                      const char *name,
                                      void *opaque, Error **errp)
@@ -244,6 +257,17 @@ static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
     return *ext_enabled;
 }
 
+static void kvm_cpu_get_multi_ext_cfg(Object *obj, Visitor *v,
+                                      const char *name,
+                                      void *opaque, Error **errp)
+{
+    KVMCPUConfig *multi_ext_cfg = opaque;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
                                       const char *name,
                                       void *opaque, Error **errp)
@@ -346,6 +370,15 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+static void cpu_get_cfg_unavailable(Object *obj, Visitor *v,
+                                    const char *name,
+                                    void *opaque, Error **errp)
+{
+    bool value = false;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
                                     const char *name,
                                     void *opaque, Error **errp)
@@ -376,7 +409,8 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
      * to enable any of them.
      */
     object_property_add(obj, prop_name, "bool",
-                        NULL, cpu_set_cfg_unavailable,
+                        cpu_get_cfg_unavailable,
+                        cpu_set_cfg_unavailable,
                         NULL, (void *)prop_name);
 }
 
@@ -406,7 +440,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         misa_cfg->description = riscv_get_misa_ext_description(bit);
 
         object_property_add(cpu_obj, misa_cfg->name, "bool",
-                            NULL,
+                            kvm_cpu_get_misa_ext_cfg,
                             kvm_cpu_set_misa_ext_cfg,
                             NULL, misa_cfg);
         object_property_set_description(cpu_obj, misa_cfg->name,
@@ -422,7 +456,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
 
         object_property_add(cpu_obj, multi_cfg->name, "bool",
-                            NULL,
+                            kvm_cpu_get_multi_ext_cfg,
                             kvm_cpu_set_multi_ext_cfg,
                             NULL, multi_cfg);
     }
-- 
2.41.0


