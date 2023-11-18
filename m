Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9647F0048
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 16:27:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4NCP-0003NV-MK; Sat, 18 Nov 2023 10:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r4NC5-0003KM-2n
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 10:25:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r4NC3-0007no-9y
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 10:25:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so26706495ad.0
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700320989; x=1700925789;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgZStl6cQ0hFCfxIDbFZBOxl4qkddCAwhz0OMlhMXNU=;
 b=lK2U76w7tcPWrRrugslXYlXIm7fIhZvBoAqSUDHuwOIvf+F/dZkdWlk9lRg1/BVAN0
 HebCGejhaDIQFIsWT54RpiMEk9HW1kme+48IIagoH7O72wBCiEnENhUx+fr60cjAYUgx
 ZCm4u6xq3nP2W+fazUWnsA49W5Ua/tMTAt+g1VsVoamPBOCZYG/+rLBGvuC3ZKUzOXxi
 7Qbck5PmNyl5lY4yNpggENATq9nfYcFKTT53JRlJWzL9bCw+peftY+srteJdEfURSo7u
 JbNHS0VBcMH4vhyVr8vuG2EnhYD1nvlDIbqQ7zRggr7l1BDX/H4Lgf/bMoRHSQaUDMwL
 AeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700320989; x=1700925789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgZStl6cQ0hFCfxIDbFZBOxl4qkddCAwhz0OMlhMXNU=;
 b=NexmJqMcukk/Jxr5fs1dsn+9hiW/5gP6xILrHU21dPyAi1P6EMiKB0r4k06JzGe0eL
 NdpSRr+sRrOP4WLmgKkCdqazhnW5wA64TTWMa8MupnebPYGybNKVK3IGP4juhc2K4yQD
 xHUHgn0vJxbr3mmlbcB2l6gyrzSEDqpBwRxVmv8GZrrF2daReCjgUGJEjakmGmDt4gZZ
 6ilLnGtmQJrKsXv8F8K9oAiERurploYdhO8SAVMUy0d75sjznE6BIygZUTJdOoQZYttq
 DoFZLSsMevjvihszLD6GMO9iwXfA5P8sMCT01CVCZucpbL2/5vsACr8eGGLKjQLPD7L0
 mjTA==
X-Gm-Message-State: AOJu0YyY3AJaoZZ3PktlCJuPcSor6ALC02tzZmk40Fio/0tqRrcSzBQJ
 2VpRstnR6su3lkoz8x+VuOEFZfKJFsmbHg0nrHASCw==
X-Google-Smtp-Source: AGHT+IGqTmfDBbqqwxiI+7QbzG3uvSzgK3isc+v28wtXSsQRLfG8YD3iMtP45w0hLeuBH+2wdr4GvQ==
X-Received: by 2002:a17:902:ec02:b0:1cc:4467:a563 with SMTP id
 l2-20020a170902ec0200b001cc4467a563mr3083938pld.3.1700320989230; 
 Sat, 18 Nov 2023 07:23:09 -0800 (PST)
Received: from localhost.localdomain ([125.71.94.124])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a170902ce8200b001bbb25dd3a7sm3120884plg.187.2023.11.18.07.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 07:23:08 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [v2 1/2] qapi/virtio: Add feature and status bits for
 x-query-virtio-status
Date: Sat, 18 Nov 2023 23:22:49 +0800
Message-Id: <3c7161a47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1700319559.git.yong.huang@smartx.com>
References: <cover.1700319559.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x631.google.com
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

This patch allows to display feature and status bits in
virtio-status.

Applications could find it helpful to compare status and features
that are numeric encoded. For example, an upper application could
use the features (encoded as a number) in the output of "ovs-vsctl
list interface" and the feature bits fields in the output of QMP
command "x-query-virtio-status" to compare directly when attempting
to ensure the correctness of the virtio negotiation between guest,
QEMU, and OVS-DPDK. Not applying any more encoding.

This patch also serves as a preparation for the next one, which implements
a vhost-user test case about acked features of vhost-user protocol.

Note that since the matching HMP command is typically used for human,
leave it unchanged.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/virtio/virtio-qmp.c |  8 ++++++++
 qapi/virtio.json       | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..13ba1e926e 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -733,6 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     status->name = g_strdup(vdev->name);
     status->device_id = vdev->device_id;
     status->vhost_started = vdev->vhost_started;
+    status->guest_features_bits = vdev->guest_features;
+    status->host_features_bits = vdev->host_features;
+    status->backend_features_bits = vdev->backend_features;
     status->guest_features = qmp_decode_features(vdev->device_id,
                                                  vdev->guest_features);
     status->host_features = qmp_decode_features(vdev->device_id,
@@ -753,6 +756,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     }
 
     status->num_vqs = virtio_get_num_queues(vdev);
+    status->status_bits = vdev->status;
     status->status = qmp_decode_status(vdev->status);
     status->isr = vdev->isr;
     status->queue_sel = vdev->queue_sel;
@@ -775,6 +779,10 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
+        status->vhost_dev->features_bits = hdev->features;
+        status->vhost_dev->acked_features_bits = hdev->acked_features;
+        status->vhost_dev->backend_features_bits = hdev->backend_features;
+        status->vhost_dev->protocol_features_bits = hdev->protocol_features;
         status->vhost_dev->features =
             qmp_decode_features(vdev->device_id, hdev->features);
         status->vhost_dev->acked_features =
diff --git a/qapi/virtio.json b/qapi/virtio.json
index e6dcee7b83..6f1b5e3710 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -79,12 +79,20 @@
 #
 # @vq-index: vhost_dev vq_index
 #
+# @features-bits: vhost_dev features encoded as a number
+#
 # @features: vhost_dev features
 #
+# @acked-features-bits: vhost_dev acked_features encoded as a number
+#
 # @acked-features: vhost_dev acked_features
 #
+# @backend-features-bits: vhost_dev backend_features encoded as a number
+#
 # @backend-features: vhost_dev backend_features
 #
+# @protocol-features-bits: vhost_dev protocol_features encoded as a number
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
+# @guest-features-bits: VirtIODevice guest_features encoded as a number
+#
 # @guest-features: VirtIODevice guest_features
 #
+# @host-features-bits: VirtIODevice host_features encoded as a number
+#
 # @host-features: VirtIODevice host_features
 #
+# @backend-features-bits: VirtIODevice backend_features encoded as a number
+#
 # @backend-features: VirtIODevice backend_features
 #
 # @device-endian: VirtIODevice device_endian
@@ -135,6 +153,9 @@
 # @num-vqs: VirtIODevice virtqueue count.  This is the number of
 #     active virtqueues being used by the VirtIODevice.
 #
+# @status-bits: VirtIODevice configuration status encoded as a number
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
@@ -216,6 +241,7 @@
 #          "disable-legacy-check": false,
 #          "name": "virtio-crypto",
 #          "started": true,
+#          "guest-features-bits": 5100273664,
 #          "device-id": 20,
 #          "backend-features": {
 #              "transports": [],
@@ -241,6 +267,7 @@
 #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
 #              ]
 #          },
+#          "host-features-bits": 6325010432,
 #          "host-features": {
 #              "unknown-dev-features": 1073741824,
 #              "dev-features": [],
@@ -252,9 +279,11 @@
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
@@ -272,11 +301,13 @@
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
@@ -284,6 +315,8 @@
 #                  "transports": []
 #              },
 #              "nvqs": 2,
+#              "acked-features-bits": 5100306432,
+#              "backend-features-bits": 0,
 #              "protocol-features": {
 #                  "protocols": []
 #              },
@@ -299,6 +332,7 @@
 #                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
 #                  ]
 #              },
+#              "protocol-features-bits": 0,
 #              "features": {
 #                  "dev-features": [
 #                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
@@ -387,6 +421,7 @@
 #                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
 #             ]
 #          },
+#          "host-features-bits": 6337593319,
 #          "host-features": {
 #              "dev-features": [
 #                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
@@ -420,9 +455,11 @@
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
-- 
2.39.1


