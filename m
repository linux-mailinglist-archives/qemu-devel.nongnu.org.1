Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0674B003
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiQ-00069K-Mf; Fri, 07 Jul 2023 07:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiP-000651-1e; Fri, 07 Jul 2023 07:33:33 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiK-0006vl-9f; Fri, 07 Jul 2023 07:33:32 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b91ad1f9c1so301779a34.3; 
 Fri, 07 Jul 2023 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729606; x=1691321606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bmFh0f21cuWSLdvSzklWRjoB0aaNjNHJ+yUu807r2k=;
 b=fre3ajtf/xJNqG4NBQ2cpHHk+hMywLnyg6MoUmgDlX2TybcIBIqKIcE3zcTHwKcKDC
 08IAXyCMGUV0DbbngFRcSycNFTjNWv0EenK6+XrTSC8XP9VaqL0Bxfyre4PhhoDSq+ZA
 8fNChm9gXEFTkhefdfDegx2nRcntLslSVxeobjOJw5pdchY3/MTHJEnpz7i8T+4SZ3Gt
 7o5ICynDagj5kZ9XaM+FYqTS8uGwiZH9/1fLMDQr4lQ+7KKyTxKRb53jz0u98A+CFr/D
 qyBshK9njk52IxjjfMMBaiQjwaA44oV2Rk4CxHSTVtfpa1JPXPpL2SglHTOrgjG1b2op
 jkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729606; x=1691321606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bmFh0f21cuWSLdvSzklWRjoB0aaNjNHJ+yUu807r2k=;
 b=gsW7KH8gQIZOBN4zBA+Y7w1YNaGepXVroWfZ5QUCNw/Z3wjNLqHcex1lTNDRHI1bkS
 jpjgZQPGbnj0bYd07ycci4eK+AmWyg+SfB8X7hmMz1+BNGlbxDNO1O0hYIg+mA2+UrfA
 ROcNNZMB4sEgpWzW/JyksNBQz+TkzO42w2uE5CBpyUOVJYdHtD7qpnsOKARV71T6S+VC
 hhK0e4ZXEC1dlvpgMzBj22bBJ7dmwa8ylUGNtL0M04zmzlkT3LzqYs5QKv8IlpYrWFpq
 MWtsBAjiRWkfm3zoo8cGwqzEzxRUkNsnavL5HcO46H20Z1dlGHkxcJpeG4q93LE/wtZt
 d0oQ==
X-Gm-Message-State: ABy/qLZ+FrrWcVE0goZayBS49sgMW1DLqi4RHU2u2zp8ZT28+fiWvDBp
 cavrcGDknkzTKNm6drV+s1wFczC2vnY=
X-Google-Smtp-Source: APBJJlGe+p6FZaRF/w/sWRoBHg6TI58VtkmPmJZf4EngBB4bEjJtElClL+Ik45xh/+7o0BxtJq9KhA==
X-Received: by 2002:a9d:5e09:0:b0:6b8:6c43:12ac with SMTP id
 d9-20020a9d5e09000000b006b86c4312acmr4651259oti.25.1688729606115; 
 Fri, 07 Jul 2023 04:33:26 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:25 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/60] ppc/pnv: Log all unimp warnings with similar message
Date: Fri,  7 Jul 2023 08:30:57 -0300
Message-ID: <20230707113108.7145-50-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Add the function name so there's an indication as to where the message
is coming from. Change all prints to use the offset instead of the
address.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230706024528.40065-1-joel@jms.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_core.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8a72171ce0..a59f3f303d 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -85,8 +85,8 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
         val = 0x24f000000000000ull;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
     }
 
     return val;
@@ -95,8 +95,10 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
 static void pnv_core_power8_xscom_write(void *opaque, hwaddr addr, uint64_t val,
                                         unsigned int width)
 {
-    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+    uint32_t offset = addr >> 3;
+
+    qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                  offset);
 }
 
 static const MemoryRegionOps pnv_core_power8_xscom_ops = {
@@ -140,8 +142,8 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
     }
 
     return val;
@@ -157,8 +159,8 @@ static void pnv_core_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
     case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
-                      addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                      offset);
     }
 }
 
@@ -189,8 +191,8 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
     }
 
     return val;
@@ -203,8 +205,8 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
 
     switch (offset) {
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
-                      addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                      offset);
     }
 }
 
@@ -419,7 +421,7 @@ static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
     }
 
@@ -436,7 +438,7 @@ static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
     case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                   offset);
     }
 }
@@ -463,7 +465,7 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
 
     switch (offset) {
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
     }
 
@@ -477,7 +479,7 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
 
     switch (offset) {
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
     }
 }
-- 
2.41.0


