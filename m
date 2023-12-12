Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DED80F2E0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:35:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5hB-0000xs-Uk; Tue, 12 Dec 2023 11:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gq-0000BT-Ft
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:07 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gm-0007up-Nn
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:00 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3333131e08dso6405422f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398775; x=1703003575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txm7/iHmv0X7jWBggjHofZpA3/2r+gkB1hvwujvQQ8k=;
 b=tJdWbbb4u5oeAeN+MPcKCozrrd7nw6+MRPZ7oW/gMVSEGdbUw/ONYuBXrCqu/XgqZM
 2x8qffsqnF2zTZ+2IHAi/o/n1v6v8lJGeOcy7VG58AtWFopLtzMJ7WQKoHTOWlWoahc0
 U6HSVXNBeAiqZdYXqwRqyxFIYUZ4yt0djWUbz1azX+9a5C1iIPaNDLWkgney5y5lww1C
 eaH8/KJl9IqZIGkP7ow5SmQ96fWSbsH78NSdTbGOY7vHZiw+HAiiA4HU0AhEEUA8N8LK
 XdTqV9SbBI76DidE2Qx/jjR3vnjxFQvrtTHYAqQQJarp/ZF/EbpsFljNP9ftd9DE04ed
 Ufjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398775; x=1703003575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=txm7/iHmv0X7jWBggjHofZpA3/2r+gkB1hvwujvQQ8k=;
 b=ukdyOXk+9gv0+r02xROAVesXTmvI16kaorT5jotDzK+Yc3jnZpRHkCbcRFZmRVoUVn
 kYaHlzAsvcVb92dGPTi2+DL2av71+AmE/Pti8BfKusZ7B2psknE0PhIEzGXEiC9T38QZ
 dQ734Gs8OiK3aXblgR+aOHh70SOPBd7X5N+BlD2QJFA0f7e1j6qK0VLjzcLXGAbcuFaK
 KP+zQUaCCZQ2T5uEdVsaT3rbgoG318b9y/B2S6BgltnS8AG2GaHfDY6+D7wAOBWMP7UZ
 dAEJHGK7aw4+cYKUJ5kdPavjsSXgYHoNQkxnefttVgyqiTPpIAl87zFh6TmBahiRWBub
 gD/A==
X-Gm-Message-State: AOJu0Ywtpwkq9X4fUwZ3xJp+UNha1FXiWfFFb1nyr87IqhhASm6TxWPQ
 bGkgi+sihbx4X9ouNa/OERQVzzR0hkVXLRTwab8=
X-Google-Smtp-Source: AGHT+IE0bfcnrZKyfEhNF02tMu/TlCdEaOo1xp30m/2KU7QLmd5GRJV+BDgr/OoDe4TdwAqyB16mVQ==
X-Received: by 2002:a05:600c:4ca5:b0:40c:2630:1743 with SMTP id
 g37-20020a05600c4ca500b0040c26301743mr3033640wmp.84.1702398775012; 
 Tue, 12 Dec 2023 08:32:55 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a05600c34cd00b0040c496c64cfsm6831542wmq.12.2023.12.12.08.32.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 27/33] hw/arm/highbank: Let the A9/A15MPcore create/wire the
 CPU cores
Date: Tue, 12 Dec 2023 17:29:27 +0100
Message-ID: <20231212162935.42910-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Set the properties on the mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/highbank.c | 53 +++++++----------------------------------------
 1 file changed, 8 insertions(+), 45 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index a184bee993..b4f8304146 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -180,47 +180,10 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     SysBusDevice *busdev;
     qemu_irq pic[128];
     int n;
-    unsigned int smp_cpus = machine->smp.cpus;
-    qemu_irq cpu_irq[4];
-    qemu_irq cpu_fiq[4];
-    qemu_irq cpu_virq[4];
-    qemu_irq cpu_vfiq[4];
     MemoryRegion *sysram;
     MemoryRegion *sysmem;
     char *sysboot_filename;
 
-    switch (machine_id) {
-    case CALXEDA_HIGHBANK:
-        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
-        break;
-    case CALXEDA_MIDWAY:
-        machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
-        break;
-    default:
-        assert(0);
-    }
-
-    for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj;
-        ARMCPU *cpu;
-
-        cpuobj = object_new(machine->cpu_type);
-        cpu = ARM_CPU(cpuobj);
-
-        object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
-                                &error_abort);
-
-        if (object_property_find(cpuobj, "reset-cbar")) {
-            object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
-                                    &error_abort);
-        }
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ);
-        cpu_fiq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ);
-        cpu_virq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VIRQ);
-        cpu_vfiq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VFIQ);
-    }
-
     sysmem = get_system_memory();
     /* SDRAM at address zero.  */
     memory_region_add_subregion(sysmem, 0, machine->ram);
@@ -251,22 +214,22 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         sysbus_mmio_map(busdev, 0, 0xfff12000);
 
         dev = qdev_new(TYPE_A9MPCORE_PRIV);
+        qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-a9"));
         break;
     case CALXEDA_MIDWAY:
         dev = qdev_new(TYPE_A15MPCORE_PRIV);
+        qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-a15"));
         break;
+    default:
+        g_assert_not_reached();
     }
-    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-    qdev_prop_set_uint32(dev, "num-irq", NIRQ_GIC);
+    qdev_prop_set_uint32(dev, "num-cores", machine->smp.cpus);
+    qdev_prop_set_uint32(dev, "cpu-psci-conduit", QEMU_PSCI_CONDUIT_SMC);
+    qdev_prop_set_uint64(dev, "cpu-reset-cbar", MPCORE_PERIPHBASE);
+    qdev_prop_set_uint32(dev, "gic-spi-num", NIRQ_GIC);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
-    for (n = 0; n < smp_cpus; n++) {
-        sysbus_connect_irq(busdev, n, cpu_irq[n]);
-        sysbus_connect_irq(busdev, n + smp_cpus, cpu_fiq[n]);
-        sysbus_connect_irq(busdev, n + 2 * smp_cpus, cpu_virq[n]);
-        sysbus_connect_irq(busdev, n + 3 * smp_cpus, cpu_vfiq[n]);
-    }
 
     for (n = 0; n < 128; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
-- 
2.41.0


