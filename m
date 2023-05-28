Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B988971399C
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKD-0007Zb-8G; Sun, 28 May 2023 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GK6-0007XI-U5
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GK5-00082p-F6
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeB0i35BJVHLQClnr5fhag95I05kqA8k4ibHNET9Ee0=;
 b=PuIbkZnqMOyy3TFUwmMfIkLomFWu4vfEvkG/cqW6OcvwJAGrRCk5Ho/AMpPdrXQ3u4ZVmg
 cJc10j6jjR1ZdKzc2StPuUd+QNCyp1/OgLHvJSX5QpR5cJDEFZQJLdDNnGiNnMAYVyyE9D
 258r20V8o0/DyWac2A/hD6b5ylqSicQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-Cu3cHspBNSSi07BCrDGsMA-1; Sun, 28 May 2023 09:20:34 -0400
X-MC-Unique: Cu3cHspBNSSi07BCrDGsMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F951811E78;
 Sun, 28 May 2023 13:20:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63194112132C;
 Sun, 28 May 2023 13:20:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Erico Nunes <ernunes@redhat.com>
Subject: [PULL 03/19] ui/gtk-egl: fix scaling for cursor position in scanout
 mode
Date: Sun, 28 May 2023 17:20:00 +0400
Message-Id: <20230528132016.3218152-4-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

From: Erico Nunes <ernunes@redhat.com>

vc->gfx.w and vc->gfx.h are not updated appropriately in this code path,
which leads to a different scaling factor for rendering the cursor on
some edge cases (e.g. the focus has left and re-entered the gtk window).
This can be reproduced using vhost-user-gpu with the gtk ui on the x11
backend.
Use the surface dimensions which are already updated accordingly.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230320160856.364319-2-ernunes@redhat.com>
---
 ui/gtk-egl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 557668e418..19130041bc 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -88,8 +88,8 @@ void gd_egl_draw(VirtualConsole *vc)
 #endif
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
 
-        vc->gfx.scale_x = (double)ww / vc->gfx.w;
-        vc->gfx.scale_y = (double)wh / vc->gfx.h;
+        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
+        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
 
         glFlush();
 #ifdef CONFIG_GBM
-- 
2.40.1


