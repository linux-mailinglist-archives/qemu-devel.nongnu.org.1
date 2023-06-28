Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3F74191D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDG-0004i7-Qc; Wed, 28 Jun 2023 15:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDF-0004ho-Eu
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:25 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDD-0005j5-TP
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:25 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98e1ccc6673so23174766b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981942; x=1690573942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrA+4PmMXDulwwNnZ2Eajp9IPfFETxnEjuY+hG4KFbI=;
 b=MvudMRoe3gtJRyDV8MpbflDMKeHfkwu8jByvpJek3RVqXQGczjLOx18LjAfjpCGBbk
 LjaRPT1YEd0Bfwu3zcFd7p0Wd1y6IXT8HZ00xgMXgcAaHN1baUNmLo5PMxQlIBvd4+rB
 6oEmC9B+aOfzyAVw6idoWbeq9LwuuGrAnK/QvYZoA3PLZTJxO7XgqaXPcw0/WlppGC98
 WpDIQzT7mQM1Vm+TC0943M1PBTLx2QJHXQyFXlA9785LBtPehE2QQhBHLznRhqdIocKq
 4yc/zvh2t17gI3PGHWGMU2Y/dkK66Dr2K5qfoDfjxcqKOwvPSmnjdG+YOTQshhndCvji
 G8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981942; x=1690573942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrA+4PmMXDulwwNnZ2Eajp9IPfFETxnEjuY+hG4KFbI=;
 b=JIk5U7ZZy2JwDjeeTcAIEU9npU8Uzasmp6cmSZ9EX9PKdOppP7AS8sQVvCOwNl6vwP
 z6v2B0gf7Nbd9mqpFoPkFOmn9TMa7rvHcFb3UpQH86VBSGrEimMvf5/9u3fpInC0FWLA
 9PiC3jNua8zOV7cz+lJ0uJ4YeO/aO86mvj5ocsBvg0M6XHFdqjw1VvcKWGNsNWQdCkXL
 FdDv8aK7TWVCvonrFIAufKSO4FREGfponl3z6nYUthtjwxJKC66HDbDWdqaZQPDUWfdb
 qgpsfsfw/y/QexdylaNDSF+AROXImE8feVKlXB3pr4Lm3RFoHkgRn9Z1H8ROP/XTo/9J
 DStQ==
X-Gm-Message-State: AC+VfDx9eQJQ6sMR2Pdnh43CfdldSu0Kk+TDt7oXw+pe/GIVJgkhFzus
 GKoyGg7YRCkFsj957QR00+yp7AOguKs=
X-Google-Smtp-Source: ACHHUZ7sXM5WfkFHJw+nKFN8zO0YuoJlhJp+ood9xn3ThkX/Kwe6nQo7SqBVECVPgaOw4jTak2C3IA==
X-Received: by 2002:a17:907:36c6:b0:974:1d8b:ca5e with SMTP id
 bj6-20020a17090736c600b009741d8bca5emr29301752ejc.14.1687981941964; 
 Wed, 28 Jun 2023 12:52:21 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/16] hw/pci-host/i440fx: Move i440fx_realize() into
 PCII440FXState section
Date: Wed, 28 Jun 2023 21:51:57 +0200
Message-ID: <20230628195204.1241-10-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

i440fx_realize() realizes the PCI device inside the host bridge
(PCII440FXState), but is implemented between i440fx_pcihost_realize() and
i440fx_init() which deal with the host bridge itself (I440FXState). Since we
want to append i440fx_init() to i440fx_pcihost_realize() later let's move
i440fx_realize() out of the way.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/i440fx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 88beaf99c4..9df4688b2e 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -65,6 +65,15 @@ struct I440FXState {
  */
 #define I440FX_COREBOOT_RAM_SIZE 0x57
 
+static void i440fx_realize(PCIDevice *dev, Error **errp)
+{
+    dev->config[I440FX_SMRAM] = 0x02;
+
+    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
+        warn_report("i440fx doesn't support emulated iommu");
+    }
+}
+
 static void i440fx_update_memory_mappings(PCII440FXState *d)
 {
     int i;
@@ -229,15 +238,6 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
     memory_region_add_coalescing(&phb->conf_mem, 0, 4);
 }
 
-static void i440fx_realize(PCIDevice *dev, Error **errp)
-{
-    dev->config[I440FX_SMRAM] = 0x02;
-
-    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
-        warn_report("i440fx doesn't support emulated iommu");
-    }
-}
-
 PCIBus *i440fx_init(const char *pci_type,
                     DeviceState *dev,
                     MemoryRegion *address_space_mem,
-- 
2.41.0


