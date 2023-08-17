Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E877F6EB
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:56:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcTV-0000ZU-LS; Thu, 17 Aug 2023 08:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcTE-0008At-4f
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcTA-0002ne-Hl
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692276679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RoAgmdHVfaxrotk6P2oWZwGjxrYgJ2tjahDTLO99Evw=;
 b=TqXCOGjohD02InaizYiD6SHugdL79PDiwDUKrmRNTkhcDMx0kQemyJA8N5MqF08r286uGb
 l5z6XUALO062kYCgVX1B+tio6Pp/7mIZxlIbnpm7Z6DtpYt8CR7E/91xE7diZ+maD1tl0x
 6AfeuoCkF1McwuFa0AKEqelnbU2Peko=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-q8y0u7kPN2eAaNc6l3rFdw-1; Thu, 17 Aug 2023 08:51:16 -0400
X-MC-Unique: q8y0u7kPN2eAaNc6l3rFdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B58E23C0E212;
 Thu, 17 Aug 2023 12:51:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A9A31121314;
 Thu, 17 Aug 2023 12:51:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 16/21] block: Mark bdrv_parent_cb_change_media() GRAPH_RDLOCK
Date: Thu, 17 Aug 2023 14:50:15 +0200
Message-ID: <20230817125020.208339-17-kwolf@redhat.com>
In-Reply-To: <20230817125020.208339-1-kwolf@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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

The function reads the parents list, so it needs to hold the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 0a28bfc3c4..7df8780d6e 100644
--- a/block.c
+++ b/block.c
@@ -3369,7 +3369,8 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
 }
 
 
-static void bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
+static void GRAPH_RDLOCK
+bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
 {
     BdrvChild *c;
     GLOBAL_STATE_CODE();
@@ -3967,6 +3968,9 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     GLOBAL_STATE_CODE();
     assert(!qemu_in_coroutine());
 
+    /* TODO We'll eventually have to take a writer lock in this function */
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (reference) {
         bool options_non_empty = options ? qdict_size(options) : false;
         qobject_unref(options);
-- 
2.41.0


