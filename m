Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7A7D03FC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaU9-0007CR-AN; Thu, 19 Oct 2023 17:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaU6-00073y-Id
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaU3-0001gG-JI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so970445e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750589; x=1698355389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1KVZlIcRQGW0XDbXXS/PkAkK9AJc9io1ITINi4/pEc=;
 b=PlyfPiR73/l+jcLWpe2OTLzyWqY4ayVQxyCkR2aPsQCahvDUgqwbQuxQhe0nvSNSaN
 yp+eRb35uJWdzyn4NV0g8VvV2oxdtrV4h1CqKjYy/5dYH4cipUaVJq9nRebKhHUvZg//
 CLBGNOOyZUI8GiRN8d09iJ17FUQX0Wk3GOaTlTyHJDjwRjo7QsnxJHI90uRLERH/TWg/
 6uuYWWc7zoduTeSqDil1pRXYeOtGbh3gh8vP1Tb5Z08nYXTKWMurgSHIGrrrmDSEbbq/
 lAJhIWRPpYJlHjmQg3CSM5dyv04P+Ul/MSZXrZicInrHUGSuPTauS8CqVBMtRtxRPFhm
 t6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750589; x=1698355389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1KVZlIcRQGW0XDbXXS/PkAkK9AJc9io1ITINi4/pEc=;
 b=Kx0jeYZos50CCoM+C7Kn+o95Oz49U08cvTMCKPHKNMpU3BLiOEhWkvIm/LjQXH7hbH
 WgLRzxYHDkKrEzjH4m15bKDr2aiTJUUJ9GD+4BBsUShIEwYdP+Bq7Pc6+4H3gNFOodQ6
 GCLPDP3bCAuxCdutPowWQdrPntVppMPVr1UVfG/9dWyw/9wwXaSjyQYO/5bnjNSuR0EO
 zGqjQHEDmfD5ZL/eveiEy5nEL3EwIWzneLn5FSmcLYVO8IaMwno8zciK+OlJXJ9Kbae5
 e1pjt5XbGhpp3aVDD+q4WlaNR5QQuYVHpO6uPIlhGmIS+l+16uNtTN1+DW1/R0JxEWxn
 JHaQ==
X-Gm-Message-State: AOJu0YyDLCyDCxzTd0zTzpBuqyyUBChUAVSkrJpiWSPdtF/2GO8GE/IM
 INCHKShxquU6oErkMrHUG6Jg+0vVjlvUVcL3gOp+hA==
X-Google-Smtp-Source: AGHT+IGioeDtmL/WKeN5TVON+5Ig9iQ6RDB70m3/3RKX3A8U4BFYfPVLzBmstLLXNP2V/GuCdVXCnw==
X-Received: by 2002:a05:600c:4446:b0:407:7e5f:ffb9 with SMTP id
 v6-20020a05600c444600b004077e5fffb9mr34692wmn.9.1697750589715; 
 Thu, 19 Oct 2023 14:23:09 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b0040775501256sm530184wmq.16.2023.10.19.14.23.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:23:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 44/46] hw/dma: Declare link using static DEFINE_PROP_LINK()
 macro
Date: Thu, 19 Oct 2023 23:18:09 +0200
Message-ID: <20231019211814.30576-45-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Declare link statically using DEFINE_PROP_LINK().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231017140150.44995-6-philmd@linaro.org>
---
 hw/dma/xilinx_axidma.c |  6 ++----
 hw/dma/xlnx-zdma.c     |  7 ++-----
 hw/dma/xlnx_csu_dma.c  | 13 ++++---------
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 12c90267df..0ae056ed06 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -577,10 +577,6 @@ static void xilinx_axidma_init(Object *obj)
     object_initialize_child(OBJECT(s), "axistream-control-connected-target",
                             &s->rx_control_dev,
                             TYPE_XILINX_AXI_DMA_CONTROL_STREAM);
-    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
-                             (Object **)&s->dma_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
 
     sysbus_init_irq(sbd, &s->streams[0].irq);
     sysbus_init_irq(sbd, &s->streams[1].irq);
@@ -596,6 +592,8 @@ static Property axidma_properties[] = {
                      tx_data_dev, TYPE_STREAM_SINK, StreamSink *),
     DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIDMA,
                      tx_control_dev, TYPE_STREAM_SINK, StreamSink *),
+    DEFINE_PROP_LINK("dma", XilinxAXIDMA, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 4eb7f66e9f..84c0083013 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -795,11 +795,6 @@ static void zdma_init(Object *obj)
                           TYPE_XLNX_ZDMA, ZDMA_R_MAX * 4);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq_zdma_ch_imr);
-
-    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
-                             (Object **)&s->dma_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
 }
 
 static const VMStateDescription vmstate_zdma = {
@@ -817,6 +812,8 @@ static const VMStateDescription vmstate_zdma = {
 
 static Property zdma_props[] = {
     DEFINE_PROP_UINT32("bus-width", XlnxZDMA, cfg.bus_width, 64),
+    DEFINE_PROP_LINK("dma", XlnxZDMA, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 88002698a1..e89089821a 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -702,6 +702,10 @@ static Property xlnx_csu_dma_properties[] = {
      * which channel the device is connected to.
      */
     DEFINE_PROP_BOOL("is-dst", XlnxCSUDMA, is_dst, true),
+    DEFINE_PROP_LINK("stream-connected-dma", XlnxCSUDMA, tx_dev,
+                     TYPE_STREAM_SINK, StreamSink *),
+    DEFINE_PROP_LINK("dma", XlnxCSUDMA, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -728,15 +732,6 @@ static void xlnx_csu_dma_init(Object *obj)
 
     memory_region_init(&s->iomem, obj, TYPE_XLNX_CSU_DMA,
                        XLNX_CSU_DMA_R_MAX * 4);
-
-    object_property_add_link(obj, "stream-connected-dma", TYPE_STREAM_SINK,
-                             (Object **)&s->tx_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
-                             (Object **)&s->dma_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
 }
 
 static const TypeInfo xlnx_csu_dma_info = {
-- 
2.41.0


