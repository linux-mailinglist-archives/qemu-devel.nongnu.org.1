Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E67916CC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8B3-00072B-EM; Mon, 04 Sep 2023 07:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Ab-0006Ve-3h
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AY-0000MN-RE
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ne/7j6le0wzOyvB/VuAUFxnOQk1uvQsIvzJaRXinX0=;
 b=YTuvrqu8s8ndFXZ1MmakoDn8/ewgXahgDOnLd/9vyrm4WvyigZQmBmMUNT8q0M6kUfXIBU
 /KYVWwfn2gAUDzDvFTcth7tKwaU8fnwGEP09yZf2/hjAhJ4DM0UR6GLX+30sWrXVjdDhYa
 e6BWvVBQnjCyEsA56Q4hyd30TE4Rr9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-B7N-ndzVPC2aep4YgqlVXA-1; Mon, 04 Sep 2023 07:55:00 -0400
X-MC-Unique: B7N-ndzVPC2aep4YgqlVXA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CDA9803F3A
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:00 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD68400F5A;
 Mon,  4 Sep 2023 11:54:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 32/52] ui/console: simplify getting active_console size
Date: Mon,  4 Sep 2023 15:52:29 +0400
Message-ID: <20230904115251.4161397-33-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

We can get the active console dimension regardless of its kind, by
simply giving NULL as argument. It will fallback with the given value
when the dimensions aren't known.

This will also allow to move the code in a separate unit more easily.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-33-marcandre.lureau@redhat.com>
---
 ui/console.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 5d521ba79d..70e11f924d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2577,10 +2577,8 @@ static void vc_chr_open(Chardev *chr,
     drv->console = s;
 
     if (QEMU_CONSOLE(s)->scanout.kind != SCANOUT_SURFACE) {
-        if (active_console && active_console->scanout.kind == SCANOUT_SURFACE) {
-            g_width = qemu_console_get_width(active_console, g_width);
-            g_height = qemu_console_get_height(active_console, g_height);
-        }
+        g_width = qemu_console_get_width(NULL, g_width);
+        g_height = qemu_console_get_height(NULL, g_height);
         QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(g_width, g_height);
         QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
     }
-- 
2.41.0


