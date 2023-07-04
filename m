Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B774717E
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfGt-0005Lq-V3; Tue, 04 Jul 2023 08:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGfGr-0005CN-5v
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:36:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGfGp-0002wk-6B
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:36:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3143798f542so2208605f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688474197; x=1691066197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sdqM9qea1gluYMtuxISIShwJNmf3aOXgi8u2chJ8Mqc=;
 b=KublXLyFGdbsLhFpEUVt++PgUs9aKclaLrLvP6kqGFMTZOsEOvA19VHjpuRJeP5jEW
 PlHe/11iujAx66XyBU5htmeEl1zB/osGzSebNpOKOUvqQsRwbEYDY+BFf8YPZTBgUL70
 A+4UecndPUgakRghoD1o714sKh3DP2WNDNWWhlIv2kkAOu0ISisjpMXNP5iT2It6uC09
 QmI7JQIgwrtpGKdfMpcd5cNWBRWtNpQhQL+AeeHbZgBQzhWesPBzkwyDLb3qdaMCvMCI
 DuHJDfb56ZlxMOwsQ5EiAUtHL4WjLvvRBaFDzyuPCYxcfnwlJWoZaReVs+Nh5mzMbNkM
 aaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688474197; x=1691066197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sdqM9qea1gluYMtuxISIShwJNmf3aOXgi8u2chJ8Mqc=;
 b=NWFPc42ySwz40MrFv2wJ+Xdmms6Sx3XM0No+6F4S1hLzQoWp5UyllxC/tfSI4E8lOG
 wKHm4epUkP3FZaRUw5ZWCAYFPGnGWXdDtoqxmCDkkIJBEHpmTn+66R5Ew3gRxcZoXEUx
 HQjqIxhn8g2696Fdc7zGtStpQny4KKVTnJWV6gZjdoZlEMMjI0p208ax1BWpKCvsktIm
 z3dB69xUeaz5uulTkJSSHd4gbggOVbrhsaiH3cMVmT4s36JTvI2HkhW30RA78kqCXXoe
 xePnukj85/ArxGhqCtfe3KGOnAh29W3dD+/iObsSOaX0ZNbuPv8wHRl58op7AOsj3HoH
 Intw==
X-Gm-Message-State: ABy/qLb4+7O+xdzh8e6itGihp99nV5f1OnLXxJDuqLJyWqA6uomCPB9z
 oYmxJldx4vUY5+Gl9v8A6TUAEA==
X-Google-Smtp-Source: APBJJlF5bvL3gi1v3zWPv3B1bXUa9h+fhIfUgkdWSqdKmBeq2DBxu2CN6lTXrui4wd13YhXvQxqojQ==
X-Received: by 2002:a5d:670a:0:b0:313:eadf:b82d with SMTP id
 o10-20020a5d670a000000b00313eadfb82dmr9395725wru.69.1688474197450; 
 Tue, 04 Jul 2023 05:36:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k9-20020adff5c9000000b0031411b7087dsm15334074wrp.20.2023.07.04.05.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:36:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8FF211FFBB;
 Tue,  4 Jul 2023 13:36:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com,
 marcandre.lureau@redhat.com, stefanha@redhat.com, viresh.kumar@linaro.org,
 sgarzare@redhat.com, takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Date: Tue,  4 Jul 2023 13:36:00 +0100
Message-Id: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
 docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c      |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..85b1b1583a 100644
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
 
@@ -885,6 +902,13 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
+
+Some features are only valid in the presence of other supporting
+features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
+backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
+``VHOST_USER_PROTOCOL_F_STATUS``.
+
 
 Front-end message types
 -----------------------
@@ -1440,6 +1464,19 @@ Front-end message types
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


