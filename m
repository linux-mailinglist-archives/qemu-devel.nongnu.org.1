Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6E78EB06
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBN-0003sd-75; Thu, 31 Aug 2023 06:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB7-0003ZZ-H0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB1-00043a-0h
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so487632f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478725; x=1694083525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TezHjCyr/pegc2JSFZbMQFCmEx4buRUZ+C0WWCBvLyA=;
 b=rvb5iCvZJx8bzOofSYdubFG6qOUt7hupKBvFZCq5tLAxLRpmzn/ySMVMa4WpjtK+R0
 yk3SyA/GM95dUgpnHzWxiSQ7puuqcMgAf82hs2BM2o35/AOB8ra6ZIT+LfbVKZUiYxpV
 kIqmQAjb+ZsHwA2KNR0AP8rOTrEUTfTFGyS03j90MdTlfpS4LIYftmJ562lqYP7KvQpu
 IHkY5S3+HrKl6RoVdH5jlHrwu3BY2uRr6xoLhb9GFsxBoetmwgDS8VjXMWI3eLk2Z9Q9
 DLD0j5+YFg3S5rd0rVLgQfts62QtwiRtVyc3ljVZhWOacm/MoYz2loiwNdtM8qBCjuDS
 yLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478725; x=1694083525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TezHjCyr/pegc2JSFZbMQFCmEx4buRUZ+C0WWCBvLyA=;
 b=WA4rCyzaHi60GQML39T/SN5StVBNR/pf25lHY9vf1cE2wb88oUdu+RkPXLwgqGHY7A
 6iDimBF8RfvDf5KNRdC2obkF55YVfkk/TWFTyN8dgi7Yf/m13z6fh6onHzmVbH0pj5CT
 QxPlQcQlRtkzDxQS+gmmWSFJyISwUIRYbau6yITRYzP50tdzsQm54eUx8C46s/WjaTlX
 D+q8bh1fZx8UrT4p4oM/ckrBeumGoFeHajh/YA8dNQ5okNXzAvn4C2ni/uavgGAgWnu6
 tGLGqirw1ge8fYJ0SpW23XRldWKVDWYClfY+EdIIslsP80OIN62c8Gkp7nRkuyY3v14o
 4HGw==
X-Gm-Message-State: AOJu0YxtDUppYQGxz/LDCF3Kn9nkTwTbX0grG57QnUqW8s+VeEgSu52H
 voLtngqw5/kqfJT5B1A4Z4UYHPWr/env8QAEO6Q=
X-Google-Smtp-Source: AGHT+IHBje37cOadb/jbpCf+yPrKnnuAp7CsbEg+ree+CjVFwxnkHtMw3C9pucEKIPZQ93z+fSu6ww==
X-Received: by 2002:adf:e809:0:b0:31a:d2f9:7372 with SMTP id
 o9-20020adfe809000000b0031ad2f97372mr4232313wrm.29.1693478725570; 
 Thu, 31 Aug 2023 03:45:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/24] Refactor i.MX6UL processor code
Date: Thu, 31 Aug 2023 11:45:07 +0100
Message-Id: <20230831104519.3520658-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

* Add Addr and size definition for most i.MX6UL devices in i.MX6UL header file.
* Use those newly defined named constants whenever possible.
* Standardize the way we init a familly of unimplemented devices
  - SAI
  - PWM
  - CAN
* Add/rework few comments

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: d579043fbd4e4b490370783fda43fc02c8e9be75.1692964892.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h | 156 +++++++++++++++++++++++++++++++-----
 hw/arm/fsl-imx6ul.c         | 147 ++++++++++++++++++++++-----------
 2 files changed, 232 insertions(+), 71 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 3bec6bb3fb7..f7bf684b428 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -37,6 +37,7 @@
 #include "exec/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
+#include "qemu/units.h"
 
 #define TYPE_FSL_IMX6UL "fsl-imx6ul"
 OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6ULState, FSL_IMX6UL)
@@ -57,6 +58,9 @@ enum FslIMX6ULConfiguration {
     FSL_IMX6UL_NUM_ADCS         = 2,
     FSL_IMX6UL_NUM_USB_PHYS     = 2,
     FSL_IMX6UL_NUM_USBS         = 2,
+    FSL_IMX6UL_NUM_SAIS         = 3,
+    FSL_IMX6UL_NUM_CANS         = 2,
+    FSL_IMX6UL_NUM_PWMS         = 4,
 };
 
 struct FslIMX6ULState {
@@ -92,119 +96,227 @@ struct FslIMX6ULState {
 
 enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_MMDC_ADDR            = 0x80000000,
-    FSL_IMX6UL_MMDC_SIZE            = 2 * 1024 * 1024 * 1024UL,
+    FSL_IMX6UL_MMDC_SIZE            = (2 * GiB),
 
     FSL_IMX6UL_QSPI1_MEM_ADDR       = 0x60000000,
-    FSL_IMX6UL_EIM_ALIAS_ADDR       = 0x58000000,
-    FSL_IMX6UL_EIM_CS_ADDR          = 0x50000000,
-    FSL_IMX6UL_AES_ENCRYPT_ADDR     = 0x10000000,
-    FSL_IMX6UL_QSPI1_RX_ADDR        = 0x0C000000,
+    FSL_IMX6UL_QSPI1_MEM_SIZE       = (256 * MiB),
 
-    /* AIPS-2 */
+    FSL_IMX6UL_EIM_ALIAS_ADDR       = 0x58000000,
+    FSL_IMX6UL_EIM_ALIAS_SIZE       = (128 * MiB),
+
+    FSL_IMX6UL_EIM_CS_ADDR          = 0x50000000,
+    FSL_IMX6UL_EIM_CS_SIZE          = (128 * MiB),
+
+    FSL_IMX6UL_AES_ENCRYPT_ADDR     = 0x10000000,
+    FSL_IMX6UL_AES_ENCRYPT_SIZE     = (1 * MiB),
+
+    FSL_IMX6UL_QSPI1_RX_ADDR        = 0x0C000000,
+    FSL_IMX6UL_QSPI1_RX_SIZE        = (32 * MiB),
+
+    /* AIPS-2 Begin */
     FSL_IMX6UL_UART6_ADDR           = 0x021FC000,
+
     FSL_IMX6UL_I2C4_ADDR            = 0x021F8000,
+
     FSL_IMX6UL_UART5_ADDR           = 0x021F4000,
     FSL_IMX6UL_UART4_ADDR           = 0x021F0000,
     FSL_IMX6UL_UART3_ADDR           = 0x021EC000,
     FSL_IMX6UL_UART2_ADDR           = 0x021E8000,
+
     FSL_IMX6UL_WDOG3_ADDR           = 0x021E4000,
+
     FSL_IMX6UL_QSPI_ADDR            = 0x021E0000,
+    FSL_IMX6UL_QSPI_SIZE            = 0x500,
+
     FSL_IMX6UL_SYS_CNT_CTRL_ADDR    = 0x021DC000,
+    FSL_IMX6UL_SYS_CNT_CTRL_SIZE    = (16 * KiB),
+
     FSL_IMX6UL_SYS_CNT_CMP_ADDR     = 0x021D8000,
+    FSL_IMX6UL_SYS_CNT_CMP_SIZE     = (16 * KiB),
+
     FSL_IMX6UL_SYS_CNT_RD_ADDR      = 0x021D4000,
+    FSL_IMX6UL_SYS_CNT_RD_SIZE      = (16 * KiB),
+
     FSL_IMX6UL_TZASC_ADDR           = 0x021D0000,
+    FSL_IMX6UL_TZASC_SIZE           = (16 * KiB),
+
     FSL_IMX6UL_PXP_ADDR             = 0x021CC000,
+    FSL_IMX6UL_PXP_SIZE             = (16 * KiB),
+
     FSL_IMX6UL_LCDIF_ADDR           = 0x021C8000,
+    FSL_IMX6UL_LCDIF_SIZE           = 0x100,
+
     FSL_IMX6UL_CSI_ADDR             = 0x021C4000,
+    FSL_IMX6UL_CSI_SIZE             = 0x100,
+
     FSL_IMX6UL_CSU_ADDR             = 0x021C0000,
+    FSL_IMX6UL_CSU_SIZE             = (16 * KiB),
+
     FSL_IMX6UL_OCOTP_CTRL_ADDR      = 0x021BC000,
+    FSL_IMX6UL_OCOTP_CTRL_SIZE      = (4 * KiB),
+
     FSL_IMX6UL_EIM_ADDR             = 0x021B8000,
+    FSL_IMX6UL_EIM_SIZE             = 0x100,
+
     FSL_IMX6UL_SIM2_ADDR            = 0x021B4000,
+
     FSL_IMX6UL_MMDC_CFG_ADDR        = 0x021B0000,
+    FSL_IMX6UL_MMDC_CFG_SIZE        = (4 * KiB),
+
     FSL_IMX6UL_ROMCP_ADDR           = 0x021AC000,
+    FSL_IMX6UL_ROMCP_SIZE           = 0x300,
+
     FSL_IMX6UL_I2C3_ADDR            = 0x021A8000,
     FSL_IMX6UL_I2C2_ADDR            = 0x021A4000,
     FSL_IMX6UL_I2C1_ADDR            = 0x021A0000,
+
     FSL_IMX6UL_ADC2_ADDR            = 0x0219C000,
     FSL_IMX6UL_ADC1_ADDR            = 0x02198000,
+    FSL_IMX6UL_ADCn_SIZE            = 0x100,
+
     FSL_IMX6UL_USDHC2_ADDR          = 0x02194000,
     FSL_IMX6UL_USDHC1_ADDR          = 0x02190000,
-    FSL_IMX6UL_SIM1_ADDR            = 0x0218C000,
-    FSL_IMX6UL_ENET1_ADDR           = 0x02188000,
-    FSL_IMX6UL_USBO2_USBMISC_ADDR   = 0x02184800,
-    FSL_IMX6UL_USBO2_USB_ADDR       = 0x02184000,
-    FSL_IMX6UL_USBO2_PL301_ADDR     = 0x02180000,
-    FSL_IMX6UL_AIPS2_CFG_ADDR       = 0x0217C000,
-    FSL_IMX6UL_CAAM_ADDR            = 0x02140000,
-    FSL_IMX6UL_A7MPCORE_DAP_ADDR    = 0x02100000,
 
-    /* AIPS-1 */
+    FSL_IMX6UL_SIM1_ADDR            = 0x0218C000,
+    FSL_IMX6UL_SIMn_SIZE            = (16 * KiB),
+
+    FSL_IMX6UL_ENET1_ADDR           = 0x02188000,
+
+    FSL_IMX6UL_USBO2_USBMISC_ADDR   = 0x02184800,
+    FSL_IMX6UL_USBO2_USB1_ADDR      = 0x02184000,
+    FSL_IMX6UL_USBO2_USB2_ADDR      = 0x02184200,
+
+    FSL_IMX6UL_USBO2_PL301_ADDR     = 0x02180000,
+    FSL_IMX6UL_USBO2_PL301_SIZE     = (16 * KiB),
+
+    FSL_IMX6UL_AIPS2_CFG_ADDR       = 0x0217C000,
+    FSL_IMX6UL_AIPS2_CFG_SIZE       = 0x100,
+
+    FSL_IMX6UL_CAAM_ADDR            = 0x02140000,
+    FSL_IMX6UL_CAAM_SIZE            = (16 * KiB),
+
+    FSL_IMX6UL_A7MPCORE_DAP_ADDR    = 0x02100000,
+    FSL_IMX6UL_A7MPCORE_DAP_SIZE    = (4 * KiB),
+    /* AIPS-2 End */
+
+    /* AIPS-1 Begin */
     FSL_IMX6UL_PWM8_ADDR            = 0x020FC000,
     FSL_IMX6UL_PWM7_ADDR            = 0x020F8000,
     FSL_IMX6UL_PWM6_ADDR            = 0x020F4000,
     FSL_IMX6UL_PWM5_ADDR            = 0x020F0000,
+
     FSL_IMX6UL_SDMA_ADDR            = 0x020EC000,
+    FSL_IMX6UL_SDMA_SIZE            = 0x300,
+
     FSL_IMX6UL_GPT2_ADDR            = 0x020E8000,
+
     FSL_IMX6UL_IOMUXC_GPR_ADDR      = 0x020E4000,
+    FSL_IMX6UL_IOMUXC_GPR_SIZE      = 0x40,
+
     FSL_IMX6UL_IOMUXC_ADDR          = 0x020E0000,
+    FSL_IMX6UL_IOMUXC_SIZE          = 0x700,
+
     FSL_IMX6UL_GPC_ADDR             = 0x020DC000,
+
     FSL_IMX6UL_SRC_ADDR             = 0x020D8000,
+
     FSL_IMX6UL_EPIT2_ADDR           = 0x020D4000,
     FSL_IMX6UL_EPIT1_ADDR           = 0x020D0000,
+
     FSL_IMX6UL_SNVS_HP_ADDR         = 0x020CC000,
+
     FSL_IMX6UL_USBPHY2_ADDR         = 0x020CA000,
-    FSL_IMX6UL_USBPHY2_SIZE         = (4 * 1024),
     FSL_IMX6UL_USBPHY1_ADDR         = 0x020C9000,
-    FSL_IMX6UL_USBPHY1_SIZE         = (4 * 1024),
+
     FSL_IMX6UL_ANALOG_ADDR          = 0x020C8000,
+    FSL_IMX6UL_ANALOG_SIZE          = 0x300,
+
     FSL_IMX6UL_CCM_ADDR             = 0x020C4000,
+
     FSL_IMX6UL_WDOG2_ADDR           = 0x020C0000,
     FSL_IMX6UL_WDOG1_ADDR           = 0x020BC000,
+
     FSL_IMX6UL_KPP_ADDR             = 0x020B8000,
+    FSL_IMX6UL_KPP_SIZE             = 0x10,
+
     FSL_IMX6UL_ENET2_ADDR           = 0x020B4000,
+
     FSL_IMX6UL_SNVS_LP_ADDR         = 0x020B0000,
+    FSL_IMX6UL_SNVS_LP_SIZE         = (16 * KiB),
+
     FSL_IMX6UL_GPIO5_ADDR           = 0x020AC000,
     FSL_IMX6UL_GPIO4_ADDR           = 0x020A8000,
     FSL_IMX6UL_GPIO3_ADDR           = 0x020A4000,
     FSL_IMX6UL_GPIO2_ADDR           = 0x020A0000,
     FSL_IMX6UL_GPIO1_ADDR           = 0x0209C000,
+
     FSL_IMX6UL_GPT1_ADDR            = 0x02098000,
+
     FSL_IMX6UL_CAN2_ADDR            = 0x02094000,
     FSL_IMX6UL_CAN1_ADDR            = 0x02090000,
+    FSL_IMX6UL_CANn_SIZE            = (4 * KiB),
+
     FSL_IMX6UL_PWM4_ADDR            = 0x0208C000,
     FSL_IMX6UL_PWM3_ADDR            = 0x02088000,
     FSL_IMX6UL_PWM2_ADDR            = 0x02084000,
     FSL_IMX6UL_PWM1_ADDR            = 0x02080000,
+    FSL_IMX6UL_PWMn_SIZE            = 0x20,
+
     FSL_IMX6UL_AIPS1_CFG_ADDR       = 0x0207C000,
+    FSL_IMX6UL_AIPS1_CFG_SIZE       = (16 * KiB),
+
     FSL_IMX6UL_BEE_ADDR             = 0x02044000,
+    FSL_IMX6UL_BEE_SIZE             = (16 * KiB),
+
     FSL_IMX6UL_TOUCH_CTRL_ADDR      = 0x02040000,
+    FSL_IMX6UL_TOUCH_CTRL_SIZE      = 0x100,
+
     FSL_IMX6UL_SPBA_ADDR            = 0x0203C000,
+    FSL_IMX6UL_SPBA_SIZE            = 0x100,
+
     FSL_IMX6UL_ASRC_ADDR            = 0x02034000,
+    FSL_IMX6UL_ASRC_SIZE            = 0x100,
+
     FSL_IMX6UL_SAI3_ADDR            = 0x02030000,
     FSL_IMX6UL_SAI2_ADDR            = 0x0202C000,
     FSL_IMX6UL_SAI1_ADDR            = 0x02028000,
+    FSL_IMX6UL_SAIn_SIZE            = 0x200,
+
     FSL_IMX6UL_UART8_ADDR           = 0x02024000,
     FSL_IMX6UL_UART1_ADDR           = 0x02020000,
     FSL_IMX6UL_UART7_ADDR           = 0x02018000,
+
     FSL_IMX6UL_ECSPI4_ADDR          = 0x02014000,
     FSL_IMX6UL_ECSPI3_ADDR          = 0x02010000,
     FSL_IMX6UL_ECSPI2_ADDR          = 0x0200C000,
     FSL_IMX6UL_ECSPI1_ADDR          = 0x02008000,
+
     FSL_IMX6UL_SPDIF_ADDR           = 0x02004000,
+    FSL_IMX6UL_SPDIF_SIZE           = 0x100,
+    /* AIPS-1 End */
+
+    FSL_IMX6UL_BCH_ADDR             = 0x01808000,
+    FSL_IMX6UL_BCH_SIZE             = 0x200,
+
+    FSL_IMX6UL_GPMI_ADDR            = 0x01806000,
+    FSL_IMX6UL_GPMI_SIZE            = 0x200,
 
     FSL_IMX6UL_APBH_DMA_ADDR        = 0x01804000,
-    FSL_IMX6UL_APBH_DMA_SIZE        = (32 * 1024),
+    FSL_IMX6UL_APBH_DMA_SIZE        = (4 * KiB),
 
     FSL_IMX6UL_A7MPCORE_ADDR        = 0x00A00000,
 
     FSL_IMX6UL_OCRAM_ALIAS_ADDR     = 0x00920000,
-    FSL_IMX6UL_OCRAM_ALIAS_SIZE     = 0x00060000,
+    FSL_IMX6UL_OCRAM_ALIAS_SIZE     = (384 * KiB),
+
     FSL_IMX6UL_OCRAM_MEM_ADDR       = 0x00900000,
-    FSL_IMX6UL_OCRAM_MEM_SIZE       = 0x00020000,
+    FSL_IMX6UL_OCRAM_MEM_SIZE       = (128 * KiB),
+
     FSL_IMX6UL_CAAM_MEM_ADDR        = 0x00100000,
-    FSL_IMX6UL_CAAM_MEM_SIZE        = 0x00008000,
+    FSL_IMX6UL_CAAM_MEM_SIZE        = (32 * KiB),
+
     FSL_IMX6UL_ROM_ADDR             = 0x00000000,
-    FSL_IMX6UL_ROM_SIZE             = 0x00018000,
+    FSL_IMX6UL_ROM_SIZE             = (96 * KiB),
 };
 
 enum FslIMX6ULIRQs {
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 0fdd2782ba5..06a32aff647 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -64,7 +64,7 @@ static void fsl_imx6ul_init(Object *obj)
     object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
 
     /*
-     * GPIOs 1 to 5
+     * GPIOs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_GPIOS; i++) {
         snprintf(name, NAME_SIZE, "gpio%d", i);
@@ -72,7 +72,7 @@ static void fsl_imx6ul_init(Object *obj)
     }
 
     /*
-     * GPT 1, 2
+     * GPTs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_GPTS; i++) {
         snprintf(name, NAME_SIZE, "gpt%d", i);
@@ -80,7 +80,7 @@ static void fsl_imx6ul_init(Object *obj)
     }
 
     /*
-     * EPIT 1, 2
+     * EPITs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_EPITS; i++) {
         snprintf(name, NAME_SIZE, "epit%d", i + 1);
@@ -88,7 +88,7 @@ static void fsl_imx6ul_init(Object *obj)
     }
 
     /*
-     * eCSPI
+     * eCSPIs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
@@ -96,7 +96,7 @@ static void fsl_imx6ul_init(Object *obj)
     }
 
     /*
-     * I2C
+     * I2Cs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_I2CS; i++) {
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
@@ -104,7 +104,7 @@ static void fsl_imx6ul_init(Object *obj)
     }
 
     /*
-     * UART
+     * UARTs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_UARTS; i++) {
         snprintf(name, NAME_SIZE, "uart%d", i);
@@ -112,25 +112,31 @@ static void fsl_imx6ul_init(Object *obj)
     }
 
     /*
-     * Ethernet
+     * Ethernets
      */
     for (i = 0; i < FSL_IMX6UL_NUM_ETHS; i++) {
         snprintf(name, NAME_SIZE, "eth%d", i);
         object_initialize_child(obj, name, &s->eth[i], TYPE_IMX_ENET);
     }
 
-    /* USB */
+    /*
+     * USB PHYs
+     */
     for (i = 0; i < FSL_IMX6UL_NUM_USB_PHYS; i++) {
         snprintf(name, NAME_SIZE, "usbphy%d", i);
         object_initialize_child(obj, name, &s->usbphy[i], TYPE_IMX_USBPHY);
     }
+
+    /*
+     * USBs
+     */
     for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
         snprintf(name, NAME_SIZE, "usb%d", i);
         object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
     }
 
     /*
-     * SDHCI
+     * SDHCIs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
         snprintf(name, NAME_SIZE, "usdhc%d", i);
@@ -138,7 +144,7 @@ static void fsl_imx6ul_init(Object *obj)
     }
 
     /*
-     * Watchdog
+     * Watchdogs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
@@ -184,10 +190,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
      * A7MPCORE DAP
      */
     create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
-                                0x100000);
+                                FSL_IMX6UL_A7MPCORE_DAP_SIZE);
 
     /*
-     * GPT 1, 2
+     * GPTs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_GPTS; i++) {
         static const hwaddr FSL_IMX6UL_GPTn_ADDR[FSL_IMX6UL_NUM_GPTS] = {
@@ -212,7 +218,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * EPIT 1, 2
+     * EPITs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_EPITS; i++) {
         static const hwaddr FSL_IMX6UL_EPITn_ADDR[FSL_IMX6UL_NUM_EPITS] = {
@@ -237,7 +243,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * GPIO
+     * GPIOs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_GPIOS; i++) {
         static const hwaddr FSL_IMX6UL_GPIOn_ADDR[FSL_IMX6UL_NUM_GPIOS] = {
@@ -279,17 +285,12 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * IOMUXC and IOMUXC_GPR
+     * IOMUXC
      */
-    for (i = 0; i < 1; i++) {
-        static const hwaddr FSL_IMX6UL_IOMUXCn_ADDR[FSL_IMX6UL_NUM_IOMUXCS] = {
-            FSL_IMX6UL_IOMUXC_ADDR,
-            FSL_IMX6UL_IOMUXC_GPR_ADDR,
-        };
-
-        snprintf(name, NAME_SIZE, "iomuxc%d", i);
-        create_unimplemented_device(name, FSL_IMX6UL_IOMUXCn_ADDR[i], 0x4000);
-    }
+    create_unimplemented_device("iomuxc", FSL_IMX6UL_IOMUXC_ADDR,
+                                FSL_IMX6UL_IOMUXC_SIZE);
+    create_unimplemented_device("iomuxc_gpr", FSL_IMX6UL_IOMUXC_GPR_ADDR,
+                                FSL_IMX6UL_IOMUXC_GPR_SIZE);
 
     /*
      * CCM
@@ -309,7 +310,9 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->gpcv2), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpcv2), 0, FSL_IMX6UL_GPC_ADDR);
 
-    /* Initialize all ECSPI */
+    /*
+     * ECSPIs
+     */
     for (i = 0; i < FSL_IMX6UL_NUM_ECSPIS; i++) {
         static const hwaddr FSL_IMX6UL_SPIn_ADDR[FSL_IMX6UL_NUM_ECSPIS] = {
             FSL_IMX6UL_ECSPI1_ADDR,
@@ -337,7 +340,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * I2C
+     * I2Cs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_I2CS; i++) {
         static const hwaddr FSL_IMX6UL_I2Cn_ADDR[FSL_IMX6UL_NUM_I2CS] = {
@@ -363,7 +366,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * UART
+     * UARTs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_UARTS; i++) {
         static const hwaddr FSL_IMX6UL_UARTn_ADDR[FSL_IMX6UL_NUM_UARTS] = {
@@ -401,7 +404,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * Ethernet
+     * Ethernets
      *
      * We must use two loops since phy_connected affects the other interface
      * and we have to set all properties before calling sysbus_realize().
@@ -454,28 +457,45 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
     }
 
-    /* USB */
+    /*
+     * USB PHYs
+     */
     for (i = 0; i < FSL_IMX6UL_NUM_USB_PHYS; i++) {
+        static const hwaddr
+                     FSL_IMX6UL_USB_PHYn_ADDR[FSL_IMX6UL_NUM_USB_PHYS] = {
+            FSL_IMX6UL_USBPHY1_ADDR,
+            FSL_IMX6UL_USBPHY2_ADDR,
+        };
+
         sysbus_realize(SYS_BUS_DEVICE(&s->usbphy[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
-                        FSL_IMX6UL_USBPHY1_ADDR + i * 0x1000);
+                        FSL_IMX6UL_USB_PHYn_ADDR[i]);
     }
 
+    /*
+     * USBs
+     */
     for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
+        static const hwaddr FSL_IMX6UL_USB02_USBn_ADDR[FSL_IMX6UL_NUM_USBS] = {
+            FSL_IMX6UL_USBO2_USB1_ADDR,
+            FSL_IMX6UL_USBO2_USB2_ADDR,
+        };
+
         static const int FSL_IMX6UL_USBn_IRQ[] = {
             FSL_IMX6UL_USB1_IRQ,
             FSL_IMX6UL_USB2_IRQ,
         };
+
         sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
-                        FSL_IMX6UL_USBO2_USB_ADDR + i * 0x200);
+                        FSL_IMX6UL_USB02_USBn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
                            qdev_get_gpio_in(DEVICE(&s->a7mpcore),
                                             FSL_IMX6UL_USBn_IRQ[i]));
     }
 
     /*
-     * USDHC
+     * USDHCs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
         static const hwaddr FSL_IMX6UL_USDHCn_ADDR[FSL_IMX6UL_NUM_USDHCS] = {
@@ -507,7 +527,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0, FSL_IMX6UL_SNVS_HP_ADDR);
 
     /*
-     * Watchdog
+     * Watchdogs
      */
     for (i = 0; i < FSL_IMX6UL_NUM_WDTS; i++) {
         static const hwaddr FSL_IMX6UL_WDOGn_ADDR[FSL_IMX6UL_NUM_WDTS] = {
@@ -515,6 +535,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_WDOG2_ADDR,
             FSL_IMX6UL_WDOG3_ADDR,
         };
+
         static const int FSL_IMX6UL_WDOGn_IRQ[FSL_IMX6UL_NUM_WDTS] = {
             FSL_IMX6UL_WDOG1_IRQ,
             FSL_IMX6UL_WDOG2_IRQ,
@@ -535,33 +556,59 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * SDMA
      */
-    create_unimplemented_device("sdma", FSL_IMX6UL_SDMA_ADDR, 0x4000);
+    create_unimplemented_device("sdma", FSL_IMX6UL_SDMA_ADDR,
+                                FSL_IMX6UL_SDMA_SIZE);
 
     /*
-     * SAI (Audio SSI (Synchronous Serial Interface))
+     * SAIs (Audio SSI (Synchronous Serial Interface))
      */
-    create_unimplemented_device("sai1", FSL_IMX6UL_SAI1_ADDR, 0x4000);
-    create_unimplemented_device("sai2", FSL_IMX6UL_SAI2_ADDR, 0x4000);
-    create_unimplemented_device("sai3", FSL_IMX6UL_SAI3_ADDR, 0x4000);
+    for (i = 0; i < FSL_IMX6UL_NUM_SAIS; i++) {
+        static const hwaddr FSL_IMX6UL_SAIn_ADDR[FSL_IMX6UL_NUM_SAIS] = {
+            FSL_IMX6UL_SAI1_ADDR,
+            FSL_IMX6UL_SAI2_ADDR,
+            FSL_IMX6UL_SAI3_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "sai%d", i);
+        create_unimplemented_device(name, FSL_IMX6UL_SAIn_ADDR[i],
+                                    FSL_IMX6UL_SAIn_SIZE);
+    }
 
     /*
-     * PWM
+     * PWMs
      */
-    create_unimplemented_device("pwm1", FSL_IMX6UL_PWM1_ADDR, 0x4000);
-    create_unimplemented_device("pwm2", FSL_IMX6UL_PWM2_ADDR, 0x4000);
-    create_unimplemented_device("pwm3", FSL_IMX6UL_PWM3_ADDR, 0x4000);
-    create_unimplemented_device("pwm4", FSL_IMX6UL_PWM4_ADDR, 0x4000);
+    for (i = 0; i < FSL_IMX6UL_NUM_PWMS; i++) {
+        static const hwaddr FSL_IMX6UL_PWMn_ADDR[FSL_IMX6UL_NUM_PWMS] = {
+            FSL_IMX6UL_PWM1_ADDR,
+            FSL_IMX6UL_PWM2_ADDR,
+            FSL_IMX6UL_PWM3_ADDR,
+            FSL_IMX6UL_PWM4_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "pwm%d", i);
+        create_unimplemented_device(name, FSL_IMX6UL_PWMn_ADDR[i],
+                                    FSL_IMX6UL_PWMn_SIZE);
+    }
 
     /*
      * Audio ASRC (asynchronous sample rate converter)
      */
-    create_unimplemented_device("asrc", FSL_IMX6UL_ASRC_ADDR, 0x4000);
+    create_unimplemented_device("asrc", FSL_IMX6UL_ASRC_ADDR,
+                                FSL_IMX6UL_ASRC_SIZE);
 
     /*
-     * CAN
+     * CANs
      */
-    create_unimplemented_device("can1", FSL_IMX6UL_CAN1_ADDR, 0x4000);
-    create_unimplemented_device("can2", FSL_IMX6UL_CAN2_ADDR, 0x4000);
+    for (i = 0; i < FSL_IMX6UL_NUM_CANS; i++) {
+        static const hwaddr FSL_IMX6UL_CANn_ADDR[FSL_IMX6UL_NUM_CANS] = {
+            FSL_IMX6UL_CAN1_ADDR,
+            FSL_IMX6UL_CAN2_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "can%d", i);
+        create_unimplemented_device(name, FSL_IMX6UL_CANn_ADDR[i],
+                                    FSL_IMX6UL_CANn_SIZE);
+    }
 
     /*
      * APHB_DMA
@@ -579,13 +626,15 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         };
 
         snprintf(name, NAME_SIZE, "adc%d", i);
-        create_unimplemented_device(name, FSL_IMX6UL_ADCn_ADDR[i], 0x4000);
+        create_unimplemented_device(name, FSL_IMX6UL_ADCn_ADDR[i],
+                                    FSL_IMX6UL_ADCn_SIZE);
     }
 
     /*
      * LCD
      */
-    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR, 0x4000);
+    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
+                                FSL_IMX6UL_LCDIF_SIZE);
 
     /*
      * ROM memory
-- 
2.34.1


