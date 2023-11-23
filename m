Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6E7F577F
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:45:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YM-0006dW-SA; Wed, 22 Nov 2023 23:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y7-0006TM-Mg
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:48 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y4-0006Hp-1H
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:47 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b52360cdf0so282977b6e.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714562; x=1701319362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMxrWeuiHOLByxeE5N6Cs/cc7NkJUHDeIn2aLelpULE=;
 b=QGdVhUsKc5Ko4aCEd/QuwPa5MF68JTZuE3ZVVI/vAz0zeyHTqtlikRzHX1eg+dEe5I
 AvBrV2MQ5u4kYAgSeHXd2IxEwoBc3hLQCHzwQFC8DshpDE7ajNssMTaPznqOI2VHaAZH
 UuEOjz++0fit43Xi7bzZm3/HbNtiPpXkburwtPVaBD4P5jliIGuLB9elpOTU+ShcQzFQ
 WRJlwtg2vqRmrdBW/Nf0D28P5s4de6tgU4cU+ATlgnwaaOHjNwvUKqcOM31WZ9nN3ZTc
 N5MvX7I8ID0Jfo1v9qUTMQtNRg2JcFmVQr8b88+Y9vvGoMnJVc15RVMAt1+eHR8rJTdD
 NEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714562; x=1701319362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMxrWeuiHOLByxeE5N6Cs/cc7NkJUHDeIn2aLelpULE=;
 b=OXe6t3oEIDfQW8n2sL3/uMQ+AuvI7ogFEz+wlm9UHtOE6niJ/kBIsAEIggr2rIk/s5
 p7DhtlP3F6fNOblGCrgc/D/Okt3ky5frL5Q35hEV8HJkyzRw4P/srEr2/U4r5Dz6Ot4/
 /fc5m7MLBtiqM2MUAH+w1vPCFX24UwaGSLxcsp5fJgqBPbxtwTEW04mLsAYlUKoI6RhW
 0ffINa6XQBRsWTQxWtlwYHIilbAXF/eO7p4OrcCOo8oTxfUD/0BbN2vNo+g1m1tdYdws
 Fxr+PiuJ2sgZZVILarKDGcOWVR8UssLSS2g14KQ32x98Ufk924NTruEfn6V4PfsvSGrm
 1L4A==
X-Gm-Message-State: AOJu0Yxi6okzhhPIB1Fvc21Zd/26hWTBu87loEHY3LdTxCDMcPPdODwW
 tIyrWFZ4GfIl/S8x4zG01/NS0MagEl9fEKYtBfExy9aO
X-Google-Smtp-Source: AGHT+IHJsOa7qNEOJzfrry7beIAknR39vUMO6yPd+pVe1flEUkVOj5KQe1c3dTwCFGZSQLuFo36x9A==
X-Received: by 2002:a05:6808:1a0d:b0:3b2:dfa0:aea3 with SMTP id
 bk13-20020a0568081a0d00b003b2dfa0aea3mr5571900oib.3.1700714562036; 
 Wed, 22 Nov 2023 20:42:42 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 20/21] target/arm/kvm: Unexport and tidy
 kvm_arm_sync_mpstate_to_{kvm, qemu}
Date: Wed, 22 Nov 2023 22:42:18 -0600
Message-Id: <20231123044219.896776-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Drop fprintfs and actually use the return values in the callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h | 20 --------------------
 target/arm/kvm.c     | 23 ++++++-----------------
 2 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b4339d49d1..8a44a6b762 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -200,26 +200,6 @@ bool kvm_arm_sve_supported(void);
  */
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
 
-/**
- * kvm_arm_sync_mpstate_to_kvm:
- * @cpu: ARMCPU
- *
- * If supported set the KVM MP_STATE based on QEMU's model.
- *
- * Returns 0 on success and -1 on failure.
- */
-int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
-
-/**
- * kvm_arm_sync_mpstate_to_qemu:
- * @cpu: ARMCPU
- *
- * If supported get the MP_STATE from KVM and store in QEMU's model.
- *
- * Returns 0 on success and aborts on failure.
- */
-int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
-
 void kvm_arm_vm_state_change(void *opaque, bool running, RunState state);
 
 int kvm_arm_vgic_probe(void);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f9aa55b1a0..19454f432a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1006,41 +1006,32 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
 /*
  * Update KVM's MP_STATE based on what QEMU thinks it is
  */
-int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu)
+static int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu)
 {
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state = {
             .mp_state = (cpu->power_state == PSCI_OFF) ?
             KVM_MP_STATE_STOPPED : KVM_MP_STATE_RUNNABLE
         };
-        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
-        if (ret) {
-            fprintf(stderr, "%s: failed to set MP_STATE %d/%s\n",
-                    __func__, ret, strerror(-ret));
-            return -1;
-        }
+        return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
     }
-
     return 0;
 }
 
 /*
  * Sync the KVM MP_STATE into QEMU
  */
-int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
+static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
 {
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state;
         int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
         if (ret) {
-            fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
-                    __func__, ret, strerror(-ret));
-            abort();
+            return ret;
         }
         cpu->power_state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ?
             PSCI_OFF : PSCI_ON;
     }
-
     return 0;
 }
 
@@ -2184,9 +2175,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    kvm_arm_sync_mpstate_to_kvm(cpu);
-
-    return ret;
+    return kvm_arm_sync_mpstate_to_kvm(cpu);
 }
 
 static int kvm_arch_get_fpsimd(CPUState *cs)
@@ -2367,7 +2356,7 @@ int kvm_arch_get_registers(CPUState *cs)
      */
     write_list_to_cpustate(cpu);
 
-    kvm_arm_sync_mpstate_to_qemu(cpu);
+    ret = kvm_arm_sync_mpstate_to_qemu(cpu);
 
     /* TODO: other registers */
     return ret;
-- 
2.34.1


