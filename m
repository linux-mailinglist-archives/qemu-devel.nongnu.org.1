Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61873A28E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKov-0007nB-Ck; Thu, 22 Jun 2023 09:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoq-0007hT-EJ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:52 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoo-0001jN-F3
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:52 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-562e830bb80so253041eaf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687442269; x=1690034269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNxdEV8WFDJLmyw/5yS1+F5P/tLSBnf3oBZ+O84qKOA=;
 b=YNNPLpmvO6rJNxWIYOONkq8lI6uWpkVouiB7yTdjfLJuxLzBuXR8oq2xSZXvDkKUHi
 B40nm3FJiZcU5HOK2FyDu9PU7usydamVk3bXPn1MWH76CQdKYT6nCTKJcmabgHh2zPB+
 u483O5iM2C7UnRObl1uij39wKYnQppGjvw36CuLMfy+cBIkNt1rZe1kG6Nwvtj2CIkH6
 MwMXIbnMfNbjmtdRF/ihQZiXbgBQXc+1wr4yiX8cUoA63+0CM3zc+F+U2EeRpaKv8bl3
 rzZHlRfZdLiigD4yu118/PN/cJkZml21fiG0sjEsVGQrAMZ9MDX9CNSZ4lTbccfguOmD
 znPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687442269; x=1690034269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNxdEV8WFDJLmyw/5yS1+F5P/tLSBnf3oBZ+O84qKOA=;
 b=Uz6EZY4gdCEu7WVokssBPwnlRWyT8FahlFK0mYsKTKtOPENgMcRk688MBg6+YqGzt7
 TWOg00wHa2PLlTyrcoBHCaP26rspkD44KXS13iRUmCdusqeMmuBaK13W2WOV1d1a4Sf4
 X6lvoU3IuCVzGWzc5c3JCf04TFkwV0bxs77ptZyZOg6zTN1Z1n0BT0BMAwjeUfen61yp
 VJ+B7hK8g/2zK1OT7bl5cjrf/Z+t/lCDBNDAT7/F53G6oB08+LDYsOziH6lvDaxtqUjm
 GM6weUTKAj3v81CjnoITbyyoFumGKnN9iNs40/FyBdqgwQ2B3Es1qjcqyNxiNWOXovTJ
 CHqg==
X-Gm-Message-State: AC+VfDxJlcesZ5O2LzxaNmxsG3vtvl1phCjg4MTZXTacSWdceMOpKOTD
 wyzln4qKfao6Kk//56hVZALlRFQJtx2AgQHTXJg=
X-Google-Smtp-Source: ACHHUZ6jyOpGzs+6VnGCAeKGPH3ffpylVsiCJqCtGszhfto1Z8hByL179TGKwR7sdmWmRD1VkvS7BA==
X-Received: by 2002:a05:6808:210b:b0:3a0:56ff:be8a with SMTP id
 r11-20020a056808210b00b003a056ffbe8amr2072634oiw.25.1687442268946; 
 Thu, 22 Jun 2023 06:57:48 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a4aa446000000b00562f06fb5easm156677ool.11.2023.06.22.06.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 06:57:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 13/19] target/riscv/kvm.c: update KVM MISA bits
Date: Thu, 22 Jun 2023 10:56:54 -0300
Message-ID: <20230622135700.105383-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622135700.105383-1-dbarboza@ventanamicro.com>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2a.google.com
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
index fb5c5d4bfc..cb511ea8f1 100644
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


