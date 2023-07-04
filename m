Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F60746D1F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcCE-00034y-6q; Tue, 04 Jul 2023 05:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qGcCB-00034a-Gk
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qGcC9-0003hs-RZ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688462376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yp/dhcbYBIfUnLLTV2EoNZf8qbnWJr8DYQoLr25VBZQ=;
 b=eFRMZDMJilyqdczOHnsgBA7wYfteGD4uzkTWHiPPR2oz0vX3I4Bc6fbLlLvtVcJxV8mkte
 a6oCqyk+MgJhjUO9H9LDdky4LuMNcRdsydZlWH9VmLK3/Dgq8BedkVXgOgJNmjkd0AQBrp
 WE7CgMK6feYtoNZpuzVoWkgCHL4eGlM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-POSPSxY9OFKDCSSE8mccmw-1; Tue, 04 Jul 2023 05:19:35 -0400
X-MC-Unique: POSPSxY9OFKDCSSE8mccmw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C0B71C05EA2;
 Tue,  4 Jul 2023 09:19:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7D78492C13;
 Tue,  4 Jul 2023 09:19:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: alxndr@bu.edu,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH] virtio-gpu: fix potential divide-by-zero regression
Date: Tue,  4 Jul 2023 11:19:33 +0200
Message-ID: <20230704091933.2342193-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit 9462ff4695aa0 ("virtio-gpu/win32: allocate shareable 2d
resources/images") introduces a division, which can lead to crashes when
"height" is 0.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1744
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c  | 4 ++--
 tests/lcitool/libvirt-ci | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 347e17d490..7371a5cbf0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -324,7 +324,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         res->image = pixman_image_create_bits(pformat,
                                               c2d.width,
                                               c2d.height,
-                                              bits, res->hostmem / c2d.height);
+                                              bits, c2d.height ? res->hostmem / c2d.height : 0);
 #ifdef WIN32
         if (res->image) {
             pixman_image_set_destroy_function(res->image, win32_pixman_image_destroy, res->handle);
@@ -1292,7 +1292,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 #endif
         res->image = pixman_image_create_bits(pformat,
                                               res->width, res->height,
-                                              bits, res->hostmem / res->height);
+                                              bits, res->height ? res->hostmem / res->height : 0);
         if (!res->image) {
             g_free(res);
             return -EINVAL;
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index b0f44f929a..c8971e90ac 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit b0f44f929a81c0a604fb7fbf8afc34d37ab0eae9
+Subproject commit c8971e90ac169ee2b539c747f74d96c876debdf9
-- 
2.41.0


