Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5167E4A1E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Szu-0006aS-He; Tue, 07 Nov 2023 15:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szr-0006YE-TK; Tue, 07 Nov 2023 15:48:27 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szq-0006SM-5e; Tue, 07 Nov 2023 15:48:27 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cd6e1d4fbso36742141cf.1; 
 Tue, 07 Nov 2023 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390104; x=1699994904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuiB8YLB6fW19Sv4iIZuZRWwFlQIhnLJeadaVGwfrms=;
 b=DYYYcgIPLVJbzJhbsn6tUq0UAn2z5rKAadcdNzB1FHOVPIfXJLJeBtpLCyO3pqobsg
 L4oP/s6qFzzABoO2egeFrMO9UYaUu2OB6SbrcBZfoxtdoH+CmBjjMbQt1xJQFQO3M/B0
 MFSsnh1aScKCfQ0iSZ7YORGIInJ30Ev0nq+oPhBoCy5q8uBCQJ4T5lPS/jNuke209u55
 bs9MmabZb/G6nR53tlwBvNUOog6yTW4O3IUSiUkwApYh4kA+xXt9dYBm8gXq39cFE2L4
 csYuWklbZrUBciQHiB+8NsfNnapT4sxMiz11s7t2Mhv/rRymdf7OQuaNJrKjO49zPPDz
 Bl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390104; x=1699994904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuiB8YLB6fW19Sv4iIZuZRWwFlQIhnLJeadaVGwfrms=;
 b=sr71KsXQ+xq6V4ewJtqIF/fkC2nMhhHe19M/lo7WhbecqdiwMKkBneT4IYIPClOjBI
 eD71HAw3n6oW/kkj8B4fp30iGKG6FAdU1DF/Kf5gEgQHThrOIjCdW77uXQcSyRNyKQ5Q
 F6L9CDyDdqzN+T6r6CDyScZpfsqyBTJ4i4jj+7UV7n+tloqXdal429HYQBRAwUIHjPAd
 aeP90ADudvz6+y43DeAz/CieTRGglHju91kntFFICVlVst7K6Czy6GTCCAyIHzDtocDV
 l8wj3OfGnb/sxMLVStf/jVXtB+sEPYgYeef4P+e4WV16cXnIXdti70Ln4yv9d7d1JXPz
 AZDQ==
X-Gm-Message-State: AOJu0YxXEvdA7N9QN9FzIr+waMaUCI7iaIdMEcNS9FMfHjEpFwUUe4zn
 9UPisEyFHGH/8e7E+OoRf00YBPoGyaI=
X-Google-Smtp-Source: AGHT+IHmwHIWejHpTz+YaRHBguR/1xfLwspLpuT7RAgmXOxj7ynshxOtYUCKVsUDKwGtHYWnNjv+jg==
X-Received: by 2002:a05:622a:1b8e:b0:41c:c2ad:6810 with SMTP id
 bp14-20020a05622a1b8e00b0041cc2ad6810mr1584qtb.2.1699390104464; 
 Tue, 07 Nov 2023 12:48:24 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:24 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 7/9] ppc/pnv: Fix number of I2C engines and ports for power9/10
Date: Tue,  7 Nov 2023 17:48:04 -0300
Message-ID: <20231107204806.8507-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x830.google.com
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

Power9 is supposed to have 4 PIB-connected I2C engines with the
following number of ports on each engine:

    0: 2
    1: 13
    2: 2
    3: 2

Power10 also has 4 engines but has the following number of ports
on each engine:

    0: 14
    1: 14
    2: 2
    3: 16

Current code assumes that they all have the same (maximum) number.
This can be a problem if software expects to see a certain number
of ports present (Power Hypervisor seems to care).

Fixed this by adding separate tables for power9 and power10 that
map the I2C controller number to the number of I2C buses that should
be attached for that engine.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Message-ID: <20231025152714.956664-1-milesg@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv.c              | 12 ++++++++----
 include/hw/ppc/pnv_chip.h |  6 ++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ae8e0b45cd..9c29727337 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1615,7 +1615,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip9->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pcc->i2c_ports_per_engine[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1640,6 +1641,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
+    static const int i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
@@ -1656,7 +1658,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER9";
     k->num_pecs = PNV9_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
+    k->i2c_ports_per_engine = i2c_ports_per_engine;
 
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
                                     &k->parent_realize);
@@ -1861,7 +1863,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip10->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pcc->i2c_ports_per_engine[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1886,6 +1889,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
+    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
 
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
@@ -1902,7 +1906,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER10";
     k->num_pecs = PNV10_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
+    k->i2c_ports_per_engine = i2c_ports_per_engine;
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
                                     &k->parent_realize);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 5815d96ecf..0ab5c42308 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -88,8 +88,7 @@ struct Pnv9Chip {
 #define PNV9_CHIP_MAX_PEC 3
     PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
 
-#define PNV9_CHIP_MAX_I2C 3
-#define PNV9_CHIP_MAX_I2C_PORTS 1
+#define PNV9_CHIP_MAX_I2C 4
     PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
 };
 
@@ -122,7 +121,6 @@ struct Pnv10Chip {
     PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
 
 #define PNV10_CHIP_MAX_I2C 4
-#define PNV10_CHIP_MAX_I2C_PORTS 2
     PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
 };
 
@@ -140,7 +138,7 @@ struct PnvChipClass {
     uint32_t     num_phbs;
 
     uint32_t     i2c_num_engines;
-    uint32_t     i2c_num_ports;
+    const int    *i2c_ports_per_engine;
 
     DeviceRealize parent_realize;
 
-- 
2.41.0


