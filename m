Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4C78D4AB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:40:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHfC-0007Gl-3D; Wed, 30 Aug 2023 05:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfA-0007Fu-8g
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHf8-0000q7-4j
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gh2udv7f3z4GM5pcT/1Ns4j3PLWwCim7+/8rj7t05/o=;
 b=NEf8RWbfYvrXVde9MFKK36lXQKikUvH8RMUVxeoxPbnIKmWEtdGsveGgSt+NZM2OGdkklt
 6O8zdYUyvXuSvk6telbwpsTtp5YFEaGiqAJUNt4g8ZPlA9HEhrjieVDgPiFgpTF7M2UJyP
 bZcxNd/pwYwrKAW3xuyeMi15mIh66FE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-Eczibkq3Mza_awWcgV4iBw-1; Wed, 30 Aug 2023 05:38:55 -0400
X-MC-Unique: Eczibkq3Mza_awWcgV4iBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F2A33C100BC
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:38:55 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6FEF112131B;
 Wed, 30 Aug 2023 09:38:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 02/67] ui: remove qemu_pixman_linebuf_copy()
Date: Wed, 30 Aug 2023 13:37:36 +0400
Message-ID: <20230830093843.3531473-3-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit 43c7d8bd449 ("console: add qemu_pixman_linebuf_copy"), it
seems it was never used.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-pixman.h | 2 --
 ui/qemu-pixman.c         | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index fd78d17124..ce4518e4de 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -72,8 +72,6 @@ pixman_image_t *qemu_pixman_linebuf_create(pixman_format_code_t format,
                                            int width);
 void qemu_pixman_linebuf_fill(pixman_image_t *linebuf, pixman_image_t *fb,
                               int width, int x, int y);
-void qemu_pixman_linebuf_copy(pixman_image_t *fb, int width, int x, int y,
-                              pixman_image_t *linebuf);
 pixman_image_t *qemu_pixman_mirror_create(pixman_format_code_t format,
                                           pixman_image_t *image);
 void qemu_pixman_image_unref(pixman_image_t *image);
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index c5053cd326..be00a96340 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -200,14 +200,6 @@ void qemu_pixman_linebuf_fill(pixman_image_t *linebuf, pixman_image_t *fb,
                            x, y, 0, 0, 0, 0, width, 1);
 }
 
-/* copy linebuf to framebuffer */
-void qemu_pixman_linebuf_copy(pixman_image_t *fb, int width, int x, int y,
-                              pixman_image_t *linebuf)
-{
-    pixman_image_composite(PIXMAN_OP_SRC, linebuf, NULL, fb,
-                           0, 0, 0, 0, x, y, width, 1);
-}
-
 pixman_image_t *qemu_pixman_mirror_create(pixman_format_code_t format,
                                           pixman_image_t *image)
 {
-- 
2.41.0


