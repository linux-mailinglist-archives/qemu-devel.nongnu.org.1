Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DEA0AC6B
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Jan 2025 23:57:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6su-0007FB-NR; Sun, 12 Jan 2025 17:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sl-00079M-O4
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:36 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sj-0001Zp-TF
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:35 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso25582185e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736722591; x=1737327391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lib4OrNK5VdPwlvzVttsZjjREbL5pGt5xtvhCA9WJB4=;
 b=CvOQrVWzES5wzN1HzTU28ab3Q4Fsl2GBuwpVwxT3HC/4FzJQxg8R1jBkLp8uYRvRBG
 JrI+2DG8UbXtAyzGaiGXuHjhkwdU2gMlt/afP57jjuewjFqoUFQpq5qeL9XQDkh7F9I0
 ba1glyYve0tAsiCxfxTCtLltZAortHbQIviTUjtrM5gnXjwRuW3/PixADzivrZOa/7Tr
 BXnBai3jMtE8d/b/TGvzmcN9xYqRUFpKjpNTjy5p3+Qg9EEMhz1EGehtze/GRt+k+B0z
 Aibcclf8vAaLXi9GRm5+Jat0yeSIb0UgdyT5gX+PFZknUm79M+2kb2DQHNa9XnsV3Nm5
 HyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736722591; x=1737327391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lib4OrNK5VdPwlvzVttsZjjREbL5pGt5xtvhCA9WJB4=;
 b=wzsdXFHz3PXLXNNYITle+K59TexueUSbVS8Oee2+frHyw2Z9qBKjcQwbfNMVXl02x0
 DDmYMoo9r4vnpqJ6oMSqACJoduyWyI33faKB5iGElC215IScQBMaRquJRvfeSGfapTH+
 w8StsTBGRIq7G5TPVaKCK+f347DaEo/2lmkH7PfGmuuTxK16yYDJKo3iLDndRWhiA/AM
 QiWNoGogDYg91CRBk3LSGcPIHfG1JmjHEExmA+i/dIE5W8it+Ufo2Oqg/qlfua5VWKBN
 uAmWuSHWB2gPGuXVesxZwHoGOUwDPRTJTlgGedltxDC6TLeZ+W+20bS4iCHE1PmPIQJo
 todQ==
X-Gm-Message-State: AOJu0Yza/7aQlKZHfA0fONjX16e0j9EPzrgZPVC3rJBOq2s9mGwEmCge
 dlhwme2+iMpSSKznZUHvuCyyrhd9C09x0jIbnnbFoB0fvKi6rNDWE3+kRFD/I8SeGGmpJj0Ko3Y
 /Tsk=
X-Gm-Gg: ASbGncu3JK+l7DSFiAu+tsKSIt3v4hI2Nx9HxbOTlpLfhGD9fBhscPPQ0UHUlLUq6G4
 HcFYimQ1zsP0q6Gr8zpIWqlWCOrvNdhwcxSt+4BYWbK5tHWJjw0IMtJtyzL1W+K4NGjlosga1FN
 CKQLJpWtjdBH7/oYPBJ/6o2CPpzZ744T6a08NW7dEZc2hApJz3T+AKNgg1UxPajkaOjqN5IqWOv
 a3XapvpU0TvwkDDFuKpoQJSCQ8YeM+kilW8sgyfdHs1O96/x4vmmW3IxDTrAd+YcKDHSRaugEDC
 PjkX6Dsji3mtTiHZw/+LER6lzJ/INgI=
X-Google-Smtp-Source: AGHT+IF1rzYv68giexpTGKmCXKEtlNrhmigsKGj/sk2J1RBawMBpxyNd+JR+AUWO6UJxYEmkiXws1A==
X-Received: by 2002:a05:6000:18a7:b0:385:f220:f798 with SMTP id
 ffacd0b85a97d-38a872c93eemr13904757f8f.6.1736722591081; 
 Sun, 12 Jan 2025 14:56:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm10819644f8f.97.2025.01.12.14.56.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:56:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/arm/v7m: Remove use of &first_cpu in machine_init()
Date: Sun, 12 Jan 2025 23:56:14 +0100
Message-ID: <20250112225614.33723-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112225614.33723-1-philmd@linaro.org>
References: <20250112225614.33723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When instanciating the machine model, the machine_init()
implementations usually create the CPUs, so have access
to its first CPU. Use that rather then the &first_cpu
global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/b-l475e-iot01a.c    | 2 +-
 hw/arm/microbit.c          | 2 +-
 hw/arm/mps2-tz.c           | 2 +-
 hw/arm/mps2.c              | 2 +-
 hw/arm/msf2-som.c          | 2 +-
 hw/arm/musca.c             | 2 +-
 hw/arm/netduino2.c         | 2 +-
 hw/arm/netduinoplus2.c     | 2 +-
 hw/arm/olimex-stm32-h405.c | 2 +-
 hw/arm/stellaris.c         | 2 +-
 hw/arm/stm32vldiscovery.c  | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 5002a40f06d..c9a5209216c 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -82,7 +82,7 @@ static void bl475e_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     sc = STM32L4X5_SOC_GET_CLASS(&s->soc);
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0,
+    armv7m_load_kernel(s->soc.armv7m.cpu, machine->kernel_filename, 0,
                        sc->flash_size);
 
     if (object_class_by_name(TYPE_DM163)) {
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 374fbcb3618..3f56fb45ce1 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -56,7 +56,7 @@ static void microbit_init(MachineState *machine)
     memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI_BASE,
                                         mr, -1);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(s->nrf51.armv7m.cpu, machine->kernel_filename,
                        0, s->nrf51.flash_size);
 }
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 0136e419bfd..d3a9f1b03ac 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1211,7 +1211,7 @@ static void mps2tz_common_init(MachineState *machine)
                                     mms->remap_irq);
     }
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(mms->iotkit.armv7m[0].cpu, machine->kernel_filename,
                        0, boot_ram_size(mms));
 }
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index efb3500742f..56b2af40f1d 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -460,7 +460,7 @@ static void mps2_common_init(MachineState *machine)
                  qdev_get_gpio_in(armv7m,
                                   mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(mms->armv7m.cpu, machine->kernel_filename,
                        0, 0x400000);
 }
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 5c415abe852..9b20f1e2c98 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -92,7 +92,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(soc->armv7m.cpu, machine->kernel_filename,
                        0, soc->envm_size);
 }
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 3c3b534cb72..e9c092abc3d 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -590,7 +590,7 @@ static void musca_init(MachineState *machine)
                                                      "cfg_sec_resp", 0));
     }
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(mms->sse.armv7m[0].cpu, machine->kernel_filename,
                        0, 0x2000000);
 }
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 8b1a9a24379..df793c77fe1 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -48,7 +48,7 @@ static void netduino2_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(STM32F205_SOC(dev)->armv7m.cpu, machine->kernel_filename,
                        0, FLASH_SIZE);
 }
 
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index bccd1003549..81b6334cf72 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -48,7 +48,7 @@ static void netduinoplus2_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu),
+    armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
                        0, FLASH_SIZE);
 }
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 4ad7b043be0..1f15620f9fd 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -51,7 +51,7 @@ static void olimex_stm32_h405_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu),
+    armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
                        0, FLASH_SIZE);
 }
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 7303e096ef7..284980ad4b5 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1366,7 +1366,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
     create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, 0, flash_size);
+    armv7m_load_kernel(ARMV7M(armv7m)->cpu, ms->kernel_filename, 0, flash_size);
 }
 
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index cc419351605..e6c1f5b8d7d 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -51,7 +51,7 @@ static void stm32vldiscovery_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu),
+    armv7m_load_kernel(STM32F100_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
                        0, FLASH_SIZE);
 }
-- 
2.47.1


