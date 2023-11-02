Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A67DEF78
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaR-0001pY-NX; Thu, 02 Nov 2023 06:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaQ-0001ov-8a
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:02 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaO-0003Ih-KP
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:02 -0400
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-9d2d8343dc4so114036766b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919559; x=1699524359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgU3A7Uj0T7+lZtLblFEbvia9EIUhglbB47huGk+KSs=;
 b=TpK2pJvfaBQJEKcNxXRJ3cpWzb2Zr4dDet/bsxwzwgMz94P/OxtFoIC7Zc/Gf7BwrW
 ARD1dZgGNA0xjptmOjN5WBM3s6gb9noVwWzDrjrKlcq1+UWINJ4HYzSXnqWia7QNpIgy
 WV6yvOYnWL32C+dvFz1JfxDD6zlyvj4IBZo6FUHyUqmucMVEgjwbAc87PTcFYEXgld0J
 qn2QPQZU/IGshP/vzxv2BdZ6ywg0vbPrQXtE6ImSVzDCXDHdhLrHVUzAiRa8laeIKQWN
 g6paxvczB6XmIQ/18HSAE52jC6h1vnZeMlhFeiQ8/v/7JFxdfSCU3VtlGjrDlra+48Ak
 NnoQ==
X-Gm-Message-State: AOJu0Yxv+rnUKX3YlQS93TtUduN8FLziSFaO4Gmmna5DoviB3C5KWvcW
 9LXg0+3LkDr8REKlrElC2mbZUCdyZaY=
X-Google-Smtp-Source: AGHT+IFba4UZPk+AUXWl1Q68yUinXDKkR844bUSgKsjfxiC5xhfBIyhSlK8zzAf6H8+cIKDW0QmQhw==
X-Received: by 2002:a17:907:3e94:b0:9d0:92b5:8f4b with SMTP id
 hs20-20020a1709073e9400b009d092b58f4bmr4760233ejc.24.1698919559253; 
 Thu, 02 Nov 2023 03:05:59 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:58 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/10] hw/m68k/next-cube: Mirror BIOS to address 0
Date: Thu,  2 Nov 2023 11:05:41 +0100
Message-ID: <20231102100543.4875-9-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20230930132351.30282-2-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d17e6be8e1..2c94c6a9c2 100644
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
@@ -993,9 +994,10 @@ static void next_cube_init(MachineState *machine)
     sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
 
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


