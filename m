Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E365D7CE2F6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:39:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Z4-0001du-ON; Wed, 18 Oct 2023 12:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Yn-0001PV-Hz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Yl-0007QU-Qn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKZyCSNjjP6HQEmWy1mFmMwgg9xL+PtkdeavECS0iEU=;
 b=QKiRYNskGuZkSHBFzvaSorg2DSygW4yUAkkkGfCZut5PjnIPnq1AHzYPV+ZHHm5MHCBDIw
 niQhgohSXyQ6Bl0tM1aO0Oc6Aqfq7ogDAsFq5t1pVqVEcdLxasKn/+XHhSj6fZirezTAGp
 6mkwCoYBRklyAzA45+i3/nknG2tmESs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-QLH6UMIHODiV2eyG2HMRPA-1; Wed, 18 Oct 2023 12:38:03 -0400
X-MC-Unique: QLH6UMIHODiV2eyG2HMRPA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9c15543088aso433908266b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647082; x=1698251882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKZyCSNjjP6HQEmWy1mFmMwgg9xL+PtkdeavECS0iEU=;
 b=RbkOBYyn9uj8DrSxBEoDG8NDJiSwNcJ9XbifQuWJilmmkhWQjO+5FTgJQMhUZFNUX4
 uzCfgyAA3GG8eDrLVuWla0T6b52UysbhKX82ILszp7MAE17GTJ4yodIJ7niQ2ylPuTQt
 IpoCAvqkSL29I9JcU+Tvn85Q241lVGJ6+0xZK/9zpUlDSSdGK7YukR1iU5/3BNZheIw2
 qQXm8vLZJ4PGRuIyXl812lWc/AqzL7th3ky4xyZ7MR6tiynHmtibLxLPcEY5ZbmdK6Qm
 M3bAd3wCo0d3ogqU6Cw9WYdrFufIjurWoQy9NEx7pbgwiBUExpNf45BIova1YT9yHmfJ
 W0Yg==
X-Gm-Message-State: AOJu0Yyww1Tw9uVTWEeu0WLSdG2WHcvMuYti7J0zy5Ox5zGj7df6kFGu
 HqxP3lmATHVgVYgayRn/UW1lA0PtCObK/dwHE1PcObTYpLsFeZrw5rqcyINya6YSCw52YQjuDXi
 4YALeG7L8mrmxN+9T8ARKdzPUncLkloYSITdd0OuviggibHrQiaQzBShomPTGO0QBh3wqRXbwuK
 8=
X-Received: by 2002:a17:906:4fc7:b0:9ae:705a:8451 with SMTP id
 i7-20020a1709064fc700b009ae705a8451mr5126818ejw.25.1697647082350; 
 Wed, 18 Oct 2023 09:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH18g87aEWDL6xpW6jb5elk1saANSTB/7ejguy3d0GUzegtHsgbgJhYP8AOIel1s2EbspBIuQ==
X-Received: by 2002:a17:906:4fc7:b0:9ae:705a:8451 with SMTP id
 i7-20020a1709064fc700b009ae705a8451mr5126804ejw.25.1697647081978; 
 Wed, 18 Oct 2023 09:38:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 mb8-20020a170906eb0800b0098951bb4dc3sm1963879ejb.184.2023.10.18.09.38.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:38:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/17] kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2
Date: Wed, 18 Oct 2023 18:37:28 +0200
Message-ID: <20231018163728.363879-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index bb3854d1d08..f3793dd0633 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1213,12 +1213,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 
     /*
      * Check if an HPET shall be created.
-     *
-     * Without KVM_CAP_PIT_STATE2, we cannot switch off the in-kernel PIT
-     * when the HPET wants to take over. Thus we have to disable the latter.
      */
-    if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
-                               kvm_has_pit_state2())) {
+    if (pcms->hpet_enabled) {
         hpet = qdev_try_new(TYPE_HPET);
         if (!hpet) {
             error_report("couldn't create HPET device");
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a3d52cb538f..cbb8db6ea70 100644
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


