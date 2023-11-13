Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E47EA343
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:04:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cCu-0002eV-5O; Mon, 13 Nov 2023 14:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCn-0002e6-Ge
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:41 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCj-0000LF-LR
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:39 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41eae4ebf61so31158171cf.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699902156; x=1700506956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKs2iaNGcckU3ni81u+5apbwGwozAkz/WW7uZAFdepY=;
 b=Ma+SD+FaeB0XJSF0amKQLnzM2tzC2BIbBoRKBdG+dWKMFo93phgu4+/kU6Knjt+88M
 GxtuIVNXHd01Q7nSZY1f5OjK5wu5o7RqEu7NlHalZ6w/h1IXooi3opARjI+aaGt/S++6
 J42afjuuItxD0KvKg+RfB8R0moMpAd63ox1QIxzTE4i9n74ci/0NKN9vN4WM1lIhWGbo
 bxQYl4I+MIt/Q7HZpoe2psREp+/QUV32GNhEF081AIKCqOQIPXBYbe8y6WlvgDO6TpPZ
 rBxFoSgWq0X7usemjaO+3ljL/W9bUK4Mu8jcNk5vn3Gto84oHjD9jYq4USZDvZCOk89H
 LeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699902156; x=1700506956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKs2iaNGcckU3ni81u+5apbwGwozAkz/WW7uZAFdepY=;
 b=iB9L6OOK3XjS4j3XYDzzW4nRlQ79iSh+2gJkh9ZG6TvXOevOqU1wVd0QOnFdOHxifq
 VSykEwmTK0PmZufoa0hmM4JNTsohNZ1/Oedohr8KzorL0QvVIEluOngFmvvY/MZ/NAzE
 CdnVcSD+Po/9CtPREHi5iO0zfj48RNcxD2vMaVsoV5slU2DqpRyF6hXmW1OVFONcgMUh
 uYa7ooI9CovfxUNv5og3pDruA6Q4z3aHo8gEsDciDsR/GcErZTW9pmYZ6uXEbHqGiqWI
 3OVgZK2VS4fZrMMzPuGkdeyDMtadE1K1GW3BDvc6jlKhDHkGWRSQNMqhhH+DEedCs+Ld
 8wMg==
X-Gm-Message-State: AOJu0YxaXJQplpbm4zTqBKFAbXXsNsSB1LIx3Jf1lw3z8gDzGzz1RJAh
 ltvwjbHGiRAVi/SOKpxV+GE0guq0rq2n2wzMLeaGhvr0ovY=
X-Google-Smtp-Source: AGHT+IGbdBDiArhG8Nyj7lqNuVsOp3IrB0+YWC6+9q0GZxS8q/8ZtukRhU5Rl8ZRS9yVA7kuZMw/Bw==
X-Received: by 2002:ac8:4e83:0:b0:41c:c34a:84af with SMTP id
 3-20020ac84e83000000b0041cc34a84afmr17686qtp.6.1699902156181; 
 Mon, 13 Nov 2023 11:02:36 -0800 (PST)
Received: from localhost.localdomain ([12.186.190.1])
 by smtp.gmail.com with ESMTPSA id
 kq4-20020ac86184000000b004181c32dcc3sm2124834qtb.16.2023.11.13.11.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 11:02:34 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/4] hw/virtio: Move vhost-user-input into virtio folder
Date: Tue, 14 Nov 2023 03:02:10 +0800
Message-Id: <20231113190211.92412-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113190211.92412-1-leo.yan@linaro.org>
References: <20231113190211.92412-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=leo.yan@linaro.org; helo=mail-qt1-x82d.google.com
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
 MAINTAINERS                             | 2 +-
 hw/input/meson.build                    | 1 -
 hw/virtio/meson.build                   | 4 +++-
 hw/{input => virtio}/vhost-user-input.c | 0
 4 files changed, 4 insertions(+), 3 deletions(-)
 rename hw/{input => virtio}/vhost-user-input.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef72c6d512..b0b6db38c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2234,8 +2234,8 @@ virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
 F: docs/system/devices/vhost-user-input.rst
-F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
+F: hw/virtio/vhost-user-input.c
 F: include/hw/virtio/virtio-input.h
 F: contrib/vhost-user-input/*
 
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


