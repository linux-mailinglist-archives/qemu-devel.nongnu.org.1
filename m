Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5D74994C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:21:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM41-00052U-Fv; Thu, 06 Jul 2023 06:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3z-0004t0-2k
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:15 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3x-0006eB-Ci
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:14 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b8baa72c71so456150a34.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638691; x=1691230691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIsSwZv0+6HkvL9zAUnCljJ7f9IbfLIHWBAcagEC0B4=;
 b=kf9443lYuUwXQkn4KqEl0YJu+NNwJuSBOnA8spt9nfNuTH3oCHuQlY7s84yFED5RLd
 BO9c80uk6Syf+4tTrXw+35FjxZhL6R72RYkp7KY8nF7Abq4hbaAfvslmSlgeS2oWxxaL
 GvmwTqDI4n/1kJDIMY2l+LIWxxBno2+QrEzFxDyQY9skELZlGzWnls7GNhQuB0JWwPFG
 vzLSPCVG/TCwX7xENObVFNL+eQv8yBKMt2IbiNX6eqiXfeBVw7h5eh1gYWQfO9Ia5PUZ
 RVoHELDf0y+HIcLkUSgnOmgjFqZi1YyxNL+9lSIrkMGw5rm4+eYZwz+Gp0c0ZEiU4QRc
 H9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638691; x=1691230691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIsSwZv0+6HkvL9zAUnCljJ7f9IbfLIHWBAcagEC0B4=;
 b=TAjx5TLoun5+kHGdiz01q9rvAs2KiqMOOlSxX7bo1NzBZvtEDnG0pKll9Owhn8w1dA
 IyBVltQW2JwwFDvoogvZ7yn/eDDhl8HoHn9qG0UetPJtVGJ90Hr3emHIFoLLXuyV0hra
 B623lqDf4Q4RoHAXIfiFhLgXLEOHI3OePlosJ0e0axmlbNlNODzLqlao1egZBRxYAJ0V
 u+Yi+mEPnrvUYV7NxfmlrUQdSNA3VTIbQZgDfSvKvXEmGD6PY3boyz8XwtzcVPxetN1+
 d1Q2HWH2UQ7bNWrZepA5qISdJD5eXBknUsYugz+HPN/0jxwllo+QRfnIGBSs7FPA2BCB
 vSWA==
X-Gm-Message-State: ABy/qLaz8R0yQV7OhyQHGYZxiyBGOgxSkOsZsTUiLZC4uyMSdbHmGJS8
 UJ5xy2qAm8x4Pg8D+Hu5JrUyvv4jBblmldJQr3k=
X-Google-Smtp-Source: APBJJlFw5Op88fU9OqEt3avsFgLRNPriTvShMBFLUoOAIpWNsJWssMOYZXbPFKiPKmcsbv07WKp1fw==
X-Received: by 2002:a05:6830:22f5:b0:6b7:5386:4a44 with SMTP id
 t21-20020a05683022f500b006b753864a44mr1550969otc.27.1688638691788; 
 Thu, 06 Jul 2023 03:18:11 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:18:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 08/20] target/riscv: handle mvendorid/marchid/mimpid for
 KVM CPUs
Date: Thu,  6 Jul 2023 07:17:26 -0300
Message-ID: <20230706101738.460804-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706101738.460804-1-dbarboza@ventanamicro.com>
References: <20230706101738.460804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32d.google.com
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

After changing user validation for mvendorid/marchid/mimpid to guarantee
that the value is validated on user input time, coupled with the work in
fetching KVM default values for them by using a scratch CPU, we're
certain that the values in cpu->cfg.(mvendorid|marchid|mimpid) are
already good to be written back to KVM.

There's no need to write the values back for 'host' type CPUs since the
values can't be changed, so let's do that just for generic CPUs.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index cd2974c663..602727cdfd 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -495,6 +495,33 @@ void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
 
+static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t id;
+    int ret;
+
+    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                          KVM_REG_RISCV_CONFIG_REG(mvendorid));
+    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mvendorid);
+    if (ret != 0) {
+        return ret;
+    }
+
+    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                          KVM_REG_RISCV_CONFIG_REG(marchid));
+    ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
+    if (ret != 0) {
+        return ret;
+    }
+
+    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                          KVM_REG_RISCV_CONFIG_REG(mimpid));
+    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
+
+    return ret;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
@@ -513,6 +540,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     env->misa_ext = isa;
 
+    if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
+        ret = kvm_vcpu_set_machine_ids(cpu, cs);
+    }
+
     return ret;
 }
 
-- 
2.41.0


