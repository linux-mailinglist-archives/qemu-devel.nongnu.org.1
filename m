Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C81B83076D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 14:59:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6RV-0002ML-DQ; Wed, 17 Jan 2024 08:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ6RT-0002M8-LR
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:58:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ6RR-00008w-VG
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705499932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbbxKsoVPE9jEV8xu6idN/lsAEfYLdBvE0iBswSM+eM=;
 b=Ru7g6n65MSjwCbEY67iDgzWWcigmVF3Y67AVEfnYrFaN6Gavt5R1QH0509x8oN91PNEKU/
 MvsUr7fDebvMP/8qXF+GXUYggpwgjIG2pICbb4j1BrjM7ewkZopWUs7wmZP9D2Mlo2Ll7F
 IfqSIO17RF1mzImEl0Ny1M8In5nY6SY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-b4MSuMoJPL6XaayUr2gunA-1; Wed, 17 Jan 2024 08:58:49 -0500
X-MC-Unique: b4MSuMoJPL6XaayUr2gunA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bbc40771a9so13213072b6e.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 05:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705499929; x=1706104729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbbxKsoVPE9jEV8xu6idN/lsAEfYLdBvE0iBswSM+eM=;
 b=RF0gt+U4kAsUWuFYdx/kXW3A388ZcAHwFCyMZ4DjiDMdjdwa4wvlZt29oSeKhPgDyo
 qDE7xDN2K3UIRx6j2/KBu3mzouj/ynR90DjJ9nAceTdfQydxJjaV2eFSowcDB6h5sjtg
 v5w0MeP19BD0zcGHVg7LuQQh4Z/xg8GcSNuhlDuveQ1Ct+D0TapLZgmXbpu/cQUUYR75
 cvNOtvA5/gGcRB5579QJzrbMMgF7hbIkXBN0tWSrPzo5pU5m6/+Glpd13tN6ORi/Vl2X
 LUUwvu0vNhF6MRi7NC609iz+QRKlg4faOtF90Zgr2cZXMJ1vIIvCFg04dk905o/ETltb
 zSPw==
X-Gm-Message-State: AOJu0YxgrNzx+dBPZQAMy1d/4Vk/wnw5Th2vpWWCJJ+UBIoLZ86WzYQf
 aHM9xfLmxLDeOy1bS6GtdLqvDMS9NkUpAJfYVQNBfVVAlBwOsy2aPz9gPdPqe9GXL7IcCpVq/cF
 sKkupx6d7lHbawni29A/i5QM=
X-Received: by 2002:a05:6808:1455:b0:3bd:49a4:f854 with SMTP id
 x21-20020a056808145500b003bd49a4f854mr11495507oiv.68.1705499929156; 
 Wed, 17 Jan 2024 05:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC2KRahq24LyBMwZia0ELqd03xLWZBZPGpLEx9kwFiLAhCrqX9kYFCPio5y0i+b1EE6Fcxgw==
X-Received: by 2002:a05:6808:1455:b0:3bd:49a4:f854 with SMTP id
 x21-20020a056808145500b003bd49a4f854mr11495495oiv.68.1705499928848; 
 Wed, 17 Jan 2024 05:58:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 3-20020ac85643000000b004282ce42c71sm5804061qtt.86.2024.01.17.05.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 05:58:48 -0800 (PST)
Message-ID: <00e2dc08-c6a3-4e7c-aba3-187d281b71b0@redhat.com>
Date: Wed, 17 Jan 2024 14:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: Allow multiple stages of system resets
Content-Language: en-US
To: eric.auger@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-3-peterx@redhat.com>
 <1bc3d59d-41a6-4ca7-9d9b-ee6ba6639bd0@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <1bc3d59d-41a6-4ca7-9d9b-ee6ba6639bd0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/17/24 11:28, Eric Auger wrote:
> Hi Peter,
> On 1/17/24 10:15, peterx@redhat.com wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> QEMU resets do not have a way to order reset hooks.  Add one coarse grained
>> reset stage so that some devices can be reset later than some others.
> I would precise that the lowest stage has the highest priority and is
> handled first.

yes. May be add an enum like we have for migration :

typedef enum {
     MIG_PRI_DEFAULT = 0,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
     MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
     MIG_PRI_GICV3,              /* Must happen before the ITS */
     MIG_PRI_MAX,
} MigrationPriority;

I think it would help understand the reset ordering and maintenance
when grepping qemu_register_reset_one().

Thanks,

C.



>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>   include/sysemu/reset.h |  5 ++++
>>   hw/core/reset.c        | 60 +++++++++++++++++++++++++++++++-----------
>>   2 files changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
>> index 609e4d50c2..0de697ce9f 100644
>> --- a/include/sysemu/reset.h
>> +++ b/include/sysemu/reset.h
>> @@ -5,9 +5,14 @@
>>   
>>   typedef void QEMUResetHandler(void *opaque);
>>   
>> +#define  QEMU_RESET_STAGES_N  2
>> +
>>   void qemu_register_reset(QEMUResetHandler *func, void *opaque);
>> +void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
>> +                             bool skip_snap, int stage);
>>   void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque);
>>   void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
>> +void qemu_unregister_reset_one(QEMUResetHandler *func, void *opaque, int stage);
>>   void qemu_devices_reset(ShutdownCause reason);
>>   
>>   #endif
>> diff --git a/hw/core/reset.c b/hw/core/reset.c
>> index 8cf60b2b09..a84c9bee84 100644
>> --- a/hw/core/reset.c
>> +++ b/hw/core/reset.c
>> @@ -36,55 +36,83 @@ typedef struct QEMUResetEntry {
>>       bool skip_on_snapshot_load;
>>   } QEMUResetEntry;
>>   
>> -static QTAILQ_HEAD(, QEMUResetEntry) reset_handlers =
>> -    QTAILQ_HEAD_INITIALIZER(reset_handlers);
>> +typedef QTAILQ_HEAD(QEMUResetList, QEMUResetEntry) QEMUResetList;
>> +static QEMUResetList reset_handlers[QEMU_RESET_STAGES_N];
>>   
>> -static void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
>> -                                    bool skip_snap)
>> +static void __attribute__((__constructor__)) qemu_reset_handlers_init(void)
>> +{
>> +    QEMUResetList *head;
>> +    int i = 0;
> nit: you may put the declarations within the block
>> +
>> +    for (i = 0; i < QEMU_RESET_STAGES_N; i++) {
>> +        head = &reset_handlers[i];
>> +        QTAILQ_INIT(head);
>> +    }
>> +}
>> +
>> +void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
>> +                             bool skip_snap, int stage)
>>   {
>>       QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
>> +    QEMUResetList *head;
>> +
>> +    assert(stage >= 0 && stage < QEMU_RESET_STAGES_N);
>> +    head = &reset_handlers[stage];
>>   
>>       re->func = func;
>>       re->opaque = opaque;
>>       re->skip_on_snapshot_load = skip_snap;
>> -    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
>> +    QTAILQ_INSERT_TAIL(head, re, entry);
>>   }
>>   
>>   void qemu_register_reset(QEMUResetHandler *func, void *opaque)
>>   {
>> -    /* By default, do not skip during load of a snapshot */
> Shouldn't the above comment stay since the statement is not affected by
> this patch? Or remove it in previous patch?
>> -    qemu_register_reset_one(func, opaque, false);
>> +    qemu_register_reset_one(func, opaque, false, 0);
>>   }
>>   
>>   void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
>>   {
>> -    qemu_register_reset_one(func, opaque, true);
>> +    qemu_register_reset_one(func, opaque, true, 0);
>>   }
>>   
>> -void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
>> +void qemu_unregister_reset_one(QEMUResetHandler *func, void *opaque, int stage)
>>   {
>> +    QEMUResetList *head;
>>       QEMUResetEntry *re;
>>   
>> -    QTAILQ_FOREACH(re, &reset_handlers, entry) {
>> +    assert(stage >= 0 && stage < QEMU_RESET_STAGES_N);
>> +    head = &reset_handlers[stage];
>> +
>> +    QTAILQ_FOREACH(re, head, entry) {
>>           if (re->func == func && re->opaque == opaque) {
>> -            QTAILQ_REMOVE(&reset_handlers, re, entry);
>> +            QTAILQ_REMOVE(head, re, entry);
>>               g_free(re);
>>               return;
>>           }
>>       }
>>   }
>>   
>> +void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
>> +{
>> +    qemu_unregister_reset_one(func, opaque, 0);
>> +}
>> +
>>   void qemu_devices_reset(ShutdownCause reason)
>>   {
>>       QEMUResetEntry *re, *nre;
>> +    QEMUResetList *head;
>> +    int stage;
>>   
>>       /* reset all devices */
>> -    QTAILQ_FOREACH_SAFE(re, &reset_handlers, entry, nre) {
>> -        if (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
>> -            re->skip_on_snapshot_load) {
>> -            continue;
>> +    for (stage = 0; stage < QEMU_RESET_STAGES_N; stage++) {
>> +        head = &reset_handlers[stage];
>> +        QTAILQ_FOREACH_SAFE(re, head, entry, nre) {
>> +            if (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
>> +                re->skip_on_snapshot_load) {
>> +                continue;
>> +            }
>> +            re->func(re->opaque);
>>           }
>> -        re->func(re->opaque);
>>       }
>>   }
>>   
> Thanks
> 
> Eric
> 
> 


