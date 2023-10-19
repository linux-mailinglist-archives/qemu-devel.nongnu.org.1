Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5307E7D03B5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaSX-0001Q5-1O; Thu, 19 Oct 2023 17:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaSV-0001PE-IG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaST-0007AV-3e
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso1062225e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750491; x=1698355291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2FEPKvYUQPXlVYljpSlyvIweR9xsIaSQUX0X9ROFrQ=;
 b=Io5dx2HJ2QF9qta9RzXxG3iuyp9hpO5BOPfXcB1LF53zd1w/nhHjJgkR+A8T8EG6+I
 XKTLdNPfTil217slE+Hv2tpAo4KJSvRgxGXfLLHWiJiPOVzo6rjx9Ej2q3cAf0dtNXJ3
 jxi+hCc8torXPMqCH3GIAqFaVEWzpKLrrtgfxwXW2YpkCg+VWWjxsBGNo7B3tPbOrd1v
 ejgaMICIsxyB3noRUtIEev9HUt4KHyRLOXlVT+HPvwRpGh+xZcH0rnrISRnaYzWtjvpW
 qp9wjq7TCghj0L7gfqeZa0sy9np6FO5EvGdbZ+IEZAlEFlW5htfJBCOGcn53bqCnNy01
 vlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750491; x=1698355291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2FEPKvYUQPXlVYljpSlyvIweR9xsIaSQUX0X9ROFrQ=;
 b=e9/PWvPRxoeo/uDBRyXhmzz5g4C2YGorCjW+/+3yzXRk9wPSIsuYpYayqxgavD8LFu
 E8ZOXLwonSbSerPdk/DC9EEr9IGZSovtQufcNtvX0o8NYV33SD2axMmiDQPvggwgzq3L
 G8SBFqVj7Ru7KeppivVRIvlR+heXCDoYrrsP36sCMVEnyS0+GoRA0KSEkDzHd5TKaotp
 aVR0vgRbHnUnCM83ZJA2lgdZiCe8j2xsmi1HYlKf6N8/t8XCGJJFwkvTgLqe3k8sTzCk
 ZmAD87q/B0JWw2hTGl5cjw0TNm7VxLZAPSCob/WdgPSAi3+fOU6PzV7KBgay/nETVjY6
 e1Tw==
X-Gm-Message-State: AOJu0Yx0LctmNc9lthYwJ6hj1qlX5n75z+7CqrTomYVZFNUtNf0NPb4K
 jHFK+GrroTuhcBUk1eAnk4dXlpR5kV1RmQ8aETD83g==
X-Google-Smtp-Source: AGHT+IHZVRlRQJuSV9tZxAn03EAS0vCfkRenWR+CBaRN6dfJzGHs+1YUtGHFq2xIba/iiVF3kXkDZw==
X-Received: by 2002:a05:600c:1c8d:b0:402:ea83:45cf with SMTP id
 k13-20020a05600c1c8d00b00402ea8345cfmr38255wms.2.1697750491527; 
 Thu, 19 Oct 2023 14:21:31 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c220600b0040684abb623sm5244918wml.24.2023.10.19.14.21.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:21:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 29/46] hw/intc/spapr_xive: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 23:17:54 +0200
Message-ID: <20231019211814.30576-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20231019131647.19690-8-philmd@linaro.org>
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


