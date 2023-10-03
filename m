Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C0B7B691D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneda-0006lK-39; Tue, 03 Oct 2023 08:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedV-0006kQ-QT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedS-0000Km-VE
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o34PMiMbxJi+qbJ/XcjEASoRlg0j6gl4nUI/wxQ5YE=;
 b=AQCwFfqmKzYevaV/nER4C5tLOOACDBFauiRKr9GqpMn0YI8FijXAouqsgZvSA72/6JCB86
 xTYUXIUTJTJ7fIFdDdjSKwReDrMrbZY1RY4zXnMsPrIIG2Ezypq8yUopfgz/1kfhoySTt6
 Xmf2sxqVd0zwfRbxWg+sbum5qwFfH+Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-0IEuLQW5NFSTb-QiH3Iq3g-1; Tue, 03 Oct 2023 08:36:21 -0400
X-MC-Unique: 0IEuLQW5NFSTb-QiH3Iq3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A987E3816C8F
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 12:36:20 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98A3C2156A27;
 Tue,  3 Oct 2023 12:36:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 08/13] ui/gtk: fix UI info precondition
Date: Tue,  3 Oct 2023 16:35:37 +0400
Message-ID: <20231003123543.1360795-9-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

dpy_get_ui_info() shouldn't be called if the underlying GPU doesn't
support it.

Before the assert() was added and the regression introduced, GTK code
used to get "zero" UI info, for ex with a simple VGA device. The assert
was added to prevent from calling when there are no console too. The
other display backend that calls dpy_get_ui_info() correctly checks that
pre-condition.

Calling dpy_set_ui_info() is "safe" in this case, it will simply return
an error that can be generally ignored.

Fixes: commit a92e7bb4c ("ui: add precondition for dpy_get_ui_info()")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index cd3b8953cd..935de1209b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -726,6 +726,10 @@ static void gd_set_ui_refresh_rate(VirtualConsole *vc, int refresh_rate)
 {
     QemuUIInfo info;
 
+    if (!dpy_ui_info_supported(vc->gfx.dcl.con)) {
+        return;
+    }
+
     info = *dpy_get_ui_info(vc->gfx.dcl.con);
     info.refresh_rate = refresh_rate;
     dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
@@ -735,6 +739,10 @@ static void gd_set_ui_size(VirtualConsole *vc, gint width, gint height)
 {
     QemuUIInfo info;
 
+    if (!dpy_ui_info_supported(vc->gfx.dcl.con)) {
+        return;
+    }
+
     info = *dpy_get_ui_info(vc->gfx.dcl.con);
     info.width = width;
     info.height = height;
-- 
2.41.0


