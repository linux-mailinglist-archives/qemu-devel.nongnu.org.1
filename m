Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B0274DA1D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIt2x-0002XX-VV; Mon, 10 Jul 2023 11:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2t-0002WU-Bk
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:27 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2q-0006Lv-M9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31438512cafso5037494f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003802; x=1691595802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJso+7/SyOzlPSfGsjFdKvvog0Z+6+yUR2hdcAwaBfc=;
 b=MutJX7emGU8QPyPA59RtM1I5kKlSSAidzSGGfKrRgsv11216aNl7PXId0QQU0m6W9J
 kHL4Eb2rXMOQqQTZgcLmLeTksnZRcvY1ErYZBDeBOySKM/ww0rU2Rr3smYl1FhJN0Ty7
 QJrFU9oocvL+vmc/Bx7Z/KJ3CTzdoDFaCBgcwvTnFEegXYES6XbkJEQLXgiUnNMq1Ysc
 1AZF9EOnlU1Uvz/M5uFTWDDzYjRveuU/vJzNhFy/huSrObmQQQepk3UYUs9f63mxO86E
 MJovmWlhQQ8kwXuW9WuhWTxkIH+8r9xN8D+8Ug2UJy7MexKFU8FutQUpxEEreiFj7qNs
 AeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003802; x=1691595802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJso+7/SyOzlPSfGsjFdKvvog0Z+6+yUR2hdcAwaBfc=;
 b=GnPSr3VXDRxk03FIZGlJJdKLpNoflqj5edJ0tMJFipAXJ1zMNnHLurDVcC+YQ1obZU
 z49zYUseTbvA2gEfm4GaXu2b3ZzgyABKM31D4VlYJ9woLSN0Fuw5bDH0fs9whHt/17d+
 J4+FSpNoB2X6NkaHyTC3PLtAx/RruD3B/xYqcrDypdPNfbWSI827+p60jT5mbuq3fAym
 O9JiZ//NNArMHspVmCDQAfli6EpwfhF98nJ7yYOGvrq065ZniGEMR1G0JWnMHv/MXJw3
 jAUCsGxgd8X6t1kAIPnpP/HBxS2O+pPgv0rcJhj32HiQzc//QNJYAlwQRQ1KDNfyZQtm
 APzw==
X-Gm-Message-State: ABy/qLbHY73PGlDpiHWemYUDH5vBVPytHummZKEZwBwViqGFPl2/vfBq
 oQQ4LM1+RXZhXS5SqB4htQicDQ==
X-Google-Smtp-Source: APBJJlFuiEwR3xklGxewoqbHVHNHTdsiIcaIGFTzbtuibm3DJOi91ktQumtkHhsRrGTXSoDX6nRypg==
X-Received: by 2002:a5d:5749:0:b0:313:e741:1caa with SMTP id
 q9-20020a5d5749000000b00313e7411caamr14204318wrw.25.1689003802026; 
 Mon, 10 Jul 2023 08:43:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c22d800b003fbaade072dsm191143wmg.23.2023.07.10.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:43:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B26E01FFC8;
 Mon, 10 Jul 2023 16:35:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH v3 13/20] docs/system: add a basic enumeration of
 vhost-user devices
Date: Mon, 10 Jul 2023 16:35:15 +0100
Message-Id: <20230710153522.3469097-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Make it clear the vhost-user-device is intended for expert use only.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - make clear vhost-user-device for expert use
---
 docs/system/devices/vhost-user-rng.rst |  2 ++
 docs/system/devices/vhost-user.rst     | 41 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/docs/system/devices/vhost-user-rng.rst b/docs/system/devices/vhost-user-rng.rst
index a145d4105c..ead1405326 100644
--- a/docs/system/devices/vhost-user-rng.rst
+++ b/docs/system/devices/vhost-user-rng.rst
@@ -1,3 +1,5 @@
+.. _vhost_user_rng:
+
 QEMU vhost-user-rng - RNG emulation
 ===================================
 
diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index a80e95a48a..0f9eec3f00 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -15,6 +15,47 @@ to the guest. The code is mostly boilerplate although each device has
 a ``chardev`` option which specifies the ID of the ``--chardev``
 device that connects via a socket to the vhost-user *daemon*.
 
+Each device will have an virtio-mmio and virtio-pci variant. See your
+platform details for what sort of virtio bus to use.
+
+.. list-table:: vhost-user devices
+  :widths: 20 20 60
+  :header-rows: 1
+
+  * - Device
+    - Type
+    - Notes
+  * - vhost-user-device
+    - Generic Development Device
+    - You must manually specify ``virtio-id`` and the correct ``num_vqs``. Intended for expert use.
+  * - vhost-user-blk
+    - Block storage
+    -
+  * - vhost-user-fs
+    - File based storage driver
+    - See https://gitlab.com/virtio-fs/virtiofsd
+  * - vhost-user-scsi
+    - SCSI based storage
+    - See contrib/vhost-user/scsi
+  * - vhost-user-gpio
+    - Proxy gpio pins to host
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-i2c
+    - Proxy i2c devices to host
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-input
+    - Generic input driver
+    - See contrib/vhost-user-input
+  * - vhost-user-rng
+    - Entropy driver
+    - :ref:`vhost_user_rng`
+  * - vhost-user-gpu
+    - GPU driver
+    -
+  * - vhost-user-vsock
+    - Socket based communication
+    - See https://github.com/rust-vmm/vhost-device
+
 vhost-user daemon
 =================
 
-- 
2.39.2


