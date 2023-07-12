Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6D75110E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfKJ-0005md-Lm; Wed, 12 Jul 2023 15:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJfKH-0005mF-Nu
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJfKG-0001wW-9K
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689189394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dsryfDy6LjagDRiliXIP3B2Rbyb/hrR3RC0ewdhj+4c=;
 b=TZwT0bFtNULrz/Qq1Z45WZPb6IPqGj+6FuwsuF+bQ8vmYJdO3FxFAa1O339IXTICwxftQ9
 8taZ4WQ5qoKmNB9joeli7JDNpfuzbYHm2ztoOXmmitpfDUCoNa7dpKG7xz60gioGE7gr6f
 FJKGg4037tR76L6FJQAR+cNY2wPPfPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-FfPUmKHQOpCOsikadt37pQ-1; Wed, 12 Jul 2023 15:16:31 -0400
X-MC-Unique: FfPUmKHQOpCOsikadt37pQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00802185A7A8;
 Wed, 12 Jul 2023 19:16:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 153C2C1ED96;
 Wed, 12 Jul 2023 19:16:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Subject: [PATCH] block/nvme: invoke blk_io_plug_call() outside q->lock
Date: Wed, 12 Jul 2023 15:16:28 -0400
Message-Id: <20230712191628.252806-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

blk_io_plug_call() is invoked outside a blk_io_plug()/blk_io_unplug()
section while opening the NVMe drive from:

  nvme_file_open() ->
  nvme_init() ->
  nvme_identify() ->
  nvme_admin_cmd_sync() ->
  nvme_submit_command() ->
  blk_io_plug_call()

blk_io_plug_call() immediately invokes the given callback when the
current thread is not plugged, as is the case during nvme_file_open().

Unfortunately, nvme_submit_command() calls blk_io_plug_call() with
q->lock still held:

    ...
    q->sq.tail = (q->sq.tail + 1) % NVME_QUEUE_SIZE;
    q->need_kick++;
    blk_io_plug_call(nvme_unplug_fn, q);
    qemu_mutex_unlock(&q->lock);
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^

nvme_unplug_fn() deadlocks trying to acquire q->lock because the lock is
already acquired by the same thread. The symptom is that QEMU hangs
during startup while opening the NVMe drive.

Fix this by moving the blk_io_plug_call() outside q->lock. This is safe
because no other thread runs code related to this queue and
blk_io_plug_call()'s internal state is immune to thread safety issues
since it is thread-local.

Reported-by: Lukáš Doktor <ldoktor@redhat.com>
Fixes: f2e590002bd6 ("block/nvme: convert to blk_io_plug_call() API")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7ca85bc44a..b6e95f0b7e 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -501,8 +501,9 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
            q->sq.tail * NVME_SQ_ENTRY_BYTES, cmd, sizeof(*cmd));
     q->sq.tail = (q->sq.tail + 1) % NVME_QUEUE_SIZE;
     q->need_kick++;
+    qemu_mutex_unlock(&q->lock);
+
     blk_io_plug_call(nvme_unplug_fn, q);
-    qemu_mutex_unlock(&q->lock);
 }
 
 static void nvme_admin_cmd_sync_cb(void *opaque, int ret)
-- 
2.40.1


