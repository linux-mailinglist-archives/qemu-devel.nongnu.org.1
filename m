Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446C981FA8B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 19:56:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIvWw-0001i1-7x; Thu, 28 Dec 2023 13:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rIvWu-0001hX-7F
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:54:52 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rIvWr-0004hm-S8
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:54:51 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so4862289a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 10:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703789568; x=1704394368;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61zagdriZ+kjNGpLsZU3/P0+/e5oeNJx5BWwKCMqi2Y=;
 b=XlsWREa9HB/VbltuXDnRt2flDN8ZH8gVrU2hCytRK/4JMqWC1Z/jeFTNda/vpxQhSd
 Q+203Irt9ZB3fuCEhBNA0drdm+PyFclUmyxqgKM1F4+a/sIKbygDRDulGLwMOZEc9oT+
 3a3dM+qjeJ70utEKWiCVfDtnTqB9odnkOw5vRy0X6GVzW72Muksxdm+OFcBMRGUz4zrs
 WKEzX7FyVQhzv9cV+918E9Wg86vmArN9OjeBehZ6+AWhfWlNTczeKtXTnBbtUMTtqXnY
 AQ1A/lyr6eETkDvWtCCv6LgWZ3S/Ligj4ezOuhpLp7O2P7tu3ZwdHiiJr0Enc6Ua/AjM
 k9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703789568; x=1704394368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61zagdriZ+kjNGpLsZU3/P0+/e5oeNJx5BWwKCMqi2Y=;
 b=RpxJLXj08PlZ44BlzN2kJr6SpQbWy/Q2a1l+ds6LxlCqHNEaPLSj0QCgvogBLGdI5v
 CAhGmBDWtlZ299g9yj56HWmQrxMXjIhbyO4xcWtX+FBuTmsp3B30xzmZHUXW/plxcBgl
 VgrI8i0UB5xmIsu035vS75AsABS+EIFGeo6tWYnnUhvyHDYlusijC+eTZTn6Bsyt262r
 SIGvGEGVkThcwQ7oIqX8Mab0jKFodBPBrV2ZN4oOmd4nRI4pJ/Z8WJ9UCsIVvSAHOkw8
 VK+Ubx6udHu1hHgREiQxXGw0oerXVix5ag+SMq1HDU0QPZZR4arYADXjXxFf2b22c6bm
 +MWA==
X-Gm-Message-State: AOJu0YzzileTASlej2thXkzAUqgBGyVUS21UrCfUAOIXf0p2DBRgkm9K
 QdfwZYQFicHvKjYg3kN9VqekT0wzzC/hZGonHijmVuTFfJnvYA8S
X-Google-Smtp-Source: AGHT+IFvHdMpHvTXWHQiw0Ii3VdoMr2BUnHo80iWqa0zfNfiqQ7U6APWjRb8qrvI50YyFDBnkwL99g==
X-Received: by 2002:a17:902:7088:b0:1d0:6ffd:6119 with SMTP id
 z8-20020a170902708800b001d06ffd6119mr10680317plk.59.1703789567733; 
 Thu, 28 Dec 2023 10:52:47 -0800 (PST)
Received: from localhost.localdomain ([118.114.59.180])
 by smtp.gmail.com with ESMTPSA id
 h24-20020a170902ac9800b001d36dbb22a9sm14312694plr.4.2023.12.28.10.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:52:46 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH 1/2] qapi/virtio: Keep feature and status bits in the QMP
 output
Date: Fri, 29 Dec 2023 02:52:31 +0800
Message-Id: <138716dee4162ad959ac3580da0d4681fabd6185.1703787712.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703787712.git.yong.huang@smartx.com>
References: <cover.1703787712.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52d.google.com
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

Maintain the feature and status bits in the x-query-virtio-status
output and, as usual, add human-readable output only in HMP.

Applications may find it useful to compare features and status
information directly. An upper application, for example, could
use the QMP command x-query-virtio-status to retrieve vhost-user
net device features and the "ovs-vsctl list interface" command to
retrieve interface features (in number format) in order to verify
the correctness of the virtio negotiation between guest, QEMU,
and OVS-DPDK. The application could then compare the two features
directly, without the need for additional feature encoding.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/virtio/virtio-hmp-cmds.c |  25 +++--
 hw/virtio/virtio-qmp.c      |  23 ++---
 qapi/virtio.json            | 192 ++++--------------------------------
 3 files changed, 45 insertions(+), 195 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..721c630ab0 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "virtio-qmp.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
@@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  endianness:              %s\n",
                    s->device_endian);
     monitor_printf(mon, "  status:\n");
-    hmp_virtio_dump_status(mon, s->status);
+    hmp_virtio_dump_status(mon,
+        qmp_decode_status(s->status));
     monitor_printf(mon, "  Guest features:\n");
-    hmp_virtio_dump_features(mon, s->guest_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->guest_features));
     monitor_printf(mon, "  Host features:\n");
-    hmp_virtio_dump_features(mon, s->host_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->host_features));
     monitor_printf(mon, "  Backend features:\n");
-    hmp_virtio_dump_features(mon, s->backend_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->backend_features));
 
     if (s->vhost_dev) {
         monitor_printf(mon, "  VHost:\n");
@@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "    log_size:       %"PRId64"\n",
                        s->vhost_dev->log_size);
         monitor_printf(mon, "    Features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->features));
         monitor_printf(mon, "    Acked features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->acked_features));
         monitor_printf(mon, "    Backend features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->backend_features));
         monitor_printf(mon, "    Protocol features:\n");
-        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
+        hmp_virtio_dump_protocols(mon,
+            qmp_decode_protocols(s->vhost_dev->protocol_features));
     }
 
     qapi_free_VirtioStatus(s);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..1660c17653 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     status->name = g_strdup(vdev->name);
     status->device_id = vdev->device_id;
     status->vhost_started = vdev->vhost_started;
-    status->guest_features = qmp_decode_features(vdev->device_id,
-                                                 vdev->guest_features);
-    status->host_features = qmp_decode_features(vdev->device_id,
-                                                vdev->host_features);
-    status->backend_features = qmp_decode_features(vdev->device_id,
-                                                   vdev->backend_features);
+    status->guest_features = vdev->guest_features;
+    status->host_features = vdev->host_features;
+    status->backend_features = vdev->backend_features;
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
@@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     }
 
     status->num_vqs = virtio_get_num_queues(vdev);
-    status->status = qmp_decode_status(vdev->status);
+    status->status = vdev->status;
     status->isr = vdev->isr;
     status->queue_sel = vdev->queue_sel;
     status->vm_running = vdev->vm_running;
@@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
-        status->vhost_dev->features =
-            qmp_decode_features(vdev->device_id, hdev->features);
-        status->vhost_dev->acked_features =
-            qmp_decode_features(vdev->device_id, hdev->acked_features);
-        status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features);
-        status->vhost_dev->protocol_features =
-            qmp_decode_protocols(hdev->protocol_features);
+        status->vhost_dev->features = hdev->features;
+        status->vhost_dev->acked_features = hdev->acked_features;
+        status->vhost_dev->backend_features = hdev->backend_features;
+        status->vhost_dev->protocol_features = hdev->protocol_features;
         status->vhost_dev->max_queues = hdev->max_queues;
         status->vhost_dev->backend_cap = hdev->backend_cap;
         status->vhost_dev->log_enabled = hdev->log_enabled;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 19c7c36e36..26516fb29c 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -102,10 +102,10 @@
             'n-tmp-sections': 'int',
             'nvqs': 'uint32',
             'vq-index': 'int',
-            'features': 'VirtioDeviceFeatures',
-            'acked-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
-            'protocol-features': 'VhostDeviceProtocols',
+            'features': 'uint64',
+            'acked-features': 'uint64',
+            'backend-features': 'uint64',
+            'protocol-features': 'uint64',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
             'log-enabled': 'bool',
@@ -170,11 +170,11 @@
             'device-id': 'uint16',
             'vhost-started': 'bool',
             'device-endian': 'str',
-            'guest-features': 'VirtioDeviceFeatures',
-            'host-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
+            'guest-features': 'uint64',
+            'host-features': 'uint64',
+            'backend-features': 'uint64',
             'num-vqs': 'int',
-            'status': 'VirtioDeviceStatus',
+            'status': 'uint8',
             'isr': 'uint8',
             'queue-sel': 'uint16',
             'vm-running': 'bool',
@@ -217,41 +217,14 @@
 #          "name": "virtio-crypto",
 #          "started": true,
 #          "device-id": 20,
-#          "backend-features": {
-#              "transports": [],
-#              "dev-features": []
-#          },
+#          "backend-features": 0,
 #          "start-on-kick": false,
 #          "isr": 1,
 #          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
+#          "status": 15,
 #          "num-vqs": 2,
-#          "guest-features": {
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#              ]
-#          },
-#          "host-features": {
-#              "unknown-dev-features": 1073741824,
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
-#          },
+#          "guest-features": 5100273664,
+#          "host-features": 6325010432,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 1,
@@ -279,147 +252,22 @@
 #              "max-queues": 1,
 #              "backend-cap": 2,
 #              "log-size": 0,
-#              "backend-features": {
-#                  "dev-features": [],
-#                  "transports": []
-#              },
+#              "backend-features": 0,
 #              "nvqs": 2,
-#              "protocol-features": {
-#                  "protocols": []
-#              },
+#              "protocol-features": 0,
 #              "vq-index": 0,
 #              "log-enabled": false,
-#              "acked-features": {
-#                  "dev-features": [
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#                  ]
-#              },
-#              "features": {
-#                  "dev-features": [
-#                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#                  ]
-#              }
-#          },
-#          "backend-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
+#              "acked-features": 5100306432,
+#              "features": 13908344832,
 #          },
+#          "backend-features": 6337593319,
 #          "start-on-kick": false,
 #          "isr": 1,
 #          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
+#          "status": 15,
 #          "num-vqs": 3,
-#          "guest-features": {
-#              "dev-features": [
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#             ]
-#          },
-#          "host-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#             ]
-#          },
+#          "guest-features": 5111807911,
+#          "host-features": 6337593319,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 2,
-- 
2.39.1


