Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7086672D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 01:08:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOT3-0006nA-2F; Sun, 25 Feb 2024 19:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSu-0006gl-Cr; Sun, 25 Feb 2024 19:03:29 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSs-0000PK-Tl; Sun, 25 Feb 2024 19:03:28 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-607e60d01b2so10517567b3.1; 
 Sun, 25 Feb 2024 16:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905804; x=1709510604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5a2w/rK6Bkb8GbGdExqQD2sclDIKNcGfVOyOWOm/V4=;
 b=J/GVaXz0ZMiAKq608z/juXWZk8GFH+Xiv4S+lG+T/0Y11JBicP0VNDZ9GrVgZYCo+8
 kYYr25IMOTgPLf+WnVn8lfrtFaR2lxnEXQQujU8+hfo+gRzVT3frrOrUbRo9oVPDmAB5
 W8IKlA7/HEPsFOxjOnqVcRgvClBqaWCYt0UTbsc8Cp70IxSqIdHolo2Bf5FxxfoV5mkc
 2lL7uUq9P8IIFboREn3ZCsV1SsVxXk5xDGEzEEcQu82WpBWsm8sUydI75p5xzk1gfiAl
 js6u2p4/hNLW+YZoW96HJ4Uc5m49oiWoWOzFB3YhoijJT/gcU0r+7YFgduz4C5S/JR2O
 YI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905804; x=1709510604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5a2w/rK6Bkb8GbGdExqQD2sclDIKNcGfVOyOWOm/V4=;
 b=ASuoMD53E/Ji+UKy7e10/h5jDILhVi7Gv2PmGdAGleeves2p87pqM5UhivVQ2nSjLm
 rhbct0q4TaA0cOcMvv+22XaDslQSWH1n5kErI0hFOBW3kS3oAwSo/9RLEJKCbK+mmSxw
 wKkawizQWi0U7C2BuRQHGiSgJuU/vX8x6J8A437ssvanjjbp4k79kPKfD3CI+44sBK1Y
 z7E087QU22FeyUhtxlfjCoByJtiLhuhOwVmZn3kOv8F7kA6n2bC9tJloTa5GqwHi2HIb
 fzMovvhboosWMNFVdvgT37I96ThxwuYFY5b5xBBL8uvOwqB79ruOzT83GPShjCnd2D4H
 DqHQ==
X-Gm-Message-State: AOJu0YxRxqbdMquzVSKLOZgscEBa/o7aO83NOeqr5vkfW9w+GCU3TrC6
 OEEisJRtqoaDxLKJ+Klbz/gFf7HjUQPbQdZnn096GOekfRkjgNmjYgvKQs/OXOC8Kg==
X-Google-Smtp-Source: AGHT+IFHryWgVKT6KVjryIumMj81xR2SzF5JXniiV7EA1DBCG0jQo/QGdnJPu3Q8pG1jGGschG0/WQ==
X-Received: by 2002:a05:690c:80d:b0:5ff:aa34:7c5f with SMTP id
 bx13-20020a05690c080d00b005ffaa347c5fmr3388368ywb.46.1708905804275; 
 Sun, 25 Feb 2024 16:03:24 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:23 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 18/41] Add clock_isp stub
Date: Sun, 25 Feb 2024 18:02:36 -0600
Message-Id: <20240226000259.2752893-19-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 6 ++++++
 include/hw/arm/bcm2838_peripherals.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 6badda3045..1f41028649 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -17,6 +17,9 @@
 #define PCIE_MMIO_ARM_OFFSET    0x600000000
 #define PCIE_MMIO_SIZE          0x40000000
 
+#define CLOCK_ISP_OFFSET        0xc11000
+#define CLOCK_ISP_SIZE          0x100
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -228,6 +231,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 mmio_mr);
 
+    create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
+                 CLOCK_ISP_SIZE);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 49bb4fab08..adc02894c1 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -77,6 +77,7 @@ struct BCM2838PeripheralState {
     OrIRQState dma_9_10_irq_orgate;
 
     UnimplementedDeviceState asb;
+    UnimplementedDeviceState clkisp;
 };
 
 struct BCM2838PeripheralClass {
-- 
2.34.1


