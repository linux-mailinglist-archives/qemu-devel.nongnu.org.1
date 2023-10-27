Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B397D9BCA
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0r-0000CW-NQ; Fri, 27 Oct 2023 10:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0J-0007Li-RV
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0G-0008BE-Bo
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32dd70c5401so1403892f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417598; x=1699022398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y5AUijSrfVsWwd+101EJqdvIevP5G6afFX1UVrgLj5Y=;
 b=kYpYi7uDv8b+7oYW73UShHPoLIVdNlaLlgNBNl6qM58K+ZwuPYYdTnsp6KANyvdXuh
 3JiqumBJM5PNe922ClZN5SR1uRkIcO+6weqM8kHFamTpX17lS8q29bpX2UOzT7h7XdYk
 45Gby+z9yt4WgpoZ4mGNc8Mqr5WRFhJWL+UxnWeOA3F0W8az0ANoZKFdcBuKm5p9twO9
 MqcpvZDQrPd+Ze/GX4dm4pShXTcH+/qDcm16ivnLlNafJKezRAyeYCoq0Gt3y0ydNq9o
 SA9qjYo1AVFG6RMHRAawILcBbZy1HLvhWSnAZulK6ITKt+AsPz/X7JzWccN9Z0SXevY/
 0eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417598; x=1699022398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5AUijSrfVsWwd+101EJqdvIevP5G6afFX1UVrgLj5Y=;
 b=VQbbo+h0bFwZ1M70d/ZG90uV4Xm3GC3QvB9A4TcWItYP5uDlSgNkJsIKnj4+cMfoRg
 z1vLvgskJ6JmX1VSpV/M421xKTk24t78rRDMW2zIKihp0cOkBojN6H6pIWo63WURRRQe
 PgwTa8H+ZWUuIex0ZsaBB2rY1n8NDmXpVqpV33LhIWOTsh8O9E60YTVFjtKhkkfdmKK6
 Wmv5VKO3KHgglbL/tTNAQ12Pb+IbajVR6TuCdBspPFTSt0NSi8krp5mnYeO+89a/f17T
 zKDwto7TdREjKj81qMEBzQB7JgisPYRse2s3xKVR1vpR9o78O1OgY+Wusy/+fSWktk2T
 vV1Q==
X-Gm-Message-State: AOJu0YyRLIeeiO0FNVhqJJu6xE5dW5uV/S6NjNqO8+YATLQ/nqL0lizW
 VjhJfgMZRkOXE3ffu488RRV8PPSk9VdVMbzZ3LY=
X-Google-Smtp-Source: AGHT+IGr3+4AMeGqEbyqR13e5cFnZI1bOF5x2T1sUctdquALuapc6altwL8cDx9+wSFNkSD7mTJ2Ng==
X-Received: by 2002:adf:fe05:0:b0:320:920:42b1 with SMTP id
 n5-20020adffe05000000b00320092042b1mr1976078wrr.53.1698417597878; 
 Fri, 27 Oct 2023 07:39:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] hw/arm/pxa2xx: Realize PXA2XX_I2C device before
 accessing it
Date: Fri, 27 Oct 2023 15:39:29 +0100
Message-Id: <20231027143942.3413881-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

qbus_new(), called in i2c_init_bus(), should not be called
on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20231020130331.50048-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 601ddd87666..f0bf407e664 100644
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
2.34.1


