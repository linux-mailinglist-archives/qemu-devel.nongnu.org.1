Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039EE7D103A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpB1-0001rB-2a; Fri, 20 Oct 2023 09:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAl-0000rk-1i
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:16 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAi-0005Lx-C4
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:14 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso121421866b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807050; x=1698411850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSmy0AQ2ctzt4sBy/4+sAM4ntN11b2Cq/iHR2Msv118=;
 b=ZaOVU1WdVB2Eu95j73/qAX8nJn8MV4rWIVcHDVM2rMhC1sxAp/tokeGQd8GlpdqfKY
 X2nC+WJp5gZeg2NFCY/FzqwrB2rFWH265bO2IRC+ckfUpLlsb63WiAUk/wwRlS+hBtHD
 jc8/cO+9PMFrRnz0yoE9Ox+gywvv2n5dmfI4Iutv/TsV7LaB+R025mtm17bdt1gmd4mR
 TOYeWAAQ6kPnECS/RMAfEYXS80yyBAEd4F2m66nKYWkEcZh3/9TEc3N0ma5AG9InXkIG
 Nj4+ew/esqESDofflc5jWEPDk3XcpBz4fzrmFgcTVDz00lCq/4UQgsViI3f0aARD+blO
 1dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807050; x=1698411850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSmy0AQ2ctzt4sBy/4+sAM4ntN11b2Cq/iHR2Msv118=;
 b=snJoinZoCsAJ8jcDBEAroFyOJVSAA09wJiSmC1Vntz3BIjzPCAtlzuo1XD/sd74AG3
 JxH2Lz1PG+IGmdOvxVHHN+/FthqTtHI+9nBT4Q571JSfv7FoS8vGS8ulRUnc5ivsej/D
 OjXXRLR4/b4Tyi+oarv6bMQMIo8GckMX1zwtzGoztFDhUEPaQgS2DXMeUCCm8iEZncuI
 dpsTbObdBxei5BZZXY+sOAAHzkuXGLULgbvCqEPIlqZpTT1t7s0Lh29MiuRP+n9RHeOU
 bdzG5nQ5wouBRCk4KmssHE5PkHMgZES1UVpTtudyXy1rcZP2kwuyIyjFGvOMK/5PiLXa
 Dk1A==
X-Gm-Message-State: AOJu0YwiYBBs4ZwuJY8+x7UnWea3FEnm2xw72bolyU1zV0IUoTy1AFXa
 rOna6nSFN2F8BzDAVWnST3m7BpTMiX57ebRxS5E=
X-Google-Smtp-Source: AGHT+IEElSvLZLeja/TwUNbWmCbY4kPpVpZSNtUdaIS6w7rJaZL27Q6qghDZ4MhE91h1W7ww2LX3lA==
X-Received: by 2002:a17:907:a03:b0:9be:5ab2:73c2 with SMTP id
 bb3-20020a1709070a0300b009be5ab273c2mr1295033ejc.58.1697807049770; 
 Fri, 20 Oct 2023 06:04:09 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 y19-20020a170906519300b009adc7733f98sm1484765ejk.97.2023.10.20.06.04.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:04:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/9] hw/intc/pxa2xx: Convert to Resettable interface
Date: Fri, 20 Oct 2023 15:03:27 +0200
Message-ID: <20231020130331.50048-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Factor reset code out of the DeviceRealize() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/pxa2xx_pic.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 47132ab982..2eb869a605 100644
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
2.41.0


