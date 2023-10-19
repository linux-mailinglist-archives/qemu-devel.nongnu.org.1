Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9C7CFAA8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:15:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSrX-00026e-Fi; Thu, 19 Oct 2023 09:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqZ-00080z-NQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:56 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqX-0002bY-5M
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:54 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c514cbbe7eso75083041fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721231; x=1698326031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtQTvP35/R8Mqpc3lXMAne5CQvH4pHB2/4W4n7b7ncs=;
 b=xadH6JqO+0k4uwSthL38IgtGt9LIlkOENM8plMk93X6Ll53NpMiprg50MWOQjX6D56
 NQznZIkd2Whe2LEHCMwLEI2SUf6W+hLVLlLnGCHfPdDb86Blt5OXjKBg0asEGrs5hyug
 VjNgpPSrJTBAIGkRG/SOzHP+cuGEIAcNUpWEACluS/C2FPufcPn6Ntk3s+2iWcvM2WU+
 /2MTPxaVkN18yIaxnMpuqiRXaDXaZf/2++UyoHrozU2dQbCoZooRuSc463njmM5g1Nh0
 Ff/LvsqdOSlxl3woYQp159kM3yDaAxsyW4REJmIhAbLqBD4d+u1gJaiqYDu3rXwysVGf
 kGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721231; x=1698326031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtQTvP35/R8Mqpc3lXMAne5CQvH4pHB2/4W4n7b7ncs=;
 b=hvbJEYUOk0K+6Ktbxp7rQ3kjAtItC9ZKU1otuzg2hZUWgdsvubMVjckVnAwYIuYkrK
 Yd6HThrB0CUJoMKUliKF/LRUYf55+XgBBVZ3TZJlUtNMTTfb9I+Rppjll7jY2x10MZpJ
 5D8yvbHrV5ISxgpw7/DdfFfljDVua7vaPdtVUbEgfzEv8Zp0MaFzWNXsXS5ZcknTpMQw
 5rJIaPthWBk2RXj6Yi30T+wWw/4Fmk5aJHdbpngOuXqz4VJUqUiMRGM8ew7co0vzM+qB
 jpN88hoLbWMpPl4RuJinXS9YI2+Su9NvYBrZdUeXxMq8aL0AYiBerxHnIRl9pmpnSOrw
 fiMA==
X-Gm-Message-State: AOJu0YwjNJOjyPfYJQJLkyG/JEU2oUXzCXpnZ9NePt1opV21tcJ58Z8X
 oNz6NKqVAIS07lG6GApbzA93EkezPEK24qQhMSjJnw==
X-Google-Smtp-Source: AGHT+IH4c3VowCxRbypXJFO0ItaJ1HZ1CHs5j7W8RjFjyk7lFPPWPNuGhyCixslgrpWwhwZdALfxRg==
X-Received: by 2002:a05:651c:1688:b0:2c1:6b9c:48d6 with SMTP id
 bd8-20020a05651c168800b002c16b9c48d6mr1201003ljb.16.1697721230915; 
 Thu, 19 Oct 2023 06:13:50 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c2e4c00b0040648217f4fsm4341857wmf.39.2023.10.19.06.13.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:13:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] hw/intc/spapr_xive: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 15:13:05 +0200
Message-ID: <20231019131305.19157-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131305.19157-1-philmd@linaro.org>
References: <20231019131305.19157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 hw/intc/spapr_xive.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 12057ffe5b..199c261b07 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -350,12 +350,12 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
      * Map all regions. These will be enabled or disabled at reset and
      * can also be overridden by KVM memory regions if active
      */
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
+    memory_region_add_subregion(get_system_memory(), xive->vc_base,
+                                &xsrc->esb_mmio);
+    memory_region_add_subregion(get_system_memory(), xive->end_base,
+                                &end_xsrc->esb_mmio);
+    memory_region_add_subregion(get_system_memory(), xive->tm_base,
+                                &xive->tm_mmio);
 }
 
 static int spapr_xive_get_eas(XiveRouter *xrtr, uint8_t eas_blk,
-- 
2.41.0


