Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3180AC40
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfkd-0006DV-Ay; Fri, 08 Dec 2023 13:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkb-0006D0-RF
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:39:01 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkX-0008UW-DB
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:39:01 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2866af9d73bso2048597a91.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 10:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702060735; x=1702665535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDUfXfcWCozOr3YgPfrQcgZ6dHfOfa/IJlJz1rUOmVs=;
 b=Lh4uGZHE7CCxi8LRDEOsVbSVjUKk0U79gztgTYBR1/vIdCAuoPfmQxENj04fiRAN/8
 ErL8m4tqtGUwie7daQqO+KAtCG3whu0mDRSxOvV7Vkz5HS1vUfgV7XJGUH8l1zjeBHIY
 LggUnV2oKU87EYeBxKOb2RDYSvBgvUvOr8b08wxRsbxkJBTyq4CuhZVUmxvwLcGxmiRs
 N2vR3705uawMkH4kg3quZuZl95RaDm0EtU288+2XDpPe6BBfkE07jGF84vSgHlvZYatx
 mv8Nxg+lS310CdqotRvSR0/9RTS7DGBQ02NeblzpKC6eWEM0Sy2j/fKNiOziJPAwgjkV
 RuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702060735; x=1702665535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDUfXfcWCozOr3YgPfrQcgZ6dHfOfa/IJlJz1rUOmVs=;
 b=TdURLj2V8d01337+URNdmSCGLI6t83fXl2Bs+6XX2wEByYoNZhFmdN/eIaImM/+xCb
 tGKjNuUPiZ+A8tGYoPFVkX+IGRtVnTw48qavGQPLcWb2kYEPRHvATp3tlmTqrv4tfyvA
 AE0ZjbQqCN7zuZn8l+zxxYK0/H+jJ1oH6SqplPYlP0ICidijSVX+yXg9FMfGCaINjyKA
 UyPNVRonfzyZogJT9JQQrMrmukABW9olhSYVD9YsUiWa+BUcyzJ6RHID6EFY4mbPuUx+
 Trwds2OE1vLlalh3tKryt4icPX+vokBxVY7nN7/sEx9AghJc06MGfoIWqbzGvA59P1MW
 Z7Ag==
X-Gm-Message-State: AOJu0YyRudI7crgZIDsYqQtba4C+tgf6W2uyVgkn2AxKutOhOwW2QBgI
 JJoJR/81dAWttMjzokX4tmyRgVNl6N3JYrdiOQc=
X-Google-Smtp-Source: AGHT+IF5vNV7Ckzv3fFEibjYzWgBzqp+D4YZC+h1rf/ORom4P6rwIkG+3vr2+xs783PpYkpqrTZtOQ==
X-Received: by 2002:a17:90a:3482:b0:286:6cc1:8670 with SMTP id
 p2-20020a17090a348200b002866cc18670mr446596pjb.85.1702060735222; 
 Fri, 08 Dec 2023 10:38:55 -0800 (PST)
Received: from grind.. ([152.234.124.8]) by smtp.gmail.com with ESMTPSA id
 sk13-20020a17090b2dcd00b002864c14063fsm2190709pjb.20.2023.12.08.10.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 10:38:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 4/5] target/riscv/kvm: add RISCV_CONFIG_REG()
Date: Fri,  8 Dec 2023 15:38:34 -0300
Message-ID: <20231208183835.2411523-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
References: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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

Create a RISCV_CONFIG_REG() macro, similar to what other regs use, to
hide away some of the boilerplate.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 476e5d4b3d..11797338ec 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -88,6 +88,10 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
 #define RISCV_CSR_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CSR, \
                  KVM_REG_RISCV_CSR_REG(name))
 
+#define RISCV_CONFIG_REG(env, name) \
+    kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG, \
+                     KVM_REG_RISCV_CONFIG_REG(name))
+
 #define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
@@ -756,24 +760,21 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(mvendorid));
+    reg.id = RISCV_CONFIG_REG(env, mvendorid);
     reg.addr = (uint64_t)&cpu->cfg.mvendorid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(marchid));
+    reg.id = RISCV_CONFIG_REG(env, marchid);
     reg.addr = (uint64_t)&cpu->cfg.marchid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve marchid from host, error %d", ret);
     }
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(mimpid));
+    reg.id = RISCV_CONFIG_REG(env, mimpid);
     reg.addr = (uint64_t)&cpu->cfg.mimpid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
@@ -788,8 +789,7 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(isa));
+    reg.id = RISCV_CONFIG_REG(env, isa);
     reg.addr = (uint64_t)&env->misa_ext_mask;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
 
@@ -1094,8 +1094,7 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
     uint64_t id;
     int ret;
 
-    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                          KVM_REG_RISCV_CONFIG_REG(mvendorid));
+    id = RISCV_CONFIG_REG(env, mvendorid);
     /*
      * cfg.mvendorid is an uint32 but a target_ulong will
      * be written. Assign it to a target_ulong var to avoid
@@ -1107,15 +1106,13 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
         return ret;
     }
 
-    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                          KVM_REG_RISCV_CONFIG_REG(marchid));
+    id = RISCV_CONFIG_REG(env, marchid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
     if (ret != 0) {
         return ret;
     }
 
-    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                          KVM_REG_RISCV_CONFIG_REG(mimpid));
+    id = RISCV_CONFIG_REG(env, mimpid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
 
     return ret;
-- 
2.41.0


