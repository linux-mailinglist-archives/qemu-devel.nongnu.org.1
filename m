Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD37E1B1E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:26:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztxl-0001g3-5M; Mon, 06 Nov 2023 02:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztxf-0001fr-SE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztxd-0006LF-AE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zr8zAotEqX1zZhbLTs985HQlzifY6ujW9QIdplWN7/g=;
 b=jOZbA87rZQi28Bf5Qf4kebfBixHMAxemDLlAyUHg48IqpqXcM3qtu4Phav4STrWrjqfe11
 OOH3tK5H6FcEHH1ln8S496nKkzKcMfrDWyK/Py3fjK4VSJzHg8JztTsgaa0pyNZTcsLj4r
 rPRxPu0UfLBZyy3qtxHEpUKPJ0LBrBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-t7fr_YfZP3COgWXGlVzIyA-1; Mon, 06 Nov 2023 02:23:46 -0500
X-MC-Unique: t7fr_YfZP3COgWXGlVzIyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91CB7831523;
 Mon,  6 Nov 2023 07:23:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 829881C060AE;
 Mon,  6 Nov 2023 07:23:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/23] vl: simplify display_remote logic
Date: Mon,  6 Nov 2023 11:22:56 +0400
Message-ID: <20231106072313.1742543-8-marcandre.lureau@redhat.com>
In-Reply-To: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
References: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Bump the display_remote variable when the -vnc option is parsed, just
like -spice.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 system/vl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 19aef762e4..e9819408df 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1401,11 +1401,6 @@ static void qemu_create_default_devices(void)
 #endif
     }
 
-#if defined(CONFIG_VNC)
-    if (!QTAILQ_EMPTY(&(qemu_find_opts("vnc")->head))) {
-        display_remote++;
-    }
-#endif
     if (dpy.type == DISPLAY_TYPE_DEFAULT && !display_remote) {
         if (!qemu_display_find_default(&dpy)) {
             dpy.type = DISPLAY_TYPE_NONE;
@@ -3350,6 +3345,7 @@ void qemu_init(int argc, char **argv)
 #ifdef CONFIG_VNC
             case QEMU_OPTION_vnc:
                 vnc_parse(optarg);
+                display_remote++;
                 break;
 #endif
             case QEMU_OPTION_no_acpi:
-- 
2.41.0


