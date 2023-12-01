Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CB78010EB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:16:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9776-0002tG-6E; Fri, 01 Dec 2023 12:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976v-0002pX-BL
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976r-0007f7-UK
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viSu+JmZMKOikUcA7oY6KDbzcP0eJ0La9olcbUF7oSI=;
 b=HWTqi33iXsVeImc886mOxc/dtd8ZWMhOQLxeh65YA2drSy+DZWFLrsfqDDGdQfjsUTvWVT
 /TYoqHc6VzkrEq4sDVLkpe9CB7mBAzs+gnAUjGM0NhOeOpie5TIg0ypCK6eBxlxWmXPiqI
 vh0A6wYv3rqIEOHCLs4Wvb4nFccfIW4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-XZpXmxZLOLKkl-zI5fSkIw-1; Fri, 01 Dec 2023 12:15:22 -0500
X-MC-Unique: XZpXmxZLOLKkl-zI5fSkIw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40b297925ccso17136685e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450921; x=1702055721;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=viSu+JmZMKOikUcA7oY6KDbzcP0eJ0La9olcbUF7oSI=;
 b=SoDprpPc0K5Sq+v9NaPZRmpeMRElwmMhAGajLCHdZThfEgVgGHsW1nrM1BkqQUB0F/
 QwHApp179MKt/Lyjfbif8UUu0MN3oQkIDI7rBT6c5+9pWMSYTpBqzkpmpD6L0Z9Lpn6d
 KQlh6uorvawFEeySmuPBzQZyNkZR4iRos6Qr3VSYZCbY8vPVJLnmqRkT+xl39g6kWWZl
 LQ8zOy7oDrHBFFmd0nZ0fczMCPgYdGQHQARnaMQAhLvlxBa79vxB8HiFtHa5LghJ2iKx
 173TpXxMaUJHuuqKl0+/riFBK8ShwNdenW7U0sY+jDpwA2yj/JKHu9u5s1nVpazAzoRk
 xGqQ==
X-Gm-Message-State: AOJu0YzfKAbdETMRvAm7zuF/UJiXDhIDdZrzQWPVIT/TmLZFhY+CiHOh
 TPJAntCPAikKUdsHGOhgOhl5FewcOkMQTrRSjs5Mpsl88NjRzQZ+DVZ88bxm/zCeBxcZ9Xom0GJ
 LgWF20Kl8bBLm34Ofjxl+QbdkhosICZTmkZj2a6dMPsx0vPLIbPPRq04wO7FIn7J2B0Sd
X-Received: by 2002:a05:600c:21c4:b0:40b:5e1b:54b0 with SMTP id
 x4-20020a05600c21c400b0040b5e1b54b0mr783697wmj.60.1701450921417; 
 Fri, 01 Dec 2023 09:15:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERj68gq+AIOWM7sE0d0knhA05UxAp+hBKrszRkbjhToO6QJXiBTMKt8dl4d0c+h8cwyB1XAA==
X-Received: by 2002:a05:600c:21c4:b0:40b:5e1b:54b0 with SMTP id
 x4-20020a05600c21c400b0040b5e1b54b0mr783685wmj.60.1701450921104; 
 Fri, 01 Dec 2023 09:15:21 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 bi10-20020a05600c3d8a00b0040b4c7e1a65sm9715783wmb.13.2023.12.01.09.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:20 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 04/15] hw/audio/virtio-snd-pci: fix the PCI class code
Message-ID: <be73ed78034894734a729aa6760bd78d50a1ad8f.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Volker Rümelin <vr_qemu@t-online.de>

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
Message-Id: <20231107185034.6434-1-vr_qemu@t-online.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
MST


