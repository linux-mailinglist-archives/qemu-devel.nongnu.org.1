Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C37BF7B691F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedJ-0006Zm-Tm; Tue, 03 Oct 2023 08:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedF-0006Yg-1z
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedC-0000Ex-ET
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qp1k7QexJcfzACy5BneWkGbVeZ9HA+kdJPy04DSdKck=;
 b=VpVzSo8/5aF5Hg8rwNOIwNXJk4q8ZpVVAwMYW3zAOsuj40rTw1T2jhNrnmHAq9Io+2eYAV
 JRnGRyfhfH3/wInUCEL9VnbqCJWgzi3fIidMojWVvGfvPNoB4UWDKVlSTX3aS3Qjukh54Z
 03WhXTx+o01rg1uien3Nj0a7VCi7GEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-jkYYlys7NTqI6Ajp_kk2lg-1; Tue, 03 Oct 2023 08:36:04 -0400
X-MC-Unique: jkYYlys7NTqI6Ajp_kk2lg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15C75185A79B
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 12:36:04 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E807493113;
 Tue,  3 Oct 2023 12:36:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 04/13] ui/console: eliminate QOM properties from
 qemu_console_is_multihead()
Date: Tue,  3 Oct 2023 16:35:33 +0400
Message-ID: <20231003123543.1360795-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
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

From: Laszlo Ersek <lersek@redhat.com>

According to Marc-André's and Gerd's descriptions, the "device" and
"head" members of QemuGraphicConsole are exposed as QOM properties for two
purposes:

(1) Introspection (e.g., "qom-get" monitor command).

(2) A VNC server can display a specific device + head. This lets us run a
    multihead configuration by using multiple VNC servers (one for each
    head).

    Further, we can link input devices to device + head, so input events
    are routed to different devices dependent on where they are coming
    from. Which is most useful for tablet devices in a VNC multihead
    setup, each head has its own tablet device then. This does requires
    manual guest-side configuration, for establishing the same tablet <->
    head relationship.

However, neither goal seems to justify the complicated QOM property lookup
that's internal to qemu_console_is_multihead().

Rework qemu_console_is_multihead() with plain old C language field
accesses.

Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graphics)
Cc: Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230913144959.41891-4-lersek@redhat.com>
---
 ui/console.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 4fe26c08fb..65463d84a7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1434,25 +1434,25 @@ bool qemu_console_is_gl_blocked(QemuConsole *con)
     return con->gl_block;
 }
 
-static bool qemu_console_is_multihead(DeviceState *dev)
+static bool qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
 {
     QemuConsole *con;
-    Object *obj;
     uint32_t f = 0xffffffff;
     uint32_t h;
 
     QTAILQ_FOREACH(con, &consoles, next) {
+        QemuGraphicConsole *candidate;
+
         if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
             continue;
         }
-        obj = object_property_get_link(OBJECT(con),
-                                       "device", &error_abort);
-        if (DEVICE(obj) != dev) {
+
+        candidate = QEMU_GRAPHIC_CONSOLE(con);
+        if (candidate->device != c->device) {
             continue;
         }
 
-        h = object_property_get_uint(OBJECT(con),
-                                     "head", &error_abort);
+        h = candidate->head;
         if (f == 0xffffffff) {
             f = h;
         } else if (h != f) {
@@ -1471,7 +1471,7 @@ char *qemu_console_get_label(QemuConsole *con)
             bool multihead;
 
             dev = DEVICE(c->device);
-            multihead = qemu_console_is_multihead(dev);
+            multihead = qemu_graphic_console_is_multihead(c);
             if (multihead) {
                 return g_strdup_printf("%s.%d", dev->id ?
                                        dev->id :
-- 
2.41.0


