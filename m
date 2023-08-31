Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B178EB0B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:49:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBQ-00048k-Ft; Thu, 31 Aug 2023 06:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB5-0003YT-Lc
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB1-00043Q-1K
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso6273995e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478725; x=1694083525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kyRjWza4FydApFPcQyrvxJM4UV9pQPcxGBS07VokX2o=;
 b=C7eTEmu3wRM/GH5sFLOAWRD0yxRvp7ZGhRFko1yr/vclm3w/PHUNgLx3KxLiPzzKoi
 06gLZxw4nuFzkGm0kcoeEU7w0inGNMJNut5Qz4zo4Nth6h8r9/f3EFjXTMqoyjBlnmdH
 hLO79aBU/rJVCdWJDuASwdT+Fw1w02X5dbelEiXfLmuB/TCp9nS8AnJf+7uTfagSSKtA
 zGVqVjBHodGG6U39mxAL0tQ1biqrjKDauBMvpS3o4KqEPxN2Iqin7rBWZIKdeC0ui54q
 2CmeXAj9fCADQhBc+v112McuX+fgjwYAgxYMl4Ptr8GLEifIo/vacgExqZ3X6uNDZC8p
 +DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478725; x=1694083525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyRjWza4FydApFPcQyrvxJM4UV9pQPcxGBS07VokX2o=;
 b=NzD2iY47Y7aQscW127vRYSOJmEuAtCmq3PV0b0JGCMhgxBIgClfm6o8mKXA3nyHND9
 hh9TqatgsOy4As3rnVILRLoW0nSlq1ZhQf4EjrZi9Y2ER0200vWyoVWrqgn4pbW3TJyX
 z+F0kSidQbSYsCTBpd72Or7mmj+Wh8CUpWZb8vF2I64z1WL/naxT7etRGpSsrRnQUbwr
 sNS0dbuFaWTIK2k39jPDfxAUcYKj5XqsaK8YSFluDnjcpGH6oV3ucBkQgvBXBSrWZPpO
 /y17I4EGmwxQ1nHawrM8bxT6bl2qNBod6YCZhnjhsoq9zhe7KDzjT6tNSnPsGUdsJkOB
 nQLw==
X-Gm-Message-State: AOJu0Yx5C3DAkrkG2gAP/t8pBbmMe4MmZpwPnc2e1qp4bk5UDVu+2oek
 bEoIf3jKMu74Vrkb5EsvGY+UU+eRPwAbN9IpiXU=
X-Google-Smtp-Source: AGHT+IHqm88wppzu+ELKGeMzH7jpjKjbcJ0zUsOkGun5lTH4ATRAwMRmj2lMLxeWWfqmF4YS0hv5lw==
X-Received: by 2002:a05:600c:228e:b0:3fe:ef11:d79f with SMTP id
 14-20020a05600c228e00b003feef11d79fmr4159542wmf.36.1693478725135; 
 Thu, 31 Aug 2023 03:45:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/24] Remove i.MX7 IOMUX GPR device from i.MX6UL
Date: Thu, 31 Aug 2023 11:45:06 +0100
Message-Id: <20230831104519.3520658-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

i.MX7 IOMUX GPR device is not equivalent to i.MX6UL IOMUXC GPR device.
In particular, register 22 is not present on i.MX6UL and this is actualy
The only register that is really emulated in the i.MX7 IOMUX GPR device.

Note: The i.MX6UL code is actually also implementing the IOMUX GPR device
as an unimplemented device at the same bus adress and the 2 instantiations
were actualy colliding. So we go back to the unimplemented device for now.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: 48681bf51ee97646479bb261bee19abebbc8074e.1692964892.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h |  2 --
 hw/arm/fsl-imx6ul.c         | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 9ee15ae38d6..3bec6bb3fb7 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -22,7 +22,6 @@
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
-#include "hw/misc/imx7_gpr.h"
 #include "hw/intc/imx_gpcv2.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
@@ -74,7 +73,6 @@ struct FslIMX6ULState {
     IMX6SRCState       src;
     IMX7SNVSState      snvs;
     IMXGPCv2State      gpcv2;
-    IMX7GPRState       gpr;
     IMXSPIState        spi[FSL_IMX6UL_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX6UL_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX6UL_NUM_UARTS];
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 2189dcbb72c..0fdd2782ba5 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -63,11 +63,6 @@ static void fsl_imx6ul_init(Object *obj)
      */
     object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
 
-    /*
-     * GPR
-     */
-    object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX7_GPR);
-
     /*
      * GPIOs 1 to 5
      */
@@ -537,12 +532,6 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX6UL_WDOGn_IRQ[i]));
     }
 
-    /*
-     * GPR
-     */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpr), &error_abort);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX6UL_IOMUXC_GPR_ADDR);
-
     /*
      * SDMA
      */
-- 
2.34.1


