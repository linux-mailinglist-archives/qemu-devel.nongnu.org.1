Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C37CFAB2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:17:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSte-00006o-5p; Thu, 19 Oct 2023 09:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStb-00004s-1c
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:03 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStZ-0003kY-BJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:02 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso168511966b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721418; x=1698326218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8v7QjsFI/UQ66aMELorogiH5Qo/GKGcFOriZN36zvBM=;
 b=JNwsx9LVnZcvc1k2iMugIvXUUvr8KTzegk/9Luilhca+0b/LUnoymgZtXcQy5FP5DS
 hz8sWO1laYSnekYSuglSZtOuaeHoDFw5P27Z4eQeml7rVho5n68Z69kxRlUGFud0Ls4E
 TBBzdtQrS2WPZBsEgMwAasEpYsQ0v4lskBf2GAMHT9WPPeQBR2/vvlDqjU2kVN5liglu
 YUaz+vwQj/x0uXA9FxvtzZKejuPaKzKdUKB4T7EqLLNbjYEy1IiqpgCzXdVqEq9tfsNg
 K9Y5g0+YcP39CJxyP9beAvAqaec8woT7RLuIzA6m1F3IDpYYBJ+I6mrFhhKKicwJFPSL
 Mx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721418; x=1698326218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8v7QjsFI/UQ66aMELorogiH5Qo/GKGcFOriZN36zvBM=;
 b=SSe7RZ8eeDCdXSBsZ7Z2XM7NQB4PH9Git2DcYC2kVmuigD12hRzcZRdfL9gX2tdW6n
 JrLcdwHCiB3zqLPPFkEAfsb1Fl3AvRJlTcvQvX5vBEw9xwlIxJKAZh9uR7BQaXk+yZGV
 fiSV9ZMKITutvYmqhzzXBxHWFTFGnTpgV3Uup9VBQKlFROV7KTw4JSXIAGNB2LbHj2c6
 3oYrpDQEwihiI/TfVSFUWKH8qTQfrqvPRs8IucLLbN11CEYeGgC1UBQ2h++eFardSyf3
 B/DnmLCiXRUmVkxPM0rWRDGo/kMKEoorCu91JdS72uxuAqV+2Txwqartxek2nD500lph
 lADg==
X-Gm-Message-State: AOJu0YwmFywo9PzUdJ2DiY5hUAsbIGfjBEc2ZxFkD2jzVKv6RVPldozR
 xVOoK2CwUVMb7tTY1t6XUBkct7V23e7G+OFUKEbytA==
X-Google-Smtp-Source: AGHT+IGUQ1O50AWq59MWxV9+yzXQWKxNwOCCAgZ2MluUPleF12o2dyGbCwOrp8IujdMbZeBu3AJHVA==
X-Received: by 2002:a17:907:2d0f:b0:9ba:8ed:ea58 with SMTP id
 gs15-20020a1709072d0f00b009ba08edea58mr1744308ejc.30.1697721418141; 
 Thu, 19 Oct 2023 06:16:58 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 gx17-20020a1709068a5100b00992e94bcfabsm3463588ejc.167.2023.10.19.06.16.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:16:57 -0700 (PDT)
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
Subject: [PATCH v3 1/7] hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device
 before accessing it
Date: Thu, 19 Oct 2023 15:16:41 +0200
Message-ID: <20231019131647.19690-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131647.19690-1-philmd@linaro.org>
References: <20231019131647.19690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

qbus_new() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_vio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 9d4fec2c04..f8ef2b6fa8 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -574,13 +574,14 @@ SpaprVioBus *spapr_vio_bus_init(void)
 
     /* Create bridge device */
     dev = qdev_new(TYPE_SPAPR_VIO_BRIDGE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     qbus = qbus_new(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
     bus = SPAPR_VIO_BUS(qbus);
     bus->next_reg = SPAPR_VIO_REG_BASE;
 
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
     /* hcall-vio */
     spapr_register_hypercall(H_VIO_SIGNAL, h_vio_signal);
 
-- 
2.41.0


