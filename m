Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2377390B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 10:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTI6N-000243-Aq; Tue, 08 Aug 2023 04:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qTI6I-00023C-VY; Tue, 08 Aug 2023 04:29:59 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qTI6H-0002sh-Ak; Tue, 08 Aug 2023 04:29:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3F9920018;
 Tue,  8 Aug 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691483394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1AgYTkJudYNFAGtf+a0VXsJXBA+JNNpUxbgm1X2Zac=;
 b=XHxVT2USZC2SPARkfDLPYuzeBEZeXbhhpt5z+DdRa3Em96mq6eBY1ApTUpQ/m9HrWYT0WB
 sM5DdmDuXUBrMy7QTZiCYVRsYV4qCBuA2X6ht46QZMiE8wyeXESgAKBX5dkuZMbDssnivV
 W/wo2KXgEoQPPY1DsFi4md+X1aSHzC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691483394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1AgYTkJudYNFAGtf+a0VXsJXBA+JNNpUxbgm1X2Zac=;
 b=7R00e3mD3sZOjK4m/ItWyIjns8X9BBOWDO25/cgEBG35hz2mGV6kWNhbSXPzB0kxGH97c2
 Mybu/f2ziQNz6ABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 493AC139D1;
 Tue,  8 Aug 2023 08:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yFU4EAL90WSIewAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 08 Aug 2023 08:29:54 +0000
Message-ID: <3554b180-1283-70d1-4c6f-2e96b3112a2e@suse.de>
Date: Tue, 8 Aug 2023 10:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block-migration: Ensure we don't crash during migration
 cleanup
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230731203338.27581-1-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230731203338.27581-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

added Kevin and Hanna for block, since this seems still untouched?

Thanks,

Claudio

On 7/31/23 22:33, Fabiano Rosas wrote:
> We can fail the blk_insert_bs() at init_blk_migration(), leaving the
> BlkMigDevState without a dirty_bitmap and BlockDriverState. Account
> for the possibly missing elements when doing cleanup.
> 
> Fix the following crashes:
> 
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
> 359         BlockDriverState *bs = bitmap->bs;
>  #0  0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
>  #1  0x0000555555bba331 in unset_dirty_tracking () at ../migration/block.c:371
>  #2  0x0000555555bbad98 in block_migration_cleanup_bmds () at ../migration/block.c:681
> 
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
> 7073        QLIST_FOREACH_SAFE(blocker, &bs->op_blockers[op], list, next) {
>  #0  0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
>  #1  0x0000555555e9734a in bdrv_op_unblock_all (bs=0x0, reason=0x0) at ../block.c:7095
>  #2  0x0000555555bbae13 in block_migration_cleanup_bmds () at ../migration/block.c:690
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/block.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index b9580a6c7e..86c2256a2b 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -368,7 +368,9 @@ static void unset_dirty_tracking(void)
>      BlkMigDevState *bmds;
>  
>      QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
> -        bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
> +        if (bmds->dirty_bitmap) {
> +            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
> +        }
>      }
>  }
>  
> @@ -676,13 +678,18 @@ static int64_t get_remaining_dirty(void)
>  static void block_migration_cleanup_bmds(void)
>  {
>      BlkMigDevState *bmds;
> +    BlockDriverState *bs;
>      AioContext *ctx;
>  
>      unset_dirty_tracking();
>  
>      while ((bmds = QSIMPLEQ_FIRST(&block_mig_state.bmds_list)) != NULL) {
>          QSIMPLEQ_REMOVE_HEAD(&block_mig_state.bmds_list, entry);
> -        bdrv_op_unblock_all(blk_bs(bmds->blk), bmds->blocker);
> +
> +        bs = blk_bs(bmds->blk);
> +        if (bs) {
> +            bdrv_op_unblock_all(bs, bmds->blocker);
> +        }
>          error_free(bmds->blocker);
>  
>          /* Save ctx, because bmds->blk can disappear during blk_unref.  */


