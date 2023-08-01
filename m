Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A024276BFB1
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKI-0003rL-7Z; Tue, 01 Aug 2023 17:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKF-0003pO-Ou
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:43 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKC-0004lq-Hu
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:42 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so8798628e87.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926878; x=1691531678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tug+CECb4KNzufWe9Ppj5URciL2axuWNKJ5vUVPsbBc=;
 b=ylerMqvBqypNgpbhaMDxfmwF4Oovx7GZVkkI5MSrWZpB8DT38C8V550zY/fPIUXzES
 An27tPi/XmjezkwXX9CSj3w/c/TXW1UEZYMfB8I9B+9p4p6jpCkapocfIECy836Pp8mK
 WGa5r3/+s3QflqRq1D5oltytBVhxIhcwxx9HgOMRI2DujTfkOkoTAQUb+jPt+jwXSXCG
 R2/OGTVFWk6CiUaZkNR10SRT2BZUka5sw2MyvWKhE21Vg2VOZcQujquF5PH6S2yS7W23
 pX1tp69UOyv9wJMTEUJPUHNwtMhC8K5CgFK13zaY+WUn48EzPWQBrNHMAYQd6c76aKfS
 v7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926878; x=1691531678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tug+CECb4KNzufWe9Ppj5URciL2axuWNKJ5vUVPsbBc=;
 b=ftezxlr6cA/yLY2tq5jfXPObp40ougbJXwBXZObsVuFQ7urlaVt/KtSHucPG72PoVF
 so/H3b+QEgWCvxvgKOcv8hTEe5Rp7c0TB3SWDURO6qGCCnY51o6XJOqju11lk56J+0Es
 P93c03Uj7Zt3jbUhG1cUsNRVg1yemBsNQ9b8rhQeEkP0SuD8t/1t0cB309IPEDAOSVUu
 8RJtNrarMDvJxGY8Ty79DP+CQKsL5ZhPoDiLxOn/CVxzzN10HVi/gC+pmiTM0imjLpOL
 As1PECHjfeL5QweEZCDmmm5n0wjkLYO3m59BA9Fwrnpzei2MU76sLY0tUPeqX3F0ULBE
 l9XA==
X-Gm-Message-State: ABy/qLY+xFdnV6kkfqkqd8xYnu2PK3xJk7I5NUyWZ5zIuy87OglQAISX
 0DXdW8jqvUx3z713Rcf3Ai06LN8uBO8PLH/rdQk=
X-Google-Smtp-Source: APBJJlGiw1TbmWnbRDDuRPpCqyhP5V/xUsF2fEt4GgzrWdVJArNPx7JrJtrRFTtj0Y2V3OJLRyOlFw==
X-Received: by 2002:a05:6512:3d0c:b0:4fb:73ce:8e7d with SMTP id
 d12-20020a0565123d0c00b004fb73ce8e7dmr4581447lfv.15.1690926877903; 
 Tue, 01 Aug 2023 14:54:37 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a1c7c04000000b003fc06169abdsm25112wmc.2.2023.08.01.14.54.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:54:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/10] i386/xen: consistent locking around Xen singleshot timers
Date: Tue,  1 Aug 2023 23:54:13 +0200
Message-Id: <20230801215421.60133-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

From: David Woodhouse <dwmw@amazon.co.uk>

Coverity points out (CID 1507534, 1507968) that we sometimes access
env->xen_singleshot_timer_ns under the protection of
env->xen_timers_lock and sometimes not.

This isn't always an issue. There are two modes for the timers; if the
kernel supports the EVTCHN_SEND capability then it handles all the timer
hypercalls and delivery internally, and all we use the field for is to
get/set the timer as part of the vCPU state via an ioctl(). If the
kernel doesn't have that support, then we do all the emulation within
qemu, and *those* are the code paths where we actually care about the
locking.

But it doesn't hurt to be a little bit more consistent and avoid having
to explain *why* it's OK.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20230801175747.145906-3-dwmw2@infradead.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/xen-emu.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index d7c7eb8d9c..a8146115f0 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -43,6 +43,7 @@
 
 static void xen_vcpu_singleshot_timer_event(void *opaque);
 static void xen_vcpu_periodic_timer_event(void *opaque);
+static int vcpuop_stop_singleshot_timer(CPUState *cs);
 
 #ifdef TARGET_X86_64
 #define hypercall_compat32(longmode) (!(longmode))
@@ -466,6 +467,7 @@ void kvm_xen_inject_vcpu_callback_vector(uint32_t vcpu_id, int type)
     }
 }
 
+/* Must always be called with xen_timers_lock held */
 static int kvm_xen_set_vcpu_timer(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -483,6 +485,7 @@ static int kvm_xen_set_vcpu_timer(CPUState *cs)
 
 static void do_set_vcpu_timer_virq(CPUState *cs, run_on_cpu_data data)
 {
+    QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
     kvm_xen_set_vcpu_timer(cs);
 }
 
@@ -545,7 +548,6 @@ static void do_vcpu_soft_reset(CPUState *cs, run_on_cpu_data data)
     env->xen_vcpu_time_info_gpa = INVALID_GPA;
     env->xen_vcpu_runstate_gpa = INVALID_GPA;
     env->xen_vcpu_callback_vector = 0;
-    env->xen_singleshot_timer_ns = 0;
     memset(env->xen_virq, 0, sizeof(env->xen_virq));
 
     set_vcpu_info(cs, INVALID_GPA);
@@ -555,8 +557,13 @@ static void do_vcpu_soft_reset(CPUState *cs, run_on_cpu_data data)
                           INVALID_GPA);
     if (kvm_xen_has_cap(EVTCHN_SEND)) {
         kvm_xen_set_vcpu_callback_vector(cs);
+
+        QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
+        env->xen_singleshot_timer_ns = 0;
         kvm_xen_set_vcpu_timer(cs);
-    }
+    } else {
+        vcpuop_stop_singleshot_timer(cs);
+    };
 
 }
 
@@ -1059,6 +1066,10 @@ static int vcpuop_stop_periodic_timer(CPUState *target)
     return 0;
 }
 
+/*
+ * Userspace handling of timer, for older kernels.
+ * Must always be called with xen_timers_lock held.
+ */
 static int do_set_singleshot_timer(CPUState *cs, uint64_t timeout_abs,
                                    bool future, bool linux_wa)
 {
@@ -1086,12 +1097,8 @@ static int do_set_singleshot_timer(CPUState *cs, uint64_t timeout_abs,
         timeout_abs = now + delta;
     }
 
-    qemu_mutex_lock(&env->xen_timers_lock);
-
     timer_mod_ns(env->xen_singleshot_timer, qemu_now + delta);
     env->xen_singleshot_timer_ns = now + delta;
-
-    qemu_mutex_unlock(&env->xen_timers_lock);
     return 0;
 }
 
@@ -1115,6 +1122,7 @@ static int vcpuop_set_singleshot_timer(CPUState *cs, uint64_t arg)
         return -EFAULT;
     }
 
+    QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
     return do_set_singleshot_timer(cs, sst.timeout_abs_ns,
                                    !!(sst.flags & VCPU_SSHOTTMR_future),
                                    false);
@@ -1141,6 +1149,7 @@ static bool kvm_xen_hcall_set_timer_op(struct kvm_xen_exit *exit, X86CPU *cpu,
     if (unlikely(timeout == 0)) {
         err = vcpuop_stop_singleshot_timer(CPU(cpu));
     } else {
+        QEMU_LOCK_GUARD(&X86_CPU(cpu)->env.xen_timers_lock);
         err = do_set_singleshot_timer(CPU(cpu), timeout, false, true);
     }
     exit->u.hcall.result = err;
@@ -1826,6 +1835,7 @@ int kvm_put_xen_state(CPUState *cs)
          * If the kernel has EVTCHN_SEND support then it handles timers too,
          * so the timer will be restored by kvm_xen_set_vcpu_timer() below.
          */
+        QEMU_LOCK_GUARD(&env->xen_timers_lock);
         if (env->xen_singleshot_timer_ns) {
             ret = do_set_singleshot_timer(cs, env->xen_singleshot_timer_ns,
                                     false, false);
@@ -1844,10 +1854,8 @@ int kvm_put_xen_state(CPUState *cs)
     }
 
     if (env->xen_virq[VIRQ_TIMER]) {
-        ret = kvm_xen_set_vcpu_timer(cs);
-        if (ret < 0) {
-            return ret;
-        }
+        do_set_vcpu_timer_virq(cs,
+                               RUN_ON_CPU_HOST_INT(env->xen_virq[VIRQ_TIMER]));
     }
     return 0;
 }
@@ -1896,6 +1904,15 @@ int kvm_get_xen_state(CPUState *cs)
         if (ret < 0) {
             return ret;
         }
+
+        /*
+         * This locking is fairly pointless, and is here to appease Coverity.
+         * There is an unavoidable race condition if a different vCPU sets a
+         * timer for this vCPU after the value has been read out. But that's
+         * OK in practice because *all* the vCPUs need to be stopped before
+         * we set about migrating their state.
+         */
+        QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
         env->xen_singleshot_timer_ns = va.u.timer.expires_ns;
     }
 
-- 
2.38.1


