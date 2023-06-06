Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF747244B0
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:42:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Ww2-0003of-LF; Tue, 06 Jun 2023 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q6Wvs-0003ef-6X
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q6Wvm-000736-RO
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686058860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GBTOz+YyCX++vH3iUXEHKyw26euMXXfnV7kqyjV6XA=;
 b=V7MDtoQfSnrYjZp3bMbcrb+oxHUmrG6kedtHJbzk5UTZn6mxyZlujE1F6xIYSxctUoUdxy
 mros2QrBSwB6wKve9zdaYSzC0Cbtht1KGfMEo+kAKfneWt6jusUIKCJlie0hAdeBeI4TKs
 bu9lfaBxHGKZ/QkL+iPUp0rD38dSd7w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-IbaoYfEtO--lrzW4HC7FMA-1; Tue, 06 Jun 2023 09:40:59 -0400
X-MC-Unique: IbaoYfEtO--lrzW4HC7FMA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f739cc1aafso13813935e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686058854; x=1688650854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7GBTOz+YyCX++vH3iUXEHKyw26euMXXfnV7kqyjV6XA=;
 b=H3xN5nMoA8SXQEurZEIu8g+BypLZHNs+EYw0fVL89X8F+AugTH3Rwaxv5gNALAx15d
 iAJkOljfNNsJsewz0YPWto9ISnr28p4WgaJnB00lLTTqXoMSB11rtJ9o6zm8fxHLYbnU
 oRhVahzeCumLW9liZBaNgQnvl9kfnJYo0/t5PFdWryoOqo5507d7i9Fs+ayZZVetoXEU
 aKD7/a5aC/xuBe3WeanrXUHKmemtHHol0GyJlu8rAQcGcm8JgQsj8t923BunzohoOj4G
 9WfFxIHH/2dRq1WTEWfNemmjvWFoZnFW275tolSbPOVB8B1Mr2ADIaNENhxmjChiaDPL
 AvWA==
X-Gm-Message-State: AC+VfDxRU0i23Tgz6jSFxwdd0ROHJGFwGmo08Vnp/biZGLNKZSCVkTI4
 Gk0U+tkL3u0UNIY+L7T1/29B5bTH1/aUAQiR14T/5ZEhJ4jvJb/rBmWFiUuW33O/U/nMVGG8LDv
 gpC7nwJOUsF38yp4=
X-Received: by 2002:a7b:cd98:0:b0:3f6:2391:be99 with SMTP id
 y24-20020a7bcd98000000b003f62391be99mr2140782wmj.35.1686058854284; 
 Tue, 06 Jun 2023 06:40:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ehxI9xg3+2dUCXSKAXEB6d7tg6Dmkjx5LzA10u/Syr54n1CpqqW3Xr+EeRW4Pr1f6b8rZFw==
X-Received: by 2002:a7b:cd98:0:b0:3f6:2391:be99 with SMTP id
 y24-20020a7bcd98000000b003f62391be99mr2140760wmj.35.1686058853999; 
 Tue, 06 Jun 2023 06:40:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a1ced11000000b003f4266965fbsm17717006wmh.5.2023.06.06.06.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 06:40:53 -0700 (PDT)
Message-ID: <ffa8db05-aa4d-2ad7-3165-72c05b4de2d7@redhat.com>
Date: Tue, 6 Jun 2023 15:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-9-avihaih@nvidia.com>
 <20230601142231.78b15326.alex.williamson@redhat.com>
 <c3edcf5c-75c7-df60-8782-8cc9a8a31ccf@nvidia.com>
 <20230605085612.32f4ef95.alex.williamson@redhat.com>
 <9bb2d05c-d4e3-1d4a-ec99-2780895ae7c5@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9bb2d05c-d4e3-1d4a-ec99-2780895ae7c5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Avihai

On 6/6/23 13:59, Avihai Horon wrote:
> 
> On 05/06/2023 17:56, Alex Williamson wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Sun, 4 Jun 2023 12:33:43 +0300
>> Avihai Horon <avihaih@nvidia.com> wrote:
>>
>>> On 01/06/2023 23:22, Alex Williamson wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Tue, 30 May 2023 17:48:20 +0300
>>>> Avihai Horon <avihaih@nvidia.com> wrote:
>>>>
>>>>> Add a new VFIO device property x-allow-pre-copy to keep migration
>>>>> compatibility to/from older QEMU versions that don't have VFIO pre-copy
>>>>> support.
>>>> This doesn't make sense to me, vfio migration is not currently
>>>> supported, it can only be enabled via an experimental flag.  AFAIK we
>>>> have no obligation to maintain migration compatibility against
>>>> experimental features.  Is there any other reason we need a flag to
>>>> disable pre-copy?
>>> This could give flexibility to do migration between hosts without
>>> matching VFIO device kernel drivers. E.g., source driver doesn't have
>>> precopy support and dest driver has or vice versa.
>> If these are valid scenarios, the protocol should support negotiation
>> without requiring an experimental flag to do so.
> 
> Thinking again, the two intree drivers we have support precopy and as you said, this is still experimental, so I assume that we can drop this patch in v6.

No need to resend if there are no other changes.

Thanks,

C.

> 
>>
>>>> OTOH, should this series finally remove the experimental migration
>>>> flag?  Do we require Joao's vIOMMU support to finally make it
>>>> supportable?  Is there something else?
>>> I think that after precopy is accepted we can remove the experimental
>>> flag, as we'll have the major parts of VFIO migration upstream.
>>> After that we will still need to add Joao's vIOMMU support and P2P support.
>>> Do you want me to add a patch to this series that makes VFIO migration
>>> non-experimental?
>> I'd keep it as a separate patch with a clearly described dependency on
>> this series so that we can discuss it separately.
> 
> Sure, so I will post it separately.
> 
> Thanks.
> 
>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>    include/hw/vfio/vfio-common.h | 1 +
>>>>>    hw/core/machine.c             | 1 +
>>>>>    hw/vfio/migration.c           | 3 ++-
>>>>>    hw/vfio/pci.c                 | 2 ++
>>>>>    4 files changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>> index 1db901c194..a53ecbe2e0 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -146,6 +146,7 @@ typedef struct VFIODevice {
>>>>>        VFIOMigration *migration;
>>>>>        Error *migration_blocker;
>>>>>        OnOffAuto pre_copy_dirty_page_tracking;
>>>>> +    bool allow_pre_copy;
>>>>>        bool dirty_pages_supported;
>>>>>        bool dirty_tracking;
>>>>>    } VFIODevice;
>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>> index 1000406211..64ac3fe38e 100644
>>>>> --- a/hw/core/machine.c
>>>>> +++ b/hw/core/machine.c
>>>>> @@ -41,6 +41,7 @@
>>>>>
>>>>>    GlobalProperty hw_compat_8_0[] = {
>>>>>        { "migration", "multifd-flush-after-each-section", "on"},
>>>>> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>>>>>    };
>>>>>    const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>>>>
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index d8f6a22ae1..cb6923ed3f 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>>>>    {
>>>>>        VFIOMigration *migration = vbasedev->migration;
>>>>>
>>>>> -    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>>> +    return vbasedev->allow_pre_copy &&
>>>>> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>>>    }
>>>>>
>>>>>    /* ---------------------------------------------------------------------- */
>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>> index 73874a94de..c69813af7f 100644
>>>>> --- a/hw/vfio/pci.c
>>>>> +++ b/hw/vfio/pci.c
>>>>> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
>>>>>        DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>>>>>                                vbasedev.pre_copy_dirty_page_tracking,
>>>>>                                ON_OFF_AUTO_ON),
>>>>> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
>>>>> +                     vbasedev.allow_pre_copy, true),
>>>>>        DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>>>>                                display, ON_OFF_AUTO_OFF),
>>>>>        DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> 


