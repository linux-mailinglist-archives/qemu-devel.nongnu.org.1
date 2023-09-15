Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E837A2378
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBYu-0005Wm-Sf; Fri, 15 Sep 2023 12:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBYt-0005Wb-Fr
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:20:55 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBYr-0000Wa-TL
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:20:55 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50078eba7afso3852963e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694794852; x=1695399652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY2zRc5UQ1ttBDAhQdzUYI1/2Fa0E28wpiBNWWnnf1g=;
 b=YDitTy0P5i2XWPQTLy1bUaeZtgwTG5MLt1WaxiRAIMCLhofLzNmlvhwj5VA5Tk/pml
 H9DwZCxaY/OZh/JLsvam/Tkm8bVrVDjWiJq5kK6ydk9S28QVobQxw1UzXoNooXdUEKFX
 pXPR6jhN/xcKOWOZH9e4gEg1Vle8VPePePzYbVQIZcLKKR9JGxr9gWf7H1T5T0Fe1OcN
 5OA9ZXDQ8omWdYfYyk3kxVIXw1maCCPOtCQP164hxeBfA3kLHaNRBhkQG5GZ5E64ThZ3
 u+/Q01M+gAX/hF43tpp7ApcgrvgwM7K+Y9337vR4kg9IoeIZfLjIju2AHNgKdlJv1ufv
 7N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694794852; x=1695399652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY2zRc5UQ1ttBDAhQdzUYI1/2Fa0E28wpiBNWWnnf1g=;
 b=rztl6vKKO2Rl/yAuz7zaiSGf1N7YenMG69ecPs4XEvi7a3+wHd28SI8D+KYGfJC3Ta
 Gi6rjmT3Jd/7oK6x7exuDPlx3aTrZ/MrCQOASGDwcY3onOj95Uov54TuCP/IoXky4MBU
 NQSXe4Z63RRk3olVGT5VRWN3xWsBzxgFHlc+IapMmyknQRJxz2oi6HM9CVVDXWhDWnu3
 vdIt2pAuqkIJeKg5b1coSjahYC6P8+xF2WDM92RFdWPUpiIavA/kD2HdIk8REnjNMK47
 aJShgRlyo+XashPBXprfLBdTTviDS/SHjGXzC9eCbAKV9al9bFRmxyDb33kmUHS5O8M+
 6sQA==
X-Gm-Message-State: AOJu0YxvPUv1U0GDycQ4ype7shbz3mvjvtViYeXljX4V/HYv5igaMq81
 +3Fz8URilZBNO9lJRILhPdWCrJWUD6WJ7n+1ggc=
X-Google-Smtp-Source: AGHT+IFz3JoD9H/tmIP++pjLx88owh4qoGe3gCA2KTGTNuT/hiSOOjRkcyihrXFxQUvOs7UMsdlzwg==
X-Received: by 2002:a05:6512:1193:b0:500:9b7d:ee3c with SMTP id
 g19-20020a056512119300b005009b7dee3cmr2299624lfr.7.1694794851648; 
 Fri, 15 Sep 2023 09:20:51 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 br20-20020a170906d15400b0098669cc16b2sm2610559ejb.83.2023.09.15.09.20.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 09:20:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/i386: Only realize existing APIC device
Date: Fri, 15 Sep 2023 18:20:41 +0200
Message-ID: <20230915162042.55890-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915162042.55890-1-philmd@linaro.org>
References: <20230915162042.55890-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

APIC state is created under a certain condition,
use the same condition to realize it.
Having a NULL APIC state is a bug: use assert().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu-sysemu.c | 9 +++------
 target/i386/cpu.c        | 8 +++++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 2375e48178..6a164d3769 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -272,9 +272,7 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
     APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class(errp);
 
-    if (!apic_class) {
-        return;
-    }
+    assert(apic_class);
 
     cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
     object_property_add_child(OBJECT(cpu), "lapic",
@@ -293,9 +291,8 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
     APICCommonState *apic;
     static bool apic_mmio_map_once;
 
-    if (cpu->apic_state == NULL) {
-        return;
-    }
+    assert(cpu->apic_state);
+
     qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
 
     /* Map APIC MMIO area */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2a20365e1..a23d4795e0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7448,9 +7448,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    x86_cpu_apic_realize(cpu, &local_err);
-    if (local_err != NULL) {
-        goto out;
+    if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
+        x86_cpu_apic_realize(cpu, &local_err);
+        if (local_err != NULL) {
+            goto out;
+        }
     }
 #endif /* !CONFIG_USER_ONLY */
     cpu_reset(cs);
-- 
2.41.0


