Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C718979167C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd89b-0002dC-Ja; Mon, 04 Sep 2023 07:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89W-0002PJ-8p
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89S-0008OH-NV
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96Uyc1t2XsaTuT7+HdEGqagaVU5D7+hfz4wBBG5J9wo=;
 b=ZrSTHvL68+UesajD9/s2GmwAryXlMIa3ZQq+HAG9Mz3+WTtiictYwwcN1OOIHZc5KIzucg
 QTVo5I6Kfi7/varTs7Cwc8RjQKBMw6WiWD3krg+BMEDqRZI8Y/2QYSzFwrYQZt3ncAtgMY
 05AtRQcUjVYqLahDsBJm/K/h+Q6K0F0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-24vfBL_YO2S76j1sBYJMqA-1; Mon, 04 Sep 2023 07:53:50 -0400
X-MC-Unique: 24vfBL_YO2S76j1sBYJMqA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 421ED3810D23
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:50 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13D0C400F5A;
 Mon,  4 Sep 2023 11:53:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 14/52] ui/vc: fold text_update_xy()
Date: Mon,  4 Sep 2023 15:52:11 +0400
Message-ID: <20230904115251.4161397-15-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-15-marcandre.lureau@redhat.com>
---
 ui/console.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index d1855f3fcf..405aedfcbd 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -425,14 +425,6 @@ static void text_console_resize(QemuConsole *s)
     s->cells = cells;
 }
 
-static inline void text_update_xy(QemuConsole *s, int x, int y)
-{
-    s->text_x[0] = MIN(s->text_x[0], x);
-    s->text_x[1] = MAX(s->text_x[1], x);
-    s->text_y[0] = MIN(s->text_y[0], y);
-    s->text_y[1] = MAX(s->text_y[1], y);
-}
-
 static void invalidate_xy(QemuConsole *s, int x, int y)
 {
     if (!qemu_console_is_visible(s)) {
@@ -453,7 +445,10 @@ static void update_xy(QemuConsole *s, int x, int y)
     TextCell *c;
     int y1, y2;
 
-    text_update_xy(s, x, y);
+    s->text_x[0] = MIN(s->text_x[0], x);
+    s->text_x[1] = MAX(s->text_x[1], x);
+    s->text_y[0] = MIN(s->text_y[0], y);
+    s->text_y[1] = MAX(s->text_y[1], y);
 
     y1 = (s->y_base + y) % s->total_height;
     y2 = y1 - s->y_displayed;
-- 
2.41.0


