Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D499D7CFA8E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSnF-0006KV-AA; Thu, 19 Oct 2023 09:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSnC-0005wY-1u
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:26 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSn8-0008ED-TB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:25 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b95d5ee18dso116091921fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721021; x=1698325821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XHyEIGArD78mgw8R7PN08IB8dbr9alKW/qdS4/dSAc=;
 b=tTlJfgfFTTti9T7ef2mjZmwlgwquxMQHtMBIfvTBQPlHRKPiaZIc3HTOU6opKGCJdL
 Inbe6F7veaVsjcf09k0wNWrDA5zj70/uFO0aauYPVYXW0TM4MtuzS+YxyDqJeQFWR64E
 ImSFy7CYO/gle+5yJ+C0CGaTNEtl4SSa0ITq4LfvqlkrZyzJApMFR4dHBPNvHSZfN60q
 6hljErKdy3oio3Vyu3Th2hVhBiYrl3ZbX6fYn8btEIqTED6Sm6HJ4GGdwqthl0y45g+4
 BhGRDWk2CWqdmJyGMRsv/LcweeSj4kbJw6tINhiQObzTNYkc9rt+8/eBcksakjLOiFYY
 EGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721021; x=1698325821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XHyEIGArD78mgw8R7PN08IB8dbr9alKW/qdS4/dSAc=;
 b=nvsYoDhuJpY05Y4qyY5SEjNpaA3khd1LsqkCT4xlrU6XwHEJ7DI0ly706/bR1OjjYW
 6Xmh0+2X5dgm+JBjaRAcQ8x0eZRdvCfEDGy62FD989IQeddy5hhxuhoI+scMV+U8ZZhr
 lCbt4DLxA8M8tH6NuSWlKjR89/sblEhSZc7bXigiRFFQTYDcvXe+qAgU0N9rbb5yGiUw
 FKQln+9dZnxJ09c90aiqPR2G8KxaH+cpKcfNfOP75xd+K2B8uTEn7HJtvwAXvTiRSh6y
 rskFZpkGf26KslFA5UuU8Wmd8zq+N+vrdemOv+RtpAQtH22O+l8J07WsWki4N8XP/ATH
 Gr5A==
X-Gm-Message-State: AOJu0YwWtEbGgTsUXyOqzQm2FQ9lRthWMov5lbGcl6b66lscHY7z++M/
 86Y3D9hbd9OgnOPxRHKC3r64S+UYn4tVFDQlcLEegw==
X-Google-Smtp-Source: AGHT+IFkqkGK9Gt2O8cUoe+C52M46/qI7NN2msK2Fns5hoKJdI4Bno2716qQSEMgZP2HSAMDUZVZMA==
X-Received: by 2002:a2e:b601:0:b0:2c5:1a89:41c0 with SMTP id
 r1-20020a2eb601000000b002c51a8941c0mr1329995ljn.23.1697721020837; 
 Thu, 19 Oct 2023 06:10:20 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c1d8f00b00402d34ea099sm4421837wms.29.2023.10.19.06.10.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:10:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 9/9] hw/arm/pxa2xx: Realize PXA2XX_I2C device before
 accessing it
Date: Thu, 19 Oct 2023 15:09:24 +0200
Message-ID: <20231019130925.18744-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

qbus_new(), called in i2c_init_bus(), should not be called
on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/pxa2xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 601ddd8766..f0bf407e66 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1513,14 +1513,15 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,
     qdev_prop_set_uint32(dev, "size", region_size + 1);
     qdev_prop_set_uint32(dev, "offset", base & region_size);
 
+    /* FIXME: Should the slave device really be on a separate bus?  */
+    i2cbus = i2c_init_bus(dev, "dummy");
+
     i2c_dev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(i2c_dev, &error_fatal);
     sysbus_mmio_map(i2c_dev, 0, base & ~region_size);
     sysbus_connect_irq(i2c_dev, 0, irq);
 
     s = PXA2XX_I2C(i2c_dev);
-    /* FIXME: Should the slave device really be on a separate bus?  */
-    i2cbus = i2c_init_bus(dev, "dummy");
     s->slave = PXA2XX_I2C_SLAVE(i2c_slave_create_simple(i2cbus,
                                                         TYPE_PXA2XX_I2C_SLAVE,
                                                         0));
-- 
2.41.0


