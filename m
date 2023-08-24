Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C858787C1A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZK5A-00068D-No; Thu, 24 Aug 2023 19:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qZK55-000681-KG; Thu, 24 Aug 2023 19:49:39 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qZK53-0006fy-ES; Thu, 24 Aug 2023 19:49:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE4D634D4;
 Thu, 24 Aug 2023 23:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4921DC433C7;
 Thu, 24 Aug 2023 23:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692920972;
 bh=3qFAQ24vgEKkxl9isqOyiONufc7rik7dqxcydUEvpMA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=So0Hid5lJxFPWUe1ZLgHrQaGQuo541uq/w4KACzuPYT9Nc+HktyFzlqgfUtnjzh+6
 iynBG9nb/Ni4331XEFk44FlnMJO1MBJy7daGqJFo+SCXJMTDDRY/mCWFUzEvxVpNOi
 Obh2X7o65THyseQSXKHY/VTtY5jrQxzSL7Kc9ZE/V7+6JyxkYXBU4lQE3QpCZ1jcp4
 tJgRd0tmTinHekoRhJLDAxwo8gunRVJu+2eMHlNlJ/w+WdZ2oDOSCz1HyeNXwZ3iyp
 rIfo/yu2gN6R3yoFXfT/nuuZrPeAhHEnf3VFo3cztSmGYZdJgZiZGLJKDuysolFDiU
 oqh7iCxf2LB/g==
Message-ID: <8ec9d245-d729-2dd5-11de-e437bd37cdb8@kernel.org>
Date: Fri, 25 Aug 2023 08:49:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] block/file-posix: fix update_zones_wp() caller
Content-Language: en-US
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com, hare@suse.de, dmitry.fomichev@wdc.com,
 Hanna Reitz <hreitz@redhat.com>
References: <20230824173957.8472-1-faithilikerun@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230824173957.8472-1-faithilikerun@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=dlemoal@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -99
X-Spam_score: -10.0
X-Spam_bar: ----------
X-Spam_report: (-10.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On 8/25/23 02:39, Sam Li wrote:
> When the zoned requests that may change wp fail, it needs to
> update only wps of the zones within the range of the requests
> for not disrupting the other in-flight requests. The wp is updated
> successfully after the request completes.
> 
> Fixed the callers with right offset and nr_zones.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b16e9c21a1..22559d6c2d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2522,7 +2522,8 @@ out:
>          }
>      } else {
>          if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> -            update_zones_wp(bs, s->fd, 0, 1);
> +            update_zones_wp(bs, s->fd, offset,
> +                            ROUND_UP(bytes, bs->bl.zone_size));

Write and zone append operations are not allowed to cross zone boundaries. So I
the number of zones should always be 1. The above changes a number of zones to a
number of bytes, which seems wrong. The correct fix is I think:

		update_zones_wp(bs, s->fd, offset, 1);

>          }
>      }
>  
> @@ -3472,7 +3473,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
>                          len >> BDRV_SECTOR_BITS);
>      ret = raw_thread_pool_submit(handle_aiocb_zone_mgmt, &acb);
>      if (ret != 0) {
> -        update_zones_wp(bs, s->fd, offset, i);
> +        update_zones_wp(bs, s->fd, offset, nrz);

Same here. Why would you need to update all zones wp ? This will affect zones
that do not have a write error and potentially change there correct in-memory wp
to a wrong value. I think this also should be:

	   update_zones_wp(bs, s->fd, offset, 1);

>          error_report("ioctl %s failed %d", op_name, ret);
>          return ret;
>      }

-- 
Damien Le Moal
Western Digital Research


