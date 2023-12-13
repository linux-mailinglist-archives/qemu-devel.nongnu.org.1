Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF881265E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 05:26:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDdHz-0006Zz-Ut; Wed, 13 Dec 2023 23:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rDdHY-0006YA-4U
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:25:11 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rDdHW-00047B-AY
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702527906; x=1734063906;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GB7Aw2ZUWFlZrpDmc0tXArN8lQPdhA8HuiP+BBWfeHI=;
 b=lw0dfIOgaK8QpH2HlMA7OQTPhECh/JNbhOOKjB27bx1qVWeNxg4mrVzs
 SSc346aDS+TSlkZu49LgDh6ftjE1xKza7U8Tmk1kACAGxhhbkQR/4I0F0
 +hR4TDJkWXS7+5GOOZDpWHrcLxNCXiiRhFyswHmHWUZEpsCjdf61w+uU5
 YnSb0e536qCUiqvWez07spwXuXwAjiGgACsaCXAMv2vzji7+Pu/jNNI71
 jR72JqNCshgjqKnEDbTsE9HWq1xmqt2F6ACyEow2PFV7oucLDgBbcYxcB
 Tw4e9bS6iqUpea9YbYjXpyqQfodRws/u/WhDQDmEmYFrjj1SnqBTQWwRo w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481261836"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="481261836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2023 20:24:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803127566"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="803127566"
Received: from unknown (HELO localhost.fm.intel.com) ([10.105.154.69])
 by orsmga008.jf.intel.com with ESMTP; 13 Dec 2023 20:24:58 -0800
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH 3/3] virtio-gpu: first surface update with blob scanout after
 resumed
Date: Wed, 13 Dec 2023 20:24:19 +0000
Message-Id: <20231213202419.15459-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213202419.15459-1-dongwon.kim@intel.com>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The guest surface needs to be updated with a blob scanout after resumed
from saved vm state if blob is enabled.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b016d3bac8..34dc0ab9fc 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1417,19 +1417,27 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
         if (!res) {
             return -EINVAL;
         }
-        scanout->ds = qemu_create_displaysurface_pixman(res->image);
-        if (!scanout->ds) {
-            return -EINVAL;
-        }
+
+        if (res->blob_size) {
+            assert(g->dmabuf.primary[i] != NULL);
+            g->dmabuf.primary[i]->buf.fd = res->dmabuf_fd;
+            dpy_gl_scanout_dmabuf(scanout->con, &g->dmabuf.primary[i]->buf);
+        } else {
+            scanout->ds = qemu_create_displaysurface_pixman(res->image);
+            if (!scanout->ds) {
+                return -EINVAL;
+            }
 #ifdef WIN32
-        qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
+            qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
 #endif
+            dpy_gfx_replace_surface(scanout->con, scanout->ds);
+            dpy_gfx_update_full(scanout->con);
+        }
 
-        dpy_gfx_replace_surface(scanout->con, scanout->ds);
-        dpy_gfx_update_full(scanout->con);
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
         }
+
         res->scanout_bitmask |= (1 << i);
     }
 
-- 
2.34.1


