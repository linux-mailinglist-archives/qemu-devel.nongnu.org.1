Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C359380B8C8
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:08:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB6U-0005ss-AX; Sat, 09 Dec 2023 23:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB60-0005f0-Bg
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:07:18 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5t-0005lU-Ep
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:07:08 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so2366239fac.2
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181223; x=1702786023;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mtfsYxKw0csHOz6PBDk8tQDoenyAhfkRumc0jwtXEEg=;
 b=qIOgdW8ED9GLW+n8Ot0mUCYEw/oE1jC5D8tCikxnfyf88YFJ0XATGCI1EvjCnBNunp
 ndtkhOIEkXNp2qkHr895wT3mWTFzhUdPcDYcQitJo6nrUVom+lN5cwzBYPHHlCIZyoyr
 rpCFbHObRdiqRHuyWKggTP7FyBFxroepuWpaou2JtCVFwU362A6tl989ouoooTUx36cD
 XuNAPQhBiQnlowPIR4nTbB1yYiRb7J8YvzvjlwxniTtCGvwY3V+4fYgxI3dH19slMuCy
 pPRenaNTeR7KpORtFgzUxBYMiDeYD0qR6USLsBWGyZowoVBSwypoZE45Ir22M4BDit5E
 lkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181223; x=1702786023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtfsYxKw0csHOz6PBDk8tQDoenyAhfkRumc0jwtXEEg=;
 b=azHdozj40hmWHZsazrVcizfdDESx7XVZ64zItp1m+6aAyMGH0kMQprmDyyhvoO126x
 eTri/flQeVyNlJvwXNQhI1/oimQe74tSd6HBes9kQf0fCtuseF+Kdki5xH77wo4q8Xu3
 wQop7ZznhiCNCEokeih0qCCW/yzvcPwKPZ9wMx8luau+OPnv48zgh5vOMa5NE9/aIxGk
 4pzluvmccrNKMX5sWXbi/12foI+7YZdKgPu+zCg6f6DE3m/FIe7TyPdRorSjPXRnjZFZ
 DjkD6e83X/xzchQREuzFFpEYzbozu34GO2LzLbFVEDB/4jREmRHuvW5mC+w+ihVpol/0
 TOTw==
X-Gm-Message-State: AOJu0Yz+hZDEA7Ct3Gove2s1aeyW6lx3EOcx7RI3d9FfOhSFLLP4MgyF
 AEX7wZEX2Wm6yCyqNd7bLDkidg==
X-Google-Smtp-Source: AGHT+IEfst0jFvA1dJHzWA22XZ2HkUvvY3vnO5/rJe4hvn/tVbDaPjQORR6M84NvmflRzoTPMea6rw==
X-Received: by 2002:a05:6870:8329:b0:1fb:e34:e31c with SMTP id
 p41-20020a056870832900b001fb0e34e31cmr3009072oae.37.1702181223537; 
 Sat, 09 Dec 2023 20:07:03 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 c7-20020a6566c7000000b005c215baacc1sm3448286pgw.70.2023.12.09.20.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:07:03 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:54 +0900
Subject: [PATCH RFC v2 11/12] virtio-pci: Implement SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-11-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Allow user to attach SR-IOV VF to a virtio-pci PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 205dbf24fb..4f3ec71218 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2075,6 +2075,12 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
+
+    if (pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
+                                                 PCI_CONFIG_SPACE_SIZE,
+                                                 errp)) {
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    }
 }
 
 static void virtio_pci_device_unplugged(DeviceState *d)
@@ -2083,6 +2089,7 @@ static void virtio_pci_device_unplugged(DeviceState *d)
     bool modern = virtio_pci_modern(proxy);
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     virtio_pci_stop_ioeventfd(proxy);
 
     if (modern) {

-- 
2.43.0


