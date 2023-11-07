Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C77E3620
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:56:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Gvg-0000Wh-Nc; Tue, 07 Nov 2023 02:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0GvY-0000Vz-Hs
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:55:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0GvW-0000xE-E4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699343708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeP7RdrtsCymmJHV4I1XRzRQym1UQzvDHM9sJcJxAm0=;
 b=L+X9B/rWYiSnQgB0zGSdkivTskdKv/Fn5GbN5LZC+w+DHnUepAxUvaFQyMDHBHJNl42Miz
 BbP24hET8RH6+SxCNEFMOrjG7f9DoWV58IAivyBNedbOmBeB93hyyEdh8b8lENLvM/T/B8
 +o92UFYN6uTnLT7WVFXyT5KajBejjTU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Vsyuuod4PO6xbQ9HwHH-ow-1; Tue, 07 Nov 2023 02:55:06 -0500
X-MC-Unique: Vsyuuod4PO6xbQ9HwHH-ow-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d87503d24so70644076d6.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 23:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699343706; x=1699948506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VeP7RdrtsCymmJHV4I1XRzRQym1UQzvDHM9sJcJxAm0=;
 b=fI7vVZl718VHyuarolofwXBr69Y7Y+wR+4lUXVbWyx8wOMTk9Kiq+QBdx9tV+wzs5V
 /GuaCzrMyGpnGkkdc8ArCp20HUhJccn2h25uY6rijKjnkrm0k6JcATGPCihbRljZ2qpU
 q0lO6SNvjjRbTxIeDT+hkWXs4FPNO5+q0ahzG+NnVwmFhQp2y4OwUViJrZMVBHtmWnR2
 C5xkdTbBK5nGLOyZfal45ZB7vz60AMZMabKBfq8IK+slIZL9ib0i/wFjNeXOOiJ6vafj
 GTJTtizICAWMQUnT/byROwTJgLGgxo1MXRmJLMRs6G1EDfSyXseGCx3d9CcqeWxulBMc
 EFGg==
X-Gm-Message-State: AOJu0Yzmxj3PMcXKbIZCyxBHxKcJZsuLdLMEQ6A+G1M04c9/nilZ6hHW
 aAWuh3npc0sFVcKji1Y2rkpP9U8WplH4I6d/a5pFfTZ1oUpfoVTo4eEchvENxVqzUrDIYua8q+M
 oCHlnmOdGvCG4SMc=
X-Received: by 2002:a05:6214:624:b0:671:560f:32fa with SMTP id
 a4-20020a056214062400b00671560f32famr29969893qvx.40.1699343706501; 
 Mon, 06 Nov 2023 23:55:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqLkcjMjVkh3uAidyUKs9yTcaREixeL3ccv+pooI5BNBqZV3+6JebGSa5BJw7+IRteEcPuzQ==
X-Received: by 2002:a05:6214:624:b0:671:560f:32fa with SMTP id
 a4-20020a056214062400b00671560f32famr29969887qvx.40.1699343706273; 
 Mon, 06 Nov 2023 23:55:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a05621401c600b0066cfb9cc087sm4163084qvt.134.2023.11.06.23.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 23:55:05 -0800 (PST)
Message-ID: <9282ab25-82ca-44e0-a2d6-0c4c015ca10f@redhat.com>
Date: Tue, 7 Nov 2023 08:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/snapshot: Fix compiler warning with
 -Wshadow=local
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20231023175038.111607-1-thuth@redhat.com>
 <87zg08vcwd.fsf@pond.sub.org> <875y2ws3vq.fsf@pond.sub.org>
 <dadc9fd6-b6c4-4824-81c1-07aa91f7723d@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <dadc9fd6-b6c4-4824-81c1-07aa91f7723d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 10/24/23 13:51, Thomas Huth wrote:
> On 24/10/2023 12.37, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> No need to declare a new variable in the the inner code block
>>>> here, we can re-use the "ret" variable that has been declared
>>>> at the beginning of the function. With this change, the code
>>>> can now be successfully compiled with -Wshadow=local again.
>>>>
>>>> Fixes: a32e781838 ("Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK")
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   v2: Assign "ret" only in one spot
>>>>
>>>>   block/snapshot.c | 6 ++----
>>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/block/snapshot.c b/block/snapshot.c
>>>> index 6e16eb803a..55974273ae 100644
>>>> --- a/block/snapshot.c
>>>> +++ b/block/snapshot.c
>>>> @@ -629,7 +629,6 @@ int bdrv_all_goto_snapshot(const char *name,
>>>>       while (iterbdrvs) {
>>>>           BlockDriverState *bs = iterbdrvs->data;
>>>>           AioContext *ctx = bdrv_get_aio_context(bs);
>>>> -        int ret = 0;
>>>>           bool all_snapshots_includes_bs;
>>>>           aio_context_acquire(ctx);
>>>> @@ -637,9 +636,8 @@ int bdrv_all_goto_snapshot(const char *name,
>>>>           all_snapshots_includes_bs = bdrv_all_snapshots_includes_bs(bs);
>>>>           bdrv_graph_rdunlock_main_loop();
>>>> -        if (devices || all_snapshots_includes_bs) {
>>>> -            ret = bdrv_snapshot_goto(bs, name, errp);
>>>> -        }
>>>> +        ret = (devices || all_snapshots_includes_bs) ?
>>>> +              bdrv_snapshot_goto(bs, name, errp) : 0;
>>>>           aio_context_release(ctx);
>>>>           if (ret < 0) {
>>>>               bdrv_graph_rdlock_main_loop();
>>>
>>> Better.  Unconditional assignment to @ret right before it's checked is
>>> how we should use @ret.
>>>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> And queued.  Thanks!
>>
>> Mind if I drop the Fixes: tag?  Nothing broken until we enable
>> -Wshadow=local...
> 
> Fine for me!

This looks like the last remaining warning. Are we going to activate
-Wshadow=local next ?

Thanks,

C.






