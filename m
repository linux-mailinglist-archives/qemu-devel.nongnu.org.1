Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D47E47DC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QUo-0006zi-UW; Tue, 07 Nov 2023 13:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUd-0006sh-Ul
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:08:03 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUZ-00026y-EB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:08:02 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507975d34e8so8624813e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380477; x=1699985277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKC1LNIfj9tc06yjyzpgfvvZWaBsp45q1uaz/hs/4dA=;
 b=Y5GfEFeO3h0xcqxJ/mknMdFccr5Zpfkkfqvj4XQVWE/fNmylVeG3VyqpNYXWBadE9+
 QBgNvpZSYYPHfY3nnznB6Cr1y4aa2TXWrnJHIxHa+q7KyFuvM3/wHxzQaW7JZFbZYS+H
 L5m6Vjp4HlBy1ZuvHVwwyajDKtKAL5w/W/rSaUxel9TinOEtQ6NgASg/KJRY69vpwTEH
 RZeIunIMwnG3HB660DKOWNWkXJQE0eOQD8zYZoyiHZL5Gke065VuN86f57EI4b0HK8g0
 AAlo3GRruBpZYxoAFduktzw5jVg/aYn/m0/zYYXC2dgdEHga6mz9PxXjOEjhs2y8cNCM
 xyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380477; x=1699985277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKC1LNIfj9tc06yjyzpgfvvZWaBsp45q1uaz/hs/4dA=;
 b=gi0arGTSZXDtHvolO0aoRUYhT/D8qJ1+2cKRegcM+QGWboLWy1RtCRB9OHr5GYuejV
 oKbbbqTwJB8nXXpVii2D8eAZOf7/tGSAR2ozM+1FZ+zinN3KKhMhLHvJXmxWSyf47aJn
 pfGPK90apCuzqE96sECDkZuj92Lmgt50XM2YWbOZ9ZK1G4vj3qovIFnbt3XaTKq3g+5v
 9TIJTtqdOdAQRwVNI22jGXqYIX94ialDCCOlyZ84J9iOMa798QzLpqdu5yGCnDDmOGoj
 e2jaO+YqYYyCiIGhFqea/jYDChbRbN/nSb+nHJ7ec+sVuDjNG5tZHx+DcYA9Vz5evs/f
 6g0w==
X-Gm-Message-State: AOJu0YwdlNneL/rZqOvYJdmLoUQpCqeuCAWAkHKohipysDLjzYwBaaLy
 A2uNAgSBp+VzZYGSG2CJG8n/PA==
X-Google-Smtp-Source: AGHT+IGsIw9TUjZNlpk6tVtYTkQzRGPmg4Na8p66rpLAqLGFUYBgIb4PxL8/93B9M1WJQ+XdRkawew==
X-Received: by 2002:a05:6512:3f0c:b0:508:17be:c366 with SMTP id
 y12-20020a0565123f0c00b0050817bec366mr5870203lfa.21.1699380477236; 
 Tue, 07 Nov 2023 10:07:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x17-20020adfffd1000000b0032710f5584fsm2997290wrs.25.2023.11.07.10.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:07:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 23A5C6575D;
 Tue,  7 Nov 2023 18:07:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, virtio-fs@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 7/7] docs/system: add a basic enumeration of vhost-user
 devices
Date: Tue,  7 Nov 2023 18:07:52 +0000
Message-Id: <20231107180752.3458672-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107180752.3458672-1-alex.bennee@linaro.org>
References: <20231107180752.3458672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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


