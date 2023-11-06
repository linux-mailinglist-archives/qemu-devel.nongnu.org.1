Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF027E2CAF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:16:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r054S-0007tQ-S9; Mon, 06 Nov 2023 14:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r054Q-0007tH-TQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:15:34 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r054G-0005l7-Ax
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:15:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32da7ac5c4fso2990413f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 11:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699298123; x=1699902923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDtPrefEanCjuZJYQIPqmOV+61RS08DIeIexVmAEaok=;
 b=LslB3tCl95kPKdSLdEER2Q848DybVctpn4nPkHC0C1K8akNGnXZAQhUIaoOg4PtnZ3
 oCQNI7QxHwDQy2lgOXRXiwBXYO9NgrfgG4gs7A3KZH+y/nhy1bFqpM1rfWxWrpRq0+Ef
 6pb516/KjPiBjfHKZ/n3la+GkUU8GNNX3dcNvp4KqR2gpx68qkv9QSNrk3VEtq5UJOeP
 bucJqVavYRC7eGgrK+fGQ5bc6IMjtvEKoG147QxfaSYQtQR4+w+dPRoWWgQQT+nhEsai
 RQeuWB3T8BiJXPXGTPq8NTrKao/qxF9qM6LiOjfS/fKuKL2DeYhINPtc7fRnt+dJcW5g
 T4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699298123; x=1699902923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDtPrefEanCjuZJYQIPqmOV+61RS08DIeIexVmAEaok=;
 b=t/2N8xwIkF+voOA+87CMXpZ614Z0fvEhzobaO7s9pzrZMNJ+ohOPXERtX9ASCvZwV+
 htBMn2jnxZ3MPrupzGondotxPkbj2aIFGEYDMg5jPlZghso7AC3hlKLCiE+/PtDo9aEh
 YngzgMxmaTjHDTOZNQBiX0+7uDTCVlvz0YVMoH3q3Auhi6DQa/qZGy6Dz9cHoiAYqt0d
 6nJmm4fUjnyge6qzclckOoVW7Yve2Q0m73P68o7iDnPzVsancNNIKCZ0E76vuyG2zqMv
 Fp9ln873CAl7LnFXW5KglZDsFx2PPDMiGX+UB26I26+sb+IepS3P0/XEZccvxudMCJxL
 pDiA==
X-Gm-Message-State: AOJu0YxMNFZzd4p/QllZSEIMrcZk3qi7jA8NdY356R6umxoO098q5sOE
 JVQtuvELVp05J7GK9qi+f395GA==
X-Google-Smtp-Source: AGHT+IGHSsYcGcabLRNX9DqLWtq3bGnh5H7gCpt8A7316y5laA1TQZxCK1wVqzflyk1hNy5udHsVbw==
X-Received: by 2002:a5d:6d0f:0:b0:32f:a48f:3658 with SMTP id
 e15-20020a5d6d0f000000b0032fa48f3658mr15956735wrq.69.1699298122807; 
 Mon, 06 Nov 2023 11:15:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i12-20020a5d630c000000b0032dba85ea1bsm347391wru.75.2023.11.06.11.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:15:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B8A056575C;
 Mon,  6 Nov 2023 19:15:16 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 6/6] docs/system: add a basic enumeration of vhost-user
 devices
Date: Mon,  6 Nov 2023 19:15:15 +0000
Message-Id: <20231106191515.2801863-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106191515.2801863-1-alex.bennee@linaro.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-Id: <20231009095937.195728-7-alex.bennee@linaro.org>

---
v5
  - split vhost-user-device out of the table
  - sort the table alphabetically
  - add sound and scmi devices
v6
  - add note re vhost-user-device
---
 docs/system/devices/vhost-user-rng.rst |  2 +
 docs/system/devices/vhost-user.rst     | 65 +++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

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
index a80e95a48a..74c8b2f8be 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -8,13 +8,76 @@ outside of QEMU itself. To do this there are a number of things
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
+  vhost-user-device without first patching out ``.abstract = true`` in
+  the ``vhost-user-device.c`` file and rebuilding.
+
 vhost-user daemon
 =================
 
-- 
2.39.2


