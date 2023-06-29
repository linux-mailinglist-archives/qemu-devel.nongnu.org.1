Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF127427B1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:49:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErUy-0003eC-6H; Thu, 29 Jun 2023 09:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qErUv-0003b0-Bi
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:15:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qErUs-0007Vf-MX
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:15:45 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E760674638A;
 Thu, 29 Jun 2023 15:15:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B41C1746361; Thu, 29 Jun 2023 15:15:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B235574632B;
 Thu, 29 Jun 2023 15:15:24 +0200 (CEST)
Date: Thu, 29 Jun 2023 15:15:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: Unused variables in dbus_call_update_gl
In-Reply-To: <156d2af2-5e64-39f1-fdbd-54f6c299515a@eik.bme.hu>
Message-ID: <336f7697-bcfa-1f5f-e411-6859815aa26c@eik.bme.hu>
References: <156d2af2-5e64-39f1-fdbd-54f6c299515a@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1215749224-1688044524=:10381"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1215749224-1688044524=:10381
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Thu, 29 Jun 2023, BALATON Zoltan wrote:
> Hello,
>
> After recent commits I'm now getting:
>
> ../ui/dbus-listener.c: In function ¡dbus_call_update_gl¢:
> ../ui/dbus-listener.c:210:26: error: unused variable ¡ddl¢ 
> [-Werror=unused-variable]
>  210 |     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, 
> dcl);
>      |                          ^~~
> At top level:
> ../ui/dbus-listener.c:180:13: error: ¡dbus_update_gl_cb¢ defined but not used 
> [-Werror=unused-function]
>  180 | static void dbus_update_gl_cb(GObject *source_object,
>      |             ^~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> when compiling on Linux with gcc.

The patch below seems to fix compilation for me but not sure what else 
would it break.

Regards,
BALATON Zoltan

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index e10162b279..601c134e09 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -177,6 +177,7 @@ fail:
 }
 #endif /* WIN32 */

+#if defined (CONFIG_GBM) || defined (WIN32)
 static void dbus_update_gl_cb(GObject *source_object,
                               GAsyncResult *res,
                               gpointer user_data)
@@ -203,12 +204,14 @@ static void dbus_update_gl_cb(GObject *source_object,
     graphic_hw_gl_block(ddl->dcl.con, false);
     g_object_unref(ddl);
 }
+#endif

 static void dbus_call_update_gl(DisplayChangeListener *dcl,
                                 int x, int y, int w, int h)
 {
+#if defined (CONFIG_GBM) || defined (WIN32)
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
-
+#endif
     trace_dbus_update_gl(x, y, w, h);

     glFlush();
--3866299591-1215749224-1688044524=:10381--

