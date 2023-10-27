Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA807D9BEA
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0y-0001LZ-Oe; Fri, 27 Oct 2023 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0G-0007JB-K0
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0E-00089z-HF
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so1451849f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417594; x=1699022394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=imigjsNGXBkOUVZzVBGOXn7dYRW7BzDepKRKFU1uSDY=;
 b=n4k0x6K/Qsc/48AL9nys34IEMEoZKvYPWt4VvOKd/Se7isB0TEIJCRecFQmYH13O7W
 ZyB26nKwzFJkzzUBntkQ7soV9rONMxFcMYHA/kcEpf1j2KxAWIH7cUYMk0LPQ6moayRd
 o4aHgo/wmNg2ePVDHGBzF0snvW/O7IbN8scnGKL/2WfRAyffvwJCumkqTITVu/BCPv4u
 dSV1AYJ80p7Rzqth+v2klBo5yXKtZTdyR1KVIhFJfAJdAtIHMp3TjYNYPkmRkaPwJ5vz
 AXmJJBql8tpYC+UIZVga/6Ko+jedPuJZtS3rbw74xuztBPqDpPCW82KJ5qXzkJqbaTVL
 vknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417594; x=1699022394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imigjsNGXBkOUVZzVBGOXn7dYRW7BzDepKRKFU1uSDY=;
 b=Df/3VIUYBIf+dGSer6RO3cZzP2xqP6sDMmsOEZZ8/4X7GUIl3A3d3QiEXVmxRG3q5R
 u4paFceH+bC0PzFxSIH3BmvLJvApJkCjDlLlG2nlmV6OCaCebCQ1gnNCy3hed8QS59Md
 bAKWhULEoeu8w5357yF5Hfog+kxGFdTuJc48HjjzzT2STOServ82bFKPMlUAC8hz8nmA
 nY6wbNuB/r6fmdTB59peg07+1Dizg1/73BKy3HCvCQNe5L4H1rs7l0bQVeAJ919be+GR
 f3GozrXOKkEyhaXcA7VE2jGRukjbt8bJxI1pO8o2t1JvuGTWXh9R5khki8pJ0jMxkw7v
 Du1Q==
X-Gm-Message-State: AOJu0Yy+ESyyQI2vbOYyWPQapru5bfpPjha5m0xt307bG83v6U/Ozcyy
 Z75N003J8lE4IJf1tYgIkxtsGqGMVyqvBav1S/Q=
X-Google-Smtp-Source: AGHT+IFvKAj0RQY8FAzGm/FJ5Ny9DZ+wGM1kAvn/PlKllLFk+lsP+uU0232GqQUDCHxwiR7eS2uJiA==
X-Received: by 2002:adf:cf02:0:b0:32d:baf4:e56f with SMTP id
 o2-20020adfcf02000000b0032dbaf4e56fmr2413957wrj.12.1698417594137; 
 Fri, 27 Oct 2023 07:39:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/41] hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
Date: Fri, 27 Oct 2023 15:39:22 +0100
Message-Id: <20231027143942.3413881-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231020130331.50048-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/pxa2xx_mmci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 9f7a880bac2..4749e935d8a 100644
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
2.34.1


