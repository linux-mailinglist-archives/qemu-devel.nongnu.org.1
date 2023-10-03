Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD4E7B6929
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:38:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedM-0006cs-Qd; Tue, 03 Oct 2023 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedJ-0006Zs-Lj
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedI-0000FU-6g
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvS19ktAf+CvLzn5plzs+/OhAtpzncaQg9JZt2Lgibw=;
 b=eR1cI2HucZYEUkILypLLQo3xwwuBROW87Pxa1fYu4fmZ2q5XInchRQPl4lb2YnuAYJTHyV
 9EMM5FpWNpxtlBjLPXRY6sg1njU7Nj7wwJgZSBZGuPKbm4wEK6SQe//3xni96tmbgOxEcF
 iySt7H8BQg/3gBSe4Al0ydyBc3/LC3s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-N4bz85ETOhS0nc2pcdoZiQ-1; Tue, 03 Oct 2023 08:36:08 -0400
X-MC-Unique: N4bz85ETOhS0nc2pcdoZiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB0781C06515
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 12:36:07 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 099A1140E953;
 Tue,  3 Oct 2023 12:36:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 05/13] ui/console: sanitize search in
 qemu_graphic_console_is_multihead()
Date: Tue,  3 Oct 2023 16:35:34 +0400
Message-ID: <20231003123543.1360795-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

From: Laszlo Ersek <lersek@redhat.com>

qemu_graphic_console_is_multihead() declares the graphical console "c" a
"multihead" console if there are two different graphical consoles in the
system that (a) both reference "c->device", and (b) have different
"c->head" numbers. In effect, if at least two graphical consoles exist
that are different heads of the same device that underlies "c". In fact,
"c" may be one of these two graphical consoles, or "c" may differ from
both of those consoles (in case "c->device" has at least three heads).

The loop currently uses this awkward "two different consoles" approach
because the function used not to have access to "c", only to "c->device",
which didn't allow for fetching (and comparing) "c->head". But, we've
changed that in the last patch; we now pass all of "c" to
qemu_graphic_console_is_multihead().

Thus, look for the *first* (and possibly *only*) graphical console, if
any, that refers to the same "device" as "c", but by a different "head"
number.

Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graphics)
Cc: Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230913144959.41891-5-lersek@redhat.com>
---
 ui/console.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 65463d84a7..8ee66d10c5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1437,8 +1437,6 @@ bool qemu_console_is_gl_blocked(QemuConsole *con)
 static bool qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
 {
     QemuConsole *con;
-    uint32_t f = 0xffffffff;
-    uint32_t h;
 
     QTAILQ_FOREACH(con, &consoles, next) {
         QemuGraphicConsole *candidate;
@@ -1452,10 +1450,7 @@ static bool qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
             continue;
         }
 
-        h = candidate->head;
-        if (f == 0xffffffff) {
-            f = h;
-        } else if (h != f) {
+        if (candidate->head != c->head) {
             return true;
         }
     }
-- 
2.41.0


