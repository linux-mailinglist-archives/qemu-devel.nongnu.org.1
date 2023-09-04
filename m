Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F27916C8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8B9-0007hz-Qn; Mon, 04 Sep 2023 07:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Ai-0006tp-UL
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Ag-0000YH-RJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2rNjEp/JzIVt97SxAZIimLer1BY0QFgisrshHK2Peg=;
 b=CjXKEcsVWStr/+1ZKvVnKshdvqviGqz3lfY3pnIXTJF9dv0RcuQhP7i/feIPfqAbIKsoCH
 aigANfuW/prZCbZTiG+5CV8vYs8Yyxa1q+ffRJtfKpJ3ponWU181SHyoDlKauJKRpPLVPd
 V1RmWYGA2PdK3JjtNUCmUlwOBO2KD30=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-n28heJ7API2nCMLXz0yP_w-1; Mon, 04 Sep 2023 07:55:07 -0400
X-MC-Unique: n28heJ7API2nCMLXz0yP_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AA0F3810D2B
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:07 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A12B440C84A6;
 Mon,  4 Sep 2023 11:55:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 34/52] ui/vc: use common text console surface creation
Date: Mon,  4 Sep 2023 15:52:31 +0400
Message-ID: <20230904115251.4161397-35-marcandre.lureau@redhat.com>
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-35-marcandre.lureau@redhat.com>
---
 ui/console.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index a3fd1c5059..3d884956b7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2569,18 +2569,13 @@ static void vc_chr_open(Chardev *chr,
         height = qemu_console_get_height(NULL, 24 * FONT_HEIGHT);
     } else {
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
-        QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
-        QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(width, height);
     }
 
+    dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
+
     s->chr = chr;
     drv->console = s;
 
-    if (QEMU_CONSOLE(s)->scanout.kind != SCANOUT_SURFACE) {
-        QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(width, height);
-        QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
-    }
-
     /* set current text attributes to default */
     drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     text_console_resize(s);
-- 
2.41.0


