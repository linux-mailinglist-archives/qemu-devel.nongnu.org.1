Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70072419B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VKt-0001TH-GU; Tue, 06 Jun 2023 07:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKP-0000k3-S5
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKK-0005vZ-Tp
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxhwVzVRwljnUz15Fjsw4i2JV+aBvDRzU9xpCc326Bw=;
 b=M/SP8tVxAkmXKEnbHjMU4rgOD9BYcyFDegxsJ3j9HlFxdmwtYCYXMyb0O0SpbcB86ogda6
 y0vPMZBogKv+s3ApgOlXLiSW8DMO2rdZkuvIlPGmeBgX5Ag+XhqPdv6p7HNYplmsLwPjOX
 h758nHFCPEM0+zarhS2eqeP2oQmlcuQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-c6uYuGcvOC6YUUkIXPr5OQ-1; Tue, 06 Jun 2023 07:58:14 -0400
X-MC-Unique: c6uYuGcvOC6YUUkIXPr5OQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D45F1C01E9D
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:58:13 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E02251121314;
 Tue,  6 Jun 2023 11:58:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 13/21] ui/egl: default to GLES on windows
Date: Tue,  6 Jun 2023 15:56:50 +0400
Message-Id: <20230606115658.677673-14-marcandre.lureau@redhat.com>
In-Reply-To: <20230606115658.677673-1-marcandre.lureau@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Windows GL drivers are notoriously not very good. Otoh, ANGLE provides
rock solid GLES implementation on top of direct3d. We should recommend
it and default to ES when using EGL (users can easily override this if
necessary)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/egl-helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 4b29dda7ed..1c718b0b98 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -537,6 +537,10 @@ int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode)
 #ifdef WIN32
 int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode)
 {
+    /* prefer GL ES, as that's what ANGLE supports */
+    if (mode == DISPLAYGL_MODE_ON) {
+        mode = DISPLAYGL_MODE_ES;
+    }
     return qemu_egl_init_dpy(dpy, 0, mode);
 }
 #endif
-- 
2.40.1


