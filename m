Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E520B74AFF2
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHji4-0004AF-SI; Fri, 07 Jul 2023 07:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji2-0003yN-Qy; Fri, 07 Jul 2023 07:33:10 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhw-0006pZ-EJ; Fri, 07 Jul 2023 07:33:10 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b75637076eso1627667a34.2; 
 Fri, 07 Jul 2023 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729577; x=1691321577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k61BptTOwj98xOgsrzjqXszhqFKZTaKD33+onC34AMU=;
 b=jJxzL8fmGloo/q+z+E2CdnQZfVbD6a6YD+vqTNyxQnt01Clo/JlgED7Y7e7yiOuaSK
 cbSM0GPkXGy/lKg62jrd5wdf6OwIaoqTaWEuU1yHN5gD4o0XyF0LEvlEC6bqCGyT1Omy
 Bqbf3ypNKjQFIa7+bV8qYgTHhqigCwE9EhopzywHtxhiKBRjUREyrUDm5fzUEi0vjbb0
 d5cU6RjXEbz60rUVyD6xD6q2exBz+j9ygtd7BhOLbWdcWzOb5lim07M/JfKkvtz5XTy/
 UtYWBf6G7kgU+BV4v7ddse9ZFxbyfDqA2hmXzixD8f9lnu7Wgfxe00IfF7ACHkAyBvZc
 lqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729577; x=1691321577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k61BptTOwj98xOgsrzjqXszhqFKZTaKD33+onC34AMU=;
 b=LBaLsW7UYCH9zrA+vU+l3X4+qMmEbwSl1cm7Pea72s6k+bW0NiuvdXdZprvAtuI+Bb
 6tmHfA123DMaT+qse8+U6praXyhMKkqiVNuBXWqstL77PiAeebIs7ncmo35wyHDvleE5
 I4tgVA91MFhd1bQk30ePWQ2fdmuZFVMZKSOCAsnSjWbz4PS4XYaX5HtakWZc4bUg/bc6
 q43/i6JBTSU3gnSiHqAj5FwDOr3L3NZQjfLMevDrMZ4q+/YRCqUC8giGKR2rp/FDVw1x
 pD9UovBXpaj9lN6WVkCn0+J6p0Aiq03hk4h2dg6ZonGze5K6R+Z1NmHyzW8O3fCLjTva
 O86w==
X-Gm-Message-State: ABy/qLbqQ7rFSXnvVlesoY5AFAqWTYO3PD4aY44QotyC/hPS2QgwpPXn
 mszUdJ09AmN80//pOCp0GuiK9C/pdZM=
X-Google-Smtp-Source: APBJJlGfuiB1L3YMJrWeK5s+unKTNbsizK51xZT4Uwn8w1T4p3sR/QMthUaaEID6t3FNBFRIMXbytA==
X-Received: by 2002:a05:6830:2057:b0:6b7:43eb:c1a with SMTP id
 f23-20020a056830205700b006b743eb0c1amr4084736otp.36.1688729577228; 
 Fri, 07 Jul 2023 04:32:57 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:57 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/60] ppc440: Add a macro to shorten PCIe controller DCR
 registration
Date: Fri,  7 Jul 2023 08:30:45 -0300
Message-ID: <20230707113108.7145-38-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

It is shorter and more readable to wrap the complex call to
ppc_dcr_register() in a macro than to repeat it several times.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <4dec5ef8115791dc67253afdff9a703eb816a2a8.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_uc.c | 76 +++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index b26c0cee1b..b36dc409d7 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1002,56 +1002,36 @@ static void ppc460ex_set_irq(void *opaque, int irq_num, int level)
        qemu_set_irq(s->irq[irq_num], level);
 }
 
+#define PPC440_PCIE_DCR(s, dcrn) \
+    ppc_dcr_register(&(s)->cpu->env, (s)->dcrn_base + (dcrn), (s), \
+                     &dcr_read_pcie, &dcr_write_pcie)
+
+
 static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s)
 {
-    CPUPPCState *env = &s->cpu->env;
-
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_SPECIAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFG, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
+    PPC440_PCIE_DCR(s, PEGPL_CFGBAH);
+    PPC440_PCIE_DCR(s, PEGPL_CFGBAL);
+    PPC440_PCIE_DCR(s, PEGPL_CFGMSK);
+    PPC440_PCIE_DCR(s, PEGPL_MSGBAH);
+    PPC440_PCIE_DCR(s, PEGPL_MSGBAL);
+    PPC440_PCIE_DCR(s, PEGPL_MSGMSK);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1BAH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1BAL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1MSKH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1MSKL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2BAH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2BAL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2MSKH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2MSKL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3BAH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3BAL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3MSKH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3MSKL);
+    PPC440_PCIE_DCR(s, PEGPL_REGBAH);
+    PPC440_PCIE_DCR(s, PEGPL_REGBAL);
+    PPC440_PCIE_DCR(s, PEGPL_REGMSK);
+    PPC440_PCIE_DCR(s, PEGPL_SPECIAL);
+    PPC440_PCIE_DCR(s, PEGPL_CFG);
 }
 
 static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
-- 
2.41.0


