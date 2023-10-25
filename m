Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 347AA7D7889
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnI9-0001ib-OW; Wed, 25 Oct 2023 19:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI7-0001hd-Ji
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI5-0005IS-RL
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMmrenvtAKAEB/AkfeeWMbQ57rrPYZxDXMhbNc53l7U=;
 b=VJjbuTbdiEzw7COxl6WXBzk9j5Rf9NuRvgEJxmIpVjUxj09hx/2JC+0P5/Xi6kaDNUcBep
 AH2IjeC2G2bHwmb42zGmC+V+04Vd1Hs3L6x9mZyL7TUudH5EUvS6EUhMEAzvX+LvK9OUe2
 u0/igBV6FSJXEfiLuLza+NQ1xI/22Ik=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-W99JxP81MySasxUq4bo56A-1; Wed, 25 Oct 2023 19:27:55 -0400
X-MC-Unique: W99JxP81MySasxUq4bo56A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77892f2ee51so52671285a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276474; x=1698881274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMmrenvtAKAEB/AkfeeWMbQ57rrPYZxDXMhbNc53l7U=;
 b=AUyyDRSiLZ1VPk6CqWiBeVY1dPm6w9m7QWeFSmkg8RIJ2U59aFgtooznfwJaIz1QCv
 /+rb0mvDw1PvbqCCRpDXeN9x0mEyBf0oRuktnejZSK123/DMcmi7f6X0PW6IqKWnQkx/
 5YCwBZaRnQIdMvGp72EhfqxCLuDCG/AxViTIZeMdJNOyC7GgQL3HR7VUM6CQ88rVDRQF
 bC3jtCoV6KS5WZv7Qg5fWslGlMEhunTpYZBIvafwszPk2zmFHOxm+I5sCOOI2TpaP4lC
 yfHV871oamqZHFzMfa8PtJ2ySqxFy/rqF+wL1Uej09ArJJwWwhwcrfsmphRln3l85cgb
 n68w==
X-Gm-Message-State: AOJu0YyvZzdeNVK4OZ2VjqgUUXbQlcXzZQe8FmghEzwnVyYmlFon77P6
 x7APH0+GFL6LYypDbGp9yTFh+Bdv2GpqP+6z+hCfjg9RhAvIj7bcJaQf5mZfOfx/8MbkQwv2goa
 S/O3+7DBV0K1ArpvXTYEMQxWqHRQhbl3IiSHS8k6aPdNWaPn7SmV6Zkh6vG3uoUSQm6Gy01WpFQ
 8=
X-Received: by 2002:a05:622a:386:b0:41e:23fc:a040 with SMTP id
 j6-20020a05622a038600b0041e23fca040mr9908377qtx.56.1698276474253; 
 Wed, 25 Oct 2023 16:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQrLCemwJz8NGSSVcvGQUDs1MU/tbZAvn2NuIqbB4ZeT9fPDTn2cO8xaWplvn969IKxgw+rQ==
X-Received: by 2002:a05:622a:386:b0:41e:23fc:a040 with SMTP id
 j6-20020a05622a038600b0041e23fca040mr9908362qtx.56.1698276473899; 
 Wed, 25 Oct 2023 16:27:53 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a05620a143600b00774350813ccsm4557318qkj.118.2023.10.25.16.27.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/24] kvm: i386: require KVM_CAP_DEBUGREGS
Date: Thu, 26 Oct 2023 01:27:11 +0200
Message-ID: <20231025232718.89428-19-pbonzini@redhat.com>
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

This was introduced in KVM in Linux 2.6.35, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 9 ---------
 include/sysemu/kvm.h     | 1 -
 include/sysemu/kvm_int.h | 1 -
 target/i386/kvm/kvm.c    | 9 +--------
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b59a48da924..aeda902b3e9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2528,10 +2528,6 @@ static int kvm_init(MachineState *ms)
     s->robust_singlestep =
         kvm_check_extension(s, KVM_CAP_X86_ROBUST_SINGLESTEP);
 
-#ifdef KVM_CAP_DEBUGREGS
-    s->debugregs = kvm_check_extension(s, KVM_CAP_DEBUGREGS);
-#endif
-
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
     s->irq_set_ioctl = KVM_IRQ_LINE;
@@ -3152,11 +3148,6 @@ int kvm_has_robust_singlestep(void)
     return kvm_state->robust_singlestep;
 }
 
-int kvm_has_debugregs(void)
-{
-    return kvm_state->debugregs;
-}
-
 int kvm_max_nested_state_length(void)
 {
     return kvm_state->max_nested_state_len;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 31c03cc1932..02c031d1f29 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -193,7 +193,6 @@ unsigned int kvm_get_free_memslots(void);
 bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
-int kvm_has_debugregs(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 840b905a2e9..151ecc84233 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -79,7 +79,6 @@ struct KVMState
     bool coalesced_flush_in_progress;
     int vcpu_events;
     int robust_singlestep;
-    int debugregs;
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 94b2516c29f..b8fb74d7f17 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -93,6 +93,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(MP_STATE),
     KVM_CAP_INFO(SIGNAL_MSI),
     KVM_CAP_INFO(IRQ_ROUTING),
+    KVM_CAP_INFO(DEBUGREGS),
     KVM_CAP_LAST_INFO
 };
 
@@ -4601,10 +4602,6 @@ static int kvm_put_debugregs(X86CPU *cpu)
     struct kvm_debugregs dbgregs;
     int i;
 
-    if (!kvm_has_debugregs()) {
-        return 0;
-    }
-
     memset(&dbgregs, 0, sizeof(dbgregs));
     for (i = 0; i < 4; i++) {
         dbgregs.db[i] = env->dr[i];
@@ -4622,10 +4619,6 @@ static int kvm_get_debugregs(X86CPU *cpu)
     struct kvm_debugregs dbgregs;
     int i, ret;
 
-    if (!kvm_has_debugregs()) {
-        return 0;
-    }
-
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_DEBUGREGS, &dbgregs);
     if (ret < 0) {
         return ret;
-- 
2.41.0


