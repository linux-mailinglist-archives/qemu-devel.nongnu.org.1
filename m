Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53027727454
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 03:31:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q74Su-00023A-DE; Wed, 07 Jun 2023 21:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1q74So-00021R-Aq; Wed, 07 Jun 2023 21:29:25 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1q74Sm-0002se-Hl; Wed, 07 Jun 2023 21:29:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DFCD061ED6;
 Thu,  8 Jun 2023 01:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246E8C433D2;
 Thu,  8 Jun 2023 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686187751;
 bh=p2/TdeOqd3QAqhGmMf/YlpBJ4B6SjjAiT4LZsMFFe8w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=f0ZPCpzTvRn5DgkbYpiOVsL0weSBRaPCCDpMDSwlE3lIVve+H1unbjq0C/+WFSwsZ
 wRB9BBgZCtHK1ryBhQeI0FEgqadragnd0xGWqDo8izhiXw7sJiaYstlvfPeA0UoGJh
 F6TEWkTvMzLggk18ELhGPwaAY+ruWsrC7Wd5ARna7n47Eb4yz0uADFUIYlk536amY8
 3WeBn80AcBH90LrLdkd6ySwr6uU6IKExvbeELlKA0hauUjKpmHW4zmwT9LjILDETnE
 TtQhPi6tPTx4HDCKY5Xoo3YJP2EEBgNRMq7B95BuNwHtZ/0fvFO0y+pNJxno+sbdFC
 gQMTilVGdGNQw==
Message-ID: <6c2621d5-5446-7cd5-2b03-2eb9b99ae64b@kernel.org>
Date: Thu, 8 Jun 2023 10:29:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] block/file-posix: fix wps checking in raw_co_prw
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, dmitry.fomichev@wdc.com,
 hare@suse.de
References: <20230607185741.4238-1-faithilikerun@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230607185741.4238-1-faithilikerun@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=dlemoal@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/8/23 03:57, Sam Li wrote:
> If the write operation fails and the wps is NULL, then accessing it will
> lead to data corruption.
> 
> Solving the issue by adding a nullptr checking in get_zones_wp() where
> the wps is used.
> 
> This issue is found by Peter Maydell using the Coverity Tool (CID
> 1512459).
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ac1ed54811..4a6c71c7f5 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2523,7 +2523,7 @@ out:
>              }
>          }
>      } else {
> -        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> +        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND) && wps) {
>              update_zones_wp(bs, s->fd, 0, 1);

Nit: this could be:

	} else if (wps && type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {

However, both if & else side do something only if the above condition is true
and we only need to that for a zoned drive. So the entire code block could
really be simplified to be a lot more readable. Something like this (totally
untested, not even compiled):

#if defined(CONFIG_BLKZONED)
    if (bs->bl.zone_size && (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))) {
        BlockZoneWps *wps = bs->wps;
        uint64_t *wp;

        if (!wps) {
            return ret;
        }

        if (ret) {
            /* write error: update the wp from the underlying device */
            update_zones_wp(bs, s->fd, 0, 1);
            goto unlock;
        }

        wp = &wps->wp[offset / bs->bl.zone_size];
        if (BDRV_ZT_IS_CONV(*wp)) {
            /* Conventional zones do not have a write pointer */
            goto unlock;
        }

        /* Return the written position for zone append */
        if (type & QEMU_AIO_ZONE_APPEND) {
            *s->offset = *wp;
            trace_zbd_zone_append_complete(bs,
                    *s->offset >> BDRV_SECTOR_BITS);
        }

        /* Advance the wp if needed */
        if (offset + bytes > *wp) {
            *wp = offset + bytes;
        }

unlock:
        qemu_co_mutex_unlock(&wps->colock);
    }
#endif

And making this entire block a helper function (e.g. advance_zone_wp()) would
further clean the code. But that should be done in another patch. Care to send one ?

-- 
Damien Le Moal
Western Digital Research


