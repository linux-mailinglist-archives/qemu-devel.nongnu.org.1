Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0F791688
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd88y-00027I-9r; Mon, 04 Sep 2023 07:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88x-000275-Dz
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88v-0008Jn-Bh
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIdSJ5rroo5IqOjA5fWj+tdgB6g3pollPahLxT09zLg=;
 b=giqxeBNdOg/y8ts4C0iS29E89AHpHSK6L5CDL2xkLwL+y1vCvfvS6WZEC/UxEiEyp3vMf7
 PEJ/jfjWPfPizshB6j00goP4/PiVoHv3xBiA4OaGhkyV2jxEa8VBUvRCH8zlqNE2nxs/SC
 VTyP6PNOaLd4JQnLnMphrAxInR00lN8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-E3K67XrbP9e10vUpskNBzw-1; Mon, 04 Sep 2023 07:53:19 -0400
X-MC-Unique: E3K67XrbP9e10vUpskNBzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 231EB380671E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:19 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40650568FF;
 Mon,  4 Sep 2023 11:53:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 06/52] ui/console: console_select() regardless of have_gfx
Date: Mon,  4 Sep 2023 15:52:03 +0400
Message-ID: <20230904115251.4161397-7-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Even if we don't have a gfx listener, we should call
displaychangelistener_display_console() which handle that case correctly.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-7-marcandre.lureau@redhat.com>
---
 ui/console.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index bec2d1a40a..14717a6f4d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1047,13 +1047,11 @@ void console_select(unsigned int index)
         DisplayState *ds = s->ds;
 
         active_console = s;
-        if (ds->have_gfx) {
-            QLIST_FOREACH(dcl, &ds->listeners, next) {
-                if (dcl->con != NULL) {
-                    continue;
-                }
-                displaychangelistener_display_console(dcl, s, NULL);
+        QLIST_FOREACH (dcl, &ds->listeners, next) {
+            if (dcl->con != NULL) {
+                continue;
             }
+            displaychangelistener_display_console(dcl, s, NULL);
         }
         dpy_text_resize(s, s->width, s->height);
         text_console_update_cursor(NULL);
-- 
2.41.0


