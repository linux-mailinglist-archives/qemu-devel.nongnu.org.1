Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F277EC5F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWOUk-0000yY-Gy; Wed, 16 Aug 2023 17:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qWOUi-0000y3-R2
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qWOUe-0003Ee-Gz
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692222955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OcFKirAQXEdhqOVkq6H9M3WaJkHAoXMZ0EUi9vCMpys=;
 b=BjiqjddBncrYCDemFnvDuGTph/Cr26z3ACzGv3erRxLajLymMrmxDO3pulLNQKWFqcIrXY
 0IcdNvh9N23/1vrVbVy7MdB7YAcNs2Xu6YUaihXVy1Lm2vvaOeO/YDFxaSd4/53u9Mv+Bq
 dfegoRf1y9zLoOfk6gvTzyDY20okwLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-wF-3j_miPpCeE4P1ZLmvig-1; Wed, 16 Aug 2023 17:55:53 -0400
X-MC-Unique: wF-3j_miPpCeE4P1ZLmvig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A943D185A78B;
 Wed, 16 Aug 2023 21:55:52 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.32.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 361B91121314;
 Wed, 16 Aug 2023 21:55:52 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, marcandre.lureau@redhat.com,
 dongwon.kim@intel.com, kraxel@redhat.com
Subject: [PATCH for-8.1] vfio/display: Fix missing update to set backing fields
Date: Wed, 16 Aug 2023 15:55:49 -0600
Message-Id: <20230816215550.1723696-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

The below referenced commit renames scanout_width/height to
backing_width/height, but also promotes these fields in various portions
of the egl interface.  Meanwhile vfio dmabuf support has never used the
previous scanout fields and is therefore missed in the update.  This
results in a black screen when transitioning from ramfb to dmabuf display
when using Intel vGPU with these features.

Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.html
Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

This fixes a regression in dmabuf/EGL support for Intel GVT-g and
potentially the mbochs mdev driver as well.  Once validated by those
that understand dmabuf/EGL integration, I'd welcome QEMU maintainers to
take this directly for v8.1 or queue it as soon as possible for v8.1.1.

 hw/vfio/display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index bec864f482f4..837d9e6a309e 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -243,6 +243,8 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
     dmabuf->dmabuf_id  = plane.dmabuf_id;
     dmabuf->buf.width  = plane.width;
     dmabuf->buf.height = plane.height;
+    dmabuf->buf.backing_width = plane.width;
+    dmabuf->buf.backing_height = plane.height;
     dmabuf->buf.stride = plane.stride;
     dmabuf->buf.fourcc = plane.drm_format;
     dmabuf->buf.modifier = plane.drm_format_mod;
-- 
2.40.1


