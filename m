Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B1A49302
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Feb 2025 09:11:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvRS-0002rS-7F; Fri, 28 Feb 2025 03:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnvRQ-0002rD-5Q
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:09:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnvRN-00009M-TZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740730187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ChwMbL4Izz+HB6bXLWF0S7F7M6cNu2aGB3Fa52pOT4o=;
 b=DNtSJY3UDfi7tfpgH5Z2WOL7w7jJg6eCcTMYFhsje2HaHNp0fYnZt2nQzjrF0ZJGXqDdv+
 aERM9q2MZPk5E4kiJ/5AlZinpKZ2MT8FNZy8kWThNTxoljjJ4HX6gRao6swEY6JG+prgJe
 tmYPB/iCDOwq/bC2NTurxwWDpKWpZ3Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-OvR39veXN_aJVqLWUfiszw-1; Fri, 28 Feb 2025 03:09:45 -0500
X-MC-Unique: OvR39veXN_aJVqLWUfiszw-1
X-Mimecast-MFC-AGG-ID: OvR39veXN_aJVqLWUfiszw_1740730184
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f455a8fcaso1138065f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 00:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740730184; x=1741334984;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChwMbL4Izz+HB6bXLWF0S7F7M6cNu2aGB3Fa52pOT4o=;
 b=fFxchu5xoe7kUBYQdtS+6H+Fb176JmjiOD4BwP0hpzyf1NiiS8fr8MIXijnKWwmKSw
 y7C3JbzRqPXqAeEIibzB+Stptq9QOs9jQaK/6qPWxed4fv3n9U4yjGKAByisL8qQlcHp
 OAXoMJN9eMZDbZ46pwehQRoMQVkRj37Qbx/QznR+ClVgobymBamGkzGjy+CGpYQRH21D
 wtyerMtfg+PYNyC6rvnRXpX7RKUBj//rRCBh2plGxihhEU/GMBGI8wFjJOfHLb4RN81l
 aACmu8wDZ0d1uAJpIvj0bHt+wtHACzVtdYxiZStEr/iDD3EfRAK2Zw0XvBJoBU7GjK+W
 IH8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtmdTNshDQJsqbxdQPsbLPvAbfGWClUiDfvgRrYT/J99isZErYko1BBkMBxrqkfaCOm4n8ZjAeT3w3@nongnu.org
X-Gm-Message-State: AOJu0Yx5OgJeDf3y+PxYXOiRsuzwdLvyd4LDuDFAYSCf6n/GeFtzO66k
 7+XXuJTy5SKt7awshUganOyUIHM2KecRC3LT0ObmsT95Q9ujV80g1PrbGK+WPdFtqDXOI/GqTyS
 Rn5wzG0Ozr2eovQrZ0kHihp84FXrGc9zFqYmnyIm/MrKW/SKPVa3p
X-Gm-Gg: ASbGncvSbSfZdr/GFR1weL7S3btBODxE7k2M+2IONJ+6/H9k25h/rBQmgUMA3vA6Fzn
 gDkaeZcaVHrYadrJ/QsdKS4D29tLpGo8FfDdnP95XfCTHja+6kiGGpL7zCNy6QRnTVsjU/d+sp7
 ccWj5PTGIU/KJKcW1XZBvedAklfbrMJVnw0ckPLU2CyL9INoE3bjz+g/2s7AKlcX73aU5knwywN
 GRG7weZ227P4r+Co7WbTlBaiZ1svkE7X/0+w6fBv4y4XYrpwW7CQRdKIN8lTucapntcV4z+k4KM
 Qyn8seoZxYE32apkrBf4Tpk5Ika/n7p5p17Ur376UGShg79NWyRe0tnbeU0=
X-Received: by 2002:a05:6000:1f8c:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-390eca530a8mr1654752f8f.39.1740730184115; 
 Fri, 28 Feb 2025 00:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6GIxxm4Bu7APHi1QdBwDNmgGaj4tDPg1TL3R6UZFA+kSLFvAeHfK9uEln02n0oS5n14Fa1w==
X-Received: by 2002:a05:6000:1f8c:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-390eca530a8mr1654724f8f.39.1740730183725; 
 Fri, 28 Feb 2025 00:09:43 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7c4fsm4439491f8f.52.2025.02.28.00.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 00:09:42 -0800 (PST)
Message-ID: <0a2cb938-7c2c-46aa-bb5e-19a425b18de5@redhat.com>
Date: Fri, 28 Feb 2025 09:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/36] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <4de9762ebf7e7857103eb276d1a26a092aee325d.1739994627.git.maciej.szmigiero@oracle.com>
 <6ad969cd-e522-4c8b-9d95-05b4df3be002@redhat.com>
 <e91b1d67-1ddc-4d63-9c7f-cde1b13f3673@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e91b1d67-1ddc-4d63-9c7f-cde1b13f3673@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/26/25 22:04, Maciej S. Szmigiero wrote:
> On 26.02.2025 11:43, Cédric Le Goater wrote:
>> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> The multifd received data needs to be reassembled since device state
>>> packets sent via different multifd channels can arrive out-of-order.
>>>
>>> Therefore, each VFIO device state packet carries a header indicating its
>>> position in the stream.
>>> The raw device state data is saved into a VFIOStateBuffer for later
>>> in-order loading into the device.
>>>
>>> The last such VFIO device state packet should have
>>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration-multifd.c | 103 ++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/migration-multifd.h |   3 ++
>>>   hw/vfio/migration.c         |   1 +
>>>   hw/vfio/trace-events        |   1 +
>>>   4 files changed, 108 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>> index c2defc0efef0..5d5ee1393674 100644
>>> --- a/hw/vfio/migration-multifd.c
>>> +++ b/hw/vfio/migration-multifd.c
>>> @@ -42,6 +42,11 @@ typedef struct VFIOStateBuffer {
>>>   } VFIOStateBuffer;
>>>   typedef struct VFIOMultifd {
>>> +    VFIOStateBuffers load_bufs;
>>> +    QemuCond load_bufs_buffer_ready_cond;
>>> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>> +    uint32_t load_buf_idx;
>>> +    uint32_t load_buf_idx_last;
>>>   } VFIOMultifd;
>>>   static void vfio_state_buffer_clear(gpointer data)
>>> @@ -87,15 +92,113 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>>>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>>   }
>>
>> this routine expects load_bufs_mutex to be locked ? May be say so.
> 
> I guess the comment above pertains to the vfio_load_state_buffer_insert()
> below.
> 
> Do you mean it should have a comment that it expects to be called
> under load_bufs_mutex?

Just a one liner like :

/* called with load_bufs_mutex locked */

?

It's good to have for the future generations.

> 
>>> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>>
>> could you pass VFIOMultifd* instead  ?
> 
> No, it needs vbasedev->migration_max_queued_buffers too (introduced
> in later patch).
> > Also, most of VFIO routines (besides very small helpers/wrappers)
> take VFIODevice *.

OK. It's minor but I prefer when parameters are limited to the minimum.
Having 'VFIODevice *' opens doors to a lot of state.


Thanks,

C.



> 
>>> +                                          VFIODeviceStatePacket *packet,
>>> +                                          size_t packet_total_size,
>>> +                                          Error **errp)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    VFIOStateBuffer *lb;
>>> +
>>> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
>>> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
>>> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
>>> +    }
>>> +
>>> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
>>> +    if (lb->is_present) {
>>> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
>>> +                   packet->idx);
>>> +        return false;
>>> +    }
>>> +
>>> +    assert(packet->idx >= multifd->load_buf_idx);
>>> +
>>> +    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>>> +    lb->len = packet_total_size - sizeof(*packet);
>>> +    lb->is_present = true;
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>> +                            Error **errp)
>>
>>
>> AFAICS, the only users of the .load_state_buffer() handlers is
>> multifd_device_state_recv().
>>
>> Please rename to vfio_multifd_load_state_buffer().
> 
> Renamed it accordingly.
> 
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
>>> +
>>> +    /*
>>> +     * Holding BQL here would violate the lock order and can cause
>>> +     * a deadlock once we attempt to lock load_bufs_mutex below.
>>> +     */
>>> +    assert(!bql_locked());
>>> +
>>> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
>>> +        error_setg(errp,
>>> +                   "got device state packet but not doing multifd transfer");
>>> +        return false;
>>> +    }
>>> +
>>> +    assert(multifd);
>>> +
>>> +    if (data_size < sizeof(*packet)) {
>>> +        error_setg(errp, "packet too short at %zu (min is %zu)",
>>> +                   data_size, sizeof(*packet));
>>> +        return false;
>>> +    }
>>> +
>>> +    if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
>>> +        error_setg(errp, "packet has unknown version %" PRIu32,
>>> +                   packet->version);
>>> +        return false;
>>> +    }
>>> +
>>> +    if (packet->idx == UINT32_MAX) {
>>> +        error_setg(errp, "packet has too high idx");
>>
>> or "packet index is invalid" ?
> 
> Changed the error message.
> 
>>> +        return false;
>>> +    }
>>> +
>>> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
>>> +
>>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>>
>> Using WITH_QEMU_LOCK_GUARD() would be cleaner I think.
> 
> Changed into a WITH_QEMU_LOCK_GUARD() block.
> 
>>
>>
>> Thanks,
>>
>> C.
> 
> Thanks,
> Maciej
> 


