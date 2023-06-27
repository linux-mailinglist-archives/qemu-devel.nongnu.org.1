Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ACD73FC5F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M1-00007p-Pl; Tue, 27 Jun 2023 09:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lv-000051-5f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lr-000774-Pq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDesFIck21Cj1KLqw1bw4HycV5nSY4Dbu4C8FaGyIk0=;
 b=bhHAsXvlq+cLq6Y5SIIV+5/vSdSmqhDnBnGlfqzpil7ETWgSvvOSG4XB214umLufgOWsWy
 1Bw8mOgIHZ4tA3YsBlLsyolNY6AP88NhOsEVe3daShASO26aKGxYxoI47k0cGm6KsEOxZr
 LmLUtmMP5701ZHXRh5a3HA3tXmMiJKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-4Q2Aoc1AOvWxWVAbx_JlaA-1; Tue, 27 Jun 2023 09:03:19 -0400
X-MC-Unique: 4Q2Aoc1AOvWxWVAbx_JlaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E872A8564EF;
 Tue, 27 Jun 2023 13:02:53 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87F08C00049;
 Tue, 27 Jun 2023 13:02:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Dongwon Kim <dongwon.kim@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PULL 10/33] ui/gtk: set the area of the scanout texture correctly
Date: Tue, 27 Jun 2023 15:02:07 +0200
Message-ID: <20230627130231.1614896-11-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

x and y offsets and width and height of the scanout texture
is not correctly configured in case guest scanout frame is
dmabuf.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-ID: <20230621213150.29573-1-dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 3 ++-
 ui/gtk-gl-area.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 19130041bc..e99e3b0d8c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -257,7 +257,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
                            dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                           0, 0, dmabuf->width, dmabuf->height);
+                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
+                           dmabuf->scanout_height);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c384a1516b..1605818bd1 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -299,7 +299,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
                                dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                               0, 0, dmabuf->width, dmabuf->height);
+                               dmabuf->x, dmabuf->y, dmabuf->scanout_width,
+                               dmabuf->scanout_height);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
-- 
2.41.0


