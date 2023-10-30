Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A97DB546
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 09:38:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxNlw-0005O0-JH; Mon, 30 Oct 2023 04:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxNlr-0005NB-Ax
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:37:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxNlo-0004F3-VE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:37:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9c5b313b3ffso621148966b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698655029; x=1699259829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vzmvmyVQ+oA867Qws9NF2zxwyLsLq34rfuCOG7/GxcY=;
 b=quAwy3hX86F6NqV1CcRde3wQdSkkVIsY3DYvNTACZxBcMqNctKAqvTc7UpKPspe+cB
 uYxV2qxYA1QCPWTJt69fjfjg6No4aUOBlI7t8T/wFKpleC3365kdoNAJwnLjiVM0SHZI
 3B0/FvsghH8ieVs9Oa1bjZWEvzlEtCfu/4doJnGCiPNx8J2XgNOGgDN7AyHew2bcheBW
 /82aG2V2eTFYeWRjyyeIsDwrqAVklMvK37wDLOwysE3W6DqcEqo9Wz1/xspbSFSuCiwD
 tLATiP03tPJQ6L0xIIoXEkTH4ITgoutqvfdJq1EszQqtNwqB5oIHZy1Tefa/8Qpy1Tg2
 l8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698655029; x=1699259829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vzmvmyVQ+oA867Qws9NF2zxwyLsLq34rfuCOG7/GxcY=;
 b=j3Sgx63zSs23U9XQu7O6vmU3GH2p1FWHHWD0O3Ay2KtwLz29LCbDZbOKh98Rt6ZAxd
 HhGxXC9Z4Pbn6NikAtFMp9Go1pNnBFURqYszAwwyqw5amYU7hT9klyF1lZqDJbj/UEfe
 sUl/xLQK3lPWbZbXpl8e7gj9rl6siasK+VhB+W4tBDWpRsTi0K0mxcpz5/RD1wjqiXNE
 YEKO+6o83JCfCwyo2XFBIYGo4XRFFPu+BN2tYba3kxlvHkhe2KrPDRn88ubBg8aBc2bf
 O0oa1VLKjfuJyzlP1vSPbvaF7GnjcYvNl5hoYgNcppGyDSxS8qVq3PyWdbeMbPGT0Cml
 2Q8A==
X-Gm-Message-State: AOJu0Yy+Bnn46o6b+J3v5g02VFMCgxvchaCUJJqA2KkE+2aG7pA/wu/H
 5x4y3E/nPKTTDXEwq06QCPZNi7G2XnZxRJ+RHHc=
X-Google-Smtp-Source: AGHT+IG2abL72UwnUo6mToooCAhy4BEMIUY6j2QPoQzFL4tIQKahNjpdZLbGv6L48o0+kOBxr25FYA==
X-Received: by 2002:a17:907:7ba1:b0:9b7:37de:601a with SMTP id
 ne33-20020a1709077ba100b009b737de601amr8044179ejc.49.1698655029305; 
 Mon, 30 Oct 2023 01:37:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a1709062b4e00b00988e953a586sm5627636ejg.61.2023.10.30.01.37.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 01:37:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm/pxa2xx_gpio: Pass CPU using QOM link property
Date: Mon, 30 Oct 2023 09:37:05 +0100
Message-ID: <20231030083706.63685-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Instead of passing the CPU index and resolving it,
use a QOM link to directly pass the CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/pxa2xx_gpio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index e7c3d99224..c8db5e8e2b 100644
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
2.41.0


