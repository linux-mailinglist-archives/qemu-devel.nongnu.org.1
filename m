Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5755BFA662
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Oct 2025 08:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSnK-0001ip-OH; Wed, 22 Oct 2025 02:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnI-0001hE-1k
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnG-00087o-AJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJHhV44xA2yV6Pwkj+xG4UfO7EkjL4EsvWC4IiZRDKY=;
 b=Pk3hUPYKArydlrHW8uOyASENP0BSUGSAqX1Krpm74dhWVSqIqhONEYuunmrpsTLsRhW75b
 2b3OYaR75lsqL1Je2uf4CrRGhw13/bgyNbj1ghk/Km7GhmT1aJTWOB2BB5SXhO9HMHq49Y
 pYPXxL/ouT9mXnORcHhststg4WAcT0g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-3Q8tBEQ8PyCb41a6kFDucw-1; Wed,
 22 Oct 2025 02:57:53 -0400
X-MC-Unique: 3Q8tBEQ8PyCb41a6kFDucw-1
X-Mimecast-MFC-AGG-ID: 3Q8tBEQ8PyCb41a6kFDucw_1761116272
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B6E71956096; Wed, 22 Oct 2025 06:57:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2278B3000218; Wed, 22 Oct 2025 06:57:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 12/42] hw/audio/virtio-snd-pci: remove custom model callback
Date: Wed, 22 Oct 2025 10:56:07 +0400
Message-ID: <20251022065640.1172785-13-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

virtio-snd can rely on the default code to instantiate the device and
set the audiodev.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/virtio-snd-pci.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index 613538e46f..b78eaff851 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -71,24 +71,10 @@ static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
     .class_init    = virtio_snd_pci_class_init,
 };
 
-/* Create a Virtio Sound PCI device, so '-audio driver,model=virtio' works. */
-static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
-{
-    DeviceState *vdev = NULL;
-    VirtIOSoundPCI *dev = NULL;
-
-    vdev = qdev_new(TYPE_VIRTIO_SND_PCI);
-    assert(vdev);
-    dev = VIRTIO_SND_PCI(vdev);
-    qdev_prop_set_string(DEVICE(&dev->vdev), "audiodev", audiodev);
-    qdev_realize_and_unref(vdev, BUS(bus), &error_fatal);
-    return 0;
-}
-
 static void virtio_snd_pci_register(void)
 {
     virtio_pci_types_register(&virtio_snd_pci_info);
-    audio_register_model_with_cb("virtio", "Virtio Sound", virtio_snd_pci_init);
+    audio_register_model("virtio", "Virtio Sound", 0, TYPE_VIRTIO_SND_PCI);
 }
 
 type_init(virtio_snd_pci_register);
-- 
2.51.0


