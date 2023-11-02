Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F377DEF81
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:08:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaQ-0001p5-U7; Thu, 02 Nov 2023 06:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaO-0001oX-Io
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:00 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaL-0003I3-TS
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:00 -0400
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso105642966b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919556; x=1699524356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bf2kNhCkpvCEnz1DEQWyTqLO5YTEMKoovu/EJ+x2rmc=;
 b=Y9RynoZSUVQ6ASsscJjUzgIzB6D/qzpmfoBpvGSXSG7jneptT3cSyM7rxbd9/b9JQD
 4IvAXFfj02PM84jWiZbEHGk7uhlO9e/q5BErsjQrguIdPxJ7E2adTIvIUhRJAK5r3nn/
 v/ISodVEqaTqTzRHYUQQhYK86x8XRKpWtgnlKVMVEiFhLgpNWwuGgHstTHcvoG3CCZiq
 /3tbeYJUZMIO8ML7tje3LsP7UfgJ9255FKiMT2I6SqyKrBV6X54ntGAVAaQYFNloQCM+
 OCSsguSO5lHhRATZj0QJimJmW/cMIKDZU81shn4IEVIn22eC4Qp3VXNrIGPOVjGUdzww
 +7yg==
X-Gm-Message-State: AOJu0YymyL9RoyrC6efREhfW7MkL/MRQUDuKn07ZWhaP75V3hBddNXUw
 RLRSQhtt3zUF5m1e6mmh3vjaebvsrUE=
X-Google-Smtp-Source: AGHT+IEPlrjzTbQ8vZlqAXFuIn/8U7QM/F/S75Qf/p9yJ4NbvJad4S+0PDB9fApsVOlhgm8J3eBvQg==
X-Received: by 2002:a17:907:97d6:b0:9bf:77ae:3aa9 with SMTP id
 js22-20020a17090797d600b009bf77ae3aa9mr3773951ejc.24.1698919555867; 
 Thu, 02 Nov 2023 03:05:55 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:55 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/10] hw/m68k/next-cube: Do not open-code
 sysbus_create_simple()
Date: Thu,  2 Nov 2023 11:05:38 +0100
Message-ID: <20231102100543.4875-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.52; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f52.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-ID: <20231024083010.12453-6-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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


