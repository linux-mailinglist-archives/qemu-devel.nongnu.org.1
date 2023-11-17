Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C17EF44E
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:19:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zfF-0005kO-Sd; Fri, 17 Nov 2023 09:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zfD-0005kB-3b
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zfB-0003Kx-DX
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700230660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8dv+Bl8k9ZxpBnkSncSYj/0g8+1bisNRfWCEq5CXa+k=;
 b=VsKxFL+0US3KidtkShGY1jUttJHibBGupzhcH5OGYTuRJzPGivVLALdaZaxCfl0os7KeNo
 Ezn39ptFJfhk36hDH2czJAIUdj8LF9ZYQ17j5AsMq73S3en7qAPgbhUH0pLmveynWVQImm
 PJjwlPnYIsrJnwgwlN4wUO1WEZt2cOk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-f5TXPjxIMNm8YdskO0Sk2g-1; Fri,
 17 Nov 2023 09:17:38 -0500
X-MC-Unique: f5TXPjxIMNm8YdskO0Sk2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A473380664A
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 14:17:38 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 982BC2026D4C;
 Fri, 17 Nov 2023 14:17:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] vl: add missing display_remote++
Date: Fri, 17 Nov 2023 18:17:35 +0400
Message-ID: <20231117141735.1511211-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We should also consider -display vnc= as setting up a remote display,
and not attempt to add another default one.

The display_remote++ in qemu_setup_display() isn't necessary at this
point, but is there for completeness and further usages of the variable.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 5af7ced2a1..f95ae77b5a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1110,6 +1110,7 @@ static void parse_display(const char *p)
          */
         if (*opts == '=') {
             vnc_parse(opts + 1);
+            display_remote++;
         } else {
             error_report("VNC requires a display argument vnc=<display>");
             exit(1);
@@ -1359,6 +1360,7 @@ static void qemu_setup_display(void)
             dpy.type = DISPLAY_TYPE_NONE;
 #if defined(CONFIG_VNC)
             vnc_parse("localhost:0,to=99,id=default");
+            display_remote++;
 #endif
         }
     }
-- 
2.41.0


