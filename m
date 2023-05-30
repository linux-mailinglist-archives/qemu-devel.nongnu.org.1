Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F137161FB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNr-00085a-MM; Tue, 30 May 2023 09:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMs-0005e8-3S
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMo-0001OF-NS
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso32310855e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453182; x=1688045182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cb7tW0OrRUlLGsWKm9Wt1qUNMT77CsNBwWCPAxZNsz8=;
 b=F99oshoIb0a4BpGIsKNj/qvwufmntZ1c4KVtKoiG66ExFG5FY7RCGwQDWG1Ii8QdRp
 jXNx+1cvzgZFNHrAmFFcnUSZPlldObt0XKhO7R7/XnosIVvAQsObVYju03jXhxG3cTit
 74jfO5lGqer8P2xnznqtCmnaTnQSO3Ax6zX8ll8WQniI4imGnscFmhKEDW2mKx1Oj/he
 RQByEqMAI5N22yGhb22uGNcgKl+YbgBYbuDGIHLxbkeQoWEm9To1uaAhm1sWwqWSiV0Q
 fUr+s6LAhlWri+o4EPW5g0Iz6QeL+1ErRtYq1UHTZNn0oVS7EAg46CpsSMZa1mN1HXTr
 OP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453182; x=1688045182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cb7tW0OrRUlLGsWKm9Wt1qUNMT77CsNBwWCPAxZNsz8=;
 b=SiBNls27eYmDus0X9Rm8ZCea3xNucQ/V3VRDqOEugJRgzmMTUAfFipRPiuA0yrXAbD
 42mOMWC1sfnif+SHVtsO5CfJLA7j/XIQBBXKB3Xof1TFqi0bvIwP5+19VzoQhsWGlDeq
 IuM/2wiBlugfyoPQkNRSFp9aVD2wdfKPIaRPrQ4RabaLcmuYoemXhSihv7b879GGZMaU
 +dm1mbhvWlqxGqQ1q52g7O8nu81OZmmDSsY+0hrY7n2Jb1awzt+fip3J1QZy7S0JoouO
 voNVDBSdH5QPJULSBhfTLQDwYXSPHxSrBcrhidm4mlCRFiAroeAvDc+mgNiHvgZUbBrr
 Bm5Q==
X-Gm-Message-State: AC+VfDzOXJ3LtoY2mDmn8spl5yArgjjxWC3quD89Ttgr1kKHsUzruaQD
 5bWToopzCfrHE6gU+mC6x0rq2Sfk5AshMdI11nI=
X-Google-Smtp-Source: ACHHUZ53D5dvCw/qDf9Pyk+HKZeNwsL0PfLtbSkxN71MwQKv1i0r0sZ5YgpNuYUR3/iwg+f5vIF1HQ==
X-Received: by 2002:a05:600c:3b27:b0:3f7:a7c:b039 with SMTP id
 m39-20020a05600c3b2700b003f70a7cb039mr2482938wms.2.1685453182472; 
 Tue, 30 May 2023 06:26:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/21] fsl-imx6: Add SNVS support for i.MX6 boards
Date: Tue, 30 May 2023 14:26:00 +0100
Message-Id: <20230530132620.1583658-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vitaly Cheptsov <cheptsov@ispras.ru>

SNVS is supported on both i.MX6 and i.MX6UL and is needed
to support shutdown on the board.

Cc: Peter Maydell <peter.maydell@linaro.org> (odd fixer:SABRELITE / i.MX6)
Cc: Jean-Christophe Dubois <jcd@tribudubois.net> (reviewer:SABRELITE / i.MX6)
Cc: qemu-arm@nongnu.org (open list:SABRELITE / i.MX6)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Signed-off-by: Vitaly Cheptsov <cheptsov@ispras.ru>
Message-id: 20230515095015.66860-1-cheptsov@ispras.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h | 2 ++
 hw/arm/fsl-imx6.c         | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 83291457cf2..5b4d48da084 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -21,6 +21,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/misc/imx6_ccm.h"
 #include "hw/misc/imx6_src.h"
+#include "hw/misc/imx7_snvs.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
@@ -59,6 +60,7 @@ struct FslIMX6State {
     A9MPPrivState  a9mpcore;
     IMX6CCMState   ccm;
     IMX6SRCState   src;
+    IMX7SNVSState  snvs;
     IMXSerialState uart[FSL_IMX6_NUM_UARTS];
     IMXGPTState    gpt;
     IMXEPITState   epit[FSL_IMX6_NUM_EPITS];
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 00dafe3f62d..4fa7f0b95ed 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -53,6 +53,8 @@ static void fsl_imx6_init(Object *obj)
 
     object_initialize_child(obj, "src", &s->src, TYPE_IMX6_SRC);
 
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
     for (i = 0; i < FSL_IMX6_NUM_UARTS; i++) {
         snprintf(name, NAME_SIZE, "uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -390,6 +392,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->a9mpcore),
                                         FSL_IMX6_ENET_MAC_1588_IRQ));
 
+    /*
+     * SNVS
+     */
+    sysbus_realize(SYS_BUS_DEVICE(&s->snvs), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0, FSL_IMX6_SNVSHP_ADDR);
+
     /*
      * Watchdog
      */
-- 
2.34.1


