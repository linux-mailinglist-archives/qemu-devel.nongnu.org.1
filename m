Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE207E33A7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CUl-00064Y-26; Mon, 06 Nov 2023 22:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUj-0005y1-3f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:13 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUh-00025E-DK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:12 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5b9a7357553so4043096a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326670; x=1699931470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCD7MGoBGBvFUMEqCraVMyK1zfse2SsJ+vuTkGcLU/A=;
 b=aQZuV2JNvVTvJVCz5CKy+yPJBlDVAX7d6Ko9Gp4YLhk6eX0aH17/4OwHK8D6uHk1aY
 nQOWrqazJqlxQ+/AD7Y4M/Ld/88mwSeIrmgypi9WxTzWlO5fN6fPCYmfKsX8JdU5T4Ct
 OIgBwAn1vLVUNW3A/mPrfb7aniZ4iwWZ68XgA9+LwLKqWZMtPXh/4feQvR26YIynwJXD
 TuRY/S6o34DdIqVcsVoPZgjtOQX3emToImuiPGL5xFKHUYa9h4PBA2I866bKf25LPL79
 bffZNk2dGbABUEaR3dz6i8tmKVfGByD7+UplWOdTxQR12lBcT0Pbz/YTLZ1KSrlmXyuV
 FFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326670; x=1699931470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCD7MGoBGBvFUMEqCraVMyK1zfse2SsJ+vuTkGcLU/A=;
 b=tZJe1er7iXGgViSjeBVSgOlszjCd4zYHfKGb6qjrMLLiI23MP8EKBX1u5AkmjW525u
 Oy7c8phFQXfC9r/AJ1uqbUeMnTb84lpBJMwfyviXnoGEtOgYH7ThKvILgeXoughkJ6tw
 ibH2nICuJRS+oNdlBz8CVAR7K88B7AvC+alartExMPG6OQs/Ylstf4KprGfKAfkSfnu9
 dxMmdVvZu0oCp+3nlQ2qPCok1kcTyjOHO65vEatgDELIbJNhnD/yXWiS+69alJ8yybs5
 kf+JO6i9DQtysuxo+mZRK9i7dxBcFJAbecSsGo0PZyufnSEInlQztgl57EudmtQ2UIOU
 xiLQ==
X-Gm-Message-State: AOJu0Yy94WE5TtTolbrGXzL4ehFNrzhN8GjxYnOuNcnY9tIIzG8/XgKJ
 UIc1W+BjE/nXec1CdvBSgVpHF7BLsmYNsdOypOY=
X-Google-Smtp-Source: AGHT+IFMuuzw15oSJ67Bs2nNC4WGCB82t8C5043skulGpB1FPB9cnFZ2qJ7cYksz2wBs4GW/Y1IapQ==
X-Received: by 2002:a05:6a20:12c4:b0:181:275f:3b4f with SMTP id
 v4-20020a056a2012c400b00181275f3b4fmr18542685pzg.11.1699326669931; 
 Mon, 06 Nov 2023 19:11:09 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gw13-20020a17090b0a4d00b0026f4bb8b2casm6246253pjb.6.2023.11.06.19.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:11:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 82/85] hw/pci-host/astro: Map Astro chip into 64-bit I/O memory
 region
Date: Mon,  6 Nov 2023 19:04:04 -0800
Message-Id: <20231107030407.8979-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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


