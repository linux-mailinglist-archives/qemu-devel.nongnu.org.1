Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793177CE2F2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9YR-0000xh-Pm; Wed, 18 Oct 2023 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YL-0000wc-7C
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YJ-0007O8-MZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCBjqXciEfbUIqL0Z8mMxzxH/l5EMff3nfa5XLVTjNg=;
 b=eFZzBt4JwqnN/rtatNWQbwc0n2YrDp5zeNG48loEWqvbK1gzaz77OdyxocAEL2jNis6X6J
 TlpxuciMc9AJXzQYw/A6GBDewXeyZxb2JBOpJrSUToQKrwsZnOsMmoBcd5+CADL36dbv/C
 Skr8vBbnwYPdo8tQBmMtYcgINHhOJmM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-9OcnfjbSM7-gK9WOFd72Jw-1; Wed, 18 Oct 2023 12:37:40 -0400
X-MC-Unique: 9OcnfjbSM7-gK9WOFd72Jw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9bea60bd1adso476196166b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647059; x=1698251859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCBjqXciEfbUIqL0Z8mMxzxH/l5EMff3nfa5XLVTjNg=;
 b=GT/Mkj5h9F5ZWBYjYWpuR1OyOPBEOEgKKUkHYOnR3CtsK4wveNgijI+IaBxIN+VS15
 Y3CtgkPdySr2o+9EBwj/hXKUalaST/OXwyz/9B8IEsQHptbOy+30fserFPNfkodTwfmN
 dHP79x3WRQYfdF36G8uHEjc7Ck4Y1y+/XbgvZznitUtPh5JgyI4RkZrUcvHDdmB8lJt3
 qH7ihL05rUjeYx/8qazQRAvmULmviFkRRDn7TrnzpHeA54C92GxGHrPdiQmoXrp1X5ke
 TzNHx2Uw/83vNdjsyDlbOTmi7biVU3Qy/M6Gh+/rNo2GQB4VBbZjfQeUFMTZgRmpdXth
 qQqg==
X-Gm-Message-State: AOJu0YxL7u3kf38FkADnYF0FCVv0o/wYbyBPv+TCsxUf33SILIEBd7Vq
 IPRSwaE+VaTxeTLAdDY45RXLt0P6yBYJXjkH23/g16aXD8JJOhh7nAxE78rHzBVei0UoMiAl+/6
 gVN2WyJ1YdqGbA4rZmM1XU0m7N8ILSBsOSKx9ponk5LuG2dhW3QSkEgmlzeV7TWEwSF5mSdFp/G
 s=
X-Received: by 2002:a17:906:7311:b0:9a1:e0b1:e919 with SMTP id
 di17-20020a170906731100b009a1e0b1e919mr5029774ejc.4.1697647059089; 
 Wed, 18 Oct 2023 09:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh6SFbNshg7W+eZJ54cE+pODvDcYVgVD0sVVbRXrqAuZEJ9WBJpNJUC926xRncuTFGqsE0nA==
X-Received: by 2002:a17:906:7311:b0:9a1:e0b1:e919 with SMTP id
 di17-20020a170906731100b009a1e0b1e919mr5029761ejc.4.1697647058710; 
 Wed, 18 Oct 2023 09:37:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a1709066bc700b009b27d4153cfsm1990501ejs.176.2023.10.18.09.37.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/17] kvm: drop reference to KVM_CAP_PCI_2_3
Date: Wed, 18 Oct 2023 18:37:16 +0200
Message-ID: <20231018163728.363879-6-pbonzini@redhat.com>
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
index 575dee53b39..aa299396fba 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -215,7 +215,6 @@ int kvm_has_debugregs(void);
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


