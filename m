Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8070F167
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kAo-0002BM-At; Wed, 24 May 2023 04:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1q1kAd-00024D-2o; Wed, 24 May 2023 04:48:35 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1q1kAR-0002VS-K7; Wed, 24 May 2023 04:48:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A9A7223E7;
 Wed, 24 May 2023 08:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684918100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8awv1LFcgczQ52mMGbVrNa2+cTuEcMZ6Y48Geq0PFIQ=;
 b=ZIes7ipetqt6x006tu06uaIOrI7DTUaP0Ho4/2R2dgKSmyVhcoVBULWLwn7nOQr3brPRLB
 JwGZAJOOO5e4bqUokGF4+d7fR2qt9mdFswz+heqyTSIJA0iGdf3pCs1X4EZpSJDQ7hqO6N
 KkrhOxuBNxPTGMnv3G04z479cVkizm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684918100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8awv1LFcgczQ52mMGbVrNa2+cTuEcMZ6Y48Geq0PFIQ=;
 b=VqrvCEw6erkAljIMENLJf1yBjCJurdMy5Tmx/pdWmiISqn3F9NH8saIWBiawKGjMPnz5iD
 6IdelFTkAfu73sCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2422B133E6;
 Wed, 24 May 2023 08:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xdBnBVTPbWQEaAAAMHmgww
 (envelope-from <cfontana@suse.de>); Wed, 24 May 2023 08:48:20 +0000
Message-ID: <e79cbb4a-7e79-d5d8-1f95-cb458af94ddf@suse.de>
Date: Wed, 24 May 2023 10:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 3/6] Convert query-block/info_block to coroutine
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Jo=c3=a3o_Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-4-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230523213903.18418-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/23/23 23:39, Fabiano Rosas wrote:
> From: Lin Ma <lma@suse.com>
> 
> Sometimes the query-block performs time-consuming I/O(say waiting for
> the fstat of NFS complete), So let's make this QMP handler runs in a
> coroutine.
> 
> The following patch moves the fstat() into a thread pool.


Hi, this message talks about QMP and query-block only and the subject talks about info_block as well.
We need to clarify this.

Also, lets make it clear that one is a QMP command, and the other is an HMP command.

In any case I would say:

"Convert QMP command query-block to use a coroutine", and in case we also need info_block, an additional patch could take care of the HMP command with a subject like:

"Convert HMP command info_block to use a coroutine".

Ciao,

Claudio


> 
> Signed-off-by: Lin Ma <lma@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  block/monitor/block-hmp-cmds.c | 2 +-
>  block/qapi.c                   | 2 +-
>  hmp-commands-info.hx           | 1 +
>  include/block/block-hmp-cmds.h | 2 +-
>  qapi/block-core.json           | 2 +-
>  5 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index ca2599de44..4b704010bc 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -738,7 +738,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>      }
>  }
>  
> -void hmp_info_block(Monitor *mon, const QDict *qdict)
> +void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict)
>  {
>      BlockInfoList *block_list, *info;
>      BlockDeviceInfoList *blockdev_list, *blockdev;
> diff --git a/block/qapi.c b/block/qapi.c
> index 79bf80c503..ae6cd1c2ff 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -667,7 +667,7 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
>      return s;
>  }
>  
> -BlockInfoList *qmp_query_block(Error **errp)
> +BlockInfoList *coroutine_fn qmp_query_block(Error **errp)
>  {
>      BlockInfoList *head = NULL, **p_next = &head;
>      BlockBackend *blk;
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 47d63d26db..996895f417 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -65,6 +65,7 @@ ERST
>          .help       = "show info of one block device or all block devices "
>                        "(-n: show named nodes; -v: show details)",
>          .cmd        = hmp_info_block,
> +        .coroutine  = true,
>      },
>  
>  SRST
> diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
> index 71113cd7ef..6d9152318f 100644
> --- a/include/block/block-hmp-cmds.h
> +++ b/include/block/block-hmp-cmds.h
> @@ -48,7 +48,7 @@ void hmp_eject(Monitor *mon, const QDict *qdict);
>  
>  void hmp_qemu_io(Monitor *mon, const QDict *qdict);
>  
> -void hmp_info_block(Monitor *mon, const QDict *qdict);
> +void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict);
>  void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
>  void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
>  void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 98d9116dae..da95fe456c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -838,7 +838,7 @@
>  #    }
>  ##
>  { 'command': 'query-block', 'returns': ['BlockInfo'],
> -  'allow-preconfig': true }
> +  'allow-preconfig': true, 'coroutine': true }
>  
>  ##
>  # @BlockDeviceTimedStats:


