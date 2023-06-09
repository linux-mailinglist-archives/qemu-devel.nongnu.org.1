Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387772A4A4
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7iaV-00025S-Nh; Fri, 09 Jun 2023 16:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7iaR-00023z-DG; Fri, 09 Jun 2023 16:19:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7ia9-0000BA-V7; Fri, 09 Jun 2023 16:19:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8394E1FD6D;
 Fri,  9 Jun 2023 20:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686341976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpsBsTWWwIgYxCL079sJNHRptOhse1wDEWsxBAJclkY=;
 b=GYDyhdSbarljKxwWeOHTMR+IOUudyXBvFWCQ4/nGYUJSJPb5tui+h/hDKTMT6NgahGipq3
 w0m9Z19lwgyRBxl/IM6CFYUsBancfIxMUXwdqcZBr20sVCmCPvVDo3OL67Qy6sBU3uSR/4
 EL9KhU0jtDQ4jS4jfxawCkri+fdfFmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686341976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpsBsTWWwIgYxCL079sJNHRptOhse1wDEWsxBAJclkY=;
 b=sRK+L+DG+z3qwDeRzqHvAy3o9Z5Q8lNTVqWbeExxPxxdH4MXxA168dl59gdNSKtrDVoGvo
 r4/48xZff6EKLtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A16EA139C8;
 Fri,  9 Jun 2023 20:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WFDzGFWJg2R/SwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 09 Jun 2023 20:19:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 06/10] block: Convert bdrv_block_device_info into co_wrapper
Date: Fri,  9 Jun 2023 17:19:06 -0300
Message-Id: <20230609201910.12100-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609201910.12100-1-farosas@suse.de>
References: <20230609201910.12100-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

We're converting callers of bdrv_get_allocated_file_size() to run in
coroutines because that function will be made asynchronous when called
(indirectly) from the QMP dispatcher.

This function is a candidate because it calls bdrv_query_image_info()
-> bdrv_do_query_node_info() -> bdrv_get_allocated_file_size().

It is safe to turn this is a coroutine because the code it calls is
made up of either simple accessors and string manipulation functions
[1] or it has already been determined to be safe [2].

1) bdrv_refresh_filename(), bdrv_is_read_only(),
   blk_enable_write_cache(), bdrv_cow_bs(), blk_get_public(),
   throttle_group_get_name(), bdrv_write_threshold_get(),
   bdrv_query_dirty_bitmaps(), throttle_group_get_config(),
   bdrv_filter_or_cow_bs(), bdrv_skip_implicit_filters()

2) bdrv_do_query_node_info() (see previous commit);

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/qapi.c         |  8 ++++----
 include/block/qapi.h | 12 ++++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index a2e71edaff..20660e15d6 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -41,10 +41,10 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 
-BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs,
-                                        bool flat,
-                                        Error **errp)
+BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
+                                                        BlockDriverState *bs,
+                                                        bool flat,
+                                                        Error **errp)
 {
     ImageInfo **p_image_info;
     ImageInfo *backing_info;
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 7035bcd1ae..5cb0202791 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -30,10 +30,14 @@
 #include "block/snapshot.h"
 #include "qapi/qapi-types-block-core.h"
 
-BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs,
-                                        bool flat,
-                                        Error **errp);
+BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
+                                                        BlockDriverState *bs,
+                                                        bool flat,
+                                                        Error **errp);
+BlockDeviceInfo *co_wrapper bdrv_block_device_info(BlockBackend *blk,
+                                                   BlockDriverState *bs,
+                                                   bool flat,
+                                                   Error **errp);
 int bdrv_query_snapshot_info_list(BlockDriverState *bs,
                                   SnapshotInfoList **p_list,
                                   Error **errp);
-- 
2.35.3


