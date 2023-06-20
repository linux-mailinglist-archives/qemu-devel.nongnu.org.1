Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFBF73663F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWn8-0006AZ-RK; Tue, 20 Jun 2023 04:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWn6-0006AD-7D
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:32:44 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWn4-000849-IO
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:32:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-988a5383fd4so369449566b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249959; x=1689841959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fWrVTkrh+bhxulRnGVYi7XRu+z1AiTWlgw98CXAeJI=;
 b=SOnhA91BKwLw20oxQ7Deu+EZBvp12+SO/nRM9MirPrl1jRsI5NjJUhnurnJNs6BR9q
 nBq52fa3Nb+Ga+3YlccTxEm5xU4s7GsxUA0eg6bpv5MfcWogS2Flp1XWsYbBfTOJSOmu
 A6/HzEk5O8wTO2jeJcnHVSj3Gehtn16el8oVkz1YfTNf+mjGT9RofjTbg3IaHCGXVd/T
 djp6Oa6O69TJO16H1cxgtk1R+2FpNLZ4o8w0o7lVqIV4a52ackRgdbECu7M4FT4LyIEf
 JPBdUmJRmFcjHtY3Jf6vUx+fBReGCSlNklpaEZ9czKLnPJvspNH6c4rVVdM3uhYcobBA
 7+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249959; x=1689841959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fWrVTkrh+bhxulRnGVYi7XRu+z1AiTWlgw98CXAeJI=;
 b=LG9O4CjK9xWMh/O8TwtGkfeiLH27iqTy8JBPWPZQpiweYNsJyanIT3jiQCw8ZAPlRg
 AhjYiN3oVnAvvnO+CioejbSez/VY6flKdTvPJR4gkadQU1fTCdj0lDNRL+ugexFWA2mv
 ajV0U9zAO8kHlc6GeCMf+bvwT+Q0cnqKDZ8Hh+wg/PpuAT0eAiVwoAOn8UjqefBK09rV
 ij67vjoeggM7BxpnggVyRwYtUq1y1gGwHaCD/5Fk7YCd1Roalfm+C4eG+edIlUF7xJHm
 HpMewGe8t60kM27tMZluSDZjuCvwAv2AKNFBcEpJvJzbJOrD6L53EEdmeEj/AEpfeylW
 tTFw==
X-Gm-Message-State: AC+VfDwXjr0ZHk99AVf8K9/F2KOWbcoNciVDvMXczjmiOP85uAGII9RV
 z7OuGsE2oQbV7m3zUbGEHdfwUnHmTQRX+Me/RO98bw==
X-Google-Smtp-Source: ACHHUZ7oqvtsCEH2H0pVIvI62fTmZU22tNpVGN4sTvY9bwRm64+jLUGifNJtnWRyBxOtlihXSS5sBA==
X-Received: by 2002:a17:907:6d26:b0:988:2037:c687 with SMTP id
 sa38-20020a1709076d2600b009882037c687mr6360386ejc.37.1687249959548; 
 Tue, 20 Jun 2023 01:32:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170906644b00b00988956f244csm966198ejn.6.2023.06.20.01.32.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jun 2023 01:32:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/i386: Remove unuseful kvmclock_create() stub
Date: Tue, 20 Jun 2023 10:32:27 +0200
Message-Id: <20230620083228.88796-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620083228.88796-1-philmd@linaro.org>
References: <20230620083228.88796-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

We shouldn't call kvmclock_create() when KVM is not available
or disabled:
 - check for kvm_enabled() before calling it
 - assert KVM is enabled once called
Since the call is elided when KVM is not available, we can
remove the stub (it is never compiled).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/kvm/clock.h | 10 ----------
 hw/i386/kvm/clock.c    |  4 +++-
 hw/i386/microvm.c      |  4 +++-
 hw/i386/pc_piix.c      |  2 +-
 hw/i386/pc_q35.c       |  4 +++-
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/hw/kvm/clock.h b/include/hw/kvm/clock.h
index 7994071c4f..3efe0a871c 100644
--- a/include/hw/kvm/clock.h
+++ b/include/hw/kvm/clock.h
@@ -13,16 +13,6 @@
 #ifndef HW_KVM_CLOCK_H
 #define HW_KVM_CLOCK_H
 
-#ifdef CONFIG_KVM
-
 void kvmclock_create(bool create_always);
 
-#else /* CONFIG_KVM */
-
-static inline void kvmclock_create(bool create_always)
-{
-}
-
-#endif /* !CONFIG_KVM */
-
 #endif
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index df70b4a033..0824c6d313 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -332,8 +332,10 @@ void kvmclock_create(bool create_always)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
 
-    if (!kvm_enabled() || !kvm_has_adjust_clock())
+    assert(kvm_enabled());
+    if (!kvm_has_adjust_clock()) {
         return;
+    }
 
     if (create_always ||
         cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7227a2156c..6b762bc18e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -180,7 +180,9 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         x86ms->ioapic2 = ioapic_init_secondary(gsi_state);
     }
 
-    kvmclock_create(true);
+    if (kvm_enabled()) {
+        kvmclock_create(true);
+    }
 
     mms->virtio_irq_base = 5;
     mms->virtio_num_transports = 8;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 44146e6ff5..715c063eec 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -193,7 +193,7 @@ static void pc_init1(MachineState *machine,
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
-    if (pcmc->kvmclock_enabled) {
+    if (kvm_enabled() && pcmc->kvmclock_enabled) {
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a9a59ed42b..a0553f70f7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -184,7 +184,9 @@ static void pc_q35_init(MachineState *machine)
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
-    kvmclock_create(pcmc->kvmclock_create_always);
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
 
     /* pci enabled */
     if (pcmc->pci_enabled) {
-- 
2.38.1


