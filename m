Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B456771D38
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwf7-0002w1-WD; Mon, 07 Aug 2023 05:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ake@igel.co.jp>) id 1qSwez-0002pV-0Z
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:36:22 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ake@igel.co.jp>) id 1qSwew-0000uZ-Pk
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:36:20 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-76ad8892d49so393908985a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1691400975; x=1692005775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kjb2Lb0RodSPhVU0nCFJdyCAFChvledIaVNLXAkV0w8=;
 b=xwipYGdNcEpyiDk6qsTSlkRrWsfuHPU+lQLEuUUwEAQi7e1qiZW3D4B0yGWbwMOJoE
 styG2kNVp+LULZP4wT0j7UcbZCEdEC74FpsEd/raGVNqCzH/qLDJE/pXoSI6FpQH4msE
 D+VtJlcT66KzUy6MY1z9LPN5ZmL/GkXIBDTbosR5l4mYrqWWwb8oKnWoJ/2/fwDEvdyI
 umGXIo5pbr/Lxv53IhaJA6Cp3OJkvqeFC6riVlnSj3yugSsPnrRyOSHl0wamk4fFXnI9
 lzWkXO0q0hdHVf3DLdnSAX9AIoJ6qL4zv5YrBIMkNbcTQCwOji0p1GhN5DqnM2mARlqf
 a0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691400975; x=1692005775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kjb2Lb0RodSPhVU0nCFJdyCAFChvledIaVNLXAkV0w8=;
 b=QlE1+Cz0OcKqpl3KYX4NuiUeU3x3RMjghpOGMiW4poJx9hwQE/jiPNmBF85awQMy8Y
 4EhBhbslni0++c1xBJCfrM2wxsQedleseUbUjRpElgNSl/7KZJtqK9G1BPoxh08JV38x
 XYWg2I9LPXplK61pfxac1YqqCpU9ZoavoQ2vhpX7pdw00q9KlqiGkiN6g8iWIERl9Oui
 3+eeRvXS1wOh08dB2omU8nVlQK72Z6N/rjt94VPP9Rkpha/wdAoJBcWO3O7CZbj+xyRG
 Goobg18L46wzG9T0zu8FN5p3JdjuPkuhdYVpXJm+wp8xXaEPBxnq6T7/F0pmDPjU0GiB
 AP5Q==
X-Gm-Message-State: AOJu0YxJ7Kkw6OsHCO8iV+HMWdJTj7RAgMquDIZlM8qYqfR1GBsZ+D5M
 5JDEhaUC0ksyRylRYKpkD4rh1itJrHcqzGLmksURcw==
X-Google-Smtp-Source: AGHT+IF9jAHbV8nFraUjRWfUV0kqC3/FUdti5p+QtKBK9lDJuY4ZHyXu2zeCuEAouG1s6IsdPGjiCA==
X-Received: by 2002:a05:620a:4545:b0:767:8083:dd46 with SMTP id
 u5-20020a05620a454500b007678083dd46mr11825282qkp.61.1691400975530; 
 Mon, 07 Aug 2023 02:36:15 -0700 (PDT)
Received: from localhost.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 g28-20020a63375c000000b005633941a547sm4750337pgn.27.2023.08.07.02.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 02:36:15 -0700 (PDT)
From: Ake Koomsin <ake@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ake Koomsin <ake@igel.co.jp>
Subject: [RFC PATCH] targer/i386: add support for
 VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE
Date: Mon,  7 Aug 2023 18:33:40 +0900
Message-ID: <20230807093339.32091-2-ake@igel.co.jp>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=ake@igel.co.jp; helo=mail-qk1-x734.google.com
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


