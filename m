Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476317CAD58
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPNc-0000Wx-W4; Mon, 16 Oct 2023 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ffd15938eba190e275bf+7358+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qsPNN-0000OG-2W; Mon, 16 Oct 2023 11:19:25 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ffd15938eba190e275bf+7358+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qsPNK-0001aO-QD; Mon, 16 Oct 2023 11:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=CKGyyzKxuGsuwvI9v9sDpTYzNulOlzm/j1apww1tl2E=; b=uA3k1jxFkJRBbPY6r9+ROrl9xB
 Ed1eunSvi3H/KfvrxrT9lP5H2djfPrnFHcFygKZj4VcGF52CxaRrHRDnTZjj+UZ4Vmx3fme2ifd+8
 jLrO4NXss7pNWzjoHdrAHJMckswmA04WATXDPBzFy1GB/kwDx0q70Asa+juNKTadNvBADrARDRpaq
 qED7epYAiAoHEZ4Mc691xWO7fHvrFofp1UauU0/ULASJmdaKqcMU8KUj1WRBkHIk/dO85a0houl97
 suKAGPYQ0Sa9d51Ix6QAOP2so7mLXRySlKD02UAH/xsCQG0QNTs9AMYKlBF2zNqslKh21c7iwIGu8
 1TscSXxA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qsPNC-006lqd-K5; Mon, 16 Oct 2023 15:19:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qsPNC-0005nm-0O; Mon, 16 Oct 2023 16:19:14 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Woodhouse <dwmw2@infradead.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: [PATCH 11/12] hw/xen: automatically assign device index to block
 devices
Date: Mon, 16 Oct 2023 16:19:08 +0100
Message-Id: <20231016151909.22133-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016151909.22133-1-dwmw2@infradead.org>
References: <20231016151909.22133-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+ffd15938eba190e275bf+7358+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

There's no need to force the user to assign a vdev. We can automatically
assign one, starting at xvda and searching until we find the first disk
name that's unused.

This means we can now allow '-drive if=xen,file=xxx' to work without an
explicit separate -driver argument, just like if=virtio.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 blockdev.c           | 15 ++++++++++++---
 hw/block/xen-block.c | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 325b7a3bef..9dec4c9c74 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -255,13 +255,13 @@ void drive_check_orphaned(void)
          * Ignore default drives, because we create certain default
          * drives unconditionally, then leave them unclaimed.  Not the
          * users fault.
-         * Ignore IF_VIRTIO, because it gets desugared into -device,
-         * so we can leave failing to -device.
+         * Ignore IF_VIRTIO or IF_XEN, because it gets desugared into
+         * -device, so we can leave failing to -device.
          * Ignore IF_NONE, because leaving unclaimed IF_NONE remains
          * available for device_add is a feature.
          */
         if (dinfo->is_default || dinfo->type == IF_VIRTIO
-            || dinfo->type == IF_NONE) {
+            || dinfo->type == IF_XEN || dinfo->type == IF_NONE) {
             continue;
         }
         if (!blk_get_attached_dev(blk)) {
@@ -977,6 +977,15 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
         qemu_opt_set(devopts, "driver", "virtio-blk", &error_abort);
         qemu_opt_set(devopts, "drive", qdict_get_str(bs_opts, "id"),
                      &error_abort);
+    } else if (type == IF_XEN) {
+        QemuOpts *devopts;
+        devopts = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
+                                   &error_abort);
+        qemu_opt_set(devopts, "driver",
+                     (media == MEDIA_CDROM) ? "xen-cdrom" : "xen-disk",
+                     &error_abort);
+        qemu_opt_set(devopts, "drive", qdict_get_str(bs_opts, "id"),
+                     &error_abort);
     }
 
     filename = qemu_opt_get(legacy_opts, "file");
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 9262338535..20fa783cbe 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -34,6 +34,31 @@ static char *xen_block_get_name(XenDevice *xendev, Error **errp)
     XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
     XenBlockVdev *vdev = &blockdev->props.vdev;
 
+    if (blockdev->props.vdev.type == XEN_BLOCK_VDEV_TYPE_INVALID) {
+        char name[11];
+        int disk = 0;
+        unsigned long idx;
+
+        /* Find an unoccupied device name */
+        while (disk < (1 << 20)) {
+            if (disk < (1 << 4)) {
+                idx = (202 << 8) | (disk << 4);
+            } else {
+                idx = (1 << 28) | (disk << 8);
+            }
+            snprintf(name, sizeof(name), "%lu", idx);
+            if (!xen_backend_exists("qdisk", name)) {
+                vdev->type = XEN_BLOCK_VDEV_TYPE_XVD;
+                vdev->partition = 0;
+                vdev->disk = disk;
+                vdev->number = idx;
+                return g_strdup(name);
+            }
+            disk++;
+        }
+        error_setg(errp, "cannot find device vdev for block device");
+        return NULL;
+    }
     return g_strdup_printf("%lu", vdev->number);
 }
 
-- 
2.40.1


