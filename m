Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA57CC576
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsket-0004pd-On; Tue, 17 Oct 2023 10:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsked-0004F2-2j
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskeZ-0008Q3-NC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so60406065e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551351; x=1698156151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zd7XFPGgQEK2cJC81izUf+xDXi7YU9Dxs0UeK55tGc=;
 b=sMVJhPUZHMJjYFGLGbMb5BHLHrWSFrRS5URZ00agLBSFkOAjuLF7+SupN/pCddravn
 vPwbEviyf0vNTn0KI4CpLdeV2E9WMXiPs+a0Qu4gHhwD+IojRlGyaRv8DDs7oHZsJIeH
 +Sm2/oxNIY4bNWcf8BFyZHqOG+UuihzmCmN0eAhZFHBXh34G9TPDHhKIkV6b3sL5Qhec
 EICDkUiEam61zFHQKHfrs2FEIe9y8bD6anQn9S2dIOApSWL3ZkQkCv3lte7HckoUPafb
 XNWzQ019M1BjU7kxLxhHE/VaJiw4BJTp+VtO/g1Mjk4HzKLO7VBM4TjFGyPyHGhShajX
 4HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551351; x=1698156151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Zd7XFPGgQEK2cJC81izUf+xDXi7YU9Dxs0UeK55tGc=;
 b=DuSwazjrm1xEzF7nvv0DnH3sJlW142sakdauG9H6C49XA2Ho1UnefjxCQdJJKx2vEo
 Ys9EqNBbkgl/7gBG4ki98ejFTtdyg9EZY10U5aoEMUmoXW8Wds7UpijgwaTv+KlMNRyD
 7qEWa1hQsGsuz/qerP7JQHmKOyv6y4popTdktkpQX/26qDLd/+hhU7yCVk9IQxwol8ea
 GBbqarvBCgy7MVLJrMciUGdyfYNo+tFEwgW+E6TL358dFWksU+wJVaDRqH1NeJPbIgvW
 6/4alEWsF8p1hRlEASfDSep2VI4+UaPrADCL4b8K8EnSLldx6HF+EfNTHcRVK/C9kpY8
 TwIQ==
X-Gm-Message-State: AOJu0Yx/yy2SS0if9HQqpjAH0XSdACFIUJuot4FCWxaFbs4OkGXf3yXt
 zW2pJMSPFqwT6NeRmN7m+QxY6fhSHoeJpNvSrIZaZQ==
X-Google-Smtp-Source: AGHT+IHG3RXB8acip9h1BwGTjc6cpMcmPkRM04GoyShM07nkaT8gHlmc+ixv41NoTfM2DqiZ6IP7og==
X-Received: by 2002:a5d:5232:0:b0:313:f463:9d40 with SMTP id
 i18-20020a5d5232000000b00313f4639d40mr1747107wra.65.1697551350315; 
 Tue, 17 Oct 2023 07:02:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a5d62ce000000b0031779a6b451sm1744270wrv.83.2023.10.17.07.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:02:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] hw/dma: Declare link using static DEFINE_PROP_LINK() macro
Date: Tue, 17 Oct 2023 16:01:48 +0200
Message-ID: <20231017140150.44995-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


