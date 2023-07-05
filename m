Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E37483AF
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Ap-0006Kv-Ri; Wed, 05 Jul 2023 07:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1An-0006KL-QW
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1Am-00012L-7Y
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mpYxydYLCCyJPDsQ/wBoNchM063w/3npouA7+lTogQ=;
 b=RdvUCyHJx9I9xLySLbgK4Ek5hSoaqfRdel5sLplRa5uU9pxYBF7SbNQCbmCoNlnXIriT5g
 HpEqapc+HjBtcy1nQ7OgJ9HZPqehCN7zDwl4o37vGZ51yQCTnOfMvvpD2bwaKcc79yIjTH
 5UzdiuxQIaCjxRAgXGg8A2v6Jtx/5S8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-60iBBCjCMyqpkkhIy_n9QQ-1; Wed, 05 Jul 2023 07:59:50 -0400
X-MC-Unique: 60iBBCjCMyqpkkhIy_n9QQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b81ec07321so71607215ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558388; x=1691150388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mpYxydYLCCyJPDsQ/wBoNchM063w/3npouA7+lTogQ=;
 b=Q2ImK1Z862YTzacakvsOoizdPiCZUnQOHrPi2E9UPvj9Qxkl0Wuj6MlLWgDLNW7EN+
 RngejAjw1vcvpQWvwZOcQEC7c52dTU3rG76uD8cx+8Tx7vBpVwocRDOCDfnqUeMrBeP1
 OJbqc5oJ7Rphuz3+ZV3RFIbY3aLOt8ixAuFYCK1sn42dUb5FbvvxZva2wDgFk9Yrd6Fi
 7qLkjx7ut5/hCvNYRvBR/pWriRHy9luRaE3Y0QcqY+CMJmArRx14E3E9OWAVlWLKQWvT
 FgzFyyTRJzUx3aWkbDwWqg4tobmv6zQ8VrJ1d1zUq0+eueOjAIQY2xrV+GqRWrHXRXQ9
 oUmQ==
X-Gm-Message-State: ABy/qLb9M00h7PmyKJ1iu79DoXKxC78m9OU3H/I3Byd5cCoVn9RSTcZO
 1UAjsrLSHMHFldAW7XAwSCjCcJerYuhEncvu6gODVSe6jaLid5yQURc3guJznc9LirEr3vjMNwP
 9wp9u5LIEC9/ppIj3wiFPdfB4FQeNCHvNYOvo/+q1pqCfBqAdWH959gq7SfdcCJbWP5Ld9r9Wgk
 s=
X-Received: by 2002:a17:903:2441:b0:1b7:f443:c7f8 with SMTP id
 l1-20020a170903244100b001b7f443c7f8mr16057548pls.15.1688558388657; 
 Wed, 05 Jul 2023 04:59:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGv7me6t21A6XYhI2KaOoRbn2pdHHaG9XEmruPfxQ52MCK1aoHInPHbbphB506yjd4VtreRug==
X-Received: by 2002:a17:903:2441:b0:1b7:f443:c7f8 with SMTP id
 l1-20020a170903244100b001b7f443c7f8mr16057523pls.15.1688558388309; 
 Wed, 05 Jul 2023 04:59:48 -0700 (PDT)
Received: from localhost.localdomain ([115.96.119.220])
 by smtp.googlemail.com with ESMTPSA id
 v3-20020a1709028d8300b001b89c313185sm4878852plo.205.2023.07.05.04.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:59:47 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, jusual@redhat.com, imammedo@redhat.com,
 akihiko.odaki@daynix.com
Subject: [PATCH v8 5/6] hw/pci: warn when PCIe device is plugged into non-zero
 slot of downstream port
Date: Wed,  5 Jul 2023 17:29:23 +0530
Message-Id: <20230705115925.5339-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230705115925.5339-1-anisinha@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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
---
 hw/pci/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..62b393dfb7 100644
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
2.39.1


