Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796DF7CE302
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9ZA-0001m0-LX; Wed, 18 Oct 2023 12:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Yj-0001OY-Sy
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Yi-0007QG-Eg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=duiHUT8st5eyEW1wOxW61bUKxv0U4vv/DGWXwswcz+Y=;
 b=ZuqeB/lAD43N8nqeIYjjW/AGloHTu3+KQi5IB5LHnK9PUzHXWG6eHTcEODYLb+6o1EkvEy
 8ePwmzT4pTVoVjUCWcCloaxwbt4c5Aa3IQwP7wDp3NZMCRtvVPtAIyU0zrZ4PpfScBaSAB
 fFh9FJgLFmadOBP83RoGNu2Eyhyr80k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-hXoO9FBZPnG6eAAH5uppjw-1; Wed, 18 Oct 2023 12:37:54 -0400
X-MC-Unique: hXoO9FBZPnG6eAAH5uppjw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so471041166b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647073; x=1698251873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duiHUT8st5eyEW1wOxW61bUKxv0U4vv/DGWXwswcz+Y=;
 b=ObVsuHWI6LzVljuWmOT37XEsiqA+gODjrhUF4B9fLRmHY0Xu1JNXzqfewCetggyn0L
 aXJKBS3oOlAKG+KyAu36VFuqIqLSERGM9CNBFuCe1zRo4PgE712D/HZGYjnlxL7hjJ7K
 HGxfcnhtJIfz6jZXyAuQNiuILsYTTWsC/8/Zn2I4D2migsAH/iT1HEVItQqjtEJc3uKl
 txh9LzsBWPdqVcdRDghiZps4V7sABJogv9w2U/KPH/nx5bPJNjSAyYYT1IW7Be2Mr2GR
 4eb1L4swdpCKheb2FEdhz/fLq3Yk3WokzXzbT6TOrn47PsHhJQb2OrDNyheK5fOSi6s+
 A1SQ==
X-Gm-Message-State: AOJu0YwOR2aArq5v53C02DNNrKDhAoG3yUQFpT+gHS+bFECd5YGTXfcB
 7htHU2LJMyc/NDizo+ITG3yVBQnipoBnsD+WezqmALSr4gzS4BNhGMRLfJ8L85fD9EhiqK7aDkC
 NtDQ+WYtdT1cgKDmn4NHWQz0Aq44Yz1d50lcciY/T9BFjnbIbMWu/o1MhLWtoF5LDTJ2o6d+wnj
 M=
X-Received: by 2002:a17:906:ee86:b0:9be:cdca:dae9 with SMTP id
 wt6-20020a170906ee8600b009becdcadae9mr4589168ejb.36.1697647072919; 
 Wed, 18 Oct 2023 09:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV1tOGmBtg6EPRNfybbGe8bXWdinz3Zno8piiSpInItRhmqoeLYg47+FGFneRKOK6IZTXw8g==
X-Received: by 2002:a17:906:ee86:b0:9be:cdca:dae9 with SMTP id
 wt6-20020a170906ee8600b009becdcadae9mr4589150ejb.36.1697647072474; 
 Wed, 18 Oct 2023 09:37:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a1709063a0900b009c758b6cdefsm261859eje.128.2023.10.18.09.37.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/17] kvm: i386: require KVM_CAP_DEBUGREGS
Date: Wed, 18 Oct 2023 18:37:22 +0200
Message-ID: <20231018163728.363879-12-pbonzini@redhat.com>
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
index c06982fd64c..16fddeef663 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -192,7 +192,6 @@ unsigned int kvm_get_free_memslots(void);
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
index 91dd43eaa9b..86af39c437a 100644
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


