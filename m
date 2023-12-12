Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9811280F2C4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:33:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5hC-0001Fl-VM; Tue, 12 Dec 2023 11:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gz-0000FF-1h
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gv-0007wS-DY
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so55198325e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398783; x=1703003583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtRA1ZcQFW7z3eKOx2yAyRkVJ7SlDZA04aMcZUs1m4I=;
 b=ZVIFuzmLchDjDB3OkfjbMZXVKMgYwOO0S7whNc7TlESvzffg/pX3xTSev92pWsuFIv
 R02c9U8UvYwvO7l6tyJUfWr4J4xbO7b6xtrku2REbGptcPu3sWjfXcLHfD+8UtsUq4oH
 p4Be110cat34XfxwujbHVBGeqtNXtgXezqOFw88PJtEAe+tzdruz/hx5A6dJrD1QDUwF
 T1yjyA8nGbOzmiHEJCN8j3ALC/SeXV+OjsNkYQYZfqQeTm1CeyDonkKwxuolrIki6isD
 r46rJlzP5oWhuS2wRnjJNyc7FQD89UFvyWtvdUtmTJ9EyourFloZkWnjOmiWK+WhFBz3
 IYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398783; x=1703003583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtRA1ZcQFW7z3eKOx2yAyRkVJ7SlDZA04aMcZUs1m4I=;
 b=eJUUw4v5l1E+td8KM5SyOr/xGQVWE9Baf8QGnIz9BoIw1H3g7qiyvi6prDoJ3/xDDS
 Qfmj/Gpk5EzhHE0nA3eFVTnwlbSoVBNulxeKm7aK3ewr5Ow4q0o4olKkzq8JgJ2Kd4RN
 lq4wyP4J13R3NhzaYVO2o8g5nCMnkzaun6boU7tzfhqgiNGNwtZVRqVoGVaKiXDjt9F2
 GBYjvjmQsjCQ5TayUPfMm0lyPKCRKtQ+0aoWvDdmo8lBfNkx8rn2Jp7NPYrrbUWewm9+
 tn/H3m9FgQi00O9M/JVbSKyEsZzcJ8ImMt8D16pc3bRGWTSN0rL7nnLPnl8HZG1Zz4Ha
 5fAQ==
X-Gm-Message-State: AOJu0YzXILDL35+rUk6rR/li9X95Bg1yOmf1iyKAIzfOEx3QTFBsjbCI
 UPStPmT3LodfPFXt0onH9rYA4XVhWxMPN20A+S0=
X-Google-Smtp-Source: AGHT+IHmB1gMHyfBTapoK6ubgT1kUI5aeRYDa46oOtCc66PwG5Jhqp1N4vhbcxsCs9bUukgHOyUtsw==
X-Received: by 2002:a1c:4c07:0:b0:40c:3419:6ed6 with SMTP id
 z7-20020a1c4c07000000b0040c34196ed6mr1818330wmf.85.1702398783009; 
 Tue, 12 Dec 2023 08:33:03 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c1d8100b0040b47c69d08sm19472560wms.18.2023.12.12.08.33.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:33:02 -0800 (PST)
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
Subject: [PATCH 28/33] hw/arm/vexpress: Let the A9/A15MPcore create/wire the
 CPU cores
Date: Tue, 12 Dec 2023 17:29:28 +0100
Message-ID: <20231212162935.42910-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
 hw/arm/vexpress.c | 51 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 45 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 294b6f15f2..c104759588 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -210,45 +210,19 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
                       qemu_irq *pic, bool secure, bool virt)
 {
     DeviceState *dev;
-    SysBusDevice *busdev;
-    int n;
-    unsigned int smp_cpus = ms->smp.cpus;
 
-    /* Create the actual CPUs */
-    for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(cpu_type);
-
-        if (!secure) {
-            object_property_set_bool(cpuobj, "has_el3", false, NULL);
-        }
-        if (!virt) {
-            if (object_property_find(cpuobj, "has_el2")) {
-                object_property_set_bool(cpuobj, "has_el2", false, NULL);
-            }
-        }
-
-        if (object_property_find(cpuobj, "reset-cbar")) {
-            object_property_set_int(cpuobj, "reset-cbar", periphbase,
-                                    &error_abort);
-        }
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-    }
-
-    /* Create the private peripheral devices (including the GIC);
-     * this must happen after the CPUs are created because a15mpcore_priv
-     * wires itself up to the CPU's generic_timer gpio out lines.
-     */
     dev = qdev_new(privdev);
+    qdev_prop_set_uint32(dev, "num-cores", ms->smp.cpus);
+    qdev_prop_set_string(dev, "cpu-type", cpu_type);
     if (!secure) {
         qdev_prop_set_bit(dev, "cpu-has-el3", false);
     }
     if (!virt) {
         qdev_prop_set_bit(dev, "cpu-has-el2", false);
     }
-    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-    busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_mmio_map(busdev, 0, periphbase);
+    qdev_prop_set_uint64(dev, "cpu-reset-cbar", periphbase);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, periphbase);
 
     /* Interrupts [42:0] are from the motherboard;
      * [47:43] are reserved; [63:48] are daughterboard
@@ -256,22 +230,9 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * external interrupts starting from 32 (because there
      * are internal interrupts 0..31).
      */
-    for (n = 0; n < 64; n++) {
+    for (int n = 0; n < 64; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
-
-    /* Connect the CPUs to the GIC */
-    for (n = 0; n < smp_cpus; n++) {
-        DeviceState *cpudev = DEVICE(qemu_get_cpu(n));
-
-        sysbus_connect_irq(busdev, n, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(busdev, n + smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(busdev, n + 2 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(busdev, n + 3 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
-    }
 }
 
 static void a9_daughterboard_init(VexpressMachineState *vms,
-- 
2.41.0


