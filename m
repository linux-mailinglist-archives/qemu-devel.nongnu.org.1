Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3F274E1F0
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwe-0003Ci-JM; Mon, 10 Jul 2023 19:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwM-0002Vv-TD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwI-0004Zc-Dn
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xD1AkY/txf5N+3ZJ0BJ1Fs74CaRBbtaK9Vb5NSU/lq4=;
 b=T6VqkFsNJjKK9UoUYpRyXks/43BUdwT1WXIoNPb7ksrcBE1RCOUjooIW7Nv8/HJwDfvHwv
 mutSxiVTvjEiFvcYFku/KC9Y829aB07A+BAvVsZ6w4MRYIc68QZjLuTTy+vO24XeEmCzkV
 nMcWk2d2jK3/LaN8UapqC8Y4SteuwSs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Q3K-hMeMNkSrygRNgFchAw-1; Mon, 10 Jul 2023 19:04:48 -0400
X-MC-Unique: Q3K-hMeMNkSrygRNgFchAw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fc07d4c63eso10374685e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030286; x=1691622286;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xD1AkY/txf5N+3ZJ0BJ1Fs74CaRBbtaK9Vb5NSU/lq4=;
 b=S+jiRAQ8pxxPhvW18NQnmYl1nDrEcvDMd+qXni8tz2OLfc/LT7YfmdWqKcGgYO952k
 DICRMLUiaalWygQWuIn5QxXXjOvinxVsrB7GqN9lQw5yfbUlgCYHWBDBAgQME2Rsj2AL
 iRkkeAOmgCa3qX8arf3Hi7PeAEizjXPTR3cZQsjJ4m3clyQ2Gn9Z6xwOctFALAzGvjfZ
 QXG6vM8IhpzpwEOZnKS/b27F+qbqajJpEqKHAyFhvI22jf47pnLzafB2vFr3w16memQY
 UpjEeY4cQYy1wzpRjhbSxPI2SGozyUTATvH+3R+2SMkCQaDDJ8ErqSKbk5eEPFsB51SL
 FI7g==
X-Gm-Message-State: ABy/qLYkmHP/YsJD69h1t9WbLy702GG/VR11Xqxa+8bb8/zgsWG72Emu
 Nr36o2A0T5B7ZH9eXnGGdBvnbyBvScLpeyqVVIfgRQjKLSqmOpTCIuUunVK6iHGD2TSUWbN3SKf
 e+UATxgLAJIQKDFjlORrYjO9BHpA7Yxk+36me1a1uWSpCAwA7+469To74OjorZ4C++cSD
X-Received: by 2002:a05:6000:8b:b0:30e:56b3:60fe with SMTP id
 m11-20020a056000008b00b0030e56b360femr12727790wrx.4.1689030286387; 
 Mon, 10 Jul 2023 16:04:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGhQMsYv7zygab3dCzUEdaW/nT6fijvgaEMfYTmFF4ZiehJ9ZFiUsrLK6LtQ5YpJRpQtlBP8g==
X-Received: by 2002:a05:6000:8b:b0:30e:56b3:60fe with SMTP id
 m11-20020a056000008b00b0030e56b360femr12727773wrx.4.1689030286101; 
 Mon, 10 Jul 2023 16:04:46 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 b16-20020a5d5510000000b0031417b0d338sm574620wrv.87.2023.07.10.16.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:45 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 48/66] pcie: Add hotplug detect state register to cmask
Message-ID: <625b370c45f4acd155ee625d61c0057d770a5b5e.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Leonardo Bras <leobras@redhat.com>

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
Message-Id: <20230706045546.593605-3-leobras@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/pci/pcie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b7f107ed8d..763f65c528 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -666,6 +666,10 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
     pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
                                PCI_EXP_HP_EV_SUPPORTED);
 
+    /* Avoid migration abortion when this device hot-removed by guest */
+    pci_word_test_and_clear_mask(dev->cmask + pos + PCI_EXP_SLTSTA,
+                                 PCI_EXP_SLTSTA_PDS);
+
     dev->exp.hpev_notified = false;
 
     qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
-- 
MST


