Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636273EAC9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:00:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrIa-00047L-VF; Mon, 26 Jun 2023 14:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIW-00044p-JZ; Mon, 26 Jun 2023 14:50:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIT-0004qT-Mu; Mon, 26 Jun 2023 14:50:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 85CA1EF1C;
 Mon, 26 Jun 2023 21:50:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 69D3FF7AF;
 Mon, 26 Jun 2023 21:50:17 +0300 (MSK)
Received: (nullmailer pid 1573985 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 09/54] ui/dbus: fix compilation when GBM && !OPENGL
Date: Mon, 26 Jun 2023 21:49:16 +0300
Message-Id: <20230626185002.1573836-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

commit 4814d3cbf ("ui/dbus: restrict opengl to gbm-enabled config")
assumes that whenever GBM is available, OpenGL is. This is not always
the case, let's further restrict opengl-related paths and fix some
compilation issues.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230515132348.1024663-1-marcandre.lureau@redhat.com>
(cherry picked from commit 0b31e48d62c8f3a282d1bffbcc0e90200df9f9f0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.2


