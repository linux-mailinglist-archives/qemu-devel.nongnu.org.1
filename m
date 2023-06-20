Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0662F736452
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 09:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBVdJ-0004L8-24; Tue, 20 Jun 2023 03:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBVdE-0004KN-HH
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBVdC-0006GC-Nt
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687245504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wx6OtQTzdSiC1EUBAQtfYo+awyRfge7HDnOsUegRGlo=;
 b=h3QP1UTo0bn63xiZJb98SBCbKdoGdW+w9XcD64Y6aicfhC1Tn+yj/9Uu8PLJ+wlyDRKuP4
 3IjMHx/5O7zmvT44W3/L26Q7Ac1lSPQTdFMBG6kbtW1pRav3rgqLFcNArZqlomc2PzU/xj
 6Uoq8DbhtRCi1IVkAfWjJ3pnMPbACs8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-nsFbXBaGOSi7UxWDGfkPgw-1; Tue, 20 Jun 2023 03:18:21 -0400
X-MC-Unique: nsFbXBaGOSi7UxWDGfkPgw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5538f216c7aso943828a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 00:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687245500; x=1689837500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wx6OtQTzdSiC1EUBAQtfYo+awyRfge7HDnOsUegRGlo=;
 b=jlsKJw5PVMvgm3GssLILRIdDD79lY8Zdp93yYXdFYXJb2ZA/eWDrnSwsrJnnAMm1iI
 GoB9UWWgCXua5nQ3vI9g6yZft/+wbMh4AQ8RxtiNPt8puJpnpihSY+XaLpBoYUc5hFDk
 y9wansRM6dOlAHgGzV7nFO9got7Y0qwXGmYn064/Gs3osoUXzLS3IC86I0M2VZv3yrjs
 hfN94JbkRZZBBUCQ7BIGeCLgA8e+pnXpXZz+aUMFCY+EMAAk7dwkkPWwa0ln4T6CnI1n
 j25TS6/sTtJvTrKvVnYHNdF4swm0qkeTxR+Ns6JjZfZzkXSMB5g7HcCCSLEZTwTjCAJq
 x2Ew==
X-Gm-Message-State: AC+VfDzbPWmCOfK8LDJBQII1MZWW3K6Ty7i+bQsqmIjB0SL6ZiBY/EuH
 FqLllc6P/NGO9pfeFhMLdXYgN9Mt7OqWxpfJ4E1vNuarYuNYPRLMsETawQUYcxAAP78TNaKCs6n
 qqAqEFY9gviz74yc=
X-Received: by 2002:a05:6a20:3d85:b0:118:a48:8977 with SMTP id
 s5-20020a056a203d8500b001180a488977mr8992337pzi.3.1687245499926; 
 Tue, 20 Jun 2023 00:18:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4AQgOsORLwFCZpDrqW9VRAaun31SmfCtYitGqonoEtfib21lpOXLsngflfttD22QTwKJLTuA==
X-Received: by 2002:a05:6a20:3d85:b0:118:a48:8977 with SMTP id
 s5-20020a056a203d8500b001180a488977mr8992321pzi.3.1687245499480; 
 Tue, 20 Jun 2023 00:18:19 -0700 (PDT)
Received: from localhost.localdomain ([116.72.143.94])
 by smtp.googlemail.com with ESMTPSA id
 io20-20020a17090312d400b001ac38343438sm903669plb.176.2023.06.20.00.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 00:18:18 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, jusual@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices have
 an upstream PCIE port
Date: Tue, 20 Jun 2023 12:48:05 +0530
Message-Id: <20230620071805.4400-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a device has an upstream PCIE port, we can only use slot 0. Non-zero slots
are invalid. This change ensures that we throw an error if the user
tries to hotplug a device with an upstream PCIE port to a non-zero slot.

CC: jusual@redhat.com
CC: imammedo@redhat.com
Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

changelog:
v2: addressed issue with multifunction pcie root ports. Should allow
hotplug on functions other than function 0.
v3: improved commit message.
v4: improve commit message and code comments further. Some more
improvements might come in v5. No claims made here that this is
the final one :-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..30ce6a78cb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,6 +64,7 @@ bool pci_available = true;
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset(BusState *qbus);
+static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
@@ -1182,6 +1183,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     } else if (dev->hotplugged &&
                !pci_is_vf(pci_dev) &&
                pci_get_function_0(pci_dev)) {
+        /*
+         * populating function 0 triggers a bus scan from the guest that
+         * exposes other non-zero functions. Hence we need to ensure that
+         * function 0 wasn't added yet.
+         */
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
@@ -1189,6 +1195,18 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    name);
 
        return NULL;
+    } else if (dev->hotplugged &&
+               !pci_is_vf(pci_dev) &&
+               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
+        /*
+         * If the device has an upstream PCIE port, like a pcie root port,
+         * we only support functions on slot 0.
+         */
+        error_setg(errp, "PCI: slot %d is not valid for %s,"
+                   " only functions on slot 0 is supported for devices"
+                   " with an upstream PCIE port.",
+                   PCI_SLOT(devfn), name);
+        return NULL;
     }
 
     pci_dev->devfn = devfn;
-- 
2.39.1


