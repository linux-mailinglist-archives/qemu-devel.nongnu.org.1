Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7767F4F9E
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:33:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s1f-0005JR-Dn; Wed, 22 Nov 2023 13:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0u-0004RR-Sd
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:54 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0t-0004hS-3p
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:52 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso7419f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677909; x=1701282709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9IPEOr0rBXMMdMMcbayFM6zic8FKV6LVlnxUz4MJGo=;
 b=CGUlveBtcf6sVTbFmIFKpNOwPRCdwQZZTtImAOLUjN+DmSgYiGK9xrcXqvj76DAo19
 rssEi+4Vws9ooltW/C3MDJybOKHFI43eqaBP7v4M/FMBPWwAsiFHtzmPrJHx46ZsPnk4
 PUzXgN5YA2Lfpk16t3/dzq3bukWP+YejbjKKnn/HBByhRyqYse96NnKiEL+BtE85/XcH
 WtFWQBK0gl2a9ctJv6BTTYqr/mUGkwSZQESq6bqakKDxXTVl6eIJzp11/YZVPr8fXj/x
 4Rj9DYbds5+pkphSoKRZeS/xhGdtyoRlnsYoI99Z8wZaJHiOrymldIPD0LdVjXDP8tHK
 6H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677909; x=1701282709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9IPEOr0rBXMMdMMcbayFM6zic8FKV6LVlnxUz4MJGo=;
 b=bHwYwc+T6TOTvlYqCYd4YrMvOemLnUAQhGn40nKV9VuexXccUi7uryvBztUAgdJ5Cv
 OJLQZYrmBfvOihCeHjOoX0MXHSTC3nPTrvb2gDya+JBuhyhXiNW4wE1lZpzGn6Zl3ff7
 Pf1OK6fvpLpaLJ5RqnKSVylbcHo5F9v12gb+NkRdWErUrMDDhUvuL75ISZ8ZPyuGf4Rg
 V6dNcQC+uuipuUNQ+U/wsSbCgbrbdNxo+AXxbd5Wudu8fhXZvROewbnAuKny4gJ3Ht+G
 mIPVNBgKpiQ4yRDgGeB6Z1OmQM6VL2VBmlHxkvCTST+oJcjaMoZOffCILgNFB7+vZXxC
 al4w==
X-Gm-Message-State: AOJu0YwCUVdQnxAlYQFi/uvsbDHfaq5X9NIz/CpfzFUg545HTZtIfV2n
 WiFOtRRhogeGi1GUrw8awK0+QPm4YffjzYbCJ20=
X-Google-Smtp-Source: AGHT+IH5oUX5HGY8Tyq5COBq6B13fWkNiw9fUgbBMXCor3h0U1nUKnPUvYvsxmr+d4l3j0e+BaAyXw==
X-Received: by 2002:a5d:6c6d:0:b0:332:ca1a:a824 with SMTP id
 r13-20020a5d6c6d000000b00332ca1aa824mr3142903wrz.11.1700677909262; 
 Wed, 22 Nov 2023 10:31:49 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 d11-20020adfa40b000000b003232380ffd7sm38237wra.102.2023.11.22.10.31.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH-for-9.0 11/11] hw/intc/meson: Simplify how arm_gicv3_kvm.o
 objects are built
Date: Wed, 22 Nov 2023 19:30:47 +0100
Message-ID: <20231122183048.17150-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use the target_aarch64_available() to build the ARM_GIC_KVM types
regardless the ARM/AARCH64 targets are selected, but restrict its
registration to TARGET_AARCH64 presence at runtime.

This will help to have a single binary running both ARM/Aarch64.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/arm_gicv3_its_kvm.c | 1 +
 hw/intc/arm_gicv3_kvm.c     | 1 +
 hw/intc/meson.build         | 6 ++++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index f7df602cff..b3063c4cd7 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -261,6 +261,7 @@ static const TypeInfo kvm_arm_its_info = {
     .instance_size = sizeof(GICv3ITSState),
     .class_init = kvm_arm_its_class_init,
     .class_size = sizeof(KVMARMITSClass),
+    .can_register = target_aarch64_available,
 };
 
 static void kvm_arm_its_register_types(void)
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 77eb37e131..33321dee5d 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -909,6 +909,7 @@ static const TypeInfo kvm_arm_gicv3_info = {
     .instance_size = sizeof(GICv3State),
     .class_init = kvm_arm_gicv3_class_init,
     .class_size = sizeof(KVMARMGICv3Class),
+    .can_register = target_aarch64_available,
 };
 
 static void kvm_arm_gicv3_register_types(void)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index ed355941d1..d45eb76f36 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -40,8 +40,10 @@ endif
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
-specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
-specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files(
+  'arm_gic_kvm.c',
+  'arm_gicv3_kvm.c',
+  'arm_gicv3_its_kvm.c'))
 specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
-- 
2.41.0


