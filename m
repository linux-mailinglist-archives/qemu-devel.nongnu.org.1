Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AE78D578
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJD4-0001ne-GI; Wed, 30 Aug 2023 07:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qbJD1-0001js-AB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qbJCy-0005Jk-Tg
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693394280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qB5he+8NMnegRxw7N2VaGdtqtCBe7uspOhMUzxOFUM4=;
 b=RHr5EWxDau2VmMCjMeHr6LQ6rCT07TdoItTuL6td98nyV64idy0KI0XkkUQNHSpW/b4xPz
 LKr4tU1I02HorMpJpFqziMAufdeHRxY9m/a0aytRoT5hgPhCGZW90K6swSYAYonlDVdRhZ
 vMUXex1AIBLwRNi/PApVqHm3jY+y8wc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-U-EZCH0GPiy5IY07buytpw-1; Wed, 30 Aug 2023 07:17:59 -0400
X-MC-Unique: U-EZCH0GPiy5IY07buytpw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76ef8b91a84so60311685a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 04:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693394278; x=1693999078;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qB5he+8NMnegRxw7N2VaGdtqtCBe7uspOhMUzxOFUM4=;
 b=aaSZ4ACoZS9U4x/ydt3vf8FCIzYY73hOWbLMcYnI1S7ffu4ECU7dP5b4bTsSRXkHS6
 JVcMrBNPJ3mY3RKxR3/ZkGn6LKK2oOrGaGYtEHDpmqy62RgFSqd7w+JzJ4um2/9it+gB
 2y/hEQhdCX5Wbenhuu6wASUmIRqRVFYqqvvA04M306tuwndLlgp4dgan3ZdBJQrr6D21
 HxweJeDJuJkJieeoQ87JFf5l8WpgpNTxHLjHPZYk9tOC7x9crydyd6tlqxYrUA5+QfcB
 ix5T67YHDP2OUtXWN5TxJ3dnXI6IxlW02rExENxvwFxgAkZpmRqkEovxpFzPA6EVq3aX
 LUBA==
X-Gm-Message-State: AOJu0YwuVveV+Yv325XQur37/+sdCjsgUNBKdIPrShBrGLvCmy+q5AEi
 LhYJW8/XsXDHINQtt3HCCAmwLSPNHxlaYXGNpmvxCP8OB1YW/vn6SbWVVRIrNX7IH4MutxXtepu
 5wDuU6fvJFkIsWLY=
X-Received: by 2002:a05:620a:e9b:b0:76c:e566:2dab with SMTP id
 w27-20020a05620a0e9b00b0076ce5662dabmr1952331qkm.33.1693394278563; 
 Wed, 30 Aug 2023 04:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ99aYDpxbciyf3QKzFrau7H98ZHGwfeiCEObytGjsbwMOt9vOrPegIlxXFg6um2Lal83Brg==
X-Received: by 2002:a05:620a:e9b:b0:76c:e566:2dab with SMTP id
 w27-20020a05620a0e9b00b0076ce5662dabmr1952308qkm.33.1693394278286; 
 Wed, 30 Aug 2023 04:17:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a05620a12f700b0076ef0fb5050sm3716157qkl.31.2023.08.30.04.17.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 04:17:57 -0700 (PDT)
Message-ID: <95a37158-3ded-3930-ebf9-e33df4416cec@redhat.com>
Date: Wed, 30 Aug 2023 13:17:55 +0200
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
 <b900cc98-49fe-219b-4be0-a4b8eb36e1a4@redhat.com>
 <e3d3b6f8-2877-620e-66eb-6d3a53d65bc6@nvidia.com>
 <d036904b-6106-2cfd-6533-70f0f70fea2f@redhat.com>
 <2ce812f6-3372-fd3d-b0f3-46f12a9dc64c@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <2ce812f6-3372-fd3d-b0f3-46f12a9dc64c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 8/30/23 12:12, Avihai Horon wrote:
> 
> On 30/08/2023 12:53, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/30/23 11:21, Avihai Horon wrote:
>>>
>>> On 30/08/2023 11:37, Cédric Le Goater wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 8/30/23 09:01, Avihai Horon wrote:
>>>>>
>>>>> On 29/08/2023 21:27, Peter Xu wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
>>>>>>> On 29/08/2023 17:53, Peter Xu wrote:
>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>
>>>>>>>>
>>>>>>>> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>>>>>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>>>>>> index 1d1e1321b0..e201053563 100644
>>>>>>>>> --- a/migration/options.c
>>>>>>>>> +++ b/migration/options.c
>>>>>>>>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>>>>>>>>                error_setg(errp, "Postcopy is not yet compatible with multifd");
>>>>>>>>>                return false;
>>>>>>>>>            }
>>>>>>>>> +
>>>>>>>>> +        if (migration_vfio_mig_active()) {
>>>>>>>>> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
>>>>>>>>> +            return false;
>>>>>>>>> +        }
>>>>>>>> Hmm.. this will add yet another vfio hard-coded line into migration/..
>>>>>>>>
>>>>>>>> What will happen if the vfio device is hot plugged after enabling
>>>>>>>> postcopy-ram here?
>>>>>>> In that case a migration blocker will be added.
>>>>>>>
>>>>>>>> Is it possible to do it in a generic way?
>>>>>>> What comes to my mind is to let devices register a handler for a "caps
>>>>>>> change" notification and allow them to object.
>>>>>>> But maybe that's a bit of an overkill.
>>>>>> This one also sounds better than hard-codes to me.
>>>>>>
>>>>>>>> I was thinking the only unified place to do such check is when migration
>>>>>>>> starts, as long as we switch to SETUP all caps are locked and doesn't allow
>>>>>>>> any change until it finishes or fails.
>>>>>>>>
>>>>>>>> So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
>>>>>>>> to fail the whole migration early?  For example, maybe we should have an
>>>>>>>> Error** passed in, then if it fails it calls migrate_set_error, so
>>>>>>>> reflected in query-migrate later too.
>>>>>>> Yes, I think this could work and it will simplify things because we could
>>>>>>> also drop the VFIO migration blockers code.
>>>>>>> The downside is that the user will know migration is blocked only when he
>>>>>>> tries to migrate, and migrate_caps_check() will not block setting postcopy
>>>>>>> when a VFIO device is already attached.
>>>>>>> I don't have a strong opinion here, so if it's fine by you and everyone
>>>>>>> else, I could change that to what you suggested.
>>>>>> Failing later would be fine in this case to me; my expectation is VFIO
>>>>>> users should be advanced already anyway (as the whole solution is still
>>>>>> pretty involved comparing to a generic VM migration) and shouldn't try to
>>>>>> trigger that at all in real life.  IOW I'd expect this check will be there
>>>>>> just for sanity, rather than being relied on to let people be aware of it
>>>>>> by the error message.
>>>>>
>>>>> Yes, I agree with you.
>>>>>
>>>>>>
>>>>>> Meanwhile the blocker + caps check is slightly complicated to me to guard
>>>>>> both sides.  So I'd vote for failing at the QMP command. But we can wait
>>>>>> and see whether there's other votes.
>>>>>
>>>>> Sure.
>>>>> So I will do the checking in vfio_save_setup(), unless someone else has a better idea.
>>>>
>>>> Just to recap for my understanding,
>>>>
>>>> vfio_save_setup() would test migrate_postcopy_ram() and update a new
>>>> 'Error *err' parameter of the .save_setup() op which would be taken
>>>> into account in qemu_savevm_state_setup(). Is that correct ?
>>>>
>>> Yes.
>>> But I wonder if it would be simpler to call migrate_set_error() directly from vfio_save_setup() instead of adding "Error *err" argument to .save_setup() and changing all other users.
>>> What do you prefer?
>>
>> Well, with my downstreamer hat, I would prefer a simpler solution for the
>> VFIO postcopy limitation first. That said, there is value in adding
>> a 'Error *' parameter to the .save_setup() op and letting the top routine
>> qemu_savevm_state_setup() propagate. Other SaveVMhandler could start using
>> it. even VFIO has multiple error_report() in vfio_save_setup() which could
>> be propagated to the top callers.
>>
>> Let's try that first. I will check your new series on top of 8.0
>>
> OK, so just making sure, you want to add "Error *err" argument to .save_setup() first and see how it goes, right?

yes. Sorry. that was not clear.

Thanks

C.


