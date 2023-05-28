Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45E71398D
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKK-0007bq-Ex; Sun, 28 May 2023 09:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKG-0007bS-Ud
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKF-00085p-HN
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rwa4w3lHrxjFcXn2rIPSMTl2Jjhngi5lCJQjzwXfN8I=;
 b=ZflFLj+dKiNC9ZKxIc/uz/K1eenMDOmu/Tk/qdLamyTW2XChdti6od9RBrpM1RMPtj86IH
 pyOvUcID6H9J3xDkgBcSDUAF9Oc0Sfz1fx+sUA3w952q4YG95wtOkct0UVPPCWN03IC2OB
 TQM6Y52B/3byVFK8wwST7Fo6Hl84SSE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-oLOMCpaPOkaE3lSTD3_Z_g-1; Sun, 28 May 2023 09:20:42 -0400
X-MC-Unique: oLOMCpaPOkaE3lSTD3_Z_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6841C1C0514E;
 Sun, 28 May 2023 13:20:42 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 038F52166B2B;
 Sun, 28 May 2023 13:20:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 05/19] ui/dbus: fix compilation when GBM && !OPENGL
Date: Sun, 28 May 2023 17:20:02 +0400
Message-Id: <20230528132016.3218152-6-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

commit 4814d3cbf ("ui/dbus: restrict opengl to gbm-enabled config")
assumes that whenever GBM is available, OpenGL is. This is not always
the case, let's further restrict opengl-related paths and fix some
compilation issues.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230515132348.1024663-1-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 911acdc529..defe2220c0 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -50,7 +50,7 @@ struct _DBusDisplayListener {
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
 
-#ifdef CONFIG_GBM
+#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
 static void dbus_update_gl_cb(GObject *source_object,
                            GAsyncResult *res,
                            gpointer user_data)
@@ -239,7 +239,7 @@ static void dbus_refresh(DisplayChangeListener *dcl)
     graphic_hw_update(dcl->con);
 }
 
-#ifdef CONFIG_GBM
+#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
 static void dbus_gl_gfx_update(DisplayChangeListener *dcl,
                                int x, int y, int w, int h)
 {
@@ -302,7 +302,7 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
         DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
 }
 
-#ifdef CONFIG_GBM
+#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
 static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
                                struct DisplaySurface *new_surface)
 {
@@ -369,7 +369,7 @@ static void dbus_cursor_define(DisplayChangeListener *dcl,
         NULL);
 }
 
-#ifdef CONFIG_GBM
+#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
 const DisplayChangeListenerOps dbus_gl_dcl_ops = {
     .dpy_name                = "dbus-gl",
     .dpy_gfx_update          = dbus_gl_gfx_update,
@@ -417,7 +417,7 @@ dbus_display_listener_constructed(GObject *object)
     DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(object);
 
     ddl->dcl.ops = &dbus_dcl_ops;
-#ifdef CONFIG_GBM
+#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
     if (display_opengl) {
         ddl->dcl.ops = &dbus_gl_dcl_ops;
     }
-- 
2.40.1


