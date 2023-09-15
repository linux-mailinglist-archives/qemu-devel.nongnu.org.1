Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539537A2152
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:45:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3O-0000Fd-D6; Fri, 15 Sep 2023 10:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA36-0008TH-Na
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA34-0004vk-QU
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Hz6zJ6FqoLa4zXJLL3Ym1mHcV9WlGYpPtJxllnj2jg=;
 b=XT2eJi3yKy6M1poJ2Op0VIQOiy7koKR1mmBHkW1UQljmlpkUBcIARo4GmNbXM7musUe3tg
 WJOyDo7t8VzlyGJ5T171r9Gb3MjNJhdqLF3eUyMVV/Hs8ffHdnK/OiSMosR2w273QCfAxp
 H3mB4fLbbxaud3OiLcAv2EFR2veKLos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-LtOwMPPcMiSzkUObfFNGWg-1; Fri, 15 Sep 2023 10:43:54 -0400
X-MC-Unique: LtOwMPPcMiSzkUObfFNGWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8827A101B041;
 Fri, 15 Sep 2023 14:43:54 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E887D2026D4B;
 Fri, 15 Sep 2023 14:43:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/28] block-coroutine-wrapper: Allow arbitrary parameter names
Date: Fri, 15 Sep 2023 16:43:23 +0200
Message-ID: <20230915144344.238596-8-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Don't assume specific parameter names like 'bs' or 'blk' in the
generated code, but use the actual name.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-8-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/block-coroutine-wrapper.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index fa01c06567..685d0b4ed4 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -105,12 +105,13 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
 
     def gen_ctx(self, prefix: str = '') -> str:
         t = self.args[0].type
+        name = self.args[0].name
         if t == 'BlockDriverState *':
-            return f'bdrv_get_aio_context({prefix}bs)'
+            return f'bdrv_get_aio_context({prefix}{name})'
         elif t == 'BdrvChild *':
-            return f'bdrv_get_aio_context({prefix}child->bs)'
+            return f'bdrv_get_aio_context({prefix}{name}->bs)'
         elif t == 'BlockBackend *':
-            return f'blk_get_aio_context({prefix}blk)'
+            return f'blk_get_aio_context({prefix}{name})'
         else:
             return 'qemu_get_aio_context()'
 
-- 
2.41.0


