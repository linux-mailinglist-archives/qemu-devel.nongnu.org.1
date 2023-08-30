Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E4F78D428
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGhY-0002yr-6e; Wed, 30 Aug 2023 04:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qbGhV-0002yT-N8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qbGhT-0005Am-Es
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwEAGIuiJoiBTkWO5FVO8g6CL4/9kEf3F4HCjl8WHxg=;
 b=cu5GhksjcLttecaF79tAcwDhpEGoswlBjg7HrI0CCGCQkVv3M2mtqUclga2IDGqcVUIHnR
 MSyzBOPdjm8XsaN+EiETfUhQ8jUn5BVRro0iLsgsazPKMarKmA1pWzgdicyKJTttz447uN
 5yrjUbiFL1N5adC6dRmhRw+l9yW1InI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-13HFL3tCOzOqNHmU5gPMBA-1; Wed, 30 Aug 2023 04:37:17 -0400
X-MC-Unique: 13HFL3tCOzOqNHmU5gPMBA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5007f3d3255so5924297e87.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384635; x=1693989435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LwEAGIuiJoiBTkWO5FVO8g6CL4/9kEf3F4HCjl8WHxg=;
 b=Oxa8fWAk3NNhhpdTx5FbxPRC72ystxoEmKFkZte4jmDNZ3G5afXphOqq85AxcO8WmC
 IQc0TXCwpGa/jRVrsTWGs4fBBnwMxDmSKVT9Cd01lyqTtw2WPBOXHpborUL+mBT4/Oa9
 yDpFsOilHRhya/q5vUHiyMbfNV9uBBoR5thOsBXqSkG8wBRzcWIo+KOU1RM67NDxXbNG
 fHVqLTXqSEiweRshPRZxpBC+UH7DUNCcRj1vps4AE+V3iSSqMAHpGTGgXzpPdJ/1K1xr
 vqPzskw66N4366j0o/RAOdP9GE3murogb/YPS3dYvgmRlykrKiS1SO+nuAgH8+St+pDy
 NEyQ==
X-Gm-Message-State: AOJu0Yy4D/CLz8quVgvdWDlBZFx+D08B6JOzw992yqtt9WGoC3LksXBA
 MWAy+5OtdSbsqp59I1c0VSNYCXywZ51f9f4+PXI9YC2sBsiyb/5VSRXQt9fOfDLbIKnhrtyCe39
 qpKgxyqx9VLOSwmc=
X-Received: by 2002:a19:3814:0:b0:500:a408:dbd with SMTP id
 f20-20020a193814000000b00500a4080dbdmr1042777lfa.55.1693384635554; 
 Wed, 30 Aug 2023 01:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY54MlJo2MrN42GQiA9jzVitmWNxm5C5O320PFpPfdGtAW+AQ/zXm2FPiHLhQUluQZeUBnmQ==
X-Received: by 2002:a19:3814:0:b0:500:a408:dbd with SMTP id
 f20-20020a193814000000b00500a4080dbdmr1042765lfa.55.1693384635213; 
 Wed, 30 Aug 2023 01:37:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a7bc7d1000000b003fc0505be19sm1516900wmk.37.2023.08.30.01.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 01:37:14 -0700 (PDT)
Message-ID: <b900cc98-49fe-219b-4be0-a4b8eb36e1a4@redhat.com>
Date: Wed, 30 Aug 2023 10:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
 <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com> <ZO44klknC6hpd7mf@x1n>
 <adb00739-3074-dc16-bb24-1e42cbbdd50a@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <adb00739-3074-dc16-bb24-1e42cbbdd50a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/30/23 09:01, Avihai Horon wrote:
> 
> On 29/08/2023 21:27, Peter Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
>>> On 29/08/2023 17:53, Peter Xu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>> index 1d1e1321b0..e201053563 100644
>>>>> --- a/migration/options.c
>>>>> +++ b/migration/options.c
>>>>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>>>>                error_setg(errp, "Postcopy is not yet compatible with multifd");
>>>>>                return false;
>>>>>            }
>>>>> +
>>>>> +        if (migration_vfio_mig_active()) {
>>>>> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
>>>>> +            return false;
>>>>> +        }
>>>> Hmm.. this will add yet another vfio hard-coded line into migration/..
>>>>
>>>> What will happen if the vfio device is hot plugged after enabling
>>>> postcopy-ram here?
>>> In that case a migration blocker will be added.
>>>
>>>> Is it possible to do it in a generic way?
>>> What comes to my mind is to let devices register a handler for a "caps
>>> change" notification and allow them to object.
>>> But maybe that's a bit of an overkill.
>> This one also sounds better than hard-codes to me.
>>
>>>> I was thinking the only unified place to do such check is when migration
>>>> starts, as long as we switch to SETUP all caps are locked and doesn't allow
>>>> any change until it finishes or fails.
>>>>
>>>> So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
>>>> to fail the whole migration early?  For example, maybe we should have an
>>>> Error** passed in, then if it fails it calls migrate_set_error, so
>>>> reflected in query-migrate later too.
>>> Yes, I think this could work and it will simplify things because we could
>>> also drop the VFIO migration blockers code.
>>> The downside is that the user will know migration is blocked only when he
>>> tries to migrate, and migrate_caps_check() will not block setting postcopy
>>> when a VFIO device is already attached.
>>> I don't have a strong opinion here, so if it's fine by you and everyone
>>> else, I could change that to what you suggested.
>> Failing later would be fine in this case to me; my expectation is VFIO
>> users should be advanced already anyway (as the whole solution is still
>> pretty involved comparing to a generic VM migration) and shouldn't try to
>> trigger that at all in real life.  IOW I'd expect this check will be there
>> just for sanity, rather than being relied on to let people be aware of it
>> by the error message.
> 
> Yes, I agree with you.
> 
>>
>> Meanwhile the blocker + caps check is slightly complicated to me to guard
>> both sides.  So I'd vote for failing at the QMP command.  But we can wait
>> and see whether there's other votes.
> 
> Sure.
> So I will do the checking in vfio_save_setup(), unless someone else has a better idea.

Just to recap for my understanding,

vfio_save_setup() would test migrate_postcopy_ram() and update a new
'Error *err' parameter of the .save_setup() op which would be taken
into account in qemu_savevm_state_setup(). Is that correct ?


Thanks,

C.


