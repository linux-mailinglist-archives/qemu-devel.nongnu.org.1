Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B49D1745
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 18:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5gt-0000JC-Cb; Mon, 18 Nov 2024 12:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gR-0008Fo-0Y
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gP-0004mo-GE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIFQ3iIfQ6WGQ+3ewFMhClo7IyMsvlGjJ+aMfrpuFkE=;
 b=aUxn45Sh+JmPL7Z5XNIziuTfxEObeKUe7NwmuMZFhRpK0DmmpEl9b8GnJoSf8oWmRZv3yS
 dZPhceunkGwcsMHKW9K2QxLClX01R1EVdpmTCXa2kEEatY/nyB0FT9K9fpACtImBuW2PQ5
 hFH1IZ2UTk4jy3GSy6ttnGX+N09UfJQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-8-Qii9qrMnSkhsU8jo8v2w-1; Mon,
 18 Nov 2024 12:37:02 -0500
X-MC-Unique: 8-Qii9qrMnSkhsU8jo8v2w-1
X-Mimecast-MFC-AGG-ID: 8-Qii9qrMnSkhsU8jo8v2w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E72C1955F42; Mon, 18 Nov 2024 17:36:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 183FE19560A3; Mon, 18 Nov 2024 17:36:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 06/12] hw/s390x: Restrict "loadparm" property to devices that
 can be used for booting
Date: Mon, 18 Nov 2024 18:36:28 +0100
Message-ID: <20241118173634.473532-7-thuth@redhat.com>
In-Reply-To: <20241118173634.473532-1-thuth@redhat.com>
References: <20241118173634.473532-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit bb185de423 ("s390x: Add individual loadparm assignment to
CCW device") added a "loadparm" property to all CCW devices. This
was a little bit unfortunate, since this property is only useful
for devices that can be used for booting, but certainly it is not
useful for devices like virtio-gpu or virtio-tablet.

Thus let's restrict the property to CCW devices that we can boot from
(i.e. virtio-block, virtio-net and vfio-ccw devices).

Message-ID: <20241113114741.681096-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ccw-device.h     | 5 +++++
 hw/s390x/ccw-device.c     | 4 +---
 hw/s390x/virtio-ccw-blk.c | 1 +
 hw/s390x/virtio-ccw-net.c | 1 +
 hw/vfio/ccw.c             | 1 +
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 1e1737c0f3..4439feb140 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -51,4 +51,9 @@ static inline CcwDevice *to_ccw_dev_fast(DeviceState *d)
 
 OBJECT_DECLARE_TYPE(CcwDevice, CCWDeviceClass, CCW_DEVICE)
 
+extern const PropertyInfo ccw_loadparm;
+
+#define DEFINE_PROP_CCW_LOADPARM(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(uint8_t[8]))
+
 #endif
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 230cc09e03..30f2fb486f 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -73,7 +73,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
     s390_ipl_fmt_loadparm(dev->loadparm, val, errp);
 }
 
-static const PropertyInfo ccw_loadparm = {
+const PropertyInfo ccw_loadparm = {
     .name  = "ccw_loadparm",
     .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
             " to the guest loader/kernel",
@@ -85,8 +85,6 @@ static Property ccw_device_properties[] = {
     DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
     DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
     DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
-    DEFINE_PROP("loadparm", CcwDevice, loadparm, ccw_loadparm,
-            typeof(uint8_t[8])),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 8e0e58b77d..2364432c6e 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -48,6 +48,7 @@ static Property virtio_ccw_blk_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index 484e617659..a4a3f65c7e 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -51,6 +51,7 @@ static Property virtio_ccw_net_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 24703c814a..c1cd7736cd 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -662,6 +662,7 @@ static Property vfio_ccw_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
+    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.47.0


