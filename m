Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCC87DEA53
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:44:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeU-0006zf-2D; Wed, 01 Nov 2023 21:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeM-0006Js-Fl
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:35 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeI-0004Iv-An
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:33 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b565722c0eso256826b6e.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889048; x=1699493848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCD7MGoBGBvFUMEqCraVMyK1zfse2SsJ+vuTkGcLU/A=;
 b=pXbvUGGeg02hjluVnLmUvDp630W9vnY7IqPmSawJzk+RKjr+W12p+O2RfsDMmgSdFB
 VTpLAPQ0rHdQb8ljo1QnAGupaPrLH/YoP7LkbD4mYME9QW82rkMUMbqaSGZnf6hs5IHA
 5p5AOIOjIbhPk2sxytaBS7JcfW/zQmQPNjK7OUfXEzV6o1hIoJ4nkVD0BubpDVRV6dhd
 zHOW3J4SmOcWxbB9T8VRVSm0nUV1LQ0gPbKRSQFTwAPVKrOxp9ob72oiwkSbUXAz56lx
 sz0688foefsze5ARitC4DoK/Tg9LHloxOqhmS7jlep5lcukyFiff7yDJ84+9K3PWgksg
 DVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889048; x=1699493848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCD7MGoBGBvFUMEqCraVMyK1zfse2SsJ+vuTkGcLU/A=;
 b=ITlw+cZlaka+eMTH5YSaS49zwvhASukiwIpUccZPhyhMmBxQGSngIhAeuRalzuMv/y
 j6r3r4NgRcJpl5EmUWhqm2wSOHzw6rfpdlDr44TrueHEvj53LWoIZ5ZowfrZKUmPyT/7
 ePxLyp6qLd6nZSVZ9fB25xzY4vrFQFtwmhVYzkaXlM1gms8AoLE4ENGR9wO0c/OEBz40
 xU3CyZEBjCIeYpZmQBPn8ChbvfMXyGa5XwEeudadsURsKVlFhfZ9eeKg9w4SeJUXwz4B
 /F22mtsaeDulDMdYIB3tCZbRczkI4B1d5UyMy/NV9e4b3mjZfQiXA+HLZx4yqxead3mk
 xgnQ==
X-Gm-Message-State: AOJu0YxV6TrpTaxRcUc7WTuRVgHPgkabAmieAUPskYxeaKXAKuiEqvtg
 m+9M8LDwXGYxWkrL70tNNCopTGBMxdKSL7F+qa8=
X-Google-Smtp-Source: AGHT+IGwkU4dMMmIr3YXuINkogNPNpivzrLVw6QY/QAqsTVN0yNWcX8g8DuxRZgxnRwcLAk0YYG5HQ==
X-Received: by 2002:a05:6808:19a5:b0:3a8:f3e7:d691 with SMTP id
 bj37-20020a05680819a500b003a8f3e7d691mr22622485oib.37.1698889048782; 
 Wed, 01 Nov 2023 18:37:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 84/88] hw/pci-host/astro: Map Astro chip into 64-bit I/O
 memory region
Date: Wed,  1 Nov 2023 18:30:12 -0700
Message-Id: <20231102013016.369010-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

From: Helge Deller <deller@gmx.de>

Map Astro into high F-region and add alias for 32-bit OS in low region.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 4b2d7caf2d..df61386bd9 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -19,6 +19,8 @@
 
 #define TYPE_ASTRO_IOMMU_MEMORY_REGION "astro-iommu-memory-region"
 
+#define F_EXTEND(addr) ((addr) | MAKE_64BIT_MASK(32, 32))
+
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
@@ -821,15 +823,16 @@ static void astro_realize(DeviceState *obj, Error **errp)
 
         /* map elroys mmio */
         map_size = LMMIO_DIST_BASE_SIZE / ROPES_PER_IOC;
-        map_addr = (uint32_t) (LMMIO_DIST_BASE_ADDR + rope * map_size);
+        map_addr = F_EXTEND(LMMIO_DIST_BASE_ADDR + rope * map_size);
         memory_region_init_alias(&elroy->pci_mmio_alias, OBJECT(elroy),
                                  "pci-mmio-alias",
-                                 &elroy->pci_mmio, map_addr, map_size);
+                                 &elroy->pci_mmio, (uint32_t) map_addr, map_size);
         memory_region_add_subregion(get_system_memory(), map_addr,
                                  &elroy->pci_mmio_alias);
 
+        /* map elroys io */
         map_size = IOS_DIST_BASE_SIZE / ROPES_PER_IOC;
-        map_addr = (uint32_t) (IOS_DIST_BASE_ADDR + rope * map_size);
+        map_addr = F_EXTEND(IOS_DIST_BASE_ADDR + rope * map_size);
         memory_region_add_subregion(get_system_memory(), map_addr,
                                  &elroy->pci_io);
 
-- 
2.34.1


