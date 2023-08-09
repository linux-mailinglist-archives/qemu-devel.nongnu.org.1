Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2806775613
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTf55-0002mV-5t; Wed, 09 Aug 2023 05:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qTf52-0002lm-Vt; Wed, 09 Aug 2023 05:02:13 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qTf51-0006mr-7K; Wed, 09 Aug 2023 05:02:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 183292186F;
 Wed,  9 Aug 2023 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691571726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBxpHHRYipyeEtQyh8RmZb6JiBaguz3E4YF6GzSv3cw=;
 b=kgjF7eK35uTSnbEjyz+RdT93TuEB1d379ObtMJdDrwDOCcF5tN0Dxhno42Tuu+MGmLD25t
 CGsBfnrxAXejvNHAWe66xbAIgX/7rDlyDImRn/ZVsU8O8/nH/PXQKtiK2mDd4XF70WjZKq
 idV7zjvlpdC0fiAkrc4+adHOGc6/icM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691571726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBxpHHRYipyeEtQyh8RmZb6JiBaguz3E4YF6GzSv3cw=;
 b=ZGGsRSwIMSfCUMogHCd1gWL717itT6Ilk/SoCLLncq5Dz4CDJPx626CyVN/hLVns6FxJHY
 tIR70TiMNy1PxeDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE0F513251;
 Wed,  9 Aug 2023 09:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PGxrKA1W02RqBAAAMHmgww
 (envelope-from <cfontana@suse.de>); Wed, 09 Aug 2023 09:02:05 +0000
Message-ID: <d94ff8c4-12f6-0e47-d384-26a9e94ca26f@suse.de>
Date: Wed, 9 Aug 2023 11:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block-migration: Ensure we don't crash during migration
 cleanup
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-stable@nongnu.org
References: <20230731203338.27581-1-farosas@suse.de>
 <20230808170823.GA2749198@fedora>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230808170823.GA2749198@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 19:08, Stefan Hajnoczi wrote:
> On Mon, Jul 31, 2023 at 05:33:38PM -0300, Fabiano Rosas wrote:
>> We can fail the blk_insert_bs() at init_blk_migration(), leaving the
>> BlkMigDevState without a dirty_bitmap and BlockDriverState. Account
>> for the possibly missing elements when doing cleanup.
>>
>> Fix the following crashes:
>>
>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
>> 359         BlockDriverState *bs = bitmap->bs;
>>  #0  0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
>>  #1  0x0000555555bba331 in unset_dirty_tracking () at ../migration/block.c:371
>>  #2  0x0000555555bbad98 in block_migration_cleanup_bmds () at ../migration/block.c:681
>>
>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
>> 7073        QLIST_FOREACH_SAFE(blocker, &bs->op_blockers[op], list, next) {
>>  #0  0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
>>  #1  0x0000555555e9734a in bdrv_op_unblock_all (bs=0x0, reason=0x0) at ../block.c:7095
>>  #2  0x0000555555bbae13 in block_migration_cleanup_bmds () at ../migration/block.c:690
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/block.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Sorry, I missed this patch!
> 
> If this needs to be in QEMU 8.1 (-rc3 is being tagged today), please
> reply and provide a justification. At this point only security fixes and
> showstoppers will be merged. Thanks!
> 
> Applied to my block-next tree for QEMU 8.2:
> https://gitlab.com/stefanha/qemu/commits/block-next
> 
> Stefan

Thanks, and in my personal view I think it's ok for 8.2, IIUC it happens during the migration to file work which is not in 8.1 anyway,
Fabiano correct me here if I am wrong,

Ciao,

Claudio

