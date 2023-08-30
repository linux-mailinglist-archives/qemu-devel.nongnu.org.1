Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C33D78D4D3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgh-0004kD-DV; Wed, 30 Aug 2023 05:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgf-0004To-6J
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgd-0001Kg-1c
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFT3XJhJf5kLf+c2f60i7BSjb1iWkSM119UEWY/PfOs=;
 b=BRJxRPxVaqMLrlWzye8go3T7FOCzSneyuFVSMoS3DqC0npr1WE4AjprX2b4foZzn6nRP6N
 WZyqS8R+wnvANxWlzVeNtse6VTNtO8o29m5i1XZax6uHcYu4EB451j9hzRhQdhGObgTKwD
 3idkq6bCELFMrn9tXNlWMt2+LxVnSUQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-sbykND2kPdqmfnHQsXa3Mw-1; Wed, 30 Aug 2023 05:40:29 -0400
X-MC-Unique: sbykND2kPdqmfnHQsXa3Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB2293C0DDC7
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:40:28 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EECE440C6F4C;
 Wed, 30 Aug 2023 09:40:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 26/67] ui/vc: move cursor_timer initialization to
 QemuTextConsole class
Date: Wed, 30 Aug 2023 13:38:00 +0400
Message-ID: <20230830093843.3531473-27-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

The timer is only relevant when a text console exists.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 8c4a2c83fa..ffa68c3a22 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1399,6 +1399,10 @@ qemu_text_console_finalize(Object *obj)
 static void
 qemu_text_console_class_init(ObjectClass *oc, void *data)
 {
+    if (!cursor_timer) {
+        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                    text_console_update_cursor, NULL);
+    }
 }
 
 static void
@@ -2144,8 +2148,6 @@ static DisplayState *get_alloc_displaystate(void)
 {
     if (!display_state) {
         display_state = g_new0(DisplayState, 1);
-        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
-                                    text_console_update_cursor, NULL);
     }
     return display_state;
 }
-- 
2.41.0


