Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F67D788B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnIj-0002S1-4k; Wed, 25 Oct 2023 19:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIH-000273-RD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIF-0005KI-W0
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZY5//aD518+bnTqOsfjSVpnnQxspKQErGS97zV8JuKw=;
 b=ZIGa4FjoQ0dTeI1BASarxny3keoQ7YAhxHGP4/Mo2Q5jgUY6B/oBLw+3jlMOv3hmY5wP4I
 VpS0TdOlS1zXTs7l+FU4HMcFSPdVCz/iAiojzE9+vRcVnuAfMYdA1O3TUW9q+bJgIv8HNZ
 lHklcSadBHp4tNkRcurMbDi/Jw5tjzI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-Ickhse0RMDSpb2JypViMtg-1; Wed, 25 Oct 2023 19:28:04 -0400
X-MC-Unique: Ickhse0RMDSpb2JypViMtg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778b3526240so41220085a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276484; x=1698881284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZY5//aD518+bnTqOsfjSVpnnQxspKQErGS97zV8JuKw=;
 b=cslIMn3ofnD1sGYpQaAWKnmqMLHI+Wf2oY0DDSzKRuuEyM/D7m5uS3Sge7ZZ1GusGD
 iymIQfBUR4nDijDfk+w4jaIKo5cIHLADm5TQQ+pp5GcbfBtvqmhrVHPALW0944krKalr
 zTQRE8RgvYLQk1DOlW9WJGsphoACqnlzaC8b3Z7gNYTFtdh4wYqNVm7Xsx8jg4PdYwO5
 ABNxbeqspRE2mO0dqYLCzrI9NYCSRdBf1pVrb6hPyjjamABOrx169HQG5e3cIpLB7/rE
 Cw4mXhejeV6EsPsUmhMC/YM1JzMcwCYCHcpMqv6a8S4vFHxX7XFE1SA6yWv63Q3mtmOJ
 HPWw==
X-Gm-Message-State: AOJu0YwxgFeRxg78UYvmsIS2dffiO+wxdqKk2mGdA9rZerQgWOwKjeYV
 IefJzmScertRt+3Iz6M91bbsbQBVNYcGUFQp1QQyioiK4Ibjsd6k4OAM2o6MVyXZUI0uOBbJWBt
 K88pVlmK9bKWbMDeCy5GKj1wlxhDox58g3gWXLK6EsmmbJkT4+lD4jD3rcGh/RIz1d5TL54tgC0
 Y=
X-Received: by 2002:a05:620a:16d6:b0:774:139a:e442 with SMTP id
 a22-20020a05620a16d600b00774139ae442mr16926344qkn.76.1698276483933; 
 Wed, 25 Oct 2023 16:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo01mt/6nNMcd+yPayeP6PNi/iIG/xPMUJEZyyll8mmknmhTkZ3vPX9yKNVMd4KEcwOmvudQ==
X-Received: by 2002:a05:620a:16d6:b0:774:139a:e442 with SMTP id
 a22-20020a05620a16d600b00774139ae442mr16926330qkn.76.1698276483505; 
 Wed, 25 Oct 2023 16:28:03 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 bq12-20020a05620a468c00b007678973eaa1sm4576761qkb.127.2023.10.25.16.28.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:28:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/24] kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2
Date: Thu, 26 Oct 2023 01:27:17 +0200
Message-ID: <20231025232718.89428-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/i8254.c        | 38 ++++++++++++--------------------------
 hw/i386/pc.c               |  6 +-----
 target/i386/kvm/kvm.c      |  7 -------
 target/i386/kvm/kvm_i386.h |  1 -
 4 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index a649b2b7caf..e49b9c4b565 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -97,24 +97,12 @@ static void kvm_pit_get(PITCommonState *pit)
         return;
     }
 
-    if (kvm_has_pit_state2()) {
-        ret = kvm_vm_ioctl(kvm_state, KVM_GET_PIT2, &kpit);
-        if (ret < 0) {
-            fprintf(stderr, "KVM_GET_PIT2 failed: %s\n", strerror(-ret));
-            abort();
-        }
-        pit->channels[0].irq_disabled = kpit.flags & KVM_PIT_FLAGS_HPET_LEGACY;
-    } else {
-        /*
-         * kvm_pit_state2 is superset of kvm_pit_state struct,
-         * so we can use it for KVM_GET_PIT as well.
-         */
-        ret = kvm_vm_ioctl(kvm_state, KVM_GET_PIT, &kpit);
-        if (ret < 0) {
-            fprintf(stderr, "KVM_GET_PIT failed: %s\n", strerror(-ret));
-            abort();
-        }
+    ret = kvm_vm_ioctl(kvm_state, KVM_GET_PIT2, &kpit);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_GET_PIT2 failed: %s\n", strerror(-ret));
+        abort();
     }
+    pit->channels[0].irq_disabled = kpit.flags & KVM_PIT_FLAGS_HPET_LEGACY;
     for (i = 0; i < 3; i++) {
         kchan = &kpit.channels[i];
         sc = &pit->channels[i];
@@ -170,12 +158,9 @@ static void kvm_pit_put(PITCommonState *pit)
         kchan->count_load_time = sc->count_load_time - s->kernel_clock_offset;
     }
 
-    ret = kvm_vm_ioctl(kvm_state,
-                       kvm_has_pit_state2() ? KVM_SET_PIT2 : KVM_SET_PIT,
-                       &kpit);
+    ret = kvm_vm_ioctl(kvm_state, KVM_SET_PIT2, &kpit);
     if (ret < 0) {
-        fprintf(stderr, "%s failed: %s\n",
-                kvm_has_pit_state2() ? "KVM_SET_PIT2" : "KVM_SET_PIT",
+        fprintf(stderr, "KVM_SET_PIT2 failed: %s\n",
                 strerror(-ret));
         abort();
     }
@@ -261,11 +246,12 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
     };
     int ret;
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
-        ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
-    } else {
-        ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT);
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PIT_STATE2) ||
+        !kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
+        error_setg(errp, "In-kernel PIT not available");
     }
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
     if (ret < 0) {
         error_setg(errp, "Create kernel PIC irqchip failed: %s",
                    strerror(-ret));
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 11fed78d178..6031234a73f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1214,12 +1214,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 
     /*
      * Check if an HPET shall be created.
-     *
-     * Without KVM_CAP_PIT_STATE2, we cannot switch off the in-kernel PIT
-     * when the HPET wants to take over. Thus we have to disable the latter.
      */
-    if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
-                               kvm_has_pit_state2())) {
+    if (pcms->hpet_enabled) {
         qemu_irq rtc_irq;
 
         hpet = qdev_try_new(TYPE_HPET);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e364b842e6d..770e81d56e4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -145,7 +145,6 @@ static uint32_t num_architectural_pmu_fixed_counters;
 
 static int has_xsave2;
 static int has_xcrs;
-static int has_pit_state2;
 static int has_sregs2;
 static int has_exception_payload;
 static int has_triple_fault_event;
@@ -162,11 +161,6 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RANGES];
 static RateLimit bus_lock_ratelimit_ctrl;
 static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
-bool kvm_has_pit_state2(void)
-{
-    return !!has_pit_state2;
-}
-
 bool kvm_has_smm(void)
 {
     return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
@@ -2543,7 +2537,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
-    has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
     has_sregs2 = kvm_check_extension(s, KVM_CAP_SREGS2) > 0;
 
     hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 7e60ea4f23f..30fedcffea3 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,7 +33,6 @@
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
 bool kvm_hv_vpindex_settable(void);
-bool kvm_has_pit_state2(void);
 
 bool kvm_enable_sgx_provisioning(KVMState *s);
 bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
-- 
2.41.0


