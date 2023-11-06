Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1B7E224B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 13:52:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzz4i-0001e3-EQ; Mon, 06 Nov 2023 07:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qzz4X-0001RB-C4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qzz4U-0002sw-8Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 07:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699275073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2JX8w7KK1WCoEJRlCU59BVi+/PnUZhVP6Z8jOiAw/A=;
 b=Na0yDq6VqabPx2SV3mjgmSh17zbbfOq8GDJCj0jnPhmbEQQglDaYirn26C7qwKsAiLjJ0f
 iPAIJYAypGdjGXDzKIHq6CEYssG5xXGBq9rkao7gKxfQqm6UkG308RDlaFUI+noyPRLkga
 GZbzYKjaxeouRaTjjur29CWayqrQlro=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-ExQfUs9oMrivPSFfHn3n4w-1; Mon, 06 Nov 2023 07:51:11 -0500
X-MC-Unique: ExQfUs9oMrivPSFfHn3n4w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c503804667so48972731fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 04:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699275070; x=1699879870;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a2JX8w7KK1WCoEJRlCU59BVi+/PnUZhVP6Z8jOiAw/A=;
 b=dvzi87BZzvYz9knQ3fuy5t3JwRBmenp9SN1q8uia/DzEo9n2/ORuhDYDnO5IMi7sox
 MvhxgDWxrpFyngmBVMcJ1vNQC2UM1F+Me5D7n23gmsjg88yBiGgUfU0eeeqpoGuRimdF
 cwxoV8CRCR/ALMPc0DiW/RrXBaQSKmzBxz6LLevVsnevoQQRFYdrOvGk9iIDgN96n0VE
 Mk/dHT9fB2W4fXvbRaXuojqfVmnZUXijgC2l6zu91e0cGJ/8l1FCTeP6ZHMj6I54WGyO
 skJe3no5gGs3792L2zWPw+BNbzITOJhBEyiWN9rK8/xuc7pCpEjNfCjoLeRDJdzZWPUQ
 XCfw==
X-Gm-Message-State: AOJu0YyeZQaG9MvqA0Sczyb9oRmSDv9+hXo66T8VxeQWkc0HPNEg9jVR
 KNTa+uDI/Ee0agg/UpjI2oZSMYBiJvWCTStwUXH+ezPrW2z8tPU6cdcvsJgxFvvdwFNrZB1TQKU
 3ZCQh92xx2vO591Y=
X-Received: by 2002:a2e:90d5:0:b0:2c5:12b:6ef2 with SMTP id
 o21-20020a2e90d5000000b002c5012b6ef2mr22194975ljg.33.1699275070422; 
 Mon, 06 Nov 2023 04:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE29DgsM2rDLiwyf6xJ7hNMnEJXJBN06Nt8kiXeZMzN67q2yv5V5CoMFdq5EFfMXQIuM06Zmw==
X-Received: by 2002:a2e:90d5:0:b0:2c5:12b:6ef2 with SMTP id
 o21-20020a2e90d5000000b002c5012b6ef2mr22194964ljg.33.1699275070226; 
 Mon, 06 Nov 2023 04:51:10 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c358600b004053a6b8c41sm11984973wmq.12.2023.11.06.04.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 04:51:09 -0800 (PST)
Message-ID: <c83eaf27-87de-421f-928a-f40745a7ac25@redhat.com>
Date: Mon, 6 Nov 2023 13:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] block: Convert bdrv_block_device_info into
 co_wrapper
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-7-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-7-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> We're converting callers of bdrv_get_allocated_file_size() to run in
> coroutines because that function will be made asynchronous when called
> (indirectly) from the QMP dispatcher.
>
> This function is a candidate because it calls bdrv_query_image_info()
> -> bdrv_do_query_node_info() -> bdrv_get_allocated_file_size().
>
> It is safe to turn this is a coroutine because the code it calls is
> made up of either simple accessors and string manipulation functions
> [1] or it has already been determined to be safe [2].
>
> 1) bdrv_refresh_filename(), bdrv_is_read_only(),
>     blk_enable_write_cache(), bdrv_cow_bs(), blk_get_public(),
>     throttle_group_get_name(), bdrv_write_threshold_get(),
>     bdrv_query_dirty_bitmaps(), throttle_group_get_config(),
>     bdrv_filter_or_cow_bs(), bdrv_skip_implicit_filters()
>
> 2) bdrv_do_query_node_info() (see previous commit);
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block/qapi.c         |  8 ++++----
>   include/block/qapi.h | 12 ++++++++----
>   2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/block/qapi.c b/block/qapi.c
> index a2e71edaff..20660e15d6 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -41,10 +41,10 @@
>   #include "qemu/qemu-print.h"
>   #include "sysemu/block-backend.h"
>   
> -BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
> -                                        BlockDriverState *bs,
> -                                        bool flat,
> -                                        Error **errp)
> +BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
> +                                                        BlockDriverState *bs,
> +                                                        bool flat,
> +                                                        Error **errp)
>   {
>       ImageInfo **p_image_info;
>       ImageInfo *backing_info;
> diff --git a/include/block/qapi.h b/include/block/qapi.h
> index 7035bcd1ae..5cb0202791 100644
> --- a/include/block/qapi.h
> +++ b/include/block/qapi.h
> @@ -30,10 +30,14 @@
>   #include "block/snapshot.h"
>   #include "qapi/qapi-types-block-core.h"
>   
> -BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
> -                                        BlockDriverState *bs,
> -                                        bool flat,
> -                                        Error **errp);
> +BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
> +                                                        BlockDriverState *bs,
> +                                                        bool flat,
> +                                                        Error **errp);
> +BlockDeviceInfo *co_wrapper bdrv_block_device_info(BlockBackend *blk,
> +                                                   BlockDriverState *bs,
> +                                                   bool flat,
> +                                                   Error **errp);

bdrv_co_block_device_info() is now marked as GRAPH_RDLOCK, so should 
this use a co_wrapper_bdrv_rdlock instead?

Hanna

>   int bdrv_query_snapshot_info_list(BlockDriverState *bs,
>                                     SnapshotInfoList **p_list,
>                                     Error **errp);


