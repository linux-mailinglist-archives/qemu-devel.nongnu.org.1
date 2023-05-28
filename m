Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7971398E
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKl-0008Bx-Fw; Sun, 28 May 2023 09:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKj-00089D-2m
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKh-0008CJ-GC
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VmGs16g4aCjuhlM/61mP+IiKbSVpFIz0LJWayBAaXQ=;
 b=fd/lPPiDDBwa28dQbYSso5lvbHDIa3V5EaJIlKYwvCBQUIm8Wwun091/pmXQiRqs+zjsQr
 f37sSBT8ho3HwFkujoj3/nmzpsqPVpug3TCCJ1TMZ4UPrM7F7Io+JpmGICivSOM7fsHsL3
 hd2iUvprlDRVX75vvsRZ83MR3mly6GE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-RrlowcgwPTCwyCfrpJzTJQ-1; Sun, 28 May 2023 09:21:11 -0400
X-MC-Unique: RrlowcgwPTCwyCfrpJzTJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F8AF1C0514E;
 Sun, 28 May 2023 13:21:11 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29108112132C;
 Sun, 28 May 2023 13:21:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PULL 12/19] ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows
Date: Sun, 28 May 2023 17:20:09 +0400
Message-Id: <20230528132016.3218152-13-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

From: Volker Rümelin <vr_qemu@t-online.de>

Windows sends an extra left control key up/down input event for
every right alt key up/down input event for keyboards with
international layout. Since commit 830473455f ("ui/sdl2: fix
handling of AltGr key on Windows") QEMU uses a Windows low level
keyboard hook procedure to reliably filter out the special left
control key and to grab the keyboard on Windows.

The SDL2 version 2.0.16 introduced its own Windows low level
keyboard hook procedure to grab the keyboard. Windows calls this
callback before the QEMU keyboard hook procedure. This disables
the special left control key filter when the keyboard is grabbed.

To fix the problem, disable the SDL2 Windows low level keyboard
hook procedure.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230418062823.5683-1-vr_qemu@t-online.de>
---
 ui/sdl2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 00aadfae37..9d703200bf 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -855,7 +855,10 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available since SDL 2.0.8 */
     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
 #endif
+#ifndef CONFIG_WIN32
+    /* QEMU uses its own low level keyboard hook procecure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
+#endif
 #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
-- 
2.40.1


