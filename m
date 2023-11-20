Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F777F1279
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 12:53:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r52oJ-0001YT-HL; Mon, 20 Nov 2023 06:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r52oF-0001Y4-0w
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:51:23 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r52oD-0008PJ-2J
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:51:22 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5094727fa67so5906608e87.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 03:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700481079; x=1701085879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zrVc+uxt2aamx+bfLzj4zVN/8r9EOkToxVQHm8NrWKA=;
 b=v6KZgT+tx2D6DBWpI66z92Ls7wSKZUgaxqvS7IWqMfOkbQvjOLPANJtgX3uCA/W1k1
 pjsci9tXfAUeAX0vgLa2hRmJx2gGdsCtlClxRuLOX4GgLYoPFXvWMde1ZU+P9LzldvS5
 iWYDY3Lnl9K3dtvUxb6UuvqEKBVs3gN58K/58lJPepWrJ1Llp791UYZERoUWKb76tnml
 0wfeTXhK2c/0sCBuDq/MDbouym5vTrKajW24+fraCSEHfDCq2YLpODLa1lPPuKqHJcpf
 w7nQA+QGcvCraG2QHwQdsDO8uT0Cr1b3wFXYMtrVEAGgKNd7xVlbs8zkGmUwMyGDwrEq
 tgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700481079; x=1701085879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zrVc+uxt2aamx+bfLzj4zVN/8r9EOkToxVQHm8NrWKA=;
 b=XJx4HKtO1xYdDTOi4De7GnAYOjA4meULHHpzRxLNf4Zv/9s342bnLCuVG7i2G2HsY7
 tMgJxmSUMh+3y1lz4HLYpARCRY7/vg/SIvFWrfbOrCdXD0dU9mEsCuniHxFhiDM/VymM
 U4OIdUxdqD1AuQ0pYufJ4h95WfbdqkuQRyaDi38quTFcRnMk7Xq7mV6YDHcnkNykDeVk
 owsoiNHHYpl/zrWkBJGAHml+v8XDrgGVpsNNNxUFx0RiKGAL5+k7D8DJNIjIF4f+LJF6
 ZLSV3N7jVpmw4aK7U+WQz4d2L7Yz4BwmebTESgdwBi68ZmCfOWR/CYOTDL7AIFJmaGyn
 4QAw==
X-Gm-Message-State: AOJu0Yxldv4B32M2x1g8zVeQYP5lQfwIjcFmpkXxBGssqds2KerSpQ62
 4AxRdRGEr50Dr+F9CDTLw7AZgVc2jaeC3pUZkfc=
X-Google-Smtp-Source: AGHT+IHN+hDbRN1Cy0rpeaMp8iHSR6ZjWPmTJx2OSvSYUVAYcUplwPOpE3+jn2M47rtCXkP8OfxMmw==
X-Received: by 2002:a19:7015:0:b0:507:9fa0:e247 with SMTP id
 h21-20020a197015000000b005079fa0e247mr5124919lfc.32.1700481078904; 
 Mon, 20 Nov 2023 03:51:18 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 p11-20020adfcc8b000000b0032d9337e7d1sm11001729wrj.11.2023.11.20.03.51.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 03:51:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2?] hw/arm/fsl-imx: Do not ignore Error argument
Date: Mon, 20 Nov 2023 12:51:15 +0100
Message-ID: <20231120115116.76858-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Both i.MX25 and i.MX6 SoC models ignore the Error argument when
setting the PHY number. Pick &error_abort which is the error
used by the i.MX7 SoC (see commit 1f7197deb0 "ability to change
the FEC PHY on i.MX7 processor").

Fixes: 74c1330582 ("ability to change the FEC PHY on i.MX25 processor")
Fixes: a9c167a3c4 ("ability to change the FEC PHY on i.MX6 processor")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx25.c | 3 ++-
 hw/arm/fsl-imx6.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 24c4374590..9aabbf7f58 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -169,7 +169,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             epit_table[i].irq));
     }
 
-    object_property_set_uint(OBJECT(&s->fec), "phy-num", s->phy_num, &err);
+    object_property_set_uint(OBJECT(&s->fec), "phy-num", s->phy_num,
+                             &error_abort);
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), errp)) {
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 4fa7f0b95e..7dc42cbfe6 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -379,7 +379,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             spi_table[i].irq));
     }
 
-    object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num, &err);
+    object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
+                             &error_abort);
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), errp)) {
         return;
-- 
2.41.0


