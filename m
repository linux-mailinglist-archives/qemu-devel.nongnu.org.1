Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C486741AFA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEcmB-0004yC-V2; Wed, 28 Jun 2023 17:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcm3-0004O8-0N
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:28 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcm1-0000GU-F4
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:26 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-564e4656fecso4840eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987944; x=1690579944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiNvpsLjP0ikqlRCdf/dgDy6nJZjXTzSnGyXN6QwndA=;
 b=DyonKPb3ApGJulAElGxxV13lFFUc14H2UQOxY8+mSI28rdPr0fxNqilnhDmoQ0F0W0
 0296jBUWbnK9K6hbsRQYuc5m+p8U8odAVS0NCmGWEpD9uPcI+56F+8Wx85NI4uPAcjk3
 4JfXQLhiZNoAeAd5hMg+yXCZ3L1rICalLVSUg3qssiEcKsHeVDSJnuq3imVCTunZC4W3
 iVX8eGpQ/NHBVrr7EOdsqxiNSAmY3ThobxYIbA/27ks5/WoaH6lKiDevqtfN9rSDV0S5
 3U8D5nl/5R71vFSXghOBlixwJe5gaDBEnRoqy2hJMbNsho3/PVTJw0nSeGg6yCIOZf//
 k0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987944; x=1690579944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiNvpsLjP0ikqlRCdf/dgDy6nJZjXTzSnGyXN6QwndA=;
 b=e+StYJuiuHVi3Zc9+2wr5c8Y3UioU5LZzOUZJtzIZ30R73rlOxg36CLyS+yXwTOMdY
 KS65gC/gCzfF29iJL+Y9ug+zfvJeZlLnTJ13fpzR6vF46lgi57nIzHzQ7Pno6pg+GHdZ
 RuwiHZl1+ILKeNL8pVVhgJj+k19+CDMBKaYTXwvqNlZgl+NgKikC44etM7OeaFBv3iJz
 0RFyH216270iCaQlp989K2hgXvEZ6p/BfqkCa3aZUMgL8AksyZDa8xPEJRX3ckcrnzG9
 70DVJwIRx8GzUq7kuKRip/tBknpH8c/z07X8uj5vKM/1Y3IEPe5dNEGT/2fXk9SPm8hn
 ftQw==
X-Gm-Message-State: AC+VfDzpFPINw49CTI+/iqQCXGMLxL0WonBmW8PR+bQX3ODxPzfK831Z
 FGQZOLZQhWFnXOUo9eWUjjzApHX9dLB5TnWdPYk=
X-Google-Smtp-Source: ACHHUZ5OFzlzayMhQDqxM1rtvQ6+T2ntjR8WxuiRxUItfdTLJscIvamMCKJJe3M8aGcDciXt2dewHw==
X-Received: by 2002:a4a:d28e:0:b0:560:befd:6d6a with SMTP id
 h14-20020a4ad28e000000b00560befd6d6amr19560000oos.7.1687987944128; 
 Wed, 28 Jun 2023 14:32:24 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:32:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 18/20] target/riscv: update multi-letter extension KVM
 properties
Date: Wed, 28 Jun 2023 18:30:31 -0300
Message-ID: <20230628213033.170315-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2b.google.com
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
index 68f6538b04..aa4edc8a56 100644
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


