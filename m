Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFA374390A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB3a-0005A4-VO; Fri, 30 Jun 2023 06:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3Y-00059L-To
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:48 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3X-0000ne-BK
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:48 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b055511b85so1449135fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119726; x=1690711726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIsSwZv0+6HkvL9zAUnCljJ7f9IbfLIHWBAcagEC0B4=;
 b=IqxXxKSoVKptP9WLdUx5R4cPwzAbbWJ2unZXaSqnwnHUF8bhNhFVZ8Uq6bgjqMhpQp
 0LLlV8z9bCXf1J+3Mn6xNrJVtecMeTQVEPqqcH1M6l0vwmXqVgLmsgv1GLYMYVgqutZ8
 g/9xLDAJvbNF2CdFr9EFuSrPrBdHAylt0ovclU0/PGlr67ZfSHiMmOaHx8jsnOuOCB4r
 PCina0ENqTR7lZITPm40fq2tWK8diPA4taXRfqSy9naWCObNwQOFmFQgYV4n9Wn/M5PS
 oRJ4hDa+9r6+U/a13AryUMP5p+gqvEv0dExBctajzTGQBjgVbFOFUXs4zDPqf97ut58/
 0yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119726; x=1690711726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIsSwZv0+6HkvL9zAUnCljJ7f9IbfLIHWBAcagEC0B4=;
 b=NzlioPrjwl0tEWLdQpEsPEUvbasIERducBwkteafcuwYDd+m5vAUDkSkx6TvbDRbwR
 kQSAQJA/iYHPBQg2Bdp3Aie2UT9vwJpcG+QUWsEFSk0MmWs7J1J08ZZY21o6jxkjrTQd
 AXPtAQFPKt57e3Ho38yBlZfxEL8stnCw8bOAWwQ079u10tJvaE3X83HDEG5nW81pyKkS
 6psA2q3xlBw6azWyVT/Hx6QbktVHJJFH4q2vu1mkKcAHyzw45tEdfRQRmrlLEvTlOxyl
 63NG3/jtN+TSYFkZbj1wVDAGc+s5jXJPbHQyXSvp05lkZW5qUrTl1vR6Fq9HKlp0qfR3
 m7VA==
X-Gm-Message-State: ABy/qLao7njZ0YS1kmut2DFWy3Cubqd6irlEVXwvP7zhSQVRqvBtHYP5
 CVM+OqOFV6m4QhfM65GcXNg+AcVzTOG9N7M0tcM=
X-Google-Smtp-Source: ACHHUZ7t+k623Up5S41fE+/RKW7vn4bTdl7P3D45iB5KVWmPj13EvHLD7wqf3vIYDRUTLubYwHrsow==
X-Received: by 2002:a05:6870:75ca:b0:1aa:30e3:6a5e with SMTP id
 de10-20020a05687075ca00b001aa30e36a5emr2959005oab.22.1688119725985; 
 Fri, 30 Jun 2023 03:08:45 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:08:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 08/20] target/riscv: handle mvendorid/marchid/mimpid for
 KVM CPUs
Date: Fri, 30 Jun 2023 07:07:59 -0300
Message-ID: <20230630100811.287315-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100811.287315-1-dbarboza@ventanamicro.com>
References: <20230630100811.287315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
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


