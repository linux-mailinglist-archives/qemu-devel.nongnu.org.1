Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8072FFF2
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Pfd-0001Dw-5d; Wed, 14 Jun 2023 08:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9Pfb-0001Dn-RI
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9Pfa-0001Xt-0H
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686745929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HQjxQzTjvSsc/EcAevXzcNRisCk4xmWtL6nsEmLeh3M=;
 b=ZlSi4CgJF17WY8LR8ksvZK/cXyu9aWb1gMFmHelpnQO80U2ej5mfG8YQ96CXH2ndgVnQZ8
 Pz2yUQshF5jX5nWKFHZt53+8urgLqBpGhE/tqkWY3GMqLbPgIVZvVRZsMPQsKMNm+U1Jo6
 fGPSS402VmMn97iMSBYhKc7XwWhSWhk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Q-d1snGqNAm2nScrSLCJ5A-1; Wed, 14 Jun 2023 08:32:07 -0400
X-MC-Unique: Q-d1snGqNAm2nScrSLCJ5A-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-33db528e4faso57212325ab.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686745926; x=1689337926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQjxQzTjvSsc/EcAevXzcNRisCk4xmWtL6nsEmLeh3M=;
 b=RfsZ7+CsKANBFFD3H5tdIhgi04RzU8ySKrjoLrgpTeCYezmPDFQ8eDQyGhDr2zYHrh
 XAMhK8/j6ZwzqEoji3yKJl+wr1LfyJHOY74yhJmZ6DJj4cNxGHBHzpnlKObXPnyJeNfD
 +gZ+jR+ssPkDKs6ieVmc7M655tApiKs38Kpjzx3u4FpWduisHKnNlPSGKYOPcmSrkvMJ
 gZs6/C7vkQGtiheVeiCHlA7sHVMmUT33aiWp0y55EHU+0oeVqCxTBmZjSJTYwrizhSvv
 g3wGBueyyo1fSc/1me/mlbwJXPcZYxR2+er7sgYG3jISGqw32ZR0Mu/H83BG8HKk1OZ3
 b+fw==
X-Gm-Message-State: AC+VfDytC5s2nrZQ+WHY0fvh8jmOOlRkwRN4B8D7c/Bd9/htJ93dsCvx
 bA13m+3kDozYSAwnbjn4xpqhhl+moGWb4iZL1YrQvfvuJ+MelJW8hACVUQviy3fy8I9PgVcPEob
 DBWaM/4PtuMy0ldY=
X-Received: by 2002:a05:6e02:5c7:b0:33f:dfd1:fe49 with SMTP id
 l7-20020a056e0205c700b0033fdfd1fe49mr9418030ils.6.1686745926530; 
 Wed, 14 Jun 2023 05:32:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Wvb9QffUUW+Jaa1aJ83Bf1aEysmG9cLgPuZNh6BGKChCkuf9IoSoye4IYpD2btwEGWQt6OQ==
X-Received: by 2002:a05:6e02:5c7:b0:33f:dfd1:fe49 with SMTP id
 l7-20020a056e0205c700b0033fdfd1fe49mr9418016ils.6.1686745926282; 
 Wed, 14 Jun 2023 05:32:06 -0700 (PDT)
Received: from localhost.localdomain ([116.72.128.64])
 by smtp.googlemail.com with ESMTPSA id
 x10-20020a63cc0a000000b0053fb37fb626sm11002572pgf.43.2023.06.14.05.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 05:32:05 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, jusual@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports with
 wrong devfn address
Date: Wed, 14 Jun 2023 18:01:50 +0530
Message-Id: <20230614123150.7077-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=216.145.221.124;
 envelope-from=anisinha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
 TO_EQ_FM_DOM_SPF_FAIL=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

PCIE root ports only allow one device on slot 0/function 0. When hotplugging a
device on a pcie root port, make sure that the device address passed is
always 0x00 that represents slot 0 and function 0. Any other slot value and
function value would be illegal on a root port.

CC: jusual@redhat.com
CC: imammedo@redhat.com
Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

Note:
I tested this with both native and acpi hotplug enabled on pcie. The
check seems to work on both.

(qemu)  netdev_add socket,id=hostnet1,listen=:1234
(qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x2.0x5
Error: PCI: slot 2 function 5 is not valid for e1000e
(qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x0.0
(qemu) info network
net1: index=0,type=nic,model=e1000e,macaddr=00:11:22:33:44:03
 \ hostnet1: index=0,type=socket,
(qemu) device_del net1
(qemu) info network
hostnet1: index=0,type=socket,

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..bc39322dfd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,6 +64,7 @@ bool pci_available = true;
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset(BusState *qbus);
+static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
@@ -1189,6 +1190,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    name);
 
        return NULL;
+    } else if (dev->hotplugged &&
+               !pci_is_vf(pci_dev) &&
+               pcie_has_upstream_port(pci_dev) && devfn) {
+        /* For an upstream PCIE port, we only support one device at slot 0 */
+        error_setg(errp, "PCI: slot %d function %d is not valid for %s",
+                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
+        return NULL;
+
     }
 
     pci_dev->devfn = devfn;
-- 
2.39.1


