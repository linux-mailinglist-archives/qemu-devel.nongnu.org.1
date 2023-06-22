Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9B73A25E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:59:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKp6-00083T-Ee; Thu, 22 Jun 2023 09:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKp3-0007yZ-6R
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:58:05 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKp1-0001n3-9b
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:58:04 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-55e41318185so3520097eaf.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687442281; x=1690034281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cm5y2gWYt5OAiZ+hxblm6TFm4mb5jHZNaimv5+Czdw=;
 b=DI0mFsQ3y9MABQnIcq0O3ycu7j3dbvfNpY0a3hUyGSfu2r21Vuu/YZxVhIJHQ0Tn2x
 zRXK/uJqkvqHqJ1WA+VxN3R5rHLQ8Skvi833r2T7rpIFwQN8dREEpkuYk//G1ri7rx1c
 0i9OnLchhMNYjGkHOidqH7VKHUX7MWr2m8cQAGkvGLkVMve81mHTBr4v1xiN6X/R/S1n
 hPAmFWCX1qIZxik3nSTOtFpcmvIoCvDWJCMA+Lh5+7+/HcVBXVxbjM5Xyql5U/2xIzHo
 lti6yhvZTGngegERbTX523BdUpocOA2qt3/LZFeIys5gPQSE0GYApVZHeIWM8TDt5vxl
 gtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687442281; x=1690034281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cm5y2gWYt5OAiZ+hxblm6TFm4mb5jHZNaimv5+Czdw=;
 b=Z+Vci731K8oNP9qfn8XgNjTmZvCO6OA9rCY7U1PiJ8UhJnpH4YAnZ8uRxKQHXBM7tK
 AYQRAfR33/UcroxX4RReDMYhTjLMzPWoJ5G7Ab+bfjwMtmsIhLi4AiXES9RugL2vsjCx
 Yp+dOXYZJnP+0ANELOpaR8/Lhrnw0XWmPb81NLlJA28HmQr8dGlTLf6w5qn79GnszWQ+
 o2qK67R4i5bNqB3g7nNXek4nxo1AzXVNAe6krCB6auYnnDLBJCveOVjT+y8B9S+OOC67
 AYcfKAghNfmeUW1T0bLQLKDxDT6OhMIClBjHyOJkOSSGRnoB+1eGfv9YI/t0x8i87iz2
 7JzA==
X-Gm-Message-State: AC+VfDyRDUJ1p7tVs2o1gNmBNPudcA/tvvpN5emNnfwNgNMJS/4ytYoa
 zmGwL9ZGDfrIsj80BYSiDotOpNOmIlAxUjl/Vms=
X-Google-Smtp-Source: ACHHUZ4MOKVqNEh7bksKj2+zTVp0EuxtdOE3OuOpMBhF5PhU7tnvnPEeJIb04WjVN3CCdu0Io7mLNQ==
X-Received: by 2002:a4a:d0b8:0:b0:562:eb5c:15af with SMTP id
 t24-20020a4ad0b8000000b00562eb5c15afmr658352oor.8.1687442281500; 
 Thu, 22 Jun 2023 06:58:01 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a4aa446000000b00562f06fb5easm156677ool.11.2023.06.22.06.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 06:58:01 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 17/19] target/riscv: update multi-letter extension KVM
 properties
Date: Thu, 22 Jun 2023 10:56:58 -0300
Message-ID: <20230622135700.105383-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622135700.105383-1-dbarboza@ventanamicro.com>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
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

We're now ready to update the multi-letter extensions status for KVM.

kvm_riscv_update_cpu_cfg_isa_ext() is called called during vcpu creation
time to verify which user options changes host defaults (via the 'user_set'
flag) and tries to write them back to KVM.

Failure to commit a change to KVM is only ignored in case KVM doesn't
know about the extension (-EINVAL error code) and the user wanted to
disable the given extension. Otherwise we're going to abort the boot
process.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 376bbc68b4..6eebeb123a 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -273,6 +273,32 @@ static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
     kvm_cpu_cfg_set(cpu, multi_ext_cfg, value);
 }
 
+static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t id, reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
+        KVMCPUConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
+
+        if (!multi_ext_cfg->user_set) {
+            continue;
+        }
+
+        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
+                              multi_ext_cfg->kvm_reg_id);
+        reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
+        ret = kvm_set_one_reg(cs, id, &reg);
+        if (ret != 0) {
+            error_report("Unable to %s extension %s in KVM, error %d",
+                         reg ? "enable" : "disable",
+                         multi_ext_cfg->name, ret);
+            exit(EXIT_FAILURE);
+        }
+    }
+}
+
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
@@ -792,6 +818,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     kvm_riscv_update_cpu_misa_ext(cpu, cs);
+    kvm_riscv_update_cpu_cfg_isa_ext(cpu, cs);
 
     return ret;
 }
-- 
2.41.0


