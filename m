Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E55829894
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNWZp-0002a8-7D; Wed, 10 Jan 2024 06:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNWZm-0002ZF-T9
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNWZl-0007Ss-Ep
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704885408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MPi5QLbvAJvYm5CDS4bDTSfdB/ICs0cpDwBl7iy+UwE=;
 b=V8GSkxVk0wB7oyfoKYfQHA5FhyJ2yv0Vs4y5x2GlUvqPFhSOP27pbQs+Q9soW+HYoLLc/2
 s1IRUdO2ngpfrU9lNkOxZdSTFe6fuJ1AAiC5Nl2Mcjj9tRxli+0TG06rW0UT9IU95jeWY4
 2huvnwwjMCe1Ft6fDE+NAdbZOvo1334=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-ZNRaZ23oMD-lun-7llpmlw-1; Wed, 10 Jan 2024 06:16:47 -0500
X-MC-Unique: ZNRaZ23oMD-lun-7llpmlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EFE4185A780;
 Wed, 10 Jan 2024 11:16:47 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0A995012;
 Wed, 10 Jan 2024 11:16:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 jiangyegen <jiangyegen@huawei.com>
Subject: [PATCH] chardev: close QIOChannel before unref'ing
Date: Wed, 10 Jan 2024 11:16:44 +0000
Message-ID: <20240110111644.28294-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The chardev socket backend will unref the QIOChannel object while
it is still potentially open. When using TLS there could be a
pending TLS handshake taking place. If the channel is left open
then when the TLS handshake callback runs, it can end up accessing
free'd memory in the tcp_chr_tls_handshake method.

Closing the QIOChannel will unregister any pending handshake
source.

Reported-by: jiangyegen <jiangyegen@huawei.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 73947da188..7105753815 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -378,6 +378,10 @@ static void tcp_chr_free_connection(Chardev *chr)
                                  char_socket_yank_iochannel,
                                  QIO_CHANNEL(s->sioc));
     }
+
+    if (s->ioc) {
+        qio_channel_close(s->ioc, NULL);
+    }
     object_unref(OBJECT(s->sioc));
     s->sioc = NULL;
     object_unref(OBJECT(s->ioc));
-- 
2.43.0


