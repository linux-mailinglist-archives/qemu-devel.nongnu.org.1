Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2C73330E
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAA4P-0001qY-1o; Fri, 16 Jun 2023 10:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qAA4N-0001qG-0x
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qAA4L-0005n2-4P
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686924291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tse9FEbqCfvkGIhQA9qQyGQPGBI3qyEj4Y3DdvOeQMI=;
 b=Llo4Ve+FJywVPB6nakQ5vXBCQ8D3YACTHZ4YkejdeJAvHHbrKwxxtQKwqa8Oap86At7STM
 5kXl7rFAz14oISqrLclLp+rs0zB8TpgSYnFHgzPFY1TsT6DY0nBvl8FTngmmWS7YGa+2LJ
 Oj7pOJhUr53XsoIGtn228ngpUh9mbpU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-NIac8U2GPjefqOqi_4XqbQ-1; Fri, 16 Jun 2023 10:04:49 -0400
X-MC-Unique: NIac8U2GPjefqOqi_4XqbQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f8f8e29771so2466995e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 07:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686924288; x=1689516288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tse9FEbqCfvkGIhQA9qQyGQPGBI3qyEj4Y3DdvOeQMI=;
 b=O4t+GuAin6WCmqBGSs1yJn9zhcdMR4wZp7S9feGIiCVv7RvcFUNGQL6pgYO3KN2wHt
 /Uw1+TvL1HhulggZddrMO/UvCIR6dCrtF3rkDUd2ZddyKljAgfeWcMog73vTszLLypqG
 v0IJYzVATh05GrnwzLeNDHC9vM1Un8MQQwEasSXCY2bIdQw76Y0eAWCrVMB1a5zMnFsN
 gKf/fm4pBqIHMgRLVFfLd0bLLxY9zdYLiDVxBTSVzWB7vmPPUNcCVemE6Y/WVgQ9mocw
 Xvl/87TxT2kOLm3w3GdBpF4iP11ywB2UEoadIE4ejPZRS15XDo2t2sU9ZDg8dzmHj8qb
 30+A==
X-Gm-Message-State: AC+VfDxziAtb1hkK3beu5B5ZtUB5KK4ROlkRQfYAylPDIYBTwZoZY0RV
 w5mkoyH9Ef2ZyiYofaWNQ7S94vbskTMBawlv8y8Ju8fDu7QhnlQiTLUtgwwdLlo+DP8ifAUbxwZ
 VU0ejtP5mzcDf0Sw=
X-Received: by 2002:a05:600c:5562:b0:3f7:ba55:d03e with SMTP id
 ja2-20020a05600c556200b003f7ba55d03emr7122813wmb.6.1686924288154; 
 Fri, 16 Jun 2023 07:04:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4P2u7m8pIPk1BwVIGp/wErk8BLAJ+dfDVBl/u+fzK1QjBV/n+ptSr0+1/jqgSSKftI0yYBpg==
X-Received: by 2002:a05:600c:5562:b0:3f7:ba55:d03e with SMTP id
 ja2-20020a05600c556200b003f7ba55d03emr7122793wmb.6.1686924287722; 
 Fri, 16 Jun 2023 07:04:47 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c294600b003f7e4639aabsm2322170wmd.10.2023.06.16.07.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 07:04:47 -0700 (PDT)
Message-ID: <c28aa967-ef65-a8be-8ae5-b04c604ba988@redhat.com>
Date: Fri, 16 Jun 2023 16:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
 <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
 <SJ0PR11MB674488BE146A88E35D763C639258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2f3ee2ab-e37b-c429-e604-b62440d37278@oracle.com>
 <SJ0PR11MB6744FA7630BA42F4DBFB30FA9258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b5023864-f56e-24b5-4e1b-007184484c2f@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <b5023864-f56e-24b5-4e1b-007184484c2f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/16/23 12:12, Joao Martins wrote:
> On 16/06/2023 10:53, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Sent: Friday, June 16, 2023 5:06 PM
>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-devel@nongnu.org;
>>> Peng, Chao P <chao.p.peng@intel.com>
>>> Subject: Re: [PATCH] vfio/migration: Fix return value of vfio_migration_realize()
>>>
>>> On 16/06/2023 03:42, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>> Sent: Thursday, June 15, 2023 6:23 PM
>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>> Cc: alex.williamson@redhat.com; clg@redhat.com;
>>>>> qemu-devel@nongnu.org; Peng, Chao P <chao.p.peng@intel.com>
>>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>>> vfio_migration_realize()
>>>>>
>>>>> On 15/06/2023 10:19, Duan, Zhenzhong wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>>> Sent: Thursday, June 15, 2023 4:54 PM
>>>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>>> Cc: alex.williamson@redhat.com; clg@redhat.com;
>>>>>>> qemu-devel@nongnu.org; Peng, Chao P <chao.p.peng@intel.com>
>>>>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>>>>> vfio_migration_realize()
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 15/06/2023 09:18, Zhenzhong Duan wrote:
>>>>>>>> We should print "Migration disabled" when migration is blocked in
>>>>>>>> vfio_migration_realize().
>>>>>>>>
>>>>>>>> Fix it by reverting return value of migrate_add_blocker(),
>>>>>>>> meanwhile error out directly once migrate_add_blocker() failed.
>>>>>>>>
>>>>>>>
>>>>>>> It wasn't immediately obvious from commit message that this is
>>>>>>> mainly about just printing an error message when blockers get added
>>>>>>> and that well
>>>>>>> migrate_add_blocker() returns 0 on success and caller of
>>>>>>> vfio_migration_realize expects the opposite when blockers are added.
>>>>>>>
>>>>>>> Perhaps better wording would be:
>>>>>>>
>>>>>>> migrate_add_blocker() returns 0 when successfully adding the
>>>>>>> migration blocker. However, the caller of vfio_migration_realize()
>>>>>>> considers that migration was blocked when the latter returned an
>>>>>>> error. Fix it by negating the return value obtained by
>>>>>>> migrate_add_blocker(). What matters for migration is that the
>>>>>>> blocker is added in core migration, so this cleans up usability
>>>>>>> such that user sees "Migrate disabled" when any of the vfio
>>>>>>> migration blockers are
>>>>> active.
>>>>>>
>>>>>> Great, I'll use your words.
>>>>>>
>>>>>>>
>>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>> ---
>>>>>>>>   hw/vfio/common.c    | 4 ++--
>>>>>>>>   hw/vfio/migration.c | 6 +++---
>>>>>>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>>>>>>> fa8fd949b1cf..8505385798f3 100644
>>>>>>>> --- a/hw/vfio/common.c
>>>>>>>> +++ b/hw/vfio/common.c
>>>>>>>> @@ -399,7 +399,7 @@ int
>>>>>>>> vfio_block_multiple_devices_migration(Error
>>>>>>> **errp)
>>>>>>>>           multiple_devices_migration_blocker = NULL;
>>>>>>>>       }
>>>>>>>>
>>>>>>>> -    return ret;
>>>>>>>> +    return !ret;
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   void vfio_unblock_multiple_devices_migration(void)
>>>>>>>> @@ -444,7 +444,7 @@ int vfio_block_giommu_migration(Error **errp)
>>>>>>>>           giommu_migration_blocker = NULL;
>>>>>>>>       }
>>>>>>>>
>>>>>>>> -    return ret;
>>>>>>>> +    return !ret;
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   void vfio_migration_finalize(void) diff --git
>>>>>>>> a/hw/vfio/migration.c b/hw/vfio/migration.c index
>>>>>>>> 6b58dddb8859..0146521d129a 100644
>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>> @@ -646,12 +646,12 @@ int vfio_migration_realize(VFIODevice
>>>>>>>> *vbasedev,
>>>>>>> Error **errp)
>>>>>>>>       }
>>>>>>>>
>>>>>>>>       ret = vfio_block_multiple_devices_migration(errp);
>>>>>>>> -    if (ret) {
>>>>>>>> +    if (ret || (errp && *errp)) {
>>>>>>>
>>>>>>> Why do you need this extra clause?
>>>>>>
>>>>>> Now that error happens, no need to add other blockers which will
>>>>>> fail for same reason.
>>>>>>
>>>>>
>>>>> But you don't need the (errp && *errp) for that as that's the whole
>>>>> point of negating the result.
>>>>>
>>>>> And if there's an error set it means migrate_add_blocker failed to
>>>>> add the blocker (e.g. snapshotting IIUC), and you would be failing here
>>> unnecessarily?
>>>>
>>>> If there is an error qdev_device_add() will fail, continue execution is
>>> meaningless here?
>>>> There is ERRP_GUARD in this path, so it looks (*errp) is enough.
>>>>
>>>> If I removed (errp && *errp) to continue, need below change to bypass
>>>> trace_vfio_migration_probe Do you prefer this way?
>>>>
>>>>      if (!*errp) {
>>>>          trace_vfio_migration_probe(vbasedev->name);
>>>>      }
>>>>
>>>
>>> I am mainly questioning that the error testing is correct to test here.
>>>
>>> IIUC, the only one that can propagate any *new* error in
>>> vfio_migration_realize is the calls to migrate_add_blocker failing within the
>>> vfio_block* (migration code suggests that this happens on snapshotting).
>>> Failing to add migration blocker just means we haven't installed any blockers.
>>> And the current code presents that as a "Migration disabled" case. If we want
>>> to preserve that behaviour on migration_add_blocker() failures (which seems
>>> like that's what you are doing here) then instead of this:
>>
>> Current behavior(without my patch):
>> "Migration disabled" isn't printed if migrate_add_blocker succeed.
>> "Migration disabled" is printed if migrate_add_blocker fail.
>>
>> I think this behavior isn't correct, I want to revert it not preserve it, so I used !ret.
>> Imagine we hotplug a vfio device when snapshotting, migrate_add_blocker failure
>> will lead to hotplug fail, then the guest is still migratable as no vfio plugged.
>> But we see "Migration disabled" which will confuse us.
>>
> 
> /me nods

Yes. Overall, the reason for which migration is not supported or is
disabled is not very clear today (for the user). It might need some
more adjustments, like this one, before we remove the experimental flag.
It will also help QE to define test scenarios and track expected results.

>   >>
>>> 	return !ret;
>>>
>>> you would do this:
>>>
>>> 	ret = migration_add_blocker(...);
>>> 	if (ret < 0) {
>>> 		error_free(...);
>>> 		blocker = NULL;
>>> +		return ret;
>>> 	}
>>>
>>> +	return 1;
>>>
>>> Or something like that. And then if you return early as you intended?
>>
>> Yes, this change make sense, I also want to add below:
>>
>>       if (!pdev->failover_pair_id) {
>>           ret = vfio_migration_realize(vbasedev, errp);
>> -        if (ret) {
>> +        if (ret > 0) {
>>               error_report("%s: Migration disabled", vbasedev->name);
>>           }
>>
> Makes sense. Checking errp above before printing the tracepoint (like you
> suggested) is also an option taking the discussion so far, but perhaps the
> return type to be bool to make it clear to callers that this is not no longer an
> error code? Maybe let's wait for others on what style is generally preferred in
> error propagation.

I think the code should follow the qdev_realize() prototype, which returns
a bool.

Thanks,

C.


