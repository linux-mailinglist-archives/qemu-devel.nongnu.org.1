Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBB7CF482
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPlS-000520-6Z; Thu, 19 Oct 2023 05:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlJ-0004zU-Fr
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlG-0006RM-OP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40651a72807so69363625e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709373; x=1698314173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nl4oCt66DltFJde5FyDlUuqmws3N7dpBwF8Ew9PpHYQ=;
 b=ZLYySVgJrG+1BbhtvReq0RxorsQZkcVrX7RPWFQCXyrrbvOOP+ystxnttNS7ThYJaz
 Pb2UKsjGauAqr81o4VUzHFMssCVb/pUGPAKhwguAHablwGoiM9RRcP0dnyw4Zrv08g2V
 4bmerGUcxLTzV93jfalmQQ7MVd3omkHWCe1dP4bxy0YJsda7Zpj5HWCINTHKSt+6v1Wg
 ZFIKJN/2SGW9pquV0SxC1F0ZNxSuFj9h8NLhR7JxJSE9TJH1T+DnuvPMriK9yOdY4wAf
 KpH3ZkdX0ilSzfGS1psutTwHdiGawkeRHghgSPUdYBVN8+iY0LWDma9wKehL1uOvTe/n
 RHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709373; x=1698314173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nl4oCt66DltFJde5FyDlUuqmws3N7dpBwF8Ew9PpHYQ=;
 b=uXUciH5odXHz9cVlT9TDNyr+jcoAL0Z75YN0WOVSyFH/FtdJQOFfvtIJuWoSFhpJZK
 cB6GDJXZivtpFbMSBmT5vWMwETLpdVvMO9KEHhOviTZvpxDw350OL42IBHyV6S+y0PW8
 MmKwZJANIoQgckGlQBvP9w5BH/zwSzNPkAUWUjgbTdo++j481hZYGHj/CIKaSVPusgkv
 oKXMQ1hD6GZIp1nzU6s59hcC0UpWef0bR3Yxr/3HK1PDu3KcQjApKJrsIRDpbSdF4xpS
 6t4GTussqyT2In1erqcOBnKBNo7Gs8aKVq+5arRb04xE40jk81im1RYBv4BnvR8WzAQM
 XNkA==
X-Gm-Message-State: AOJu0YxO/3WnfQ9J6eYJuzDfYL288DEMbSYh/44Tk8ih7n35C3LZ425z
 jwUrMOqAG5HfPZsFCeEa+gO12Q==
X-Google-Smtp-Source: AGHT+IElZ+NOfSa7VnDuv0vELv5ygq7fZEbuFgBO0iUPWNvnK5rhYEDk2NbQuKZ8BHuIAnD+dyDcBw==
X-Received: by 2002:a05:600c:4f94:b0:407:7e7a:6017 with SMTP id
 n20-20020a05600c4f9400b004077e7a6017mr1542361wmq.11.1697709373279; 
 Thu, 19 Oct 2023 02:56:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a05600c481200b00407b93d8085sm3928988wmo.27.2023.10.19.02.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:56:12 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1EF8C1FFC1;
 Thu, 19 Oct 2023 10:56:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 virtio-fs@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v5 6/6] docs/system: add a basic enumeration of vhost-user
 devices
Date: Thu, 19 Oct 2023 10:56:10 +0100
Message-Id: <20231019095610.2818087-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019095610.2818087-1-alex.bennee@linaro.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20231009095937.195728-7-alex.bennee@linaro.org>

---
v5
  - split vhost-user-device out of the table
  - sort the table alphabetically
  - add sound and scmi devices
---
 docs/system/devices/vhost-user-rng.rst |  2 +
 docs/system/devices/vhost-user.rst     | 60 +++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

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
index a80e95a48a..3e9fd2eba5 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -8,13 +8,71 @@ outside of QEMU itself. To do this there are a number of things
 required.
 
 vhost-user device
-===================
+=================
 
 These are simple stub devices that ensure the VirtIO device is visible
 to the guest. The code is mostly boilerplate although each device has
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
+  * - vhost-user-blk
+    - Block storage
+    - See contrib/vhost-user-blk
+  * - vhost-user-fs
+    - File based storage driver
+    - See https://gitlab.com/virtio-fs/virtiofsd
+  * - vhost-user-gpio
+    - Proxy gpio pins to host
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-gpu
+    - GPU driver
+    - See contrib/vhost-user-gpu
+  * - vhost-user-i2c
+    - Proxy i2c devices to host
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-input
+    - Generic input driver
+    - See contrib/vhost-user-input
+  * - vhost-user-rng
+    - Entropy driver
+    - :ref:`vhost_user_rng`
+  * - vhost-user-scmi
+    - System Control and Management Interface
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-snd
+    - Audio device
+    - See https://github.com/rust-vmm/vhost-device/staging
+  * - vhost-user-scsi
+    - SCSI based storage
+    - See contrib/vhost-user-scsi
+  * - vhost-user-vsock
+    - Socket based communication
+    - See https://github.com/rust-vmm/vhost-device
+
+The referenced *daemons* are not exhaustive, any conforming backend
+implementing the device and using the vhost-user protocol should work.
+
+vhost-user-device
+^^^^^^^^^^^^^^^^^
+
+The vhost-user-device is a generic development device intended for
+expert use while developing new backends. The user needs to specify
+all the required parameters including:
+
+  - Device ``virtio-id``
+  - The ``num_vqs`` it needs and their ``vq_size``
+  - The ``config_size`` if needed
+
 vhost-user daemon
 =================
 
-- 
2.39.2


