Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A299746FE5
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeAz-0001tO-UP; Tue, 04 Jul 2023 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAr-0001oq-8d
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAo-0002EV-4Y
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Euko7EPBlQ+qipY8fQMzafVw5ZALKBrq7a4gmRGSUmc=;
 b=NMzBtJSHecktIOwGxvzXy900vRG5KGraTwWDFwyILXTVzEWtv/pwmPk2urx4L73G47cZPG
 VpIARPQCGWk9muRGn4ifGO9ICuML8wjMGh+wIz5IAePvpd0x3U/w38m6ntbfYJVURg28GP
 zKkI9G2BT5eGFu4naSKQYmcMbpBTb7s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Kiwek8S4O1atTf-EruRcKA-1; Tue, 04 Jul 2023 07:26:19 -0400
X-MC-Unique: Kiwek8S4O1atTf-EruRcKA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b8071502d2so75953195ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688469978; x=1691061978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Euko7EPBlQ+qipY8fQMzafVw5ZALKBrq7a4gmRGSUmc=;
 b=CAacJ4LG/gP0JHONLxMRlChAnWtE/twgOAUC+oiUvWO34iC9awu6dXN7MOxlUPNHjF
 aKO7jIAKInf7phei7wzTdgspraT2R0lrqNpoDtzRNOLEfyHplW11YWbsRZJDy15CL+Iv
 aX45eINr0RcBe5O7pbdiByCdsUc8CTy85eE5ERst3E8ypk3SGK3VZTQWFVm/aqno7OoG
 P56PDHc3UYE2d6tEqfnyhY8hivaTDExXU82+RcVTh5lQp+fU2B2aPAyM235IM8lQa1TP
 P36rb0teJ9nU7ryor6nKd0qxO0i6qmGq4jpKzGJgZROj91+WJNNByJr5/fsVhn5j21Dc
 24ug==
X-Gm-Message-State: ABy/qLYjbhr9D5JPAULr0vCyME7LVu3ODchD8aX39iqonFh+8JWiPm4/
 l00y8V/8ZgkZ9cdXd5O0D5uZMYTCXtO4soDJl6bdf/MZKkiIhtbsf36T9fG7Vx9ExOK7Foo+72G
 zDK2BJ15hjcO81yVFFjqAGCbfpJcCT7GxU63I2YH8jZbr/iMYBjJ9UzLoPm4ankSbmfaRwm1cH9
 I=
X-Received: by 2002:a17:902:c407:b0:1ac:5717:fd5 with SMTP id
 k7-20020a170902c40700b001ac57170fd5mr15689856plk.60.1688469978303; 
 Tue, 04 Jul 2023 04:26:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUIDmicEIWbeakyTb2nTXKg1nPXsFChPp6SSc8qyx6g/HLVqR8vgbvmQDU6v5jv4RZDzCZiQ==
X-Received: by 2002:a17:902:c407:b0:1ac:5717:fd5 with SMTP id
 k7-20020a170902c40700b001ac57170fd5mr15689832plk.60.1688469977969; 
 Tue, 04 Jul 2023 04:26:17 -0700 (PDT)
Received: from localhost.localdomain ([115.96.131.170])
 by smtp.googlemail.com with ESMTPSA id
 o7-20020a170902bcc700b001b8a897cd26sm780608pls.195.2023.07.04.04.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 04:26:17 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, jusual@redhat.com, imammedo@redhat.com,
 akihiko.odaki@daynix.com
Subject: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only slot
 0 of PCIE port
Date: Tue,  4 Jul 2023 16:55:54 +0530
Message-Id: <20230704112555.5629-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230704112555.5629-1-anisinha@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
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

PCI Express ports only have one slot, so PCI Express devices can only be
plugged into slot 0 on a PCIE port. Add a warning to let users know when the
invalid configuration is used. We may enforce this more strongly later on once
we get more clarity on whether we are introducing a bad regression for users
currenly using the wrong configuration.

The change has been tested to not break or alter behaviors of ARI capable
devices by instantiating seven vfs on an emulated igb device (the maximum
number of vfs the linux igb driver supports). The vfs instantiated correctly
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
 hw/pci/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..47517ba3db 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -65,6 +65,7 @@ bool pci_available = true;
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset(BusState *qbus);
+static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
@@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    /*
+     * With SRIOV and ARI, vfs can have non-zero slot in the conventional
+     * PCI interpretation as all five bits reserved for slot addresses are
+     * also used for function bits for the various vfs. Ignore that case.
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


