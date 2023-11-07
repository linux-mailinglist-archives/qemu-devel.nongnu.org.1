Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD37E47C3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:04:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QPv-00088h-0F; Tue, 07 Nov 2023 13:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPg-00086s-Kt
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:57 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPe-0000gn-2R
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32f7c44f6a7so3553538f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380172; x=1699984972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjrsuQ6/uCHQnudTjxdx5KRWGaPot2PzYlmZFPHERhk=;
 b=b2hR++1XuG+00xF0uQT69YHlWwL12N+KDYJtLcHjKwvHUAaM0QKGEK9AvXVk6tQVnx
 8TsQvMiWl7nzoY1fU+uw7GaClnNzZuUDD/iZq4VFcJgiGpXJwId2lkKfZcqv/BTYJVTn
 3fLDGX2gJZRHGLrqWa2nAUkb7quTUv9DgczFu7reMflZmtvuLCSBVb+0lo7g23K8RnSz
 x8tb7pL/7E12lTPAp0qxHbdus+hwFdidOQGAkVCq22a6gevwLZeREE8qTvZpHCXXcYEi
 tRP3/t3JSz4d3ERd2JjRwUPtgyHAKYPeTWknlC0NOm6kPl9Sa8D9hS1zfsYF4mXFDKeh
 JQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380172; x=1699984972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjrsuQ6/uCHQnudTjxdx5KRWGaPot2PzYlmZFPHERhk=;
 b=LMwKHnOdwrfeNRVQ89TnRbKpLYMd844qDU94wwyTDig+l2gUgfWy92c06y+ecxGPw9
 MxI5eoXkLiED+QPH6mzbj3lWU7ba9fS+i0WzskTY0iOVgr4GJQLvySoVrsuL177BIXd6
 d0s6+8OwjnVSEBKM2ktxqhab5HWA9StKUjl2ydxITfxFGMkp0oMjubEaGSJl6MxowbWh
 Kye3KmzXeJqUN2F9AzVykKIc0El9ZM0lxdF5mawbs/lw2EVe/lkOnLx07ZFBTay+5imT
 rdT1bhj1aoUFSaCUF75bVLtnP90wuApVrxPVn/kdT7p1omby3xGCVp8tdr7vq7iWgjbT
 2owQ==
X-Gm-Message-State: AOJu0YwvPw9Dn8K4yLMRzPJj+v3Owdxwpl52FA5/sjP29xr1fwc4FLvF
 w8S2zjxY2bE2YBGtoLGuqXNDxQ==
X-Google-Smtp-Source: AGHT+IFr20qX3E3v82qNa2ILdGvvFapMP2HG6koieeTmHISoJYpu7qPyDHwyPeF7/rjN4VIHwbCXOA==
X-Received: by 2002:a05:6000:402c:b0:323:2d01:f043 with SMTP id
 cp44-20020a056000402c00b003232d01f043mr37614174wrb.3.1699380172682; 
 Tue, 07 Nov 2023 10:02:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l2-20020a5d4bc2000000b0032da319a27asm2955285wrt.9.2023.11.07.10.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:02:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 677016575D;
 Tue,  7 Nov 2023 18:02:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, virtio-fs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v7 7/7] docs/system: add a basic enumeration of vhost-user
 devices
Date: Tue,  7 Nov 2023 18:02:46 +0000
Message-Id: <20231107180246.3456598-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107180246.3456598-1-alex.bennee@linaro.org>
References: <20231107180246.3456598-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
v7
  - fix patching description
---
 docs/system/devices/vhost-user-rng.rst |  2 +
 docs/system/devices/vhost-user.rst     | 70 +++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

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
index a80e95a48a..c6afc4836f 100644
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


