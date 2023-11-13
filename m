Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 104177E93F9
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 02:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2La4-0000ZN-5m; Sun, 12 Nov 2023 20:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2La2-0000Z8-IA
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:34 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2La0-0003os-SU
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:34 -0500
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-6d2fedd836fso2477266a34.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699838251; x=1700443051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7vncVI87o92pRpzeuD48ta62u1QTVk6AgDWcVuOTqQ=;
 b=EU4wuJcoINLWVEy0HKYI5JUZFoeHb0r1BN9gttdCXGsBUpMna1ZI1IHBfp4H6WIxM3
 VJtJg6FEIniyQmOzqn7fR98mdAMCVsa0z275srr9p6f/zKCIlqY1n5EYXQPw/s8jXAzX
 8jkU2wt2P2zcMu+DjTcDB8sPD/3hC8zT8qOoH1GWDVWO+nUMX6LJ2lfq9oM6q6kVpWma
 c6+G4+SXGrWe2rnxeRiRa0Ski4hv+1Wve2gGFFD0gZlAYAihzl5l5YSXxia5QrnJ0GGn
 4qWmv74I+U8BSmfgUDDKza9ct7CGLGSrHeJiHaIP27B4cQhJ4zv+RO53XCNrQeXtzp9K
 7oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699838251; x=1700443051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7vncVI87o92pRpzeuD48ta62u1QTVk6AgDWcVuOTqQ=;
 b=B5c9zb7TIkTGOQVUgfGKEnVWCYzKijtVoKkG+yb4ic4KAbLmvX6W1p4pJTsdYvCbit
 wxUNr+EW2uBAl/3KbbR9ypV/3VjWxOLukNSaghmlPUgd0k+X0WZXfYc1Vc4hA/7UgsEK
 aIuOLVy6fOuIbPaHL+ay58MMBVJJP/MwpqQwx94opgDvAMqmz5XoCjcev+DUInqDyMW5
 dbDWn49cWFtRSwwiHUzqgHqmKxXlXayh98Lmb2lrb/mcIgKBT2R84yWRTpS5T0+fLXH/
 SYwg7F0Rt/UiEFKTQ6r+wrzFnkMTwqnwnhP4qhdsp20Burf88IVJI+6SCHDOiPDfUYo/
 AT7Q==
X-Gm-Message-State: AOJu0Yzf/3La0H7dXyKW5UcuZPAHhuH+OuYDGuqGIS2CVYNFnpXluaEM
 TXicXOpl0GICi0e1TjiQokb5ZfH6Z4gQqJzQmNPL+IIn3Cg2bw==
X-Google-Smtp-Source: AGHT+IGn9utev8X7slrdJM5NCZA9QY14S5t/bOpSbdmriokMArv47wFnJDQr3zqfxNVWbhn1GbX9SQ==
X-Received: by 2002:a05:6870:6b89:b0:1e9:919d:83ec with SMTP id
 ms9-20020a0568706b8900b001e9919d83ecmr8386683oab.28.1699838251367; 
 Sun, 12 Nov 2023 17:17:31 -0800 (PST)
Received: from localhost.localdomain ([128.1.74.235])
 by smtp.gmail.com with ESMTPSA id
 r6-20020aa78b86000000b0064f76992905sm2918511pfd.202.2023.11.12.17.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:17:31 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/4] docs/system: Add vhost-user-input documentation
Date: Mon, 13 Nov 2023 09:16:40 +0800
Message-Id: <20231113011642.48176-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113011642.48176-1-leo.yan@linaro.org>
References: <20231113011642.48176-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=leo.yan@linaro.org; helo=mail-ot1-x344.google.com
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
 docs/system/devices/vhost-user-input.rst | 44 ++++++++++++++++++++++++
 docs/system/devices/vhost-user.rst       |  2 +-
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst

diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devices/vhost-user-input.rst
new file mode 100644
index 0000000000..601282e658
--- /dev/null
+++ b/docs/system/devices/vhost-user-input.rst
@@ -0,0 +1,44 @@
+.. _vhost_user_rng:
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


