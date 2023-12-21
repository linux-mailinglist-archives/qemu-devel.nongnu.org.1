Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8419C81C01F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:28:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQXf-0002kp-68; Thu, 21 Dec 2023 16:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXM-0001ov-Jd
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:25:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXK-0008GS-Rc
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UZHNff/BCIVKRkdzo6ebK9H1VCBnQ5pKLjjOUrZ15o=;
 b=GmsW1WJkj/0WhzJz6dY0lfeVXKQgxFlIBFCfrG0AvIdfvBcRSmqUh7D1aXIISChtd6JbuT
 9vkC1AVxrNxuyCWi/cVWA9BGtBBB0kS1jCc2Ef3EnnLneRRoYoHnHwsYKZh4hmK3d+scxu
 Ky29SqIgWsborDob7Dqy7H8Sjc861l8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-ove6nwM9OOOgQVr6W6Q_-A-1; Thu,
 21 Dec 2023 16:24:56 -0500
X-MC-Unique: ove6nwM9OOOgQVr6W6Q_-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AF5F3C1E9D1;
 Thu, 21 Dec 2023 21:24:56 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 890BFC15968;
 Thu, 21 Dec 2023 21:24:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 29/33] block-coroutine-wrapper: use
 qemu_get_current_aio_context()
Date: Thu, 21 Dec 2023 22:23:34 +0100
Message-ID: <20231221212339.164439-30-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Use qemu_get_current_aio_context() in mixed wrappers and coroutine
wrappers so that code runs in the caller's AioContext instead of moving
to the BlockDriverState's AioContext. This change is necessary for the
multi-queue block layer where any thread can call into the block layer.

Most wrappers are IO_CODE where it's safe to use the current AioContext
nowadays. BlockDrivers and the core block layer use their own locks and
no longer depend on the AioContext lock for thread-safety.

The bdrv_create() wrapper invokes GLOBAL_STATE code. Using the current
AioContext is safe because this code is only called with the BQL held
from the main loop thread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230912231037.826804-6-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/block-coroutine-wrapper.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index c9c09fcacd..dbbde99e39 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -92,8 +92,6 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
                                  f"{self.name}")
             self.target_name = f'{subsystem}_{subname}'
 
-        self.ctx = self.gen_ctx()
-
         self.get_result = 's->ret = '
         self.ret = 'return s.ret;'
         self.co_ret = 'return '
@@ -167,7 +165,7 @@ def create_mixed_wrapper(func: FuncDecl) -> str:
         {func.co_ret}{name}({ func.gen_list('{name}') });
     }} else {{
         {struct_name} s = {{
-            .poll_state.ctx = {func.ctx},
+            .poll_state.ctx = qemu_get_current_aio_context(),
             .poll_state.in_progress = true,
 
 { func.gen_block('            .{name} = {name},') }
@@ -191,7 +189,7 @@ def create_co_wrapper(func: FuncDecl) -> str:
 {func.return_type} {func.name}({ func.gen_list('{decl}') })
 {{
     {struct_name} s = {{
-        .poll_state.ctx = {func.ctx},
+        .poll_state.ctx = qemu_get_current_aio_context(),
         .poll_state.in_progress = true,
 
 { func.gen_block('        .{name} = {name},') }
-- 
2.43.0


