Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A78073FC62
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Le-0008SF-Tc; Tue, 27 Jun 2023 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lb-0008RF-4Z
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LX-00072f-1n
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BH5BpSpjKRT4vLbjNQw58r98+qZ4ELu7ZRZz3wXTis=;
 b=BErFOMIbQYCeUR6n4RiQswhXvedxeSsrmg3pRzN6cQaEs4+IyAbatylLzsTI0XMqEcIIuL
 cAEHi7BffB/Z+PaZvjWy5g5Xq1dOURHx1AzUT5l3tlWtFF6ChAksxNM13Clcv2HUH75Raw
 z1gWedM8d8Bj9CNOy3U7wwDA+KjMBr0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392--sX9zqhhONmAOqQ33drxPg-1; Tue, 27 Jun 2023 09:02:58 -0400
X-MC-Unique: -sX9zqhhONmAOqQ33drxPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59D4988D554;
 Tue, 27 Jun 2023 13:02:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB6D740C2063;
 Tue, 27 Jun 2023 13:02:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Zhang Huasen <huasenzhang@foxmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/33] chardev/char-win-stdio: Support VT sequences on Windows
 11 host
Date: Tue, 27 Jun 2023 15:02:02 +0200
Message-ID: <20230627130231.1614896-6-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

From: Zhang Huasen <huasenzhang@foxmail.com>

If the monitor or the serial port use STDIO as backend on Windows 11 host,
e.g. -nographic options is used, the monitor or the guest Linux do not
response to arrow keys.

When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is disabled
by default. Arrow keys cannot be retrieved by ReadFile or ReadConsoleInput
functions.

Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to SetConsoleMode,
when opening stdio console.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1674

Signed-off-by: Zhang Huasen <huasenzhang@foxmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <tencent_8DA57B405D427A560FD40F8FB0C0B1ADDE09@qq.com>
---
 chardev/char-win-stdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index eb830eabd9..1a18999e78 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
         }
     }
 
-    dwMode |= ENABLE_LINE_INPUT;
+    dwMode |= ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TERMINAL_INPUT;
 
     if (is_console) {
         /* set the terminal in raw mode */
-- 
2.41.0


