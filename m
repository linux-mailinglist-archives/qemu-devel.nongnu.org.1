Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B77D123E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr5i-0006Rf-Hu; Fri, 20 Oct 2023 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5g-0006Jw-0y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:07:08 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5e-0001Os-3v
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:07:07 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so143769966b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814422; x=1698419222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0zvSCA6AYDZV2ErRdt/jshRiMTPrawiKivetLDL0Ao=;
 b=qObmGYqpNx+Y9Yos4/6Gxj3LJLotzanwAGws++IG/gGvx6TFh5+HwSSSk4eRqWNJXH
 xx5b5Iq3pGbJ9kKTOYg8EFHkKxG4N2pq55Cx0iv4ku/IJbK1z1MgiEXRPDnVctMeiApk
 tZFWRGIWBDdAZF9RtsBqWstz2oJkdgM35WMtUzQG8H9eUTc3rKNNmhjzuu/sjXAy3CAP
 x0qUzEwCfq+eJCsCHFnhfM6ziy03erYIDeEC7VQJh9MUf3qtQHSf75Og1ZceCrwwZ+Sk
 53EzLPBsqb9iViaACD5Mib539XM5dGcbBYom5zVVBPyqCTr9rYYz5TcmZ1dM8J8Oup3F
 xyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814422; x=1698419222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0zvSCA6AYDZV2ErRdt/jshRiMTPrawiKivetLDL0Ao=;
 b=j7nGbN8MpcJKaGJ8ISOHI8fZU/AxjrkMe8yyP3yukZ4CXbyFzRm0pV9a8S7JA6i7JR
 Mx92dACHbtwJWCBD7uONoV3BifJCp/b62Wnyp+++9MIpHIQL59ZCQwWekzkts5ub3Ja6
 gnUpp1rrwhP4UKyHRhDoug9Sxr48Dtz8JsQtAuZOlWB30A87Ov9uREtNl3Bs3lnhk8aw
 /TD3d3qHMmb0MM8JV/Lwlp+iSezV+EAZzun2bERDghsb0V/3FI55HsMHYOomSUe9/XBQ
 wU2SIGgyLeKOQUybDHSJVUZ4Tu+6mkti6aQeOkIWHQiBucbpYKzO2cvTGKSKXxzKB2Sz
 W3Tw==
X-Gm-Message-State: AOJu0YxH2vsLwqTt7mD0o6FHypncxiqT595hA4YyMsxI90B9vPrAV9lT
 LGYJbxZiV3cn3VIhL8qN3cZywsmQ/7D8TjbXnww=
X-Google-Smtp-Source: AGHT+IEiseBgxPQUKadqWjRYy8Gxfrp1aC/zyiKLQ1MwIveSKbBVtV5nPXWg+tJiO0oOnPP3uWy5Hg==
X-Received: by 2002:a17:907:6088:b0:9ad:8aac:362b with SMTP id
 ht8-20020a170907608800b009ad8aac362bmr1851341ejc.23.1697814422591; 
 Fri, 20 Oct 2023 08:07:02 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 m10-20020a170906234a00b009b29668fce7sm1646701eja.113.2023.10.20.08.07.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 08:07:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] hw/m68k/next-cube: Do not open-code sysbus_create_simple()
Date: Fri, 20 Oct 2023 17:06:25 +0200
Message-ID: <20231020150627.56893-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020150627.56893-1-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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


