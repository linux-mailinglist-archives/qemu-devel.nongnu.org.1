Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A717D7892
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:30:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnI0-0001ca-NF; Wed, 25 Oct 2023 19:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHx-0001aC-Ma
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHw-0005Bu-4l
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpXBNDQ2zJ3iFM2sYgodeN86HxnKFSz31ivc1oz0iiM=;
 b=OpVLIU+FspK/oH96lFlPGc9QM0sRMtxV0nRgQ/u+RTQF8XwC58r4HY015aviM5tufe0llu
 5el6I+B8wdUIn8taFSq8HfuHWyppLfBjDOynIzHfmcddM6amSO39mHySZPPo20huTlWBUZ
 xeOPNmSH7kdbooldZ98x08xb/CL6brc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-31dBzu3hMx6Jx-gP8qM6EA-1; Wed, 25 Oct 2023 19:27:46 -0400
X-MC-Unique: 31dBzu3hMx6Jx-gP8qM6EA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63d0c38e986so3743256d6.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276465; x=1698881265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpXBNDQ2zJ3iFM2sYgodeN86HxnKFSz31ivc1oz0iiM=;
 b=G0C70qXuQHr+kCT0YWmocqtPCl2n2HHQgv5THLI/aCmlugOJiMZGLhy7UiEjH8yJtO
 HWTBieqAFfWYLRbREOqPt5Ya1s1W7TuU4ff3XJHWFn/KqBSeGergwbYFCmH/J9vQCa4a
 RDXBFSsDskiPMCZ+qqBzrIqw6wiQ/KrJfhFbPGiBkHvd/IKlTu2vtoYa9FdI+RrFMcqx
 YFPM5U/sZja86vfKWIw+IQutNYgYlinBBJkys9CsCcW/6xczEqoycvzSAh4Gizdw6uQK
 l+uZRC509fmaN/tN1bNWZyubcN0pk9E8L+0qjNXFZUTN/RhHDhxpcQ+UG7dYXhq9djun
 o4wg==
X-Gm-Message-State: AOJu0Yzc1vExzlOqGb/S1uTvMSCsX1Ry70nFGiDIVsxRBwa1IaChubY7
 aAK1U+tnr/NZeycxVYmT4lLdsWhLm1wIDt/bMtmPYRhhtFzJHBP0un5qPenaVKhjCGCOovAUTo4
 Rkscbxxg6EnayfspaAvesb6gWZAHpvaLEDDO1y0ffDMAE1wuyjmT64jrNBu8DsUBYPnLxs5mkCh
 U=
X-Received: by 2002:ad4:5bc8:0:b0:66d:1ffe:bcd4 with SMTP id
 t8-20020ad45bc8000000b0066d1ffebcd4mr15857873qvt.44.1698276465319; 
 Wed, 25 Oct 2023 16:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyLkXsqqUbwZRs+UTQt3unpIwVOEq5K5Yt0pJIMWrtNQBp706lxIUbc+/AnDezG0yIuyhVmQ==
X-Received: by 2002:ad4:5bc8:0:b0:66d:1ffe:bcd4 with SMTP id
 t8-20020ad45bc8000000b0066d1ffebcd4mr15857856qvt.44.1698276464936; 
 Wed, 25 Oct 2023 16:27:44 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 dh5-20020ad458c5000000b0066cf6f202cdsm4750410qvb.122.2023.10.25.16.27.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/24] kvm: drop reference to KVM_CAP_PCI_2_3
Date: Thu, 26 Oct 2023 01:27:06 +0200
Message-ID: <20231025232718.89428-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

This is a remnant of pre-VFIO device assignment; it is not defined
anymore by Linux and not used by QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 7 -------
 include/sysemu/kvm.h     | 1 -
 include/sysemu/kvm_int.h | 1 -
 3 files changed, 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index be50d47f7b4..50717a0d634 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2576,8 +2576,6 @@ static int kvm_init(MachineState *ms)
 
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
-    s->intx_set_mask = kvm_check_extension(s, KVM_CAP_PCI_2_3);
-
     s->irq_set_ioctl = KVM_IRQ_LINE;
     if (kvm_check_extension(s, KVM_CAP_IRQ_INJECT_STATUS)) {
         s->irq_set_ioctl = KVM_IRQ_LINE_STATUS;
@@ -3237,11 +3235,6 @@ int kvm_has_gsi_routing(void)
 #endif
 }
 
-int kvm_has_intx_set_mask(void)
-{
-    return kvm_state->intx_set_mask;
-}
-
 bool kvm_arm_supports_user_irq(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 16d58d2598a..bcc9bd96a92 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -216,7 +216,6 @@ int kvm_has_debugregs(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
-int kvm_has_intx_set_mask(void);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a7dacd12d6c..817238b9582 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -85,7 +85,6 @@ struct KVMState
 #endif
     int max_nested_state_len;
     int many_ioeventfds;
-    int intx_set_mask;
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-- 
2.41.0


