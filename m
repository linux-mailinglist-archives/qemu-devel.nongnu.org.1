Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC437E991C
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2TMw-0007x2-BX; Mon, 13 Nov 2023 04:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2TMs-0007wQ-7A
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2TMp-0001xE-Sr
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699868184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aesQ6/07jaB1mqhaZf9GxawfJWuVxUiwCEukQxq61tw=;
 b=Kif4lpRpz/ghbH+4CpCpajjFh8Wx9Q/xqv1UZGtiwN67nABOPX6rHUxdBAkfKZA8dm+aRl
 ox1orVBj9N+XNyeW64HW3OkQP1F6MTUPjUtC/re/w4NqqLaVLPwg11T4MEhXSQZ8hKGJTB
 X+OEX7b6iic5pxbyvT+mTqlfArbYHjM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ozbJ9dZxPTms1wG4lbj7vg-1; Mon,
 13 Nov 2023 04:36:23 -0500
X-MC-Unique: ozbJ9dZxPTms1wG4lbj7vg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 186E528B72E3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:36:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EACA3492BFA
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:36:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E09EA21E6A26; Mon, 13 Nov 2023 10:36:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/2] block/snapshot: Fix compiler warning with -Wshadow=local
Date: Mon, 13 Nov 2023 10:36:20 +0100
Message-ID: <20231113093621.750115-2-armbru@redhat.com>
In-Reply-To: <20231113093621.750115-1-armbru@redhat.com>
References: <20231113093621.750115-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

No need to declare a new variable in the the inner code block
here, we can re-use the "ret" variable that has been declared
at the beginning of the function. With this change, the code
can now be successfully compiled with -Wshadow=local again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231023175038.111607-1-thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/snapshot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index 6e16eb803a..55974273ae 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -629,7 +629,6 @@ int bdrv_all_goto_snapshot(const char *name,
     while (iterbdrvs) {
         BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
-        int ret = 0;
         bool all_snapshots_includes_bs;
 
         aio_context_acquire(ctx);
@@ -637,9 +636,8 @@ int bdrv_all_goto_snapshot(const char *name,
         all_snapshots_includes_bs = bdrv_all_snapshots_includes_bs(bs);
         bdrv_graph_rdunlock_main_loop();
 
-        if (devices || all_snapshots_includes_bs) {
-            ret = bdrv_snapshot_goto(bs, name, errp);
-        }
+        ret = (devices || all_snapshots_includes_bs) ?
+              bdrv_snapshot_goto(bs, name, errp) : 0;
         aio_context_release(ctx);
         if (ret < 0) {
             bdrv_graph_rdlock_main_loop();
-- 
2.41.0


