Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0FC80B8C7
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:07:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5Q-0005RH-5z; Sat, 09 Dec 2023 23:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5N-0005PV-RG
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:33 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5M-0005B4-1p
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:33 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b9e7f4a0d7so1702791b6e.1
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181190; x=1702785990;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jULzVKw4jETQdTwVTVbDoDIcPJ/Lkqp7c9I7LEiA14c=;
 b=15BFI5moSZshIa0O3FsI4C3O2brP8Xm2ivsjL6kI9zR0UhREqlYxjE8K3hR84H2JwV
 KFLChEDTjhsvvzwLZcRp4USI21ZuAWqQN29w+jZJ4hOYRvQJ/ZP/TNofLKxTrhwDLWWD
 jiOH2rbhAJITPoZDwfkIJWuVDlOGIcvYw6aYbh6ceNWr60u1mSyl+phzd8P+Xnae4icM
 f8+IHnsnnjls0kCNonbEd/OeoSEIBZdbk9UZqE6tsdhLbf6IIXIr+DjxemwcpDwsJv1e
 XLcp+E+J1AAqvpXgyou9xaPm7ZU/mlxQLd2PRNkcDALIWjsTn6JVLeCM8gI6RXvxhBio
 N33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181190; x=1702785990;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jULzVKw4jETQdTwVTVbDoDIcPJ/Lkqp7c9I7LEiA14c=;
 b=IwyBqiiotN/22a6v2VJN4VTTRn/ZJxCR7EtXVN/ufjcTsbCa4PbsmBUU+fnI7aFgd7
 yC3WH3W1YtXddWb5rNRA4yq3ne5nhM07Eh+c2sOieADWD4Qpj4hAp/CyGZknIcTE8I/D
 k76EmjWydt/1SyWQB9jr88gtnxMEPSo4z1fu6uVOCWLvCh1z16NwaSa0+tiS4DbbxzcG
 kkBG9uiquTbDeSO3QJvlO8FjDhXAUuMAxXTvn4buDp5Vmy1xIRfTtxUZVjM5wYVSHOhZ
 MyGVUw2qlm2y86RHSdHO4wflY+cCxQSJF3gwjaAlIU7EZQXQc5ubzztRPinO13lBvXlH
 csTw==
X-Gm-Message-State: AOJu0YzIJ2tj3noZfnndeFBNjMSDUdLmCJK2+ZG+FmFEPuGOEqpCWWul
 0BZxy1BE1qrdZLmjXRbjtjDbwQ==
X-Google-Smtp-Source: AGHT+IGbnxIS4baOZPGHxd8mgfZL4vUaxcE7xce9Kl6fiitDPlGKE2/Ahd4QNOIUet91DwXf1aI3YQ==
X-Received: by 2002:aca:f13:0:b0:3b9:e22a:22da with SMTP id
 19-20020aca0f13000000b003b9e22a22damr2704507oip.112.1702181189999; 
 Sat, 09 Dec 2023 20:06:29 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 y14-20020a62ce0e000000b006ce467a2475sm4113695pfg.181.2023.12.09.20.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:47 +0900
Subject: [PATCH RFC v2 04/12] vfio: Avoid inspecting option QDict for
 rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-4-b959e8a6dfaf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x229.google.com
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

Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c62c02f7b6..bc29ce9194 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1008,7 +1008,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1042,7 +1041,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.0


