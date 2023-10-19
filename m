Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2277D0403
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRO-0007wC-9s; Thu, 19 Oct 2023 17:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRI-0007ph-Lp
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRF-0005SI-Cc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so1084585e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750415; x=1698355215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K26pjgbN/XJgbsjyyabQMj6h89ERK847wNhqfJ3+FrQ=;
 b=tgIbW72gdEe0J15DAGSFo5F5RL+D00EVqjq94AFWCipRgfE+i21DryN4ksgImS8FGu
 kcanE4YKdt5Vvsv83hOxi3QNmHD+a5bqKRTBzwaWyTIz1pjEIdSJYyJZeMuVsIPt+zvJ
 G1SCyFjlLcAcI8z/538/VLhQajdwdcDgcQf9A6FYoDJGokZyhekAKO39o7f2CmbUgNWN
 UkK+vpqPgxPyO3M/tsAaF/7E/SPRxA+YqFER2xbLbKAKN7q2zLIQFjCLrUPYxzNfezlr
 1NhTxKhjXsrXe+uYPP7iVVURqB7dCWK4lE/ok5iB4iTZ0mSWUXd9S6mL/iVR4Rp7p6XB
 XbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750415; x=1698355215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K26pjgbN/XJgbsjyyabQMj6h89ERK847wNhqfJ3+FrQ=;
 b=Wkon2Wyg1lwFaHfZte7INBmkQANnTWvO9ImKH2g7s4ezwGCn8ynGgtzjiE3D7kIltN
 Q5o5L0xO4wiMXvBcr25DYU3xkSv+aph2YAJAE4YTOBSQl13iH5Cg4JQ8TbCgHtzyRDT2
 xjEbsjp0rT4Ib+7iO4bSam/9BZwn97ob3QjhoIrSiYWQ/R64WfWoNbtAimlPlA+34hkK
 zisb5LdTqTOUP+wBjcQVL5iP/I1P9Vm8jN9G8Yi9YolcnLWZtoQRMritFiBB7kijMOZX
 vaSPBcoa6Jil81vTd3y3w1Izqf3YcULR8w8rtFV0FHbpLYNZR4pT9nlqhGzlutZMbgRY
 1mlA==
X-Gm-Message-State: AOJu0Yyd2hO4VnkrszL+n/HDVy4jhcMWqRP6MtgLGA8wmuTTEoD7iRKb
 a++QO9D/RAGTsZSFuDSdFwIMHHx1Vvq9S6SWtsW3Gw==
X-Google-Smtp-Source: AGHT+IGFyEVnluLvh4ti0n6ItjO27mnAck1ch29Fy3FWNfG9z+/o28J/7u+rc1v0qlrTSQZ2SDJMuQ==
X-Received: by 2002:a05:600c:4f8d:b0:401:a0b1:aef6 with SMTP id
 n13-20020a05600c4f8d00b00401a0b1aef6mr67981wmq.2.1697750415641; 
 Thu, 19 Oct 2023 14:20:15 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b0040775501256sm525525wmq.16.2023.10.19.14.20.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 18/46] hw/sparc64/ebus: Access memory regions via
 pci_address_space_io()
Date: Thu, 19 Oct 2023 23:17:43 +0200
Message-ID: <20231019211814.30576-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

PCI functions are plugged on a PCI bus. They can only access
external memory regions via the bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231011185954.10337-5-philmd@linaro.org>
---
 hw/sparc64/sun4u.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d908a38f73..c871170378 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -360,11 +360,11 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     pci_dev->config[0x09] = 0x00; // programming i/f
     pci_dev->config[0x0D] = 0x0a; // latency_timer
 
-    memory_region_init_alias(&s->bar0, OBJECT(s), "bar0", get_system_io(),
-                             0, 0x1000000);
+    memory_region_init_alias(&s->bar0, OBJECT(s), "bar0",
+                             pci_address_space_io(pci_dev), 0, 0x1000000);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
-    memory_region_init_alias(&s->bar1, OBJECT(s), "bar1", get_system_io(),
-                             0, 0x8000);
+    memory_region_init_alias(&s->bar1, OBJECT(s), "bar1",
+                             pci_address_space_io(pci_dev), 0, 0x8000);
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);
 }
 
-- 
2.41.0


