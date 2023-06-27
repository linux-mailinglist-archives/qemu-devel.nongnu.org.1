Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C8D73FC7D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Lc-0008RE-5K; Tue, 27 Jun 2023 09:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LW-0008QY-GC
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LU-00070I-7t
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YuWEoa6I8zWS86cVN/kOltNgtawgnRHKNxC8RPd0s4=;
 b=cwUKFpu+C97dDAznuUrWoc/njeYORgDu/awVgLl61RCeFNefuXE3hzgKUs5/GeAZLWNDgW
 27tj2MCKX2MTAbZXP4zs0ZBEmNYieamhxKlr8Lvj6sBwCXIbPHT+gTcXT8RlcYs7EnbRRY
 nATqCROg+2oo05EaJiVXsTHD0IHL/dM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-lQW_KQcNPHu4QMGesQPCvA-1; Tue, 27 Jun 2023 09:02:52 -0400
X-MC-Unique: lQW_KQcNPHu4QMGesQPCvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 849AA18E5313;
 Tue, 27 Jun 2023 13:02:37 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 301E540C6CCD;
 Tue, 27 Jun 2023 13:02:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 02/33] egl: no need to lookup EGL functions manually
Date: Tue, 27 Jun 2023 15:01:59 +0200
Message-ID: <20230627130231.1614896-3-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

libepoxy handles loading the function pointer and dispatching the call,
so you don't have to worry about it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230515132455.1025608-1-marcandre.lureau@redhat.com>
---
 ui/egl-helpers.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 4203163ace..60385c1f48 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -439,10 +439,8 @@ static EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
 
     /* In practise any EGL 1.5 implementation would support the EXT extension */
     if (epoxy_has_egl_extension(NULL, "EGL_EXT_platform_base")) {
-        PFNEGLGETPLATFORMDISPLAYEXTPROC getPlatformDisplayEXT =
-            (void *) eglGetProcAddress("eglGetPlatformDisplayEXT");
-        if (getPlatformDisplayEXT && platform != 0) {
-            dpy = getPlatformDisplayEXT(platform, native, NULL);
+        if (platform != 0) {
+            dpy = eglGetPlatformDisplayEXT(platform, native, NULL);
         }
     }
 
-- 
2.41.0


