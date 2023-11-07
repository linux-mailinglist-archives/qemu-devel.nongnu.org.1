Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA17E37E9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:32:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IQX-0002dl-VV; Tue, 07 Nov 2023 04:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQR-0002cH-D0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQK-0003ZF-4t
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvxuGFPQ6ZWUTw94i9daQ6zLpWSIr54PibDJolNJ5y8=;
 b=iz/exWWBFP3By4q05R8oUHNc11tfGvQcri6gKWIMdjRK/73eJzS3/y5Uf8Rb61kY1Zgjde
 tHoPLENKvY8zZRFH8zqvsxi0veTEEdz0kSR2rwAVShdG5aCVLnXT5oPQcMjdvYGwx3Z0EQ
 oBZ4gSZxZZgEo7t99ZMo/fY8m0RXlsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-B7sisWSgN9qXzJivAkK_JQ-1; Tue, 07 Nov 2023 04:31:01 -0500
X-MC-Unique: B7sisWSgN9qXzJivAkK_JQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53822814088;
 Tue,  7 Nov 2023 09:31:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29D81143;
 Tue,  7 Nov 2023 09:30:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Mironov <mironov@fintech.ru>
Subject: [PULL 5/5] ui: Replacing pointer in function
Date: Tue,  7 Nov 2023 13:30:35 +0400
Message-ID: <20231107093035.2746581-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Sergey Mironov <mironov@fintech.ru>

At the end of the first if we see 'vc->gfx.surface = NULL;',
further checking of it is pointless. In the second if, ectx is taken.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Co-developed-by: Linux Verification Center <sdl.qemu@linuxtesting.org>
Signed-off-by: Sergey Mironov <mironov@fintech.ru>
Message-ID: <20231012104448.1251039-1-mironov@fintech.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 2a4c9b84ba..be047a41ad 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1400,7 +1400,7 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
             eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
             vc->gfx.esurface = NULL;
         }
-        if (vc->gfx.esurface) {
+        if (vc->gfx.ectx) {
             eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
             vc->gfx.ectx = NULL;
         }
-- 
2.41.0


