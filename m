Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DB75630C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNcW-00067p-IQ; Mon, 17 Jul 2023 08:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcS-0005ww-Aw
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcP-0008H1-Ly
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jJhd0nXcKpbP4xI8lyzEFj7qDAb0vnPKb1C7/51uiY=;
 b=AUTBnvTty8QTbYkd74/2AxC0MhYhgj8LMLBXxOigFtuIrLkZUKtJtA9ciOVK8a7qc2C+hr
 pDUYIXQKl81lMrJ98K4IHxmGN43SBgJG+zhapN2BRBbGbg5IzENCqNpt8eMqddtuOREFPG
 EJIKATd3NlxOhODAyn/KAoC2NLXOkbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-Eu9w4cSkPnSRymgYmmY5Qg-1; Mon, 17 Jul 2023 08:46:21 -0400
X-MC-Unique: Eu9w4cSkPnSRymgYmmY5Qg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E10CC800193;
 Mon, 17 Jul 2023 12:46:20 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8D04492B01;
 Mon, 17 Jul 2023 12:46:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PULL 07/19] ui/gtk: skip refresh if new dmabuf has been submitted
Date: Mon, 17 Jul 2023 16:45:32 +0400
Message-ID: <20230717124545.177236-8-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

From: Dongwon Kim <dongwon.kim@intel.com>

Skip refresh if a new dmabuf (guest scanout frame) has already been
submitted and ready to be drawn because the scanout will be updated
with new frame anyway.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230706183355.29361-2-dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 4 ++++
 ui/gtk-gl-area.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 98b3a116bf..4c29ac10d0 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -148,6 +148,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        return;
+    }
+
     if (!vc->gfx.esurface) {
         gd_egl_init(vc);
         if (!vc->gfx.esurface) {
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 28d9e49888..1ce34a249e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -125,6 +125,10 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        return;
+    }
+
     if (!vc->gfx.gls) {
         if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
             return;
-- 
2.41.0


