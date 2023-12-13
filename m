Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C262C8107D7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 02:51:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDENa-0007TR-MV; Tue, 12 Dec 2023 20:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rDENY-0007Sg-62; Tue, 12 Dec 2023 20:49:40 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rDENW-0007uh-FJ; Tue, 12 Dec 2023 20:49:39 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b7039d30acso370227239f.3; 
 Tue, 12 Dec 2023 17:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702432176; x=1703036976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=MVVU9s00n1TGH1xdlGn64eFa0srxhzdvWLz07J4494s=;
 b=fDP0bKqMCrIyugmcgC32k7WCQX9qaLYLCW9eey7zIOiGQIeZyxOoxiMk1VVztfZa0U
 /e+b6MCQA+1gYOla4GZJAlceLpPVjN4JmxQ/fBm32aHJQN/zepehFfcIKyeCr82h4ZRP
 ejiajg6ZqZSQ76BF7NGznJrcl7Yy77KA3K+vBOY9N75+WqFFgujD5pMBr6VNAEcl8EoL
 XgnQK8/Szdj3rE6reoEeGXTslN3fyI22yeBASyse2fySTv/I46lJG3EIMfhpYe3OIV6s
 Iw3IS97kKWqle/MuYYwliD6pn03UtP8vVIcXNVco5eVCmS+f9gUWErUPHZ7LD5vbiq/i
 Om0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702432176; x=1703036976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVVU9s00n1TGH1xdlGn64eFa0srxhzdvWLz07J4494s=;
 b=tVAM0Or3ssv+FAoXBf/3nam1ARqX0NU5hIW4SiscAmwVnrJzTeER6GOCTEugaB43L7
 9qIZDL+vsSss9//6P5IDhBrqYw0Sg1l7i+QbytHc9fNVjltTKLRFFFcrRZeIOw+0yut9
 DxH83sxcwHkLpr0C2VmIEr8r4B79kadVd3nsAujlbG0bQNRUZbVb8XR84X+fpeR6mWfP
 P14hJv4uMT1BEpwXIbFSh1607zHCQdZNU9E7DUAa0sAFXp1OFAHkbqTPJJke3lbR7J1g
 SkguYTCowK1yOlGgyxDxHD8Pu2/lzytRkdSCd75g/4Ezz40Ea5ReU2a8kn8ZhUEL8RUN
 WJDA==
X-Gm-Message-State: AOJu0Yyww3xOCrpoVe7aTel8PgL5MVAZEssbvfdrgP9z1QnVgfpMU9mC
 4VB/4OLT1tq//Na5yzgbZOWVk5TRnmVO9A==
X-Google-Smtp-Source: AGHT+IENdDyp7gvMzu6tNrqrPwKgNxygaVqnUMFx+eGYIOdEfpgrPmhlWoVVTqQbPeSTqaLw+ZuiEQ==
X-Received: by 2002:a92:c267:0:b0:35d:70c7:4c5b with SMTP id
 h7-20020a92c267000000b0035d70c74c5bmr11008025ild.33.1702432175836; 
 Tue, 12 Dec 2023 17:49:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a170903248b00b001cfd077fab4sm9314264plw.282.2023.12.12.17.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 17:49:34 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hw/sd/pxa2xx_mmci: Disable reentrancy detection
Date: Tue, 12 Dec 2023 17:49:32 -0800
Message-Id: <20231213014932.1748323-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=groeck7@gmail.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

All tests using pxa2xx_mmc to access mmc cards on pxa2xx platforms
such as borzoi fail starting with commit a2e1753b80 ("memory: prevent
dma-reentracy issues"). Disable reentrancy guard to fix the problem.

Fixes: a2e1753b80 ("memory: prevent dma-reentracy issues")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sd/pxa2xx_mmci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 5e8ea69188..27ae8f2888 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -555,6 +555,8 @@ static void pxa2xx_mmci_instance_init(Object *obj)
     qdev_init_gpio_out_named(dev, &s->rx_dma, "rx-dma", 1);
     qdev_init_gpio_out_named(dev, &s->tx_dma, "tx-dma", 1);
 
+    s->iomem.disable_reentrancy_guard = true;
+
     qbus_init(&s->sdbus, sizeof(s->sdbus),
               TYPE_PXA2XX_MMCI_BUS, DEVICE(obj), "sd-bus");
 }
-- 
2.39.2


