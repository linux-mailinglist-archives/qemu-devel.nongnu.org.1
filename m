Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D4E791782
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8wq-0003Yb-2v; Mon, 04 Sep 2023 08:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wY-0002hM-Kk
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:43 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wU-0004q1-8N
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:36 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so221339266b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831472; x=1694436272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQp1ZwukkzwgrEJecGe85e61/jQRSJ79TXphHOkDcps=;
 b=kdM4fmih7f7PIXry0I6KDgO3ccjLjcYsaaIES5rX5783shZBjvqesxw6xJJnZgToju
 q4HT2kWEXWU2NkDVHMBTN6S7aSMEUp7nUyMm7PPZt/eO628pvWP0MGNOqFCzDLarFH0N
 30orC0f7UPti1MDYHXPRMm+h7D2MVcRbOO3R98xuOluEj4oPWNpQj0xo4A8TLpOplaWh
 5iDQ+ZYrSUVxwYwXAHeLz3B44pJJMNwJ53L6J3+IWRv1e2cZit99YG1EjQW7CD8tCSoD
 YXyBjHn5Z2bUd/zqviSboydn79io3X+yZ0ywiBpS9Qmw0GH+G3i806e6YU3mujR0Okbl
 vhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831472; x=1694436272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQp1ZwukkzwgrEJecGe85e61/jQRSJ79TXphHOkDcps=;
 b=L7om7tDGaHDZ1UqelNfMJaUQqv/T4Dy8g+pu1bz9U9To0lDuLXNzHHbhuq/MiKRljZ
 Biec5woowqJ8QZr5Jjzjgh61hISHIQqaKgdfkCoO17zA2af/52cGSiguBv/mrJzOZ68D
 sXR8QD8IiHRRntf8x8weuXik890jLqH3sztBToKr1iR/gCP6Xsh4Ej40AoKQHTh+lUYW
 E78cdLPdBotHh5EJV8obwMqsMteqeYK/wz8R8y2ZadvZgEIyO0b6bJdh2pgRrQ0RJWww
 7x60ux0T7SaniIIRegNcUVJwmrNpBTy8o8cYV5qpPlCqhdrleaYNDAJ6aU1WBRyA+VuY
 R7qg==
X-Gm-Message-State: AOJu0YzqO5MYqg0uD+MUCU+b1iuANmNIAWoFwjWpQGNpBrK0sp2o+PKr
 gO7qEJmmNoD/B9SZ1TzEAr4pV3bQJNbVdPC+T8E=
X-Google-Smtp-Source: AGHT+IHuyIx4y8Ds8coh9sd7t5uoyGE2ek+jqkPzJtAFpTx/gIGSHZIy1qj15vmm5PPTTvaYTKuKSw==
X-Received: by 2002:a17:907:2c64:b0:9a1:b43b:73a0 with SMTP id
 ib4-20020a1709072c6400b009a1b43b73a0mr8116583ejc.20.1693831472606; 
 Mon, 04 Sep 2023 05:44:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 x24-20020a170906299800b0099cadcf13cesm6132052eje.66.2023.09.04.05.44.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/13] sysemu/kvm: Restrict kvm_get_apic_state() to x86 targets
Date: Mon,  4 Sep 2023 14:43:22 +0200
Message-ID: <20230904124325.79040-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

kvm_get_apic_state() is only defined for x86 targets (in
hw/i386/kvm/apic.c). Its declaration is pointless on all
other targets.

Since we include "linux-headers/asm-x86/kvm.h", no need
to forward-declare 'struct kvm_lapic_state'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h       | 3 ---
 target/i386/kvm/kvm_i386.h | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a578961a5e..4326b53f90 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -188,7 +188,6 @@ extern bool kvm_msi_use_devid;
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
 
 struct kvm_run;
-struct kvm_lapic_state;
 struct kvm_irq_routing_entry;
 
 typedef struct KVMCapabilityInfo {
@@ -407,8 +406,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
-void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
-
 struct kvm_guest_debug;
 struct kvm_debug_exit_arch;
 
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index b78e2feb49..d4a1239c68 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -54,6 +54,7 @@ bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
 
+void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
 void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_has_x2apic_api(void);
-- 
2.41.0


