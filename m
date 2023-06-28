Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE37741606
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXey-0001YF-8G; Wed, 28 Jun 2023 12:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEXee-0001Kz-KC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEXeb-0004m4-5M
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687968264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdOj7QUz/AuRR4bas7CSoxXdBUstOoSAdAf2o8XtFMs=;
 b=LUtrPo9ydMrxkGmaTDKhjxWgM/RR0XQeL/ph79Ub9u/8vZPCgQih+H+rhJ9bDyEtPvyF2k
 VcX7D3XkhGDkmNyWkXHdfBc4ZdBms4SizY+W58XV7zLl8V1UVlp3pUEOy4vcQW5iM2j/sf
 tY+4GIWTNDWR0LlAiNhxQHYQlUCf0qs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-vqhS502XMFG7GkjhcIUUrA-1; Wed, 28 Jun 2023 12:04:06 -0400
X-MC-Unique: vqhS502XMFG7GkjhcIUUrA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4027c076023so44231cf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 09:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687968234; x=1690560234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdOj7QUz/AuRR4bas7CSoxXdBUstOoSAdAf2o8XtFMs=;
 b=a43zQJxjDSnZ8W+Z7NcRxz0PF7zqXQL4ewaWTdvv2AQXgqwW3LigG/gtrkggUTJRNB
 pPP1FcN4AbShscL49Mwm8LJ+xNewKi5atNh4qWbsl7ITfr+qRUKJgOmfMwph6SR2C/H6
 luwrsDkOxgDKhtmkPf018IwlEDhSdR0mRsqCMLKG+FAPX1SlViKfZymPkprPBZRftH9k
 LwaStmerMoyFwKAEbvBLwfSjadPpExAuhDTxDWiq0a/HyLLmy6RqvDIf3u9hU4P5/Vha
 6Iklt0xStSOM2/fdp03EwpKAaTal3OfspzNHY26XiA4+OmXWISWK4HXVMNkb1SOo8Ir1
 YOfQ==
X-Gm-Message-State: AC+VfDxNtBpwjS47tANuPQEnmXnBDRLxpkgeD8yn4OgNLRnQXSprNLwc
 f69zKsrFnX2BQuznz4GzNWh8fUAY1XoxXch+EhAFv3qk3Fv5cxpKE8QO4P2flYvJTwTZEgrg4yv
 hBwUCDTBbNjNbOXA=
X-Received: by 2002:ac8:5acc:0:b0:3fd:e410:73a9 with SMTP id
 d12-20020ac85acc000000b003fde41073a9mr39548323qtd.66.1687968233632; 
 Wed, 28 Jun 2023 09:03:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ot/BMeoXYhXE4mD3cFBQt9OZ5I1wyE/qEV7el1oMCOV9Vd/VaBsRqvOt3GA4CaQE5XZbw2w==
X-Received: by 2002:ac8:5acc:0:b0:3fd:e410:73a9 with SMTP id
 d12-20020ac85acc000000b003fde41073a9mr39548286qtd.66.1687968233286; 
 Wed, 28 Jun 2023 09:03:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 bt3-20020ac86903000000b003f9a79fe046sm3886370qtb.38.2023.06.28.09.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 09:03:53 -0700 (PDT)
Message-ID: <6e5a8ac8-6542-bdbb-473f-15e842902052@redhat.com>
Date: Wed, 28 Jun 2023 18:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] vfio/migration: Make VFIO migration
 non-experimental
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 qemu-devel@nongnu.org
References: <20230628073112.7958-1-avihaih@nvidia.com>
 <20230628073112.7958-3-avihaih@nvidia.com>
 <0b6b4262-5782-bdc1-428e-2b106411afd3@redhat.com>
 <b9c42787-0f8b-b458-0d8f-c691f7be5276@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <b9c42787-0f8b-b458-0d8f-c691f7be5276@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/28/23 16:51, Joao Martins wrote:
> On 28/06/2023 13:54, Cédric Le Goater wrote:
>> On 6/28/23 09:31, Avihai Horon wrote:
>>> The major parts of VFIO migration are supported today in QEMU. This
>>> includes basic VFIO migration, device dirty page tracking and precopy
>>> support.
>>>
>>> Thus, at this point in time, it seems appropriate to make VFIO migration
>>> non-experimental: remove the x prefix from enable_migration property,
>>> change it to ON_OFF_AUTO and let the default value be AUTO.
>>>
>>> In addition, make the following adjustments:
>>> 1. When enable_migration is ON and migration is not supported, fail VFIO
>>>      device realization.
>>> 2. When enable_migration is AUTO (i.e., not explicitly enabled), require
>>>      device dirty tracking support. This is because device dirty tracking
>>>      is currently the only method to do dirty page tracking, which is
>>>      essential for migrating in a reasonable downtime. Setting
>>>      enable_migration to ON will not require device dirty tracking.
>>> 3. Make migration error and blocker messages more elaborate.
>>> 4. Remove error prints in vfio_migration_query_flags().
>>> 5. Rename trace_vfio_migration_probe() to
>>>      trace_vfio_migration_realize().
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>
>>
>> We should rework the return value of most of the routines called by
>> vfio_migration_realize() and simply use a bool. I think Zhenzhong is
>> working it.
>>
>> Zhenzhong,
>>
>> When you resend v4 of the "VFIO migration related refactor and bug fix"
>> series, please rebase on this patch since it should be merged.
>>
> 
> This, and his switchover-ack series from Avihai that preceeds it.
> 
> Perhaps it might be easier to point to your tree:branch where you are queueing
> all the patches?
> 

Sure.

I track QEMU patches for various subsystems under :

  https://github.com/legoater/qemu

  
VFIO candidates are under :

   https://github.com/legoater/qemu/tree/vfio-8.1

This is a wip tree, patches come and go. It contains the VFIO patches of
the day/week, good for testing new ideas and checking CI.


The vfio-next branch contains what I am 90% sure to send upstream :

  https://github.com/legoater/qemu/tree/vfio-next

which I rebase on master and update with new proposals and new tags.

Beware, both are git push forced branches. Only master is not.


Cheers,

C.


