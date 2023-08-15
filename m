Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A277D6AA
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 01:31:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW3Uo-0003MS-Nf; Tue, 15 Aug 2023 19:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW3Uj-0003IW-R4
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 19:30:38 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW3Uh-0007Yi-IX
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 19:30:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21BFB1F8C1;
 Tue, 15 Aug 2023 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692142233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gSEM+vc6AfPUHJuGSt2iBmmb1ykkYTm87kds8xy1838=;
 b=V2c4apPs4WMP/ZDQXtLTRj/cmdXHAA2mInw0d9ZcfGSeXK6iR/Z2w/E2JLI232mCQCtrr1
 f4AW9hQkVl49LVUXIFFOvMoq+j3HZtaYY76YEUbJZ3m/7mDY+DD6rY+av+EQm5NAxSv5cQ
 fMCMzVUz5et+Tfv6z+qQ+8D+LjoayQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692142233;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gSEM+vc6AfPUHJuGSt2iBmmb1ykkYTm87kds8xy1838=;
 b=PJQbhEFaPGajHFOnLnvY5zK1CnRM9MBxvTICliQcXhx/DEt2xfShWQrOKwe7AMNNLu9l7z
 siTOMoZR10552YCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A743D1353E;
 Tue, 15 Aug 2023 23:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U5BWHJgK3GQHRwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 23:30:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 3/5] migration/ram: Move xbzrle zero page handling into
 save_zero_page
In-Reply-To: <20230815143828.15436-4-farosas@suse.de>
References: <20230815143828.15436-1-farosas@suse.de>
 <20230815143828.15436-4-farosas@suse.de>
Date: Tue, 15 Aug 2023 20:30:30 -0300
Message-ID: <87wmxvlw89.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Fabiano Rosas <farosas@suse.de> writes:

> It makes a bit more sense to have the zero page handling of xbzrle
> right where we save the zero page.
>
> This also makes save_zero_page() follow the same format as
> save_compress_page() at the top level of
> ram_save_target_page_legacy().
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 761f43dc34..a10410a1a5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1159,11 +1159,12 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
>   *
>   * Returns the number of pages written.
>   *
> + * @rs: current RAM state
>   * @pss: current PSS channel
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   */
> -static int save_zero_page(PageSearchStatus *pss, RAMBlock *block,
> +static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
>                            ram_addr_t offset)
>  {
>      int len = save_zero_page_to_file(pss, block, offset);
> @@ -1171,6 +1172,17 @@ static int save_zero_page(PageSearchStatus *pss, RAMBlock *block,
>      if (len) {
>          stat64_add(&mig_stats.zero_pages, 1);
>          ram_transferred_add(len);
> +
> +        /*
> +         * Must let xbzrle know, otherwise a previous (now 0'd) cached
> +         * page would be stale.
> +         */
> +        if (rs->xbzrle_started) {
> +            XBZRLE_cache_lock();
> +            xbzrle_cache_zero_page(block->offset + offset);
> +            XBZRLE_cache_unlock();
> +        }
> +
>          return 1;
>      }
>      return -1;
> @@ -2141,17 +2153,8 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>          return 1;
>      }
>  
> -    res = save_zero_page(pss, block, offset);
> -    if (res > 0) {

These two subtractions should be in patch 5.

> -        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
> -         * page would be stale
> -         */
> -        if (rs->xbzrle_started) {
> -            XBZRLE_cache_lock();
> -            xbzrle_cache_zero_page(block->offset + offset);
> -            XBZRLE_cache_unlock();
> -        }
> -        return res;
> +    if (save_zero_page(rs, pss, block, offset)) {
> +        return 1;

These two additions should be in patch 5.

>      }
>  
>      /*

