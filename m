Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF3741F24
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 06:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEixH-0004IR-VH; Thu, 29 Jun 2023 00:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEixE-0004Hc-4Q
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEixC-000195-Dy
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688011701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoBS0EC4cwBNnpcmWPjz9AcRRSQCOhYWW+JOrffjg2c=;
 b=ZrPOOwnU5AnQAOEPlB3RMWkAxl0ypBmzwnUa/j7ONT8ypAWhhzSIAxVHoZQukhdM49RXlq
 81eLlM1/RkQ6lAaH0PZxroYwB8bLJ4xyKm86u+4mSKq+Z6neYkATl88mmS1lwjIDwhGDoh
 iJRm99OYEo2zIyy7LWvv0Pw856d+LFE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-vYea4MMNMjKRqjb8V2csew-1; Thu, 29 Jun 2023 00:08:19 -0400
X-MC-Unique: vYea4MMNMjKRqjb8V2csew-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-26337f5d2daso230492a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 21:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688011698; x=1690603698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoBS0EC4cwBNnpcmWPjz9AcRRSQCOhYWW+JOrffjg2c=;
 b=G0SRXBCbA76T3FxELTg6q4Wh9lAMwlo49cCWsuF7OMU/uXLQLxSL/wji/xw9TzGts/
 DeKnZMpXLmcyg2Rg6bhaBp2cn89m5h7ch+C4e0X4B2LDW1Wt/dU+geBBcp8C+YeZORu4
 WpvYrfTgnPF/SEo5xdEF+xQ9x01Xp1nhb6L8xVVNxDl89r5azv3MacO+4kZn1t2LfJ5S
 Ku2X/qPSZku42ZD4baySJJztUdRYe+YwER2Ko9+V413Q9TGpvcMx9PDNfBPT/Luix7+J
 dQ9nVHJhKxjCYkbmCVLCW3h+Gx5vX5eYW2V8cGE/AuN4fE5e1yt3E6e5eZBeHsIY5xWD
 GWRA==
X-Gm-Message-State: AC+VfDxnTv4SYOzoLW3AvlYto4gQaHtXaSwPMa5MWVbicCnemPuVAPvU
 h8ZoTMkq7ySTpPWLDJVfViWYUYqeFq0NizjmLR5Me6M7UE1gm2OmCJyYA2IDK9ibJE8JWzEw8ah
 QK1dUIHQrama1PvKdoez6KcL0GJzoZ7SROY/vowZztkyYcynLnX+TzUQowk0Xo6lR6PB4YbV7Dm
 c=
X-Received: by 2002:a17:90a:8d09:b0:262:f449:4497 with SMTP id
 c9-20020a17090a8d0900b00262f4494497mr9606143pjo.2.1688011698400; 
 Wed, 28 Jun 2023 21:08:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7asSaYoTZygpM8utTywpaThVmrfqBiWRAIQog79mLQcg486a7xuk2AS+F5sSazfKDolhxyUw==
X-Received: by 2002:a17:90a:8d09:b0:262:f449:4497 with SMTP id
 c9-20020a17090a8d0900b00262f4494497mr9606128pjo.2.1688011698047; 
 Wed, 28 Jun 2023 21:08:18 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.183])
 by smtp.googlemail.com with ESMTPSA id
 21-20020a17090a019500b00256b67208b1sm10978169pjc.56.2023.06.28.21.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 21:08:17 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, jusual@redhat.com, imammedo@redhat.com,
 akihiko.odaki@daynix.com
Subject: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only slot
 0 of PCIE port
Date: Thu, 29 Jun 2023 09:37:07 +0530
Message-Id: <20230629040707.115656-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230629040707.115656-1-anisinha@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
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

PCI Express ports only have one slot, so PCI Express devices can only be
plugged into slot 0 on a PCIE port. Enforce it.

The change has been tested to not break ARI by instantiating seven vfs on an
emulated igb device (the maximum number of vfs the linux igb driver supports).
The vfs are seen to have non-zero device/slot numbers in the conventional
PCI BDF representation.

CC: jusual@redhat.com
CC: imammedo@redhat.com
CC: akihiko.odaki@daynix.com

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Julia Suvorova <jusual@redhat.com>
---
 hw/pci/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..0320ac2bb3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -65,6 +65,7 @@ bool pci_available = true;
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset(BusState *qbus);
+static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
@@ -1190,6 +1191,20 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    name);
 
        return NULL;
+    } /*
+       * With SRIOV and ARI, vfs can have non-zero slot in the conventional
+       * PCI interpretation as all five bits reserved for slot addresses are
+       * also used for function bits for the various vfs. Ignore that case.
+       * It is too early here to check for ARI capabilities in the PCI config
+       * space. Hence, we check for a vf device instead.
+       */
+    else if (!pci_is_vf(pci_dev) &&
+             pcie_has_upstream_port(pci_dev) &&
+             PCI_SLOT(devfn)) {
+        error_setg(errp, "PCI: slot %d is not valid for %s,"
+                   " parent device only allows plugging into slot 0.",
+                   PCI_SLOT(devfn), name);
+        return NULL;
     }
 
     pci_dev->devfn = devfn;
-- 
2.39.1


