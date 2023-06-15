Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A61730E95
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 07:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9fLw-00079O-QS; Thu, 15 Jun 2023 01:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9fLv-00079F-3p
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9fLs-0005d4-U9
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686806216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cmUyql7+dpZi3HAq3nccH9iirFrjowjrbYZr5+pucTY=;
 b=dWa01sIHGC8q4rQi42IO/lBL94nHnKvxede+Ug1HX9P0nuUM3uWBYGNs5RutfpExrbCc8+
 fJqzFmV0pSNdzQurGED9GEhPjMQWDLHAp3YNFdxcs7PTFqQgtDyEjip2VxQINFgliZJUDK
 JPtkfzFOdGicWTAQkPyuiYUtnUTaIv4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-MBfN675mPUegqBO5tna4jg-1; Thu, 15 Jun 2023 01:16:54 -0400
X-MC-Unique: MBfN675mPUegqBO5tna4jg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f9d8c685b6so39990971cf.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 22:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686806214; x=1689398214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmUyql7+dpZi3HAq3nccH9iirFrjowjrbYZr5+pucTY=;
 b=Hxhj8MV7L4wT1WOamJZY/Vs1GWuGsLGk23MIEYcLoT+xl72kEmDsq5ZCU8cVz/IxmI
 nqZ+sHBfNlm7lvT96U9mvGKjgznmVehMj5z2ssWKMhhvK9PPsVTiHBvQkt3aBhwspvOr
 dfOf3Xjh9fTSAvqnCfUCHCS8gqiN39BFN4/CesVzfTXCDmgGEpFg81dQt7ZHXqK5+KR6
 mTzSCEOFTAk7AMGkhSETdeWsJXzuTd03DQ9cCb1bWWhSrJkCxNXqkL5yUhjToZR4faTr
 7SbB36mqDejkVjMt4wZ6aZuQ9bVy0JXRScHczLNm54/rFTfcj0FSM2MPnMxQXOI2/DVN
 17kg==
X-Gm-Message-State: AC+VfDwbIktTLn2l+ekRj6u4X8WqA+rhh9CIpn7o68sfPBNbVetV0C60
 AAWDKukbsQfhFn2D6OuiVgYM6gdLq/8xAieRiIRlLqHJTNod7YyB4u623TtOx/L6du5dHEWPKOz
 303wInuIRM4Z0s9A=
X-Received: by 2002:a05:622a:254:b0:3f9:b5e3:8f18 with SMTP id
 c20-20020a05622a025400b003f9b5e38f18mr5422817qtx.24.1686806214289; 
 Wed, 14 Jun 2023 22:16:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60jvS5h/Q/pL9NyMg0uJMbVkNK/0KAeo3/dagrU3nkT8y7GWrdzK1A6WDN2Il4uhHxJJiGVg==
X-Received: by 2002:a05:622a:254:b0:3f9:b5e3:8f18 with SMTP id
 c20-20020a05622a025400b003f9b5e38f18mr5422798qtx.24.1686806214009; 
 Wed, 14 Jun 2023 22:16:54 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.99])
 by smtp.googlemail.com with ESMTPSA id
 j17-20020a62e911000000b0065379c6d549sm11028068pfh.215.2023.06.14.22.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 22:16:53 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, jusual@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2] hw/pci: prevent hotplug of devices on pcie-root-ports on
 the wrong slot
Date: Thu, 15 Jun 2023 10:46:45 +0530
Message-Id: <20230615051645.4798-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

PCIE root ports and other upstream ports only allow one device on slot 0.
When hotplugging a device on a pcie root port, make sure that the device
address passed always represents slot 0. Any other slot value would be
illegal on a root port.

CC: jusual@redhat.com
CC: imammedo@redhat.com
Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

changelog:
v2: feedback from mst included.

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..66999352cc 100644
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
+         * function 0 is available.
+         */
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
@@ -1189,6 +1195,16 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    name);
 
        return NULL;
+    } else if (dev->hotplugged &&
+               !pci_is_vf(pci_dev) &&
+               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
+        /*
+         * If the device is being plugged into an upstream PCIE port,
+         * like a pcie root port, we only support one device at slot 0
+         */
+        error_setg(errp, "PCI: slot %d is not valid for %s",
+                   PCI_SLOT(devfn), name);
+        return NULL;
     }
 
     pci_dev->devfn = devfn;
-- 
2.39.1


