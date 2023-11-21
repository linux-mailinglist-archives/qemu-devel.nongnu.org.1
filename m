Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D87F2AD2
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OBS-0007eE-T0; Tue, 21 Nov 2023 05:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBR-0007da-4c
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBP-0003GS-JE
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700563243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axn6nnTAUbHi2JFtucXKIDiamPS3DqXPTcu4AQADkEw=;
 b=fTGW6tXIMQ2LRn17nKoPOsKpBKbo9qVTOHjee+YhvW+oxncmLlqKLhvDOnSMuqiDpm7iBi
 64+4LHbocgpPTCgTOTjiZQTv/wvQxp7x6KZ6sqcw+fd3Kv1i9FANMsGmt8pyd5Ld6nPruO
 jrwERR5pxuDMqUSPIb8XTtfzNCPGcCA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-QLCkeohSP4qso8SJAZy4Tg-1; Tue,
 21 Nov 2023 05:40:39 -0500
X-MC-Unique: QLCkeohSP4qso8SJAZy4Tg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0322A3C100C4;
 Tue, 21 Nov 2023 10:40:39 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46AC0492BE7;
 Tue, 21 Nov 2023 10:40:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org, dwmw@amazon.co.uk
Subject: [PULL 4/5] vl: add missing display_remote++
Date: Tue, 21 Nov 2023 14:40:19 +0400
Message-ID: <20231121104020.2209345-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
References: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

We should also consider -display vnc= as setting up a remote display,
and not attempt to add another default one.

The display_remote++ in qemu_setup_display() isn't necessary at this
point, but is there for completeness and further usages of the variable.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1988
Fixes: commit 484629fc81 ("vl: simplify display_remote logic ")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 14bf0cf0bf..da2654aa77 100644
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
2.42.0


