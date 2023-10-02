Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C97B4F9C
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnFcn-0006b5-Fz; Mon, 02 Oct 2023 05:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnFcg-0006a9-6I
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnFce-0004bU-Hk
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696240429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kHQU2Oey3z1ckiRBzracDYuNVck1xkD9yvEzQmgy0Ig=;
 b=G2LhUPsd1z4Ll1C4esGl/ZHUN0JijUcg6EFycstiAKSZV9ZGlHIgtUcu1tW5XzqZHfNcmQ
 LdQaaRmooFbbxpSu7EuqSHiKSuDMmY/0jJjHd8JCs9xnGhV1JRaPEINjIhPxF42x+sVCAb
 Ri7r9y/SlrvF7Cx/39IA/G1QXPaR1QM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-3dizbd9DM3K5XtpyhtW3Bg-1; Mon, 02 Oct 2023 05:53:47 -0400
X-MC-Unique: 3dizbd9DM3K5XtpyhtW3Bg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a5d86705e4so1432279566b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 02:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696240426; x=1696845226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHQU2Oey3z1ckiRBzracDYuNVck1xkD9yvEzQmgy0Ig=;
 b=V1TnUHKHVWcU9vo7EamP+XqEB0yr9ye4+B/ILD+SPk2q9Hyn92NPC1yHgbUjWsdF5k
 hRJdvatVjsijF+xRGA6J7IVBczpzXB/WpLcMTrxYHNlEPUSc8PLizzGI7WJlwlc/yfiB
 4zaXooey0jbkV+85ZFrEXEz+VBV4CHnybaqI66g0UTsX06PntRV3P1Aepz9/QHRnnnY9
 l52DMOXOrQxpkReasSau/8Swp4HrcmY7Wx95dMZ9Mbzrgqloq4kTyfIfI38BBwwZkN27
 jjsZH7xNw+P4iBuquRXIidAPtOPXTPwImPEZbSq+afHmeNAi1toodHY9UR0OjqrRD6Cs
 bMaA==
X-Gm-Message-State: AOJu0YxBnpqdiq9tFJtCbSd9ALqWE2CBkR6MCDK+iP3bkGBwWKGA8I+h
 Yi+Up6k7VHJeRSTqCohPUt6iQd/l9sXT8aUGiMCCQtoAvzqfO2EbhYU6JF5ne1IXMe0Ta9H6Doi
 fGKFAd88xQ3vrKGHd0sNGR/9E2pZD7N1O0JQe/QPvzua0iGbB0/YR/BCWrKZcSxyyG36OJhMUoI
 4=
X-Received: by 2002:a17:906:104e:b0:9ae:4e81:4580 with SMTP id
 j14-20020a170906104e00b009ae4e814580mr10364429ejj.66.1696240425814; 
 Mon, 02 Oct 2023 02:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlcV/Av1fA8kjXUicZnvDMVqLkfnAEhyrQ4v0Ih8Be2YvL+tDsG0/vsbn8XKcxS+mqCkM9iA==
X-Received: by 2002:a17:906:104e:b0:9ae:4e81:4580 with SMTP id
 j14-20020a170906104e00b009ae4e814580mr10364409ejj.66.1696240425371; 
 Mon, 02 Oct 2023 02:53:45 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 a2-20020aa7cf02000000b005232ea6a330sm15261112edy.2.2023.10.02.02.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 02:53:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH] ui: fix dpy_ui_info_supported(con) assertion
Date: Mon,  2 Oct 2023 11:53:44 +0200
Message-ID: <20231002095344.64509-1-pbonzini@redhat.com>
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
 ui/gtk.c     | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

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
index e09f97a86b7..d8abdb1bdcc 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -724,18 +724,30 @@ static gboolean gd_window_close(GtkWidget *widget, GdkEvent *event,
 
 static void gd_set_ui_refresh_rate(VirtualConsole *vc, int refresh_rate)
 {
-    QemuUIInfo info;
+    QemuUIInfo *p_info, info;
 
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
-    QemuUIInfo info;
+    QemuUIInfo *p_info, info;
 
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


