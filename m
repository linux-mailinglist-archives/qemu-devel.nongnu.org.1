Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 449D180F301
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:35:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5hE-0001HT-HG; Tue, 12 Dec 2023 11:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5h5-0000N8-8K
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:15 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5h1-0007xX-CN
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c256ffdbcso60583605e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398789; x=1703003589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPLFBqDabQLYVHbUOqNffhd0DEwyb05vaEjM8y+M+3M=;
 b=s8kbTXB8AEbxBjsjbFGVEoR/lsAH29R1OrNjO60MN1apmRvTB1EZqhy7BFUZylURBe
 jcMHV92mIKrr4OUDXV9t9pOQVUFsrSYQmhLBQqRXyIFlPfpupO91QlmpGyLSP97ILV09
 2Ztz/nKnZ2ByhOywOzY6y9P6BakzczuRxKUp9HLvLslWgzpi1lico5eFUGBDtqnSquoE
 BguKYqDTC37i/CxhTmzUyK0zs+bMOmxJQBFgrMvBHSP/7Br/MgG1TpptHoHzCC9MZ/Ri
 5sRkgbKXEP+60+YM5qNvM74Wzj2KBzT0iMNz3MHycRiReeRjLRmzrJnB+Yu0ITqWD+Cg
 bSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398789; x=1703003589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPLFBqDabQLYVHbUOqNffhd0DEwyb05vaEjM8y+M+3M=;
 b=lBEOR4B2Lx4VK0EwgWMUWnke54IjY7gk8SWiay5eiCTswpMpiVqDXZ7fPoVtClEAnQ
 G3cXTLIrPGqu20hGKUnykDhOKGOqHbrdQAgLuiU97vaH0rqM3N7S3V8GwSWaRcmstmY1
 95l84Y5I9dSNF7861VT7IVGAy+j1658I2CA9/G9f4NoiO3swNUAwT/YRAQ+TkSs8E6Uu
 Njv2xGpULj9rhwmWbbG2uPIO7W3/Ns2op3a2OmD/LBQ4zFc6Eg2ZxbEjPjsOD2o8Jyx+
 0KJO2Zsw3rs1TLwhnReNZVPTrKbmC1FMBO7gCa1OqaltFAWf9dvBypaj17IHVnt4f+71
 fuBQ==
X-Gm-Message-State: AOJu0Yy27aB/K+KctfKI7YKYyW6kxgDoiGz43qd/twr2jAZW5wxgv1E/
 gR6D9GjAXYKZNrMKuMGJCFpjuYAxrDJaHVQe7Yw=
X-Google-Smtp-Source: AGHT+IF1Ojrl2IyYsz/84g4YWjU8+ikQLoD7mLNtZdFpFRmWCmlEXTsgd+oesNBQPzJHjvSF2faQWg==
X-Received: by 2002:a05:600c:2a8d:b0:40c:3308:3afd with SMTP id
 x13-20020a05600c2a8d00b0040c33083afdmr3042997wmd.12.1702398789402; 
 Tue, 12 Dec 2023 08:33:09 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 fc17-20020a05600c525100b0040c42681fcesm10272057wmb.15.2023.12.12.08.33.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:33:09 -0800 (PST)
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
Subject: [PATCH 29/33] hw/arm/xilinx_zynq: Let the A9MPcore create/wire the
 CPU cores
Date: Tue, 12 Dec 2023 17:29:29 +0100
Message-ID: <20231212162935.42910-30-philmd@linaro.org>
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

Set the properties on the mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 28430dcfba..736e2115a6 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -192,22 +192,6 @@ static void zynq_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    cpu = ARM_CPU(object_new(machine->cpu_type));
-
-    /* By default A9 CPUs have EL3 enabled.  This board does not
-     * currently support EL3 so the CPU EL3 property is disabled before
-     * realization.
-     */
-    if (object_property_find(OBJECT(cpu), "has_el3")) {
-        object_property_set_bool(OBJECT(cpu), "has_el3", false, &error_fatal);
-    }
-
-    object_property_set_int(OBJECT(cpu), "midr", ZYNQ_BOARD_MIDR,
-                            &error_fatal);
-    object_property_set_int(OBJECT(cpu), "reset-cbar", MPCORE_PERIPHBASE,
-                            &error_fatal);
-    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
-
     /* DDR remapped to address zero.  */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
@@ -239,15 +223,19 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
-    qdev_prop_set_uint32(dev, "num-cpu", 1);
+    qdev_prop_set_uint32(dev, "num-cores", 1);
+    qdev_prop_set_string(dev, "cpu-type", machine->cpu_type);
     /*
      * By default A9 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
      * realization.
      */
     qdev_prop_set_bit(dev, "cpu-has-el3", false);
+    qdev_prop_set_uint64(dev, "cpu-reset-cbar", MPCORE_PERIPHBASE);
+    qdev_prop_set_uint64(dev, "cpu-midr", ZYNQ_BOARD_MIDR);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
+    cpu = CORTEX_MPCORE_PRIV(dev)->cpu[0];
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
-- 
2.41.0


