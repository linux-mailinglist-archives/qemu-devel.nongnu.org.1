Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D693713998
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKq-0008Ic-8y; Sun, 28 May 2023 09:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKo-0008Cr-A7
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKm-0008Fd-Pa
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRgd2WXcnIcnRx9qqnV/t9M2085ej0NQRFuRwFwUoqU=;
 b=eWp9OfLI9MaF+0O1z6WarSEtsfoT2DG5D7xFvZrmSJW6sBk8psGweqmmF9YIscae4oGVYI
 ojjdrGbgci4gcJLr/C3pIPrDzZrBVysdjmkjLknIb2XncXRSI9GSnwPFGiskOLrt9W93hs
 yyrBUM13UW2fXyBj7Z0o/MQwqjMXtJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-bioQ2JOMNm6GiU5av0perQ-1; Sun, 28 May 2023 09:21:15 -0400
X-MC-Unique: bioQ2JOMNm6GiU5av0perQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01512800B2A;
 Sun, 28 May 2023 13:21:15 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4630C53BB;
 Sun, 28 May 2023 13:21:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: [PULL 13/19] ui/cursor: make width/height unsigned 16-bit integer
Date: Sun, 28 May 2023 17:20:10 +0400
Message-Id: <20230528132016.3218152-14-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Mauro Matteo Cascella <mcascell@redhat.com>

Although not actually exploitable at the moment, a negative width/height
could make datasize wrap around and potentially lead to buffer overflow.
Since there is no reason a negative width/height is ever appropriate,
modify QEMUCursor struct and cursor_alloc prototype to accept uint16_t.
This protects us against accidentally introducing future bugs.

Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Jacek Halon <jacek.halon@gmail.com>
Reported-by: Yair Mizrahi <yairh33@gmail.com>
Reported-by: Elsayed El-Refa'ei <e.elrefaei99@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230523163023.608121-1-mcascell@redhat.com>
---
 include/ui/console.h | 4 ++--
 ui/cursor.c          | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 2a8fab091f..ae5ec466c1 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
 
 /* cursor data format is 32bit RGBA */
 typedef struct QEMUCursor {
-    int                 width, height;
+    uint16_t            width, height;
     int                 hot_x, hot_y;
     int                 refcount;
     uint32_t            data[];
 } QEMUCursor;
 
-QEMUCursor *cursor_alloc(int width, int height);
+QEMUCursor *cursor_alloc(uint16_t width, uint16_t height);
 QEMUCursor *cursor_ref(QEMUCursor *c);
 void cursor_unref(QEMUCursor *c);
 QEMUCursor *cursor_builtin_hidden(void);
diff --git a/ui/cursor.c b/ui/cursor.c
index 6fe67990e2..29717b3ecb 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -90,11 +90,12 @@ QEMUCursor *cursor_builtin_left_ptr(void)
     return cursor_parse_xpm(cursor_left_ptr_xpm);
 }
 
-QEMUCursor *cursor_alloc(int width, int height)
+QEMUCursor *cursor_alloc(uint16_t width, uint16_t height)
 {
     QEMUCursor *c;
     size_t datasize = width * height * sizeof(uint32_t);
 
+    /* Modern physical hardware typically uses 512x512 sprites */
     if (width > 512 || height > 512) {
         return NULL;
     }
-- 
2.40.1


