Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C49797423E0
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:20:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEokP-0000Fc-Hp; Thu, 29 Jun 2023 06:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokN-0000F2-HL
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokL-0005nk-MQ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688033969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+5l3uQ4w1rclU3bnl8FcUEU2dexkvR8ceW6D8ETkRk=;
 b=JM62kroFeqa4lVJfj5rdMAuyaERtA9XUTCvGip5BQtBVn8UDYFpRW3J+2FfpkvAZIM2JCx
 bxDw8LhI7fA1rjmScDfSOYJ7sNKjWqZCxbk7WLxQe5mIf7Mi1D1gLBuo6TlTFCAjdk1XOt
 vIj9JR/Fq9YrrZ0nRiLVtzg5WEdywDU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-kDdWY_GmOBarK0ElIva4yg-1; Thu, 29 Jun 2023 06:19:27 -0400
X-MC-Unique: kDdWY_GmOBarK0ElIva4yg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso401268a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688033966; x=1690625966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+5l3uQ4w1rclU3bnl8FcUEU2dexkvR8ceW6D8ETkRk=;
 b=QgrBvGiA0d4yUdCajlgijzPwlORxz8/SiFk3CMyt6TKth0Zz1Xar1ZHIiMssFU+vfA
 jjYEhfzDRidQnXEYMQRcKVDC2jLgD37zVmAtXh2/0f0wKLDH5vDh4OGdjFB6EQRFUAB+
 1r++Mui80jmcvNpQ59ntnpqyclE+0oJooNG/dpP2k9BgSCVfyMsbFK707AOr9YISW0fl
 H4zhlfY6Tn9AOEBehESlo3vMeLwRc8wRx2qBhkqTK3WkgupY7uDXe2moJ4OP+L+HpNKb
 t7IKOsQMIVnsWvf1Kip2xRVY4dpumgye9d9HmXDofBSqzeKV+zoB8iyCe57Ma4VTfVMV
 fpog==
X-Gm-Message-State: AC+VfDwZKsmOH4fRqjTa8I7RQLOBpAhNM/CgnZOo2RP6WaBOYIQfofkb
 zctm1rRfjCkQEtfswHPUmbCsWO2sexZLkMuwtkw8at1uF0H7JuQ6ETmn60jDchXQ9wUMnjGP/+p
 Gmv3E50pIAsdUyxM02siqyuGy95wq4YfTWyqIGdgu9MVwlG82Sv5IVrZGlmjKNz9VNdjD/RaZhm
 4=
X-Received: by 2002:a17:907:968d:b0:992:9756:6a22 with SMTP id
 hd13-20020a170907968d00b0099297566a22mr3108905ejc.48.1688033966071; 
 Thu, 29 Jun 2023 03:19:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74sy10mhIcE/UAauAWObu6IzRwWQxVZ5AEaWCG/oQftBFTsUaWTVLyuOKlWSbeLZIk2C+hVg==
X-Received: by 2002:a17:907:968d:b0:992:9756:6a22 with SMTP id
 hd13-20020a170907968d00b0099297566a22mr3108885ejc.48.1688033965708; 
 Thu, 29 Jun 2023 03:19:25 -0700 (PDT)
Received: from [192.168.10.81] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 qp7-20020a170907206700b009890ab4efa9sm6613616ejb.32.2023.06.29.03.19.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 03:19:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] target/i386: ignore CPL0-specific features in user mode
 emulation
Date: Thu, 29 Jun 2023 12:19:17 +0200
Message-ID: <20230629101918.9800-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629101918.9800-1-pbonzini@redhat.com>
References: <20230629101918.9800-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

With this change, all CPUs up to Broadwell-v4 can be emulate.  Skylake-Client
requires XSAVEC, while EPYC also requires SHA-NI, MISALIGNSSE and TOPOEXT.
MISALIGNSSE is not hard to implement, but I am not sure it is worth using
a precious hflags bit for it.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1534
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 83 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 328779874f2..a3ddd1b6137 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -623,13 +623,25 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
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
+                                 CPUID_EXT_X2APIC)
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
@@ -642,22 +654,63 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
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
+#define CPUID_EXT2_KERNEL_FEATURES CPUID_EXT2_FFXSR
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
-- 
2.41.0


