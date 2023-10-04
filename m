Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCBE7B7A71
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUw-0005Ie-AT; Wed, 04 Oct 2023 04:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUj-0004uX-UG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUg-0001gl-BN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mf4R/8YkSOY8vs2JqIsx1upo9A7AZa1KZ2BBSwBvoc=;
 b=M/T/XC2QQPmMkV8MdsFrzj2uvZldjSx1CE0WVPxK4QKzkNXsN7sLSRDVzGhJWZcWPZDwDw
 3VefZc2IkdiSDLzwk0yHNSKFi8Uy+dKgdiWzXyc1lYkEft+Ua9F0p0iivOxPPTeeRvmcle
 kcz3dWSZknXOHMvmrBy2dkwTwaOlOOg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Svz1X2jfN_i-yLtfPP_ihw-1; Wed, 04 Oct 2023 04:44:22 -0400
X-MC-Unique: Svz1X2jfN_i-yLtfPP_ihw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50421897564so1813797e87.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409060; x=1697013860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mf4R/8YkSOY8vs2JqIsx1upo9A7AZa1KZ2BBSwBvoc=;
 b=jsajrMJZLibIMzESo3APTOpUNl+/lY97yZ68JpsMtqUpXfd4OUZh7TZ91yHlTUiS3U
 A0fxcr0w+U8PvB0xDpQffSZ+r2pPWkLgmgG5nnDqb5RW2rScLiiHDiY0fHl2nLbPA/+q
 HScB1Wcy0DjnVKBfayz0bomUfvubBy7mJP42SPDGc/jkPNFxMvMxfhfadB2Sh8dm0WaQ
 39qPw5e4pWJZeSq9etURrwgCm8iMOpsXqRfB8PZXcRQVZermhjHJkgxhpqyLoJ4hBJvN
 UFuRzrQrLi8fgPFWpWOQY+8G2dGbC6JLBrWD1+TlO6nWzGzeO2VPaVq1QGkOTnFzUD8t
 /pIQ==
X-Gm-Message-State: AOJu0YxeNs0vf+++5yIsf7GRJDAEPgsoecVDLpCRRkjfIRh4ZssZ9HE7
 +8MTgMohnv8pxNF8TB/d8UFl7hqu2pu25701kMankOXESXHELsViUZNjQbWsw6ms/zEGxjm89mG
 VK3JcoccoMgbtzp5mlKGDBVsv3/XH08th8qPaGpcr589AmfciJk9vKaDhs4Sy49K7D1s6
X-Received: by 2002:a19:2d4d:0:b0:4fd:f77d:5051 with SMTP id
 t13-20020a192d4d000000b004fdf77d5051mr1374639lft.26.1696409059926; 
 Wed, 04 Oct 2023 01:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4iBlgcsGI+jSrDZBFcl3aq65AXEnUtr0bg93LS2SzWbi51O3tXpbgUtAzUEcIX73TxwIKvA==
X-Received: by 2002:a19:2d4d:0:b0:4fd:f77d:5051 with SMTP id
 t13-20020a192d4d000000b004fdf77d5051mr1374619lft.26.1696409059492; 
 Wed, 04 Oct 2023 01:44:19 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b00401b242e2e6sm929297wme.47.2023.10.04.01.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:18 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 22/63] qmp: update virtio feature maps, vhost-user-gpio
 introspection
Message-ID: <b9a4e572e784293618ebab985548d1f4da69da96.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add new vhost-user protocol feature to vhost-user protocol feature map
and enumeration:
 - VHOST_USER_PROTOCOL_F_STATUS

Add new virtio device features for several virtio devices to their
respective feature mappings:

virtio-blk:
 - VIRTIO_BLK_F_SECURE_ERASE

virtio-net:
 - VIRTIO_NET_F_NOTF_COAL
 - VIRTIO_NET_F_GUEST_USO4
 - VIRTIO_NET_F_GUEST_USO6
 - VIRTIO_NET_F_HOST_USO

virtio/vhost-user-gpio:
 - VIRTIO_GPIO_F_IRQ
 - VHOST_USER_F_PROTOCOL_FEATURES

Add support for introspection on vhost-user-gpio devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20230926224107.2951144-3-jonah.palmer@oracle.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-gpio.c |  7 +++++++
 hw/virtio/virtio-qmp.c      | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index 3b013f2d0f..3d7fae3984 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -205,6 +205,12 @@ static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
     vhost_virtqueue_mask(&gpio->vhost_dev, vdev, idx, mask);
 }
 
+static struct vhost_dev *vu_gpio_get_vhost(VirtIODevice *vdev)
+{
+    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
+    return &gpio->vhost_dev;
+}
+
 static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserGPIO *gpio)
 {
     virtio_delete_queue(gpio->command_vq);
@@ -413,6 +419,7 @@ static void vu_gpio_class_init(ObjectClass *klass, void *data)
     vdc->get_config = vu_gpio_get_config;
     vdc->set_status = vu_gpio_set_status;
     vdc->guest_notifier_mask = vu_gpio_guest_notifier_mask;
+    vdc->get_vhost = vu_gpio_get_vhost;
 }
 
 static const TypeInfo vu_gpio_info = {
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index adebf87e9b..3431711db5 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -30,6 +30,7 @@
 #include "standard-headers/linux/virtio_iommu.h"
 #include "standard-headers/linux/virtio_mem.h"
 #include "standard-headers/linux/virtio_vsock.h"
+#include "standard-headers/linux/virtio_gpio.h"
 
 #include CONFIG_DEVICES
 
@@ -53,6 +54,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
+    VHOST_USER_PROTOCOL_F_STATUS = 16,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -136,6 +138,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
             "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
             "memory slots supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
+            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
+            "device status supported"),
     { -1, "" }
 };
 
@@ -178,6 +183,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "VIRTIO_BLK_F_DISCARD: Discard command supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
             "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
+            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             "VIRTIO_BLK_F_ZONED: Zoned block devices"),
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -301,6 +308,14 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
             "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
             "channel"),
+    FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
+            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
+            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
+            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
+            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
     FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
             "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
@@ -471,6 +486,18 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
 };
 #endif
 
+/* virtio/vhost-gpio features mapping */
+#ifdef CONFIG_VHOST_USER_GPIO
+static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
+            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
 #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
     ({                                                   \
         type *list = NULL;                               \
@@ -627,6 +654,12 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         features->dev_features =
             CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
         break;
+#endif
+#ifdef CONFIG_VHOST_USER_GPIO
+    case VIRTIO_ID_GPIO:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
+        break;
 #endif
     /* No features */
     case VIRTIO_ID_9P:
@@ -653,7 +686,6 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
     case VIRTIO_ID_DMABUF:
     case VIRTIO_ID_PARAM_SERV:
     case VIRTIO_ID_AUDIO_POLICY:
-    case VIRTIO_ID_GPIO:
         break;
     default:
         g_assert_not_reached();
-- 
MST


