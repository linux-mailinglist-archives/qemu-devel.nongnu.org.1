Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54574716DF2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:48:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45JR-0006mr-R5; Tue, 30 May 2023 15:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45JK-0006jI-Fy
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:47:15 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45JH-0004L2-80
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:47:12 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-19a13476ffeso3821996fac.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685476030; x=1688068030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cd9JOx+5sZlBShuxbAm/YknaytC2WuApRr7KjE0e3dw=;
 b=U+s8u7dzwJHe3/qDV4ql8xRxSpcb9bgQ0vfvh8ionCECTwOlnvohWTITpBEsxPPjR9
 KpZYGKsDQtMWljAJT66GWK8ERBuTg3oAR3f3RUmNL/qT6SBscJyng13K7txVTegISsMZ
 wtK9uaUE8J+RGqprY2EPMpJ+SzOsCluvQDD4H1yZ98DsabLsp9dRWut+zr3yrnb8EZVS
 56cAiJiz9P1v6G919q2PiLwhtybgmDRp9adaxODZ8lqxwJq5fuR+BYhwuhrz9ftEr1J7
 ufD/EVTXp8o8Ba4a2MadgtpnjuDgeqcI+NIYwaNpk2kbQmcr4JrgQMiMhxCAIbY2PE4Z
 niRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685476030; x=1688068030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cd9JOx+5sZlBShuxbAm/YknaytC2WuApRr7KjE0e3dw=;
 b=cj0KF7m2Me/yKEHe2LXmWw1M4hAanE7AF21konOUb0l1OvspBt5tXPwkPD/aOeo0dP
 8rklD3H1vMGsxDF5SSua5aKkbK0kBAAlbW8FdGdk+7z73r6EphEWk42o7FNz8zJu7qOF
 XmR4Nc9a0aZQrpd/RyWkm5GDr1zI1O4DQGI/bAUG+Tozr2fVMOlffPus4uQZdBl9Smmz
 SbJ0/R5f+nbsOnEgPnQdQpo317+a1RnXNWsAj9GbiC0uZdLIkkyiGvK1q0qMIteWiBJb
 DcO4QpKAJec7fWxZtqBHuqNxEvDEYRgYH41XgoaLcK5ObrKsMCAW7FWKXMN0Ujp8us0w
 A4mQ==
X-Gm-Message-State: AC+VfDx5zz04g27T9aeQq/m+w7MDGHto2XWPlHaBQE3BOhk9QsgzbLIo
 ubJyX4I1OEiDJQSmnfMMJQzzb+ocPVN42wLqfhI=
X-Google-Smtp-Source: ACHHUZ74J/dintgtnuTEUvXiFquyGTVNCezfqGVB/mRu1nZFK9OgWhpHQw6M/aMbtZ/kW2kyxeM5Fw==
X-Received: by 2002:a05:6871:8e06:b0:19f:698f:56a1 with SMTP id
 zp6-20020a0568718e0600b0019f698f56a1mr1514796oab.15.1685476029729; 
 Tue, 30 May 2023 12:47:09 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-121.static-corp.ajato.com.br. [200.162.225.121])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056870a48300b0019fa8728b05sm342214oal.39.2023.05.30.12.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:47:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 12/16] target/riscv/kvm.c: update KVM MISA bits
Date: Tue, 30 May 2023 16:46:19 -0300
Message-Id: <20230530194623.272652-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530194623.272652-1-dbarboza@ventanamicro.com>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x31.google.com
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

For MISA bits we're going to be a little more conservative: we won't
even try enabling bits that aren't already available in the host. The
ioctl() is so likely to fail that's not worth trying. This check is
already done in the previous patch, in kvm_cpu_set_misa_ext_cfg(), thus
we don't need to worry about it now.

In kvm_riscv_update_cpu_misa_ext() we'll go through every potential user
option and do as follows:

- if the user didn't set the property or set to the same value of the
host, do nothing;

- Disable the given extension in KVM. If it fails we need to verify the
error code. -EINVAL indicates that KVM doesn't know about the reg, so
re-enable the extension in env->misa_ext and keep booting. If it fails
for any other reason we're going to exit out.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 6afd56cda5..bb1dafe263 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -166,6 +166,42 @@ static void kvm_cpu_set_misa_ext_cfg(Object *obj, Visitor *v,
                "enabled in the host", misa_ext_cfg->name);
 }
 
+static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t id, reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
+        RISCVCPUMisaExtConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
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
+            if (ret == -EINVAL) {
+                /*
+                 * KVM doesn't know how to handle this bit. Since
+                 * it's an extension that the user wants to disable,
+                 * do not error out.
+                 */
+                continue;
+            } else {
+                error_report("Unable to set KVM reg %s, error %d",
+                             misa_cfg->name, ret);
+                exit(EXIT_FAILURE);
+            }
+        }
+        env->misa_ext &= ~misa_cfg->misa_bit;
+    }
+}
+
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
@@ -632,8 +668,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
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
2.40.1


