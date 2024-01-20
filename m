Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A53A6833200
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 01:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQzcg-000339-1f; Fri, 19 Jan 2024 19:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rQzcb-00030a-Nk; Fri, 19 Jan 2024 19:54:05 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rQzcY-0000Ms-7R; Fri, 19 Jan 2024 19:54:04 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9bba6d773so1254610b3a.1; 
 Fri, 19 Jan 2024 16:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705712040; x=1706316840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=W2Cb/MXKuF5pIWbtveLjIz4MHiC4+lMOuof671Kw8og=;
 b=VBDGsP/vRMSetcM7vQpAYLKWHbJSL/u+Jsb5LYbd7sMetdvr/URq66PXGvlRzKuUUS
 07gW2bNClmqi+1Atl/eIv46jvebc4LfcZqcMnNfdczJFwKWrZlHcdLw3bzZQUUir1E0P
 SZnQwZ5MLfFalhIN+5vkVpOgEzxZW9moszkX2e17Ae+MBCWIk2cU7LJNZZAca8DlDFoC
 FvjTxdKdPY5/DjExqRXLaM7ggFjPgS6mqUQuxCoNbseCrOe0fr2WJCU/ynCq8/VFEa35
 UPv1ghLcBMhyHaQAGetzuQzgs+a/GEnAXDNmub37nIsWGtLIBwnhCrDFx/1MgbLtco+i
 z3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705712040; x=1706316840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2Cb/MXKuF5pIWbtveLjIz4MHiC4+lMOuof671Kw8og=;
 b=K+tW+zJwpK+pZnUsAyceL7cJ0akpVFgAMAEYQYipRPFRsfcvWc0a98knzXPHUio2Ci
 1a4gFBXWi9To2V9jf4qJiZ9tPsGDm7n5gpU4LRknPOtuzKZaG15UEXAuMp2X5mddgwJf
 98ETEsiuhbkjh6DH69ScJ9xD1dq3JxHvOdQOnlDcxevebxJ1/hU1tx+MpOyBCd6rDDpq
 y6pb5g3QTOI59c3R18U4Br5tVys5MCffbsSO01uxv3tLPl098CVtA6fDeX0cLvmlKwWI
 /9W6A/i3ymOInqXB9m9jiV+GbTNTOoFlX5/5RbxrTdsXw5sumt2KIqXbDQdKW6TNlygS
 bvSQ==
X-Gm-Message-State: AOJu0YwEZXTFjltZscAs0kPJDii/PEBRs/XSH/Lz/a3p/7OM7DxTnQyy
 ueCitqSgWHyGDKUz7gK18aHPboxoT+TXIcxec7fHguruUt3vRYZryvTkK7iG
X-Google-Smtp-Source: AGHT+IGDW5C9xIaM+USb8EJLQoIvmVitgUYZo6t+Y13BkDZtLj8t11zPJwpnXRjrIPTU3q+fqmlvhg==
X-Received: by 2002:a05:6a20:43ac:b0:19a:2e13:667a with SMTP id
 i44-20020a056a2043ac00b0019a2e13667amr1060674pzl.5.1705712040313; 
 Fri, 19 Jan 2024 16:54:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a056a00140a00b006d9b2694b0csm5652456pfu.200.2024.01.19.16.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 16:53:59 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH] fsl-imx6ul: Add various missing unimplemented devices
Date: Fri, 19 Jan 2024 16:53:56 -0800
Message-Id: <20240120005356.2599547-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
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

Add MMDC, OCOTP, SQPI, CAAM, and USBMISC as unimplemented devices.

This allows operating systems such as Linux to run emulations such as
mcimx6ul-evk.

Before commit 0cd4926b85 ("Refactor i.MX6UL processor code"), the affected
memory ranges were covered by the unimplemented DAP device. The commit
reduced the DAP address range from 0x100000 to 4kB, and the emulation
thus no longer covered the various unimplemented devices in the affected
address range.

Fixes: 0cd4926b85 ("Refactor i.MX6UL processor code")
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch is necessary to boot mcimx6ul-evk with Linux v6.7.

My apologies for the noise if a similar patch has already been submitted
and I missed it.

 hw/arm/fsl-imx6ul.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6ul.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index e37b69a5e1..7d2ee0df6e 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -192,6 +192,36 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
                                 FSL_IMX6UL_A7MPCORE_DAP_SIZE);
 
+    /*
+     * MMDC
+     */
+    create_unimplemented_device("a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
+                                FSL_IMX6UL_MMDC_CFG_SIZE);
+
+    /*
+     * OCOTP
+     */
+    create_unimplemented_device("a7mpcore-ocotp", FSL_IMX6UL_OCOTP_CTRL_ADDR,
+                                FSL_IMX6UL_OCOTP_CTRL_SIZE);
+
+    /*
+     * QSPI
+     */
+    create_unimplemented_device("a7mpcore-qspi", FSL_IMX6UL_QSPI_ADDR,
+                                FSL_IMX6UL_QSPI_SIZE);
+
+    /*
+     * CAAM
+     */
+    create_unimplemented_device("a7mpcore-qspi", FSL_IMX6UL_CAAM_ADDR,
+                                FSL_IMX6UL_CAAM_SIZE);
+
+    /*
+     * USBMISC
+     */
+    create_unimplemented_device("a7mpcore-usbmisc", FSL_IMX6UL_USBO2_USBMISC_ADDR,
+                                FSL_IMX6UL_USBO2_USBMISC_SIZE);
+
     /*
      * GPTs
      */
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 14390f6014..8277b0e8b2 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -182,6 +182,8 @@ enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_ENET1_ADDR           = 0x02188000,
 
     FSL_IMX6UL_USBO2_USBMISC_ADDR   = 0x02184800,
+    FSL_IMX6UL_USBO2_USBMISC_SIZE   = 0x200,
+
     FSL_IMX6UL_USBO2_USB1_ADDR      = 0x02184000,
     FSL_IMX6UL_USBO2_USB2_ADDR      = 0x02184200,
 
-- 
2.39.2


