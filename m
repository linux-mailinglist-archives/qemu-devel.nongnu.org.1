Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 119997E8FDA
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 14:07:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2A9w-00042x-OY; Sun, 12 Nov 2023 08:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r2A9m-00041i-Cw
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 08:05:42 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r2A9j-0005R9-JA
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 08:05:41 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6c10f098a27so2646881b3a.2
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 05:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1699794218; x=1700399018;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/Yl0bYXSASF6s6wzvySv0OTCo121V875jhrfdS9OGA=;
 b=V5SLam5tpr+x0WTQE1CmRJNYECklYIynA5pBn0ru/qAmrSK8/2lu3Mn7Z/+BJU8U7n
 KkCYjcs3jzQzmSYnX4NB7OvJovcND+WwHzxAuXeU02W3+hMkdlRcpJP5bjn05W8rEQC2
 Wm9ijwkDNpgC+AKMTGdm8HkTwYCfIyJvxFClDgC4fPYDkNnzu0jvL0dQW/d/ZeftMPPU
 9TCsn2NlHIqdJuhKo9aGDCvH4Ek0C/HeCQrl+9YG6X+m8BKWJ5W9HCGkOJm9OQfKYNgT
 T9TxlQRZyUK2hKetWBOT8dQ9t9NqJqUZ7fBA05uEc2pU1FbufYpn7GYWzPNfnwARtK4l
 RygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699794218; x=1700399018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/Yl0bYXSASF6s6wzvySv0OTCo121V875jhrfdS9OGA=;
 b=epop/1YPjQ0ZBBnqNtVL9NxmXUWb1oe6mqcsdGS6lKY29JQalZ/gRRelB6IwzTsJL1
 VhpO+iv37vY9wL/A0iM9FWHfN50rzIllnv3aHdu0C6FHXIWwybxMKPGITOBqC4Irorgd
 BlWjAKr1g2tsf7uYRorFyGJEwkCFxWhp+rSx9OX2F5mgLMPrfkRItkyrZ0rN7C2woXh+
 WHBV2Gl9xzm86B+Z1LBnkRwc8wBXuIHAZ/Y2wSWCynNoFANvTXStZuLMYD2hEf5gZTK3
 waRKWPA6qvvBWAvjxnI0EJdNSxeZ8y5lxJedsNQXMljGLoqz4t8A6nXI+ZR+CFQY+F5l
 ggYw==
X-Gm-Message-State: AOJu0Yy6XJVMI/TCRsI8m8i3Hj7/BYISwlTbv1pqV4/bvG8wfYHiSjtd
 PVIkzZl/moThOuJaP8EIDP7Xlu5uMOwici48HJsQ+g==
X-Google-Smtp-Source: AGHT+IEBhSBa9ideiKG8r6vUbeBUFBAL+6k3cBEFUqciBTEJkM2FngnOhnXeBanB22MPsq8BkWmpVA==
X-Received: by 2002:a05:6a00:1acd:b0:6c4:cf33:cbe8 with SMTP id
 f13-20020a056a001acd00b006c4cf33cbe8mr2578725pfv.6.1699794217361; 
 Sun, 12 Nov 2023 05:03:37 -0800 (PST)
Received: from localhost.localdomain ([125.69.8.82])
 by smtp.gmail.com with ESMTPSA id
 ey8-20020a056a0038c800b006c2fcb25c15sm2477684pfb.162.2023.11.12.05.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 05:03:36 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
Date: Sun, 12 Nov 2023 21:03:19 +0800
Message-Id: <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1699793550.git.yong.huang@smartx.com>
References: <cover.1699793550.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch allows to display feature and status bits in virtio-status.

An optional argument is introduced: show-bits. For example:
{"execute": "x-query-virtio-status",
 "arguments": {"path": "/machine/peripheral-anon/device[1]/virtio-backend",
               "show-bits": true}

Features and status bits could be helpful for applications to compare
directly. For instance, when an upper application aims to ensure the
virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it use
the "ovs-vsctl list interface" command to retrieve interface features
(in number format) and the QMP command x-query-virtio-status to retrieve
vhost-user net device features. If "show-bits" is added, the application
can compare the two features directly; No need to encoding the features
returned by the QMP command.

This patch also serves as a preparation for the next one, which implements
a vhost-user test case about acked features of vhost-user protocol.

Note that since the matching HMP command is typically used for human,
leave it unchanged.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/virtio/virtio-hmp-cmds.c |  2 +-
 hw/virtio/virtio-qmp.c      | 21 +++++++++++++++-
 qapi/virtio.json            | 49 ++++++++++++++++++++++++++++++++++---
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..3774f3d4bf 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *path = qdict_get_try_str(qdict, "path");
-    VirtioStatus *s = qmp_x_query_virtio_status(path, &err);
+    VirtioStatus *s = qmp_x_query_virtio_status(path, false, false, &err);
 
     if (err != NULL) {
         hmp_handle_error(mon, err);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..2e92bf28ac 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(const char *path)
     return VIRTIO_DEVICE(dev);
 }
 
-VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
+VirtioStatus *qmp_x_query_virtio_status(const char *path,
+                                        bool has_show_bits,
+                                        bool show_bits,
+                                        Error **errp)
 {
     VirtIODevice *vdev;
     VirtioStatus *status;
+    bool display_bits =
+        has_show_bits ? show_bits : false;
 
     vdev = qmp_find_virtio_device(path);
     if (vdev == NULL) {
@@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     status->name = g_strdup(vdev->name);
     status->device_id = vdev->device_id;
     status->vhost_started = vdev->vhost_started;
+    if (display_bits) {
+        status->guest_features_bits = vdev->guest_features;
+        status->host_features_bits = vdev->host_features;
+        status->backend_features_bits = vdev->backend_features;
+    }
     status->guest_features = qmp_decode_features(vdev->device_id,
                                                  vdev->guest_features);
     status->host_features = qmp_decode_features(vdev->device_id,
@@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     }
 
     status->num_vqs = virtio_get_num_queues(vdev);
+    if (display_bits) {
+        status->status_bits = vdev->status;
+    }
     status->status = qmp_decode_status(vdev->status);
     status->isr = vdev->isr;
     status->queue_sel = vdev->queue_sel;
@@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
+        if (display_bits) {
+            status->vhost_dev->features_bits = hdev->features;
+            status->vhost_dev->acked_features_bits = hdev->acked_features;
+            status->vhost_dev->backend_features_bits = hdev->backend_features;
+            status->vhost_dev->protocol_features_bits = hdev->protocol_features;
+        }
         status->vhost_dev->features =
             qmp_decode_features(vdev->device_id, hdev->features);
         status->vhost_dev->acked_features =
diff --git a/qapi/virtio.json b/qapi/virtio.json
index e6dcee7b83..608b841a89 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -79,12 +79,20 @@
 #
 # @vq-index: vhost_dev vq_index
 #
+# @features-bits: vhost_dev features in decimal format
+#
 # @features: vhost_dev features
 #
+# @acked-features-bits: vhost_dev acked_features in decimal format
+#
 # @acked-features: vhost_dev acked_features
 #
+# @backend-features-bits: vhost_dev backend_features in decimal format
+#
 # @backend-features: vhost_dev backend_features
 #
+# @protocol-features-bits: vhost_dev protocol_features in decimal format
+#
 # @protocol-features: vhost_dev protocol_features
 #
 # @max-queues: vhost_dev max_queues
@@ -102,9 +110,13 @@
             'n-tmp-sections': 'int',
             'nvqs': 'uint32',
             'vq-index': 'int',
+            'features-bits': 'uint64',
             'features': 'VirtioDeviceFeatures',
+            'acked-features-bits': 'uint64',
             'acked-features': 'VirtioDeviceFeatures',
+            'backend-features-bits': 'uint64',
             'backend-features': 'VirtioDeviceFeatures',
+            'protocol-features-bits': 'uint64',
             'protocol-features': 'VhostDeviceProtocols',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
@@ -124,10 +136,16 @@
 #
 # @vhost-started: VirtIODevice vhost_started flag
 #
+# @guest-features-bits: VirtIODevice guest_features in decimal format
+#
 # @guest-features: VirtIODevice guest_features
 #
+# @host-features-bits: VirtIODevice host_features in decimal format
+#
 # @host-features: VirtIODevice host_features
 #
+# @backend-features-bits: VirtIODevice backend_features in decimal format
+#
 # @backend-features: VirtIODevice backend_features
 #
 # @device-endian: VirtIODevice device_endian
@@ -135,6 +153,9 @@
 # @num-vqs: VirtIODevice virtqueue count.  This is the number of
 #     active virtqueues being used by the VirtIODevice.
 #
+# @status-bits: VirtIODevice configuration status in decimal format
+#     (VirtioDeviceStatus)
+#
 # @status: VirtIODevice configuration status (VirtioDeviceStatus)
 #
 # @isr: VirtIODevice ISR
@@ -170,10 +191,14 @@
             'device-id': 'uint16',
             'vhost-started': 'bool',
             'device-endian': 'str',
+            'guest-features-bits': 'uint64',
             'guest-features': 'VirtioDeviceFeatures',
+            'host-features-bits': 'uint64',
             'host-features': 'VirtioDeviceFeatures',
+            'backend-features-bits': 'uint64',
             'backend-features': 'VirtioDeviceFeatures',
             'num-vqs': 'int',
+            'status-bits': 'uint8',
             'status': 'VirtioDeviceStatus',
             'isr': 'uint8',
             'queue-sel': 'uint16',
@@ -195,6 +220,9 @@
 #
 # @path: Canonical QOM path of the VirtIODevice
 #
+# @show-bits: Whether to display the feature & status bits.
+#     Default is disabled. (Since 8.2)
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -208,7 +236,8 @@
 # 1. Poll for the status of virtio-crypto (no vhost-crypto active)
 #
 # -> { "execute": "x-query-virtio-status",
-#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
+#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
+#                     "show-bits": true }
 #    }
 # <- { "return": {
 #          "device-endian": "little",
@@ -216,6 +245,7 @@
 #          "disable-legacy-check": false,
 #          "name": "virtio-crypto",
 #          "started": true,
+#          "guest-features-bits": 5100273664,
 #          "device-id": 20,
 #          "backend-features": {
 #              "transports": [],
@@ -241,6 +271,7 @@
 #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
 #              ]
 #          },
+#          "host-features-bits": 6325010432,
 #          "host-features": {
 #              "unknown-dev-features": 1073741824,
 #              "dev-features": [],
@@ -252,9 +283,11 @@
 #                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
 #              ]
 #          },
+#          "backend-features-bits": 0,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 1,
+#          "status-bits": 15,
 #          "disabled": false,
 #          "vhost-started": false,
 #          "use-started": true
@@ -264,7 +297,8 @@
 # 2. Poll for the status of virtio-net (vhost-net is active)
 #
 # -> { "execute": "x-query-virtio-status",
-#      "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
+#      "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend",
+#                     "show-bits": true }
 #    }
 # <- { "return": {
 #          "device-endian": "little",
@@ -272,11 +306,13 @@
 #          "disabled-legacy-check": false,
 #          "name": "virtio-net",
 #          "started": true,
+#          "guest-features-bits": 5111807911,
 #          "device-id": 1,
 #          "vhost-dev": {
 #              "n-tmp-sections": 4,
 #              "n-mem-sections": 4,
 #              "max-queues": 1,
+#              "features-bits": 13908344832
 #              "backend-cap": 2,
 #              "log-size": 0,
 #              "backend-features": {
@@ -284,6 +320,8 @@
 #                  "transports": []
 #              },
 #              "nvqs": 2,
+#              "acked-features-bits": 5100306432,
+#              "backend-features-bits": 0,
 #              "protocol-features": {
 #                  "protocols": []
 #              },
@@ -299,6 +337,7 @@
 #                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
 #                  ]
 #              },
+#              "protocol-features-bits": 0,
 #              "features": {
 #                  "dev-features": [
 #                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
@@ -387,6 +426,7 @@
 #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
 #             ]
 #          },
+#          "host-features-bits": 6337593319,
 #          "host-features": {
 #              "dev-features": [
 #                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
@@ -420,9 +460,11 @@
 #                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
 #             ]
 #          },
+#          "backend-features-bits": 6337593319,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 2,
+#          "status-bits": 15,
 #          "disabled": false,
 #          "vhost-started": true,
 #          "use-started": true
@@ -430,7 +472,8 @@
 #    }
 ##
 { 'command': 'x-query-virtio-status',
-  'data': { 'path': 'str' },
+  'data': { 'path': 'str',
+            '*show-bits': 'bool'},
   'returns': 'VirtioStatus',
   'features': [ 'unstable' ] }
 
-- 
2.39.1


