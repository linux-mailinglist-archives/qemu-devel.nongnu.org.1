Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D43831C1D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:14:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTzf-0007pg-Bb; Thu, 18 Jan 2024 10:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzd-0007os-6a; Thu, 18 Jan 2024 10:07:45 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzb-00083P-Bj; Thu, 18 Jan 2024 10:07:44 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d6ff29293dso10371045ad.0; 
 Thu, 18 Jan 2024 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590462; x=1706195262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uvt6s8NPiwBagvDIiZVPQjnwzx6PyMl/Fio7Q/ZImPo=;
 b=Ji4ItDfmu6OUFoBD8ZFvCg9BU5X8YMqd/Lp5gGAPO1MAA0ho7KsBr7cNC84mZ1eyNG
 UXv7tuAn4xp1ImI05cnDcmFWibX0QJeJO0ga6Lu40HbVvraWYDi/HgjQ3OY5UWAUbnn5
 PygvylLW5JskKWaaMj/P5cUIF9mPvDxqarvNKHyyUhqxbdy5Vv16vJMgpiGUvz3w0e+Y
 iUKtiM4MHGrqTuL6Dj3jvQuxFwuTcHKQ8UgvqPWkH72R5Z2WypgTBvrjS01631q15MeP
 DbuVOoNIcSQn5yKB0H8ym5N+IdFwX4LeoQHI0ylnXDfXdVSmGyzATAjppICdIUAvdsI1
 bkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590462; x=1706195262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uvt6s8NPiwBagvDIiZVPQjnwzx6PyMl/Fio7Q/ZImPo=;
 b=syIKih9HzvBuWsiC5baCMuc47hKu4a3qgoLptQIpP+s8clEd2g50C/3hZLcDsF832i
 /KMYLIp0IDeW/VdcqkCKmlpwZW9Q8J6O7rOs1fGWWwWs7tnysZUQIjPNaA3C4kgE6+VT
 k6aAGTYkSXjQwU2CuIHjkLs0pUrzvfCnCZNLwPWs8t14Lrg8R6R+G8SwQma5X/M150BB
 0RhRPfXIuX/FJQAEsJB2pm6Y9TffGmnjuVs0Kbx5qUBwEBSmCKPNyaIkegli6SNC+RT8
 TmickQxyt8nTmgENZSAGQp8KvgRJXhf7IfxZPJ0PTeaG57Das4PlZfNxfyi/QQ6/t+ZY
 /YIQ==
X-Gm-Message-State: AOJu0Yx53zUX1PoBAdrWUPPS+PpsJS1oaieL3cQ5qzZ9XreQMA13lqCi
 5uBVATeogVDl+rS3fEadFl1/5AMZKUE+nTU6wTVh1MqK7px3Z3HdgDECyvdH
X-Google-Smtp-Source: AGHT+IE+TvzSARj/WVqq5T1RNXYF22iQxYIFjJ5Uk5pB87/7ZxxXsS2IwZirm/deG0KLN4yIG48Q7g==
X-Received: by 2002:a17:903:1d1:b0:1d7:eb1:a053 with SMTP id
 e17-20020a17090301d100b001d70eb1a053mr791264plh.18.1705590461749; 
 Thu, 18 Jan 2024 07:07:41 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 10/26] ppc/pnv: Wire ChipTOD model to powernv9 and powernv10
 machines
Date: Fri, 19 Jan 2024 01:06:28 +1000
Message-ID: <20240118150644.177371-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Wire the ChipTOD model to powernv9 and powernv10 machines.

Suggested-by-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_chip.h |  3 +++
 hw/ppc/pnv.c              | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 0ab5c42308..bfc4772cf3 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -2,6 +2,7 @@
 #define PPC_PNV_CHIP_H
 
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_chiptod.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_lpc.h"
@@ -78,6 +79,7 @@ struct Pnv9Chip {
     PnvXive      xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
@@ -110,6 +112,7 @@ struct Pnv10Chip {
     PnvXive2     xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9db8fcd19e..f0456e2acf 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1505,6 +1505,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
 
+    object_initialize_child(obj, "chiptod", &chip9->chiptod, TYPE_PNV9_CHIPTOD);
+
     object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
 
     object_initialize_child(obj, "sbe", &chip9->sbe, TYPE_PNV9_SBE);
@@ -1651,6 +1653,19 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV9_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&chip9->chiptod), "primary",
+                             chip->chip_id == 0, &error_abort);
+    object_property_set_bool(OBJECT(&chip9->chiptod), "secondary",
+                             chip->chip_id == 1, &error_abort);
+    object_property_set_link(OBJECT(&chip9->chiptod), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip9->chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_CHIPTOD_BASE,
+                            &chip9->chiptod.xscom_regs);
+
     /* Create the simplified OCC model */
     if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
         return;
@@ -1763,6 +1778,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
                               "xive-fabric");
     object_initialize_child(obj, "psi", &chip10->psi, TYPE_PNV10_PSI);
     object_initialize_child(obj, "lpc", &chip10->lpc, TYPE_PNV10_LPC);
+    object_initialize_child(obj, "chiptod", &chip10->chiptod,
+                            TYPE_PNV10_CHIPTOD);
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
@@ -1896,6 +1913,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV10_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&chip10->chiptod), "primary",
+                             chip->chip_id == 0, &error_abort);
+    object_property_set_bool(OBJECT(&chip10->chiptod), "secondary",
+                             chip->chip_id == 1, &error_abort);
+    object_property_set_link(OBJECT(&chip10->chiptod), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip10->chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_CHIPTOD_BASE,
+                            &chip10->chiptod.xscom_regs);
+
     /* Create the simplified OCC model */
     if (!qdev_realize(DEVICE(&chip10->occ), NULL, errp)) {
         return;
-- 
2.42.0


