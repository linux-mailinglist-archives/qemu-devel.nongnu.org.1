Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA37CE30A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Yd-0001BQ-Vq; Wed, 18 Oct 2023 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YR-0000ya-Df
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YP-0007Oo-Hf
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3CNP1QuoS1paUivlb9aVuEK/Faji/cYsHMDMufGa0o=;
 b=ZK0silyprKEObEtlEH4dOBW681emjY3MVYjDfSqKF4nZi706323pANkPgEafBgE6Ql23zi
 I7+E24IBvjCgubKYnS9fU2po0EicnTJF4Qnr8x4rdcibDmYY4MTKNwyc4GOvKtvUAlJvEz
 Qh5tTSZ0bmARXCcD4kWpmIwbSkDngCI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-r6QbReZkMjGnFrRwGyKWgQ-1; Wed, 18 Oct 2023 12:37:51 -0400
X-MC-Unique: r6QbReZkMjGnFrRwGyKWgQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9c6a4a60033so114827666b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647070; x=1698251870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3CNP1QuoS1paUivlb9aVuEK/Faji/cYsHMDMufGa0o=;
 b=CvdoIGBsmQjL0MbuC3FgBrNLdPokrLqIZsnO46rab35GlSNKJj9aWXNPlRPBRp+fgu
 Hgya50EFpcjtPHB+1SVXuvir26DGF2VPK+0gp7J5uHE6JLt0nWs6s1/gMs6KPXfJvQiO
 fYeO+FYoAzKDME4ucnT5lXXwpLsg+ZL9LDz2N8cj+6gemgGXrVQk2HRwbyA1/CZ5MdOL
 zScEomBpdm+dgv+bJacdrWySm0Fcb9hiBLX1DyoYj4z8CBCGHLq2nSZrTMNDQmontrgm
 +OC+NwW3kgKIdQbqV9MrygoBRkXIkzkZtpnTQkvi393s/7VZHs0U6nAAYiZ7vPPk8rqT
 ueRQ==
X-Gm-Message-State: AOJu0YyVkKDWp31ueOvBp+0lkQjYn6Zf4I9dS7BJ2nAyl0C5jDjnHyf1
 ajAE4gNHysY9AIx6cA/JtadSLy+4fRltu+5bHYHD1GaBzcXvjvielOYyn/QGEw8zeve01QDs0SI
 ++Ajf7xAjWF0QDLahgs4ZCUiDLizPOQdYwwRrtCKo1KwhJbY5pU0bfFbdxaJBYWkPwBh+FfPHoV
 o=
X-Received: by 2002:a17:907:368b:b0:9c1:edd8:43c2 with SMTP id
 bi11-20020a170907368b00b009c1edd843c2mr4846629ejc.42.1697647069761; 
 Wed, 18 Oct 2023 09:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9uh9H7EB9Nv6fksFBmGVg1ro56qtklZyjY1qH1MnxQ7MZ7a14HnK9SqC6+lLKCkkxnv7I/Q==
X-Received: by 2002:a17:907:368b:b0:9c1:edd8:43c2 with SMTP id
 bi11-20020a170907368b00b009c1edd843c2mr4846610ejc.42.1697647069334; 
 Wed, 18 Oct 2023 09:37:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a17090651cf00b009ae482d70besm1990438ejk.134.2023.10.18.09.37.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/17] kvm: arm: require KVM_CAP_SET_VCPU_EVENTS
Date: Wed, 18 Oct 2023 18:37:20 +0200
Message-ID: <20231018163728.363879-10-pbonzini@redhat.com>
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

KVM_CAP_SET_VCPU_EVENTS was added in Linux 4.19, released in 2018.
It was backported to RHEL8's 4.18 kernel and is in other supported distros
as well.

While it is nice that QEMU can run even on older kernels, for example
on boards that can only run old vendor kernels, I don't think this should
extend to ancient versions of KVM/ARM which, at the time, was still
moving pretty fast.  As a reference, 4.19 still had 32-bit
KVM support.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/kvm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b66b936a958..a50e975181f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -34,6 +34,7 @@
 #include "qemu/log.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
+    KVM_CAP_INFO(VCPU_EVENTS),
     KVM_CAP_LAST_INFO
 };
 
@@ -756,10 +757,6 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
     struct kvm_vcpu_events events;
     int ret;
 
-    if (!kvm_has_vcpu_events()) {
-        return 0;
-    }
-
     memset(&events, 0, sizeof(events));
     events.exception.serror_pending = env->serror.pending;
 
@@ -785,10 +782,6 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
     struct kvm_vcpu_events events;
     int ret;
 
-    if (!kvm_has_vcpu_events()) {
-        return 0;
-    }
-
     memset(&events, 0, sizeof(events));
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_VCPU_EVENTS, &events);
     if (ret) {
@@ -927,7 +920,6 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
          * synchronization can be exceptionally skipped.
          */
         events.exception.ext_dabt_pending = 1;
-        /* KVM_CAP_ARM_INJECT_EXT_DABT implies KVM_CAP_VCPU_EVENTS */
         if (!kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events)) {
             env->ext_dabt_raised = 1;
             return 0;
-- 
2.41.0


