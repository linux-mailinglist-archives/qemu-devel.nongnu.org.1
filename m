Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1397A215C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3Z-0000Xs-3Z; Fri, 15 Sep 2023 10:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3N-0000JE-Rt
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3L-00055p-ED
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1ZNFh4cyyiQUdJMOtCof5P3KhhngdZUdVDGwlRANFc=;
 b=axYeoBYu8vfEzKxvaBw4qTkwYmBEYSBjOY6rx5BNqYHg6mHCmdWkbi4mPCi6paR/nbbCIM
 wQCGiQ70RwG0Fi/W83LFsKRhwAFEtVYy/4dnOXjU7a4+c7aKkjDTdokmfIWn34l3ui2Dz2
 TlJJrsRsUoUQyEtU2yagRWbb+bXrSjs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-x1wgglk5NJ2_ze4ISrHziQ-1; Fri, 15 Sep 2023 10:44:12 -0400
X-MC-Unique: x1wgglk5NJ2_ze4ISrHziQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1FB8955977;
 Fri, 15 Sep 2023 14:44:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B9C72026D68;
 Fri, 15 Sep 2023 14:44:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 28/28] block-coroutine-wrapper: use
 qemu_get_current_aio_context()
Date: Fri, 15 Sep 2023 16:43:44 +0200
Message-ID: <20230915144344.238596-29-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The output of qemu-iotests 051 is sensitive to event loop activity.
Update the output because the monitor BH runs at a different time,
causing prompts to be printed differently in the output.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230912231037.826804-6-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/block-coroutine-wrapper.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index 685d0b4ed4..66cda6b8db 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -91,8 +91,6 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
                 raise ValueError(f"no_co function can't be rdlock: {self.name}")
             self.target_name = f'{subsystem}_{subname}'
 
-        self.ctx = self.gen_ctx()
-
         self.get_result = 's->ret = '
         self.ret = 'return s.ret;'
         self.co_ret = 'return '
@@ -166,7 +164,7 @@ def create_mixed_wrapper(func: FuncDecl) -> str:
         {func.co_ret}{name}({ func.gen_list('{name}') });
     }} else {{
         {struct_name} s = {{
-            .poll_state.ctx = {func.ctx},
+            .poll_state.ctx = qemu_get_current_aio_context(),
             .poll_state.in_progress = true,
 
 { func.gen_block('            .{name} = {name},') }
@@ -190,7 +188,7 @@ def create_co_wrapper(func: FuncDecl) -> str:
 {func.return_type} {func.name}({ func.gen_list('{decl}') })
 {{
     {struct_name} s = {{
-        .poll_state.ctx = {func.ctx},
+        .poll_state.ctx = qemu_get_current_aio_context(),
         .poll_state.in_progress = true,
 
 { func.gen_block('        .{name} = {name},') }
-- 
2.41.0


