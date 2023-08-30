Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A524E78D4DB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHfR-0007S4-43; Wed, 30 Aug 2023 05:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfP-0007Ig-DW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfN-0000sB-Cn
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KA9NJQsp+fVWXqLqtRuq/dcV4t81Mp+eSHyizE2FTm0=;
 b=hjfVhtHu200AZO4pQch83Efj52G6y7ZVwX5tx2LT/MIHyQNhnCjthB3D4Q5lrz4kOg5sIc
 Rs5/ieJqQTOeZ9JZK2AKJtnL9VjRUvEG3PRxlhUfoMtayn+Q1lx3Xccz3jOI7UxKyL8Z3C
 y766zgAVfLAC0xNtqVPZceJ6iE137Uo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-2QZvUGqFPLa2P5qyQBVtow-1; Wed, 30 Aug 2023 05:39:11 -0400
X-MC-Unique: 2QZvUGqFPLa2P5qyQBVtow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE6498022E4
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:39:10 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE30401E63;
 Wed, 30 Aug 2023 09:39:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 06/67] ui/console: console_select() regardless of have_gfx
Date: Wed, 30 Aug 2023 13:37:40 +0400
Message-ID: <20230830093843.3531473-7-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
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


