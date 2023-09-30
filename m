Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC2B7B4075
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 15:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmZxh-0007gf-It; Sat, 30 Sep 2023 09:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxf-0007gD-2F
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:47 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxT-0007ex-Pr
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:46 -0400
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so2075070266b.0
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 06:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696080271; x=1696685071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDXAiy1apzi7aumkLFTgno5yMnJNDUPzaFhQGkdJoG4=;
 b=ZaVPpb2pdyKLr8DWfV/cwT9P9DFZIJUvJMdM5KGO0Z1oVTLfZJgd2lB+nxLNsYoY8O
 iIbbkfrD22iE5CU6WHFqaCbDyk3+EJq6K9iNGy3MFtcWR/87fAnhgefN6qRfYNWhS1kI
 sEcyo/uCoNhtFEasuoiP1xcgAL2KLyw6fNy6eGmNMHcdN6XCj5ATw5QWQ27TjLZfZJOD
 I0LmMdhcXspLTkNkzvdho+sD6KapPeUa084D2nAFEuToxF15HilVfvLcZXj1oc7fnSYc
 jg7H/WQfNxa6qM5uu8Y45xtFI5Oo1u5w5ut8+FyAQpIwNGRd1n4JhrZUjFWh5kumchkv
 aeOA==
X-Gm-Message-State: AOJu0YwNYHaqBRqwV/axaNNw2m11AJiTJe9vnE/bruqNQLkE+VJNDHgM
 cxNRPRT5CvBBepqDlXEZhMFrEdjMzEE=
X-Google-Smtp-Source: AGHT+IG5mdP6Fn8dGDMpiHObyZJJR8Q7C5a339zryfVhxaah2TfRjjPajpXWJha9JHao88j1xulQ5w==
X-Received: by 2002:a17:906:31d7:b0:9b2:b119:4918 with SMTP id
 f23-20020a17090631d700b009b2b1194918mr6271290ejf.13.1696080270532; 
 Sat, 30 Sep 2023 06:24:30 -0700 (PDT)
Received: from fedora.. (ip-109-43-177-123.web.vodafone.de. [109.43.177.123])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170906944f00b00993928e4d1bsm13919471ejx.24.2023.09.30.06.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 06:24:30 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/5] hw/m68k/next-cube: Mirror BIOS to address 0
Date: Sat, 30 Sep 2023 15:23:47 +0200
Message-ID: <20230930132351.30282-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930132351.30282-1-huth@tuxfamily.org>
References: <20230930132351.30282-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.49; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f49.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The ROM is also available at address 0, so add a proper mirror
for this address.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 5d244b3b95..4ab9a5ec98 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -945,6 +945,7 @@ static void next_cube_init(MachineState *machine)
     M68kCPU *cpu;
     CPUM68KState *env;
     MemoryRegion *rom = g_new(MemoryRegion, 1);
+    MemoryRegion *rom2 = g_new(MemoryRegion, 1);
     MemoryRegion *dmamem = g_new(MemoryRegion, 1);
     MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
     MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
@@ -998,9 +999,10 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0200e000);
 
     /* Load ROM here */
-    /* still not sure if the rom should also be mapped at 0x0*/
     memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
     memory_region_add_subregion(sysmem, 0x01000000, rom);
+    memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
+    memory_region_add_subregion(sysmem, 0x0, rom2);
     if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
-- 
2.41.0


