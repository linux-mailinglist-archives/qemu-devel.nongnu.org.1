Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8872A49F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:21:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ia7-00020Z-00; Fri, 09 Jun 2023 16:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7ia4-0001zq-TG; Fri, 09 Jun 2023 16:19:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7ia3-00009y-DT; Fri, 09 Jun 2023 16:19:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD37721A37;
 Fri,  9 Jun 2023 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686341969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jh5sG1xHrngl1FNbbZPSUScxdD6RZ8Ufzb6l9Teg74M=;
 b=WbzjSUiipfucxhWysqpze0E4zNjJfxnOTZvE//o9H/eXOyrp+bQjnkLG+CXkdGi1zDEM05
 q4xuaK8kYvVYI01ZGOWeW/B0l7mA/jtTuslyjOWHGfpRGhsMwhDOLfF1bE3XsIfzeM2qU7
 +kevUTPDFOne/CljiH6enAVxI4epBK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686341969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jh5sG1xHrngl1FNbbZPSUScxdD6RZ8Ufzb6l9Teg74M=;
 b=A8yVtKHsYmRY2AnvMfds3rVDk4s6FhpCo7N2P+GlYDSkgk//BUJU8qet4QMjO3VQxECO5a
 PjI1SOvQuMOUynBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D50E6139C8;
 Fri,  9 Jun 2023 20:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OGC/JU6Jg2R/SwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 09 Jun 2023 20:19:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 04/10] block: Temporarily mark
 bdrv_co_get_allocated_file_size as mixed
Date: Fri,  9 Jun 2023 17:19:04 -0300
Message-Id: <20230609201910.12100-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609201910.12100-1-farosas@suse.de>
References: <20230609201910.12100-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some callers of this function are about to be converted to run in
coroutines, so allow it to be executed both inside and outside a
coroutine while we convert all the callers.

This will be reverted once all callers of bdrv_do_query_node_info run
in a coroutine.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block-io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index 43af816d75..f31e25cf56 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -87,7 +87,7 @@ int64_t co_wrapper_mixed_bdrv_rdlock bdrv_getlength(BlockDriverState *bs);
 int64_t coroutine_fn GRAPH_RDLOCK
 bdrv_co_get_allocated_file_size(BlockDriverState *bs);
 
-int64_t co_wrapper_bdrv_rdlock
+int64_t co_wrapper_mixed_bdrv_rdlock
 bdrv_get_allocated_file_size(BlockDriverState *bs);
 
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
-- 
2.35.3


