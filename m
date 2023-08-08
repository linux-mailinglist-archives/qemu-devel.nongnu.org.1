Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC19773703
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:45:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTChm-0005Ct-Q8; Mon, 07 Aug 2023 22:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ake@igel.co.jp>) id 1qTChj-0005CM-J1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:44:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ake@igel.co.jp>) id 1qTChh-00070I-6X
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:44:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so45713265ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 19:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1691462651; x=1692067451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tRcQgRjRVa0F4G+R0JeZyuWvu2eFe3r6uexZMFMsd58=;
 b=1l5TFHnlbe/UFE/iltJv0jJr8sm8gyzt1oGQ3OO0aa8U+aIOBqIYWXH3siJhLRTcSs
 d2xewPhg/Awayk0psmscb7/ivGBS/jR1NLcyzP67igMNtQ66/3rKn397GtjY+POHI6Tk
 xZoVVvuiaOEvGOUGrnvGi9soNdTzeO7oJmpf1rEL3s1xoEbzlxXquw3c34BcTXo5QL6R
 m1LsF5DbvkmlyoqDT6OCZwGotMVoOAQPhlyojj5F8pNogkqo+/GL2V3S6oZ/EnGgu8KS
 3wMP2q25VR3coFMYu5/d09aGIX80z3zYi6rjnPs8afciHXIPWJukHrkChV076/oHN4G6
 rBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691462651; x=1692067451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tRcQgRjRVa0F4G+R0JeZyuWvu2eFe3r6uexZMFMsd58=;
 b=lkLXlOrZMFZyOnrX/5cB9OpTQ4qYinXXM09Yn7s4hcWE6NV5itunTRELupcOKRS20B
 DQ0eH3zphwzId70FidTSDUPgSfJSkFgBe5N0XyXZU/hyaGor6l/dWT8V7Rwa9kKPLstf
 B1PXV1TuoXmSFxlBUl4652snPpQcQtG6AzXqpCfOFlklWduyI9hkIWqfpJd79vCyGQgp
 ronW/dFNyQDT8h1rwDRD6Lsh7N1s7IK2MyU/MQFms+HN85tM9TB+MWe/vYk7R+1+YJxu
 qi52WzgJ2z2bLMZeg7malA3KDuI0L/Jlc5c9iw23OxQF1SIYj8l0+LEmOwojyMOnzaoz
 y89A==
X-Gm-Message-State: AOJu0Yyv7FY4WqsFSmGPKamUUlOIYEL7Em6ynhU46vLtjGR06fJ3JKQ1
 Q3GK7zstElkqoqkVXHLTfNHm+aeQu62FJruzgcNKjA==
X-Google-Smtp-Source: AGHT+IFRrzOKjmuMBEETspqAuRlBMkD9uxxKIZtFqDtmsYn7vdneJqskKqbNXI3cUzex7OO7VXMZtQ==
X-Received: by 2002:a17:902:ceca:b0:1bb:97d0:c628 with SMTP id
 d10-20020a170902ceca00b001bb97d0c628mr11189023plg.31.1691462651062; 
 Mon, 07 Aug 2023 19:44:11 -0700 (PDT)
Received: from localhost.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a170902b58d00b001bb04755212sm7619844pls.228.2023.08.07.19.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 19:44:10 -0700 (PDT)
From: Ake Koomsin <ake@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ake Koomsin <ake@igel.co.jp>
Subject: [RFC PATCH v2] target/i386: add support for
 VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE
Date: Tue,  8 Aug 2023 11:40:02 +0900
Message-ID: <20230808024000.3985-3-ake@igel.co.jp>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=ake@igel.co.jp; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Current QEMU can expose waitpkg to guests when it is available. However,
VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE is still not recognized and
masked by QEMU. This can lead to an unexpected situation when a L1
hypervisor wants to expose waitpkg to a L2 guest. The L1 hypervisor can
assume that VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE exists as waitpkg is
available. The L1 hypervisor then can accidentally expose waitpkg to the
L2 guest. This will cause invalid opcode exception in the L2 guest when
it executes waitpkg related instructions.

This patch adds VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE support, and
sets up dependency between the bit and CPUID_7_0_ECX_WAITPKG. QEMU should
not expose waitpkg feature if VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE is
not available to avoid unexpected invalid opcode exception in L2 guests.

Signed-off-by: Ake Koomsin <ake@igel.co.jp>
---

v2:
- Fix typo in the patch header (targer -> target)

v1:
https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg01048.html

 target/i386/cpu.c | 6 +++++-
 target/i386/cpu.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..00f913b638 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1228,7 +1228,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-invpcid-exit", "vmx-vmfunc", "vmx-shadow-vmcs", "vmx-encls-exit",
             "vmx-rdseed-exit", "vmx-pml", NULL, NULL,
             "vmx-xsaves", NULL, NULL, NULL,
-            NULL, "vmx-tsc-scaling", NULL, NULL,
+            NULL, "vmx-tsc-scaling", "vmx-enable-user-wait-pause", NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
@@ -1545,6 +1545,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
         .to = { FEAT_SVM,                   ~0ull },
     },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
+        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..a6000e93bd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1111,6 +1111,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
 #define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
 #define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
+#define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
 
 #define VMX_PIN_BASED_EXT_INTR_MASK                 0x00000001
 #define VMX_PIN_BASED_NMI_EXITING                   0x00000008
-- 
2.41.0


