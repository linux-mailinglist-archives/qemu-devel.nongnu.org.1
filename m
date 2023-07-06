Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6374950A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHib-0003I1-Cr; Thu, 06 Jul 2023 01:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHHiM-0003GY-Gl; Thu, 06 Jul 2023 01:39:38 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHHiJ-0003z8-VC; Thu, 06 Jul 2023 01:39:38 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a1e6022b93so385357b6e.1; 
 Wed, 05 Jul 2023 22:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688621974; x=1691213974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+kP5o6dJuQmIYekhU8jJbdaQArbeV9ocjVg3lz9hx4=;
 b=IQCwrBNWiBzm4xjLblLu71BHcRPf/AKEsj8z2ycK+kArib6XcwtadtvZet9zmqfm5M
 1BJTrj/A1Vz7hqcz60T0GM4rIPSz/FiOVGralvOYTzpFyxpWGHwr22NnRTsQyZe7MCf4
 snmVTl7PdEvS8JZt4+WMEuJbUvhXZvXNvjIdejEQ73zxXh3afVsBoM/RZIZgfnEGUqJ4
 VlOuam199TO9e+04haVWULeD0ZXOI16+IIk9aGcD3X2+RmMDz7dZoJRtyyMDY2BAkMFn
 M1JcJREEL0XPB5gz58d2HxCVHQoNUk9j9WmkEiHdRDvJ4Rnm/Pj3mkYKk/SmYXNWbl7u
 D1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688621974; x=1691213974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+kP5o6dJuQmIYekhU8jJbdaQArbeV9ocjVg3lz9hx4=;
 b=AQlt+dcwhT6COhs+UrGIv44xYq/7VD8S6odLjH/RyQdBGQhCyhgGA8yeQ3YVA5FeBG
 hwD1wEIYJv0Vi0hahhbB6FFuOXlMW+T0qHJpgd5FpVsOfCFOQ4AlT7atTExANaV+gqVn
 x0JE0q4iXvxXwNgIIDYXE9FyrDzU+Hbj7fKR92tdoqCnHIF98PcJpp7dViYXGFwUcPEk
 e5CE+TY706+Sdfoqsi7qN7m6J5vsDVA1s87Em0GL7rpF50E1AXWbO9pmhf6KKWzJLfet
 QO/JbWWyX5nkhlJS/XkVDx0wLRXnYP4yEMzEDiQLlvou90RMWbmFGzV4dVh+Ke2rpst8
 3bgw==
X-Gm-Message-State: ABy/qLbEKa9ro2W0lJUFkK6Fb2waGTGakEMnnWqzYm/I8ESwC1kMRqiu
 XH1SykqksJn8CLQi8hv8h/0=
X-Google-Smtp-Source: APBJJlGWBzDnQq8SusFOdLBQYlSktpk4ObcOicAH3AEH13MbyY4PC8VJcY5WpnPNi7bDy/pljq+J2A==
X-Received: by 2002:a05:6808:c8:b0:3a1:188c:9311 with SMTP id
 t8-20020a05680800c800b003a1188c9311mr671500oic.24.1688621974276; 
 Wed, 05 Jul 2023 22:39:34 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 ix10-20020a170902f80a00b001b3d8ac1b6bsm427764plb.212.2023.07.05.22.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 22:39:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 1/2] ppc/pnv: Set P10 core xscom region size to match
 hardware
Date: Thu,  6 Jul 2023 15:39:22 +1000
Message-Id: <20230706053923.115003-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706053923.115003-1-npiggin@gmail.com>
References: <20230706053923.115003-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22a.google.com
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

The P10 core xscom memory regions overlap because the size is wrong.
The P10 core+L2 xscom region size is allocated as 0x1000 (with some
unused ranges). "EC" is used as a closer match, as "EX" includes L3
which has a disjoint xscom range that would require a different
region if it were implemented.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c          | 6 ++++--
 include/hw/ppc/pnv_core.h  | 1 +
 include/hw/ppc/pnv_xscom.h | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8a72171ce0..aa363e4b85 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -296,9 +296,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     }
 
     snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
-    /* TODO: check PNV_XSCOM_EX_SIZE for p10 */
     pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
-                          pc, name, PNV_XSCOM_EX_SIZE);
+                          pc, name, pcc->xscom_size);
 
     qemu_register_reset(pnv_core_reset, pc);
     return;
@@ -350,6 +349,7 @@ static void pnv_core_power8_class_init(ObjectClass *oc, void *data)
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
     pcc->xscom_ops = &pnv_core_power8_xscom_ops;
+    pcc->xscom_size = PNV_XSCOM_EX_SIZE;
 }
 
 static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
@@ -357,6 +357,7 @@ static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
     pcc->xscom_ops = &pnv_core_power9_xscom_ops;
+    pcc->xscom_size = PNV_XSCOM_EX_SIZE;
 }
 
 static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
@@ -364,6 +365,7 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
     pcc->xscom_ops = &pnv_core_power10_xscom_ops;
+    pcc->xscom_size = PNV10_XSCOM_EC_SIZE;
 }
 
 static void pnv_core_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 77ef00f47a..aa5ca281fc 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -46,6 +46,7 @@ struct PnvCoreClass {
     DeviceClass parent_class;
 
     const MemoryRegionOps *xscom_ops;
+    uint64_t xscom_size;
 };
 
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f7da9a1dc6..a4c9d95dc5 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -133,7 +133,7 @@ struct PnvXScomInterfaceClass {
 
 #define PNV10_XSCOM_EC_BASE(core) \
     ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
-#define PNV10_XSCOM_EC_SIZE        0x100000
+#define PNV10_XSCOM_EC_SIZE        0x1000
 
 #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
-- 
2.40.1


