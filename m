Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B773C713990
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKG-0007b7-CE; Sun, 28 May 2023 09:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKC-0007aO-2n
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKA-00084N-6t
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpvPBcShRkyJ+2h3vZMKhYnEn+ZEWfxFamhs6fV9SZY=;
 b=Ga8YceF/vUoI8beUqH8lc+24pWgMdas/KXhbDkrdpzn0lAzWUrbzcf8e2O1NE8LImWw6P6
 Lp8QNjt3JiYWAYlw4tVUSmCG8Sy5xTWLqaYApFmYqEE4D7Zzw9dNO1LppFkLZnqOeQLwGF
 EFHq8IGgjsL4iAaJTzXq1AI/u6hhjIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-a6gDMBKZO5C2L6777HESNA-1; Sun, 28 May 2023 09:20:38 -0400
X-MC-Unique: a6gDMBKZO5C2L6777HESNA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9AD9800BFF;
 Sun, 28 May 2023 13:20:37 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 110B0492B0A;
 Sun, 28 May 2023 13:20:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 04/19] ui/sdl2: fix surface_gl_update_texture: Assertion 'gls'
 failed
Date: Sun, 28 May 2023 17:20:01 +0400
Message-Id: <20230528132016.3218152-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Before sdl2_gl_update() is called, sdl2_gl_switch() may decide to
destroy the console window and its associated shaders.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1644
Fixes: c84ab0a500a8 ("ui/console: optionally update after gfx switch")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-Id: <20230511074217.4171842-1-marcandre.lureau@redhat.com>
---
 ui/sdl2-gl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 39cab8cde7..bbfa70eac3 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
 
     assert(scon->opengl);
 
+    if (!scon->real_window) {
+        return;
+    }
+
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
     surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
     scon->updates++;
-- 
2.40.1


