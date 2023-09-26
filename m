Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703A7AF16F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:00:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQ2-0002DV-BO; Tue, 26 Sep 2023 13:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPV-000254-HI
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPT-0006fM-Ue
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgHX7itePFqubTHf/KRDK1qdTvRw7J8MP/E7F1S7x/Q=;
 b=awciLQq/zFhhvHBkIJ28drax4ss25gF9YOiSv6EDMDXlWnNISSMl8sFb5M4/r6BuXSgrmk
 cNXrz1WgK87Hdg5v6XC+dRwD5/FaqWLrbYvvXDUb+T3aabzqgGXC8hb1fWpJVbSeuDZ8a+
 tkyHkiEyoBG9wcYGCWV7i3aCEo34J5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-0hrHCXrzOSO-5BfRE4Uebg-1; Tue, 26 Sep 2023 12:59:40 -0400
X-MC-Unique: 0hrHCXrzOSO-5BfRE4Uebg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4063dd6729bso12211585e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747578; x=1696352378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgHX7itePFqubTHf/KRDK1qdTvRw7J8MP/E7F1S7x/Q=;
 b=IfyvecuP/IHDfzJJuYfL6LXhupNqmPFNDO1+vIVsMHkKOg01F9rM4IVHiCNczLvFGN
 knhxfzRa4w3QTTzoubsU5tIyksqnGpF3QSrPXCyrW8A23OPootw7FqyGqd3M76frgZtk
 YpffWPlFnzfxwYhHZQFYddX+ZkFt+C8TfkKB4VcJqqtvLbob3spBO0csZMHzlff0pwZd
 Twpd72msu1RyZpJqLpdsjPK6QlnE89cXdbb67ReUpEZtJl+uQPrXMSF5ztFVg0s0gnhv
 6S5jblDvGh3ZMg4cbnxyjDOw3vvQDEfqQh5QAX7RuePxOUQmzzA80g4nQE9QQhN1ZqzT
 8JcQ==
X-Gm-Message-State: AOJu0YxWbkbAUPH0XGEKSbmNapD+nW+tTbnc45TWbdCEsw6xkgUvPeWF
 K6U+/wIpY3qFGP3q4p82ncfZI4T1v7H/gvPdr1rB8qaqAvUi6pTlGKMvEf0XikOPSvj8l5W1LqR
 OoECXMarCr7q1ZW6ntwJOGC3PWzR2YAU9pqMuKrAuIRbTWSwFQkKHdS7k891RLJO0iZSW400Auu
 k=
X-Received: by 2002:a05:600c:6025:b0:406:3f62:e596 with SMTP id
 az37-20020a05600c602500b004063f62e596mr1029972wmb.32.1695747578677; 
 Tue, 26 Sep 2023 09:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKp5HqsXapSmnI+5LTVuoVwoOwJJEYFw7p9cc9rFl2Du6kw0Ysb9+jniHK/665FWFtO/dKyA==
X-Received: by 2002:a05:600c:6025:b0:406:3f62:e596 with SMTP id
 az37-20020a05600c602500b004063f62e596mr1029959wmb.32.1695747578303; 
 Tue, 26 Sep 2023 09:59:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c234900b00405959bbf4fsm4766774wmq.19.2023.09.26.09.59.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/19] target/i386/kvm: eliminate shadowed local variables
Date: Tue, 26 Sep 2023 18:59:07 +0200
Message-ID: <20230926165915.738719-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
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

These are harmless are they die immediately after their use.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index af101fcdf6f..f6c7f7e2686 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2699,8 +2699,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     if (enable_cpu_pm) {
         int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
-        int ret;
-
 /* Work around for kernel header with a typo. TODO: fix header and drop. */
 #if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
 #define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
@@ -3610,7 +3608,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (kvm_enabled() && cpu->enable_pmu &&
             (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             uint64_t depth;
-            int i, ret;
+            int ret;
 
             /*
              * Only migrate Arch LBR states when the host Arch LBR depth
@@ -3643,8 +3641,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     }
 
     if (env->mcg_cap) {
-        int i;
-
         kvm_msr_entry_add(cpu, MSR_MCG_STATUS, env->mcg_status);
         kvm_msr_entry_add(cpu, MSR_MCG_CTL, env->mcg_ctl);
         if (has_msr_mcg_ext_ctl) {
@@ -4041,7 +4037,6 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (kvm_enabled() && cpu->enable_pmu &&
         (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
         uint64_t depth;
-        int i, ret;
 
         ret = kvm_get_one_msr(cpu, MSR_ARCH_LBR_DEPTH, &depth);
         if (ret == 1 && depth == ARCH_LBR_NR_ENTRIES) {
-- 
2.41.0


