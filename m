Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE657B6922
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedW-0006kg-V6; Tue, 03 Oct 2023 08:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedV-0006kG-GI
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedT-0000Li-VJ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbKmTKt7zzAfu7d4R0MM9/iWqptgI4rr13HDxIYcuuY=;
 b=dTugBiq04lA3EhRP4JxOB/PgyBwZxto4uq/YKsRUlrzacyGi7H6JBBvRCPYjhLuUeCdIhH
 af6hqieZMsx/ghgXalAeBw/fLLn26MvbEBFLxG00x4M8a9Lf6CBcj0CGT1dV379jEQt5bh
 XZ1UAX8EhHkExV1nv4J+KGO0C+2BpeA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-9s340gs_O-KvCSiqPchQ3A-1; Tue, 03 Oct 2023 08:36:12 -0400
X-MC-Unique: 9s340gs_O-KvCSiqPchQ3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2CDE1C0651B;
 Tue,  3 Oct 2023 12:36:11 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82309402723;
 Tue,  3 Oct 2023 12:36:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Ken Xue <Ken.Xue@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/13] ui: add XBGR8888 and ABGR8888 in drm_format_pixman_map
Date: Tue,  3 Oct 2023 16:35:35 +0400
Message-ID: <20231003123543.1360795-7-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Ken Xue <Ken.Xue@amd.com>

Android uses XBGR8888 and ABGR8888 as default scanout buffer, But qemu
does not support them for qemu_pixman_to_drm_format conversion within
virtio_gpu_create_dmabuf for virtio gpu.

so, add those 2 formats into drm_format_pixman_map.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230914013151.805363-1-Ken.Xue@amd.com>
---
 include/ui/qemu-pixman.h | 4 ++++
 ui/qemu-pixman.c         | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 51f8709327..e587c48b1f 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -32,6 +32,8 @@
 # define PIXMAN_LE_r8g8b8     PIXMAN_b8g8r8
 # define PIXMAN_LE_a8r8g8b8   PIXMAN_b8g8r8a8
 # define PIXMAN_LE_x8r8g8b8   PIXMAN_b8g8r8x8
+# define PIXMAN_LE_a8b8g8r8   PIXMAN_r8g8b8a8
+# define PIXMAN_LE_x8b8g8r8   PIXMAN_r8g8b8x8
 #else
 # define PIXMAN_BE_r8g8b8     PIXMAN_b8g8r8
 # define PIXMAN_BE_x8r8g8b8   PIXMAN_b8g8r8x8
@@ -45,6 +47,8 @@
 # define PIXMAN_LE_r8g8b8     PIXMAN_r8g8b8
 # define PIXMAN_LE_a8r8g8b8   PIXMAN_a8r8g8b8
 # define PIXMAN_LE_x8r8g8b8   PIXMAN_x8r8g8b8
+# define PIXMAN_LE_a8b8g8r8   PIXMAN_a8b8g8r8
+# define PIXMAN_LE_x8b8g8r8   PIXMAN_x8b8g8r8
 #endif
 
 #define QEMU_PIXMAN_COLOR(r, g, b)                                               \
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index be00a96340..b43ec38bf0 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -96,7 +96,9 @@ static const struct {
 } drm_format_pixman_map[] = {
     { DRM_FORMAT_RGB888,   PIXMAN_LE_r8g8b8   },
     { DRM_FORMAT_ARGB8888, PIXMAN_LE_a8r8g8b8 },
-    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 }
+    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 },
+    { DRM_FORMAT_XBGR8888, PIXMAN_LE_x8b8g8r8 },
+    { DRM_FORMAT_ABGR8888, PIXMAN_LE_a8b8g8r8 },
 };
 
 pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format)
-- 
2.41.0


