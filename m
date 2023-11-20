Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A650D7F0B72
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 05:38:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4w2b-0000Dp-Ff; Sun, 19 Nov 2023 23:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2Z-0000Db-Fk
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:43 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2X-0003AG-TI
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:43 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b2f507c03cso2347951b6e.2
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 20:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700455060; x=1701059860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NIG2F7HCiQQLDnxtUKaAqaCC4f9JUC5QSsNOyMPV/o=;
 b=ACtBTCyqT7viacRCkjeSuvVcYksAeCyMX5V9eU1Xp872tDiLyK7oeR78bIRI107ywO
 Tg4uOke5RRVHXtjxK1XogGVb7JthMgtobjJUQzDDAAcngJYt6ADbPCapeMjvtABi70xn
 nzarz8qZAGRU1vQFwSSjrEstPnAZJl3oJL0ZJ3SRlzgYschJ1Yz20AUrD7sePUQkPEcU
 DnpDqvdE5efCAaWsC2PLWG+e+ndrZi0ODBI6QXdrUrzL4QM8VG7TdZx7ij6KxSUST5Xf
 3eSrarwC/tpmm9ArxD+rujoXNg2+6voPRRhlxWsqyJDOOJ//irI2a9yljusZhVd7zcv4
 inlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700455060; x=1701059860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NIG2F7HCiQQLDnxtUKaAqaCC4f9JUC5QSsNOyMPV/o=;
 b=jjkFYSQk7thurDtMWx6H8PzHtEbjCinICISlJJ9RCq/rRVu+sjQU/Oy74TFm8qqyjN
 sygVMCxZE5tOCErcTMooW7eWYYJtWUvvFz37pMzThgKqjggZeg98e7eTeatJqfxntdhi
 pipUSfJhmp3Rr2AKsgA7w/1qG26g5OWq199f52C30Y1Wm+HePcxfWf5hxunZCURduT9q
 SiYfwvyR51X8U6lpeV2epP7Us/QrjrkxX1ggWeVTQd4OvYdMRJJDBxp78FTX08mDzv4S
 9+fdgA7vtSzxQX/6ln7LRBkGmJmrZ2sopMBsGuSFMHxEdN/Ps27xTPh4tiphHMVbXeGF
 kLDQ==
X-Gm-Message-State: AOJu0YxEUErKPgJcNYpEnmShDwwUDFii76xd6uLs6F+0fizk1vD4IwGT
 JExm/fOPnnKxHgJB17OMlGoYNRJIp4cYW8XptgZVX3EBGFC+Wg==
X-Google-Smtp-Source: AGHT+IEjE+jJnrZMpcCx/XZxI8hoGx2MbdHss1eY1k6lL+494oehl3UoXpjZMPR9XoZGtNnHSWpB0w==
X-Received: by 2002:a54:4e81:0:b0:3b2:e577:7344 with SMTP id
 c1-20020a544e81000000b003b2e5777344mr6714633oiy.38.1700455060551; 
 Sun, 19 Nov 2023 20:37:40 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net.
 [211.75.219.202]) by smtp.gmail.com with ESMTPSA id
 s41-20020a056a0017a900b006926d199fdcsm5035991pfg.190.2023.11.19.20.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 20:37:40 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 3/4] hw/virtio: Move vhost-user-input into virtio folder
Date: Mon, 20 Nov 2023 12:37:20 +0800
Message-Id: <20231120043721.50555-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120043721.50555-1-leo.yan@linaro.org>
References: <20231120043721.50555-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=leo.yan@linaro.org; helo=mail-oi1-x236.google.com
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
index 8a26fe9493..fdc3edc6cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2263,8 +2263,8 @@ virtio-input
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
2.39.2


