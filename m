Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D17A0F20
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAS-000361-LX; Thu, 14 Sep 2023 16:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgtAD-00035S-6X
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:13 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgtAB-00063I-1k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:12 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a9d6b98845so559136866b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694724129; x=1695328929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MUMu/RjMRNg/e06IUEJmt9iKdjw1m+hGQfjqbaKgZlE=;
 b=QbJUkOlfQBtKSf4UJEzmm6zPavCcgC9XhUWK8f7OyfUiJImewnWL1WkCygSrlEgkPC
 o5VKvy8tYT/haTxJfs5VeIbGHY/mGMcdBMP4f3yhqsiE61ap8uRyZXCaJKZ68Eh+bjC/
 TIfvg9fPO96Y1TqPB+xkKiro/zJn2+ZWCAjVM/tyz+R+R2MOuxUgJFd1Xz8k4Mii3UHw
 BTTSH/S120aZyIOaqu53zz43b+TReh6XpnqFcmhLqinAOQJjn0vTWvkR56Yc8n3gjzb0
 M406HXxv6PCOH/FeeGgnz1Oqthtu41LetcAJ7+VYVBsSDMMR4oF/7W/4yVKBUveaGyQ5
 /xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724129; x=1695328929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MUMu/RjMRNg/e06IUEJmt9iKdjw1m+hGQfjqbaKgZlE=;
 b=VAPh95Hl1BHuPoS4fgDVGq3tzdb+bni/flyDjMCVVYb9dx/maecb4FbRi7FXyhpfjb
 kogdN0lqODlWq2F+bb+yORXAMP4tRuiOfnyRn1kFtOIsIdj/1tClGCi8WRBm9qb51sLx
 w9NV1NSV3Gr4XeXNQg0Rl+uNGit2U6emIm+00JuQLVHcoqGbzr1bC4iYGcRo1q6Hez6Y
 q04qQ2piVGBoUzE5XV3/2m9eH+wdJzcOl2Ut9SSKfqC99OGIhLfNHc/LpViKv8KM3vcD
 BKdeJM1GlpyXbUYj5gCHKwPMeokSe39b959lUHveT390krYkkfnL4FYkWlW3lOzYqQNE
 wFfw==
X-Gm-Message-State: AOJu0Yw6Pl14xvskqphUQjaZ4jA8a+UUrstBt9JEa0gfDCrD3SQ1Qmnm
 Pi9VHOfO8Bd/rPpVtQvCJuVmOLukqVttQATlNoM=
X-Google-Smtp-Source: AGHT+IG8AXEUJLJOqsbBEoGfVk8a54E//KT3I8GELjDecfQYFou9+U0+3oXd+C9x7FO3IyNL+rM4Dw==
X-Received: by 2002:a17:906:73cc:b0:9a9:f0e6:904e with SMTP id
 n12-20020a17090673cc00b009a9f0e6904emr4139944ejl.16.1694724129113; 
 Thu, 14 Sep 2023 13:42:09 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a170906595500b00992f2befcbcsm1477519ejr.180.2023.09.14.13.42.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 13:42:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Fran=C3=A7ois=20Revol?= <revol@free.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Stefan Agner <stefan@agner.ch>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] pc-bios/canyonlands.dts: Fix some DeviceTree warnings
Date: Thu, 14 Sep 2023 22:42:05 +0200
Message-ID: <20230914204206.79351-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

canyonlands.dts was imported in 2018, in commit 4b387f9ee1
("ppc: Add aCube Sam460ex board"). The file content is based
on Linux file arch/powerpc/boot/dts/canyonlands.dts from
commit 5edc2aae16bc. Then Linux added 2 commits on top:
- 86bc917d2ac1 ("powerpc/boot/dts: Fix dtc "pciex" warnings")
- eca213152a36 ("powerpc/4xx: Complete removal of MSI support")

Backport the same commits in order to fix some of the following
warnings which started to appear since commit 6e0dc9d2a8 ("meson:
compile bundled device trees"):

  [7831/8926] Generating pc-bios/canyonlands.dts with a custom command
  pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
  pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
  pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): /plb/pciex@d00000000: node name is not "pci" or "pcie"
  pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): /plb/pciex@d20000000: node name is not "pci" or "pcie"
  pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dts:268.14-289.7: Warning (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 pc-bios/canyonlands.dts | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/pc-bios/canyonlands.dts b/pc-bios/canyonlands.dts
index 0d6ac92d0f..5db1bff6b2 100644
--- a/pc-bios/canyonlands.dts
+++ b/pc-bios/canyonlands.dts
@@ -461,7 +461,7 @@
 			interrupt-map = < 0x0 0x0 0x0 0x0 &UIC1 0x0 0x8 >;
 		};
 
-		PCIE0: pciex@d00000000 {
+		PCIE0: pcie@d00000000 {
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -503,7 +503,7 @@
 				0x0 0x0 0x0 0x4 &UIC3 0xf 0x4 /* swizzled int D */>;
 		};
 
-		PCIE1: pciex@d20000000 {
+		PCIE1: pcie@d20000000 {
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -544,23 +544,5 @@
 				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
 		};
-
-		MSI: ppc4xx-msi@C10000000 {
-			compatible = "amcc,ppc4xx-msi", "ppc4xx-msi";
-			reg = < 0xC 0x10000000 0x100>;
-			sdr-base = <0x36C>;
-			msi-data = <0x00000000>;
-			msi-mask = <0x44440000>;
-			interrupt-count = <3>;
-			interrupts = <0 1 2 3>;
-			interrupt-parent = <&UIC3>;
-			#interrupt-cells = <1>;
-			#address-cells = <0>;
-			#size-cells = <0>;
-			interrupt-map = <0 &UIC3 0x18 1
-					1 &UIC3 0x19 1
-					2 &UIC3 0x1A 1
-					3 &UIC3 0x1B 1>;
-		};
 	};
 };
-- 
2.41.0


