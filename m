Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2878D4F0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHt4-0002Zk-3r; Wed, 30 Aug 2023 05:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qbHt1-0002Z9-SI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qbHsx-00044x-0V
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693389191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2i8NEaOovph6hXZj4S5sMxE4BVLqkndB1NT0oQRhK6o=;
 b=R+iu0nXjPmq6wrKWsf+kUXBvkL6xYKw1MBAbKS30bhcpKMiFAfuEwb4GhoqMV8cLzrOnW3
 JmkYLpwi+CuDMKigmmLpcMM8Er2v4Feb/9zrDYB9Yk3T+QYmw0y0OmpjJXmzh4bO9d/iFq
 Je4BBInlY9DnOcNXMGG7WkzCg+WGhUw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-wtvvxe44PUqpl3oI3t-CGg-1; Wed, 30 Aug 2023 05:53:10 -0400
X-MC-Unique: wtvvxe44PUqpl3oI3t-CGg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so3438100f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 02:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693389189; x=1693993989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2i8NEaOovph6hXZj4S5sMxE4BVLqkndB1NT0oQRhK6o=;
 b=Yqvtr3/k4iqaNWD3BzU1OamgN6vFVc//QvQqbsB3lBQb+DNcurZC5uEIDGspzJ5gQ+
 z+B0XF59s7g8AZkzJsZzLP8RC9VZ2E7NscWHziDCZJzHE0VqGa5ZTzVz4OThibg+XZwY
 bZX6PWy4TcWDH85f3b9BQOlgD4lF/dEDwdL2dXTbsKsVLEPK8Io3iTPf5kn2xAYofIFR
 Iz9zcodEdUI4liidtThR1iuhuKgdZsMzdhxB1F5hXbjn/RZv5wk/iBVW2ZghJLQ8OOQN
 q7PCPscSNwspmnUUlbKoIgZ1KvVsObPe67smSuZHMTBRjd4ZLkHMMdDiD1ot/DR1A5ns
 qxow==
X-Gm-Message-State: AOJu0Yy0mb1lh8vOTBaDVro8agjNbIAfFuFsq/p87pn2P0/6iwBusqy+
 Q3tiQrtg33yoHXo/b9T0QKfV063V68SMchd0UxgCnFCUIKPsxwiOxM34752/cGi1i4DNyHwjgmo
 tT009rVTKz7vdkXc=
X-Received: by 2002:adf:f108:0:b0:314:1e47:8bc2 with SMTP id
 r8-20020adff108000000b003141e478bc2mr1478485wro.0.1693389188955; 
 Wed, 30 Aug 2023 02:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdV2X8kBYENXZyS5z7uW9qIu2sw/GF05TFx91hN2Sf62rnaAeSXyIuLwToscRlDS1M2X06tQ==
X-Received: by 2002:adf:f108:0:b0:314:1e47:8bc2 with SMTP id
 r8-20020adff108000000b003141e478bc2mr1478480wro.0.1693389188654; 
 Wed, 30 Aug 2023 02:53:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a7bc391000000b003fe24441e23sm1745678wmj.24.2023.08.30.02.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 02:53:08 -0700 (PDT)
Message-ID: <d036904b-6106-2cfd-6533-70f0f70fea2f@redhat.com>
Date: Wed, 30 Aug 2023 11:53:06 +0200
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
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <e3d3b6f8-2877-620e-66eb-6d3a53d65bc6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 8/30/23 11:21, Avihai Horon wrote:
> 
> On 30/08/2023 11:37, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/30/23 09:01, Avihai Horon wrote:
>>>
>>> On 29/08/2023 21:27, Peter Xu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
>>>>> On 29/08/2023 17:53, Peter Xu wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>>>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>>>> index 1d1e1321b0..e201053563 100644
>>>>>>> --- a/migration/options.c
>>>>>>> +++ b/migration/options.c
>>>>>>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>>>>>>                error_setg(errp, "Postcopy is not yet compatible with multifd");
>>>>>>>                return false;
>>>>>>>            }
>>>>>>> +
>>>>>>> +        if (migration_vfio_mig_active()) {
>>>>>>> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
>>>>>>> +            return false;
>>>>>>> +        }
>>>>>> Hmm.. this will add yet another vfio hard-coded line into migration/..
>>>>>>
>>>>>> What will happen if the vfio device is hot plugged after enabling
>>>>>> postcopy-ram here?
>>>>> In that case a migration blocker will be added.
>>>>>
>>>>>> Is it possible to do it in a generic way?
>>>>> What comes to my mind is to let devices register a handler for a "caps
>>>>> change" notification and allow them to object.
>>>>> But maybe that's a bit of an overkill.
>>>> This one also sounds better than hard-codes to me.
>>>>
>>>>>> I was thinking the only unified place to do such check is when migration
>>>>>> starts, as long as we switch to SETUP all caps are locked and doesn't allow
>>>>>> any change until it finishes or fails.
>>>>>>
>>>>>> So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
>>>>>> to fail the whole migration early?  For example, maybe we should have an
>>>>>> Error** passed in, then if it fails it calls migrate_set_error, so
>>>>>> reflected in query-migrate later too.
>>>>> Yes, I think this could work and it will simplify things because we could
>>>>> also drop the VFIO migration blockers code.
>>>>> The downside is that the user will know migration is blocked only when he
>>>>> tries to migrate, and migrate_caps_check() will not block setting postcopy
>>>>> when a VFIO device is already attached.
>>>>> I don't have a strong opinion here, so if it's fine by you and everyone
>>>>> else, I could change that to what you suggested.
>>>> Failing later would be fine in this case to me; my expectation is VFIO
>>>> users should be advanced already anyway (as the whole solution is still
>>>> pretty involved comparing to a generic VM migration) and shouldn't try to
>>>> trigger that at all in real life.  IOW I'd expect this check will be there
>>>> just for sanity, rather than being relied on to let people be aware of it
>>>> by the error message.
>>>
>>> Yes, I agree with you.
>>>
>>>>
>>>> Meanwhile the blocker + caps check is slightly complicated to me to guard
>>>> both sides.  So I'd vote for failing at the QMP command.  But we can wait
>>>> and see whether there's other votes.
>>>
>>> Sure.
>>> So I will do the checking in vfio_save_setup(), unless someone else has a better idea.
>>
>> Just to recap for my understanding,
>>
>> vfio_save_setup() would test migrate_postcopy_ram() and update a new
>> 'Error *err' parameter of the .save_setup() op which would be taken
>> into account in qemu_savevm_state_setup(). Is that correct ?
>>
> Yes.
> But I wonder if it would be simpler to call migrate_set_error() directly from vfio_save_setup() instead of adding "Error *err" argument to .save_setup() and changing all other users.
> What do you prefer?

Well, with my downstreamer hat, I would prefer a simpler solution for the
VFIO postcopy limitation first. That said, there is value in adding
a 'Error *' parameter to the .save_setup() op and letting the top routine
qemu_savevm_state_setup() propagate. Other SaveVMhandler could start using
it. even VFIO has multiple error_report() in vfio_save_setup() which could
be propagated to the top callers.

Let's try that first. I will check your new series on top of 8.0

Thanks,

C.


> 
> Thanks.
> 


