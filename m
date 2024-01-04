Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA9082460C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:24:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQUv-0000wC-NC; Thu, 04 Jan 2024 11:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLQUr-0000vb-CE
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:23:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLQUo-0006Dq-La
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:23:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3e05abcaeso4492855ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704385261; x=1704990061;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfKxUYQ13A2io63U/z9C73GpW8G5JHBFo6kLrV4HbDU=;
 b=aEq4WzqjgfdGtZ61ql8SYzQhD1yzpv2dXWtmpuVdKLFw1OsL+gt5+Du+FJgXYCmQpw
 3yPTtAKNnN3W1sa/iypBF0YbEXL28EOyPnuaX7fHt6NAYuMAGVGrmGspU3J3SilICZy7
 O8Oor/JPgjFWO133eMSGU4zOX0fvnDhMqSyFEQ7NydfKYMbFlFI9k/wb+PwPx594UeUM
 FzxQsLSCIAs/SuDCz2oX4Pw8RdfjqjQhIUdyf0kLwFOUG3rY2T1mFFPMJyRtOE9jaWGy
 ApT/4m/2pWdJbIV/8r5ezRbDB55fCStei/z0jzgR2+pP4BQ0jchAes5RRy1+ArUuUzR1
 GOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704385261; x=1704990061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfKxUYQ13A2io63U/z9C73GpW8G5JHBFo6kLrV4HbDU=;
 b=mazI79SDE9g9qsD91zyGtd8I6iUrplUY8wUIdxSWDINA9w/GZm0nQJTEut3yjLZo1u
 AVYPPswX1iJ455dYiVPmCrPHT5ahvF8OumDR0Op1l1fKzddMXqM59td3YQ9+8FVI6TRS
 Yl65BCMEQMyVpR3zHJrlfm5HMzDYasC3HRz79jZomin/RDCwSLk5/9ZwUCIjAZyclDlS
 78FodKbpyR54nIAMBLwcXodtDzbphATcgOL8dYFMBcwovMh6h0+HOLVh/rd958QMB1FE
 w187TAkmIjaOdBahd2M96dbhMaEQFbumiQhvlQomN71/EiG1mvwNsGvVpbEoTUNHUbvB
 vBtg==
X-Gm-Message-State: AOJu0YzcnXzdU2Q6fFeWfn8oYsdIz4oqASOZjKjNRyU2Yi93h76TmKzy
 SoOBcqwGU0Z7fiKWF1awd4A2S3kQcDV6tQ4XpvbWHvTtoUoqYyjl
X-Google-Smtp-Source: AGHT+IGNzcPTu4+zn1oaFY3TpZDHl0+RbL/yyilQbx5x+dmRSUu97Lm8UnTROnvw5ZrDpvyDtiKu1Q==
X-Received: by 2002:a17:903:228f:b0:1d4:cb8c:fafe with SMTP id
 b15-20020a170903228f00b001d4cb8cfafemr785329plh.74.1704385260420; 
 Thu, 04 Jan 2024 08:21:00 -0800 (PST)
Received: from localhost.localdomain ([118.114.59.173])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902ee4500b001d06b63bb98sm25987314plo.71.2024.01.04.08.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 08:21:00 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 1/2] qapi/virtio: Keep feature and status bits in the QMP
 output
Date: Fri,  5 Jan 2024 00:19:34 +0800
Message-Id: <5a4bda9178716939cb641d40f9e628dc44209576.1704382761.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1704382761.git.yong.huang@smartx.com>
References: <cover.1704382761.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x632.google.com
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
 hw/virtio/virtio-hmp-cmds.c |  29 ++++--
 hw/virtio/virtio-qmp.c      |  23 ++---
 qapi/virtio.json            | 192 ++++--------------------------------
 3 files changed, 48 insertions(+), 196 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..4fabba4f9c 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "virtio-qmp.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
@@ -13,8 +14,10 @@
 
 
 static void hmp_virtio_dump_protocols(Monitor *mon,
-                                      VhostDeviceProtocols *pcol)
+                                      uint64_t bitmap)
 {
+    VhostDeviceProtocols *pcol = qmp_decode_protocols(bitmap);
+
     strList *pcol_list = pcol->protocols;
     while (pcol_list) {
         monitor_printf(mon, "\t%s", pcol_list->value);
@@ -31,8 +34,10 @@ static void hmp_virtio_dump_protocols(Monitor *mon,
 }
 
 static void hmp_virtio_dump_status(Monitor *mon,
-                                   VirtioDeviceStatus *status)
+                                   uint64_t bitmap)
 {
+    VirtioDeviceStatus *status = qmp_decode_status(bitmap);
+
     strList *status_list = status->statuses;
     while (status_list) {
         monitor_printf(mon, "\t%s", status_list->value);
@@ -49,8 +54,12 @@ static void hmp_virtio_dump_status(Monitor *mon,
 }
 
 static void hmp_virtio_dump_features(Monitor *mon,
-                                     VirtioDeviceFeatures *features)
+                                     uint16_t device_id,
+                                     uint64_t bitmap)
 {
+    VirtioDeviceFeatures *features =
+        qmp_decode_features(device_id, bitmap);
+
     strList *transport_list = features->transports;
     while (transport_list) {
         monitor_printf(mon, "\t%s", transport_list->value);
@@ -147,11 +156,11 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  status:\n");
     hmp_virtio_dump_status(mon, s->status);
     monitor_printf(mon, "  Guest features:\n");
-    hmp_virtio_dump_features(mon, s->guest_features);
+    hmp_virtio_dump_features(mon, s->device_id, s->guest_features);
     monitor_printf(mon, "  Host features:\n");
-    hmp_virtio_dump_features(mon, s->host_features);
+    hmp_virtio_dump_features(mon, s->device_id, s->host_features);
     monitor_printf(mon, "  Backend features:\n");
-    hmp_virtio_dump_features(mon, s->backend_features);
+    hmp_virtio_dump_features(mon, s->device_id, s->backend_features);
 
     if (s->vhost_dev) {
         monitor_printf(mon, "  VHost:\n");
@@ -172,11 +181,13 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "    log_size:       %"PRId64"\n",
                        s->vhost_dev->log_size);
         monitor_printf(mon, "    Features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->features);
+        hmp_virtio_dump_features(mon, s->device_id, s->vhost_dev->features);
         monitor_printf(mon, "    Acked features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
+        hmp_virtio_dump_features(mon,
+                s->device_id, s->vhost_dev->acked_features);
         monitor_printf(mon, "    Backend features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
+        hmp_virtio_dump_features(mon,
+                s->device_id, s->vhost_dev->backend_features);
         monitor_printf(mon, "    Protocol features:\n");
         hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
     }
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


