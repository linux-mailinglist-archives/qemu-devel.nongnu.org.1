Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC367730A9
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT78d-00056p-56; Mon, 07 Aug 2023 16:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78Z-00056N-QF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78Y-0006a2-AH
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691441253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTiargiIHnOWuLXbyhF4rrzgv/ceuQWlIyOsdopXpTc=;
 b=BZbQWTIL6xwjSWz6N7LLXLFBMj1IMkCo9C2ZAt97zYf3yRWj5LimsSLGux+VGGCdHJaWWd
 qrX7qf0pVe6EiF2eeC2LpugjbHaRSFc+lMXcdXHIzd7HOJOUb9x8IRROdykCle6c5+vqkk
 aegGNLdgaRUvOqG5TAz1WGgLgev/QbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-n5eNEDQ_MvSkgbYOM40Iag-1; Mon, 07 Aug 2023 16:47:30 -0400
X-MC-Unique: n5eNEDQ_MvSkgbYOM40Iag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F5DC8DC664;
 Mon,  7 Aug 2023 20:47:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE73492C13;
 Mon,  7 Aug 2023 20:47:28 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/6] chardev: report the handshake error
Date: Tue,  8 Aug 2023 00:47:12 +0400
Message-ID: <20230807204717.2483983-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
References: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

This can help to debug connection issues.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=2196182

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230510072531.3937189-1-marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8c58532171..e8e3a743d5 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -742,8 +742,12 @@ static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_data)
 {
     Chardev *chr = user_data;
     SocketChardev *s = user_data;
+    Error *err = NULL;
 
-    if (qio_task_propagate_error(task, NULL)) {
+    if (qio_task_propagate_error(task, &err)) {
+        error_reportf_err(err,
+                          "websock handshake of character device %s failed: ",
+                          chr->label);
         tcp_chr_disconnect(chr);
     } else {
         if (s->do_telnetopt) {
@@ -778,8 +782,12 @@ static void tcp_chr_tls_handshake(QIOTask *task,
 {
     Chardev *chr = user_data;
     SocketChardev *s = user_data;
+    Error *err = NULL;
 
-    if (qio_task_propagate_error(task, NULL)) {
+    if (qio_task_propagate_error(task, &err)) {
+        error_reportf_err(err,
+                          "TLS handshake of character device %s failed: ",
+                          chr->label);
         tcp_chr_disconnect(chr);
     } else {
         if (s->is_websock) {
-- 
2.41.0


