Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A53FDA25A34
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 13:58:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tew1P-00062g-RA; Mon, 03 Feb 2025 07:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tew1M-00062Q-LQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:57:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tew1D-0006mm-Br
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738587458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+LaoUrRRVG9yVzSBnkrgllxqKCLRevJdbW6h/G6DWo=;
 b=GnVbu1sw7Ghvz9kyFHlhJlqPGfUrop9XsdDUDf0D18Xz8wUF0a0ymmWMQXIT+6NZ29FV6d
 92urh7NLppvEvVeze4YjEtQ+5cbm65DYd5lUNbxaxjI+R/NLwVuavoNFn5KMV4Vr5dF53M
 m+99Fjm0I9mppxpl4Kf4vmMZkZHQIgU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-l9wKKQAaMAq6-q9_0Mx2fA-1; Mon,
 03 Feb 2025 07:57:35 -0500
X-MC-Unique: l9wKKQAaMAq6-q9_0Mx2fA-1
X-Mimecast-MFC-AGG-ID: l9wKKQAaMAq6-q9_0Mx2fA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 362D619560B7; Mon,  3 Feb 2025 12:57:33 +0000 (UTC)
Received: from localhost (unknown [10.39.208.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60B1730001BE; Mon,  3 Feb 2025 12:57:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org,
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Penyaev <r.peniaev@gmail.com>
Subject: [PULL 1/8] chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
Date: Mon,  3 Feb 2025 16:57:13 +0400
Message-ID: <20250203125721.640451-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250203125721.640451-1-marcandre.lureau@redhat.com>
References: <20250203125721.640451-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Roman Penyaev <r.peniaev@gmail.com>

Change makes code symmetric to the code, which handles
the "connected" state, i.e. send CHR_EVENT_CLOSED when
state changes from "connected" to "disconnected".

This behavior is similar to char-socket, for example.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Reviewed-by: "Alex Bennée" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Message-ID: <20250123085327.965501-2-r.peniaev@gmail.com>
---
 chardev/char-pty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cbb21b76ae..6a2c1dc13a 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -181,6 +181,9 @@ static void pty_chr_state(Chardev *chr, int connected)
 
     if (!connected) {
         remove_fd_in_watch(chr);
+        if (s->connected) {
+            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        }
         s->connected = 0;
         /* (re-)connect poll interval for idle guests: once per second.
          * We check more frequently in case the guests sends data to
@@ -215,7 +218,6 @@ static void char_pty_finalize(Object *obj)
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
 #if defined HAVE_PTY_H
-- 
2.47.0


