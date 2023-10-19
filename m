Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C12297CFA76
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSn0-0005CT-IN; Thu, 19 Oct 2023 09:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmU-0004Mf-Su
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmT-0007Qp-E4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so233115e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697720980; x=1698325780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJfJ06RDafLRLEOQTU58KKvhb0KtBRhLr9Bft9JesEY=;
 b=myfnfk+7mIjhUyLOgjIuqBOvgkunFxpV8p6QoSIsE90YbAFZjQFeoK3GFU26NwjV06
 qbbVM3Y/lNOsLMHMbW6EgVam7EM96pzXNc/0y3G2D6L/yadkU6sGiTiQBe56oglF4kPL
 KMtxYaXQfEFC7ONn6Myg2yu+FSRFgiwX7sfwKZI3BRyHJcH6aG/Zmr1nmxxWD4WmuGvJ
 do6UaeI3q0Mo5/sbk6XPEN37VLkys/rtv9X9T0atMXnoP2f1sM1YsM+8H5VAf4tZ01P/
 XyYqmQDxcHYaOmMBtZUVHZMkB6mlc2tNjxjxEF7CnslgO4YRXbUFh8WuqH/URYL77DrB
 Z7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697720980; x=1698325780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJfJ06RDafLRLEOQTU58KKvhb0KtBRhLr9Bft9JesEY=;
 b=tBIWBJULFdip63imSSJea/wflarOIUb84eNkl2WpW+1Y+9uOX180IHp7kLGptDJUr7
 JCrjpzgy4AtouZxzpJGq+xi+Ne+lewzl9vSAkTjfauBSj8NJZueX8QGCsLfaesmdZBTY
 FmetWzEpbpSYI+bhPdtWyqZfVzNLnq3olJBavJsOJVWJqZ0Tb9vYumNhMlu8O5jaUHhX
 ZJebrh1a54R5+b65PI2zp1AYxjyZREkFJKOG6iq57a8YbDYI42ftMuxVU/Nvcmn8rD0w
 hS4cWw5Hr0I3zJZ8IgSaLzXqT8hdx8Mlbv2w9YmrGA3sh4vcW5WrFlM5nyOl0JiZZCdG
 MlDQ==
X-Gm-Message-State: AOJu0Yw5hPbVw5WZDRDmeY/iSsj5YCInQkkbrC9Gw3NTeg3WrozdRqxc
 no76QzHRaYgFeSD2xSV1EnpfjUeVotSgCfcbMK+FeQ==
X-Google-Smtp-Source: AGHT+IH3OEVEj+2/bUmyOQKS5bIh8d6v/vM18La9o3CPhl8cz8xCXdHyZ+0Rc+4UjdL5lzuf3JbbwA==
X-Received: by 2002:a05:600c:3591:b0:405:375d:b860 with SMTP id
 p17-20020a05600c359100b00405375db860mr1884089wmq.21.1697720979709; 
 Thu, 19 Oct 2023 06:09:39 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 l32-20020a05600c1d2000b00402f713c56esm4494647wms.2.2023.10.19.06.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:09:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/9] hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
Date: Thu, 19 Oct 2023 15:09:17 +0200
Message-ID: <20231019130925.18744-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/pxa2xx_mmci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 9f7a880bac..4749e935d8 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -479,13 +479,8 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
                 qemu_irq irq, qemu_irq rx_dma, qemu_irq tx_dma)
 {
     DeviceState *dev;
-    SysBusDevice *sbd;
 
-    dev = qdev_new(TYPE_PXA2XX_MMCI);
-    sbd = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbd, &error_fatal);
-    sysbus_mmio_map(sbd, 0, base);
-    sysbus_connect_irq(sbd, 0, irq);
+    dev = sysbus_create_simple(TYPE_PXA2XX_MMCI, base, irq);
     qdev_connect_gpio_out_named(dev, "rx-dma", 0, rx_dma);
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
 
-- 
2.41.0


