Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37689711A1A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 00:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2JJt-00026A-Q3; Thu, 25 May 2023 18:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3J99vZAgKCs4Du5E6vuE08805y.w86Ay6E-xyFy578707E.8B0@flex--talumbau.bounces.google.com>)
 id 1q2JJr-00025D-Oy
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:27 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3J99vZAgKCs4Du5E6vuE08805y.w86Ay6E-xyFy578707E.8B0@flex--talumbau.bounces.google.com>)
 id 1q2JJp-0004RX-Kb
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:27 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5653213f5c0so4263957b3.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685053224; x=1687645224;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ubBrZ8nAFimVTuMHp6nxPEPus94HZpyzs0dejBNFzO8=;
 b=AK4H1JjLe5gTLfzqHg1BtFZKQi/zr7zix6xMHvV0NeuHVzmAk7V+3Ind0cFHKMfaB5
 I7Oh1fQy4xofsDyBVlInP/D6U3kjth7rgZmNfdPYuqYqhFqbE0bI625m+VCF2N4BfUN4
 ng+ERCmiyBM6i0gr+gLPE5lGiB1OdfWDIpR3Y8kYUnVGL+PLDfxZlaE8xf/0j+Dpcb+j
 fqJ1LKQjQ5tYyaqSM6cEYm+e7xDZwmyIBBeYiCHhKUUwkNV6imXHp50+QkDKpr7BTSb2
 W4MyU+NvMvTRv/D3UTX/4ZLl2rtdnozOngnmqXAS97mt/3puxSU4QvOttRV6XftLpaTT
 TPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685053224; x=1687645224;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubBrZ8nAFimVTuMHp6nxPEPus94HZpyzs0dejBNFzO8=;
 b=Ks93OJ330uNekzt4rGMGWiKZZWkOqMd5F9wLmKayBQexQ5zenjLEiIW54ik2NAJY5t
 6AVQRVr4nj49+82paLJ3z6BtQA2G6y7xGAG2sja+5yjqiLRabrHGYI15Hx6LeIwYfXuK
 QrI86zmlBU1+tELuckS+VD3txFb/D3JrberJZF9Vlc7FB8HIUWoyjIlDkRoRiNo7jjNw
 eQWHi9ebcJOmdA9iCP4TXEKPMzhGKZT0pZQdFRT60oks9R8hxfDjCP7F7+j+k1ggkbKW
 oWaXGfczPiPPw9GueIWUI8/YxE8wQv3frhK3DrCAb5u1k92LeXj+aDcnN8v/MHQTWASJ
 yBww==
X-Gm-Message-State: AC+VfDwDbGXsdy9mDDglCFIpCXAIbQpJqAVRx2qrAqOUiHKElS3UnKwy
 8lS7j3NjcqpZo4sJvVXYne+osOBCiXqeqo1Yjx3v9GIVgEOlFRUepY2K1d20OBnm7dQA2OU8S5X
 Twd4gUfnwAg7nlP7OB30pnq+Do+1z7me9HgoPMqci3UTzVIk3bZcFhWesvVC4djsb2Q==
X-Google-Smtp-Source: ACHHUZ5JVlUlU+5wCi9Z5u/PMrQm7zDS3WBItQthIFah5CX+c88JqRlG2X6T304HtQVogPD1MZ6gYKlzTKwLrw==
X-Received: from talumbau.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a81:e707:0:b0:55a:5aa0:ffe9 with SMTP id
 x7-20020a81e707000000b0055a5aa0ffe9mr612608ywl.7.1685053223961; Thu, 25 May
 2023 15:20:23 -0700 (PDT)
Date: Thu, 25 May 2023 22:20:14 +0000
In-Reply-To: <20230525222016.35333-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230525222016.35333-1-talumbau@google.com>
Message-ID: <20230525222016.35333-4-talumbau@google.com>
Subject: [RFC PATCH v2 3/5] virtio-balloon: Add QMP functions for Working Set
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3J99vZAgKCs4Du5E6vuE08805y.w86Ay6E-xyFy578707E.8B0@flex--talumbau.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

  - Adds QMP function 'working-set-config'
  - Adds QMP function 'working-set-request'
  - Retrieve working set via 'guest-working-set' property on balloon

>> cat script.py

NAME = "name"
SOCKET = 'vm.sock'
BALLOON =  "/machine/peripheral/balloon0"

import json
import asyncio
from qemu.qmp import QMPClient

async def main():
    client = QMPClient(NAME)
    await client.connect(SOCKET)
    config = { "i0": 200, "i1": 800, "i2": 3000, "refresh": 750, "report": 1000 }
    await client.execute('working-set-config', config)
    await client.execute('working-set-request')
    property = {"path":BALLOON, "property":"guest-working-set"}
    res = await client.execute('qom-get', property)
    return res

if __name__ == "__main__":
    ret = asyncio.run(main())
    print(json.dumps(ret, indent=2))

>> (Execute qemu with flag '-qmp unix:path=vm.sock,server=on,wait=off'
>> (Perform normal activities on VM to exercise MM code)

>> python3 script.py
{
  "working_set": {
    "ws3": {
      "memory-size-bytes": {
        "anon": 890478592,
        "file": 1285832704
      },
      "idle-age": 4294967292
    },
    "ws2": {
      "memory-size-bytes": {
        "anon": 173465600,
        "file": 83353600
      },
      "idle-age": 3000
    },
    "ws1": {
      "memory-size-bytes": {
        "anon": 44236800,
        "file": 20889600
      },
      "idle-age": 800
    },
    "ws0": {
      "memory-size-bytes": {
        "anon": 14540800,
        "file": 6963200
      },
      "idle-age": 200
    }
  }
}

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 hw/virtio/virtio-balloon-pci.c |  2 +
 hw/virtio/virtio-balloon.c     | 67 ++++++++++++++++++++++++++++++++--
 include/sysemu/balloon.h       |  9 ++++-
 monitor/monitor.c              |  1 +
 qapi/machine.json              | 66 +++++++++++++++++++++++++++++++++
 softmmu/balloon.c              | 31 +++++++++++++++-
 6 files changed, 170 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index ce2645ba71..7b781c8bab 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -68,6 +68,8 @@ static void virtio_balloon_pci_instance_init(Object *obj)
     object_property_add_alias(obj, "guest-stats-polling-interval",
                               OBJECT(&dev->vdev),
                               "guest-stats-polling-interval");
+    object_property_add_alias(obj, "guest-working-set", OBJECT(&dev->vdev),
+                              "guest-working-set");
 }
 
 static const VirtioPCIDeviceTypeInfo virtio_balloon_pci_info = {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 23481e51b8..a124d95534 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -229,7 +229,7 @@ static void virtio_balloon_receive_working_set(VirtIODevice *vdev,
     }
 }
 
-static __attribute__((unused)) void virtio_balloon_send_working_set_request(
+static void virtio_balloon_send_working_set_request(
     VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtQueueElement *elem;
@@ -248,7 +248,7 @@ static __attribute__((unused)) void virtio_balloon_send_working_set_request(
     g_free(elem);
 }
 
-static __attribute__((unused)) void virtio_balloon_send_working_set_config(
+static void virtio_balloon_send_working_set_config(
     VirtIODevice *vdev, VirtQueue *vq,
     uint64_t i0, uint64_t i1, uint64_t i2,
     uint64_t refresh, uint64_t report)
@@ -353,6 +353,43 @@ static void balloon_stats_poll_cb(void *opaque)
     s->stats_vq_elem = NULL;
 }
 
+static void balloon_working_set_get_all(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    Error *err = NULL;
+    VirtIOBalloon *s = VIRTIO_BALLOON(obj);
+    char ws_buf[4];
+    WorkingSetInfo *wsinfo;
+    int i;
+
+    if (!visit_start_struct(v, name, NULL, 0, &err)) {
+        goto out;
+    }
+
+    if (!visit_start_struct(v, "working_set", NULL, 0, &err)) {
+        goto out_end;
+    }
+    for (i = 0; i < VIRTIO_BALLOON_WS_NR_BINS; i++) {
+        wsinfo = s->ws + i;
+        sprintf(ws_buf, "ws%d", i);
+        if (!visit_type_WorkingSetInfo(v, ws_buf, &wsinfo, &err)) {
+            goto out_nested;
+        }
+    }
+    visit_check_struct(v, &err);
+out_nested:
+    visit_end_struct(v, NULL);
+
+    if (!err) {
+        visit_check_struct(v, &err);
+    }
+out_end:
+    visit_end_struct(v, NULL);
+out:
+    error_propagate(errp, err);
+}
+
 static void balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
@@ -917,6 +954,25 @@ static void virtio_balloon_stat(void *opaque, BalloonInfo *info)
                                              VIRTIO_BALLOON_PFN_SHIFT);
 }
 
+static void virtio_balloon_working_set_request(void *opaque)
+{
+    VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    virtio_balloon_send_working_set_request(vdev, dev->notification_vq);
+}
+
+static void virtio_balloon_working_set_config(void *opaque, uint64_t i0,
+                                              uint64_t i1, uint64_t i2,
+                                              uint64_t refresh, uint64_t report)
+{
+    VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    virtio_balloon_send_working_set_config(vdev, dev->notification_vq, i0, i1,
+                                           i2, refresh, report);
+}
+
 static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
@@ -992,7 +1048,9 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     virtio_init(vdev, VIRTIO_ID_BALLOON, virtio_balloon_config_size(s));
 
     ret = qemu_add_balloon_handler(virtio_balloon_to_target,
-                                   virtio_balloon_stat, s);
+                                   virtio_balloon_stat,
+                                   virtio_balloon_working_set_request,
+                                   virtio_balloon_working_set_config, s);
 
     if (ret < 0) {
         error_setg(errp, "Only one balloon device is supported");
@@ -1148,6 +1206,9 @@ static void virtio_balloon_instance_init(Object *obj)
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
                         NULL, NULL);
+
+    object_property_add(obj, "guest-working-set", "guest working set",
+                        balloon_working_set_get_all, NULL, NULL, NULL);
 }
 
 static const VMStateDescription vmstate_virtio_balloon = {
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index 867687b73a..1f504d1a31 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -18,10 +18,17 @@
 #include "qapi/qapi-types-machine.h"
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
+typedef void (QEMUBalloonWorkingSetRequest)(void *opaque);
+typedef void (QEMUBalloonWorkingSetConfig)(void *opaque, uint64_t i0,
+                                  uint64_t i1, uint64_t i2, uint64_t refresh,
+                                  uint64_t report);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
 
 int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
-                             QEMUBalloonStatus *stat_func, void *opaque);
+                             QEMUBalloonStatus *stat_func,
+                             QEMUBalloonWorkingSetRequest *ws_func,
+                             QEMUBalloonWorkingSetConfig *config_func,
+                             void *opaque);
 void qemu_remove_balloon_handler(void *opaque);
 
 #endif
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 602535696c..fad1b4aed5 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -333,6 +333,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
     [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
+    [QAPI_EVENT_WORKING_SET_EVENT] = { 1000 * SCALE_MS },
 };
 
 /*
diff --git a/qapi/machine.json b/qapi/machine.json
index 37660d8f2a..5e03ff21e2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1055,6 +1055,57 @@
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
+##
+# @working-set-config:
+#
+# Specify the config parameters for Working Set reporting.
+#
+# @i0: the endpoint of the first interval (in ms)
+#
+# @i1: the endpoint of the second interval (in ms)
+#
+# @i2: the endpoint of the third interval (in ms)
+#
+# @refresh: the refresh threshold (in ms) for Working Set reporting
+#
+# @report: the report threshold (in ms) for Working Set reporting
+#
+# Returns: - Nothing on success
+#          - If no balloon device is present, DeviceNotActive
+#
+# Example:
+#
+# -> { "execute": "working-set-config",
+#                 "arguments": { "i0": 100,
+#                                "i1": 500,
+#                                "i2": 2000,
+#                                "refresh": 750,
+#                                "report": 1000 } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'working-set-config', 'data': {'i0': 'uint64',
+                                            'i1': 'uint64',
+                                            'i2': 'uint64',
+                                            'refresh': 'uint64',
+                                            'report': 'uint64'} }
+##
+# @working-set-request:
+#
+# Request the Working Set report from the guest.
+#
+# Returns: - Nothing on success
+#          - If no balloon device is present, DeviceNotActive
+#
+# Example:
+#
+# -> { "execute": "working-set-request", "arguments": {} }
+# <- { "return": {} }
+#
+##
+{ 'command': 'working-set-request', 'data': {} }
+
+
 ##
 # @BalloonInfo:
 #
@@ -1113,6 +1164,21 @@
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
 
+##
+# @WORKING_SET_EVENT:
+#
+# Emitted when the guest sends a new Working Set report.
+#
+# Note: this event is rate-limited.
+#
+# Example:
+#
+# <- { "event": "WORKING_SET_EVENT",
+#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#
+##
+{ 'event': 'WORKING_SET_EVENT' }
+
 ##
 # @MemoryInfo:
 #
diff --git a/softmmu/balloon.c b/softmmu/balloon.c
index e0e8969a4b..f27852949a 100644
--- a/softmmu/balloon.c
+++ b/softmmu/balloon.c
@@ -35,6 +35,8 @@
 
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
+static QEMUBalloonWorkingSetRequest *balloon_ws_request_fn;
+static QEMUBalloonWorkingSetConfig *balloon_ws_config_fn;
 static void *balloon_opaque;
 
 static bool have_balloon(Error **errp)
@@ -53,9 +55,13 @@ static bool have_balloon(Error **errp)
 }
 
 int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
-                             QEMUBalloonStatus *stat_func, void *opaque)
+                             QEMUBalloonStatus *stat_func,
+                             QEMUBalloonWorkingSetRequest *ws_request_func,
+                             QEMUBalloonWorkingSetConfig *ws_config_func,
+                             void *opaque)
 {
-    if (balloon_event_fn || balloon_stat_fn || balloon_opaque) {
+    if (balloon_event_fn || balloon_stat_fn || balloon_ws_request_fn \
+        || balloon_ws_config_fn || balloon_opaque) {
         /* We're already registered one balloon handler.  How many can
          * a guest really have?
          */
@@ -63,6 +69,8 @@ int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
     }
     balloon_event_fn = event_func;
     balloon_stat_fn = stat_func;
+    balloon_ws_request_fn = ws_request_func;
+    balloon_ws_config_fn = ws_config_func;
     balloon_opaque = opaque;
     return 0;
 }
@@ -104,3 +112,22 @@ void qmp_balloon(int64_t target, Error **errp)
     trace_balloon_event(balloon_opaque, target);
     balloon_event_fn(balloon_opaque, target);
 }
+
+void qmp_working_set_request(Error **errp)
+{
+    if (!have_balloon(errp)) {
+        return;
+    }
+
+    balloon_ws_request_fn(balloon_opaque);
+}
+
+void qmp_working_set_config(uint64_t i0, uint64_t i1, uint64_t i2,
+                            uint64_t refresh, uint64_t report, Error **errp)
+{
+    if (!have_balloon(errp)) {
+        return;
+    }
+
+    balloon_ws_config_fn(balloon_opaque, i0, i1, i2, refresh, report);
+}
-- 
2.41.0.rc0.172.g3f132b7071-goog


