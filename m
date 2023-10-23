Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C267F7D2BC4
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 09:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qupec-0001J5-Jj; Mon, 23 Oct 2023 03:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qupea-0001Ip-OZ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 03:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qupeW-0003Mv-8T
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 03:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698047227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qp0oGK3lMNWuN3geomtCKP1LRI8ilfYyc8y7jbzL1zY=;
 b=NWqdYlF40CNf4W8DxY7CMlbPEi8OrlK69ACsW2Rqnz1IloX3fEucxzjxO01p+/L9g6W6Ri
 psv55Rer3mUr60BAluw5fcI2GJSuoDaG+dKfxgeZRfiluF+MdkpSozfNF/dIW+PNKQOcgg
 H8CzQHa6s7xN5iIjqXgT/mWQ/Ax+Tyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-MG867VYgP8uVpqpvvUM4LA-1; Mon, 23 Oct 2023 03:47:03 -0400
X-MC-Unique: MG867VYgP8uVpqpvvUM4LA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9642B88B770;
 Mon, 23 Oct 2023 07:47:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EAC6503B;
 Mon, 23 Oct 2023 07:46:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: zackr@vmware.com, contact@emersion.fr, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Hans de Goede <hdegoede@redhat.com>,
 Matt Roper <matthew.d.roper@intel.com>, David Airlie <airlied@gmail.com>,
 banackm@vmware.com, Rob Clark <robdclark@gmail.com>, javierm@redhat.com,
 krastevm@vmware.com, spice-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mombasawalam@vmware.com, Daniel Vetter <daniel@ffwll.ch>,
 ppaalanen@gmail.com,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
 Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: [PATCH v6 8/9] drm: Introduce DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
Date: Mon, 23 Oct 2023 09:46:12 +0200
Message-ID: <20231023074613.41327-9-aesteve@redhat.com>
In-Reply-To: <20231023074613.41327-1-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

From: Zack Rusin <zackr@vmware.com>

Virtualized drivers place additional restrictions on the cursor plane
which breaks the contract of universal planes. To allow atomic
modesettings with virtualized drivers the clients need to advertise
that they're capable of dealing with those extra restrictions.

To do that introduce DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT which
lets DRM know that the client is aware of and capable of dealing with
the extra restrictions on the virtual cursor plane.

Setting this option to true makes DRM expose the cursor plane on
virtualized drivers. The userspace is expected to set the hotspots
and handle mouse events on that plane.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/drm_ioctl.c |  9 +++++++++
 include/uapi/drm/drm.h      | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index f03ffbacfe9b4..e535b58521533 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -361,6 +361,15 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->writeback_connectors = req->value;
 		break;
+	case DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT:
+		if (!drm_core_check_feature(dev, DRIVER_CURSOR_HOTSPOT))
+			return -EOPNOTSUPP;
+		if (!file_priv->atomic)
+			return -EINVAL;
+		if (req->value > 1)
+			return -EINVAL;
+		file_priv->supports_virtualized_cursor_plane = req->value;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 794c1d857677d..fc0c267f3f3ed 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -842,6 +842,31 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	5
 
+/**
+ * DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
+ *
+ * Drivers for para-virtualized hardware (e.g. vmwgfx, qxl, virtio and
+ * virtualbox) have additional restrictions for cursor planes (thus
+ * making cursor planes on those drivers not truly universal,) e.g.
+ * they need cursor planes to act like one would expect from a mouse
+ * cursor and have correctly set hotspot properties.
+ * If this client cap is not set the DRM core will hide cursor plane on
+ * those virtualized drivers because not setting it implies that the
+ * client is not capable of dealing with those extra restictions.
+ * Clients which do set cursor hotspot and treat the cursor plane
+ * like a mouse cursor should set this property.
+ * The client must enable &DRM_CLIENT_CAP_ATOMIC first.
+ *
+ * Setting this property on drivers which do not special case
+ * cursor planes (i.e. non-virtualized drivers) will return
+ * EOPNOTSUPP, which can be used by userspace to gauge
+ * requirements of the hardware/drivers they're running on.
+ *
+ * This capability is always supported for atomic-capable virtualized
+ * drivers starting from kernel version 6.6.
+ */
+#define DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT	6
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.41.0


