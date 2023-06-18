Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0F734915
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 00:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0lw-0002mQ-HV; Sun, 18 Jun 2023 18:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0lu-0002mI-ET
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0ls-0004WY-I0
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687126879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVJPd5EiR4cU0nWZ/oi6is30khRgS/W/gWxn+4Hdo/U=;
 b=UJAJP5dftpSoj5Vp4qDjqIkz9thSGwPo2nArK/00aKEQ3Udrq0WkYmdcsWR5n00J04lgBc
 8pKR06zv6Z3KcpbYF3G8ejn3XYvLJvPmqvyo1haEoQivHy1o82DHNIFv83jxj7I6HzoxaE
 v8BKNL1ENX/R0jrhwKcEgo5wSBSibeU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-1M-sLUSAMK6E8r68_3r3yw-1; Sun, 18 Jun 2023 18:21:17 -0400
X-MC-Unique: 1M-sLUSAMK6E8r68_3r3yw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b45bf52675so15320021fa.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 15:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687126876; x=1689718876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVJPd5EiR4cU0nWZ/oi6is30khRgS/W/gWxn+4Hdo/U=;
 b=Xe+wNsKRgSA1aJ1OJ5nLp5ci4J/GZtoS2gn/UkL6tVAEWuB4EMUyr0nALzI6An+2uo
 q4LEd0OxgwwbtU9kJCXQQfTXppS475NEi98ZvHH1ARWGFrqlmRFr/lvUJ/hdv+tV5eHt
 kd/VWj/bzwHyAKS48TuJ19UPLehVwxdfRpDWCsrpX+Ny5/5RcODTA1ZHmEevu1f7eelT
 KQkAbd3YS5b1rdacj+/6al6SACfGIbZk2JR+8QJgbpjbF8hZ5uuZCGL65TRovCgTTMU8
 5p2VECKtO0wdk+HCUg8jOCVyFsKyjoIuknw9pmX2hOBHjO0rlM9ublnVl4mpBLwmi6ga
 DeWg==
X-Gm-Message-State: AC+VfDzTVnEbWRYvM9k//NRXXAMrIGFAJYwb5Ji8LC9GVq4sKY5TJtNh
 LyaWScjp6ktEdi863jP/mNHumqD3om4T/pGP8iBGmBXOBK+hlecONZiCN4oXXl7WZxVjy9hLGYk
 tVw3J5b/tHZasA/7rKuy0AXMSB4hNF7iXJPDXVbLkZgGPEoVnrtl4oIPzGeY2jKw2zaXk0bGLIt
 CiIQ==
X-Received: by 2002:a2e:8315:0:b0:2b3:44bb:2180 with SMTP id
 a21-20020a2e8315000000b002b344bb2180mr4135139ljh.40.1687126875813; 
 Sun, 18 Jun 2023 15:21:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FvmsvltftojXC+Jej6gocWq+QF4SC2ZeXJUH176jHHPAFTR6s7D7kSqb6H4jnpgIgn9Lq/g==
X-Received: by 2002:a2e:8315:0:b0:2b3:44bb:2180 with SMTP id
 a21-20020a2e8315000000b002b344bb2180mr4135130ljh.40.1687126875299; 
 Sun, 18 Jun 2023 15:21:15 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a1709066c8800b0098877b10de7sm1344962ejr.193.2023.06.18.15.21.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 15:21:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/i386: ignore CPL0-specific features in user mode
 emulation
Date: Mon, 19 Jun 2023 00:21:09 +0200
Message-Id: <20230618222109.110843-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618222109.110843-1-pbonzini@redhat.com>
References: <20230618222109.110843-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Features such as PCID are only accessible through privileged operations,
and therefore have no impact on any user-mode operation.  Allow reporting
them to programs running under user mode emulation, so that "-cpu" can be
used with more named CPU models.

XSAVES would be similar, but it doesn't make sense to provide it until
XSAVEC is implemented.

With this change, all CPUs up to Broadwell-v4 can be specified on the
command line without producing warnings.  Skylake-Client requires XSAVEC
(as well as hiding XSAVES).

In addition to XSAVEC and XSAVES, EPYC also requires SHA-NI, MISALIGNSSE
and TOPOEXT.  MISALIGNSSE is not hard to implement, but I am not sure
it is worth using a precious hflags bit for it.  TOPOEXT is related to
CPUID 0x8000001E which is implemented, but I am not sure it makes much
sense to add it as long as apic_id is always zero in user-mode emulation.
Perhaps, instead of cpu->apic_id, user-mode emulation could use the host
CPU number from getcpu(2).

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1517
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1534
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 88 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f4ad6d58609..35b85c086b2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -623,41 +623,94 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
           /* missing:
           CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
+
+/*
+ * Kernel-only features that can be shown to usermode programs even if
+ * they aren't actually supported by TCG, because qemu-user only runs
+ * in CPL=3; remove them if they are ever implemented for system emulation.
+ */
+#if defined CONFIG_USER_ONLY
+#define CPUID_EXT_KERNEL_FEATURES (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER | \
+                                   CPUID_EXT_X2APIC)
+#else
+#define CPUID_EXT_KERNEL_FEATURES 0
+#endif
 #define TCG_EXT_FEATURES (CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | \
           CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 | \
           CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_POPCNT | \
           CPUID_EXT_XSAVE | /* CPUID_EXT_OSXSAVE is dynamic */   \
           CPUID_EXT_MOVBE | CPUID_EXT_AES | CPUID_EXT_HYPERVISOR | \
           CPUID_EXT_RDRAND | CPUID_EXT_AVX | CPUID_EXT_F16C | \
-          CPUID_EXT_FMA)
+          CPUID_EXT_FMA | CPUID_EXT_KERNEL_FEATURES)
           /* missing:
           CPUID_EXT_DTES64, CPUID_EXT_DSCPL, CPUID_EXT_VMX, CPUID_EXT_SMX,
           CPUID_EXT_EST, CPUID_EXT_TM2, CPUID_EXT_CID,
           CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_PCID, CPUID_EXT_DCA,
           CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER */
 
 #ifdef TARGET_X86_64
 #define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM
 #else
 #define TCG_EXT2_X86_64_FEATURES 0
 #endif
 
+/*
+ * CPUID_*_KERNEL_FEATURES denotes bits and features that are not usable
+ * in usermode or by 32-bit programs.  Those are added to supported
+ * TCG features unconditionally in user-mode emulation mode.  This may
+ * indeed seem strange or incorrect, but it works because code running
+ * under usermode emulation cannot access them.
+ *
+ * Even for long mode, qemu-i386 is not running "a userspace program on a
+ * 32-bit CPU"; it's running "a userspace program with a 32-bit code segment"
+ * and therefore using the 32-bit ABI; the CPU itself might be 64-bit
+ * but again the difference is only visible in kernel mode.
+ */
+#if defined CONFIG_USER_ONLY
+#define CPUID_EXT2_KERNEL_FEATURES (CPUID_EXT2_LM | CPUID_EXT2_FFXSR)
+#else
+#define CPUID_EXT2_KERNEL_FEATURES 0
+#endif
+
 #define TCG_EXT2_FEATURES ((TCG_FEATURES & CPUID_EXT2_AMD_ALIASES) | \
           CPUID_EXT2_NX | CPUID_EXT2_MMXEXT | CPUID_EXT2_RDTSCP | \
           CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
-          CPUID_EXT2_SYSCALL | TCG_EXT2_X86_64_FEATURES)
+          CPUID_EXT2_SYSCALL | TCG_EXT2_X86_64_FEATURES | \
+          CPUID_EXT2_KERNEL_FEATURES)
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_EXT3_KERNEL_FEATURES CPUID_EXT3_OSVW
+#else
+#define CPUID_EXT3_KERNEL_FEATURES 0
+#endif
+
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
-          CPUID_EXT3_3DNOWPREFETCH)
+          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES)
+
 #define TCG_EXT4_FEATURES 0
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_SVM_KERNEL_FEATURES (CPUID_SVM_NRIPSAVE | CPUID_SVM_VNMI)
+#else
+#define CPUID_SVM_KERNEL_FEATURES 0
+#endif
 #define TCG_SVM_FEATURES (CPUID_SVM_NPT | CPUID_SVM_VGIF | \
-          CPUID_SVM_SVME_ADDR_CHK)
+          CPUID_SVM_SVME_ADDR_CHK | CPUID_SVM_KERNEL_FEATURES)
+
 #define TCG_KVM_FEATURES 0
+
+#if defined CONFIG_USER_ONLY
+#define CPUID_7_0_EBX_KERNEL_FEATURES CPUID_7_0_EBX_INVPCID
+#else
+#define CPUID_7_0_EBX_KERNEL_FEATURES 0
+#endif
 #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | \
           CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
           CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
-          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED)
+          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED | \
+          CPUID_7_0_EBX_KERNEL_FEATURES)
           /* missing:
           CPUID_7_0_EBX_HLE
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
@@ -672,7 +725,14 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \
           TCG_7_0_ECX_RDPID)
 
-#define TCG_7_0_EDX_FEATURES CPUID_7_0_EDX_FSRM
+#if defined CONFIG_USER_ONLY
+#define CPUID_7_0_EDX_KERNEL_FEATURES (CPUID_7_0_EDX_SPEC_CTRL | \
+          CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD)
+#else
+#define CPUID_7_0_EDX_KERNEL_FEATURES 0
+#endif
+#define TCG_7_0_EDX_FEATURES (CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_KERNEL_FEATURES)
+
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC)
 #define TCG_7_1_EDX_FEATURES 0
@@ -686,8 +746,17 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 
+#if defined CONFIG_USER_ONLY
+#define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
+          CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP | \
+          CPUID_8000_0008_EBX_STIBP_ALWAYS_ON | CPUID_8000_0008_EBX_AMD_SSBD | \
+          CPUID_8000_0008_EBX_AMD_PSFD)
+#else
+#define CPUID_8000_0008_EBX_KERNEL_FEATURES 0
+#endif
+
 #define TCG_8000_0008_EBX  (CPUID_8000_0008_EBX_XSAVEERPTR | \
-          CPUID_8000_0008_EBX_WBNOINVD)
+          CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_KERNEL_FEATURES)
 
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
@@ -5469,7 +5538,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
         return ~0;
     }
 #ifndef TARGET_X86_64
-    if (w == FEAT_8000_0001_EDX) {
+    if (w == FEAT_8000_0001_EDX
+        && (!tcg_enabled() || !CPUID_EXT2_KERNEL_FEATURES)) {
         r &= ~CPUID_EXT2_LM;
     }
 #endif
-- 
2.40.1


