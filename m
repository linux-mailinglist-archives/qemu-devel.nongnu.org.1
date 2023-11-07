Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF297E4A17
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Szv-0006bD-Fg; Tue, 07 Nov 2023 15:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szt-0006ZO-5C; Tue, 07 Nov 2023 15:48:29 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szq-0006S4-AN; Tue, 07 Nov 2023 15:48:28 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6cd09663b1cso3828877a34.3; 
 Tue, 07 Nov 2023 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390100; x=1699994900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5xpGmY9XXVbSVdbl74ir/lrmvxBgkZdGG6zA0sfySU=;
 b=Bhje6p01bbyaAHnujUflsETai8NV/oByEJ1kTEbRvSMnsTW0tcXl1CSZM9m2O1G71v
 jnjQK/3glBXnWD7330S0T78OHBm10wEXWyBFKPrlFA91KQIG6XeyKzOxF2Dm3kLX0olO
 znXKwILGst76P8FBBX7neDwGm5f8HmNwx5IRkBA/ZwQPq7DIFlmSXDOMt3kbE8jB61RU
 tjLgSIjN/jrkUyr02D+bLd+yLMAFklEY7aIvPYd9Cib6bB/fh61TKCfvBpyDwxwk9inb
 qRpE1wG6CqbwnExboPaIqqCeWYImAUlnXs1Coq1IT876mybAxKw/rhf3wen2B92O51Fi
 6YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390100; x=1699994900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5xpGmY9XXVbSVdbl74ir/lrmvxBgkZdGG6zA0sfySU=;
 b=eUwGkL2S/uC4NbvxZZ7HXkqT1UIXgrTb9yO7jBFL7stuaYyfJ0VeD/0RkL8Wv4IZKY
 sSfbNN/ETV9Wkjh8+BTKTIdBPFCeM0PG891opNKoTPWjbMhm2bsEIu5iocm9iOiKQT36
 zFwamC2VHhjuLNP2ybsQiyjq7+Ren03NQTAJi53Qe/JfF90BpXn2SMv/lysDjCWe4jog
 tEz94bRw+iOo9ON4iWRIktlSDzAr5cPlzsVUJir5wN0McqLkJTFw1ueKY7f5v6U7A4uQ
 ortPtgh9Kn6tseAaJxNq5yR4qh6t5OELIcBSG7ZqzEsKjGIlRMw087u4+DTAtujwGERr
 1e6A==
X-Gm-Message-State: AOJu0YyY4VJ+MiSBJW89xMpHs6k4PHhpz75tIvO3UGW2MuM19qn3ayKG
 MdhQUog16G1Jce5JcSifw2eRWzZGNik=
X-Google-Smtp-Source: AGHT+IFx54VtUIKhQmJuOq9Ob7bCGr5mQ5U068gmVRDKnHe+KAG1sGo0xbqefdcY6BvkIEZMG/UybQ==
X-Received: by 2002:a05:6830:1e57:b0:6cd:a9d:bc57 with SMTP id
 e23-20020a0568301e5700b006cd0a9dbc57mr32558249otj.32.1699390100725; 
 Tue, 07 Nov 2023 12:48:20 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:20 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 5/9] ppc/pnv: Connect I2C controller model to powernv9 chip
Date: Tue,  7 Nov 2023 17:48:02 -0300
Message-ID: <20231107204806.8507-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
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

From: Cédric Le Goater <clg@kaod.org>

Wires up three I2C controller instances to the powernv9 chip
XSCOM address space.

Each controller instance is wired up to a single I2C bus of
its own.  No other I2C devices are connected to the buses
at this time.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
[milesg: Split wiring from addition of model itself]
[milesg: Added new commit message]
[milesg: Moved hardcoded attributes into PnvChipClass]
[milesg: Removed TODO comment for I2C]
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Acked-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20231016222013.3739530-3-milesg@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv.c              | 28 ++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c0e34fffbc..bb4d00e266 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1432,6 +1432,10 @@ static void pnv_chip_power9_instance_init(Object *obj)
         object_initialize_child(obj, "pec[*]", &chip9->pecs[i],
                                 TYPE_PNV_PHB4_PEC);
     }
+
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        object_initialize_child(obj, "i2c[*]", &chip9->i2c[i], TYPE_PNV_I2C);
+    }
 }
 
 static void pnv_chip_quad_realize_one(PnvChip *chip, PnvQuad *eq,
@@ -1504,6 +1508,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     PnvChip *chip = PNV_CHIP(dev);
     Pnv9Psi *psi9 = &chip9->psi;
     Error *local_err = NULL;
+    int i;
 
     /* XSCOM bridge is first */
     pnv_xscom_init(chip, PNV9_XSCOM_SIZE, PNV9_XSCOM_BASE(chip));
@@ -1602,6 +1607,27 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+
+    /*
+     * I2C
+     */
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        Object *obj =  OBJECT(&chip9->i2c[i]);
+
+        object_property_set_int(obj, "engine", i + 1, &error_fatal);
+        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+                                &error_fatal);
+        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
+        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
+            return;
+        }
+        pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
+                               chip9->i2c[i].engine * PNV9_XSCOM_I2CM_SIZE,
+                                &chip9->i2c[i].xscom_regs);
+        qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&chip9->psi),
+                                               PSIHB9_IRQ_SBE_I2C));
+    }
 }
 
 static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -1629,6 +1655,8 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     k->xscom_pcba = pnv_chip_power9_xscom_pcba;
     dc->desc = "PowerNV Chip POWER9";
     k->num_pecs = PNV9_CHIP_MAX_PEC;
+    k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
+    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
 
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
                                     &k->parent_realize);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 53e1d921d7..90cfbad1a5 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -9,6 +9,7 @@
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_sbe.h"
 #include "hw/ppc/pnv_xive.h"
+#include "hw/ppc/pnv_i2c.h"
 #include "hw/sysbus.h"
 
 OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
@@ -86,6 +87,10 @@ struct Pnv9Chip {
 
 #define PNV9_CHIP_MAX_PEC 3
     PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
+
+#define PNV9_CHIP_MAX_I2C 3
+#define PNV9_CHIP_MAX_I2C_PORTS 1
+    PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
 };
 
 /*
@@ -130,6 +135,9 @@ struct PnvChipClass {
     uint32_t     num_pecs;
     uint32_t     num_phbs;
 
+    uint32_t     i2c_num_engines;
+    uint32_t     i2c_num_ports;
+
     DeviceRealize parent_realize;
 
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
-- 
2.41.0


