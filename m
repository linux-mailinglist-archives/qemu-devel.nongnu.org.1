Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30919731A6B
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 15:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9nLn-00043c-8o; Thu, 15 Jun 2023 09:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q9nLl-00043O-NB
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 09:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q9nLj-0007qn-Mp
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 09:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686836958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fHaXqTpvj8zxogAX8jabMfDDN+kmynnjnxFbZLDb/c=;
 b=LIVTTGTUYanY/00NQxH9kBAK1ZULi80nUigKCMjXaanzAPrx0x65xyp1jyCjfKd8RGO/u/
 An+8sMR4WaJg+gK7UWB/VACvpohAr5HtWcVA/Hr39+tImmBMpXGkDoZxPH/3Cp16+9juLQ
 PJeay29kJETGmIgVplDNTLU1bg5iOLA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-_DiTDGLQPNi2E-ELDDZe2Q-1; Thu, 15 Jun 2023 09:49:17 -0400
X-MC-Unique: _DiTDGLQPNi2E-ELDDZe2Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62fe611af5bso19407926d6.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 06:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686836956; x=1689428956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fHaXqTpvj8zxogAX8jabMfDDN+kmynnjnxFbZLDb/c=;
 b=TCErrprapDmCxEfrETWGCe8pizKLVucxbvanJZmNGaYzxVwANYFSzznrVk/Ri5wqWw
 RWrCvaSUtkuxByAKKfkkosvP9NvGMNNmTtb+nYO+WbO5XNKmRdLpd/xssJF2Ip0ogjJP
 gKzuTRjjbMq2MKRrTGp9y8VrJ7WryiaUS219asIUPo7x07nHjQVB8zqnnqCIKCyVZdlC
 yyIP8LqAqL/drhtvzr0hdqVluRWijgnxDlmU6nac+ocaG2MJob5gG8qY1DoNtkJ61GP1
 gjgADfGrf9Ph5EobKK9PTyOQPsEfSyFSWTq17ya2DckLefUpCj9Tjzl8YZhkehG8oOxw
 rNjQ==
X-Gm-Message-State: AC+VfDwqD+74mIIrJ6TqfdkgFoL36w/gB5jXtLiWojgOEI6VrkSo7IP2
 rvRMpyWHzQH3ibQ1taQ4eWxPn0MgnxAKPRnBpKip6XczzIx3rs8wTUWVxXLQqdbqBB89IS11iUz
 LX6ti2GMKDMqtO4U=
X-Received: by 2002:a05:6214:234c:b0:629:3ea2:46e5 with SMTP id
 hu12-20020a056214234c00b006293ea246e5mr21793021qvb.19.1686836956528; 
 Thu, 15 Jun 2023 06:49:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cxD9Mq8Pvz4Vky1o89p+HkpbiiOfawpHaNt8iLknJxSdIh70Kyp7Em29hla+d/eDcJWw2pQ==
X-Received: by 2002:a05:6214:234c:b0:629:3ea2:46e5 with SMTP id
 hu12-20020a056214234c00b006293ea246e5mr21792994qvb.19.1686836956225; 
 Thu, 15 Jun 2023 06:49:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a0ce085000000b0062439f05b87sm5858936qvk.45.2023.06.15.06.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 06:49:15 -0700 (PDT)
Message-ID: <9fb7b40c-b6bf-07aa-5605-66b9fa7353cf@redhat.com>
Date: Thu, 15 Jun 2023 15:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/9] migration: Add switchover ack capability
Content-Language: en-US
To: YangHang Liu <yanghliu@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
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
 <20230530144821.1557-2-avihaih@nvidia.com>
 <CAGYh1E97X85v+90B2G1q7DUaD=zS+5Jr+BPvLuh6p6PAoYUCLg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAGYh1E97X85v+90B2G1q7DUaD=zS+5Jr+BPvLuh6p6PAoYUCLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 6/15/23 14:38, YangHang Liu wrote:
> Test in the following two scenarios:
> 
> [1]  Test scenario:  Both source VM and target VM (in listening mode)
> have enabled return-path and switchover-ack capability:
> 
> Test result : The VFIO migration completed successfully
> 
> [2]  Test scenario :  The source VM has enabled return-path and
> switchover-ack capability while the target VM (in listening mode) not
> 
> Test result : The VFIO migration fails
> 
> The detailed error thrown by qemu-kvm when VFIO migration fails:
>      Target VM:
>            0000:17:00.2: Received INIT_DATA_SENT but switchover ack is not used
>            error while loading state section id 81(0000:00:02.4:00.0/vfio)
>            load of migration failed: Invalid argument
>      Source VM:
>             failed to save SaveStateEntry with id(name): 2(ram): -5
>             Unable to write to socket: Connection reset by peer
>             Unable to write to socket: Connection reset by peer
> 
> Tested-by: YangHang Liu <yanghliu@redhat.com>

Some more info,

Tests were performed with a mainline Linux and a mainline QEMU including
this series - patch8.

The amount of precopy data for a CX-7 VF is not very large. Any idea how
to generate some more initial state with such devices ?

I suppose pre-copy will be more important with vGPUs.



YangHang,

Could you please reply with a Tested-by on the cover letter, so that the
whole series is tagged and not only patch 1.

Thanks,

C.

> 
> 
> On Wed, May 31, 2023 at 1:46 AM Avihai Horon <avihaih@nvidia.com> wrote:
>>
>> Migration downtime estimation is calculated based on bandwidth and
>> remaining migration data. This assumes that loading of migration data in
>> the destination takes a negligible amount of time and that downtime
>> depends only on network speed.
>>
>> While this may be true for RAM, it's not necessarily true for other
>> migrated devices. For example, loading the data of a VFIO device in the
>> destination might require from the device to allocate resources, prepare
>> internal data structures and so on. These operations can take a
>> significant amount of time which can increase migration downtime.
>>
>> This patch adds a new capability "switchover ack" that prevents the
>> source from stopping the VM and completing the migration until an ACK
>> is received from the destination that it's OK to do so.
>>
>> This can be used by migrated devices in various ways to reduce downtime.
>> For example, a device can send initial precopy metadata to pre-allocate
>> resources in the destination and use this capability to make sure that
>> the pre-allocation is completed before the source VM is stopped, so it
>> will have full effect.
>>
>> This new capability relies on the return path capability to communicate
>> from the destination back to the source.
>>
>> The actual implementation of the capability will be added in the
>> following patches.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/migration.json | 12 +++++++++++-
>>   migration/options.h |  1 +
>>   migration/options.c | 21 +++++++++++++++++++++
>>   3 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 179af0c4d8..061ea512e0 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -487,6 +487,16 @@
>>   #     and should not affect the correctness of postcopy migration.
>>   #     (since 7.1)
>>   #
>> +# @switchover-ack: If enabled, migration will not stop the source VM
>> +#     and complete the migration until an ACK is received from the
>> +#     destination that it's OK to do so.  Exactly when this ACK is
>> +#     sent depends on the migrated devices that use this feature.
>> +#     For example, a device can use it to make sure some of its data
>> +#     is sent and loaded in the destination before doing switchover.
>> +#     This can reduce downtime if devices that support this capability
>> +#     are present.  'return-path' capability must be enabled to use
>> +#     it.  (since 8.1)
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> @@ -502,7 +512,7 @@
>>              'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>> -           'zero-copy-send', 'postcopy-preempt'] }
>> +           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
>>
>>   ##
>>   # @MigrationCapabilityStatus:
>> diff --git a/migration/options.h b/migration/options.h
>> index 45991af3c2..9aaf363322 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -40,6 +40,7 @@ bool migrate_postcopy_ram(void);
>>   bool migrate_rdma_pin_all(void);
>>   bool migrate_release_ram(void);
>>   bool migrate_return_path(void);
>> +bool migrate_switchover_ack(void);
>>   bool migrate_validate_uuid(void);
>>   bool migrate_xbzrle(void);
>>   bool migrate_zero_blocks(void);
>> diff --git a/migration/options.c b/migration/options.c
>> index b62ab30cd5..16007afca6 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -185,6 +185,8 @@ Property migration_properties[] = {
>>       DEFINE_PROP_MIG_CAP("x-zero-copy-send",
>>               MIGRATION_CAPABILITY_ZERO_COPY_SEND),
>>   #endif
>> +    DEFINE_PROP_MIG_CAP("x-switchover-ack",
>> +                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>>
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>> @@ -308,6 +310,13 @@ bool migrate_return_path(void)
>>       return s->capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
>>   }
>>
>> +bool migrate_switchover_ack(void)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
>> +}
>> +
>>   bool migrate_validate_uuid(void)
>>   {
>>       MigrationState *s = migrate_get_current();
>> @@ -547,6 +556,18 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>           }
>>       }
>>
>> +    if (new_caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK]) {
>> +        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
>> +            error_setg(errp, "Capability 'switchover-ack' requires capability "
>> +                             "'return-path'");
>> +            return false;
>> +        }
>> +
>> +        /* Disable this capability until it's implemented */
>> +        error_setg(errp, "'switchover-ack' is not implemented yet");
>> +        return false;
>> +    }
>> +
>>       return true;
>>   }
>>
>> --
>> 2.26.3
>>
>>
> 


