Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B27FA792
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:09:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f6C-0007UK-Kb; Mon, 27 Nov 2023 12:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f68-0007Tq-Bn
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:40 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f62-0004e0-Jk
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b479b9c35so6825895e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104912; x=1701709712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wRdrICC2oih1nk4CtbmyH20uNE3N+a54F03dwas6lTc=;
 b=mI0KGuxtsAcXZUJ1A1Xzx8Cv4gK0XWGQFRpie9JG0ZJS520KpnApy32T2gjTCobdxe
 aYQi11BFm3XFNHOSBHFV52wbwX2aJ2LIeyGM+7fai6DWw5eA2dElzERXzv7FjPcgGv89
 F3l+0PH+dlOw28rLWc2P/NF7fOuyYNH3v4ppg7GNgKuUynYMjBTsFrrVBIQqfVseNBmx
 TQhm2WS+2Pb0jI//fczfD8uPrtSpiLBVXzL1yP65Lsj5+5Enps/kOKEKw+fA/+VZzTtP
 IpNQNzolB+xaZ0inGQT4BT7XTTlKbLlmWa93dRFzsavPlj75v1aQlLCoBv0wf1V1P/2r
 Ko6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104912; x=1701709712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRdrICC2oih1nk4CtbmyH20uNE3N+a54F03dwas6lTc=;
 b=NOPvb/10OY7fwsrXfNlRdyisYql6UIU5me55YfHrRsaUdG2aFwAqgIesXrb0kWo+J0
 jaQIWLSJb1bU5RIN0rPS048gtu3Npy1gNmyPLWrXsW9C4vdX9VAAh+0/3B7LnfC/xZ+Q
 ZMF7HonlRJFUi81rAd6BXzNoh5vthBckoVnjGj+2rszXwuQljTQ3Lp3nu9eJ4OdrETIj
 6qZwH+zofqT3DdLVzA1Dh4yoTAUWtRUhd1EFfGQ2G0GNJPrIvSSEa2snaT15O5mYedmB
 lTZIGSSzjbVZ0Q6npLVWcIjuIzDi8u+MDdmfn5AQWYov8lk2M36EEvbMHuZwskl/YYvu
 utwA==
X-Gm-Message-State: AOJu0YzEuXlka2wEewejdXNzuNFQOiR8mhW+M4bLaJ6YUKZTWuteHGyr
 VGJT5NsiOQQSXyWKwhgpo+XQqp6zmYuwx2+JbO8=
X-Google-Smtp-Source: AGHT+IHlOmK6POWBUtYYRO8kMb41bSVSPf1at9A9WMkGYIRXhYJAeEizzrTUQvvIjSyFqQQ9xh7rCQ==
X-Received: by 2002:a05:600c:1d95:b0:407:3b6d:b561 with SMTP id
 p21-20020a05600c1d9500b004073b6db561mr10255685wms.9.1701104912187; 
 Mon, 27 Nov 2023 09:08:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] hw/misc, hw/ssi: Fix some URLs for AMD / Xilinx models
Date: Mon, 27 Nov 2023 17:08:22 +0000
Message-Id: <20231127170823.589863-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Frederic Konrad <fkonrad@amd.com>

It seems that the url changed a bit, and it triggers an error.  Fix the URLs so
the documentation can be reached again.

Signed-off-by: Frederic Konrad <fkonrad@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20231124143505.1493184-3-fkonrad@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/xlnx-versal-cframe-reg.h   | 2 +-
 include/hw/misc/xlnx-versal-cfu.h          | 2 +-
 include/hw/misc/xlnx-versal-pmc-iou-slcr.h | 2 +-
 include/hw/ssi/xlnx-versal-ospi.h          | 2 +-
 hw/dma/xlnx_csu_dma.c                      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
index a14fbd7fe45..0091505246f 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -12,7 +12,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/CFRAME_REG-Module
  */
 #ifndef HW_MISC_XLNX_VERSAL_CFRAME_REG_H
 #define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 86fb8410538..be62bab8c8c 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -12,7 +12,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/CFU_CSR-Module
  */
 #ifndef HW_MISC_XLNX_VERSAL_CFU_APB_H
 #define HW_MISC_XLNX_VERSAL_CFU_APB_H
diff --git a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
index f7d24c93c41..0c4a4fd66d9 100644
--- a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
+++ b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
@@ -34,7 +34,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-register-reference.html#mod___pmc_iop_slcr.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/PMC_IOP_SLCR-Module
  *
  * QEMU interface:
  * + sysbus MMIO region 0: MemoryRegion for the device's registers
diff --git a/include/hw/ssi/xlnx-versal-ospi.h b/include/hw/ssi/xlnx-versal-ospi.h
index 5d131d351d2..4ac975aa2fd 100644
--- a/include/hw/ssi/xlnx-versal-ospi.h
+++ b/include/hw/ssi/xlnx-versal-ospi.h
@@ -34,7 +34,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-register-reference.html#mod___ospi.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/OSPI-Module
  *
  *
  * QEMU interface:
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index e89089821a3..531013f35aa 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -33,7 +33,7 @@
 
 /*
  * Ref: UG1087 (v1.7) February 8, 2019
- * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers.html
+ * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers
  * CSUDMA Module section
  */
 REG32(ADDR, 0x0)
-- 
2.34.1


