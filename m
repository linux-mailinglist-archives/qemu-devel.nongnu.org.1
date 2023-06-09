Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5E72A492
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:21:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7iaY-00027C-TI; Fri, 09 Jun 2023 16:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7iaU-00024d-Qp; Fri, 09 Jun 2023 16:19:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7iaR-0000Da-Ia; Fri, 09 Jun 2023 16:19:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDCC421A89;
 Fri,  9 Jun 2023 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686341979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKxypfCH/TWYNn3NOXAvEalB2qXeE4bPySVDgd5YRIg=;
 b=SX+uPmHOrQLflHH8hZ90+gEZRg2+aX6gVn4rDglsuDHXvajM42dHOqjYJODea1nvo//2Fa
 IFJzyLrvUM3toAvkwrFv637RWTPXzFXLxfphLhfTcZVnQfmU1HYx0v1qCXCrP40wWeGqad
 FoN16aqjIStzxexBVHg304ggOAFjJUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686341979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKxypfCH/TWYNn3NOXAvEalB2qXeE4bPySVDgd5YRIg=;
 b=oja0keUZBFL7mgPWsH3tuU2JtvnfIkJNtqiSXhZiZPuzN6jW7B7NQC6gL1wsGKQKipIbGQ
 6+22gjfQyHeF/IAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08DDF139C8;
 Fri,  9 Jun 2023 20:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MIOuL1iJg2R/SwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 09 Jun 2023 20:19:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 07/10] block: Convert qmp_query_named_block_nodes to
 coroutine
Date: Fri,  9 Jun 2023 17:19:07 -0300
Message-Id: <20230609201910.12100-8-farosas@suse.de>
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

From: Lin Ma <lma@suse.com>

We're converting callers of bdrv_get_allocated_file_size() to run in
coroutines because that function will be made asynchronous when called
(indirectly) from the QMP dispatcher.

This QMP command is a candidate because it indirectly calls
bdrv_get_allocated_file_size() through bdrv_block_device_info() ->
bdrv_query_image_info() -> bdrv_query_image_info().

The previous patches have determined that bdrv_query_image_info() and
bdrv_do_query_node_info() are coroutine-safe so we can just make the
QMP command run in a coroutine.

Signed-off-by: Lin Ma <lma@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block.c              | 2 +-
 blockdev.c           | 6 +++---
 qapi/block-core.json | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index f94cee8930..abed744b60 100644
--- a/block.c
+++ b/block.c
@@ -6148,7 +6148,7 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
 
     list = NULL;
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
-        BlockDeviceInfo *info = bdrv_block_device_info(NULL, bs, flat, errp);
+        BlockDeviceInfo *info = bdrv_co_block_device_info(NULL, bs, flat, errp);
         if (!info) {
             qapi_free_BlockDeviceInfoList(list);
             return NULL;
diff --git a/blockdev.c b/blockdev.c
index e6eba61484..8b5f7d06c8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2818,9 +2818,9 @@ void qmp_drive_backup(DriveBackup *backup, Error **errp)
     blockdev_do_action(&action, errp);
 }
 
-BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
-                                                 bool flat,
-                                                 Error **errp)
+BlockDeviceInfoList *coroutine_fn qmp_query_named_block_nodes(bool has_flat,
+                                                              bool flat,
+                                                              Error **errp)
 {
     bool return_flat = has_flat && flat;
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5dd5f7e4b0..9d4c92f2c9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1972,7 +1972,8 @@
 { 'command': 'query-named-block-nodes',
   'returns': [ 'BlockDeviceInfo' ],
   'data': { '*flat': 'bool' },
-  'allow-preconfig': true }
+  'allow-preconfig': true,
+  'coroutine': true}
 
 ##
 # @XDbgBlockGraphNodeType:
-- 
2.35.3


