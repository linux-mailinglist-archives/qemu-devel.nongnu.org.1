Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED4873EE41
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuJ2-0004Pt-F6; Mon, 26 Jun 2023 18:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIg-0002wq-TE
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:03:15 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIa-00062F-QY
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:03:10 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b059dd7c0cso281842fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816983; x=1690408983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cm5y2gWYt5OAiZ+hxblm6TFm4mb5jHZNaimv5+Czdw=;
 b=NH28+1/nAe93IXz4bk1bK+n6aGPh/RsyiVMviOf8XwC5GEWbUx0sM7hgZ16Jjjbwin
 yNgsNbDyzxscPZC9z8rIYmts1A/wVJLl+kN4UnsBUV1sy46cUFf4BzpOvCUqGfzo0+bn
 +VHxkqjfaiIBG0Tubz4hkcDprFIjbt/ocp7J0YzJOyJNigLvSzWjBkLrYQVhkFI62dTu
 cN1Z9K0vioIyemDJGrzmSC0c0DLCnzWqSt7IHGWUmYG1eKhlT3QLb6CT3/lsqTsedNR4
 OZP+mGolVNrc3433b2kL+Jtd1/hGdqOzeBhadhE6aRCGN1JyGLibWWpAQom/PJK0Ule6
 u2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816983; x=1690408983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cm5y2gWYt5OAiZ+hxblm6TFm4mb5jHZNaimv5+Czdw=;
 b=KmCxQw5QzjoX0MNdhAfSM3m/7ffvB3QYA0OzPoTan6AU1Rj1mef7nGXsvb7Vp7ffpX
 JFq2ko3sQvnLBCYDHdn2+pWWHjaJ61pcy9BXUMBLyLlIrMYQ+UmqQ/P6dfT6KUmfpEpk
 X7rNqKoMjVqFJJrTKdhn46bUwDuRCrXFa4mVhqtVYZHUyfRdb9Nx3bJRSC7GY5qtLyuB
 81WgEma4hr7JNhh6HaLjzzqs/sGKJxYfuz1C9mSSXGc108RiLDHng3XFxPKxiGCepVKU
 Bcnd6Q0DXa4IoLfveok/qimzLQce6rbxzRw9OvAvt47Jiqjvbr5FWDJrYgUJleJ0pgVa
 ZVSw==
X-Gm-Message-State: AC+VfDyZLEDgXAAfieI1OaxHArI5/z2pHz3S7FVQA+LNByhm/NuBlwUD
 S9iJCM0TRtjry7aQPPUgcGDh3OTNGfGSuxoOJ60=
X-Google-Smtp-Source: ACHHUZ4eFyo8VZjOfMiz1+isxGIesklvNXrkocFXfO7tQYWy5IVbLWosCdxWL/PzR+mGx94he171SA==
X-Received: by 2002:a05:6870:d454:b0:1ad:4bff:fa48 with SMTP id
 j20-20020a056870d45400b001ad4bfffa48mr11818033oag.58.1687816983509; 
 Mon, 26 Jun 2023 15:03:03 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:03:03 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 17/19] target/riscv: update multi-letter extension KVM
 properties
Date: Mon, 26 Jun 2023 19:02:07 -0300
Message-ID: <20230626220209.22142-18-dbarboza@ventanamicro.com>
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


