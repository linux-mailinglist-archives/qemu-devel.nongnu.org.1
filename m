Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6C7D9C0E
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0n-0007wI-Fj; Fri, 27 Oct 2023 10:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0L-0007Na-S4
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:06 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0G-0008Aq-DT
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:04 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c50906f941so32201711fa.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417596; x=1699022396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V07Wudk4DGe/lbQGSeT1AObsafhup4QVV7ySJocl1eo=;
 b=KcM3i+tjTi+wChVxrsttcKkjyjdLWN0eFVMI2oWs/z7E9c/5ENIIHxl3o0YZEZPTj7
 vO9+uSTKhcrKgjuEAeNcmmcNcLrh5qGDzmDcJ80eCHV4pM9rcxSrbsdHNI69Mt5gcEOS
 V1nG0kW0Ej4K4p1VarcKCtRK1fjYeIICoQRGDncqw+Iy67uXeCU0Nhr1z7lLBxgaBmi7
 EGPgLZ1MAKTK3Fx59Ikd5l67jRCeR/L0fq/GuQ/fq1rNUYzK14EmyOKeD/1uCfRxu8n4
 /mJLHbIRDQcmC7ZeRDB+aYrZGjC1EtzSf65M5odG7JrQKfvohnSoWPTs0oyqpmdZl5IG
 u+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417596; x=1699022396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V07Wudk4DGe/lbQGSeT1AObsafhup4QVV7ySJocl1eo=;
 b=ldCww5N2sFoOVxLNJyqJxydqT8pOjorqMH84P4Djl2kD3zQfHWRmyZA47qIkWrGdWf
 SRMCDgg33oxj2+xFePYoxnEILXrbeWmNGJZSAZcsbfczHwZLc1Zwle9vGH3Ikim+Cio2
 UxW26TM/i8e9cNURyiMKa1l/tXyrid2OPLtqbtpmezeVLl6Fn5AfLOl98Gvh5C2mhXEt
 HmD0svIZn2YPxE7xPu3eP7mXt1PkHg+7scYYg7nEkkIZJXCW98J02tFv4zbEZtNvSEkn
 HhMf7sqieHTwU8MfhfL75Yh5XaZ32znl3okOCcs6f7CgjeAEkrGbYNYoCTlIyTMOTXyF
 wgxw==
X-Gm-Message-State: AOJu0YzraHWfvH7S/POwmecO45MHH23fE4UV4T9l5XJ/7e5p8n4ZSiDr
 XzeUDOYwGMO6h87c8pnvKcXqeyQhjGPqX6+eCOQ=
X-Google-Smtp-Source: AGHT+IFE+KGCqGEeE0YWvJQAeQvly/KRZ9NRZme1wt3jtKQAoP/M8ckmxxNGKmtM3OcVTndo3LTVFg==
X-Received: by 2002:a2e:3816:0:b0:2c5:8a0:b502 with SMTP id
 f22-20020a2e3816000000b002c508a0b502mr2204795lja.48.1698417596366; 
 Fri, 27 Oct 2023 07:39:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/41] hw/intc/pxa2xx: Convert to Resettable interface
Date: Fri, 27 Oct 2023 15:39:26 +0100
Message-Id: <20231027143942.3413881-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

Factor reset code out of the DeviceRealize() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20231020130331.50048-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx_pic.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 47132ab982b..2eb869a605a 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -271,12 +271,9 @@ static int pxa2xx_pic_post_load(void *opaque, int version_id)
     return 0;
 }
 
-DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
+static void pxa2xx_pic_reset_hold(Object *obj)
 {
-    DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
-    PXA2xxPICState *s = PXA2XX_PIC(dev);
-
-    s->cpu = cpu;
+    PXA2xxPICState *s = PXA2XX_PIC(obj);
 
     s->int_pending[0] = 0;
     s->int_pending[1] = 0;
@@ -284,6 +281,14 @@ DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
     s->int_enabled[1] = 0;
     s->is_fiq[0] = 0;
     s->is_fiq[1] = 0;
+}
+
+DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
+{
+    DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
+    PXA2xxPICState *s = PXA2XX_PIC(dev);
+
+    s->cpu = cpu;
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -319,9 +324,11 @@ static const VMStateDescription vmstate_pxa2xx_pic_regs = {
 static void pxa2xx_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "PXA2xx PIC";
     dc->vmsd = &vmstate_pxa2xx_pic_regs;
+    rc->phases.hold = pxa2xx_pic_reset_hold;
 }
 
 static const TypeInfo pxa2xx_pic_info = {
-- 
2.34.1


