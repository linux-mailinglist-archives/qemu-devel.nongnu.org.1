Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0070F16B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:50:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kC4-0005MZ-Hs; Wed, 24 May 2023 04:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1q1kBz-0005FD-Tz; Wed, 24 May 2023 04:50:00 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1q1kBw-0002ps-9I; Wed, 24 May 2023 04:49:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79809223C1;
 Wed, 24 May 2023 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684918193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glAGq8FAOzl9Z0cD6vEHxucS0SXRieRx2oKdSwuHHx0=;
 b=N5iqeEKcGWS5vYBlLhsbV4oitfKE28GR401uNHZv4yzAJY8FJR4B/gEZwSjrsOdw7HKTt6
 +IHnbFTZNRsGUzbU3NIV+lOTacAD6c2xfgTmZjdg1aDON5dekwCnIcG5KgUFyLz0WTIEvq
 qbr7OVQTVVGeySGWqVB+O3t9DlHtALs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684918193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glAGq8FAOzl9Z0cD6vEHxucS0SXRieRx2oKdSwuHHx0=;
 b=VYBLrpA6Yulfxire/8G+vrL6ISr2jorFJ2gDHntDhuN3yJqiwZaVoUGoVmTAyyMx8QhRqT
 Jyz6Xu4PWYLUnhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EE09133E6;
 Wed, 24 May 2023 08:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1KKbCbHPbWQ0aQAAMHmgww
 (envelope-from <cfontana@suse.de>); Wed, 24 May 2023 08:49:53 +0000
Message-ID: <232dd28c-9795-c52a-2d6d-627675c146b8@suse.de>
Date: Wed, 24 May 2023 10:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 4/6] Convert query-block/info_block to coroutine
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Jo=c3=a3o_Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-5-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230523213903.18418-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
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

On 5/23/23 23:39, Fabiano Rosas wrote:
> From: Lin Ma <lma@suse.com>
> 
> Sometimes the query-block performs time-consuming I/O(say waiting for
> the fstat of NFS complete), So let's make this QMP handler runs in a
> coroutine.
> 
> The following patch moves the fstat() into a thread pool.
> 
> Signed-off-by: Lin Ma <lma@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Apart from the wrong subject,

why is this change not including the update to:

hmp-commands-info.hx

like the previous one?

Thanks,

C

> ---
>  blockdev.c           | 6 +++---
>  qapi/block-core.json | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 5d56b79df4..6412548662 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2804,9 +2804,9 @@ void qmp_drive_backup(DriveBackup *backup, Error **errp)
>      blockdev_do_action(&action, errp);
>  }
>  
> -BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
> -                                                 bool flat,
> -                                                 Error **errp)
> +BlockDeviceInfoList *coroutine_fn qmp_query_named_block_nodes(bool has_flat,
> +                                                              bool flat,
> +                                                              Error **errp)
>  {
>      bool return_flat = has_flat && flat;
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index da95fe456c..0559c38412 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1972,7 +1972,8 @@
>  { 'command': 'query-named-block-nodes',
>    'returns': [ 'BlockDeviceInfo' ],
>    'data': { '*flat': 'bool' },
> -  'allow-preconfig': true }
> +  'allow-preconfig': true,
> +  'coroutine': true}
>  
>  ##
>  # @XDbgBlockGraphNodeType:


