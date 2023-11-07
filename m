Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E07E4A1D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Szt-0006Zm-WA; Tue, 07 Nov 2023 15:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szr-0006YB-PA; Tue, 07 Nov 2023 15:48:27 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szq-0006S9-2V; Tue, 07 Nov 2023 15:48:27 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-41eae4ebf61so23760481cf.2; 
 Tue, 07 Nov 2023 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390102; x=1699994902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2SjJKUXICgckq0rxRRR2hDp8rA78V8HEAIGqAivwTg=;
 b=mTBI4KrQHd/8g+E/2pDStpOm//R/33YXUeFaW0DYhnWPy5K0SM2W6lrH4Z8RZPQ85z
 0qNADLlsPqEVBV9/XnkmNMrKZwdeNU1URr6tYUB0K1SfwVLK7TS7gB6o0fayprnXD8E0
 B8UNbd6j9wvnCpnsqumI/nASCyfmOEBz+b3qnd0HXLOYa+ppD/GOdBmiu/rCRIgSCGIy
 wNw5PDUjt9cnVE2tIPlFpEDrqp9lxmQLzVPAkWJ7mQpgXR/W5znJE2N9tPHoMykoN3Pz
 3AhTxFVLzIiZChdlQcFeKxXqQzLfRFPsXv8JwSI14YO+2IiTBnYI/pl8kKkHG6mJyjqy
 eMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390102; x=1699994902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2SjJKUXICgckq0rxRRR2hDp8rA78V8HEAIGqAivwTg=;
 b=oDF7cZV3xxRWpfo5b0PFZvQqBAVwsY4OHdX45NVFDciqOFBXgo7NtHnBs0tF4ANaZ/
 BIql85xvUBGQ5bDa6tGoaQ4XSbIN0q4oxYw4bhXjLWDjPK0C0fIyLO16t2ua8zdUQMZe
 my0M0wskBdVZ0qt9hROYHe5BllvPDSmxCK+4SZfEwJL2qv6TLZ1Ju8HZKc2BXm1oVxIM
 xYm85UiUL2g0OBNwbjM0nNd0B1olOuTX+yzW0p/MyNzfNkgBs7cyDwhKDgxHT+rTmzPp
 ig54OY7T8imutkN8dGWXxQ9RWUxCh5IKGClvxBYeGdtkaN2Bp0L8T5r8OxJsbOav16H+
 dn6g==
X-Gm-Message-State: AOJu0YxXAkG4rNNpy6JPtPGtczRZRs5mOzGrMA+R3gj1mToTvk/IzRs3
 K/Efb2W6HnlbZV3eNiNOPN95d0B0BcQ=
X-Google-Smtp-Source: AGHT+IHJVYqMpdTkfeclhEJRgbnRtbm+kyfpy223hZQigKFGHRM8kolEzVqkuyU1Hc9aRCnP3Qtkcg==
X-Received: by 2002:ac8:7f83:0:b0:417:b970:f2a4 with SMTP id
 z3-20020ac87f83000000b00417b970f2a4mr40029225qtj.1.1699390102570; 
 Tue, 07 Nov 2023 12:48:22 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:22 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 6/9] ppc/pnv: Connect PNV I2C controller to powernv10
Date: Tue,  7 Nov 2023 17:48:03 -0300
Message-ID: <20231107204806.8507-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x82c.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Wires up four I2C controller instances to the powernv10 chip
XSCOM address space.

Each controller instance is wired up to two I2C buses of
its own.  No other I2C devices are connected to the buses
at this time.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv.c               | 29 +++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h  |  4 ++++
 include/hw/ppc/pnv_xscom.h |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index bb4d00e266..ae8e0b45cd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1684,6 +1684,10 @@ static void pnv_chip_power10_instance_init(Object *obj)
         object_initialize_child(obj, "pec[*]", &chip10->pecs[i],
                                 TYPE_PNV_PHB5_PEC);
     }
+
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
+    }
 }
 
 static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
@@ -1742,6 +1746,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     PnvChip *chip = PNV_CHIP(dev);
     Pnv10Chip *chip10 = PNV10_CHIP(dev);
     Error *local_err = NULL;
+    int i;
 
     /* XSCOM bridge is first */
     pnv_xscom_init(chip, PNV10_XSCOM_SIZE, PNV10_XSCOM_BASE(chip));
@@ -1847,6 +1852,28 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+
+
+    /*
+     * I2C
+     */
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        Object *obj =  OBJECT(&chip10->i2c[i]);
+
+        object_property_set_int(obj, "engine", i + 1, &error_fatal);
+        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+                                &error_fatal);
+        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
+        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
+            return;
+        }
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
+                                chip10->i2c[i].engine * PNV10_XSCOM_I2CM_SIZE,
+                                &chip10->i2c[i].xscom_regs);
+        qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&chip10->psi),
+                                               PSIHB9_IRQ_SBE_I2C));
+    }
 }
 
 static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -1874,6 +1901,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     k->xscom_pcba = pnv_chip_power10_xscom_pcba;
     dc->desc = "PowerNV Chip POWER10";
     k->num_pecs = PNV10_CHIP_MAX_PEC;
+    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
+    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
                                     &k->parent_realize);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 90cfbad1a5..5815d96ecf 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -120,6 +120,10 @@ struct Pnv10Chip {
 
 #define PNV10_CHIP_MAX_PEC 2
     PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
+
+#define PNV10_CHIP_MAX_I2C 4
+#define PNV10_CHIP_MAX_I2C_PORTS 2
+    PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
 };
 
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 056392ab60..f5becbab41 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -152,6 +152,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
 
+#define PNV10_XSCOM_I2CM_BASE      PNV9_XSCOM_I2CM_BASE
+#define PNV10_XSCOM_I2CM_SIZE      PNV9_XSCOM_I2CM_SIZE
+
 #define PNV10_XSCOM_OCC_BASE       PNV9_XSCOM_OCC_BASE
 #define PNV10_XSCOM_OCC_SIZE       PNV9_XSCOM_OCC_SIZE
 
-- 
2.41.0


