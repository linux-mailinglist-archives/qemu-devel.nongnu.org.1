Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AAB7494CE
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 06:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHH2q-0005If-D7; Thu, 06 Jul 2023 00:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qHH2f-0005IP-OU
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 00:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qHH2d-0002DT-H4
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 00:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688619389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=megS9wLPm3L6ymJ1GFi1dKlfx7/a2IhBKCCIQZjoAJg=;
 b=M1H2OiidVL/RgcIeghFf5UBabWgv6R7zLQDm9KbHbzxXw6Um8J8oOz13lnGPLbhiX6ke80
 lN61PsOZxH4FbKyGJM/AyWMyNXLAnU2t3QrNQ+ssW6rnLPg1C/VCKdla4E/6arnJwRQ1ro
 B4U0oYo1XegzYQNURyu5Sr7kKf5uU58=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656--xb6gNirODK7Dlgr0fl6gQ-1; Thu, 06 Jul 2023 00:56:27 -0400
X-MC-Unique: -xb6gNirODK7Dlgr0fl6gQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7656c94fc4eso49858085a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 21:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688619387; x=1691211387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=megS9wLPm3L6ymJ1GFi1dKlfx7/a2IhBKCCIQZjoAJg=;
 b=H9fMBxgHhpofCeHyLGVRR/5jJE2CPsfeLK/8DxW8o9TC+H0IHa2s2XjUQVgMrrFR3+
 0DQDK1ydOPkk70FVsqqMiPmKXxQ7mkb7DLrNzbKVLGz5D0PNd5pvQl7Ldp1Ycrd45Qb3
 CVMylPzdaPaCMUA1o5PXL9T6RstFGdCauWvPxueHPKUg2VipBGVotDATLE8B+SBWXYDk
 s3pHk/Lhga49/3NirsKoSLfSObXAk8BLWChZF8G7iMNWLBmudIRA1YpompzV3NLC8ce6
 GoEvdlbVQPr+6vvPWr493OUOmDdYwcD3+H0YLG33gA5WzRD+Ntb3hU5FjK3yEFEA2UsK
 d6IQ==
X-Gm-Message-State: ABy/qLbzVC0WL+BgXMV4fzGEkAHNIl1HEq7ApZHfD81OQlPt3oSOApxT
 zwizZsD1xUn1saBV6JFzrlRKZcuH14MX7QpW95t3uQ1dJWiKNz3MYkCh7S5wirGySLcjQZuRDDF
 1LST2zInAT0KKq0w=
X-Received: by 2002:a05:620a:4555:b0:765:4330:6e6c with SMTP id
 u21-20020a05620a455500b0076543306e6cmr803225qkp.55.1688619387327; 
 Wed, 05 Jul 2023 21:56:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1K5W5e1CyHPMnuVzR/StD7sFVTnHzDA78GrPiEJAb5AeSJan9teUM5vpBpgIXxvRq2piJqw==
X-Received: by 2002:a05:620a:4555:b0:765:4330:6e6c with SMTP id
 u21-20020a05620a455500b0076543306e6cmr803212qkp.55.1688619387015; 
 Wed, 05 Jul 2023 21:56:27 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:faf8:1d15:affc:4ee8:6427])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a05620a11ac00b00765aa9e3499sm356948qkk.135.2023.07.05.21.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 21:56:26 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Date: Thu,  6 Jul 2023 01:55:47 -0300
Message-ID: <20230706045546.593605-3-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leobras@redhat.com;
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

When trying to migrate a machine type pc-q35-6.0 or lower, with this
cmdline options,

-device driver=pcie-root-port,port=18,chassis=19,id=pcie-root-port18,bus=pcie.0,addr=0x12 \
-device driver=nec-usb-xhci,p2=4,p3=4,id=nex-usb-xhci0,bus=pcie-root-port18,addr=0x12.0x1

the following bug happens after all ram pages were sent:

qemu-kvm: get_pci_config_device: Bad config data: i=0x6e read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
qemu-kvm: Failed to load PCIDevice:config
qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_obj
qemu-kvm: error while loading state for instance 0x0 of device '0000:00:12.0/pcie-root-port'
qemu-kvm: load of migration failed: Invalid argument

This happens on pc-q35-6.0 or lower because of:
{ "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }

In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
which sets dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to signal PCI
hotplug for the guest. After a while the guest will deal with this hotplug
and qemu will clear the above bit.

Then, during migration, get_pci_config_device() will compare the
configs of both the freshly created device and the one that is being
received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS bit
and cause the bug to reproduce.

To avoid this fake incompatibility, there are tree fields in PCIDevice that
can help:

- wmask: Used to implement R/W bytes, and
- w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
- cmask: Used to enable config checks on load.

According to PCI Express® Base Specification Revision 5.0 Version 1.0,
table 7-27 (Slot Status Register) bit 6, the "Presence Detect State" is
listed as RO (read-only), so it only makes sense to make use of the cmask
field.

So, clear PCI_EXP_SLTSTA_PDS bit on cmask, so the fake incompatibility on
get_pci_config_device() does not abort the migration.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215819
Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 hw/pci/pcie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b8c24cf45f..cae56bf1c8 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -659,6 +659,10 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
     pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
                                PCI_EXP_HP_EV_SUPPORTED);
 
+    /* Avoid migration abortion when this device hot-removed by guest */
+    pci_word_test_and_clear_mask(dev->cmask + pos + PCI_EXP_SLTSTA,
+                                 PCI_EXP_SLTSTA_PDS);
+
     dev->exp.hpev_notified = false;
 
     qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
-- 
2.41.0


