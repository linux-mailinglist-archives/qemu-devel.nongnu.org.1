Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED634791694
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd88r-000268-5z; Mon, 04 Sep 2023 07:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88p-00025k-Gk
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88n-0008I7-D4
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQ2utPPwFS2/4p5GZB12jdeq7xHGReWfKcgs+mpegXk=;
 b=HjRme4oDGGdkmx67+sxBspCwbQOHkuQ3oCdniCa51Ptzan3CAmKDOLdAYaEfOE1i/z81S1
 S24VKcbkFExrrH+OmsLbLOM8HuoCqUuHYswpv31w+ntYhFUZU4WzH0UEmzb4PVXak3d3yh
 ZbXAr6FnGO6Hq/GtUhKGdVC4s6liX6Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-WkCSAZFzPSOUyTCju-j54Q-1; Mon, 04 Sep 2023 07:53:11 -0400
X-MC-Unique: WkCSAZFzPSOUyTCju-j54Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5CB63810D23
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:10 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDB5F40C206F;
 Mon,  4 Sep 2023 11:53:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 04/52] ui/vc: replace vc_chr_write() with generic
 qemu_chr_write()
Date: Mon,  4 Sep 2023 15:52:01 +0400
Message-ID: <20230904115251.4161397-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

We shouldn't call the callback directly, but use the chardev API, unless
there is a clear reason.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230830093843.3531473-5-marcandre.lureau@redhat.com>
---
 ui/console.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 9c17024dbc..a448e4d283 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1169,13 +1169,13 @@ void kbd_put_keysym_console(QemuConsole *s, int keysym)
             *q++ = '[';
             *q++ = keysym & 0xff;
         } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
-            vc_chr_write(s->chr, (const uint8_t *) "\r", 1);
+            qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
             *q++ = '\n';
         } else {
             *q++ = keysym;
         }
         if (s->echo) {
-            vc_chr_write(s->chr, buf, q - buf);
+            qemu_chr_write(s->chr, buf, q - buf, true);
         }
         num_free = fifo8_num_free(&s->out_fifo);
         fifo8_push_all(&s->out_fifo, buf, MIN(num_free, q - buf));
@@ -2474,7 +2474,7 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
 
         s->t_attrib.bgcol = QEMU_COLOR_BLUE;
         msg = g_strdup_printf("%s console\r\n", chr->label);
-        vc_chr_write(chr, (uint8_t *)msg, strlen(msg));
+        qemu_chr_write(chr, (uint8_t *)msg, strlen(msg), true);
         g_free(msg);
         s->t_attrib = s->t_attrib_default;
     }
-- 
2.41.0


