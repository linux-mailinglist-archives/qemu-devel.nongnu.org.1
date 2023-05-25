Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC3711A1C
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 00:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2JJs-00025Q-EH; Thu, 25 May 2023 18:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Jt9vZAgKCs0Ct4D5utDz77z4x.v759x5D-wxEx4676z6D.7Az@flex--talumbau.bounces.google.com>)
 id 1q2JJq-00024p-7X
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:26 -0400
Received: from mail-io1-xd4a.google.com ([2607:f8b0:4864:20::d4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Jt9vZAgKCs0Ct4D5utDz77z4x.v759x5D-wxEx4676z6D.7Az@flex--talumbau.bounces.google.com>)
 id 1q2JJo-0004R1-2Q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:25 -0400
Received: by mail-io1-xd4a.google.com with SMTP id
 ca18e2360f4ac-772d796bbe5so15828939f.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685053223; x=1687645223;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0fzL/+svKRfui1lk596I4QM9Yoz7EeoVyPyltQze/Y=;
 b=Dl4icuFiLdPlv6UEgxtS5UdRjWmbQrwaoSkEU9ey4Zt7xymLd/Be9o5z+9WAl2l0b9
 /TdvnI+7Ox1KqKW7FKonO+NFo7MIjdIW0dhM+lZmfOmOHCnUldYp7oDN6dPI0qoM2VmX
 BRJSyOmAq4pJFlx3GhK5r8E6RoTxc0p/dM1nKMtv/+gDdadnjwvNCMShtHGWxbCxtCto
 gzVhUtWL6QP0oB/PaMclMAu4qTNo9L1eUQuq6OIWpReybkOwn8szfx+HI6sIDPxSh3U1
 Ok/Xl5MWi/CXZVU3qm6spAqMtkCO3fQtTra5iYrgCh2lv4vjhNdV5dBloTW0ynPFM12n
 PSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685053223; x=1687645223;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0fzL/+svKRfui1lk596I4QM9Yoz7EeoVyPyltQze/Y=;
 b=DwEpfpPEMQ14dWCF4HAhxOfBt0P4Ymavm3CLfVtcO3CjFsC3IxZnZ/3k3wRghtL92D
 KI67n1cb5IxcMXxvP4yjikOA581MrkTTI6wT6yhosS0zCOKiOnlIsLRMCCLZtnbhKLgh
 ATxl4RdX7AP3E0eoJswKlGgFmVaDSILa2ctca7TUHs+sgBceSNbPxUMlIGp9NwaovmeU
 X4XmsG7HtMXoYw46v6Fb6XRiPUCLrN34XySgwUjG1Di/z4a31bfX+ACAR25b3ckDu9vq
 H8hxGpC8LjbzPj+eEmIW0iTi8LRRB239Ma0kI3pQtsQQIZZ8gP5wbHa00OsMYrsx0mmz
 wnJw==
X-Gm-Message-State: AC+VfDzq/GdhUW+PUNVtbhVRjghR/2BsBntuxKkL1E7JGC9HCKqk5BeW
 K/h80r9MOxAxSjVscUge43BCyzSRu/MnDvfuBFODox9QB0ZXPod6lx3uxDAsKsrntS5hJAfw9u9
 AY/AciT3REuT/efcxLxzcLjPklnEu72kNtSFDxM/PfBoEUycJ7rZ6xRKZGrDlScfYRw==
X-Google-Smtp-Source: ACHHUZ56oBqZ0JpgvPYGOmieGOIEKAdkODLKSMwXCArw+EkqnPO9r3gabaZEHvF9+ALabPuy0oqZnJlUGqfECg==
X-Received: from talumbau.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a6b:e30b:0:b0:775:3e80:4e3b with SMTP id
 u11-20020a6be30b000000b007753e804e3bmr679636ioc.2.1685053222906; Thu, 25 May
 2023 15:20:22 -0700 (PDT)
Date: Thu, 25 May 2023 22:20:13 +0000
In-Reply-To: <20230525222016.35333-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230525222016.35333-1-talumbau@google.com>
Message-ID: <20230525222016.35333-3-talumbau@google.com>
Subject: [RFC PATCH v2 2/5] virtio-balloon: device has Working Set Reporting
From: "T.J. Alumbaugh" <talumbau@google.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Yuanchu Xie <yuanchu@google.com>, 
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eric Blake <eblake@redhat.com>, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d4a;
 envelope-from=3Jt9vZAgKCs0Ct4D5utDz77z4x.v759x5D-wxEx4676z6D.7Az@flex--talumbau.bounces.google.com;
 helo=mail-io1-xd4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

 - working_set_vq to receive Working Set reports from guest
 - notification_vq to send config or request to guest
 - add working set as object property on device

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 hw/virtio/virtio-balloon.c         | 164 ++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-balloon.h |  13 ++-
 qapi/misc.json                     |  26 +++++
 3 files changed, 200 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d004cf29d2..23481e51b8 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -27,6 +27,7 @@
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-machine.h"
+#include "qapi/qapi-visit-misc.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qemu/error-report.h"
@@ -169,6 +170,119 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     }
 }
 
+/*
+ * reset_working_set - Mark all items in the array as unset
+ *
+ * This function needs to be called at device initialization and
+ * whenever a new Working Set config is specified.
+ */
+static inline void reset_working_set(VirtIOBalloon *dev)
+{
+    int i;
+    for (i = 0; i < VIRTIO_BALLOON_WS_NR_BINS; i++) {
+        dev->ws[i].idle_age = 0;
+        if (dev->ws[i].memory_size_bytes) {
+            dev->ws[i].memory_size_bytes->anon = 0;
+            dev->ws[i].memory_size_bytes->file = 0;
+        } else {
+            dev->ws[i].memory_size_bytes = g_malloc0(sizeof(MemoryBin));
+        }
+    }
+}
+
+static void virtio_balloon_receive_working_set(VirtIODevice *vdev,
+                                               VirtQueue *vq)
+{
+    VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
+    VirtQueueElement *elem;
+    VirtIOBalloonWorkingSet ws;
+    size_t offset = 0;
+    int count = 0;
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+
+    if (s->working_set_vq_elem != NULL) {
+        /* This should never happen if the driver follows the spec. */
+        virtqueue_push(vq, s->working_set_vq_elem, 0);
+        virtio_notify(vdev, vq);
+        g_free(s->working_set_vq_elem);
+    }
+
+    s->working_set_vq_elem = elem;
+
+    /* Initialize the Working Set to get rid of any stale values. */
+    reset_working_set(s);
+
+    while (iov_to_buf(elem->out_sg, elem->out_num, offset, &ws,
+                      sizeof(ws)) == sizeof(ws)) {
+        uint64_t idle_age_ms = virtio_tswap64(vdev, ws.idle_age_ms);
+        uint64_t bytes_anon = virtio_tswap64(vdev, ws.memory_size_bytes[0]);
+        uint64_t bytes_file = virtio_tswap64(vdev, ws.memory_size_bytes[1]);
+        s->ws[count].idle_age = idle_age_ms;
+        s->ws[count].memory_size_bytes->anon = bytes_anon;
+        s->ws[count].memory_size_bytes->file = bytes_file;
+        offset += sizeof(ws);
+        count++;
+    }
+}
+
+static __attribute__((unused)) void virtio_balloon_send_working_set_request(
+    VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *elem;
+    size_t sz = 0;
+    uint16_t tag = 0;
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+    tag = VIRTIO_BALLOON_WS_REQUEST;
+    sz = iov_from_buf(elem->in_sg, elem->in_num, 0, &tag, sizeof(tag));
+    assert(sz == sizeof(tag));
+    virtqueue_push(vq, elem, sz);
+    virtio_notify(vdev, vq);
+    g_free(elem);
+}
+
+static __attribute__((unused)) void virtio_balloon_send_working_set_config(
+    VirtIODevice *vdev, VirtQueue *vq,
+    uint64_t i0, uint64_t i1, uint64_t i2,
+    uint64_t refresh, uint64_t report)
+{
+    VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
+    VirtQueueElement *elem;
+    uint16_t tag = 0;
+    size_t sz = 0;
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+
+    tag = VIRTIO_BALLOON_WS_CONFIG;
+    s->ws_intervals[0] = i0;
+    s->ws_intervals[1] = i1;
+    s->ws_intervals[2] = i2;
+    s->ws_refresh_threshold = refresh;
+    s->ws_report_threshold = report;
+
+    sz = iov_from_buf(elem->in_sg, elem->in_num, 0, &tag, sizeof(tag));
+    assert(sz == sizeof(uint16_t));
+    sz += iov_from_buf(elem->in_sg, elem->in_num, sz, s->ws_intervals,
+                       (VIRTIO_BALLOON_WS_NR_BINS - 1) * \
+                       sizeof(s->ws_intervals[0]));
+    sz += iov_from_buf(elem->in_sg, elem->in_num, sz, &s->ws_refresh_threshold,
+                       sizeof(uint64_t));
+    sz += iov_from_buf(elem->in_sg, elem->in_num, sz, &s->ws_report_threshold,
+                       sizeof(uint64_t));
+    virtqueue_push(vq, elem, sz);
+    virtio_notify(vdev, vq);
+    g_free(elem);
+}
+
 static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
    [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
@@ -697,8 +811,11 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
     if (s->qemu_4_0_config_size) {
         return sizeof(struct virtio_balloon_config);
     }
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_WS_REPORTING)) {
+        return sizeof(struct virtio_balloon_config);
+   }
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
-        return sizeof(struct virtio_balloon_config);
+        return offsetof(struct virtio_balloon_config, working_set_num_bins);
     }
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         return offsetof(struct virtio_balloon_config, poison_val);
@@ -714,6 +831,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
     config.poison_val = cpu_to_le32(dev->poison_val);
+    config.working_set_num_bins = (uint8_t) VIRTIO_BALLOON_WS_NR_BINS;
 
     if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
         config.free_page_hint_cmd_id =
@@ -748,6 +866,14 @@ static bool virtio_balloon_page_poison_support(void *opaque)
     return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
 }
 
+static bool virtio_balloon_working_set_reporting_support(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_WS_REPORTING);
+}
+
 static void virtio_balloon_set_config(VirtIODevice *vdev,
                                       const uint8_t *config_data)
 {
@@ -766,6 +892,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
     if (virtio_balloon_page_poison_support(dev)) {
         dev->poison_val = le32_to_cpu(config.poison_val);
     }
+    dev->working_set_num_bins = 0;
+    if (virtio_balloon_working_set_reporting_support(dev)) {
+        dev->working_set_num_bins = config.working_set_num_bins;
+    }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -775,6 +905,7 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
+    virtio_add_feature(&f, VIRTIO_BALLOON_F_WS_REPORTING);
 
     return f;
 }
@@ -896,6 +1027,13 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
                                            virtio_balloon_handle_report);
     }
 
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_WS_REPORTING)) {
+        s->working_set_vq = virtio_add_queue(vdev, 32,
+            virtio_balloon_receive_working_set);
+        s->notification_vq = virtio_add_queue(vdev, 32, NULL);
+    }
+
+    reset_working_set(s);
     reset_stats(s);
 }
 
@@ -922,6 +1060,12 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
     if (s->reporting_vq) {
         virtio_delete_queue(s->reporting_vq);
     }
+    if (s->working_set_vq) {
+        virtio_delete_queue(s->working_set_vq);
+    }
+    if (s->notification_vq) {
+        virtio_delete_queue(s->notification_vq);
+    }
     virtio_cleanup(vdev);
 }
 
@@ -938,7 +1082,11 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
-
+    if (s->working_set_vq_elem != NULL) {
+        virtqueue_unpop(s->working_set_vq, s->working_set_vq_elem, 0);
+        g_free(s->working_set_vq_elem);
+        s->working_set_vq_elem = NULL;
+    }
     s->poison_val = 0;
 }
 
@@ -953,6 +1101,16 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
         virtio_balloon_receive_stats(vdev, s->svq);
     }
 
+    if (!s->working_set_vq_elem && vdev->vm_running &&
+        (status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+         virtqueue_rewind(s->working_set_vq, 1)) {
+        /*
+         * poll working set queue for the element we have discarded when the VM
+         * was stopped
+         */
+        virtio_balloon_receive_working_set(vdev, s->working_set_vq);
+    }
+
     if (virtio_balloon_free_page_support(s)) {
         /*
          * The VM is woken up and the iothread was blocked, so signal it to
@@ -1011,6 +1169,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_PAGE_POISON, true),
     DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_REPORTING, false),
+    DEFINE_PROP_BIT("working-set", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_WS_REPORTING, true),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 5139cf8ab6..a7a6655f50 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -17,6 +17,7 @@
 
 #include "standard-headers/linux/virtio_balloon.h"
 #include "hw/virtio/virtio.h"
+#include "qapi/qapi-types-misc.h"
 #include "sysemu/iothread.h"
 #include "qom/object.h"
 
@@ -25,7 +26,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBalloon, VIRTIO_BALLOON)
 
 #define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
 
+#define VIRTIO_BALLOON_WS_NR_BINS 4  /* Number of bins in Working Set report */
+
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
+typedef struct virtio_balloon_working_set VirtIOBalloonWorkingSet;
 
 typedef struct virtio_balloon_stat_modern {
        uint16_t tag;
@@ -42,13 +46,19 @@ enum virtio_balloon_free_page_hint_status {
 
 struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq, *working_set_vq,
+              *notification_vq;
     uint32_t free_page_hint_status;
     uint32_t num_pages;
     uint32_t actual;
     uint32_t free_page_hint_cmd_id;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
+    WorkingSetInfo ws[VIRTIO_BALLOON_WS_NR_BINS];
+    uint64_t ws_intervals[VIRTIO_BALLOON_WS_NR_BINS - 1];
+    uint64_t ws_refresh_threshold;
+    uint64_t ws_report_threshold;
     VirtQueueElement *stats_vq_elem;
+    VirtQueueElement *working_set_vq_elem;
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
     IOThread *iothread;
@@ -71,6 +81,7 @@ struct VirtIOBalloon {
 
     bool qemu_4_0_config_size;
     uint32_t poison_val;
+    uint8_t working_set_num_bins;
 };
 
 #endif
diff --git a/qapi/misc.json b/qapi/misc.json
index ff070ec828..4ba8c74b64 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -550,6 +550,32 @@
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true}
 
+##
+# @MemoryBin:
+#
+# A bin of memory with a size in bytes. File-backed and
+# anonymous memory are tracked separately.
+#
+# @anon: number of bytes of anonymous memory
+# @file: number of bytes of file-backed memory
+##
+{ 'struct': 'MemoryBin',
+  'data': { 'anon': 'uint64',
+            'file': 'uint64' } }
+
+##
+# @WorkingSetInfo:
+#
+# A bin of memory of the given size that has been idle at most `idle-age` ms
+#
+# @idle-age: guest-relative time (in milliseconds)
+#
+# @memory-size-bytes: A MemoryBin with file and anon info.
+##
+{ 'struct': 'WorkingSetInfo',
+  'data': { 'idle-age': 'uint64',
+            'memory-size-bytes': 'MemoryBin' } }
+
 ##
 # @RTC_CHANGE:
 #
-- 
2.41.0.rc0.172.g3f132b7071-goog


