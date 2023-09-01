Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91379023D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc9A2-00047G-Vn; Fri, 01 Sep 2023 14:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qc99v-00045z-9V; Fri, 01 Sep 2023 14:46:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qc99r-0004ZA-Ek; Fri, 01 Sep 2023 14:46:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3550A21847;
 Fri,  1 Sep 2023 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693593973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/w8zdoisvVJ4YCLwfJ6mIWVKjAa3skUegEf5BvHmvw=;
 b=x6X1wWyJWwtKxdZV92ULPvaTo5tFJUg9kQHI+7wrGfvtWlbpfpDrsJDipl6s6YBbHX1/1f
 CjyFASku4fEsAh2Lt4nzA5CRjdrnL9AGx6DPon9BUia6FTlAT3CjZHfOmXMSpVo4Ty5zIT
 DIvs8ODraAE5wgBy32Doikb4MbvI+TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693593973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/w8zdoisvVJ4YCLwfJ6mIWVKjAa3skUegEf5BvHmvw=;
 b=vLxY1DQ9l3/R2SAN2NIQNatDhAkBclQgVNukJ0vvAlgg5whrv7BsxQILNLKgON25hUV7aC
 w1zUGdaFVUuNfoDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B296913582;
 Fri,  1 Sep 2023 18:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OK7cHnMx8mSQVgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 01 Sep 2023 18:46:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH RESEND 2/2] block: Remove unnecessary variable in
 bdrv_block_device_info
Date: Fri,  1 Sep 2023 15:46:05 -0300
Message-Id: <20230901184605.32260-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230901184605.32260-1-farosas@suse.de>
References: <20230901184605.32260-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The commit 5d8813593f ("block/qapi: Let bdrv_query_image_info()
recurse") removed the loop where we set the 'bs0' variable, so now it
is just the same as 'bs'.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/qapi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 79bf80c503..1cbb0935ff 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -48,7 +48,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 {
     ImageInfo **p_image_info;
     ImageInfo *backing_info;
-    BlockDriverState *bs0, *backing;
+    BlockDriverState *backing;
     BlockDeviceInfo *info;
     ERRP_GUARD();
 
@@ -145,7 +145,6 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
     info->write_threshold = bdrv_write_threshold_get(bs);
 
-    bs0 = bs;
     p_image_info = &info->image;
     info->backing_file_depth = 0;
 
@@ -153,7 +152,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
      * Skip automatically inserted nodes that the user isn't aware of for
      * query-block (blk != NULL), but not for query-named-block-nodes
      */
-    bdrv_query_image_info(bs0, p_image_info, flat, blk != NULL, errp);
+    bdrv_query_image_info(bs, p_image_info, flat, blk != NULL, errp);
     if (*errp) {
         qapi_free_BlockDeviceInfo(info);
         return NULL;
-- 
2.35.3


