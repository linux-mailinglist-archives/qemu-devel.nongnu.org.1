Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59449A542A8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Mar 2025 07:18:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4Xg-0002Mw-92; Thu, 06 Mar 2025 01:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4Xa-0002Jm-PJ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:17:06 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XX-0003Wc-R0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:17:06 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22334203781so30547795ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741241822; x=1741846622;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AGRsR0xCOtQhyX6ujNZbtw42ERJg2g6jZAFsjNyb/5c=;
 b=nJQArtk+KwS58B/lRS6Q3n24QYEwQpPtJhYt37nJTQfSr//dCdCji1rbaNx8b9vgCP
 bQ01XEhBTPKPCaIudhThT/7vt7C8KEQ+OVkpfRN6kP71hUKRdTe4LTopBC3qeLAyJkqI
 iQQ2GvhVRysFtITKemzN+1vQuqrNiGqoYeE7OEsA2DSrNklrjXYfKIIyHFs63l0BQqMU
 33uY8lBuhnYuEq6iblD2jXr4o9cO8uyamWMYnpTH4bHBKIR5+J+cn3RHkrYIU2bwbZRl
 XgDUTX8C/qW8WxK9Wbbqx6UVtDB022iXeiSkkIhVufmPxGj6czqmqq2eypK+HEMl7+D8
 1UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241822; x=1741846622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGRsR0xCOtQhyX6ujNZbtw42ERJg2g6jZAFsjNyb/5c=;
 b=igHwgxBVhRZUFoldD+qoh83JKUZp+o+LSX8eoNSEjgBkdqJ8CRAF55LLPQFY5/H6T4
 C8csPHAMJ8YRB8i4SXUR6jqYuiU2J7A/XDaqBLqsrYkFZF2x+dVeZWb5BR0mpKvTJ3zN
 i38uiNERebV6d00ZUrvdXGWPrv16LMKYVfhFx158zW4xEv2Zf6/yeX0bOMUOE3vNK5EQ
 NvfnWJdljCTAI1PUVCKOQVB/RfjcKRpYLOF0Z/hrXfEjje+T9B3fDRs/2WmeM0W+dg6U
 QVaDZ6sIVXTvnlGEOF89iiIbVAPqa76Y4z7ati8VdRCWVxQ+hEfIsoO1R8ckysDHc6/e
 aGFQ==
X-Gm-Message-State: AOJu0YwrGIypzgs8YMSVnOq98dFct/8cX6zS/y6DyKexn1d2ZnuNr+e/
 r7cgNXoXfCCAeMEFq7sqN3WT4E75VsZZuiX6ZPuhYaa0z6W1M67UFotvISY+rlU=
X-Gm-Gg: ASbGncuCb30X30UjiZk7X8Ph7x7WNeDqGBw6K20N43VwNb5xJ4w30RGSQhLpkLK+Krt
 h/Rnxu1nyvezdDJqRo/r4RBL4SI6EYqO7StHramP6e1u+uA6RyPNEiDT7UYZRyaj1Af7BrIEX+Q
 w+dDe5lRwm5uj83oNh5jo0xPRacbrdZ2Pvaa19wutOzTZUPe33XQmxt7HD8nAzMQKWIQrvKNVoh
 4MnhXoyrCk7dgsuNoJlS5MCZTm64Sa2fLKkhCt9XNl74iAkQyYzYHlX3+G7FPY7lJGNKrlcty2p
 E0MbnVCrJAJJEnaBUxrUbavPNmgLVI0VPeLCdutdzLdzwSwo
X-Google-Smtp-Source: AGHT+IG8eajS4GyqD5p++5kFvzmjivQbzFN0Vvv0tKWIiVXpqP6Qg/d5gbQxmCtCaVriHzLoKQnKtg==
X-Received: by 2002:a05:6a00:1816:b0:732:706c:c4ff with SMTP id
 d2e1a72fcca58-73693f731b2mr3741981b3a.7.1741241822254; 
 Wed, 05 Mar 2025 22:17:02 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7369844ce73sm499880b3a.74.2025.03.05.22.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:17:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 15:16:30 +0900
Subject: [PATCH v6 4/4] virtio: Convert feature properties to OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-virtio-v6-4-1235eab776d9@daynix.com>
References: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
In-Reply-To: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
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
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
 hw/core/machine.c          |  1 +
 hw/virtio/virtio-bus.c     | 14 ++++++++++++--
 hw/virtio/virtio.c         |  4 +++-
 4 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 638691028050d2599592d8c7e95c75ac3913fbdd..b854c2cb1d04da0a35165289c28f87e8cb869df6 100644
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
index 02cff735b3fb8cf0ce8a85ec7f1fb36a98005a24..b25b366bdc715acd5c90af7ac38cfb3ac88f4c5b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@ GlobalProperty hw_compat_9_2[] = {
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
     { "virtio-mem-pci", "vectors", "0" },
     { "migration", "multifd-clean-tls-termination", "false" },
+    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 896feb37a1caa805543e971c150d3673675b9a6b..75d433b252d5337d91616a2847b3dc12e811c2da 100644
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
index 85110bce37443bb46c4159761af112d0dba466b4..83f803fc703da6257608e21476305c8e9c6a8b07 100644
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
2.48.1


