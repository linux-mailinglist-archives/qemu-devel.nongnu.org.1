Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AF7ADABF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsn-0000dn-8i; Mon, 25 Sep 2023 10:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsT-0000Zg-2e
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsQ-00083E-SI
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oy5H3b1MurRsW60QjHghxj1gz7bzfKw4w2cRcSLfxPY=;
 b=ACu3Tvupg8YBdL9cdMfGpE1aP6/q72suTRBMxcZMl+T7I1od2fbT2G8T3W1YQeNXdPqoUP
 zXIYR3r7VDQrl2qLmDUe9xeFEhqxVWv6nhkhikSL43ne4L6Ivz1MfLli/b5PlLfsfTUks8
 LzFcL8sHHI9J5Ov0voOSHrjTfbalYsA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-x4ljOuNkOcmRMua-WtbLHw-1; Mon, 25 Sep 2023 10:47:56 -0400
X-MC-Unique: x4ljOuNkOcmRMua-WtbLHw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405535740d2so38708575e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653274; x=1696258074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oy5H3b1MurRsW60QjHghxj1gz7bzfKw4w2cRcSLfxPY=;
 b=YJkZzuYv8Wm7WJhl5SFxUkxjC8TXIulgA5sN+AXfGT6fqbgp1mP4Huh3segsAumFus
 1zexaZqBz6QqwG1GJaxNrCcECkO9UJeHwj7vg59nPwFGcAY8tPXIsZdq8pnIj460tDEM
 En7vY9coTje/ndeGlARmdAW+78V2G+bfjthykoR2mvm4uPPi5zlvhLWOrWuueipjiI7E
 LaAo+O1VvnE1MJKv8+vCrj96kt+h7HbdfLFnAygA5l8S7vCSz3FwvXmaesWUPiE9bLAm
 PN9bn30Y48QqJtsGNkocQw5gtSJRc2+rJWBwOx32LN41JuGsKonbHuFSQvQLu4Ms3aKV
 0zGw==
X-Gm-Message-State: AOJu0YwfzX2yHDlm7c5R8Nakqo+Ma/tUxKx/bAQ8Y/oJM7DkFua1hjQd
 qRoXEU353M1F8VsuMlkpRl4IdLQmlui7Z9n4EIEvnb28qYUDuCtWE86PViBVSBOLaW5bk9Zhqe9
 BfyeJNqUHus9xFNTkF48ep5f1UUjVehQuL6aOX7fxa1zuvInSVir//Gy3N7qjysXqHpdeG2NAi/
 w=
X-Received: by 2002:a1c:4c15:0:b0:405:359a:c965 with SMTP id
 z21-20020a1c4c15000000b00405359ac965mr5719523wmf.4.1695653274437; 
 Mon, 25 Sep 2023 07:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHDQFHktzT72dVHwEC5nPyCA7fpd8289LF7wkiG6fFzAIWgcJMWbi3SfehZaJa9MNN+dW2gw==
X-Received: by 2002:a1c:4c15:0:b0:405:359a:c965 with SMTP id
 z21-20020a1c4c15000000b00405359ac965mr5719508wmf.4.1695653274022; 
 Mon, 25 Sep 2023 07:47:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a5d4989000000b0031c5ce91ad6sm12018683wrq.97.2023.09.25.07.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:47:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] target/i386/kvm: eliminate shadowed local variables
Date: Mon, 25 Sep 2023 16:47:42 +0200
Message-ID: <20230925144744.527958-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
index e5cd7cc8061..db10ed13e8c 100644
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


