Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE63824A0E
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:11:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUzJ-000770-JX; Thu, 04 Jan 2024 16:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyU-0006wr-Kz
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:59 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyS-0007Uy-43
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:58 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3367a304091so746452f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402594; x=1705007394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObKwt//EhgHompi9v5X1bJx9VVsKykUNbS0pmE1n/mg=;
 b=OU2uwP397KAm1ZEdhQjXLEzjpSaCFAc6gk+pwolayN8MsHArE54Zqi5rqu/1UMUIqq
 dGyR98wO7QLzX1+bzDmBY5QFqxROE7O592BuzpvH/05644C53ojzmOp5Ah8jtba9Y3r1
 7YCAx1RZ4u20eVOynwIC76jKwTs/zv7dPVjnrx7W3N6RIPN5zTvunIgJPRh/QpHKWBk9
 UUfa9XlypS18DAGjWZ4p7uB2mH3vhwR1ijchLQxDwwJe5hAn5jsljwJTdB81MrpY6gjV
 GjFA7/w3YqOPQkGJSwOycQS/2Oc1GWqt3g1CLyCjix9hZyHtZuoTk+JThQjSPePKHzKY
 F4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402594; x=1705007394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObKwt//EhgHompi9v5X1bJx9VVsKykUNbS0pmE1n/mg=;
 b=xRpuBVyTaHijfX40HFULGqcsWe8dq3l4FuAP8z6CLqkMeNWE1MmAiq320P4BJrkdvE
 7ovC/plgqJGAZhGqUYNJcFYB/axuSXBSVW1Mb6P0h/wzJmuoJcFNJTTsgsBkt+uFKmhC
 lEInkgaVLK4dchYicG2wC1TIM8PQ+9hZZRcQnIVRxlQlhtDbc+tL/3HeB2d995fc/a7u
 SjSBiR6hIwsVFZ9j+cihrjRfRa2QOYNGmgyppesYwm99NwYU46MlOBijJQCVEanFvwy5
 jvDNjRUOXqih4DND6dxnesYZyNzdg1PStktIz6Q6qTIrZHHZMkrkHHQF63MzwjldEcqD
 vNSA==
X-Gm-Message-State: AOJu0YxYqo7YyOsj8riwYMrhr2kn9ubLnEyOimdv/2FU1qumebFaNjr2
 f+QMN/7Y4vnvLZEQUPcJuTF87smBCklTWQ==
X-Google-Smtp-Source: AGHT+IHr24W8JgS8O3X1q2MJrAxydbEIzJyQyci/srrzU4XD25EI7spN1TV5wrjD9B/Jb1ct4eTatQ==
X-Received: by 2002:a5d:4ecf:0:b0:336:6e2f:930e with SMTP id
 s15-20020a5d4ecf000000b003366e2f930emr407735wrv.176.1704402594551; 
 Thu, 04 Jan 2024 13:09:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b003368c8d120fsm110223wrx.7.2024.01.04.13.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EFA455F942;
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
 Stefan Hajnoczi <stefanha@redhat.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 09/11] docs/system: Add vhost-user-input documentation
Date: Thu,  4 Jan 2024 21:09:43 +0000
Message-Id: <20240104210945.1223134-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

This adds basic documentation for vhost-user-input.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Message-Id: <20231120043721.50555-3-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                              |  1 +
 docs/system/device-emulation.rst         |  1 +
 docs/system/devices/vhost-user-input.rst | 45 ++++++++++++++++++++++++
 docs/system/devices/vhost-user.rst       |  4 ++-
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 607f71817f8..ff70987aeb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2274,6 +2274,7 @@ L: virtio-fs@lists.linux.dev
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
+F: docs/system/devices/vhost-user-input.rst
 F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index d1f3277cb02..f19777411cd 100644
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
index 00000000000..118eb78101c
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
index c6afc4836f9..9b2da106cec 100644
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


