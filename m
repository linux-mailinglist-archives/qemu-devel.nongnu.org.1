Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1B7BB17B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoeCO-00058Y-Cl; Fri, 06 Oct 2023 02:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCJ-00056I-PY
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:29 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCF-0002eR-C8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S1yvw5SHnz4xPy;
 Fri,  6 Oct 2023 17:20:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1yvv3FY2z4xGP;
 Fri,  6 Oct 2023 17:20:11 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/21] vfio/display: Fix missing update to set backing fields
Date: Fri,  6 Oct 2023 08:19:45 +0200
Message-ID: <20231006062005.1040296-2-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006062005.1040296-1-clg@redhat.com>
References: <20231006062005.1040296-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=cI0A=FU=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/vfio/display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index bec864f482f46866bf292a5a63c31753a7c84eef..837d9e6a309e834601c125e36faadf81c1c5172e 100644
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
2.41.0


