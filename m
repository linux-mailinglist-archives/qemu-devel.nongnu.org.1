Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817897E93FB
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 02:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2LaE-0000c0-89; Sun, 12 Nov 2023 20:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LaC-0000b5-HY
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:44 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LaA-0003pc-RH
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:44 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1efb9571b13so2517301fac.2
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 17:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699838261; x=1700443061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnIjF81Iq4zeaKROB6E3ZJNVF7enVvjwzbGJ8K3b0k4=;
 b=vh/lrjJdDVrKdfaX8qtd+/sx9fYI67hcfUQc5Ajjw0O+84wTrxKZJaafo84rFaqv8A
 qoXC2uQeInLABUYih9t45P/EIMd3jcz59OE0MUPmS0YK+MGyefMqNBwCdIefrQN69Z7y
 VRllSywr9zvoCvveaL3ySVBkVVOq8n17LU+Os21r1BiaQ6Gzh5zKJk5ucY1rEjB/oblY
 BeRNplnvcjipDI+iQpvl9yu06h5elJBon1tkfGyffoGhrh0Nz2QUwxaXhSuxY7oxSjYZ
 TVRvO/XPZmQkdZ46sHLjw5ctR1KqWpcWYDwWLpuk/eIQVo0rbjE2NptILewHrrbXcv1l
 lYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699838261; x=1700443061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnIjF81Iq4zeaKROB6E3ZJNVF7enVvjwzbGJ8K3b0k4=;
 b=L1FC5chkFeQTHXfy4sA0S1sdOwyX2lmk2MF1IwLXnctuv9Na5vWSHOmLVav9UbHueu
 O3aNmfQ37E17hGjnjAc1bG7UbFF6T6KCBVF/YasYPohJ2UiT8DuEx1WeG3j/gE+IknEh
 h+tjZ8UNm8JkA75Dtew/3PP9lsesa1WodV1GJPnuZLf8Ms9lFXBwMZ5sOZuwnsg4BdwT
 3VA/LrFK8pREOXH9cfUYNoKlUQzFmaW/oCpa5ZumEBD1gt5rM7kjpWJzGpi4GVS5F6ii
 DXc2aNulUJVon+m7R8sw4TSwhS4St6o136JjuLucqmUbuhqMPXsbBg7HaEDljELPE1BX
 0WjQ==
X-Gm-Message-State: AOJu0YxCB9aZ0cyPmCppAEgpae7bMGFndW7zl4/rx2DTKlBxekrDhIuU
 o4c0+q7u9N1Cz3A6zL3sKevO7uIVXT0Ck8tjfxXqDcTSE5Q=
X-Google-Smtp-Source: AGHT+IFV+KxOnwp4GMAeTuDzFypRPntN5rX45QL9YYpnCO9NYSCBVGP0eJwQ65iIDYfxJQ6bbVMwYw==
X-Received: by 2002:a05:6870:887:b0:1ea:6a7b:e40a with SMTP id
 fx7-20020a056870088700b001ea6a7be40amr7142194oab.59.1699838261335; 
 Sun, 12 Nov 2023 17:17:41 -0800 (PST)
Received: from localhost.localdomain ([128.1.74.235])
 by smtp.gmail.com with ESMTPSA id
 r6-20020aa78b86000000b0064f76992905sm2918511pfd.202.2023.11.12.17.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:17:40 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/4] hw/virtio: Move vhost-user-input into virtio folder
Date: Mon, 13 Nov 2023 09:16:41 +0800
Message-Id: <20231113011642.48176-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113011642.48176-1-leo.yan@linaro.org>
References: <20231113011642.48176-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=leo.yan@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

vhost-user-input is in the input folder.  On the other hand, the folder
'hw/virtio' maintains other virtio stubs (e.g. I2C, RNG, GPIO, etc).

This patch moves vhost-user-input into the virtio folder for better code
organization.  No functionality change.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 hw/input/meson.build                    | 1 -
 hw/virtio/meson.build                   | 4 +++-
 hw/{input => virtio}/vhost-user-input.c | 0
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename hw/{input => virtio}/vhost-user-input.c (100%)

diff --git a/hw/input/meson.build b/hw/input/meson.build
index 640556bbbc..3cc8ab85f0 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -11,7 +11,6 @@ system_ss.add(when: 'CONFIG_TSC2005', if_true: files('tsc2005.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-hid.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host.c'))
-system_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
 
 system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_keypad.c'))
 system_ss.add(when: 'CONFIG_TSC210X', if_true: files('tsc210x.c'))
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 118d4d4da7..c924afcafc 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -25,6 +25,7 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
@@ -36,6 +37,8 @@ if have_vhost
                          if_true: files('vhost-user-rng-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SND'],
                          if_true: files('vhost-user-snd-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_INPUT'],
+                         if_true: files('vhost-user-input-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
@@ -59,7 +62,6 @@ virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
-virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-pci.c'))
diff --git a/hw/input/vhost-user-input.c b/hw/virtio/vhost-user-input.c
similarity index 100%
rename from hw/input/vhost-user-input.c
rename to hw/virtio/vhost-user-input.c
-- 
2.34.1


