Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C39D741AEE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEcle-0002WQ-J0; Wed, 28 Jun 2023 17:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclc-0002TA-GW
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:00 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcla-0008Hn-RP
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:00 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-19a427d7b57so158751fac.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987917; x=1690579917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjO2hBYJBXBx8wIPGVPYjW7Y4BgSbyHfr9onz19xu8o=;
 b=bAMTlln2hkUkLjXEWcq2+eG6U+24WKsPZSPHaskcPLhlrVf8bWIWfNSm47FObHLPXs
 tJKPcpHPPRl42nB3hKHsSmp17XOP6YMYJiagJxgu+ginwc1G0pe3rryAN5cqLFTVUCwX
 NKX6ONwIwVmHadQV4bN67Ujbr3G9+JKDURgzK49cBdNGaNZd/AuQ4AJkD/g0Xs/LxaGI
 04wueRiOFGzl0xCQqBqE6VSX8rAd9QH0tLCN5nT2V9oZYT/WzEShV43/R10AlOpvNs7B
 DXPqHqFjUcQERN7UqdZmVjIzr4+6C042IvyNdMp9UWHaiYuE2w4SswejF5PBX6QxFc8h
 d3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987917; x=1690579917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjO2hBYJBXBx8wIPGVPYjW7Y4BgSbyHfr9onz19xu8o=;
 b=aKgBz9Kj2Bf1UDYHmZPRSFeDwBR47Lp4snErY/TMIZT8k0yjNMRpBm4LJCyVmXjvR8
 1/MX26nbw7ZBK78SPxiRTIruGVQf5OCK3tJvlWN1srKPxFtn80y8niFcaZsWdgQmV8/1
 +somrKkG620hIiHLjHjW9zF1zC9CTWfkJMAZM8gYK8rcMktwQz52v7DpOw7uZigrawY2
 rX5VajUhQx+xHfxuCNAjCDtIDYRVgsdAqTV28sASf8IwqP9iYFdwRErJpvRgqzi9PdQS
 cI5jwNrRBmfEOBAFDT2YRom2xKDFATt9lBnXuj6IeGeaN+RVAA9AowH60b7RmddJTfNU
 7i/Q==
X-Gm-Message-State: AC+VfDz9qIWdjQiTLbVgpezV7bJKM9x6hr4Z2VQjTnG91A2soloi34cG
 8/7TAvqkP2YjjxRBHzjD3pEiYx4LBSD0+fvbCMA=
X-Google-Smtp-Source: ACHHUZ5kiC7ZxyZ+CfboH3gSzSPgcb9xvgFkQ9by6aMsC7HOXXBlObj+teLUB+GD/DeJxF5jDRlAdQ==
X-Received: by 2002:a05:6870:d451:b0:1a9:8606:dfcd with SMTP id
 j17-20020a056870d45100b001a98606dfcdmr22620547oag.0.1687987917198; 
 Wed, 28 Jun 2023 14:31:57 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:31:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 13/20] target/riscv/kvm.c: update KVM MISA bits
Date: Wed, 28 Jun 2023 18:30:26 -0300
Message-ID: <20230628213033.170315-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
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

Our design philosophy with KVM properties can be resumed in two main
decisions based on KVM interface availability and what the user wants to
do:

- if the user disables an extension that the host KVM module doesn't
know about (i.e. it doesn't implement the kvm_get_one_reg() interface),
keep booting the CPU. This will avoid users having to deal with issues
with older KVM versions while disabling features they don't care;

- for any other case we're going to error out immediately. If the user
wants to enable a feature that KVM doesn't know about this a problem that
is worth aborting - the user must know that the feature wasn't enabled
in the hart. Likewise, if KVM knows about the extension, the user wants
to enable/disable it, and we fail to do it so, that's also a problem we
can't shrug it off.

In the case of MISA bits we won't even try enabling bits that aren't
already available in the host. The ioctl() is so likely to fail that
it's not worth trying. This check is already done in the previous patch,
in kvm_cpu_set_misa_ext_cfg(), thus we don't need to worry about it now.

In kvm_riscv_update_cpu_misa_ext() we'll go through every potential user
option and do as follows:

- if the user didn't set the property or set to the same value of the
host, do nothing;

- Disable the given extension in KVM. Error out if anything goes wrong.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0fb63cced3..ba97b0cbed 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -162,6 +162,41 @@ static void kvm_cpu_set_misa_ext_cfg(Object *obj, Visitor *v,
                "enabled in the host", misa_ext_cfg->name);
 }
 
+static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t id, reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
+        KVMCPUConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
+        target_ulong misa_bit = misa_cfg->offset;
+
+        if (!misa_cfg->user_set) {
+            continue;
+        }
+
+        /* If we're here we're going to disable the MISA bit */
+        reg = 0;
+        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
+                              misa_cfg->kvm_reg_id);
+        ret = kvm_set_one_reg(cs, id, &reg);
+        if (ret != 0) {
+            /*
+             * We're not checking for -EINVAL because if the bit is about
+             * to be disabled, it means that it was already enabled by
+             * KVM. We determined that by fetching the 'isa' register
+             * during init() time. Any error at this point is worth
+             * aborting.
+             */
+            error_report("Unable to set KVM reg %s, error %d",
+                         misa_cfg->name, ret);
+            exit(EXIT_FAILURE);
+        }
+        env->misa_ext &= ~misa_bit;
+    }
+}
+
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
@@ -632,8 +667,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
         ret = kvm_vcpu_set_machine_ids(cpu, cs);
+        if (ret != 0) {
+            return ret;
+        }
     }
 
+    kvm_riscv_update_cpu_misa_ext(cpu, cs);
+
     return ret;
 }
 
-- 
2.41.0


