Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758347F0B71
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 05:38:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4w2Z-0000Da-Ro; Sun, 19 Nov 2023 23:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2X-0000Cx-GV
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:41 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2V-00039r-LB
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:41 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-6c34e87b571so3140015b3a.3
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 20:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700455058; x=1701059858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfEdFC/D9UpE1gEhOw+eN4wVWhKF64mX7MUD3h35eU0=;
 b=lrRVlJtiPQGOuP2pV9hlpQodpEUclZ9s79BmQJSDZ0K2tSeJN+8o9hEzRdyjs7OQac
 aeUByCwojTRWqNgHqYmQfBHLEOBJQsESw88e6biWbKPkKARuFx+grYEWbEfqUJ/vUtJj
 enOtrpw1OXvhIj4Bf7EBDCaH2EBTMrWiJEbcyyO98OdasUwzyrO/A9knBCAMIri54+ok
 L938oHZhHhM6p6gJWNxndaq5tTjMQMbLkBg20emIvW6qLW4peBjoN58jNBNaZPACwWp4
 KlRQvbOD2zsC81ayEQIE5YCgBi0ItJLXjjXydYPHibZ9AwTstXTOrQGOZWK8y6GsmrYP
 V9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700455058; x=1701059858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfEdFC/D9UpE1gEhOw+eN4wVWhKF64mX7MUD3h35eU0=;
 b=kA4orRgVneQzBef4EmBLpBtCrKPiqoudCQy/Vn0m7Ncf9Xgkvwms/2UOfLbWgvZfvH
 uD1KRAUS1rWj8CSaPlMRFMVuAGI17P/dj8rfZnCt6OQ9lkS6OpDA0X9he+42WnifpTBJ
 ZbsIDc8g1+pqeAvTVvkyRFq9rDJsq82nvu51mJnJ+snf8hWwMTCXLf2xyuzYgwRe4E6Y
 i9TfQE5yoyFcIzat6Gim9GR1gO5ojxcma7XnOZNTaamGKXdasqNCNUAskcYrHnmWpncM
 oWCGqMxNkUA017H1sXTPoRyCJNJ6nXIfn3jDUMOABuReKP5IpWsQ5WURgVXb7hzNz+C7
 n+0A==
X-Gm-Message-State: AOJu0YxUA3RkLHTdfQBJZixS9NW+lUC5eHiZnqxvSni93WzwnGUILLA5
 aPUx9aa2Md+94ro2W6+CbV0JWGiq8gi5QOqjGUo77SMpwC7fAguX
X-Google-Smtp-Source: AGHT+IH8Is1vYxMdDVfGAy7Ue6ZJkvetZjv3aKNgzLVy1MCUl8LV+OlSzevhZNvtuLszYhMIhgtAQg==
X-Received: by 2002:a05:6a00:a88:b0:6c3:1b7d:dac9 with SMTP id
 b8-20020a056a000a8800b006c31b7ddac9mr4822781pfl.34.1700455057737; 
 Sun, 19 Nov 2023 20:37:37 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net.
 [211.75.219.202]) by smtp.gmail.com with ESMTPSA id
 s41-20020a056a0017a900b006926d199fdcsm5035991pfg.190.2023.11.19.20.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 20:37:37 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/4] docs/system: Add vhost-user-input documentation
Date: Mon, 20 Nov 2023 12:37:19 +0800
Message-Id: <20231120043721.50555-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120043721.50555-1-leo.yan@linaro.org>
References: <20231120043721.50555-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=leo.yan@linaro.org; helo=mail-pf1-x442.google.com
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

This adds basic documentation for vhost-user-input.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 MAINTAINERS                              |  1 +
 docs/system/device-emulation.rst         |  1 +
 docs/system/devices/vhost-user-input.rst | 45 ++++++++++++++++++++++++
 docs/system/devices/vhost-user.rst       |  4 ++-
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 0624d67932..8a26fe9493 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2262,6 +2262,7 @@ L: virtio-fs@lists.linux.dev
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
+F: docs/system/devices/vhost-user-input.rst
 F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index d1f3277cb0..f19777411c 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -94,6 +94,7 @@ Emulated Devices
    devices/virtio-gpu.rst
    devices/virtio-pmem.rst
    devices/virtio-snd.rst
+   devices/vhost-user-input.rst
    devices/vhost-user-rng.rst
    devices/canokey.rst
    devices/usb-u2f.rst
diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devices/vhost-user-input.rst
new file mode 100644
index 0000000000..118eb78101
--- /dev/null
+++ b/docs/system/devices/vhost-user-input.rst
@@ -0,0 +1,45 @@
+.. _vhost_user_input:
+
+QEMU vhost-user-input - Input emulation
+=======================================
+
+This document describes the setup and usage of the Virtio input device.
+The Virtio input device is a paravirtualized device for input events.
+
+Description
+-----------
+
+The vhost-user-input device implementation was designed to work with a daemon
+polling on input devices and passes input events to the guest.
+
+QEMU provides a backend implementation in contrib/vhost-user-input.
+
+Linux kernel support
+--------------------
+
+Virtio input requires a guest Linux kernel built with the
+``CONFIG_VIRTIO_INPUT`` option.
+
+Examples
+--------
+
+The backend daemon should be started first:
+
+::
+
+  host# vhost-user-input --socket-path=input.sock	\
+      --evdev-path=/dev/input/event17
+
+The QEMU invocation needs to create a chardev socket to communicate with the
+backend daemon and access the VirtIO queues with the guest over the
+:ref:`shared memory <shared_memory_object>`.
+
+::
+
+  host# qemu-system								\
+      -chardev socket,path=/tmp/input.sock,id=mouse0				\
+      -device vhost-user-input-pci,chardev=mouse0				\
+      -m 4096 									\
+      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on	\
+      -numa node,memdev=mem							\
+      ...
diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index c6afc4836f..9b2da106ce 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -42,7 +42,7 @@ platform details for what sort of virtio bus to use.
     - See https://github.com/rust-vmm/vhost-device
   * - vhost-user-input
     - Generic input driver
-    - See contrib/vhost-user-input
+    - :ref:`vhost_user_input`
   * - vhost-user-rng
     - Entropy driver
     - :ref:`vhost_user_rng`
@@ -91,6 +91,8 @@ following the :ref:`vhost_user_proto`. There are a number of daemons
 that can be built when enabled by the project although any daemon that
 meets the specification for a given device can be used.
 
+.. _shared_memory_object:
+
 Shared memory object
 ====================
 
-- 
2.39.2


