Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7AC7E224A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 13:52:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzz4h-0001Y3-VT; Mon, 06 Nov 2023 07:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qzz4X-0001Qj-7S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qzz4T-0002sc-AC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699275070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzcSdznnd4F/p1z5YnPzclINpY3HO0H5wg5gaRnbH18=;
 b=Xr3uCY3hx1NE95P7ThKD5VXgx+5wKZFl18PgvAWohBOcy9wD6Nid6d+TvENKb0fdz2ihST
 8b2HubE7H8x5pmgZs03XBf4YWl4qjjEQBXLMVlT6izsSkYpkMoNDR6Zw71dw8KEd9Kwm1Z
 Xfi8115+0JSWYgo95pWb4dHIzmV8id8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-pA-OfynON66tDU1G1B5JYw-1; Mon, 06 Nov 2023 07:51:08 -0500
X-MC-Unique: pA-OfynON66tDU1G1B5JYw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50255b905so43584761fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 04:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699275067; x=1699879867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AzcSdznnd4F/p1z5YnPzclINpY3HO0H5wg5gaRnbH18=;
 b=eQmXH6it1qZFcO+1GYA0sY7DKASkCfWqErsroovsepBjsb5KoY3m1yZaYpXj3jmb6N
 MIZEYoIzxYxlCF7Gc9zy3Yhg7B4y1zB4RV+zmm35DJ4wvSZCHorhbf/xjPKvibRasn96
 tiwp3QE83WVid27ijVCt8A3JixK0HCRJ7b5yoa9MGtjWDKk4I9HdV28nKsSJH6APxuvL
 bVPg8XM7WHugdwbMObVwm4ISbFAsM4P6LaaGEuQG/Qk5+kQ/oWiMzda2BstJgd8o4S1A
 e7AXhmWTHsA28565OEab+XvRNGE2bQg9pjn7QypaT+FZO76vB8Wc0xSab69K0PMamEDg
 PlgA==
X-Gm-Message-State: AOJu0YzOErZ9Y86jc6/wHG1j8Y5uRh78/98Y3Gs+UOUE/MTOyd34RWAn
 GIk+xj59Cbk0fpey6XNr9ZmKI4YXQG1EilALwF8Ms8lt+SaEwxLK2yssSiqd9cqgk3MLIxzmyhd
 Ht/AWEKFmf/BlZGM=
X-Received: by 2002:a2e:a986:0:b0:2bc:c650:81b with SMTP id
 x6-20020a2ea986000000b002bcc650081bmr26773058ljq.15.1699275067283; 
 Mon, 06 Nov 2023 04:51:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdZLrXR9yMj5PcryzYoSidWZzFvzCx4Wv6i3LOJwuc+arSgJN1Qaddzl9c6Mf1mLVAD3NgZA==
X-Received: by 2002:a2e:a986:0:b0:2bc:c650:81b with SMTP id
 x6-20020a2ea986000000b002bcc650081bmr26773041ljq.15.1699275066885; 
 Mon, 06 Nov 2023 04:51:06 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c358600b004053a6b8c41sm11984973wmq.12.2023.11.06.04.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 04:51:06 -0800 (PST)
Message-ID: <622d78ae-1732-46e1-9e45-0a4bff8075df@redhat.com>
Date: Mon, 6 Nov 2023 13:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] block: Convert qmp_query_named_block_nodes to
 coroutine
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-8-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-8-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09.06.23 22:19, Fabiano Rosas wrote:
> From: Lin Ma <lma@suse.com>
>
> We're converting callers of bdrv_get_allocated_file_size() to run in
> coroutines because that function will be made asynchronous when called
> (indirectly) from the QMP dispatcher.
>
> This QMP command is a candidate because it indirectly calls
> bdrv_get_allocated_file_size() through bdrv_block_device_info() ->
> bdrv_query_image_info() -> bdrv_query_image_info().
>
> The previous patches have determined that bdrv_query_image_info() and
> bdrv_do_query_node_info() are coroutine-safe so we can just make the
> QMP command run in a coroutine.
>
> Signed-off-by: Lin Ma <lma@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block.c              | 2 +-
>   blockdev.c           | 6 +++---
>   qapi/block-core.json | 3 ++-
>   3 files changed, 6 insertions(+), 5 deletions(-)

(I see patch 9 does something with HMP code, but) hmp_info_block() calls 
qmp_query_named_block_nodes(), and I don’t think it may call such a 
coroutine_fn directly.

> diff --git a/block.c b/block.c
> index f94cee8930..abed744b60 100644
> --- a/block.c
> +++ b/block.c
> @@ -6148,7 +6148,7 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
>   
>       list = NULL;
>       QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
> -        BlockDeviceInfo *info = bdrv_block_device_info(NULL, bs, flat, errp);
> +        BlockDeviceInfo *info = bdrv_co_block_device_info(NULL, bs, flat, errp);

As far as I understand, only functions marked as coroutine_fn may call 
other coroutine_fn.  Regardless of whether bdrv_named_nodes_list() is 
only called by another coroutine_fn, we still have to mark it as 
coroutine_fn, too (and probably rename it to bdrv_co_named_nodes_list()).

Also, this function (bdrv_named_nodes_list()) uses 
GRAPH_RDLOCK_GUARD_MAINLOOP().  Is that the correct thing to use in a 
coroutine context?

Hanna

>           if (!info) {
>               qapi_free_BlockDeviceInfoList(list);
>               return NULL;
> diff --git a/blockdev.c b/blockdev.c
> index e6eba61484..8b5f7d06c8 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2818,9 +2818,9 @@ void qmp_drive_backup(DriveBackup *backup, Error **errp)
>       blockdev_do_action(&action, errp);
>   }
>   
> -BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
> -                                                 bool flat,
> -                                                 Error **errp)
> +BlockDeviceInfoList *coroutine_fn qmp_query_named_block_nodes(bool has_flat,
> +                                                              bool flat,
> +                                                              Error **errp)
>   {
>       bool return_flat = has_flat && flat;
>   
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5dd5f7e4b0..9d4c92f2c9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1972,7 +1972,8 @@
>   { 'command': 'query-named-block-nodes',
>     'returns': [ 'BlockDeviceInfo' ],
>     'data': { '*flat': 'bool' },
> -  'allow-preconfig': true }
> +  'allow-preconfig': true,
> +  'coroutine': true}
>   
>   ##
>   # @XDbgBlockGraphNodeType:


