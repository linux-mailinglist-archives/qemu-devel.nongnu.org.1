Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23675E443
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 21:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNeJH-0000WK-00; Sun, 23 Jul 2023 15:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nospam@kota.moe>) id 1qNeJE-0000VY-FV
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 15:00:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nospam@kota.moe>) id 1qNeJC-0006cG-45
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 15:00:00 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-267fc19280bso537818a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kota.moe; s=google; t=1690138794; x=1690743594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8Zsu5BEMsZfOFamOKMzDItIQGLRnp+yNVQzEHQIOMY=;
 b=IfULfF1Z2daSRnNfKJRcRIV2Uc+BJhLV9alBdNMemf2nfJD2y16eNNWKdNMBZnXcOr
 E6k3D3NMTpfQJ9B001msYakn491juFI8o7vGOHJWosmwGbGyFw/mF5mP9aPFekjQ1StN
 fXOvzV+voDw0PyyAQ9sy5fbFg6p65C6GP/leY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690138794; x=1690743594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8Zsu5BEMsZfOFamOKMzDItIQGLRnp+yNVQzEHQIOMY=;
 b=D0vkAZikUUJf3Z44Bhk4MR2cM/QvpzcF7zENiH+maWIic2zFVzoANFx98WQySq97kI
 mZ87URoEnlkoLiT5j3iRBUFt8MyD/UR4geUsOfRHzm+zQFge4SLW6zkDBs5ZjibsGvkg
 /b1uCscFvsMxonXp5T5zB4Mx1uPhcE2ol6CIjORWdKJ+7joCdzpaPIJBxpsKbkbW3MBC
 HvChGaCCvOYwe6VDIj3UmAUJI1KdBpnvNdCQcecnq9BYUcPKpS0V1rNI+Wd/h++Dn0ZK
 CejPt1fZCxq4K/lk83p/O2O+IlUUwEiytKeVp6sQF2tSf1OpU/vlT00sbdSjaX7eVOEL
 oMEA==
X-Gm-Message-State: ABy/qLaTomu/QUckTvWuabsjH7PFC83cuwDHz18iaU37vqyeJ9AlcaXX
 b/1ghLLVn6qu+O05TOi8AsnAz9HW/a7BNdSLhHA=
X-Google-Smtp-Source: APBJJlGnNkpBO6lxG9DrMwzbSGmvR+G7tI1PdrrXSgfFOxo3STa/NlE05VEnOVKPA3wCL/DAWKBUhA==
X-Received: by 2002:a17:90b:615:b0:268:abf:6431 with SMTP id
 gb21-20020a17090b061500b002680abf6431mr2813960pjb.24.1690138794548; 
 Sun, 23 Jul 2023 11:59:54 -0700 (PDT)
Received: from home.home.kota.moe ([2404:bf40:8181:20:4206:cfeb:365e:302e])
 by smtp.gmail.com with ESMTPSA id
 23-20020a17090a19d700b00262fc3d911esm7656882pjj.28.2023.07.23.11.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 11:59:54 -0700 (PDT)
From: =?UTF-8?q?=E5=B0=8F=E5=A4=AA?= <nospam@kota.moe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, babu.moger@amd.com,
 =?UTF-8?q?=E5=B0=8F=E5=A4=AA?= <nospam@kota.moe>
Subject: [PATCH] target/i386: Fix reporting of CPU dies when
 nr_cores=nr_threads=1
Date: Mon, 24 Jul 2023 04:59:09 +1000
Message-Id: <20230723185909.441455-1-nospam@kota.moe>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=nospam@kota.moe; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When QEMU is started with `-smp D,sockets=1,dies=D,cores=1,threads=1` (that
is, 1 socket with D dies but each die contains just a single thread), both
Linux and Windows guests incorrectly interprets the system as having D
sockets with 1 die each

Ultimately this is caused by various CPUID leaves not being die-aware in
their "threads per socket" calculations, so this patch fixes that

These changes are referenced to the AMD PPR for Family 19h Model 01h (Milan)
and Family 17h Model 01h (Naples) manuals:
 - CPUID_Fn00000001_EBX[23:16]: Number of threads in the processor
                                (Core::X86::Cpuid::SizeId[NC] + 1)
 - CPUID_Fn0000000B_EBX_x01[15:0]: Number of logical cores in processor
                                   socket (not present until Rome)
 - CPUID_Fn80000001_ECX[1]: Multi core product
                            (Core::X86::Cpuid::SizeId[NC] != 0)
 - CPUID_Fn80000008_ECX[7:0]: The number of threads in the package - 1
                              (Core::X86::Cpuid::SizeId[NC])

Note there are two remaining occurences that I didn't touch:
 - CPUID_Fn8000001E_ECX[10:8]: Always 0 (1 node per processor) for Milan.
                               But for Naples, it can also be 2 or 4 nodes
                               where each node is defined as one or two
                               CCXes (CCD?). But Milan also has multiple
                               CCXes, so clearly the definition of a node is
                               different from model to model, so I've left
                               it untouched. (QEMU seems to use the Naples
                               definition)
 - MSR_CORE_THREAD_COUNT: This MSR doesn't exist on Milan or Naples

Signed-off-by: 小太 <nospam@kota.moe>
---
 target/i386/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..6ff23fa590 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6049,8 +6049,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env->features[FEAT_1_EDX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
-            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
+        if (env->nr_dies * cs->nr_cores * cs->nr_threads > 1) {
+            *ebx |= (env->nr_dies * cs->nr_cores * cs->nr_threads) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
@@ -6230,7 +6230,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         case 1:
             *eax = apicid_pkg_offset(&topo_info);
-            *ebx = cs->nr_cores * cs->nr_threads;
+            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         default:
@@ -6496,7 +6496,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
          * discards multiple thread information if it is set.
          * So don't set it here for Intel to make Linux guests happy.
          */
-        if (cs->nr_cores * cs->nr_threads > 1) {
+        if (env->nr_dies * cs->nr_cores * cs->nr_threads > 1) {
             if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
                 env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
                 env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
@@ -6562,7 +6562,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              *eax |= (cpu_x86_virtual_addr_width(env) << 8);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
+        if (env->nr_dies * cs->nr_cores * cs->nr_threads > 1) {
             /*
              * Bits 15:12 is "The number of bits in the initial
              * Core::X86::Apic::ApicId[ApicId] value that indicate
@@ -6570,7 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
             *ecx = (apicid_pkg_offset(&topo_info) << 12) |
-                   ((cs->nr_cores * cs->nr_threads) - 1);
+                   ((env->nr_dies * cs->nr_cores * cs->nr_threads) - 1);
         } else {
             *ecx = 0;
         }
-- 
2.39.2


