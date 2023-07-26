Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2323763B78
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgCs-0002GO-R5; Wed, 26 Jul 2023 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qOgBl-0001mv-Ok
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qOgBk-0001QJ-8f
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690384348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=APWLavxr8ztx9s7NOhk5kaGK5nG50fBFu3yankL37G8=;
 b=IrIDeV/YHJpKpHfGG13FI4yPGcZj8mJP3s/Mi1nMwaHN0iUyKuFMMV4jDqVXn8+Koc4Tyb
 7aLXKpw4qGRnFtcnI5yBMvI49gEFkoN6HMCFJ2/snPhcBl8mz5CiDEC5xgFRhGlLUHpcYs
 V2eXE9NyHJVX1uHbe9E2AmNi6/7ADJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-0rvEtBdcP-iJTbSWHCVvJg-1; Wed, 26 Jul 2023 11:12:25 -0400
X-MC-Unique: 0rvEtBdcP-iJTbSWHCVvJg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D95E2803FDC;
 Wed, 26 Jul 2023 15:12:24 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10ED94A9004;
 Wed, 26 Jul 2023 15:12:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui/dbus: fix clang compilation issue
Date: Wed, 26 Jul 2023 19:12:21 +0400
Message-ID: <20230726151221.515761-1-marcandre.lureau@redhat.com>
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

../ui/dbus-listener.c:236:9: error: expected expression
        Error *err = NULL;

See:
https://gitlab.com/qemu-project/qemu/-/issues/1782#note_1488517427

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 02fc6ae239..30917271ab 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -232,7 +232,7 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
         egl_fb_read_rect(ddl->ds, &ddl->fb, x, y, w, h);
         dbus_gfx_update(dcl, x, y, w, h);
         break;
-    case SHARE_KIND_D3DTEX:
+    case SHARE_KIND_D3DTEX: {
         Error *err = NULL;
         assert(ddl->d3d_texture);
 
@@ -249,6 +249,7 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
             dbus_update_gl_cb,
             g_object_ref(ddl));
         break;
+    }
     default:
         g_warn_if_reached();
     }
-- 
2.41.0


