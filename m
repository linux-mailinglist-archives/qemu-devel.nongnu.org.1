Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B987EFB3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Mar 2024 19:25:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHeP-0002DP-2U; Mon, 18 Mar 2024 14:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmHeH-0002Cx-Vi
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmHeB-0003jS-SY
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710786222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWv0N87mex1mgDV6ALULC06NKBETKhw3uvoJ4y4Jqkg=;
 b=UEuefUka0y+cY6vrjcyEdSy02TrshyAKS18R/dXl1gVOlEZ34rgCvUQZAPeEVb6CwlM3ci
 zmKgk0tn8ZQcLNY5wLrWgEpFmFFlKepWAEfa8AsTZ8L9NgIu/9QIEve0tYfgXGDDmEQZl4
 LFf6tZVx7o6rey41Ppj28vfvpjHkawE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-CAXZNPMfOzad0pp12XJ0Fw-1; Mon, 18 Mar 2024 14:23:40 -0400
X-MC-Unique: CAXZNPMfOzad0pp12XJ0Fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 291A81869D0C
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 18:23:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 956DF17AAF;
 Mon, 18 Mar 2024 18:23:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3 for 9.0] Revert "chardev/char-socket: Fix TLS io channels
 sending too much data to the backend"
Date: Mon, 18 Mar 2024 18:23:29 +0000
Message-ID: <20240318182330.96738-3-berrange@redhat.com>
In-Reply-To: <20240318182330.96738-1-berrange@redhat.com>
References: <20240318182330.96738-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit results in unexpected termination of the TLS connection.
When 'fd_can_read' returns 0, the code goes on to pass a zero length
buffer to qio_channel_read. The TLS impl calls into gnutls_recv()
with this zero length buffer, at which point GNUTLS returns an error
GNUTLS_E_INVALID_REQUEST. This is treated as fatal by QEMU's TLS code
resulting in the connection being torn down by the chardev.

Simply skipping the qio_channel_read when the buffer length is zero
is also not satisfactory, as it results in a high CPU burn busy loop
massively slowing QEMU's functionality.

The proper solution is to avoid tcp_chr_read being called at all
unless the frontend is able to accept more data. This will be done
in a followup commit.

This reverts commit 1907f4d149c3589ade641423c6a33fd7598fa4d3.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 2c4dffc0e6..812d7aa38a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -496,9 +496,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
         s->max_size <= 0) {
         return TRUE;
     }
-    len = tcp_chr_read_poll(opaque);
-    if (len > sizeof(buf)) {
-        len = sizeof(buf);
+    len = sizeof(buf);
+    if (len > s->max_size) {
+        len = s->max_size;
     }
     size = tcp_chr_recv(chr, (void *)buf, len);
     if (size == 0 || (size == -1 && errno != EAGAIN)) {
-- 
2.43.0


