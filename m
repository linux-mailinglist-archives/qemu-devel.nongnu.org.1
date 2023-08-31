Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D19578EB03
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBN-0003yj-SC; Thu, 31 Aug 2023 06:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfBB-0003dg-DE
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB3-000446-HM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401bdff4cb4so6265695e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478727; x=1694083527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sd1LpcRGVzLeKAumLs+R9eKwSti+aOLRgWtTQkeU06w=;
 b=fbtZPfauRjc03aQGWiw9oqImTURiHM4a3r6q68Z/SooO0rxTUkQkTuDzGxHPoCTvNy
 7cwFYQikO9e4vnV0O6GK0tvLLTDfTG6P/8HRS38+7zO/E58Lljn89SPzlpSPs5TKu/QB
 354S/oAnuIeSlWf0VnUYFcWc6REKhRreGUi5XwOW3uYyNzOfdXk2u/Zs9whiMaG6B5dJ
 t2iNGde2FNSBseHfcL3dji/GdzBDESTLNfXFBJt+L8h+7SRnojNMwBhDVefsk593aGyt
 OYOmXwL7zCEO06yw7CLQ1EU2Umyid5wOKbAUsLiRLyNSvQqCrlJAgEkg4Te3INoEna60
 moMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478727; x=1694083527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sd1LpcRGVzLeKAumLs+R9eKwSti+aOLRgWtTQkeU06w=;
 b=Mibzr8dH/Gq6MRLkDtZwQgZZLlJH27QcxJO4TgvdpfQB7d5n09YWCAibGBHku1WZVF
 c0DYcZIuAo/QujyO84EXW3t2vYWMjgWeEBjDHhtrwluOrGBC/TEeXJtOXJK2znBvBUqw
 OWz+JMRYbMpVUHQnIPsz/YSOUfUYbFkjjVFaCs3QHxSORDtdF5EDbt/EiBBOv1mLpEO8
 eTz7ygMmsVZeN8FegJPnjlOoDrRTyQKioOnpOLolNpskfgKBbqEzLpAROSC/iONy832R
 4iDGXdb9htdMpzgdmS9mnNFwmuv5GF3DX5uSE/LDk8/qiS2uZDfFZZ9zcvOW1IP4010g
 O08w==
X-Gm-Message-State: AOJu0Ywlv7/kgHOc+bHRS3G9yh/x6ISFmSxOqoph583sH2AqHEe+mGRO
 kVpmILyssWYw/vLKSbd+SxEUpJKyi74m7sgK2pY=
X-Google-Smtp-Source: AGHT+IHvM7/DXoqnqUf7kFIIt4DSBeK1RLGOfCdTiazVn5YErcDyidHzOc7dLv5+mF8MXhioCbVQFA==
X-Received: by 2002:a5d:4845:0:b0:319:666e:b466 with SMTP id
 n5-20020a5d4845000000b00319666eb466mr4034400wrs.42.1693478726934; 
 Thu, 31 Aug 2023 03:45:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] Add i.MX7 missing TZ devices and memory regions
Date: Thu, 31 Aug 2023 11:45:10 +0100
Message-Id: <20230831104519.3520658-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
* Add various memory segments
  - OCRAM
  - OCRAM EPDC
  - OCRAM PXP
  - OCRAM S
  - ROM
  - CAAM

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: f887a3483996ba06d40bd62ffdfb0ecf68621987.1692964892.git.jcd@tribudubois.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx7.h |  7 +++++
 hw/arm/fsl-imx7.c         | 63 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 06b2c5e4acf..01e15004d76 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -84,6 +84,13 @@ struct FslIMX7State {
     IMX7GPRState       gpr;
     ChipideaState      usb[FSL_IMX7_NUM_USBS];
     DesignwarePCIEHost pcie;
+    MemoryRegion       rom;
+    MemoryRegion       caam;
+    MemoryRegion       ocram;
+    MemoryRegion       ocram_epdc;
+    MemoryRegion       ocram_pxp;
+    MemoryRegion       ocram_s;
+
     uint32_t           phy_num[FSL_IMX7_NUM_ETHS];
     bool               phy_connected[FSL_IMX7_NUM_ETHS];
 };
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index e9760535393..97e982bf061 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -664,6 +664,69 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("pcie-phy", FSL_IMX7_PCIE_PHY_ADDR,
                                 FSL_IMX7_PCIE_PHY_SIZE);
 
+    /*
+     * CSU
+     */
+    create_unimplemented_device("csu", FSL_IMX7_CSU_ADDR,
+                                FSL_IMX7_CSU_SIZE);
+
+    /*
+     * TZASC
+     */
+    create_unimplemented_device("tzasc", FSL_IMX7_TZASC_ADDR,
+                                FSL_IMX7_TZASC_SIZE);
+
+    /*
+     * OCRAM memory
+     */
+    memory_region_init_ram(&s->ocram, NULL, "imx7.ocram",
+                           FSL_IMX7_OCRAM_MEM_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_MEM_ADDR,
+                                &s->ocram);
+
+    /*
+     * OCRAM EPDC memory
+     */
+    memory_region_init_ram(&s->ocram_epdc, NULL, "imx7.ocram_epdc",
+                           FSL_IMX7_OCRAM_EPDC_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_EPDC_ADDR,
+                                &s->ocram_epdc);
+
+    /*
+     * OCRAM PXP memory
+     */
+    memory_region_init_ram(&s->ocram_pxp, NULL, "imx7.ocram_pxp",
+                           FSL_IMX7_OCRAM_PXP_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_PXP_ADDR,
+                                &s->ocram_pxp);
+
+    /*
+     * OCRAM_S memory
+     */
+    memory_region_init_ram(&s->ocram_s, NULL, "imx7.ocram_s",
+                           FSL_IMX7_OCRAM_S_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_S_ADDR,
+                                &s->ocram_s);
+
+    /*
+     * ROM memory
+     */
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx7.rom",
+                           FSL_IMX7_ROM_SIZE, &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_ROM_ADDR,
+                                &s->rom);
+
+    /*
+     * CAAM memory
+     */
+    memory_region_init_rom(&s->caam, OBJECT(dev), "imx7.caam",
+                           FSL_IMX7_CAAM_MEM_SIZE, &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_CAAM_MEM_ADDR,
+                                &s->caam);
 }
 
 static Property fsl_imx7_properties[] = {
-- 
2.34.1


