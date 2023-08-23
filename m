Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68078642E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 02:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYxlV-0000YK-HN; Wed, 23 Aug 2023 19:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxlU-0000Tc-7d
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxlR-0004xa-3O
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692835192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlKK332VMj2Iv8uARE6qLd1vT7YXjyhLdxt7yDy7Wtc=;
 b=UjnB9yAR8j1H6XtdltprUd4MZqEvTRleM27y03v03oApXpm0htsY3P9dTYlZbn57ymkNHj
 M4/uDfaT32aHbsOqWahGMuRmNT5rCubBSv4kkjJeOZB/SOIS4FLIBGgIR/V/bM4Kb2eUwn
 lK7blIOX27a918v1Ll6h72BoV/Ee1DI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-1KprDExZOM6MvoBn0klnAA-1; Wed, 23 Aug 2023 19:59:49 -0400
X-MC-Unique: 1KprDExZOM6MvoBn0klnAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6B8029A9CA0;
 Wed, 23 Aug 2023 23:59:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F992140E950;
 Wed, 23 Aug 2023 23:59:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kwolf@redhat.com, <qemu-block@nongnu.org>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 4/4] block-coroutine-wrapper: use
 qemu_get_current_aio_context()
Date: Wed, 23 Aug 2023 19:59:38 -0400
Message-ID: <20230823235938.1398382-5-stefanha@redhat.com>
In-Reply-To: <20230823235938.1398382-1-stefanha@redhat.com>
References: <20230823235938.1398382-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 scripts/block-coroutine-wrapper.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index d4a183db61..f93fe154c3 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -88,8 +88,6 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
                 raise ValueError(f"no_co function can't be rdlock: {self.name}")
             self.target_name = f'{subsystem}_{subname}'
 
-        self.ctx = self.gen_ctx()
-
         self.get_result = 's->ret = '
         self.ret = 'return s.ret;'
         self.co_ret = 'return '
@@ -162,7 +160,7 @@ def create_mixed_wrapper(func: FuncDecl) -> str:
         {func.co_ret}{name}({ func.gen_list('{name}') });
     }} else {{
         {struct_name} s = {{
-            .poll_state.ctx = {func.ctx},
+            .poll_state.ctx = qemu_get_current_aio_context(),
             .poll_state.in_progress = true,
 
 { func.gen_block('            .{name} = {name},') }
@@ -186,7 +184,7 @@ def create_co_wrapper(func: FuncDecl) -> str:
 {func.return_type} {func.name}({ func.gen_list('{decl}') })
 {{
     {struct_name} s = {{
-        .poll_state.ctx = {func.ctx},
+        .poll_state.ctx = qemu_get_current_aio_context(),
         .poll_state.in_progress = true,
 
 { func.gen_block('        .{name} = {name},') }
-- 
2.41.0


