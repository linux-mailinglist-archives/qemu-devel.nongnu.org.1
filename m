Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48B79DC7D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 01:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgCX4-0001cl-0r; Tue, 12 Sep 2023 19:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgCX1-0001am-Pq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 19:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgCWz-0003K3-6t
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 19:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694560252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/Am5r627g6QuRUSXRfOq1ki/mlH81bZqKEnrMTBrpo=;
 b=Wf1xuAojVfc7CYg3ZYo75e4uGno6S6mG55c48zd3oVxHnmpYrgKbNZWuHqRkYs4qO8TPID
 JlMOHMCH/iekgxrJ00DenRt0hoNo1/Gqb99i+YntWHb/ZPzdHGyakzNWlkO4LG5oT0hqEK
 XEKqnyK3TQSmHSWWPUFKU0tCM5HbcMY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-CuV-VkKwMhSuyvc9-Lsa7A-1; Tue, 12 Sep 2023 19:10:49 -0400
X-MC-Unique: CuV-VkKwMhSuyvc9-Lsa7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEA823C0C880;
 Tue, 12 Sep 2023 23:10:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3393C2026D4B;
 Tue, 12 Sep 2023 23:10:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, kwolf@redhat.com,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 5/5] block-coroutine-wrapper: use
 qemu_get_current_aio_context()
Date: Tue, 12 Sep 2023 19:10:37 -0400
Message-ID: <20230912231037.826804-6-stefanha@redhat.com>
In-Reply-To: <20230912231037.826804-1-stefanha@redhat.com>
References: <20230912231037.826804-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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
 tests/qemu-iotests/051.pc.out      | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

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
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 4d4af5a486..650cfed8e2 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -177,11 +177,11 @@ QEMU_PROG: -device virtio-blk-pci,drive=disk,share-rw=on: Cannot change iothread
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device lsi53c895a,id=lsi0 -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on: HBA does not support iothreads
+QEMU_PROG: -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on: HBA does not support iothreads
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-scsi,id=virtio-scsi1 -device scsi-hd,bus=virtio-scsi1.0,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd,bus=virtio-scsi1.0,drive=disk,share-rw=on: Cannot change iothread of active block backend
+QEMU_PROG: -device scsi-hd,bus=virtio-scsi1.0,drive=disk,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.41.0


