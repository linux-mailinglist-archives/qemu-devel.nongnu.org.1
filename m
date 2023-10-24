Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6933B7D581D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKDB-0000vt-1e; Tue, 24 Oct 2023 12:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKD1-0000q9-HY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:47 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKCz-0000x4-Sd
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d9cb5e0fcso3313118f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164684; x=1698769484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeu0WdrzOGCHEDMF1fRtzg+H99Wxs+v/3o0eSYSnhQY=;
 b=Dm5uCT4IWCVZzMPqjTMCU8wu6QQLgTDGY7eBwJExVFnatlwI9w7abfnN36gJ3Qhxg3
 XBSHyDm0ZqqdCBys0I7pllpSIQhxudyk+LAGUBUCjvjo6vrWd7jKh2GrkM/oRSSQmF7w
 xJk4fA4RJbk5UQBnSVGzTJN+Xj8s32II50ZOAmyhAwuGTQL6TkNhuoFO3BJdFlyZ4KUE
 +h7zJgeTx3Qt8cfAFo/aFHAmxaX0qVwhN/vPSPOAnf+m0Lt3HfV/w5WgLkmCvYZHk76a
 f4QeL0YDLZSrZJ2lDSJXHfKOHVOF52MMDRVsz7HmD0SBAgi1SKAyqdjsAnyXcQ5NKCTX
 a4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164684; x=1698769484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeu0WdrzOGCHEDMF1fRtzg+H99Wxs+v/3o0eSYSnhQY=;
 b=j4BMz7XeXGLm724Cd+vl7FJwtRZU+ln6BBtTPstoPSvXHALZe1s82LlaVVLPPTg8Sb
 RZoogqMb/2nIQLCR6o6lLiHKxCQpxRWIBpmjz+iIaQZpLOV87Kk6g8gVJp2qR4vfKIw4
 m3xD8SiG3BwUB9l6WEkWnj84YnGnCjFhRSnZibYlmBBM958dyrrQkEZ9RehCcgK0It8M
 lbpttFSXlr+GGGQcbnHgavEA9Mr6xxgj0FiDKtESPpqadJYFH+Xp6nMUQGZiulzz8hNn
 vZS3aoSDf+3/MjaDYLwOyhQk8QPxOtbwq69FbRkVsqG32TsAfVaUoz54R1O2uqKuBVGr
 pjsg==
X-Gm-Message-State: AOJu0YyywxyUs0n/AlBPtpnBk+bm/7XXNA1nthORuheD+L4GlPrD6RQY
 lK9hsgwcwoOet/aHsmFYNB7ZezbH3XdejpERWMA=
X-Google-Smtp-Source: AGHT+IEH1zYSMJXFj/TJTs/gtkqz/5MabY3bs5PgOwO6DBcbEvuNgBcx5zTTIVhoExR9Kii0h6cPow==
X-Received: by 2002:a5d:4407:0:b0:31f:f1f4:ca8e with SMTP id
 z7-20020a5d4407000000b0031ff1f4ca8emr8493226wrq.36.1698164684203; 
 Tue, 24 Oct 2023 09:24:44 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 q11-20020a056000136b00b0032dc74c093dsm10240621wrz.103.2023.10.24.09.24.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:24:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/11] hw/arm/aspeed: Rename aspeed_soc_realize() as
 AST2400/2500 specific
Date: Tue, 24 Oct 2023 18:24:14 +0200
Message-ID: <20231024162423.40206-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Keep aspeed_soc_class_init() generic, set the realize handler
to aspeed_ast2400_soc_realize() in each 2400/2500 class_init.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_soc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index bb377e9e6e..191276a320 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -239,7 +239,7 @@ static void aspeed_ast2400_soc_init(Object *obj)
     object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DEVICE);
 }
 
-static void aspeed_soc_realize(DeviceState *dev, Error **errp)
+static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
 {
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
@@ -509,9 +509,6 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->realize = aspeed_soc_realize;
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
     device_class_set_props(dc, aspeed_soc_properties);
 }
 
@@ -527,6 +524,11 @@ static const TypeInfo aspeed_soc_type_info = {
 static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 {
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = aspeed_ast2400_soc_realize;
+    /* Reason: Uses serial_hds and nd_table in realize() directly */
+    dc->user_creatable = false;
 
     sc->name         = "ast2400-a1";
     sc->cpu_type     = ARM_CPU_TYPE_NAME("arm926");
@@ -554,6 +556,11 @@ static const TypeInfo aspeed_soc_ast2400_type_info = {
 static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
 {
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = aspeed_ast2400_soc_realize;
+    /* Reason: Uses serial_hds and nd_table in realize() directly */
+    dc->user_creatable = false;
 
     sc->name         = "ast2500-a1";
     sc->cpu_type     = ARM_CPU_TYPE_NAME("arm1176");
-- 
2.41.0


