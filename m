Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A09374DA21
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIt2x-0002XW-OT; Mon, 10 Jul 2023 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2s-0002WL-BW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2p-0006Lz-Tq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso52131215e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003802; x=1691595802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmygjvZg8uFQsUpexNqFXIftg/uxTgYWjvmcSaLAlsA=;
 b=K+2L5/KZsyNq2tWxX1t3NkN+Tas0iUV8sqmJbF8Bc1mBDsis9QGrtaPM6uWbU0O6EJ
 3bSL27/+49AgEl/1zUOzqznhTS7uptifshnsILnPb8Ysxny83UMqJv7qrX1EJSfNbaLE
 Y6hUgGF/ljtDn+1/g/obYmnkGelgzkpeSwAlR7o/l9tfJZXMmJbqw40/Ik1pt8LL+oxC
 ubbYAkTFnF+GkjSTpMQRpy9dJnk2lai7+GH5xVRt7EgWpiQV0uEUefvA0EbkXHwLurp7
 /uobhuxqpzB4FGOZ9bLsboHb9Ig+4QMo4/9GYqxDGdUgazYs4cRI6JoT7A14GzQYDILz
 8d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003802; x=1691595802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmygjvZg8uFQsUpexNqFXIftg/uxTgYWjvmcSaLAlsA=;
 b=gQs6o+Q+LX1A7reEThDa9jr0No4XRA9TKkDIhzLM5Cvk8Wp+zNsh+xfnHg5xJ2JzS3
 D+1i0oEaa8jFNU9ZviLgNinjWSLAGpvFdk8LoxmjIwf2Txqk4nHPz9/bG4491CsM9sSp
 SkhcsB6aiPaKHyKF2IIVrgfpd6YqaSLISpsFGbemL4g40w1R1nOs18po9mFomfQr1YkM
 wJ4afu0nK6ciRZ+5HOzcSV5s1IlLUkgTyZnp83sn1ru/CStmWCz5IRWkvEs1U4qTBCq5
 AUn9R2OQRaHqBn68LN/eVDDBgNsIY6h50MfRj6TTvLLDnzhDuQD0Rf4ABf+LNeVuOcK9
 e8pg==
X-Gm-Message-State: ABy/qLbAFeZWM1rbdyKUiB3jhO4sXx/KSr/SmynX780R1GS0LRN4fReX
 vNoUfRa2+FD0zMnh7Jgo2N7qEQ==
X-Google-Smtp-Source: APBJJlFqFG9B/dkVGhlm1Nlcwcfm7uGJi6fCci/1rziAm2SPQ/PxHiyj0YsDKmTxWa8FuUYAZQpMnQ==
X-Received: by 2002:a05:600c:3785:b0:3fb:a0fc:1ba1 with SMTP id
 o5-20020a05600c378500b003fba0fc1ba1mr15154065wmr.35.1689003802252; 
 Mon, 10 Jul 2023 08:43:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a7bcb0d000000b003fbc9b9699dsm155911wmj.45.2023.07.10.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:43:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEAE71FFC9;
 Mon, 10 Jul 2023 16:35:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH v3 14/20] docs/interop: define STANDALONE protocol feature
 for vhost-user
Date: Mon, 10 Jul 2023 16:35:16 +0100
Message-Id: <20230710153522.3469097-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Currently QEMU has to know some details about the back-end to be able
to setup the guest. While various parts of the setup can be delegated
to the backend (for example config handling) this is a very piecemeal
approach.

This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
which the back-end can advertise which allows a probe message to be
sent to get all the details QEMU needs to know in one message.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
Initial RFC for discussion. I intend to prototype this work with QEMU
and one of the rust-vmm vhost-user daemons.
---
 docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c      |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..a2080f56f3 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -275,6 +275,21 @@ Inflight description
 
 :queue size: a 16-bit size of virtqueues
 
+Backend specifications
+^^^^^^^^^^^^^^^^^^^^^^
+
++-----------+-------------+------------+------------+
+| device id | config size |   min_vqs  |   max_vqs  |
++-----------+-------------+------------+------------+
+
+:device id: a 32-bit value holding the VirtIO device ID
+
+:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
+
+:min_vqs: a 32-bit value holding the minimum number of vqs supported
+
+:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
+
 C structure
 -----------
 
@@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserConfig config;
           VhostUserVringArea area;
           VhostUserInflight inflight;
+          VhostUserBackendSpecs specs;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
 * ``VHOST_USER_GET_VRING_BASE``
 * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
 * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
 
 .. seealso::
 
@@ -885,6 +902,15 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
+
+Some features depend on others to be supported:
+
+* ``VHOST_USER_PROTOCOL_F_STANDALONE`` depends on:
+
+  * ``VHOST_USER_PROTOCOL_F_STATUS``
+  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
+
 
 Front-end message types
 -----------------------
@@ -1440,6 +1466,19 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_GET_BACKEND_SPECS``
+  :id: 41
+  :request payload: N/A
+  :reply payload: ``Backend specifications``
+
+  When the ``VHOST_USER_PROTOCOL_F_STANDALONE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to
+  query the back-end for its capabilities. This is intended to remove
+  the need for the front-end to know ahead of time what the VirtIO
+  device the backend emulates is.
+
+  The reply contains the device id, size of the config space and the
+  range of VirtQueues the backend supports.
 
 Back-end message types
 ----------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c4e0cbd702..28b021d5d3 100644
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


