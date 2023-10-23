Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D18C7D2BCE
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 09:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qupeT-0001HH-R5; Mon, 23 Oct 2023 03:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qupeR-0001H9-Cl
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 03:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qupeN-0003KB-6N
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 03:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698047218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pm5AJQT4ZR4lNVtsmA024I9/ZkwIPN6rBQ2nDY0rX4w=;
 b=NMYUIO/vj/m8BD3Ii7TzSaBnXY7ZmlSqvQXGA5ja5UtxASbuilsAodjn5DL10CKfj0l7gQ
 8s4SioAuEwicNh/ThBLp9/STiZde7/GzNiEAnD38okiLXH56e1sR2b7BflI2sHXz5btG25
 h308EwDyldHIFgozNVQZWWGbPycof18=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-wvTWb6zpPVOeM-FEuSC8Pw-1; Mon,
 23 Oct 2023 03:46:52 -0400
X-MC-Unique: wvTWb6zpPVOeM-FEuSC8Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EEB91C06E26;
 Mon, 23 Oct 2023 07:46:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5282C503B;
 Mon, 23 Oct 2023 07:46:46 +0000 (UTC)
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
 Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Subject: [PATCH v6 6/9] drm/virtio: Use the hotspot properties from cursor
 planes
Date: Mon, 23 Oct 2023 09:46:10 +0200
Message-ID: <20231023074613.41327-7-aesteve@redhat.com>
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

Atomic modesetting got support for mouse hotspots via the hotspot
properties. Port the legacy kms hotspot handling to the new properties
on cursor planes.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: virtualization@lists.linux-foundation.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a0004..20de599658c1f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -323,16 +323,16 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		DRM_DEBUG("update, handle %d, pos +%d+%d, hot %d,%d\n", handle,
 			  plane->state->crtc_x,
 			  plane->state->crtc_y,
-			  plane->state->fb ? plane->state->fb->hot_x : 0,
-			  plane->state->fb ? plane->state->fb->hot_y : 0);
+			  plane->state->hotspot_x,
+			  plane->state->hotspot_y);
 		output->cursor.hdr.type =
 			cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
 		output->cursor.resource_id = cpu_to_le32(handle);
 		if (plane->state->fb) {
 			output->cursor.hot_x =
-				cpu_to_le32(plane->state->fb->hot_x);
+				cpu_to_le32(plane->state->hotspot_x);
 			output->cursor.hot_y =
-				cpu_to_le32(plane->state->fb->hot_y);
+				cpu_to_le32(plane->state->hotspot_y);
 		} else {
 			output->cursor.hot_x = cpu_to_le32(0);
 			output->cursor.hot_y = cpu_to_le32(0);
-- 
2.41.0


