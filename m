Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B325F7DD66B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:00:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtxq-0003wA-VC; Tue, 31 Oct 2023 14:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxo-0003va-KG
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxW-00066C-39
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjIerUf9u0uFn+Ltsfafs37cS1G262v/Y5EckadG/w8=;
 b=F1H9uxnzJkARcqP+c2/WVbL85P3ICadv+Yn6ie8XOjjWoW8QwVT4p/ryVRsjohc4gMUSpg
 WqjwvW+sS0JSLbe6ftzZihuXaZazJK9Y/ko5jYBBB/ZpolQEO9KX9o79/vb7sWwdFZaBWL
 jWoughsDo1e60yhkZ4GO+gFoSvuFjLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-qVOU4cvEMWGlr7W0ibEOBg-1; Tue, 31 Oct 2023 14:59:23 -0400
X-MC-Unique: qVOU4cvEMWGlr7W0ibEOBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16CB08678A7;
 Tue, 31 Oct 2023 18:59:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A461143;
 Tue, 31 Oct 2023 18:59:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/27] qemu-img: rebase: use backing files' BlockBackend for
 buffer alignment
Date: Tue, 31 Oct 2023 19:58:54 +0100
Message-ID: <20231031185918.346940-4-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
the data read from the old and new backing files are aligned using
BlockDriverState (or BlockBackend later on) referring to the target image.
However, this isn't quite right, because buf_new is only being used for
reading from the new backing, while buf_old is being used for both reading
from the old backing and writing to the target.  Let's take that into account
and use more appropriate values as alignments.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20230919165804.439110-4-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2b2a3a86ca..e61d996e0f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3759,8 +3759,13 @@ static int img_rebase(int argc, char **argv)
         int64_t n;
         float local_progress = 0;
 
-        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
-        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
+        if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk_old_backing)) >
+            bdrv_opt_mem_align(blk_bs(blk))) {
+            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
+        } else {
+            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
+        }
+        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
 
         size = blk_getlength(blk);
         if (size < 0) {
-- 
2.41.0


