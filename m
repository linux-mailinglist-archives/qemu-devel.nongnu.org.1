Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F17D4A17
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCoJ-0001en-P1; Tue, 24 Oct 2023 04:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCoG-0001eF-LW
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:44 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCoE-0001Bk-Tp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:44 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso6626579e87.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698136241; x=1698741041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlPzf4Ab5QFLnbSPHtWGOn/3d8rqF62sEucKv3iijfs=;
 b=Lf52840PvQDuGWRF/of9bSUajlk4h+l9NZiQr8szwmL+g35GA9CUXyWAyUpPaQ6rEC
 6yV9WP631G2iuCzF4lSPlEbKQFY86606MZLB7mY5cR4yLFF47vwhBHuWSv4jYYksGrPN
 QD5o5h9m4Eay2hvG4/HCSoVNwjCtjHL5g9DKPEJqMuplCnTlQRxHOMj/uv47JkEFtz/L
 w8Mc63NgppMiJMT8BotQ3uQSN1/Pqk8wQMwQ9e3DKsBr1ZajhOOOj8CIhmzSbvg6y0W2
 jQWWMFZlCZ85DHNoVmCuiPdwIfkwaISXWgN0+jCiIqRwwXS923mwV+TZ0S8uNbMpWI5Z
 4LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136241; x=1698741041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZlPzf4Ab5QFLnbSPHtWGOn/3d8rqF62sEucKv3iijfs=;
 b=BjvwYJVa+aRAm/cWPUEfToR+4QBVR1OxR5ARd1dT0DjzJM8J4rSMSSGowEhvBwv32s
 9isgQOlEGiqymg0I/pWqW0uRAFD0cnoNnJpbAeZd52Ai4X8E3cpmhUYE5m6f/qZMyGeR
 DxKz8A11pEHhArmH8/yKVe0+r2xKlfY2JPy+Vq8m4m+m7yhz0Brvii/bU4pIWQgFnO5u
 17VBlh1auWJ0GM8JOyqC0YC3Ae1qWEssSpI3P8AS/wlzWYlx/clxmSTkDhUtqY3RwKKs
 CS8NoTGgz3Lszh9lzSMMSb0URV4JNIMHyUcpAaNxMe95hWLlwi9GwRzyColFHjOVBGF2
 F/Ag==
X-Gm-Message-State: AOJu0YzImUkaaQIo/tx/V2l13F5eGuHCUjCmvp3WLxzvoarYZVbn43Y8
 zIyIPMm0fzj7il5+q6hQ5Y0S1zSlzj45NShLxJM=
X-Google-Smtp-Source: AGHT+IGZgs/c0k+6qxQNR9uA0EfRXnlgtCEp089IEH9+EDcFy5KQYW88ru9Pm/b9VAN3zoqK2VHakQ==
X-Received: by 2002:ac2:5f54:0:b0:507:9b93:274b with SMTP id
 20-20020ac25f54000000b005079b93274bmr7675505lfz.26.1698136241029; 
 Tue, 24 Oct 2023 01:30:41 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 k12-20020a5d518c000000b0031f82743e25sm9383775wrv.67.2023.10.24.01.30.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 01:30:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/6] hw/m68k/next-cube: Do not open-code
 sysbus_create_simple()
Date: Tue, 24 Oct 2023 10:30:08 +0200
Message-ID: <20231024083010.12453-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024083010.12453-1-philmd@linaro.org>
References: <20231024083010.12453-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Mechanical change using the following coccinelle script:

  @@
  identifier dev;
  identifier sbd;
  expression qom_type;
  expression addr;
  @@
  -    dev = qdev_new(qom_type);
  -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
  -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
  +    dev = sysbus_create_simple(qom_type, addr, NULL);

then manually removing the 'dev' variable to avoid:

  error: variable 'dev' set but not used [-Werror,-Wunused-but-set-variable]

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 5d244b3b95..d17e6be8e1 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -950,7 +950,6 @@ static void next_cube_init(MachineState *machine)
     MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
     MemoryRegion *sysmem = get_system_memory();
     const char *bios_name = machine->firmware ?: ROM_FILE;
-    DeviceState *dev;
     DeviceState *pcdev;
 
     /* Initialize the cpu core */
@@ -974,9 +973,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
 
     /* Framebuffer */
-    dev = qdev_new(TYPE_NEXTFB);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0B000000);
+    sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
 
     /* MMIO */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02000000);
@@ -993,9 +990,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0x820c0000, bmapm2);
 
     /* KBD */
-    dev = qdev_new(TYPE_NEXTKBD);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0200e000);
+    sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
     /* still not sure if the rom should also be mapped at 0x0*/
-- 
2.41.0


