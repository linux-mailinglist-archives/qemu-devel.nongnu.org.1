Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A2714F07
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 19:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3gxy-00018W-MU; Mon, 29 May 2023 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3gxt-00017U-8U; Mon, 29 May 2023 13:47:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3gxr-00085b-L0; Mon, 29 May 2023 13:47:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5A91F8B2;
 Mon, 29 May 2023 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685382445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IMHd3t7BZiNAkK/hetKyVSNekS94Jh6o7mLKw+2YtuE=;
 b=KAfdnB5rKxmAVBe4a0kYynVMnSwWRXQlxcnrV2BS6zR0QO4VChnKN7Y5VLO7VLmsESiEAk
 GyZzEIi4On0m3T+YGtdU1sGzAx4mgFz4VPSMoVpH36cDiU5DNDMVSXdpHkmL21MfanEBWL
 TmPBG4byRzfooY+w37+axv64qbUbKaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685382445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IMHd3t7BZiNAkK/hetKyVSNekS94Jh6o7mLKw+2YtuE=;
 b=QdNHJw+0Z+KO7i2r1NZGbGreJdWsGcW46IIuvYc3nE7FUes1IK2UUgXJ5yBwlJMTXFMZLT
 1SyO8lxildURAlBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC03B13466;
 Mon, 29 May 2023 17:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6w//ICzldGTwZgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 29 May 2023 17:47:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Hanna Reitz
 <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Jo?=
 =?utf-8?Q?=C3=A3o?= Silva
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana
 <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH 5/6] block: Allow bdrv_get_allocated_file_size to
 run in bdrv context
In-Reply-To: <ZHB7ufFMG90NUcM0@redhat.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-6-farosas@suse.de> <ZHB7ufFMG90NUcM0@redhat.com>
Date: Mon, 29 May 2023 14:47:22 -0300
Message-ID: <87leh7rpw5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 23.05.2023 um 23:39 hat Fabiano Rosas geschrieben:
>> We're about to move calls to 'fstat' into the thread-pool to avoid
>> blocking VCPU threads should the system call take too long.
>> 
>> To achieve that we first need to make sure none of its callers is
>> holding the aio_context lock, otherwise yielding before scheduling the
>> aiocb handler would result in a deadlock when the qemu_global_mutex is
>> released and another thread tries to acquire the aio_context.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  block/qapi.c | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>> 
>> diff --git a/block/qapi.c b/block/qapi.c
>> index ae6cd1c2ff..cd197abf1f 100644
>> --- a/block/qapi.c
>> +++ b/block/qapi.c
>> @@ -222,6 +222,26 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
>>      return 0;
>>  }
>>  
>> +static int64_t bdrv_get_actual_size(BlockDriverState *bs)
>> +{
>> +    int64_t size;
>> +    AioContext *old_ctx = NULL;
>> +
>> +    if (qemu_in_coroutine()) {
>
> Hm. Why can't we make sure that it always runs in a coroutine?
>
> Callers:
>
> * bdrv_query_block_node_info(). This functions seems to be completely
>   unused, we can remove it.
>

Ok, I'm already removing it in patch 1.

> * bdrv_query_image_info(). Called by bdrv_block_device_info() and itself.
>   bdrv_block_device_info() could become a co_wrapper after swapping the
>   first two parameters so that it runs in the AioContext of @bs.
>

We cannot have bdrv_block_device_info() as co_wrapper because that would
create its own coroutine and yielding from that would merely have us
waiting at bdrv_poll_co. So it doesn't solve the blocking issue.

What would work is to make bdrv_block_device_info() a coroutine_fn
(without a wrapper). Its two callers, qmp_query_block() and
qmp_query_named_block_nodes() are already being moved into the handler
coroutine in this series, so it would be mostly a matter of adding the
type annotation.

> * bdrv_query_block_graph_info(). Only called by qemu-img. Could become a
>   co_wrapper_bdrv_rdlock.
>

This one works ok.

>> +        aio_context_release(bdrv_get_aio_context(bs));
>> +        old_ctx = bdrv_co_enter(bs);
>
> I think this is the wrong function to do this. The caller should already
> make sure that it's in the right AioContext.
>

The issue here is that bdrv_do_query_node_info() calls
bdrv_co_get_allocated_file_size(), which is the function we want to make
async and therefore needs to run outside of aio_context_acquire/release.
However, bdrv_do_query_node_info() also calls bdrv_refresh_filename(),
which is GLOBAL_STATE_CODE and therefore wants to be in the main thread
context. So entering the bs AioContext at the caller doesn't work when
giving the device its own iothread.

>> +    }
>> +
>> +    size = bdrv_get_allocated_file_size(bs);
>> +
>> +    if (qemu_in_coroutine() && old_ctx) {
>> +        bdrv_co_leave(bs, old_ctx);
>> +        aio_context_acquire(bdrv_get_aio_context(bs));
>> +    }
>> +
>> +    return size;
>> +}
>
> Kevin

