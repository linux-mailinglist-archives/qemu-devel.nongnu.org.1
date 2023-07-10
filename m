Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339874E201
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwh-000422-QJ; Mon, 10 Jul 2023 19:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwW-0003Cf-PI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwB-0004Yc-JZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NKbPO8ARdLVSrsrJJis4atM4y0FvySweZZUS4AyFig8=;
 b=O9pCfLuNnHbDk6pJN2gIh/ZStWv3X8X5EArON5R17WqvBXfeyjnVoGWW+SU8+rc3o4iC0m
 bxDgvY6pP81kamxZKE0T6fbDEJTz2j+MbELtlBAjHnsgCWu8egFNRRETe3E3NhoWM6cAvy
 SX/RNWfAZTti7gNlSzjfvxpy72WrIjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-D8Xgo10aOEKZhxZGBX5sGA-1; Mon, 10 Jul 2023 19:04:39 -0400
X-MC-Unique: D8Xgo10aOEKZhxZGBX5sGA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so31647815e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030278; x=1691622278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKbPO8ARdLVSrsrJJis4atM4y0FvySweZZUS4AyFig8=;
 b=DFh2JO4AX00GhlXfg4tZID/Qt3S+6Jt2tw1m875ch7EBLZAoLIemFaafq5ZDHoiAb1
 rZw8XnjadvOuMv3UC2etMzuP0Yez95mbfL5o8c2gotZkvWEqf+Vf6jqi4B3FEk82Vau0
 5WDJNIaFM1Ki+loL30kL7WA4tfemeTYPkLx651hHLOUvLNkSc5yfCopvIla6uo4ND574
 wkuXZMNV/7s5eY9d9HxdDOXZPjU4LUKghS/Eq9Q/N8D1JjUHQ1/NBpZ9IO5oR79lv7RL
 ROxntBJ2XeVPpCrMnlKDwYpemvFuMcLR/NVy+DEC3UemY0pY5iXZsBStadQvZFgkQscD
 hfDw==
X-Gm-Message-State: ABy/qLashtRADTTe4/rxwIeWsnF9XwpyMhir0HK/za0X9jT6FNkW4mzR
 oGBxWkPfyEVcVWAcxpB6HpQclfvu1uaOQ92SdOT/rO8QD9KTsaNCcbX2TsYddcpY6vaK16JgXK/
 w/RLr4kHduXDHtD11CnS1YfwWxqV/IjptiaaO7PH/Yl9yH1ES5gFjHfILfzbSeFuqWtoi
X-Received: by 2002:a05:600c:29a:b0:3fb:abd0:2b52 with SMTP id
 26-20020a05600c029a00b003fbabd02b52mr12272649wmk.13.1689030277924; 
 Mon, 10 Jul 2023 16:04:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmC7+r8jaVZKZnEDjDLpMd4kpEnoUezHAA5PFHCM7ND6IOO3aXgghxU7e2LmjQtMh+RFEACg==
X-Received: by 2002:a05:600c:29a:b0:3fb:abd0:2b52 with SMTP id
 26-20020a05600c029a00b003fbabd02b52mr12272630wmk.13.1689030277606; 
 Mon, 10 Jul 2023 16:04:37 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 b7-20020a05600c11c700b003fc015ae1e1sm981387wmi.3.2023.07.10.16.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:37 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, jusual@redhat.com,
 imammedo@redhat.com, mst@redhat.com, akihiko.odaki@daynix.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 45/66] hw/pci: warn when PCIe device is plugged into non-zero
 slot of downstream port
Message-ID: <ca92eb5defcf9d1c2106341744a73a03cf26e824.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ani Sinha <anisinha@redhat.com>

PCIe downstream ports only have a single device 0, so PCI Express devices can
only be plugged into slot 0 on a PCIe port. Add a warning to let users know
when the invalid configuration is used. We may enforce this more strongly later
once we get more clarity on whether we are introducing a bad regression for
users currently using the wrong configuration.

The change has been tested to not break or alter behaviors of ARI capable
devices by instantiating seven vfs on an emulated igb device (the maximum
number of vfs the igb device supports). The vfs are instantiated correctly
and are seen to have non-zero device/slot numbers in the conventional PCI BDF
representation.

CC: jusual@redhat.com
CC: imammedo@redhat.com
CC: mst@redhat.com
CC: akihiko.odaki@daynix.com

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Julia Suvorova <jusual@redhat.com>
Message-Id: <20230705115925.5339-6-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fb17138f7d..4b14f31859 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -65,6 +65,7 @@ bool pci_available = true;
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset(BusState *qbus);
+static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
@@ -2121,6 +2122,25 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    /*
+     * A PCIe Downstream Port that do not have ARI Forwarding enabled must
+     * associate only Device 0 with the device attached to the bus
+     * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
+     * sec 7.3.1).
+     * With ARI, PCI_SLOT() can return non-zero value as the traditional
+     * 5-bit Device Number and 3-bit Function Number fields in its associated
+     * Routing IDs, Requester IDs and Completer IDs are interpreted as a
+     * single 8-bit Function Number. Hence, ignore ARI capable devices.
+     */
+    if (pci_is_express(pci_dev) &&
+        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
+        pcie_has_upstream_port(pci_dev) &&
+        PCI_SLOT(pci_dev->devfn)) {
+        warn_report("PCI: slot %d is not valid for %s,"
+                    " parent device only allows plugging into slot 0.",
+                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
+    }
+
     if (pci_dev->failover_pair_id) {
         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
             error_setg(errp, "failover primary device must be on "
-- 
MST


