Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F57D103C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:06:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpBd-00039j-RX; Fri, 20 Oct 2023 09:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpB3-0002Ag-PE
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:38 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAz-0005PI-EE
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:32 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo1154518a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807067; x=1698411867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XHyEIGArD78mgw8R7PN08IB8dbr9alKW/qdS4/dSAc=;
 b=ZgqvH+q5IhCm/GI/MllifkiAU9j58GC1letSB0bXZ6+Y7QUCEmzNL18JxmnqmpTZWJ
 L9mYVh3ddM7g42KieZDQ/lxIfLV0klP1L9XoXCL1SwsrIQM/ZI9X+/P61nSqZSBer/Lw
 ++wvCqq2Tl0/mBPdD2qBlVWQOim8IKy4mEyJEE3jVvy9x7FozDugYUTA/kOMx0HF27NN
 0w8D28MrEusbZRxYss0FRw+c39vcd/8OFpMc8nhIaUv8P8L64jV4kcGjdMcNhJGxpCOE
 Yj9Eh0OgK8WwW/GNqWZnZOTJqCau4+ffGLJEgZ4bQ7lkHs1eTS/C6jwRQo1EH+LV+nE+
 p8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807067; x=1698411867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XHyEIGArD78mgw8R7PN08IB8dbr9alKW/qdS4/dSAc=;
 b=ZjPV/olK+bJf9YcwzevKYaXiMMsLKkYtftpCkVqV08LFn7Hj0/H6AyCq6NwJvcwfL9
 3I6DPcG4EMq/AyrtB4m0sLq0yLGUfgxNL8JsvPc2QdPyP3qTf05jW7mQEXphbV4DpO5z
 V6RHmBT/1gi0H2KU5v1AP1hH2ERv3tbn7Rkb5Hq4jsjIWEFSoI5D1mgu3ZfdTcHV65d5
 TRiizGlFuZDmmdzbdLHHSyTk/oYXYZJWrufWbcntP26DR+H+xBKVMQiTKcnt071Sawar
 giO/xI7V537fxeSp1c9pXzue3nx7OPXsfnVCEVgxDDhrLwn423+KwPXd7WLDZVnTNvb4
 r2rg==
X-Gm-Message-State: AOJu0Yxy4YKSwOz8h2dzOhKl4LAgGxVYzErbz8/dCEciN21NaeaghtW4
 0vmzT5fMa7ZyluBUBQqFFcf+qLW+Ql42/Z19WZc=
X-Google-Smtp-Source: AGHT+IGV0EkEyJYfkJeZEEuq2RD7cnvdFDeeIT0lvOxeO6aD8rdwH0tbZyoJGGw/XKcA/Fi7mc3UsA==
X-Received: by 2002:a17:907:36cc:b0:9ae:5523:3f84 with SMTP id
 bj12-20020a17090736cc00b009ae55233f84mr1194335ejc.72.1697807067597; 
 Fri, 20 Oct 2023 06:04:27 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 h13-20020a1709062dcd00b009ae54585aebsm1473536eji.89.2023.10.20.06.04.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:04:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 9/9] hw/arm/pxa2xx: Realize PXA2XX_I2C device before
 accessing it
Date: Fri, 20 Oct 2023 15:03:30 +0200
Message-ID: <20231020130331.50048-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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


