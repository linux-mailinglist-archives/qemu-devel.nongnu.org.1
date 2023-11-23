Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067C7F5781
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:45:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YX-0006fW-M5; Wed, 22 Nov 2023 23:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y6-0006Ru-RI
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:48 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y2-0006HN-Hu
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:46 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b52360cdf0so282968b6e.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714560; x=1701319360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iSZMQtowpDEmNjGPUjOpszRYxZbjV35t/gkG9vRYI4=;
 b=W9L/RIqoAQBzuw3sum3jbM5n8l3KwBU/9ZPt4lG/XoKM9rBq6Yz+832Fo/6dqhIcoN
 xK1WHQkafAMXV79EFuoW18iY+nGhSeZPTGZvG2YPfisIl6WKmf6yWs0L6ATSwKo3CXDH
 QLGQxoC00Wq2xjFrNTqpQ/Q7ivAMJmAuhSxl0Iv7WdMThomPT1BpaXoOuyyU6nQEm5QK
 1jlez+wjoU4mVZa3z0fNQIok0Mz6MHpHEPzTHKom10ZH2+YBeRfiDfObja2qHWY3Fh85
 OUGL4hl4zKhttK0MOjCOsGidqHqlTlBarb2oLQW8DR8Xz/f7E+/Z4VgYRvk5uFDlHY3R
 zvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714560; x=1701319360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iSZMQtowpDEmNjGPUjOpszRYxZbjV35t/gkG9vRYI4=;
 b=JqLX46p+h5UVmlaoIJemBqbCy5MBmLXQt5qlaX3kLZdUvNNCiizZHOBeD59Fb/d3Go
 Js6HUTguZiJHmnK5gNqppYUlOFdh0szQu5AsvSN3SpfI+MI7lHx7lb/pdIKSK2wr6Fyx
 1nDAxrTNtfFHrxq9V8hGQx+os0S122R7jrnRb9R8oZrV32ks8lVFwhmd+sgA1wfc6VBu
 LLbkUPZRDWMIdxALcC1Oh/7gwLbqhQD3tTgWZzZCGBL1t0yyjrw8kC7hbRIlbDoD7913
 CkSnFtdrLfWPp/PKk0CW4CviExsEcZTgAIqhLDIvFKZoJj4CreCRsPDZUzxk9iKvEiTk
 jyQQ==
X-Gm-Message-State: AOJu0Yz/Q5iSCmfrz6dCClKJjR9QOs35J+qJlfAs58m/4OA8YIL3u1zi
 wwWdb14YjHu6ar1RdqFpTwsSckVODozWxkdOFe8jf/lT
X-Google-Smtp-Source: AGHT+IHM5SR7BfMp+++fBemOjmQneHyqpOOD1guFoMrhjSfeB15iaQFqVmuYdOzratxzDyM15JXVmA==
X-Received: by 2002:a05:6808:1247:b0:3b2:dd32:2fe9 with SMTP id
 o7-20020a056808124700b003b2dd322fe9mr4916802oiv.35.1700714559780; 
 Wed, 22 Nov 2023 20:42:39 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 18/21] target/arm/kvm: Init cap_has_inject_serror_esr in
 kvm_arch_init
Date: Wed, 22 Nov 2023 22:42:16 -0600
Message-Id: <20231123044219.896776-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

There is no need to do this in kvm_arch_init_vcpu per vcpu.
Inline kvm_arm_init_serror_injection rather than keep separate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h |  8 --------
 target/arm/kvm.c     | 13 ++++---------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 350ba6cb96..1ec2476de7 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -98,14 +98,6 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
-/**
- * kvm_arm_init_serror_injection:
- * @cs: CPUState
- *
- * Check whether KVM can set guest SError syndrome.
- */
-void kvm_arm_init_serror_injection(CPUState *cs);
-
 /**
  * kvm_get_vcpu_events:
  * @cpu: ARMCPU
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index bc4ba7628b..3250919273 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -96,12 +96,6 @@ static int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
     return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
 }
 
-void kvm_arm_init_serror_injection(CPUState *cs)
-{
-    cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
-                                    KVM_CAP_ARM_INJECT_SERROR_ESR);
-}
-
 bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init)
@@ -562,6 +556,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    /* Check whether user space can specify guest syndrome value */
+    cap_has_inject_serror_esr =
+        kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
+
     if (ms->smp.cpus > 256 &&
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
@@ -1948,9 +1946,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    /* Check whether user space can specify guest syndrome value */
-    kvm_arm_init_serror_injection(cs);
-
     return kvm_arm_init_cpreg_list(cpu);
 }
 
-- 
2.34.1


