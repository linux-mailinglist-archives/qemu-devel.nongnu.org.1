Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F537E48BB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:51:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RA3-0002qE-Sq; Tue, 07 Nov 2023 13:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1r0RA1-0002lE-38
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:50:49 -0500
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1r0R9z-0002IL-0q
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:50:48 -0500
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
 by mailout02.t-online.de (Postfix) with SMTP id 5675B1A08;
 Tue,  7 Nov 2023 19:50:41 +0100 (CET)
Received: from linpower.localnet ([93.236.156.187]) by fwd81.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r0R9n-2Fe5th0; Tue, 7 Nov 2023 19:50:35 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 035FF2002D1; Tue,  7 Nov 2023 19:50:34 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] hw/audio/virtio-snd-pci: fix the PCI class code
Date: Tue,  7 Nov 2023 19:50:34 +0100
Message-Id: <20231107185034.6434-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699383035-CE571E93-BE84F1D1/0/0 CLEAN NORMAL
X-TOI-MSGID: d7732817-bb52-4296-9935-0c98ced31df1
Received-SPF: pass client-ip=194.25.134.17;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout02.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The virtio sound device is currently an unclassified PCI device.

~> sudo lspci -s '00:02.0' -v -nn | head -n 2
00:02.0 Unclassified device [00ff]:
 Red Hat, Inc. Device [1af4:1059] (rev 01)
        Subsystem: Red Hat, Inc. Device [1af4:1100]

Set the correct PCI class code to change the device to a
multimedia audio controller.

~> sudo lspci -s '00:02.0' -v -nn | head -n 2
00:02.0 Multimedia audio controller [0401]:
 Red Hat, Inc. Device [1af4:1059] (rev 01)
        Subsystem: Red Hat, Inc. Device [1af4:1100]

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
The two additional lines have been lost between v6 and v7 of
the "Add VIRTIO sound card" patch series.

 hw/audio/virtio-snd-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index 0f92e0752b..ab58c6410e 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -47,12 +47,14 @@ static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidevklass = PCI_DEVICE_CLASS(klass);
 
     device_class_set_props(dc, virtio_snd_pci_properties);
     dc->desc = "Virtio Sound";
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
 
     vpciklass->realize = virtio_snd_pci_realize;
+    pcidevklass->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
 }
 
 static void virtio_snd_pci_instance_init(Object *obj)
-- 
2.35.3


