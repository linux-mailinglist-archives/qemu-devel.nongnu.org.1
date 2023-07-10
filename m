Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A780B74E1E1
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzv5-0006V9-Oa; Mon, 10 Jul 2023 19:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzv3-0006K2-Mi
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzv2-0004Os-5q
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Muy8inKfvBPASO7rYLT1LevUdIo8+kfo/7lFDLCwAW8=;
 b=RZZquMPXGO/FTH2HIZ7/8CMwBmnlWSbZAdTy4A2FO4laRGxnSd0RrjqVoKZm5/xsHrUSWW
 LzuYtnXb+g8N3o4w5VY29MI5cF/wOiEhExxaS9oDNx8aYSjdB+z2Dz24VSHoD67MxTyYw7
 FHmblSeNzEVSoBz7U7I8EapiyycOGjI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-W4dBKDuDPVeHZ1JnJXfrTw-1; Mon, 10 Jul 2023 19:03:46 -0400
X-MC-Unique: W4dBKDuDPVeHZ1JnJXfrTw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315998d6e7fso1080471f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030224; x=1691622224;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Muy8inKfvBPASO7rYLT1LevUdIo8+kfo/7lFDLCwAW8=;
 b=WExKSNaEirQslc5IsokviqDn27scP0zEMvzZfb+5QNo9VyS+14p9iFqD8munNu6hNM
 6ZCN3nysvGjrBCOB7OnCCiIowOP6TsuBuNvG/6LBcJoaDPPVMLnY4BES7ix+2L5yOAuP
 FBvXNygU3LMz4zk0gbDS3g2Jw5zGf//qg0rZFEdIAOiP8e6gsjrrzRnW2zxjdQzzcHAB
 GBAjlZ8g4XQwQkhjkZUQFjcdEn/7PUtmKp2gN5sB5UUkxRlPFAwsF1b/GoW4qEBYWc88
 sEKIRxS92949+aJOFpZIuBk5NLtYdaV+F3GQWG+uEb0mw3W0gUDTQqa06wvScYmYxFfB
 vI4Q==
X-Gm-Message-State: ABy/qLY4L5dA6qZ8Ui9Hcez4ZAa/NpZQELIoHMRRAgH5zwEkHJhV2Auf
 Xi1YAxBexXhaDJmAFUAjJp+ZGY2VDoZgV+viO/k/oPaBqkCNLcS6lIcyccjBgvPytZ9yMPivDX9
 Cr+P0j7uv7B2B/25A16yg4QnVovMqwcJiIy9wu4FduucXfhOXDLViCdmZQ2G92aDn3A/B
X-Received: by 2002:adf:fe43:0:b0:314:1a98:ebc0 with SMTP id
 m3-20020adffe43000000b003141a98ebc0mr11566161wrs.26.1689030224838; 
 Mon, 10 Jul 2023 16:03:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmqj1QcSRR7qS0RclbDFTdZLcy4TAcmg785TslHOSqY+JERxjUiA3AkPjVxMJqveaI9M04tA==
X-Received: by 2002:adf:fe43:0:b0:314:1a98:ebc0 with SMTP id
 m3-20020adffe43000000b003141a98ebc0mr11566151wrs.26.1689030224638; 
 Mon, 10 Jul 2023 16:03:44 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d4dc4000000b0031424f4ef1dsm600772wru.19.2023.07.10.16.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:44 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 27/66] hw/pci-host/i440fx: Move i440fx_realize() into
 PCII440FXState section
Message-ID: <44df0552a020efd6191714da44edede5ded37ec8.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

i440fx_realize() realizes the PCI device inside the host bridge
(PCII440FXState), but is implemented between i440fx_pcihost_realize() and
i440fx_init() which deal with the host bridge itself (I440FXState). Since we
want to append i440fx_init() to i440fx_pcihost_realize() later let's move
i440fx_realize() out of the way.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-12-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/i440fx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 0b76fe71af..e84fcd50b6 100644
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
MST


