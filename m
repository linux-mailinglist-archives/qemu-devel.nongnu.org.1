Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED47EF4A3
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:36:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zwM-0004xh-GD; Fri, 17 Nov 2023 09:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zwD-0004t0-Qc
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zwC-0002hn-Cb
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700231714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLBqwjvUcOS5QccnJgFoGd65yOvgQ2CW1qiTbkByLqE=;
 b=THeqw67yHFa5zolRGBPLJwfkgZuJ8gqda072Hr+2M7nB/tqqmciqVWQTbR1GAoC2Ostkkb
 APilaJdN4APUHnhDdeJ6EQZx+cCAVpvkxo8n4IcCQe6zuRdiWb+8Qu6xsjTTQGG4MQRJGa
 axLaK8Pw9M62cbss2TBj68srWl7gqU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-8SmFsbGvMYGtbTf-Te2sxA-1; Fri, 17 Nov 2023 09:35:13 -0500
X-MC-Unique: 8SmFsbGvMYGtbTf-Te2sxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22B3085C6E0;
 Fri, 17 Nov 2023 14:35:13 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40319C0BDC0;
 Fri, 17 Nov 2023 14:35:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, dwmw@amazon.co.uk
Subject: [PATCH for-8.2 1/3] vl: revert behaviour for -display none
Date: Fri, 17 Nov 2023 18:35:03 +0400
Message-ID: <20231117143506.1521718-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
References: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

Commit 1bec1cc0d ("ui/console: allow to override the default VC") changed
the behaviour of the "-display none" option, so that it now creates a
QEMU monitor on the terminal. "-display none" should not be tangled up
with whether we create a monitor or a serial terminal; it should purely
and only disable the graphical window. Changing its behaviour like this
breaks command lines which, for example, use semihosting for their
output and don't want a graphical window, as they now get a monitor they
never asked for.

It also breaks the command line we document for Xen in
docs/system/i386/xen.html:

 $ ./qemu-system-x86_64 --accel kvm,xen-version=0x40011,kernel-irqchip=split \
    -display none -chardev stdio,mux=on,id=char0,signal=off -mon char0 \
    -device xen-console,chardev=char0  -drive file=${GUEST_IMAGE},if=xen

qemu-system-x86_64: cannot use stdio by multiple character devices
qemu-system-x86_64: could not connect serial device to character backend
'stdio'

When qemu is compiled without PIXMAN, by default the serials aren't
muxed with the monitor anymore on stdio. The serials are redirected to
"null" instead, and the monitor isn't set up.

Fixes: commit 1bec1cc0d ("ui/console: allow to override the default VC")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 5af7ced2a1..14bf0cf0bf 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1391,7 +1391,7 @@ static void qemu_create_default_devices(void)
         }
     }
 
-    if (nographic || (!vc && !is_daemonized() && isatty(STDOUT_FILENO))) {
+    if (nographic) {
         if (default_parallel) {
             add_device_config(DEV_PARALLEL, "null");
         }
-- 
2.41.0


