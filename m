Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B0A96F72
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 16:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F3F-0008T8-UV; Tue, 22 Apr 2025 10:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2p-0007Yh-Mz
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2c-0005F2-93
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso45734595e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333760; x=1745938560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2KEV2AEYEUZLZcRsBIKfpHBlRW4GmRUJdostUxtMx4=;
 b=Sgjuf9kxBVeOeh+sOK+JLzLhoMe/E1jN86FxcYuupc4TP6KJZSfiXy4GNe2uAcctqA
 CQ1JafAb/52vhjUSYPc0fNM2WCvml8LMueKq1ld93esKbdqXNtqLlUvpqXBVnwI1ayeR
 oVgTwimljyuqBvEshp3GgFDb7lcoaWXMkrf8nlz1j+No7luJuglRwrzywPf0I3b1rj5W
 HbdBvdmqt03+iD0aPopNgfSyO++WxUkAjUsXnaXLOPwx5RNRCryAjrYnnyttbjHQvXKd
 bcnuMSpIOh4CbTR1+wwc/ppSBCXHh5a67+yYyVu7/44pCwAHSUrlLXlk8g/ymaI3qGBy
 Nx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333760; x=1745938560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2KEV2AEYEUZLZcRsBIKfpHBlRW4GmRUJdostUxtMx4=;
 b=XIVP2Rqqlbc07qLFljR4iwN7U866zMXrsIUHHqvaq1Nc3MUp1hRlCRb6d4F1B+qXHw
 AGlGX/WijmrzW0XB6stGd5vPE53yTRLG9ErN7F9DIlDo9I661u4caPzcnhenRb5uWu8C
 OVITEOKr3dDn/P1ltFLNj2hrvjy2AlZy+trTotEkAZSuiNjX+wKASJuNj/CORK1nln/u
 8YxNFudYsR/Vkp0cC0esbN1HAHqo2LuQ2+6OC0uELZYkEtHm5hqi+Ijd99DQIEldbqkM
 NPP8DS6onh3aWXYie9kgUipIpBUiQqWWxSEf7D0Eu3ZW2JNxWIUDFTszobnyw2xN0Ean
 AxcQ==
X-Gm-Message-State: AOJu0YxilGew9BOxCPnHdQdMNRIQbT8F1cdQcWYglqzjgQcS9+s9tD+8
 zY6DnPlwkthtA6bkBzdnu+biNIqUfVV7fGf2Gxf8lVP8Hm4+QgVM4SvnACnGrOVT6CPyZ2O4D9j
 h
X-Gm-Gg: ASbGncvF6c7/F2TB/KsWfklsbdC1xFBiWiPy08HP2j4UzOZ1V1466ZHnvsQCyXPAO0P
 Gk1voldEI3fW05maV3Vx/GDutOu8bBai3KbhAXbU6v0r7u2sh2CbKsG7ifKU2Go9dmjHqeXAdDG
 SgZl35jbM4OfGQpuH7aZJvIVGfxOoCDuGcSesAxQ4CxxaZZKVxfYrblaQ4nii1tii3xUjLSFlOh
 KR7kjYiOeWYdeoYk+lyoaxvOYUxjE0DLLU5baWAyFOFJSyHLPq8ApmSinpQiMdmjh/fZVIIW4Bz
 FwPbXbaEq4POZtsSx3HYcsWiMhQPDCnMHLD46Dfjs09Tih05uNDygkAWEh0gXvJGEN0JS2IxpAJ
 hnpv1twSKt8QlSVM=
X-Google-Smtp-Source: AGHT+IHSo69OW5Hs5rZUkygtWXWCyAhed5CfpSisFgPy9uOkSsKMTK5i9Pd120jH0qTGhirp01/voQ==
X-Received: by 2002:a05:600c:19cc:b0:43c:fcb1:528a with SMTP id
 5b1f17b1804b1-4406ab67742mr125776195e9.6.1745333760048; 
 Tue, 22 Apr 2025 07:56:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbd8asm177010515e9.23.2025.04.22.07.55.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 12/19] hw/arm/virt: Register valid CPU types dynamically
Date: Tue, 22 Apr 2025 16:54:54 +0200
Message-ID: <20250422145502.70770-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace the static array returned as MachineClass::valid_cpu_types[]
by a runtime one generated by MachineClass::get_valid_cpu_types()
once the machine is created (its options being processed).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 59 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a3c9ffe29eb..c6ae7cc1705 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3130,36 +3130,41 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
+static GSList *virt_get_valid_cpu_types(const MachineState *ms)
+{
+    GSList *vct = NULL;
+
+#ifdef CONFIG_TCG
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
+#ifdef TARGET_AARCH64
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a76")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a710")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("a64fx")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
+#endif /* TARGET_AARCH64 */
+#endif /* CONFIG_TCG */
+#ifdef TARGET_AARCH64
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
+        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+            vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
+#endif /* CONFIG_KVM || CONFIG_HVF */
+#endif /* TARGET_AARCH64 */
+    vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
+
+    return vct;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
-    static const char * const valid_cpu_types[] = {
-#ifdef CONFIG_TCG
-        ARM_CPU_TYPE_NAME("cortex-a7"),
-        ARM_CPU_TYPE_NAME("cortex-a15"),
-#ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a35"),
-        ARM_CPU_TYPE_NAME("cortex-a55"),
-        ARM_CPU_TYPE_NAME("cortex-a72"),
-        ARM_CPU_TYPE_NAME("cortex-a76"),
-        ARM_CPU_TYPE_NAME("cortex-a710"),
-        ARM_CPU_TYPE_NAME("a64fx"),
-        ARM_CPU_TYPE_NAME("neoverse-n1"),
-        ARM_CPU_TYPE_NAME("neoverse-v1"),
-        ARM_CPU_TYPE_NAME("neoverse-n2"),
-#endif /* TARGET_AARCH64 */
-#endif /* CONFIG_TCG */
-#ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a53"),
-        ARM_CPU_TYPE_NAME("cortex-a57"),
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-        ARM_CPU_TYPE_NAME("host"),
-#endif /* CONFIG_KVM || CONFIG_HVF */
-#endif /* TARGET_AARCH64 */
-        ARM_CPU_TYPE_NAME("max"),
-        NULL
-    };
 
     mc->init = machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by KVM.
@@ -3187,7 +3192,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #else
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
 #endif
-    mc->valid_cpu_types = valid_cpu_types;
+    mc->get_valid_cpu_types = virt_get_valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
-- 
2.47.1


