Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4EA7EA33F
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cCm-0002dj-PW; Mon, 13 Nov 2023 14:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCj-0002db-N0
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:38 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCh-0000L5-7L
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:37 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-421bcd0b532so16892841cf.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 11:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699902154; x=1700506954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYSYSgbV/GuLcMBTYGrmXS1BeLIkylU92XcqQA40kIg=;
 b=A/l2x5bXQoQRjKcmWHve+gCwW40StMbs8HD3VCH2dNZ5LS3Mwp7hxp7lQ0VwXneaIR
 s9mWzQ+K81EKH6RuJmsSkY6XMBX9NzwsMLvcYuAvaZRkfIKLZ9aDDGQPj4hfOIFzaFoZ
 G3qF1LR1VyaqtyHbegLuPxZNfszmtwLxBCe8Ye69rBqombAsA5qDvYVxejqkqMla9ZQS
 nmhsNkr7q1P50EIXCpauyAW2Rhaapp98gKIxPlr12BRiRdRffLWLbQVklK84tZvuNHB0
 0h1yZwmWTQ0PVC60PFdc44Yz2Uw+Bd6mPF/YVzLLd3JOqTEBcPED7uuQLreaMACGFfUG
 LNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699902154; x=1700506954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYSYSgbV/GuLcMBTYGrmXS1BeLIkylU92XcqQA40kIg=;
 b=DRCEp12Vo26oHW5+w/rdmAVVz7lgTRgrc7bttalI7m/6efzy3h6Tml99t38IBdMKTL
 uNh+DUW1BJ/CzcN7RWK1LKkZUnfsNI56uOBWA4WDxYYuZ69JS9ZayE5bIm+7mFk/LixQ
 aETYcziV3fWLsZiialES0q5h82knvs57OH4MrEBvBeDVxMZC9QrhgaPKHnAfDjfn84Tl
 chCSw8IbrU5/FlUzfYrM5gY5KRbrsnyPaakspjpFTxxVVZkrf6glDxMYC6PT5CvuO+ig
 CCdX0gNKUPZjnwn0U3Nw/3kBEd5ZPbL2t5+UYuhZMMbtbzYOg9cOnuMd+tAtBQwXIlyX
 Q7+A==
X-Gm-Message-State: AOJu0Yy9CLljcgjoOBxqj/Bo3Go3wbZe4CRdX6olYK5c+o7YkJt+dGEv
 wyiZrxLRq7fSXlTZ6Hp3QhN45FYlTKIvdQqEgCEKgoSHd5k=
X-Google-Smtp-Source: AGHT+IGvxbBXrnZiM2bOelyc9TrOdArai7bc4Pfvo8Scr8TboVgdCZXDEUKr6b3PMnIfNRDMPD2vXA==
X-Received: by 2002:ac8:7fd3:0:b0:413:bd3:cda5 with SMTP id
 b19-20020ac87fd3000000b004130bd3cda5mr9226970qtk.49.1699902154250; 
 Mon, 13 Nov 2023 11:02:34 -0800 (PST)
Received: from localhost.localdomain ([12.186.190.1])
 by smtp.gmail.com with ESMTPSA id
 kq4-20020ac86184000000b004181c32dcc3sm2124834qtb.16.2023.11.13.11.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 11:02:31 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/4] docs/system: Add vhost-user-input documentation
Date: Tue, 14 Nov 2023 03:02:09 +0800
Message-Id: <20231113190211.92412-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113190211.92412-1-leo.yan@linaro.org>
References: <20231113190211.92412-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=leo.yan@linaro.org; helo=mail-qt1-x82c.google.com
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
 docs/system/devices/vhost-user-input.rst | 44 ++++++++++++++++++++++++
 docs/system/devices/vhost-user.rst       |  2 +-
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 86c649784e..ef72c6d512 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2233,6 +2233,7 @@ L: virtio-fs@redhat.com
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
+F: docs/system/devices/vhost-user-input.rst
 F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devices/vhost-user-input.rst
new file mode 100644
index 0000000000..4ff9dd4b27
--- /dev/null
+++ b/docs/system/devices/vhost-user-input.rst
@@ -0,0 +1,44 @@
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
+backend daemon and share memory with the guest over a memfd.
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
index c6afc4836f..75b40f08c6 100644
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
-- 
2.34.1


