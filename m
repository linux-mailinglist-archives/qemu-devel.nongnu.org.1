Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D09007B4F9A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnFdg-0007CG-FH; Mon, 02 Oct 2023 05:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnFdd-00076a-HH
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnFda-0004lW-Uo
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696240489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FJDLRUVJaBhfpCQ8P7M/Fh+0LBnQJh6KJ8GiG+zb1QU=;
 b=HqTiT7kZLu7Eg0jR6+fbaN9J7L3bQln8JYSFtFfM6ncfXUvCayjsb76Ip32HeuwL9mjhuI
 tEpFZJUuQ6/VjpzP/0Q5dRE1M2iD7Cc3uhECmgNFPWZNoETugiNYmVW1YbRusZzoVwRIn1
 eX1tsksVTU17b7aq7am9KlY5QXS6jTg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-LmtoSbQaOU6iSmjQGhRpTQ-1; Mon, 02 Oct 2023 05:54:48 -0400
X-MC-Unique: LmtoSbQaOU6iSmjQGhRpTQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a9f282713fso1359940666b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 02:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696240487; x=1696845287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJDLRUVJaBhfpCQ8P7M/Fh+0LBnQJh6KJ8GiG+zb1QU=;
 b=mwU80yt8+TcFulJyd3rI8fWh7g26GpPdmUk0Wa0reQbuNmpy6aXwdApFMXfKKDWDZn
 CrHoAxcAvzHZvmMnyzX7KMMXTMXh5HVE6Wz/a8qckXriG82SmGvoqGuqrxGz4wnUWyq8
 EOboBSsEyGXBnqvsXoDW15mg0vcoo15hSeNciPdfiwybOE/RKwgvfqqsW88XOUOJIID5
 p8UixXOu7oUEK2SF6szhV90w7iHZyqxwlnhHMQZMkZieYElQ/kcjTxMMKpUKUrwB96fb
 DTdHONjjr3FY7R8eMSAzCEvNdl97D8DS1D9mrZ4eqXxQQcnN+XXHZyoGeni4ujKLoSNb
 6VHQ==
X-Gm-Message-State: AOJu0Yx0wurwtYmqUiyai/GY1ehloCNq8lfhsLE021tRe9HNaCMUa60r
 omhj3Wzjq5Mjy8ZJxSuyGqLbpypqNbRv4XDiWdd3BSRr+Q/xx7i4fTDEWtOjJOp/lBNHNn1C/9O
 6pToytIX3M0mBSePWeIboWIb+bdfJ0f+Xj/++2wD0dralOzkKw5tB5ohGrYAGR0+NNUNt1q5XUx
 U=
X-Received: by 2002:a17:907:7602:b0:9b2:b2ad:2a8f with SMTP id
 jx2-20020a170907760200b009b2b2ad2a8fmr8605215ejc.11.1696240486841; 
 Mon, 02 Oct 2023 02:54:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVd/xlbc4oxWGFInTQP1FTJnARX9mkZpLktXkhqcy7ctL/jtPLI97BIKa6PnH/hSgBqfhmxw==
X-Received: by 2002:a17:907:7602:b0:9b2:b2ad:2a8f with SMTP id
 jx2-20020a170907760200b009b2b2ad2a8fmr8605205ejc.11.1696240486432; 
 Mon, 02 Oct 2023 02:54:46 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 bu24-20020a170906a15800b0098669cc16b2sm16580411ejb.83.2023.10.02.02.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 02:54:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v2] ui: fix dpy_ui_info_supported(con) assertion
Date: Mon,  2 Oct 2023 11:54:45 +0200
Message-ID: <20231002095445.65311-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

VGA does not support getting the physical video size or refresh rate.
This is causing an assertion failure when the GTK+ user interface
calls dpy_get_ui_info().  Return NULL from dpy_get_ui_info() if the
information is not supported, and just ignore the request to set
refresh rate or size in that case.

While the assertion failure was introduced by commit a92e7bb4cad
("ui: add precondition for dpy_get_ui_info()", 2023-09-12), QEMU had
been using con->ui_info incorrectly since before.

Fixes: a92e7bb4cad ("ui: add precondition for dpy_get_ui_info()", 2023-09-12)
Fixes: aeffd071ed8 ("ui: Deliver refresh rate via QemuUIInfo", 2022-06-14)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/console.c |  4 +++-
 ui/gtk.c     | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 4a4f19ed33e..24438b187c8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -815,7 +815,9 @@ bool dpy_ui_info_supported(const QemuConsole *con)
 
 const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
 {
-    assert(dpy_ui_info_supported(con));
+    if (!dpy_ui_info_supported(con)) {
+        return NULL;
+    }
 
     if (con == NULL) {
         con = active_console;
diff --git a/ui/gtk.c b/ui/gtk.c
index e09f97a86b7..0b5e314cf0d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -724,18 +724,32 @@ static gboolean gd_window_close(GtkWidget *widget, GdkEvent *event,
 
 static void gd_set_ui_refresh_rate(VirtualConsole *vc, int refresh_rate)
 {
+    const QemuUIInfo *p_info;
     QemuUIInfo info;
 
-    info = *dpy_get_ui_info(vc->gfx.dcl.con);
+    p_info = dpy_get_ui_info(vc->gfx.dcl.con);
+    if (!p_info) {
+        /* not supported by guest */
+        return;
+    }
+
+    info = *p_info;
     info.refresh_rate = refresh_rate;
     dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
 }
 
 static void gd_set_ui_size(VirtualConsole *vc, gint width, gint height)
 {
+    const QemuUIInfo *p_info;
     QemuUIInfo info;
 
-    info = *dpy_get_ui_info(vc->gfx.dcl.con);
+    p_info = dpy_get_ui_info(vc->gfx.dcl.con);
+    if (!p_info) {
+        /* not supported by guest */
+        return;
+    }
+
+    info = *p_info;
     info.width = width;
     info.height = height;
     dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
-- 
2.41.0


