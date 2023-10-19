Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802F7CFABB
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:18:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSuQ-0000yH-VS; Thu, 19 Oct 2023 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSuI-0000Pc-S9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:47 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSuE-0003sC-OF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:46 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso170981766b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721459; x=1698326259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzC6A86Bk95Jd4e/EkJIpq30sS9wgbKZ9q/zKo1ZK3Y=;
 b=p9PDFDBaJGTmNPJGxOAgLjeXyTLaO3N0pZfsI6v95DdiZx/lz59oDVv7a7HoVIauzB
 CHTKxxMGczdiNbhz8huGhTX7t20FfEmw55iIHDfyJDpV/STEBF/+82LjTmKw7WDAeepR
 DsEBfFza2/G3z+EMEwAWLeHV2rX0I0KsttSyFm6khCT7JsmRFb5K7+LkqtK+dbrceBZB
 Gzs5aLD1l8R0osZAOqU1xenhgRJCozg3Qa36YnvnPbygH42i3l3ZV455CT5v4N2tylwO
 +KjLP+ECtLOBDjvtSAeEHdqi6rAb9sS+0MW90hVRSwYPKzBKxM4Nq905g+yA3fawKkck
 72Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721459; x=1698326259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzC6A86Bk95Jd4e/EkJIpq30sS9wgbKZ9q/zKo1ZK3Y=;
 b=WOCIAPfZYOkj5ejhehBLt/2/Xq8jL7UfRzA8pIp0TNl8jXCfUs24Jv6vY3ce4CODgq
 9fCC2CfIC/TXkxLG5HFhhVDi0ZNXaCGhZ2Qjq2CmoR77+Gze4el71zamBLa04sSEkQs9
 cB4Uhi2lLlFvaVElMWLYyOOlcAWNVCnp+qPyYv80rY3gUrNOnNM1oTTXrdA1DbL1SPCS
 C1q04qKuYGy2QvUHpwP5OhlGbjP7U68BLCvuGU6J+FEmqGaEPYJtUVXaoio6ZNbnW0D5
 G4aGo4JSAaHhTQc5ZwiNwEOTWC4XrkS5vHnPOC+8aYa1Vh1JO1kTuCpM0H4nvxMs3Jnd
 dB5A==
X-Gm-Message-State: AOJu0YwEuM/6BhOwWaZEafPyS6j5c0hsiGnrWoi+Eq7hyclciaQxudIJ
 Pd0as+Tbi/y4exdpuYL9D3j9fyhBSW6Kf3fFaxJpaA==
X-Google-Smtp-Source: AGHT+IFcaaKlHQjmNWgGDlPiKwFC6ylQFxH4ghP8TNXFL6rbvoJbNEItuM8dX8kveVJAgJL4zpeycQ==
X-Received: by 2002:a17:907:1ca4:b0:9aa:206d:b052 with SMTP id
 nb36-20020a1709071ca400b009aa206db052mr1462695ejc.27.1697721459077; 
 Thu, 19 Oct 2023 06:17:39 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a170906068900b009875a6d28b0sm3524508ejb.51.2023.10.19.06.17.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:17:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/7] hw/intc/spapr_xive: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 15:16:47 +0200
Message-ID: <20231019131647.19690-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131647.19690-1-philmd@linaro.org>
References: <20231019131647.19690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Transformation done using the following coccinelle script:

  @@
  expression sbdev;
  expression index;
  expression addr;
  expression subregion;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map(sbdev, index, addr);
  +    memory_region_add_subregion(get_system_memory(), addr, subregion);

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


