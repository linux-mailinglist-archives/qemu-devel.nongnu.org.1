Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C178FC07
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:02:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1tM-0006DH-5X; Fri, 01 Sep 2023 07:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qc1tK-0006D6-U7
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:00:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qc1tI-0004gI-4t
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:00:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so1626445f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693566037; x=1694170837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wz9n8fqsI7jiFNwYpSgDyJmxy3p7QY81tAlou+VirwE=;
 b=i/NRHwBH3+CgWHeqLN7cpsR45TAVVyFf29cXE4QbQgBR9uSBRTZype/apm3HBJ62/p
 /rRKpPFi9nAZwcmvJhhB3tqQJs9orFUUKKV4FIi2F+PEItgTbET7AJr6Yg5koem1St3S
 UOEK4CSSuWMCby0UNRS4AvLfaSWgSj0fI0hAvufxYfO/F7/HCx6HSNID/4NOH5pyUWn/
 pzAFnMB8OYyWPgdf55ONYpZk1nyPfgJ5e80SGpj2soE5hNjdo3CiV0YgeRPl6vlGnb63
 yKTjXW0lPB7vhYCjB3DKON1Elktvfk9qSnL8Yttdi5/Na8P8ZbcnTHz+7Xq45xyc7eoL
 VU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693566037; x=1694170837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wz9n8fqsI7jiFNwYpSgDyJmxy3p7QY81tAlou+VirwE=;
 b=mCARphsxOHWpRclpm/yyA9oKmpr/Fx08UdN+lE9DnFM6YqXEE1/XQVXRFDhu5BF2DR
 M/1eWzL05ii5D7KaFSBBw8A8OoT0SQ7RAAjSsGzk/f7ppOLTNS9xD90PamoMVCmaHniU
 igepFe0paR4i3Nq2WdphZCrYcY7xclJRQF8SBc3rmh5kHWBTQTbP7n5FvuQ/+d5J44i6
 tDOrAlhkSZYjkL3OojW6nrFz4fLatYYm1B4sMB8VvRN+kb/0vDe1chv+kvHvQW3s/SRZ
 Grc62iWZmIs0B3DLPDD+R+MWZNe0RqsdNFjJiPZZeiPKisHZfetvyZDkNO9tdIIGsUc1
 qeXg==
X-Gm-Message-State: AOJu0YwvlXeSMISUwZpUJzXRAgQuAQEUxpQryf6Pw/sZScTLFXIB0+B1
 qRP10nC+jCZmDZ288n0Sir9zNg==
X-Google-Smtp-Source: AGHT+IGh/sgWTZUny+y2lH4VfX+G4sFgF/tDfU4lH4e7mn2APqbe4Lk7xUbBwsDPnCU+ed1gsBJDIg==
X-Received: by 2002:a5d:4410:0:b0:317:5ece:e169 with SMTP id
 z16-20020a5d4410000000b003175ecee169mr1573956wrq.68.1693566037191; 
 Fri, 01 Sep 2023 04:00:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a056000050300b003179d5aee67sm4849057wrf.94.2023.09.01.04.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 04:00:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3644A1FFBB;
 Fri,  1 Sep 2023 12:00:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com, viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2] docs/interop: define PROBE feature for vhost-user
 VirtIO devices
Date: Fri,  1 Sep 2023 12:00:18 +0100
Message-Id: <20230901110018.3704459-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Currently QEMU has to know some details about the VirtIO device
supported by a vhost-user daemon to be able to setup the guest. This
makes it hard for QEMU to add support for additional vhost-user
daemons without adding specific stubs for each additional VirtIO
device.

This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
which the back-end can advertise which allows a probe message to be
sent to get all the details QEMU needs to know in one message.

Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
daemons which are capable of handling all aspects of the VirtIO
transactions with only a generic stub on the QEMU side. These daemons
can also be used without QEMU in situations where there isn't a full
VMM managing their setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - dropped F_STANDALONE in favour of F_PROBE
  - split probe details across several messages
  - probe messages don't automatically imply a standalone daemon
  - add wording where probe details interact (F_MQ/F_CONFIG)
  - define VMM and make clear QEMU is only one of many potential VMMs
  - reword commit message
---
 docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++-----
 hw/virtio/vhost-user.c      |  8 ++++
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..ba3b5e07b7 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -7,6 +7,7 @@ Vhost-user Protocol
 ..
   Copyright 2014 Virtual Open Systems Sarl.
   Copyright 2019 Intel Corporation
+  Copyright 2023 Linaro Ltd
   Licence: This work is licensed under the terms of the GNU GPL,
            version 2 or later. See the COPYING file in the top-level
            directory.
@@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication, *front-end* and
 *back-end*. The *front-end* is the application that shares its virtqueues, in
 our case QEMU. The *back-end* is the consumer of the virtqueues.
 
-In the current implementation QEMU is the *front-end*, and the *back-end*
-is the external process consuming the virtio queues, for example a
-software Ethernet switch running in user space, such as Snabbswitch,
-or a block device back-end processing read & write to a virtual
-disk. In order to facilitate interoperability between various back-end
-implementations, it is recommended to follow the :ref:`Backend program
-conventions <backend_conventions>`.
+In the current implementation a Virtual Machine Manager (VMM) such as
+QEMU is the *front-end*, and the *back-end* is the external process
+consuming the virtio queues, for example a software Ethernet switch
+running in user space, such as Snabbswitch, or a block device back-end
+processing read & write to a virtual disk. In order to facilitate
+interoperability between various back-end implementations, it is
+recommended to follow the :ref:`Backend program conventions
+<backend_conventions>`.
 
 The *front-end* and *back-end* can be either a client (i.e. connecting) or
 server (listening) in the socket communication.
 
+Probing device details
+----------------------
+
+Traditionally the vhost-user daemon *back-end* shares configuration
+responsibilities with the VMM *front-end* which needs to know certain
+key bits of information about the device. This means the VMM needs to
+define at least a minimal stub for each VirtIO device it wants to
+support. If the daemon supports the right set of protocol features the
+VMM can probe the daemon for the information it needs to setup the
+device. See :ref:`Probing features for standalone daemons
+<probing_features>` for more details.
+
+
 Support for platforms other than Linux
 --------------------------------------
 
@@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
 * ``VHOST_USER_GET_VRING_BASE``
 * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
 * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
 
 .. seealso::
 
@@ -396,9 +412,10 @@ must support changing some configuration aspects on the fly.
 Multiple queue support
 ----------------------
 
-Many devices have a fixed number of virtqueues.  In this case the front-end
-already knows the number of available virtqueues without communicating with the
-back-end.
+Many devices have a fixed number of virtqueues. In this case the
+*front-end* usually already knows the number of available virtqueues
+without communicating with the back-end. For standalone daemons this
+number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` message.
 
 Some devices do not have a fixed number of virtqueues.  Instead the maximum
 number of virtqueues is chosen by the back-end.  The number can depend on host
@@ -885,6 +902,23 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_PROBE                18
+
+.. _probing_features:
+
+Probing features for standalone daemons
+---------------------------------------
+
+The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
+of additional messages which allow the *front-end* to probe details
+about the VirtIO device from the *back-end*. However for a *back-end*
+to be described as standalone it must also support:
+
+  * ``VHOST_USER_PROTOCOL_F_STATUS``
+  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
+
+which are required to ensure the *back-end* daemon can operate
+without the *front-end* managing some aspects of its configuration.
 
 Front-end message types
 -----------------------
@@ -1440,6 +1474,42 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_GET_DEVICE_ID``
+  :id: 41
+  :request payload: N/A
+  :reply payload: ``u32``
+
+  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end
+  to query what VirtIO device the back-end support. This is intended
+  to remove the need for the front-end to know ahead of time what the
+  VirtIO device the backend emulates is.
+
+``VHOST_USER_GET_CONFIG_SIZE``
+  :id: 42
+  :request payload: N/A
+  :reply payload: ``u32``
+
+  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end
+  to query the size of the VirtIO device's config space. This is
+  intended to remove the need for the front-end to know ahead of time
+  what the size is. Replying with 0 when
+  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
+  an bug.
+
+``VHOST_USER_GET_MIN_VQ``
+  :id: 43
+  :request payload: N/A
+  :reply payload: ``u32``
+
+  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to
+  query minimum number of VQ's required to support the device. A
+  device may support more than this number of VQ's if it advertises
+  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
+  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` would
+  indicate a bug.
 
 Back-end message types
 ----------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..4d433cdf2b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+typedef struct VhostUserBackendSpecs {
+    uint32_t device_id;
+    uint32_t config_size;
+    uint32_t min_vqs;
+    uint32_t max_vqs;
+} VhostUserBackendSpecs;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -226,6 +233,7 @@ typedef union {
         VhostUserCryptoSession session;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserBackendSpecs specs;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
-- 
2.39.2


