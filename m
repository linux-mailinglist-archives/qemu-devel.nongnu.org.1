Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEBC74B041
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhN-0002e9-CO; Fri, 07 Jul 2023 07:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhI-0002S7-F2; Fri, 07 Jul 2023 07:32:25 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhF-0006fs-QN; Fri, 07 Jul 2023 07:32:24 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-564e4656fecso1259200eaf.0; 
 Fri, 07 Jul 2023 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729539; x=1691321539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htaj5B2WTI1042uoWHK1v967XzBIlJ+oSgZpDScfAVU=;
 b=j3hTrCSZVtxL8SVofIzXTvhoplhK524wsWFqoX6lw3IQfPIsVJZX9ZOFba9fz6PhHs
 ngWWREXcfkRQoSmjmD2IWdgGwhtevbXQ0ubL/Mtw5sp22pwhSYLGqfGfcRBpKaXNO07z
 1/9r+iy2NU710hTlbfYtBqdQdSqVhpG0QnmhhCFI8nfTOMuX8j5M5ehNLe0ZjNMxpeQl
 cCxPc7ykvwp5tlX0pd/M/7fC906RQBwl1ChuUq6ToGuwKufwMVmwnuhziWt9buGXjOxI
 xGfZ37oqclb7zGfHEnqZn0t0Zb1k0qzxkoSNNokml5J8StNTkR/8sIYJXQCtrTGZfMOf
 0Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729539; x=1691321539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htaj5B2WTI1042uoWHK1v967XzBIlJ+oSgZpDScfAVU=;
 b=HAO0pKkD9sWTWlFzaQhPYT5vX51qD3DCOat0LLWZ28HGteCPNx2k8/GHyO5NQeGFIW
 L9gJXE6roLoC+KJBJER4ITs3tN8aZfQRgDA91SLTFaNqrj8BlIIFEAhbXfVym/qALaRI
 t80XoUGPeLPv2pp/GMejKtIjOSl2RRM3fheLvdlbI50Lj6NXf2QqT3/ByiPZjBMzEVGr
 I31h2jQtsr/su/2ylBNFYNy5f6fWTYddrvVjUTdrfw6nkVG6j5lH4jla6U/zY33fYrk6
 lnTos0vwzsEfPXliJfBBJg6rP0RAyGzspkEAtoIxdB7dRAUt1qnebSYoLvu2wQnOAJJf
 GUew==
X-Gm-Message-State: ABy/qLbVx8YRyWSrPvaTUlPXRykpO0y19C//WgS6VIiKK3wfd06zgSjT
 0mxsMMoHP41NQ2sfBYxG6sYdCT3Q2Bw=
X-Google-Smtp-Source: APBJJlFoE+Yi9tKJszLXvH7zWPxz2DKEBVc9772LvWoyD1QFVXL7sd/ZHtL5LEThLF3Dve61obOEEA==
X-Received: by 2002:a4a:4992:0:b0:565:84b0:845d with SMTP id
 z140-20020a4a4992000000b0056584b0845dmr3304638ooa.6.1688729539309; 
 Fri, 07 Jul 2023 04:32:19 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:19 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 22/60] ppc/pnv: quad xscom callbacks are P9 specific
Date: Fri,  7 Jul 2023 08:30:30 -0300
Message-ID: <20230707113108.7145-23-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc32.google.com
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

From: Joel Stanley <joel@jms.id.au>

Rename the functions to include P9 in the name in preparation for adding
P10 versions.

Correct the unimp read message while we're changing the function.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230704054204.168547-2-joel@jms.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 0bc3ad41c8..0f451b3b6e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -360,8 +360,8 @@ DEFINE_TYPES(pnv_core_infos)
 
 #define P9X_EX_NCU_SPEC_BAR                     0x11010
 
-static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
-                                    unsigned int width)
+static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned int width)
 {
     uint32_t offset = addr >> 3;
     uint64_t val = -1;
@@ -372,15 +372,15 @@ static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
                       offset);
     }
 
     return val;
 }
 
-static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
-                                 unsigned int width)
+static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned int width)
 {
     uint32_t offset = addr >> 3;
 
@@ -394,9 +394,9 @@ static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
     }
 }
 
-static const MemoryRegionOps pnv_quad_xscom_ops = {
-    .read = pnv_quad_xscom_read,
-    .write = pnv_quad_xscom_write,
+static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
+    .read = pnv_quad_power9_xscom_read,
+    .write = pnv_quad_power9_xscom_write,
     .valid.min_access_size = 8,
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
@@ -410,7 +410,8 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
     char name[32];
 
     snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
-    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev), &pnv_quad_xscom_ops,
+    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
+                          &pnv_quad_power9_xscom_ops,
                           eq, name, PNV9_XSCOM_EQ_SIZE);
 }
 
-- 
2.41.0


