Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 270EE7CE30F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:41:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Yj-0001KX-K3; Wed, 18 Oct 2023 12:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YZ-00016I-DJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YX-0007PY-3o
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fffmKAk2Mzul0/4WuRS85RgZzOjDwr5HJtxi7DJFtFQ=;
 b=ftk/N4XV8u7wFJP65rE/95TxMBRVQjGfPvy29cbmIfiI8XbvxXLLMRkuJJ8RfZSgWlWUjV
 NOHTlZgBVyhccf3uwlVYeFvwCr+immb4RNJfiLYs9LAGS9M7L36hFNcvOx4F7BFML705AM
 1IXz2H1At7IIQElXNz6qyJriInrPYJ4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-9-LOLCYNMjOfNu7cJnbaqA-1; Wed, 18 Oct 2023 12:37:59 -0400
X-MC-Unique: 9-LOLCYNMjOfNu7cJnbaqA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9bd7c682b33so532820066b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647077; x=1698251877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fffmKAk2Mzul0/4WuRS85RgZzOjDwr5HJtxi7DJFtFQ=;
 b=dudeVwu6+sGrQFKOHqv+/Jd/l3kRI/mBLK+Uy4nvS6JGo6gaAxnK0ZMsJSBlp3JR8+
 pW4B3lA81aKXwpLF/0rWzRhg1uywF7Bmy2cDCi+duUEZpReI+zY3Sj3N7nmEMpw3+NxJ
 pCcuWr/JhTbDjf09aw/ZkVbLyk89/ueg6zVvXszIFetR3lM6mRx7Ssauz5YJ3MeBfSKH
 jvIKaJXxcFKA49YVBO99y2fj77LZR7AXwlNvCOMevkvBQp1S/FRfSP+1x6jzrdopZ7Lq
 yNfAYvm9lZSRGampGkxKEPKEv5XURoKaUzpo3Cqjdm6SdHApZDPF9VlCc4NfwP9FvCt4
 Mb3g==
X-Gm-Message-State: AOJu0YxvA6NsTJ0ykATQ6j0zOI8PajtkJ2rjFDGtXcwu7XShLl86ugOm
 GzaxlgJLvleWa/Z8yGc/iY/tVoateSZQpcz49zzyxK5F6dp95Fall2oNrEeLmJrhDRmpdD2ac6P
 m9p6D2LfntvGjLG2pdDMdSSPa5Eu1N6RgewcbbEcrgHqIW+SToHeunXKm1t0j1JILQa79xCWqYn
 8=
X-Received: by 2002:a17:907:928e:b0:9ae:65a5:b6fa with SMTP id
 bw14-20020a170907928e00b009ae65a5b6famr4380089ejc.32.1697647077595; 
 Wed, 18 Oct 2023 09:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC2WvQk1pDekSqnBOafH+hSSQQPIc/aAqR8jRgQMy++ddruIh2kier/MlwGBb9TPOg+fVodg==
X-Received: by 2002:a17:907:928e:b0:9ae:65a5:b6fa with SMTP id
 bw14-20020a170907928e00b009ae65a5b6famr4380071ejc.32.1697647077254; 
 Wed, 18 Oct 2023 09:37:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a170906184e00b009a9fbeb15f2sm2039249eje.62.2023.10.18.09.37.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/17] kvm: i386: require KVM_CAP_MCE
Date: Wed, 18 Oct 2023 18:37:25 +0200
Message-ID: <20231018163728.363879-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This was introduced in KVM in Linux 2.6.34, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c   |  5 -----
 target/i386/kvm/kvm.c | 14 ++++----------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 608da41465d..41d388acff2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3131,11 +3131,6 @@ bool kvm_has_sync_mmu(void)
     return kvm_state->sync_mmu;
 }
 
-int kvm_has_robust_singlestep(void)
-{
-    return kvm_state->robust_singlestep;
-}
-
 int kvm_max_nested_state_length(void)
 {
     return kvm_state->max_nested_state_len;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5db3fd0f4c4..6df8d56c87e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -97,6 +97,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(XSAVE),
     KVM_CAP_INFO(VCPU_EVENTS),
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
+    KVM_CAP_INFO(MCE),
     KVM_CAP_LAST_INFO
 };
 
@@ -582,14 +583,8 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
 static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
                                      int *max_banks)
 {
-    int r;
-
-    r = kvm_check_extension(s, KVM_CAP_MCE);
-    if (r > 0) {
-        *max_banks = r;
-        return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
-    }
-    return -ENOSYS;
+    *max_banks = kvm_check_extension(s, KVM_CAP_MCE);
+    return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
 }
 
 static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
@@ -2116,8 +2111,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
-           (CPUID_MCE | CPUID_MCA)
-        && kvm_check_extension(cs->kvm_state, KVM_CAP_MCE) > 0) {
+           (CPUID_MCE | CPUID_MCA)) {
         uint64_t mcg_cap, unsupported_caps;
         int banks;
         int ret;
-- 
2.41.0


