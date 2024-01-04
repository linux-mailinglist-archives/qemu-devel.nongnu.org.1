Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D2A824A11
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:12:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUzU-0007Ek-0l; Thu, 04 Jan 2024 16:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyQ-0006ve-3d
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyN-0007Rn-UL
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d5f40ce04so9136485e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402590; x=1705007390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OfSNqfYw1yegwimMaKEPeX4MqQs2j01XgstIe7tBng=;
 b=mflICYL1syYT6P0n9kPkT5tIBC2rHnhMSj7I1jmhCNTR5GEGjm2OXTthVY4k1dogoA
 keLEa+m2hxCjxPo00R2RGZNjwxMdOxmX51utcjORHh6SlcAyKWCYpq7sbptUL51C3PlG
 1zTJvh4nncFkoYZlcLlpj6vkZZasmeudFPO+JS1imYeYcugL2xwfi5qHWMaqe7kOSayg
 SqurIQx/wSLe8JUYn6CVHFIR1rqafoHAKVtwobHR8woCbV71nnVEjK8OZEE6H5giAW9X
 Mw23DSXZLcB70Dxf4XncPIgEPcLqqrGfYn9Bshwn0W+RitmgiikJuhUu+7lhFLxN5oJj
 68uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402590; x=1705007390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OfSNqfYw1yegwimMaKEPeX4MqQs2j01XgstIe7tBng=;
 b=VqOVwGqWznCrv/If3OkOGclqSJKqv8lx98dILCGrmCgwQEBDdKO+G5P6RaUnCbvlnH
 I/FG7dZDrrNyADR57w8FDtFJYF/ZZAoL02/o+Qv4UB+PaQWQJr28OFL4tmnBtHCoHPlu
 lbKD0gGKgP8SizrPyqiXtJRYDsz1snxMQHn6svm2MzVvMhkZ1NGGd/5Sd7s3aSwHSRaM
 6N0e2A6+RY9EnePH9Htn4lTvTHsOUorN6SEiv1+ETBzWlqaskJO5c5VNzmsq7hmI0K/l
 6smK9vgUqXHwkKLPPU+dok41SLbvvgvXkgzddenBdn6WvE1aFwsObaluL0nnlGcKOxtG
 ECHg==
X-Gm-Message-State: AOJu0YzABvl1PKxyadL7TR43wk8vfUnyF2gv6PJyPIgL+zQq7trFl/iE
 WiRQTj6nAStoD1xRiSKZJzpbjZ7HFC5c8g==
X-Google-Smtp-Source: AGHT+IEtlW7xxS3/iSF0pg8fXVSFdV2j5pY9mqc1Yu3VB/LzJyCqKplDyBjc0aIeBC6yKY2/dJvV0Q==
X-Received: by 2002:a1c:7710:0:b0:40c:3905:51e4 with SMTP id
 t16-20020a1c7710000000b0040c390551e4mr676241wmi.68.1704402590483; 
 Thu, 04 Jan 2024 13:09:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m40-20020a05600c3b2800b0040d79907acasm6822175wms.26.2024.01.04.13.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3A485F93F;
 Thu,  4 Jan 2024 21:09:45 +0000 (GMT)
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
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v9 07/11] docs/system: add a basic enumeration of vhost-user
 devices
Date: Thu,  4 Jan 2024 21:09:41 +0000
Message-Id: <20240104210945.1223134-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
v5
  - split vhost-user-device out of the table
  - sort the table alphabetically
  - add sound and scmi devices
v6
  - add note re vhost-user-device
v7
  - fix patching description
---
 docs/system/devices/vhost-user-rng.rst |  2 +
 docs/system/devices/vhost-user.rst     | 70 +++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/vhost-user-rng.rst b/docs/system/devices/vhost-user-rng.rst
index a145d4105c1..ead14053264 100644
--- a/docs/system/devices/vhost-user-rng.rst
+++ b/docs/system/devices/vhost-user-rng.rst
@@ -1,3 +1,5 @@
+.. _vhost_user_rng:
+
 QEMU vhost-user-rng - RNG emulation
 ===================================
 
diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index a80e95a48ae..c6afc4836f9 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -8,13 +8,81 @@ outside of QEMU itself. To do this there are a number of things
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
+.. note::
+  To prevent user confusion you cannot currently instantiate
+  vhost-user-device without first patching out::
+
+    /* Reason: stop inexperienced users confusing themselves */
+    dc->user_creatable = false;
+
+  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
+  rebuilding.
+
 vhost-user daemon
 =================
 
-- 
2.39.2


