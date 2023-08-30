Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD878D4B1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHhd-0000r1-LC; Wed, 30 Aug 2023 05:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhV-0000dd-Oc
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhT-0001Uw-Kk
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5XDk4/Edr6CXpXgef09NrC49TzD0NVUaltlO+MRugY=;
 b=Uoq95kcyAcngPg1gZkUwa2LtGuvwh4Cqm37zDNYiL733KHWNc6ZPfXVmyRj7UbLZ2f6zEx
 JtAa9zwaFX3lLkymwgaMY04tlYvjj6jhf7mssyeqNTful0zir3TITljzWZnu3wm6cFwkXP
 u3AdZwtXUPJSxfiPvh9Xd3WxyvW2OSM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-08rjyZCBN4ixG7bewZATCw-1; Wed, 30 Aug 2023 05:41:21 -0400
X-MC-Unique: 08rjyZCBN4ixG7bewZATCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 309643C0E445
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:41:21 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4BA40C6F4F;
 Wed, 30 Aug 2023 09:41:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 39/67] ui/console: fold text_console_update_cursor_timer
Date: Wed, 30 Aug 2023 13:38:13 +0400
Message-ID: <20230830093843.3531473-40-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 04ec2d2488..c31368667d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -174,7 +174,6 @@ static QEMUTimer *cursor_timer;
 
 static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
-static void text_console_update_cursor_timer(void);
 static void text_console_update_cursor(void *opaque);
 static bool displaychangelistener_has_dmabuf(DisplayChangeListener *dcl);
 static bool console_compatible_with(QemuConsole *con,
@@ -2497,12 +2496,6 @@ static void vc_chr_set_echo(Chardev *chr, bool echo)
     drv->console->echo = echo;
 }
 
-static void text_console_update_cursor_timer(void)
-{
-    timer_mod(cursor_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
-              + CONSOLE_CURSOR_PERIOD / 2);
-}
-
 static void text_console_update_cursor(void *opaque)
 {
     QemuConsole *s;
@@ -2520,7 +2513,8 @@ static void text_console_update_cursor(void *opaque)
     }
 
     if (count) {
-        text_console_update_cursor_timer();
+        timer_mod(cursor_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
+                  + CONSOLE_CURSOR_PERIOD / 2);
     }
 }
 
-- 
2.41.0


