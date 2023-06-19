Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F33735BBF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHIC-0001Xp-47; Mon, 19 Jun 2023 11:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBHI9-0001Jo-S3
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBHI8-0005o1-2G
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687190383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iI5aKBWb2Jyro26pa27eOzEGJepeQ0goB4S3kzZ+KHA=;
 b=eDr+nxFgpYUICrS1hecuzbbax5wMOaacxpUN6fZ1B8uBVcnUgykobTq7ECckdEpf9IfPT5
 ajvwoIXH9dLtITSSIwsRw9X6fINy/gCnPlDevfzm+2dMr+2CZti4PCtoxKiGb+Ybc7AQgn
 TQ8r7VapIX1vS6DU737oDKPWYisNUpw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-_ccGuiTWMF6XzH0thmD4sw-1; Mon, 19 Jun 2023 11:59:41 -0400
X-MC-Unique: _ccGuiTWMF6XzH0thmD4sw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6687243be0cso1544400b3a.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190380; x=1689782380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iI5aKBWb2Jyro26pa27eOzEGJepeQ0goB4S3kzZ+KHA=;
 b=GBbQxBLAdZhR9gscKD+1ktwfPNzKXlSAGLY/V2OEDYuGMvs64TkeL/G1B/YUE1chON
 G5/pjg5YZrkdfH+EZUebXQZ/Ts/o6UtCqMZ28olcgV7eK3ZWFTR695IbvmyWwtrpyItZ
 Rm2SkhQcIjHXmv1z54dwIIiHu+pdGY0XcAwgh/v4+EqZM+aUyNbnlWw7//v4ppTVZvFc
 B5bBiMROGURcCEULPt2PPR6rGU80bGOsD7VjahPXJtRi9l6CVwQDVrvhpTuiCx+dAejC
 9bOqzyVTnzAXgL6mRvUh0gPbvWRxFs1IfdJW+Nql57gtlsru+45k4LTRKvxFJ1M+gkUK
 WITQ==
X-Gm-Message-State: AC+VfDwIivoKWb2edejnQkpEwMsDJ4A7zOYvww/DbxBSQJ1e2JrRxyi6
 GRujKc69axYb+71OUWG2WYbZ7YHFOT5Wpzxakk3mMEF6fmPA1CiNJn8nt3YDxvLQ1LHWY6Icsc0
 gjo9hEPaEtZSNGB8=
X-Received: by 2002:a05:6a00:1a93:b0:65b:ccb0:8f00 with SMTP id
 e19-20020a056a001a9300b0065bccb08f00mr13709926pfv.4.1687190380572; 
 Mon, 19 Jun 2023 08:59:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6d7ncpZ1YnmlwhPpb4hclvQ1YBq3YwDr2O5YO+PY37N1AN9KoRt1Mf/qB7gJo2K+BDnzo+9Q==
X-Received: by 2002:a05:6a00:1a93:b0:65b:ccb0:8f00 with SMTP id
 e19-20020a056a001a9300b0065bccb08f00mr13709915pfv.4.1687190380283; 
 Mon, 19 Jun 2023 08:59:40 -0700 (PDT)
Received: from localhost.localdomain ([115.96.121.2])
 by smtp.googlemail.com with ESMTPSA id
 h7-20020aa786c7000000b006662f36c381sm9102158pfo.144.2023.06.19.08.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 08:59:39 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, jusual@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3] hw/pci: prevent hotplug of devices on pcie-root-ports on
 the wrong slot
Date: Mon, 19 Jun 2023 21:29:26 +0530
Message-Id: <20230619155926.443668-1-anisinha@redhat.com>
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

When a device is plugged into a PCIE root port, it can only be plugged into slot
0. Hotplugging a device into a slot other than slot 0 is invalid and should be
prevented. This change ensures that we throw an error if the user tries to plug
a device into a pcie root port on any slot other than slot 0.

CC: jusual@redhat.com
CC: imammedo@redhat.com
Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

changelog:
v2: addressed issue with multifunction pcie root ports. Should allow
hotplug on functions other than function 0.
v3: improved commit message.

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


