Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C437730A4
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT792-0005cQ-HP; Mon, 07 Aug 2023 16:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78z-0005Ob-Oh
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78x-0006ig-2O
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691441278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGEquOrDYqqCouEnmaVqHGup2MXV07dB8yWThUHILDU=;
 b=Ow65ivFCiVg2kwL7U9y99EqlIivchkQ/74nYl6rlWmIZ+UhuF4Hduz3/E1PFB5LrNFniyL
 Qab9LRJGKBdeJ4UM5szx9LXSSOGAEp82iJpdbSRN5vp0nsxk9k7mlsLeZdYWFV4OqnTY0d
 HV1exR0FtwsQxwe/T52KRYSSC2oKLtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-BnrR5ahZMv2255y3ptgS6g-1; Mon, 07 Aug 2023 16:47:54 -0400
X-MC-Unique: BnrR5ahZMv2255y3ptgS6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7045185C70B;
 Mon,  7 Aug 2023 20:47:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8129C2026D4B;
 Mon,  7 Aug 2023 20:47:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PULL 5/6] hw/i386/vmmouse:add relative packet flag for button status
Date: Tue,  8 Aug 2023 00:47:16 +0400
Message-ID: <20230807204717.2483983-6-marcandre.lureau@redhat.com>
In-Reply-To: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
References: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

The buttons value use macros instead of direct numbers.

If request relative mode, have to add this for
guest vmmouse driver to judge this is a relative packet.
otherwise,vmmouse driver will not match
the condition 'status & VMMOUSE_RELATIVE_PACKET',
and can't report events on the correct(relative) input device,
result to relative mode unuseful.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
Message-ID: <20230413081526.2229916-1-zhouzongmin@kylinos.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/vmmouse.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index a56c185f15..6cd624bd09 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -44,6 +44,12 @@
 
 #define VMMOUSE_VERSION		0x3442554a
 
+#define VMMOUSE_RELATIVE_PACKET    0x00010000
+
+#define VMMOUSE_LEFT_BUTTON        0x20
+#define VMMOUSE_RIGHT_BUTTON       0x10
+#define VMMOUSE_MIDDLE_BUTTON      0x08
+
 #ifdef DEBUG_VMMOUSE
 #define DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
 #else
@@ -103,15 +109,18 @@ static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_
             x, y, dz, buttons_state);
 
     if ((buttons_state & MOUSE_EVENT_LBUTTON))
-        buttons |= 0x20;
+        buttons |= VMMOUSE_LEFT_BUTTON;
     if ((buttons_state & MOUSE_EVENT_RBUTTON))
-        buttons |= 0x10;
+        buttons |= VMMOUSE_RIGHT_BUTTON;
     if ((buttons_state & MOUSE_EVENT_MBUTTON))
-        buttons |= 0x08;
+        buttons |= VMMOUSE_MIDDLE_BUTTON;
 
     if (s->absolute) {
         x <<= 1;
         y <<= 1;
+    } else{
+        /* add for guest vmmouse driver to judge this is a relative packet. */
+        buttons |= VMMOUSE_RELATIVE_PACKET;
     }
 
     s->queue[s->nb_queue++] = buttons;
-- 
2.41.0


