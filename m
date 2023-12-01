Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD05800AB9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92TA-00065O-A1; Fri, 01 Dec 2023 07:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92SB-0005Yi-9H; Fri, 01 Dec 2023 07:17:11 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92S9-0006Mx-6u; Fri, 01 Dec 2023 07:17:07 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cddc59e731so1864034b3a.1; 
 Fri, 01 Dec 2023 04:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433023; x=1702037823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtHGRZF6+qlNeXTS0wG4HtUh3/2nP9FjM8yjvGmOaek=;
 b=iGba2KdnO2dGI+u4O/WFHeqQWT12kp3a/1G9xPWNOfeUe+u5ab0TvfHPw7ohE026+J
 Jj7pr8T9Ym8CBO8+85XxI5sdd7NaKUUa5LaO45jeDPn9sGVWM9ZB11f1ef3p5KEaJbDE
 vbEwzXlJ7Nmza0P5oa2B7KmiXNgf8GLW+MzDkhMv2zg3EooiqZWBAyz/Ztc2AiIz4HAg
 JlcvpC0BeJLzxy2+R3Bv6rXqp/0VY/YoaxDBaH6psHc9ffItr6zASPhNs6MnuhEBwxi6
 CEpQn68qyRMZ6LlKHGg7GOlM3cRH7oTRh0NV3oa6t7Pm6oy3x9hON5y6rThPKJpjJ/gQ
 pO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433023; x=1702037823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtHGRZF6+qlNeXTS0wG4HtUh3/2nP9FjM8yjvGmOaek=;
 b=usoAHoFT3Zsx5PA8vKfj+IsvjJex8xppW2PYEtfaIgtfYqo+9d1OBPxY1dMqihc8tn
 fs9NLfYo+221sYe8N8drZx7O1bwx8MadjTE9vXHh8BLBMp6dnJlSC5BPjPOLkE7LZmA2
 u3duC2IXPJDjDFl5fW9lEdRSImG2fcbwCV8iThovBQCvuGANbEYJuLA3T9BdtSEKW2SJ
 AWw5ytu7iStqM6fPU8+8lDyVQtQx7A33o8GjyhmaRHyyFdMa8gAsgDZhwGEP6cpl8chE
 eJprQZUK2Eth3I++oiEg5Y4u2GF+ZRkXnHdUo64jy54gXFd0Fxl279yTVAAUAvpUeR3g
 ExsA==
X-Gm-Message-State: AOJu0YzdfPR33WnfJofDWPI0mI8E00zmmuTZTTwTQLv06rBa5hGuo+Zk
 vidff10L06d1avT9f3vdFbS00bsSYH8=
X-Google-Smtp-Source: AGHT+IHi+6v8ZS1UcqqB4TX3k8mfteN4NzDffpSWzINYpG8XU8QuREfc7oEDtpE5t7Or5X0pUKPrNA==
X-Received: by 2002:a05:6a00:e17:b0:6cb:8beb:15dc with SMTP id
 bq23-20020a056a000e1700b006cb8beb15dcmr24344059pfb.30.1701433022767; 
 Fri, 01 Dec 2023 04:17:02 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006cdd39faaaesm2830782pfd.20.2023.12.01.04.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:17:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] ppc/pnv: Wire ChipTOD model to powernv9 and powernv10
 machines
Date: Fri,  1 Dec 2023 22:16:33 +1000
Message-ID: <20231201121636.142694-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201121636.142694-1-npiggin@gmail.com>
References: <20231201121636.142694-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
index b949398689..d38888cb76 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1419,6 +1419,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
 
+    object_initialize_child(obj, "chiptod", &chip9->chiptod, TYPE_PNV9_CHIPTOD);
+
     object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
 
     object_initialize_child(obj, "sbe", &chip9->sbe, TYPE_PNV9_SBE);
@@ -1565,6 +1567,19 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
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
@@ -1677,6 +1692,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
                               "xive-fabric");
     object_initialize_child(obj, "psi", &chip10->psi, TYPE_PNV10_PSI);
     object_initialize_child(obj, "lpc", &chip10->lpc, TYPE_PNV10_LPC);
+    object_initialize_child(obj, "chiptod", &chip10->chiptod,
+                            TYPE_PNV10_CHIPTOD);
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
@@ -1810,6 +1827,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
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


