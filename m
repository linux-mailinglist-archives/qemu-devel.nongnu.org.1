Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF6716DEE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45J9-0006ci-VP; Tue, 30 May 2023 15:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45J6-0006bM-Dr
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:47:00 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45J4-0004Ja-S2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:47:00 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6af6b6837acso3567807a34.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685476017; x=1688068017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2MGPPJ0plm+6/+zmeg7JR1jnjsVFqkpNJ2x5NNUP5s=;
 b=NRDgC6hkXxRpNuJ2foitjcc+pVW/gYFlIq5YpOb9AvwUipGts7YiVlhs43evRlPV7T
 YFcJcnDaVpVmt54Ap1+bYh2okWzAhxU0hlEmBXYpo3DYySDmfjDy4n4SK+Kjf3CDAEwn
 244WUBczcaURbZmXp+8kQS1GulvfFYH67TIa2DKgiEMIb5M1cE/dimD0I7tKZxDez/R6
 g2sOrRQ57rPXays3OmE47dUXh3WWIoZB7SGtCdJdH/MTNF33Ei81sPtE8DkZ4uslzi6V
 Tj+dWr6Z5TA1paRKBOwPtd0SeIy+DlfwoXI/4Ji4A26+K9HNPtmRc3SBiKCaSdB3yHVi
 L1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685476017; x=1688068017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2MGPPJ0plm+6/+zmeg7JR1jnjsVFqkpNJ2x5NNUP5s=;
 b=JoW6suQ/n9zwTmF5asr4srRCWIVMYuJzj95i2z7WVh8PproZwHF3AYX1yvKlm7mEtW
 gE9SBR8dP/Z7q1WvYznM20+gzNKB5fDmbIZiitn/tOx0hl3w4pEj4aIRsqJJiGFPW/nI
 jTDjqew6sWs1hCm/6bFXM3+M6BSmY2+LclD0ym8Y3QFQnfERZIseT+R+k7zLw9OpDFFU
 iVknVcoxyxGc/Z66VJAoXKT9kF0yQIbDJwOP1ToHmxgbkfF23pN0ySZDj2SKhcRKA+yx
 XRwclxmhCTaFhGDVecRD6SfgDsjR/5G7IRuCWP5dN87TgZVjsHdq55wbng2p6ziEKSpy
 dXfQ==
X-Gm-Message-State: AC+VfDx+WNO8a+YeKWQOVgjxIQ+KdECwcli0BLUif3VLoBs89wkaxynX
 mmgU9FS7TsLDiPOHza+TWYtFJNSpo1xFMxXbNFs=
X-Google-Smtp-Source: ACHHUZ6+Rj7+Xt3dFq5nX0m+eJSIRWGE799WN6FkXG26KnI9ItxifADX0WxNg7J67/M4J16Xn7lVWw==
X-Received: by 2002:a05:6808:f12:b0:398:6452:5bed with SMTP id
 m18-20020a0568080f1200b0039864525bedmr2201719oiw.20.1685476017402; 
 Tue, 30 May 2023 12:46:57 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-121.static-corp.ajato.com.br. [200.162.225.121])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056870a48300b0019fa8728b05sm342214oal.39.2023.05.30.12.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:46:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 08/16] target/riscv: handle mvendorid/marchid/mimpid for KVM
 CPUs
Date: Tue, 30 May 2023 16:46:15 -0300
Message-Id: <20230530194623.272652-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530194623.272652-1-dbarboza@ventanamicro.com>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32f.google.com
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
2.40.1


