Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227DA012EF
	for <lists+qemu-devel@lfdr.de>; Sat,  4 Jan 2025 08:37:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyic-0003CG-4j; Sat, 04 Jan 2025 02:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyiN-0003BF-JP
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:55 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyiL-0004xJ-JK
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:55 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21619108a6bso168612065ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976212; x=1736581012;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2WfOdMFhpM56iLiHN39KodrUfzohEYj4wntvgr2yc0s=;
 b=TfedkzEpmQdk1vN3qwFoLw42KOJDgiLL7qlogAUOmr9Vr88zPlWymgAyF04Bf5IAx9
 ukcL60JMkUpIIqlSN7gVPmoLNXrrhAQolVkLLTdpaZmDsKoK7q1+O0zWLQfBpYcLlARx
 14g2TTP77Dn7gs5m0QdnY2O/bm9tHaxDnHplqZn3O7UPUiURWlw1U38UBn9ahnkaJh6a
 Anls9jZM9hakekjdlyOrr+qyTF89Rt7hJcfa7JXheFtdwYqyqhxNU5Ir5lhd+VX28fMK
 a5PiJAfzHKUIVZqh6Z7selMnK2LpZnBqe7NAbJzTi2nAGBIdjE8BlKsMsM6Vd1zbhhiy
 Bguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976212; x=1736581012;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WfOdMFhpM56iLiHN39KodrUfzohEYj4wntvgr2yc0s=;
 b=NQd4xELJwlgMJ2b59yYO4GhZFqznmqre6m/RyyiHRUgczVwyeH0iV44VmGoo19GLjE
 Y6X8rsbKtxXW0VkOq6Kfr0pZl0G+HSEM+DD/moVb3SvCrYx6IfFssZ79wRzl79ro/vYp
 ysDfV0VNcLIelRDJC5fd5zQWkUHhI+5drikLIA8dEyG8WOUgBWTtllzPKHObBxukOcjb
 nt+k8l3sLePaFUt7QCkfMhT3Og4WzhnT2JhMZRBI/qR7WchJ+r0b7MRIb/qmtQ3c6eZH
 7rCPdF17HQ1OY9vp2gMzksZkLAzV+s2j143MG9M3KLpAVIPrGT54I7TbBzSjFKNit5DV
 5pBw==
X-Gm-Message-State: AOJu0YzNLZqT0M+nJQhtJll7l8A7Zaj8zzlobaVyvcFbnlZzxt91A0Z3
 B7bWKhlrWUcY8jc7B3ZpMCrBlskmQcIRJ2wcNTLrx1h5Gbcx7f49TXbBHDKRWfQ=
X-Gm-Gg: ASbGnctwwEczKS86IDhDzi+QSp3hXoUTCZg5c8VjdCdJ5P99JSrtpzwsLnNWuoo5eRZ
 1D6RBKM1Z3iJgwANuAEMDdpwzNMhKnaBLt3A9cSynpr8LNrP6gG3cJ5go0qkoPx+VE/wkS16cHi
 6g0Y+ahMk2RC5nx3pyxwQZDrrXdgRifG7fNDHOtHW8qFdKWTeu+B+YJLeIKRB0H+kvNPmCIOY3m
 GoVn9UZgnPmyZz3qYFUnWC3Rh6odySL2VCpzH3wESBriEKHCrHanfUw/kUt
X-Google-Smtp-Source: AGHT+IG/+4tnxbVcSE7Pw/3DtLGVnT+MdSDOPaJHEakUwvaQ/W/lmb5DObSJcTWZDQYBETr3rTk5Vw==
X-Received: by 2002:a05:6a20:7f87:b0:1e0:d0c8:7100 with SMTP id
 adf61e73a8af0-1e5e0447f07mr83111216637.7.1735976212392; 
 Fri, 03 Jan 2025 23:36:52 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad90c112sm27449016b3a.198.2025.01.03.23.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:36:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:36:07 +0900
Subject: [PATCH v3 3/3] virtio: Convert feature properties to OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-virtio-v3-3-63ef70e9ddf3@daynix.com>
References: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
In-Reply-To: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Some features are not always available with vhost. Legacy features are
not available with vp_vdpa in particular. virtio devices used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

QEMU already has OnOffAuto type, which includes the "auto" value to let
it automatically decide the effective value. Convert feature properties
to OnOffAuto and set them "auto" by default to utilize it. This allows
QEMU to report an error if they are set "on" and the corresponding
features are not available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
 hw/core/machine.c          |  4 +++-
 hw/virtio/virtio-bus.c     | 14 ++++++++++++--
 hw/virtio/virtio.c         |  4 +++-
 4 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 638691028050..b854c2cb1d04 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -113,7 +113,8 @@ struct VirtIODevice
     uint16_t queue_sel;
     /**
      * These fields represent a set of VirtIO features at various
-     * levels of the stack. @host_features indicates the complete
+     * levels of the stack. @requested_features indicates the feature
+     * set the user requested. @host_features indicates the complete
      * feature set the VirtIO device can offer to the driver.
      * @guest_features indicates which features the VirtIO driver has
      * selected by writing to the feature register. Finally
@@ -121,6 +122,7 @@ struct VirtIODevice
      * backend (e.g. vhost) and could potentially be a subset of the
      * total feature set offered by QEMU.
      */
+    OnOffAutoBit64 requested_features;
     uint64_t host_features;
     uint64_t guest_features;
     uint64_t backend_features;
@@ -149,6 +151,7 @@ struct VirtIODevice
     bool started;
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
     bool disable_legacy_check;
+    bool force_features_auto;
     bool vhost_started;
     VMChangeStateEntry *vmstate;
     char *bus_name;
@@ -376,22 +379,23 @@ typedef struct VirtIOSCSIConf VirtIOSCSIConf;
 typedef struct VirtIORNGConf VirtIORNGConf;
 
 #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
-    DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
-                      VIRTIO_RING_F_INDIRECT_DESC, true), \
-    DEFINE_PROP_BIT64("event_idx", _state, _field,        \
-                      VIRTIO_RING_F_EVENT_IDX, true),     \
-    DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
-                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
-    DEFINE_PROP_BIT64("any_layout", _state, _field, \
-                      VIRTIO_F_ANY_LAYOUT, true), \
-    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false), \
-    DEFINE_PROP_BIT64("packed", _state, _field, \
-                      VIRTIO_F_RING_PACKED, false), \
-    DEFINE_PROP_BIT64("queue_reset", _state, _field, \
-                      VIRTIO_F_RING_RESET, true), \
-    DEFINE_PROP_BIT64("in_order", _state, _field, \
-                      VIRTIO_F_IN_ORDER, false)
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("indirect_desc", _state, _field, \
+                                  VIRTIO_RING_F_INDIRECT_DESC, \
+                                  ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("event_idx", _state, _field, \
+                                  VIRTIO_RING_F_EVENT_IDX, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("notify_on_empty", _state, _field, \
+                                  VIRTIO_F_NOTIFY_ON_EMPTY, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("any_layout", _state, _field, \
+                                  VIRTIO_F_ANY_LAYOUT, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("iommu_platform", _state, _field, \
+                                  VIRTIO_F_IOMMU_PLATFORM, ON_OFF_AUTO_OFF), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("packed", _state, _field, \
+                                  VIRTIO_F_RING_PACKED, ON_OFF_AUTO_OFF), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("queue_reset", _state, _field, \
+                                  VIRTIO_F_RING_RESET, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("in_order", _state, _field, \
+                                  VIRTIO_F_IN_ORDER, ON_OFF_AUTO_OFF)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c949af97668d..bff26b95dd74 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_2[] = {};
+GlobalProperty hw_compat_9_2[] = {
+    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
+};
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
 GlobalProperty hw_compat_9_1[] = {
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 896feb37a1ca..75d433b252d5 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -50,6 +50,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
     bool vdev_has_iommu;
     Error *local_err = NULL;
+    uint64_t features;
 
     DPRINTF("%s: plug device.\n", qbus->name);
 
@@ -63,13 +64,22 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
 
     /* Get the features of the plugged device. */
     assert(vdc->get_features != NULL);
-    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
-                                            &local_err);
+    features = vdev->host_features | vdev->requested_features.auto_bits |
+               vdev->requested_features.on_bits;
+    features = vdc->get_features(vdev, features, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
+    if (!vdev->force_features_auto &&
+        (features & vdev->requested_features.on_bits) != vdev->requested_features.on_bits) {
+        error_setg(errp, "A requested feature is not supported by the device");
+        return;
+    }
+
+    vdev->host_features = features;
+
     if (klass->device_plugged != NULL) {
         klass->device_plugged(qbus->parent, &local_err);
     }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce3744..83f803fc703d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4013,11 +4013,13 @@ static void virtio_device_instance_finalize(Object *obj)
 }
 
 static const Property virtio_properties[] = {
-    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
+    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
     DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
                      disable_legacy_check, false),
+    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
+                     force_features_auto, false),
 };
 
 static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)

-- 
2.47.1


