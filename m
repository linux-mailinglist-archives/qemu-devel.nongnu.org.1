Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41177DF906
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:42:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfG-0003Ow-GD; Thu, 02 Nov 2023 13:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybef-0003FN-Jh
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybea-0002l8-1S
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40859c466efso8808465e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946726; x=1699551526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKA7bn5x9XExQ1qcDE6U/Plr8Mt6ZUx9Ro4D4g9gp3I=;
 b=iKH9OZijOU6qzxIy9L2zPGBID+Tu58jVZ/PtVAoKj8qxhBM28cUWoH/O5qS7lcbjho
 8O9IxISmICpvnNniQXeeo4IwGTj+NkWbj98aOAgBzMSQJZfF9T04KILveajNEfpEjjol
 T3Fo1usA7hrs5ymHeubWRxjfzGMJPJ8qsgRd+4dk0/EOlFSD8CXj+StrAwk4rnxpLnrZ
 zjqBWOTEMxL+iB2nYcuoQloN5aLxFGglGlMVlyoapvZMMV2GfPNth48u56Lq/QWzilcZ
 DCrO29z5pXrI32qGF5BYUmFBQ65KmqaeYbi7XCje0XMLCGi3wOYtUO25aHsgXVzdiHc7
 GSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946726; x=1699551526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKA7bn5x9XExQ1qcDE6U/Plr8Mt6ZUx9Ro4D4g9gp3I=;
 b=LBiR+Pn5Er1fwclT7aYlvDPDNX/Q47x9pwuEHohxILudNp0ypqf3/sU8t3Q+lQ3aJ1
 SngQxjIa02lwClM9T6f0h1TLAf6avu0lSgCaThYa6pk+0UH2rMBckjifdp3VbAeibLOR
 I2x6u+ix1ZkPh/nbpbXb/x0QAhU62iPz1SGix0ttOJQ6H9zXUn7UtIlKuixj31CWeZMb
 uNylWOOJj/MmUIgezWprl/7/OyFm0B/RY16xpxAeNmbr/Sj0c3DlwjNwf/lr6BUluLj8
 RaoxjDaapJlvvF4hSfbpveauA5u3oEnNThrLC/s8V1ykEC8WL8nrQuoAKdZdnNDvai+l
 HNuQ==
X-Gm-Message-State: AOJu0YzfJtRtamrHFmJwC+WUmEY8riC8M0U4u6SFUPR8QIH1AhP/dQnu
 IrcSm496gEOfH4+joc4Zy3AwpB7C15pIC/yFUos=
X-Google-Smtp-Source: AGHT+IExnIqyamcyxZxUSPXbKAb5QSwrFWALySqqDrCUeMvmYhBxVx7O0y4coEhnYC8e6WmbuZbD0Q==
X-Received: by 2002:a5d:64c8:0:b0:32f:9977:eefd with SMTP id
 f8-20020a5d64c8000000b0032f9977eefdmr6914028wri.42.1698946726702; 
 Thu, 02 Nov 2023 10:38:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/33] hw/arm/pxa2xx_gpio: Pass CPU using QOM link property
Date: Thu,  2 Nov 2023 17:38:19 +0000
Message-Id: <20231102173835.609985-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of passing the CPU index and resolving it,
use a QOM link to directly pass the CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231030083706.63685-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx_gpio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index e7c3d99224a..c8db5e8e2b7 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -32,7 +32,6 @@ struct PXA2xxGPIOInfo {
     MemoryRegion iomem;
     qemu_irq irq0, irq1, irqX;
     int lines;
-    int ncpu;
     ARMCPU *cpu;
 
     /* XXX: GNU C vectors are more suitable */
@@ -266,12 +265,11 @@ static const MemoryRegionOps pxa_gpio_ops = {
 DeviceState *pxa2xx_gpio_init(hwaddr base,
                               ARMCPU *cpu, DeviceState *pic, int lines)
 {
-    CPUState *cs = CPU(cpu);
     DeviceState *dev;
 
     dev = qdev_new(TYPE_PXA2XX_GPIO);
     qdev_prop_set_int32(dev, "lines", lines);
-    qdev_prop_set_int32(dev, "ncpu", cs->cpu_index);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
@@ -303,8 +301,6 @@ static void pxa2xx_gpio_realize(DeviceState *dev, Error **errp)
 {
     PXA2xxGPIOInfo *s = PXA2XX_GPIO(dev);
 
-    s->cpu = ARM_CPU(qemu_get_cpu(s->ncpu));
-
     qdev_init_gpio_in(dev, pxa2xx_gpio_set, s->lines);
     qdev_init_gpio_out(dev, s->handler, s->lines);
 }
@@ -339,7 +335,7 @@ static const VMStateDescription vmstate_pxa2xx_gpio_regs = {
 
 static Property pxa2xx_gpio_properties[] = {
     DEFINE_PROP_INT32("lines", PXA2xxGPIOInfo, lines, 0),
-    DEFINE_PROP_INT32("ncpu", PXA2xxGPIOInfo, ncpu, 0),
+    DEFINE_PROP_LINK("cpu", PXA2xxGPIOInfo, cpu, TYPE_ARM_CPU, ARMCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


