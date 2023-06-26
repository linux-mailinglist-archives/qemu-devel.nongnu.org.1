Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBEE73D9D8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhfN-0005LO-Vi; Mon, 26 Jun 2023 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhfD-0005K8-Ce
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhfA-0005iV-2G
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687768407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQM/HjRYYfHIe9Qu1AIvoe05KkXfhrLJfBM58FeB2Uc=;
 b=OKuLw5LQdi7bASixebXTKFOrujmCBYTT3yJMRIEOzSxUZ3JUYrVlVdIRs4zc5e2N0HSKYo
 aYwxH2qBP8R7PhYfK85LPNLg0ADUn7OiPw95knt79cjQ9c8uIISwTAzWyZXN75ceDw11mI
 mVZ17Q5pDE1R6MDrYTL0xcHvU6ciYvM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-PHSMHR4kM5OkjiWGwlw75A-1; Mon, 26 Jun 2023 04:33:22 -0400
X-MC-Unique: PHSMHR4kM5OkjiWGwlw75A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313f0d98e3dso306466f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768401; x=1690360401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQM/HjRYYfHIe9Qu1AIvoe05KkXfhrLJfBM58FeB2Uc=;
 b=csin64EFNeiFaxwGgOWFYHODYvoWXDt99rM11PrM1KGdUQTnQBu9x8Rv13hH0MWzeQ
 d4/W5rkXA80yDFhplIbxmMaKzcWHzh/Om0sQl3LGp6/W9ZI/xse2n8cy+ip+eaO1FRSm
 iiXHOy7GdaXGO9YtBuN2E/zpjsrL+5hKC1kPven5HTxS0dFSB25QYGn2D1lKf5rg5Und
 +KgMpUqhH8Z9Q0ytz9tn3eQlGXzNIo7ynAEHv4naSyTejdjYdp4CFENEKp7JC4kgG1JV
 ieqFGuQJ1bqUGF+30L529x+Ov6tVm2x9Atw+uXhWXrIaB7WTFKTNWGW9wMzqWkIaiBqb
 ZNEg==
X-Gm-Message-State: AC+VfDwEHVdcM2CffVM3loNgSFGwticfED2e8zArTYvHaAdKJRezF+TU
 TqPt0/cQaSWMfw6xjSXf836sZx7hhzL8FChAzYIYqt04aHAl2EwsL3fca9SNOf6cl40vW2hJ2/h
 rBwfWOo+d8Rnd5tyN3appGTCXi4vFELFfHDm96y5x34fuoB0raby+BNKWvy+ANFv6c2/U0YE4ki
 Y=
X-Received: by 2002:a7b:cbd9:0:b0:3fa:7d9d:456f with SMTP id
 n25-20020a7bcbd9000000b003fa7d9d456fmr4813163wmi.40.1687768401483; 
 Mon, 26 Jun 2023 01:33:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ET/+xXjsYNceMzUq2GsojxF6DTiq3W6McBd7XAdVxVhFtUe+K0t5SKdPKBgxt3EBlO2F4jg==
X-Received: by 2002:a7b:cbd9:0:b0:3fa:7d9d:456f with SMTP id
 n25-20020a7bcbd9000000b003fa7d9d456fmr4813152wmi.40.1687768401148; 
 Mon, 26 Jun 2023 01:33:21 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a05600c471000b003fa9a00d74csm1223538wmo.3.2023.06.26.01.33.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 01:33:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] target/i386: ignore CPL0-specific features in user
 mode emulation
Date: Mon, 26 Jun 2023 10:33:16 +0200
Message-ID: <20230626083317.144746-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626083317.144746-1-pbonzini@redhat.com>
References: <20230626083317.144746-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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
index 8387843c4d9..69a1f2f805b 100644
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


