Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 047107916D7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:06:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8AR-0004pM-Vs; Mon, 04 Sep 2023 07:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AC-0003tO-Id
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AA-0000Cl-Cu
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPLuBL3BHHlM/Kh/sWS9DYrcuY++Ag95owsA4R/NVcw=;
 b=TTzn7XRiKBqjvCvQKb1WlnQRfkwt3DEQLk2gkn3tMZxcfQYDbYBKTNiZjJjQKrWKrwRyt3
 +SnE5tvC7h2GhS3J35CZy0Lhu2qOnwYTxRw4QQLoyGg3QNTXiu2oqMaxo8O0O00oFNvpdp
 z3x7dycbLvJrpWwVAuZPTQv420gTxy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-17M7xqr5N-uE48JAnZIBAg-1; Mon, 04 Sep 2023 07:54:36 -0400
X-MC-Unique: 17M7xqr5N-uE48JAnZIBAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19195823D5E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:36 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 402792026D4B;
 Mon,  4 Sep 2023 11:54:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 26/52] ui/vc: move cursor_timer initialization to
 QemuTextConsole class
Date: Mon,  4 Sep 2023 15:52:23 +0400
Message-ID: <20230904115251.4161397-27-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-27-marcandre.lureau@redhat.com>
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


