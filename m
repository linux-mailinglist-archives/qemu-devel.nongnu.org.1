Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CFD75AFAE
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTet-0006aO-59; Thu, 20 Jul 2023 09:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMTed-0006ZC-F8
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMTeb-0003qO-8k
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689859511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTiP82o+u/BcaPM5r5VqdtNTjDtvWXW3OoNgVNUPXgQ=;
 b=Hw1MkLxf7x7at4pRom6pvpC57ApWccRWyBvnFrcsayRCgkznM1+umFe3fg4H8mXkKL0//i
 esYUvRjFSZrfpAarwDpU+rOj0IUTkcZzWuTdDrO5d5QICBvMQkOjU7zSJSvZ2DqjbsfHHZ
 JLM8fBq+XNeW26fJvj4eiRS9duOvjwg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-pzLc8OTCMum_jOwb7jOJUg-1; Thu, 20 Jul 2023 09:25:07 -0400
X-MC-Unique: pzLc8OTCMum_jOwb7jOJUg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-521dd050a78so338699a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689859206; x=1690464006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vTiP82o+u/BcaPM5r5VqdtNTjDtvWXW3OoNgVNUPXgQ=;
 b=DTjyhkWtNQFggbA796vsf2gyM/8azCg8M6otu8ptFTajC/TbvbL0k4dw/24e2Ksr0l
 DpCQZLt/ckdTy76VxS9yuI0zooTxpfaoZ7V8K8kmx1TXb7xJVGeol38TCc6KBdax2sYQ
 sK4XgpH8oR1fsrG7ICHoKR44AJXOOL1YKHxnXJbO+ze1jMKwO4jubE2PtZZ+GpNbaGB4
 kuTumY8ABEkYOAtpL5vklJqfLB6IqcPG2BPzWPJ2fahNYTGFBasfK1OWmXB+81ZU7b+e
 dzdyv7UxrbkVUez7xp36E2URfLV0HX3zBI3LgSvbEdU2pC2E76vDByDT54r6M+n9F5HH
 UNQQ==
X-Gm-Message-State: ABy/qLYw1RyHWHLoom5ULvR1UaiAOcluCKTk8UqLSAqbzxORJACe/l4R
 MowtBH8WVSzBo+xaORsvVVXHjSlfsRfcFu8TIRNvIqJPDF8OUPnLWggbm1HdEOlw0lvfMZFZIJq
 P1dlBkk8GZ65smJT4U57W6NE=
X-Received: by 2002:a17:906:3093:b0:997:ea67:cb2f with SMTP id
 19-20020a170906309300b00997ea67cb2fmr4831538ejv.48.1689859205917; 
 Thu, 20 Jul 2023 06:20:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFUy3XFeNK/KgocDHfTQLcd0zZAjRKS9Ijp/QU6BQbcP/RWAFBb9mslA1SfeGmYS2Z1RHvZlw==
X-Received: by 2002:a17:906:3093:b0:997:ea67:cb2f with SMTP id
 19-20020a170906309300b00997ea67cb2fmr4831524ejv.48.1689859205601; 
 Thu, 20 Jul 2023 06:20:05 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 qx26-20020a170906fcda00b00982cfe1fe5dsm708974ejb.65.2023.07.20.06.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 06:20:05 -0700 (PDT)
Message-ID: <14677814-9707-6a08-7b07-4532fad5f7a1@redhat.com>
Date: Thu, 20 Jul 2023 15:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Virtio-fs] [PATCH v2 2/4] vhost-user: Interface for migration
 state transfer
Content-Language: en-US
To: Hao Xu <hao.xu@linux.dev>, qemu-devel@nongnu.org, virtio-fs@redhat.com
Cc: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-3-hreitz@redhat.com>
 <d5fc7e82-3bd5-deeb-b506-5a8d10bd7112@linux.dev>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <d5fc7e82-3bd5-deeb-b506-5a8d10bd7112@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 20.07.23 14:13, Hao Xu wrote:
>
> On 7/12/23 19:17, Hanna Czenczek wrote:
>> Add the interface for transferring the back-end's state during migration
>> as defined previously in vhost-user.rst.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   include/hw/virtio/vhost-backend.h |  24 +++++
>>   include/hw/virtio/vhost.h         |  79 ++++++++++++++++
>>   hw/virtio/vhost-user.c            | 147 ++++++++++++++++++++++++++++++
>>   hw/virtio/vhost.c                 |  37 ++++++++
>>   4 files changed, 287 insertions(+)
>>
>> diff --git a/include/hw/virtio/vhost-backend.h 
>> b/include/hw/virtio/vhost-backend.h
>> index 31a251a9f5..e59d0b53f8 100644
>> --- a/include/hw/virtio/vhost-backend.h
>> +++ b/include/hw/virtio/vhost-backend.h
>> @@ -26,6 +26,18 @@ typedef enum VhostSetConfigType {
>>       VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
>>   } VhostSetConfigType;
>>   +typedef enum VhostDeviceStateDirection {
>> +    /* Transfer state from back-end (device) to front-end */
>> +    VHOST_TRANSFER_STATE_DIRECTION_SAVE = 0,
>> +    /* Transfer state from front-end to back-end (device) */
>> +    VHOST_TRANSFER_STATE_DIRECTION_LOAD = 1,
>> +} VhostDeviceStateDirection;
>> +
>> +typedef enum VhostDeviceStatePhase {
>> +    /* The device (and all its vrings) is stopped */
>> +    VHOST_TRANSFER_STATE_PHASE_STOPPED = 0,
>> +} VhostDeviceStatePhase;
>> +
>>   struct vhost_inflight;
>>   struct vhost_dev;
>>   struct vhost_log;
>> @@ -133,6 +145,15 @@ typedef int (*vhost_set_config_call_op)(struct 
>> vhost_dev *dev,
>>     typedef void (*vhost_reset_status_op)(struct vhost_dev *dev);
>>   +typedef bool (*vhost_supports_migratory_state_op)(struct vhost_dev 
>> *dev);
>> +typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
>> + VhostDeviceStateDirection direction,
>> + VhostDeviceStatePhase phase,
>> +                                            int fd,
>> +                                            int *reply_fd,
>> +                                            Error **errp);
>> +typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, 
>> Error **errp);
>> +
>>   typedef struct VhostOps {
>>       VhostBackendType backend_type;
>>       vhost_backend_init vhost_backend_init;
>> @@ -181,6 +202,9 @@ typedef struct VhostOps {
>>       vhost_force_iommu_op vhost_force_iommu;
>>       vhost_set_config_call_op vhost_set_config_call;
>>       vhost_reset_status_op vhost_reset_status;
>> +    vhost_supports_migratory_state_op vhost_supports_migratory_state;
>> +    vhost_set_device_state_fd_op vhost_set_device_state_fd;
>> +    vhost_check_device_state_op vhost_check_device_state;
>>   } VhostOps;
>>     int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 69bf59d630..d8877496e5 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -346,4 +346,83 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
>>   int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
>>                              struct vhost_inflight *inflight);
>>   bool vhost_dev_has_iommu(struct vhost_dev *dev);
>> +
>> +/**
>> + * vhost_supports_migratory_state(): Checks whether the back-end
>> + * supports transferring internal state for the purpose of migration.
>> + * Support for this feature is required for vhost_set_device_state_fd()
>> + * and vhost_check_device_state().
>> + *
>> + * @dev: The vhost device
>> + *
>> + * Returns true if the device supports these commands, and false if it
>> + * does not.
>> + */
>> +bool vhost_supports_migratory_state(struct vhost_dev *dev);
>> +
>> +/**
>> + * vhost_set_device_state_fd(): Begin transfer of internal state 
>> from/to
>> + * the back-end for the purpose of migration.  Data is to be 
>> transferred
>> + * over a pipe according to @direction and @phase.  The sending end 
>> must
>> + * only write to the pipe, and the receiving end must only read from 
>> it.
>> + * Once the sending end is done, it closes its FD.  The receiving end
>> + * must take this as the end-of-transfer signal and close its FD, too.
>> + *
>> + * @fd is the back-end's end of the pipe: The write FD for SAVE, and 
>> the
>> + * read FD for LOAD.  This function transfers ownership of @fd to the
>> + * back-end, i.e. closes it in the front-end.
>> + *
>> + * The back-end may optionally reply with an FD of its own, if this
>> + * improves efficiency on its end.  In this case, the returned FD is
>
>
> Hi Hanna,
>
> In what case/situation, the back-end will have a more efficient fd?

Hi Hao,

There is no example yet.

> Here my understanding of this "FD of its own" is as same type as
>
> the given fd(e.g. both pipe files), why the fd from back-end makes
>
> difference? Do I miss anything here?

Maybe it makes more sense in the context of how we came up with the 
idea: Specifically, Stefan and me were asking which end should provide 
the FD.  In the context of vhost-user, it makes sense to have it be the 
front-end, because it controls vhost-user communication, but that’s just 
the natural protocol choice, not necessarily the most efficient one.

It is imaginable that the front-end (e.g. qemu) could create a file 
descriptor whose data is directly spliced (automatically) into the 
migration stream, and then hand this FD to the back-end.  In practice, 
this doesn’t work for qemu (at this point), because it doesn’t use 
simple read/write into the migration stream, but has an abstraction 
layer for that.  It might be possible to make this work in some cases, 
depending on what is used as a transport, but (1) not generally, and (2) 
not now.  But this would be efficient.

The model we’d implement in qemu with this series is comparatively not 
efficient, because it manually copies data from the FD (which by default 
is a pipe) into the migration stream.

But it is possible that the front-end can provide a zero-copy FD into 
the migration stream, and for that reason we want to allow the front-end 
to provide the transfer FD.

In contrast, the back-end might have a more efficient implementation on 
its side, too, though.  It is difficult to imagine, but it may be 
possible that it has an FD already where the data needs to written 
to/read from, e.g. because it’s connected to a physical device that 
wants to get/send its state this way.  Admittedly, we have absolutely no 
concrete example for such a back-end at this point, but it’s hard to 
rule out that it is possible that there will be back-ends that could 
make use of zero-copy if only they are allowed to dictate the transfer FD.

So because we in qemu can’t (at least not generally) provide an 
efficient (zero-copy) implementation, we don’t want to rule out that the 
back-end might be able to, so we also want to allow it to provide the 
transfer FD.

In the end, we decided that we don’t want to preclude either side of 
providing the FD.  If one side knows it can do better than a plain pipe 
with copying on both ends, it should provide the FD.  That doesn’t 
complicate the implementation much.

(So, notably, we measure “improves efficiency” based on “is it better 
than a plain pipe with copying on both ends”.  A pipe with copying is 
the default implementation, but as Stefan has pointed out in his review, 
it doesn’t need to be a pipe.  More efficient FDs, like the back-end can 
provide in its reply, would actually likely not be pipes.)

Hanna


