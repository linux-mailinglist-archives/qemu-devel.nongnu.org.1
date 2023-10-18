Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B77CE306
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Yx-0001P5-NJ; Wed, 18 Oct 2023 12:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Yb-0001CY-MF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Ya-0007Po-16
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wZuj85GLu2soE71yr6wZpncdjmSTCMFr6YGQ05DMqA=;
 b=YXrwXrjwsVWzp07KdI/yZLCx5JhLYtlCCY9GdMumoU98AQDWzFP/9daBRClDMuYInbNfhb
 hQw0Czw/jKe6aQDvUNGLTPRVltNokXD/0F1u7bkjsxRqO9ohWnnIUYSsASA+NZNcPPlxAY
 6nnyY+RRALr5kPPiCZ6EU/X/ghnoZh0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-tKU5JgGpODmxoyDZQuOifA-1; Wed, 18 Oct 2023 12:38:01 -0400
X-MC-Unique: tKU5JgGpODmxoyDZQuOifA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9be601277c2so338281366b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647079; x=1698251879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wZuj85GLu2soE71yr6wZpncdjmSTCMFr6YGQ05DMqA=;
 b=B1qdlxXVX3s8RPPLPQIW3XdihZS/hL9xokogcyt1C8e1ZoYLvR+/oZXrtWbJn18tsz
 GReO3xyWWZjpGdrOizBWj/UxiMg+rxr84EuaMXPtJ4rQbdtxeoikztkMnFn5e9fLzpmU
 IiRaWtxvqUKINhCXu3RG75BOaa0wpvO4VX7hdyqezmoPuF4mF/XBt/7Az04jVH0d9FcE
 VHN5i3SlHKzcGauS0ozECfrxpVnmd8jTRHT7lG0825xCu3cfZ6fuFKKSo6p0dgRFARz+
 vyqnlchPVg7oatLcVHp2HLHw5csNZG83wi5xcJPjY0uUk1DTnYn9i342jLpXnrGTW75Q
 FBiw==
X-Gm-Message-State: AOJu0YwoAl+N6z+kFsv6kyXpzJ8sEwpIQlxbzUG2Ss7v7fjhsJTwSJNL
 eDFSqLFBFLr0SL4eHdvj5p3LBu4Hf1AjmlGx6taLxCuoBPxfFo21yMhXkaqH/wInlYV7WbxgBRz
 Gdmd9jTdcILhMb7M/ovEXL5DuMFhwHLf1e9vljGiIh5O+smrBJEaD3cdtpP31OKIPtey5lbvkAH
 k=
X-Received: by 2002:a17:907:1c0c:b0:9be:b43c:38dc with SMTP id
 nc12-20020a1709071c0c00b009beb43c38dcmr5158595ejc.12.1697647079219; 
 Wed, 18 Oct 2023 09:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElodZlgk6BSTcR/AuYZsnJSb8PuzbXHMHQByllDBRwe46NfZpwB1Kb2LxBL7eVj6hZJDviYw==
X-Received: by 2002:a17:907:1c0c:b0:9be:b43c:38dc with SMTP id
 nc12-20020a1709071c0c00b009beb43c38dcmr5158581ejc.12.1697647078867; 
 Wed, 18 Oct 2023 09:37:58 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a170906260900b009ae3d711fd9sm1987388ejc.69.2023.10.18.09.37.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/17] kvm: i386: require KVM_CAP_ADJUST_CLOCK
Date: Wed, 18 Oct 2023 18:37:26 +0200
Message-ID: <20231018163728.363879-16-pbonzini@redhat.com>
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

This was introduced in KVM in Linux 2.6.33, we can require it
unconditionally.  KVM_CLOCK_TSC_STABLE was only added in Linux 4.9,
for now do not require it (though it would allow the removal of some
pretty yucky code).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c        | 4 ----
 target/i386/kvm/kvm.c      | 6 +-----
 target/i386/kvm/kvm_i386.h | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index f25977d3f68..e756b0aa43f 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -333,10 +333,6 @@ void kvmclock_create(bool create_always)
     X86CPU *cpu = X86_CPU(first_cpu);
 
     assert(kvm_enabled());
-    if (!kvm_has_adjust_clock()) {
-        return;
-    }
-
     if (create_always ||
         cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
                                        (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6df8d56c87e..df131fcc8b1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -98,6 +98,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(VCPU_EVENTS),
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_INFO(MCE),
+    KVM_CAP_INFO(ADJUST_CLOCK),
     KVM_CAP_LAST_INFO
 };
 
@@ -177,11 +178,6 @@ bool kvm_has_adjust_clock_stable(void)
     return (ret & KVM_CLOCK_TSC_STABLE);
 }
 
-bool kvm_has_adjust_clock(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
-}
-
 bool kvm_has_exception_payload(void)
 {
     return has_exception_payload;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 55d4e68c342..7e60ea4f23f 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -50,7 +50,6 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
 
 #ifdef CONFIG_KVM
 
-bool kvm_has_adjust_clock(void);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
-- 
2.41.0


