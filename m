Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401070F0DD
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jur-0001TK-Hf; Wed, 24 May 2023 04:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1q1jud-0001Qw-8b; Wed, 24 May 2023 04:32:03 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1q1jua-0007jZ-2O; Wed, 24 May 2023 04:32:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 967FA1FDCF;
 Wed, 24 May 2023 08:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684917114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yd4ZFX17Vs9h9jWCks9s94SKiG9UvqG57Sy1xGFFpeE=;
 b=tRhJX8zsLa64vwfKyQoYR63gQjHBOp1Bv1l8RldXf2yIUsFz9lh/VOWz67KGn2nqdwOdst
 VVrVITdZ1GZURbmdEXEG2XX0CgDUEey3hvN0Q+Q8xO2z4ozkpL5NqrsxK8FH7FFWk3KpLK
 B4fhWJ6+n89QULI/IPTZeJ+y+zBWMAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684917114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yd4ZFX17Vs9h9jWCks9s94SKiG9UvqG57Sy1xGFFpeE=;
 b=qD5Mo3Afe7tPAwtShGfIrgyA1FYVkO0/kpCvzePEYqmqB/+SOlUcInOjVKaAhcvTi2cEup
 1U4Sa7k6T78pECCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F2DF133E6;
 Wed, 24 May 2023 08:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zKG4DXrLbWRyXwAAMHmgww
 (envelope-from <cfontana@suse.de>); Wed, 24 May 2023 08:31:54 +0000
Message-ID: <e2ceeeef-3c12-f467-0ef0-2bd90ea40f43@suse.de>
Date: Wed, 24 May 2023 10:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 1/6] block: Remove bdrv_query_block_node_info
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Jo=c3=a3o_Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-2-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230523213903.18418-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 23:38, Fabiano Rosas wrote:
> The last call site of this function has been removed by commit
> c04d0ab026 ("qemu-img: Let info print block graph").
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  block/qapi.c         | 27 ---------------------------
>  include/block/qapi.h |  3 ---
>  2 files changed, 30 deletions(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index f34f95e0ef..79bf80c503 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -309,33 +309,6 @@ out:
>      aio_context_release(bdrv_get_aio_context(bs));
>  }
>  
> -/**
> - * bdrv_query_block_node_info:
> - * @bs: block node to examine
> - * @p_info: location to store node information
> - * @errp: location to store error information
> - *
> - * Store image information about @bs in @p_info.
> - *
> - * @p_info will be set only on success. On error, store error in @errp.
> - */
> -void bdrv_query_block_node_info(BlockDriverState *bs,
> -                                BlockNodeInfo **p_info,
> -                                Error **errp)
> -{
> -    BlockNodeInfo *info;
> -    ERRP_GUARD();
> -
> -    info = g_new0(BlockNodeInfo, 1);
> -    bdrv_do_query_node_info(bs, info, errp);
> -    if (*errp) {
> -        qapi_free_BlockNodeInfo(info);
> -        return;
> -    }
> -
> -    *p_info = info;
> -}
> -
>  /**
>   * bdrv_query_image_info:
>   * @bs: block node to examine
> diff --git a/include/block/qapi.h b/include/block/qapi.h
> index 18d48ddb70..8663971c58 100644
> --- a/include/block/qapi.h
> +++ b/include/block/qapi.h
> @@ -36,9 +36,6 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>  int bdrv_query_snapshot_info_list(BlockDriverState *bs,
>                                    SnapshotInfoList **p_list,
>                                    Error **errp);
> -void bdrv_query_block_node_info(BlockDriverState *bs,
> -                                BlockNodeInfo **p_info,
> -                                Error **errp);
>  void bdrv_query_image_info(BlockDriverState *bs,
>                             ImageInfo **p_info,
>                             bool flat,

Reviewed-by: Claudio Fontana <cfontana@suse.de>

