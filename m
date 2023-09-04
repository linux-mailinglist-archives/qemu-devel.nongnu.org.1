Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE27916E8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8AQ-0004bW-9Z; Mon, 04 Sep 2023 07:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89x-0003kR-Fe
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89s-0008V9-2s
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32tRFRNvqpEJxCD+paAVvnT45LuqWDgt2Wm+WG8loTk=;
 b=Hs9DJxpFLK8ikdQtQcEPU9ApW0YdGlEakLSjSUQJLHp1Rg5im5W7rxntxjZYjhWDRjDQQj
 ErVRH2jtJW6cfomK6FnpQCj11sNdCr3VGGmiWJSiD6WfqyJtRtzO8Fgoc55G1shx1bcVmC
 IqLsToq54K3UZl5buMQCpDCqWXGuevo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-7yGiUav5OWeOG0gnZZWBOw-1; Mon, 04 Sep 2023 07:54:18 -0400
X-MC-Unique: 7yGiUav5OWeOG0gnZZWBOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0882803F3A
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2357140E963;
 Mon,  4 Sep 2023 11:54:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 21/52] ui/console: register the console from qemu_console_init()
Date: Mon,  4 Sep 2023 15:52:18 +0400
Message-ID: <20230904115251.4161397-22-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-22-marcandre.lureau@redhat.com>
---
 ui/console.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index dd8e8db525..02a24eaf5d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1366,6 +1366,7 @@ qemu_console_init(Object *obj)
     qemu_co_queue_init(&c->dump_queue);
     c->ds = ds;
     c->window_id = -1;
+    qemu_console_register(c);
 }
 
 static void
@@ -1419,8 +1420,6 @@ static QemuConsole *new_console(const char *typename,
     QemuConsole *c = QEMU_CONSOLE(object_new(typename));
 
     c->head = head;
-    /* TODO: move to console_init() once there is a type hierarchy */
-    qemu_console_register(c);
 
     return c;
 }
-- 
2.41.0


