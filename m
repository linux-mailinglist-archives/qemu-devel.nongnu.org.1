Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD4B74B03C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:48:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiP-00067g-R0; Fri, 07 Jul 2023 07:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiN-0005uv-8V; Fri, 07 Jul 2023 07:33:31 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiL-0006vu-QE; Fri, 07 Jul 2023 07:33:31 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b73b839025so1664481a34.1; 
 Fri, 07 Jul 2023 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729608; x=1691321608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qApXnEBC5dt2c8I7XwLAAfv6RS6GEpkDBYc7SVGxcjo=;
 b=HrvzaxWet9fjNDhKogw7BVVdaI6kBgELchAd5S2wDh4KqLoPoeuYYvsmftMB0vYGkS
 Qm3bWXWQw8PpWunI5hNGRRpQSW/QDCBeKhG3Ni7ERjggVxN9DgOg2d3l/4WkL/CxJbdV
 D8OEB4U1mDeOc0rIKUVvprcmouczeMhv8g+kDNZ9F0bH1WKqBO5sLSSsi7K0BuHX2WEF
 TQXLh/474hczvOkxGVk3dRAYRWu4za3Fd0T6flpgBbA/h9sxUjv+gpnlkg1dJu9+xFEZ
 RKufF9hG6BQB5AkElWUzY5qOS38DFCAIAGo9ZUj7s5HH2zXq4c7P8kUjKPiwcpFsAEq0
 LOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729608; x=1691321608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qApXnEBC5dt2c8I7XwLAAfv6RS6GEpkDBYc7SVGxcjo=;
 b=JYGbD8wdRe/dJRmcZDenxf+z33MhpkYBKYPEqb70+1sPSj+WQp5vNCWDR/dZ7uATev
 NOx5hesdIMKOb3gTHsd+d+sCZXERfX7B3lQSRabZraj15aUhn2RPQkq67oQ0NKoLZfzr
 9KW+MY44m+Eq++KmRSVC9OlCcI7lvP2oAlcUtSsqrovqDjrgJAv4UpYQQ/hsgz90WNfh
 Q7GYCgaWMmWuJPOjjsGeHkvKJ5KUYB34bLphHYQ/np7M069ufT58UR9FWOvUPQ/ps3Mh
 wvdeAiJzIkp6e2kXlvY3AjTJOXYHkt80lM3+rhziClIyIztGik4G8X2YxR417JJmrkcj
 wgTA==
X-Gm-Message-State: ABy/qLavOASM4kUsyHtper9cz6HvW4LIh17nRARU1J6BejF9JgMqdgr8
 uFYrivswnIlJXqLiNCBXsIRQGitHbms=
X-Google-Smtp-Source: APBJJlEvF1bAQ/0V8rwmavCI1UET/vlci4qhGjoQ8UPEM9IxTUst9utSPcSsUdiOnLVHws+x6Fi6Vg==
X-Received: by 2002:a05:6830:3b04:b0:6b5:6b95:5876 with SMTP id
 dk4-20020a0568303b0400b006b56b955876mr5666232otb.25.1688729608434; 
 Fri, 07 Jul 2023 04:33:28 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:28 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 50/60] ppc/pnv: Set P10 core xscom region size to match hardware
Date: Fri,  7 Jul 2023 08:30:58 -0300
Message-ID: <20230707113108.7145-51-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x333.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

The P10 core xscom memory regions overlap because the size is wrong.
The P10 core+L2 xscom region size is allocated as 0x1000 (with some
unused ranges). "EC" is used as a closer match, as "EX" includes L3
which has a disjoint xscom range that would require a different
region if it were implemented.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230706053923.115003-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_core.c          | 6 ++++--
 include/hw/ppc/pnv_core.h  | 1 +
 include/hw/ppc/pnv_xscom.h | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a59f3f303d..9e7cf341dc 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -298,9 +298,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     }
 
     snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
-    /* TODO: check PNV_XSCOM_EX_SIZE for p10 */
     pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
-                          pc, name, PNV_XSCOM_EX_SIZE);
+                          pc, name, pcc->xscom_size);
 
     qemu_register_reset(pnv_core_reset, pc);
     return;
@@ -352,6 +351,7 @@ static void pnv_core_power8_class_init(ObjectClass *oc, void *data)
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
     pcc->xscom_ops = &pnv_core_power8_xscom_ops;
+    pcc->xscom_size = PNV_XSCOM_EX_SIZE;
 }
 
 static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
@@ -359,6 +359,7 @@ static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
     pcc->xscom_ops = &pnv_core_power9_xscom_ops;
+    pcc->xscom_size = PNV_XSCOM_EX_SIZE;
 }
 
 static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
@@ -366,6 +367,7 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
     pcc->xscom_ops = &pnv_core_power10_xscom_ops;
+    pcc->xscom_size = PNV10_XSCOM_EC_SIZE;
 }
 
 static void pnv_core_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 77ef00f47a..aa5ca281fc 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -46,6 +46,7 @@ struct PnvCoreClass {
     DeviceClass parent_class;
 
     const MemoryRegionOps *xscom_ops;
+    uint64_t xscom_size;
 };
 
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f7da9a1dc6..a4c9d95dc5 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -133,7 +133,7 @@ struct PnvXScomInterfaceClass {
 
 #define PNV10_XSCOM_EC_BASE(core) \
     ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
-#define PNV10_XSCOM_EC_SIZE        0x100000
+#define PNV10_XSCOM_EC_SIZE        0x1000
 
 #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
-- 
2.41.0


