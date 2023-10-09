Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D50257BD7D0
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn3N-0006YD-O8; Mon, 09 Oct 2023 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn3I-0006W2-Ll
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn3A-00081s-Go
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so39625505e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845582; x=1697450382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJso+7/SyOzlPSfGsjFdKvvog0Z+6+yUR2hdcAwaBfc=;
 b=BfXsAS1yLf7PWlcK5eW9WMiTiYS/Bpqf7hupxQVJiKNxGoT3kfYYBoOE5qNd/shnZw
 WiZCz4stA4BTN4cqSKAzjvWDe1vy27W6wSMFgmhCMEgeHftt+km5Xwws3A72tgtn8D92
 lhj/LJ+ACu4f1eMOoctsZtGZahNDwivPoBOB6uyGm2wDY3Z0gTxYpavu6Pv8BWvM3wfe
 YdzkdDuXXF9Cztq/kST13ZsqAeXie7db1XuVsMtKPdOWFiXtG3R3h4T0WU38FZRqZEP/
 fTc440OK/7j/1+RSd360sjtk3rk/zRbKlPw73WGJ0Q6b7Xn9XTk+d2g/EH6UjoQIExSB
 9Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845582; x=1697450382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJso+7/SyOzlPSfGsjFdKvvog0Z+6+yUR2hdcAwaBfc=;
 b=Fro6xf8mR7CaU3ggO6cv/04TnadgBNDeYETw6jQjPBK2ebB4NhpW9nsArZCEACcJ/H
 C/Svf8yqdN3k57RugAS6j/cbdyAOD0KySjQDoZjSPjda75PIQXgMUnX+3oNEfcz+2EsM
 Wm38PTUOcuez4fKddKmARyDKGYeDJG6XUSnCl7v+wRrNTQbDyDzCgK6mojEw7ULf6xlW
 Rb4E9zcdKJ3cdtx7EzYB+TuVbhSVUOypHqtpaMJ3vmfdsOkIJ6b363WQ2+oSOyTLUbMb
 pGtg0wbTr/X98mj9yechd7QBEA+MN6htVKnYrBfQ+4w5+sJ2NDk9z+c55Gpve8XT9+Wt
 ylTw==
X-Gm-Message-State: AOJu0YxXpEg6el2FN0ZkV3iMEOPei5aXQsBz2jBQFi9bEE/RNK2lmm3v
 l4/BLseNAUG+gHoBVg2NXrxhTQ==
X-Google-Smtp-Source: AGHT+IHIB3GMWmvvvfK6rgpZdV/gO0cMpR8mFDzuZzytA0h5Wb4qnN2DHerTFBXlAVsZnwKG/gdZoA==
X-Received: by 2002:a05:600c:684:b0:406:8496:bd8c with SMTP id
 a4-20020a05600c068400b004068496bd8cmr12735162wmn.20.1696845581748; 
 Mon, 09 Oct 2023 02:59:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a7bc047000000b004063cced50bsm10735289wmc.23.2023.10.09.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 02:59:41 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EC7331FFC1;
 Mon,  9 Oct 2023 10:59:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Viresh Kumar <viresh.kumar@linaro.org>, virtio-fs@redhat.com,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 6/6] docs/system: add a basic enumeration of vhost-user
 devices
Date: Mon,  9 Oct 2023 10:59:37 +0100
Message-Id: <20231009095937.195728-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009095937.195728-1-alex.bennee@linaro.org>
References: <20231009095937.195728-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


