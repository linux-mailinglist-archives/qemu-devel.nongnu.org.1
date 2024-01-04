Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CA7824A10
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:12:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUzV-0007XU-8G; Thu, 04 Jan 2024 16:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyV-0006ww-FK
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:10:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyS-0007V3-Dr
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d60c49ee7so9243295e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402594; x=1705007394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpHAzaxTJd2Vec5B4UMxY6RAVe5qp1syQpkc++MJBDc=;
 b=h2KQymzdBk5p3CjRKSsD7qYmEBdFEtMMCbPbEv7JPR1AQ0kZCDcO1+mioyce/wrlbp
 LzFVCEpuNqkpv0r51hmTYDWOn+whCTZsqVaVllp3d96+aUXqLMHA42UxgKJSFPGYXHdS
 0uYoBdz5mBecY3G/SF4vlxv/pbb5W4H4Lum/1rdYay+ae9Zfie9chYx6Z99hJzKkOOfm
 FLwKWFHb7nG4f2Z29STWGkF/QlB3p8F/YIKjdf2Rvz+D012dlT0w5yol/721R0V9AxtI
 h0u8Isy/uzIijLG9nNJUC5Rj/wmrO3AlAcNCzNSbSkMnNify9MGaH/4Qk6ZhMSO2QdkP
 iVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402594; x=1705007394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpHAzaxTJd2Vec5B4UMxY6RAVe5qp1syQpkc++MJBDc=;
 b=XAZrbOfX8owaUSYayoADC40Z5lUs3PAySkQvGmNsHTMc0vH0cMaSNDsI5Q/Z46Xzqt
 SNDUheqUNoyMXoowYeKNbUOQbhhM3A2q3it2s5xyW8V3un6Rx7US/gO0dZO9CMaULkob
 TQWqW7VkyScfV0BSqtD9boCzQ0MBqdRz3woZnXxu/YbzKwXpt7kyfvKcoYgp1x8ItkvX
 YYn37fB3jmt7iZvG9zEN8tSnjp7CP1+2BFyb4i677FY2a3iPCSE+vfp/1HMts7SbO8Hu
 sLmOFOyv1YWHl3Vl887TBa683arBsoavkl1hMCVfqQhVpwnRLyZtVbr4Ek0Y0OxOWxJM
 LEmA==
X-Gm-Message-State: AOJu0Ywn3FDuW8yyryn9nI7Zec6NbBb8H/lUpk/MAk5Q7YyTT//1/LnQ
 IlHzVOplX1J6jXdnJPHCywCUfy8xo6djxA==
X-Google-Smtp-Source: AGHT+IGUgG1U52EZKfQgDES5Ql1BTTZ6xDaOJlulZL+gf32MN8KpV9rTI7a3MkBYGoaeQfX5rJMkqw==
X-Received: by 2002:a7b:c8d3:0:b0:40d:87ed:7c80 with SMTP id
 f19-20020a7bc8d3000000b0040d87ed7c80mr711291wml.18.1704402594740; 
 Thu, 04 Jan 2024 13:09:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c155100b0040d934f48d3sm353945wmg.32.2024.01.04.13.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 141C95F944;
 Thu,  4 Jan 2024 21:09:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 10/11] hw/virtio: Move vhost-user-input into virtio folder
Date: Thu,  4 Jan 2024 21:09:44 +0000
Message-Id: <20240104210945.1223134-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Leo Yan <leo.yan@linaro.org>

vhost-user-input is in the input folder.  On the other hand, the folder
'hw/virtio' maintains other virtio stubs (e.g. I2C, RNG, GPIO, etc).

This patch moves vhost-user-input into the virtio folder for better code
organization.  No functionality change.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231120043721.50555-4-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                             | 2 +-
 hw/{input => virtio}/vhost-user-input.c | 0
 hw/input/meson.build                    | 1 -
 hw/virtio/meson.build                   | 4 +++-
 4 files changed, 4 insertions(+), 3 deletions(-)
 rename hw/{input => virtio}/vhost-user-input.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff70987aeb3..66bd1eadc78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2275,8 +2275,8 @@ virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
 F: docs/system/devices/vhost-user-input.rst
-F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
+F: hw/virtio/vhost-user-input.c
 F: include/hw/virtio/virtio-input.h
 F: contrib/vhost-user-input/*
 
diff --git a/hw/input/vhost-user-input.c b/hw/virtio/vhost-user-input.c
similarity index 100%
rename from hw/input/vhost-user-input.c
rename to hw/virtio/vhost-user-input.c
diff --git a/hw/input/meson.build b/hw/input/meson.build
index 640556bbbcc..3cc8ab85f0c 100644
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
index 118d4d4da7c..c924afcafc0 100644
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
-- 
2.39.2


