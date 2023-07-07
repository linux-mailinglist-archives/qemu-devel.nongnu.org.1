Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA674AFF8
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiE-0004u6-CU; Fri, 07 Jul 2023 07:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji8-0004dZ-9x; Fri, 07 Jul 2023 07:33:16 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji5-0006s1-7k; Fri, 07 Jul 2023 07:33:16 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b7541d885cso1620303a34.3; 
 Fri, 07 Jul 2023 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729591; x=1691321591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljDc4BuDmlAsSVsIxNbmsHoTz5dyLTcxWBqWPsCQeQw=;
 b=qSGXcbIpy25FozjuPlo1BT9av3TuvTz3m5fLSiFsR4bS32ldRalyrTlC3y4uFtXOuO
 R9yPqbA3O/UHjFIB6R8r1f1JcIr9l2HtKjgJqsFP7BetsHwS101hCClZkKBvwzLTnqui
 P88pt+QJ5PlPFXHiNHjUPwkIdCFq/y33Sdsenqp0xcBLOyu3/8hgct/gD/zDwaa20N5E
 3XISzIiowV5eA1JzK/9zvqvB2pQiDP153s0VpKLabLyLTOprOnwMNRAG5zEUR7f3+Mfb
 BMFni1pd7HtUE1Vi91YtD2atB0Xy30KSeK6e+xutL5v+OeBbfzYxedOSN5ee4BbwrOMw
 6pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729591; x=1691321591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljDc4BuDmlAsSVsIxNbmsHoTz5dyLTcxWBqWPsCQeQw=;
 b=E6fKARsaOyAeymi3h84H9ZVBc3SaP4a+KLI2wu0cA51p8L59e3e/lAcqi2zQZjdDkV
 9GbQXWht6+Yf5tRRvbVbOCGam27ERIxFtd+7DJzzv/CaeKf4IrbMyZ6PXL3rAmJL1u1v
 YQ7jlA2SzORqqLDoX2loE/dVD+rOkVx3E2+IrfeUclwtRVKlX9a1JbIjZ2V8czFS1etW
 oSFpFQ3yLQhWIrwKMfAybwTGZBmESgEYhbHIRJ/O17j7kwrv4KYSqP42F1gDaWVbSyRB
 knoCvHggYtUlE4hB2MFJ5U00sh3/6sP59mCPXVpdtBANih+VOln0AixwNqYVfRMv2BYi
 +EdQ==
X-Gm-Message-State: ABy/qLZhI4LgLwUKfpwwGdHFMSBeGk8b3p9a6HgErzORQyiMrQD63wvO
 UXcsFCI88f/w576rxFRxM1+X5SIpcLw=
X-Google-Smtp-Source: APBJJlFdswCl6uoHBxMdsXLqcSqI7070zg7QM8NpzOxxNCvJ546KOUUc/rnQeTUjke2y/5/jQ5i3YQ==
X-Received: by 2002:a9d:751a:0:b0:6b7:45de:d533 with SMTP id
 r26-20020a9d751a000000b006b745ded533mr4383628otk.9.1688729591609; 
 Fri, 07 Jul 2023 04:33:11 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:11 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 43/60] ppc/sam460ex: Remove address_space_mem local variable
Date: Fri,  7 Jul 2023 08:30:51 -0300
Message-ID: <20230707113108.7145-44-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Some places already use  get_system_memory() directly so replace the
remaining uses and drop the local variable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <d134d64f13258d1f157b445fedb1e86cf3abb606.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/sam460ex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1bb23bb18b..d446cfc37b 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -269,7 +269,6 @@ static void main_cpu_reset(void *opaque)
 
 static void sam460ex_init(MachineState *machine)
 {
-    MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *l2cache_ram = g_new(MemoryRegion, 1);
     DeviceState *uic[4];
@@ -409,7 +408,8 @@ static void sam460ex_init(MachineState *machine)
     /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
     memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram", 256 * KiB,
                            &error_abort);
-    memory_region_add_subregion(address_space_mem, 0x400000000LL, l2cache_ram);
+    memory_region_add_subregion(get_system_memory(), 0x400000000LL,
+                                l2cache_ram);
 
     /* USB */
     sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400,
@@ -459,13 +459,13 @@ static void sam460ex_init(MachineState *machine)
     /* SoC has 4 UARTs
      * but board has only one wired and two are present in fdt */
     if (serial_hd(0) != NULL) {
-        serial_mm_init(address_space_mem, 0x4ef600300, 0,
+        serial_mm_init(get_system_memory(), 0x4ef600300, 0,
                        qdev_get_gpio_in(uic[1], 1),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
     if (serial_hd(1) != NULL) {
-        serial_mm_init(address_space_mem, 0x4ef600400, 0,
+        serial_mm_init(get_system_memory(), 0x4ef600400, 0,
                        qdev_get_gpio_in(uic[0], 1),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
-- 
2.41.0


