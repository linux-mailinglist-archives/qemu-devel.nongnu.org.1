Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99097422E4
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnbH-0001Vp-2A; Thu, 29 Jun 2023 05:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qEnax-0001UQ-Dn
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qEnav-0008DN-4e
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688029538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2BbTb2xGbwESqNIDiitibi6zq2wnpkSjq033P0Qmxt0=;
 b=GAKiRyxIwq/j32d/0UAhCnYjsOKh3oBFAFb3pEL1rymMPL3VpIfhqPqmFVgZptrbVdbLu2
 dF+nVBJ7pTgADjPGqXrgzd2x7fohfWJn1bcw4UDQjlapaCpPoXuyOYhP28kqGVUaB3aR8d
 IK/up1FpFvMgvUc5V157gbs05Ds3ZeI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-r82UdDuEOJuN2PRJGx7uqg-1; Thu, 29 Jun 2023 05:05:36 -0400
X-MC-Unique: r82UdDuEOJuN2PRJGx7uqg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3fde2d7a589so4814071cf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 02:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029536; x=1690621536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BbTb2xGbwESqNIDiitibi6zq2wnpkSjq033P0Qmxt0=;
 b=XeonNztQDxAcx1a2J+CSBTZ0PS9nFtihUV5QTKDx/fA4m8tflXa0F64Tc+XxyCifiT
 0ZLC5ip7hgK4tZIgMhSMANKBpI4oKwlP3NSl2kitWSFLWXE4itaRNYLvB/174kUcWq1l
 zJ9A08LxRAgNttFrDLibJ8maxA7R3jmbbNepg22YFc3lUe59usyz6vO1lZkdTaygXALr
 ewQLe5eeVLwQkG5wce4itC1VX6wX0SofrsOjwiktYtOeCZaYLmYvizSpE8cVS95jZQSi
 W+qhh5NxTmBO9VRIHZUptY3RkCniLhPDj4DNkPJ+EQCw0UhGFMAQQDWWPA/zs3Sm3fYX
 PKbg==
X-Gm-Message-State: AC+VfDyiMlEAJEijER4QYEcAMq0BTBg1BwFsyovd7qXl0oIQqpRtSVuY
 dSD3Oye09KI9E4P9f+cenOSFfsqPJotAhN+HIFXtxeAmPUETdK71CbeShVOz3N56HNKPQvBwLyl
 ysxMzBDdAh2mPnMU=
X-Received: by 2002:ac8:7dc5:0:b0:3f5:3851:873f with SMTP id
 c5-20020ac87dc5000000b003f53851873fmr46732219qte.8.1688029536441; 
 Thu, 29 Jun 2023 02:05:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GUqZcN+Kl0cvvipEBjqkRXYirEJGTfUvqIKzfsdRpbIkYhSKGj8wtWytgBx4y7BfBg3MzfA==
X-Received: by 2002:ac8:7dc5:0:b0:3f5:3851:873f with SMTP id
 c5-20020ac87dc5000000b003f53851873fmr46732207qte.8.1688029536192; 
 Thu, 29 Jun 2023 02:05:36 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:b9f8:e18f:c10f:b98a:c822])
 by smtp.gmail.com with ESMTPSA id
 e4-20020ac84904000000b003f7f66d5a0esm6999586qtq.44.2023.06.29.02.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 02:05:35 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
Date: Thu, 29 Jun 2023 06:05:00 -0300
Message-ID: <20230629090500.438976-2-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leobras@redhat.com;
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

When trying to migrate a machine type pc-q35-6.0 or lower, with this
cmdline options:

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
which sets the bus dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to 
signal PCI hotplug for the guest. After a while the guest will deal with
this hotplug and qemu will clear the above bit.

Then, during migration, get_pci_config_device() will compare the
configs of both the freshly created device and the one that is being
received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS bit
and cause the bug to reproduce.

To avoid this fake incompatibility, there are two fields in PCIDevice that
can help:

.wmask: Used to implement R/W bytes, and
.w1cmask: Used to implement RW1C(Write 1 to Clear) bytes

According to pcie_cap_slot_init() the slot status register
(PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, seems to fall
under w1cmask field, with makes sense due to the way signaling the hotplug
works.

So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake incompatibility on
get_pci_config_device() does not abort the migration.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215819
Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 hw/pci/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b8c24cf45f..2def1765a5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
                                PCI_EXP_SLTCTL_EIC);
 
     pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
-                               PCI_EXP_HP_EV_SUPPORTED);
+                               PCI_EXP_HP_EV_SUPPORTED | PCI_EXP_SLTSTA_PDS);
 
     dev->exp.hpev_notified = false;
 
-- 
2.41.0


