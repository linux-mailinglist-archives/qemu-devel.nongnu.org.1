Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7397FEF5C
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 13:43:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8gN6-0002Ty-D9; Thu, 30 Nov 2023 07:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8gMc-0002Sj-3T; Thu, 30 Nov 2023 07:41:54 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8gMX-0004HM-Ob; Thu, 30 Nov 2023 07:41:53 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c625e98380so459545a12.0; 
 Thu, 30 Nov 2023 04:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701348105; x=1701952905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yHCpjJwknX7SIToYCPYMu0q4QV6veLzkFIzvN3Hy64=;
 b=fRpZSLUXN8cPKUNS1Oz0aKob8KJfwwLMSVVKQGapaH6sU2nw88VWwm0pACGIYXuvHS
 qYCTOjGpvi797WHt8Ws4fnShtxxfd8IVJx3DDgKe/ucAeMmJYHUz9rz2RDbFT4MeXuFq
 1f/HWuGBsx/xJAR7UhDXSIlv1ruY2bQZVSYNyIsIpXvSU2t1/5Azt8x7SD54kxu2J7MA
 9FjmxKNGS0W345N1cLzP7q95xxErYTSXCdle1TDVTz3i2SsoPFet1ktcnnTC8qHL57i2
 BbHh+7Jxxl1d+2JKtzSU6OcRkp2LGfXocipDHyiqkJ73AI5USvljVtGLt1EnmN6Z/M87
 vffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701348105; x=1701952905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yHCpjJwknX7SIToYCPYMu0q4QV6veLzkFIzvN3Hy64=;
 b=tiZDGfJzGDOC806LF6I3Au7zfr3N3xSoeM8p0Y3cPdWTxTu+mHmd171yU1zoQVo6Xn
 DAQSmsSYvCGOGcKK61nZDFdgHycWLDjCAb8tbzhu9qOcmHRt42/Zf1KpShQtWdHdk9Eb
 s3SudmF4ZcFMTFplznGsMViExc2BMuY0iYyr6vJs7SNAIARjfm0Lz+mo8FeHr3uQ/nuV
 4lSHkulBJM1ytLGbJ4yRDM9M8cXdKs/tEw3Cfnw4yhyXLuPdLtk70+3I3qJTs71JiEqc
 7VxjQhnwTYaVAr1h1xidrBqAiQG0GQPF7ogY7M7Tp/zpFZuI7X1eJLBBrA+vioX3ZamZ
 wseA==
X-Gm-Message-State: AOJu0YxhOypBoYslKIqP6DX44J0fxlHJIUC1hSN58R80vQ3NKAI7I3yo
 l5FAhWvL5kQtZkwSGER5jO7+e5AS0Vw=
X-Google-Smtp-Source: AGHT+IE1XtuEr/zPPn8X6Qsl9ZXC8up/vKoZ4nuXUhOpsFfsovJij7y3goDrZNwNJOvjSSbaiMeeJA==
X-Received: by 2002:a05:6a20:918e:b0:188:28e:5a75 with SMTP id
 v14-20020a056a20918e00b00188028e5a75mr21998530pzd.5.1701348105198; 
 Thu, 30 Nov 2023 04:41:45 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a17090ac29800b0028593e9eaadsm3149326pjt.31.2023.11.30.04.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 04:41:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 2/2] ppc/amigaone: Allow running AmigaOS without firmware image
Date: Thu, 30 Nov 2023 22:41:11 +1000
Message-ID: <20231130124111.109602-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130124111.109602-1-npiggin@gmail.com>
References: <20231130124111.109602-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The machine uses a modified U-Boot under GPL license but the sources
of it are lost with only a binary available so it cannot be included
in QEMU. Allow running without the firmware image which can be used
when calling a boot loader directly and thus simplifying booting
guests. We need a small routine that AmigaOS calls from ROM which is
added in this case to allow booting AmigaOS without external firmware
image.

Fixes: d9656f860a38 ("hw/ppc: Add emulation of AmigaOne XE board")
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 992a55e632..ddfa09457a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -36,10 +36,19 @@
  * -device VGA,romfile=VGABIOS-lgpl-latest.bin
  * from http://www.nongnu.org/vgabios/ instead.
  */
-#define PROM_FILENAME "u-boot-amigaone.bin"
 #define PROM_ADDR 0xfff00000
 #define PROM_SIZE (512 * KiB)
 
+/* AmigaOS calls this routine from ROM, use this if no firmware loaded */
+static const char dummy_fw[] = {
+    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
+    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
+    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
+    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
+    0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
+    0x4e, 0x80, 0x00, 0x20, /* blr */
+};
+
 static void amigaone_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -60,8 +69,6 @@ static void amigaone_init(MachineState *machine)
     PowerPCCPU *cpu;
     CPUPPCState *env;
     MemoryRegion *rom, *pci_mem, *mr;
-    const char *fwname = machine->firmware ?: PROM_FILENAME;
-    char *filename;
     ssize_t sz;
     PCIBus *pci_bus;
     Object *via;
@@ -94,20 +101,24 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* allocate and load firmware */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
-    if (filename) {
-        rom = g_new(MemoryRegion, 1);
-        memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
-        memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
+    rom = g_new(MemoryRegion, 1);
+    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
+    if (!machine->firmware) {
+        rom_add_blob_fixed("dummy-fw", dummy_fw, sizeof(dummy_fw),
+                           PROM_ADDR + PROM_SIZE - 0x80);
+    } else {
+        g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                                   machine->firmware);
+        if (!filename) {
+            error_report("Could not find firmware '%s'", machine->firmware);
+            exit(1);
+        }
         sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
         if (sz <= 0 || sz > PROM_SIZE) {
             error_report("Could not load firmware '%s'", filename);
             exit(1);
         }
-        g_free(filename);
-    } else if (!qtest_enabled()) {
-        error_report("Could not find firmware '%s'", fwname);
-        exit(1);
     }
 
     /* Articia S */
-- 
2.42.0


