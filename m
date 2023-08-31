Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4F78EAF6
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBG-0003jV-T7; Thu, 31 Aug 2023 06:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB7-0003Za-Gv
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB1-00043j-ES
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4020b88bd03so6205855e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478726; x=1694083526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d8C43XFZ9tO8SprZx5Cpb/h7ovOf0gqzc6LRcUwwY6I=;
 b=Arkjihixh0w9iKEoCqZ2swtgpDMsz6qi3EQMp5NlbVqxHNL+8bQQtF3mnE3jk6ktCd
 gnKBoCtJg2T3ua8Or4LDR+l4ZToG1zI9ZbQZ48JaPrJ4jm6r8uTzTj4CkoaGCFb4ZG2n
 QMcAa7Nw3OrlXZk4lsrM1i8LZUzYqVyZvO9JwtLKt5m2VkmWRiiJI/c3u7TG/PNGNYLf
 4q8i/47iHP3GfVZxDbLBAIGcQ83uwPKYi488O7eiFBKIXD9WWHZlScBNN61aFfyj6XjF
 LJNh/EnTb7yL1KS1K9GPzCmvlr6Ci+rPRrNDkoUrvpr8AVs/gS0UKYB22KcGJbcELrEE
 cmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478726; x=1694083526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8C43XFZ9tO8SprZx5Cpb/h7ovOf0gqzc6LRcUwwY6I=;
 b=PGjGhq/L9ipeAx9RkQuji2c/9EXU53CG89Ar38CJ8pcZO/UT4QftacMiXaJMRCpPHv
 3Yz2UEVEBxoW6kB3y+kRO8W/UiZ8znnybY2GdpKvs2RP4t4pgWgwASXPiosWk68D/zxi
 0P6KC922wJn96poO/qnu65NtItJkxwNRkyAluiRiUcAtAoKvTCJK77njavI6t0xwPwMA
 e1ScPqbSLEZc881gfaQS50hTlRnDi2w+n9PNdKz/QR3i9Z+K4kCUk6v3v9b2g7wAoYN7
 QL/PdU11bhvZ1pgDFsUuonYJJdO4jWptLZ0TXw0tqB0y71T1Sc2PinyDpxoQJg2lsRLp
 NqqQ==
X-Gm-Message-State: AOJu0YxvP0ZgcUdjZxFdVORVed/XU9AWB3d0zCOJT/ocwGYoj3zrbqZG
 j/lNyrII1yxxMpoy4/VTPFXniNLLRs77ciia1yQ=
X-Google-Smtp-Source: AGHT+IEuGamRBxawi/ngBxaikZ01XxS/ANA38f304IpvEG/StXzFy7K9ORGJPHopf9T7RrlCDrZpGA==
X-Received: by 2002:a7b:cd0a:0:b0:401:b2c7:3497 with SMTP id
 f10-20020a7bcd0a000000b00401b2c73497mr3625000wmj.11.1693478726070; 
 Thu, 31 Aug 2023 03:45:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/24] Add i.MX6UL missing devices.
Date: Thu, 31 Aug 2023 11:45:08 +0100
Message-Id: <20230831104519.3520658-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Jean-Christophe Dubois <jcd@tribudubois.net>

* Add TZASC as unimplemented device.
  - Allow bare metal application to access this (unimplemented) device
* Add CSU as unimplemented device.
  - Allow bare metal application to access this (unimplemented) device
* Add 4 missing PWM devices

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 59e4dc56e14eccfefd379275ec19048dff9c10b3.1692964892.git.jcd@tribudubois.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h |  2 +-
 hw/arm/fsl-imx6ul.c         | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index f7bf684b428..63012628ff0 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -60,7 +60,7 @@ enum FslIMX6ULConfiguration {
     FSL_IMX6UL_NUM_USBS         = 2,
     FSL_IMX6UL_NUM_SAIS         = 3,
     FSL_IMX6UL_NUM_CANS         = 2,
-    FSL_IMX6UL_NUM_PWMS         = 4,
+    FSL_IMX6UL_NUM_PWMS         = 8,
 };
 
 struct FslIMX6ULState {
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 06a32aff647..e37b69a5e16 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -583,6 +583,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_PWM2_ADDR,
             FSL_IMX6UL_PWM3_ADDR,
             FSL_IMX6UL_PWM4_ADDR,
+            FSL_IMX6UL_PWM5_ADDR,
+            FSL_IMX6UL_PWM6_ADDR,
+            FSL_IMX6UL_PWM7_ADDR,
+            FSL_IMX6UL_PWM8_ADDR,
         };
 
         snprintf(name, NAME_SIZE, "pwm%d", i);
@@ -636,6 +640,18 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
                                 FSL_IMX6UL_LCDIF_SIZE);
 
+    /*
+     * CSU
+     */
+    create_unimplemented_device("csu", FSL_IMX6UL_CSU_ADDR,
+                                FSL_IMX6UL_CSU_SIZE);
+
+    /*
+     * TZASC
+     */
+    create_unimplemented_device("tzasc", FSL_IMX6UL_TZASC_ADDR,
+                                FSL_IMX6UL_TZASC_SIZE);
+
     /*
      * ROM memory
      */
-- 
2.34.1


