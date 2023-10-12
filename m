Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F17C6628
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 09:17:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpw1-0006yy-JV; Thu, 12 Oct 2023 03:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvs-0006xu-BL; Thu, 12 Oct 2023 03:16:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvq-0000sV-7l; Thu, 12 Oct 2023 03:16:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4CE3129AC4;
 Thu, 12 Oct 2023 10:16:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 163F12E9B0;
 Thu, 12 Oct 2023 10:16:27 +0300 (MSK)
Received: (nullmailer pid 25941 invoked by uid 1000);
 Thu, 12 Oct 2023 07:16:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 58/61] vfio/display: Fix missing update to set backing
 fields
Date: Thu, 12 Oct 2023 10:16:14 +0300
Message-Id: <20231012071626.25905-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alex Williamson <alex.williamson@redhat.com>

The below referenced commit renames scanout_width/height to
backing_width/height, but also promotes these fields in various portions
of the egl interface.  Meanwhile vfio dmabuf support has never used the
previous scanout fields and is therefore missed in the update.  This
results in a black screen when transitioning from ramfb to dmabuf display
when using Intel vGPU with these features.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1891
Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.html
Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 931150e56b056b120c868f94751722710df0b6a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index bec864f482..837d9e6a30 100644
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
2.39.2


