Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB475CD2E
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsfL-0003Fy-Aj; Fri, 21 Jul 2023 12:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsf7-0003Em-0e
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsf4-0006qO-1Z
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689955639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uf9Xo5YcSZTmKEnRLKmpmQSmf2Npgl+FgVzggEmP8+M=;
 b=GoYMbbK1S/GW24MOA3P7njumMNoe8vLkkp+DGurQ3/iFcd0Ias7eCCJqZUL6pyiOSkkanc
 qMFwsK7LCe09C5R2VWxTJ8hOybd71Z5rB3ZrUD8CMwZ07C0FFrj0AdRjuWR7Utmt2J85Nx
 Fc6H03kIJxDXHKQPCww1fiW/h2p5ihU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-D0yHDWr0PgOtvpXuoPOydg-1; Fri, 21 Jul 2023 12:07:17 -0400
X-MC-Unique: D0yHDWr0PgOtvpXuoPOydg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-521f2a8bde6so239050a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 09:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689955636; x=1690560436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uf9Xo5YcSZTmKEnRLKmpmQSmf2Npgl+FgVzggEmP8+M=;
 b=iuCssppJKzLWXWvaeWDQggjuXyWXObsyECKbvPE5+TAkk6UfENW7Ynmcmz+BHM6L/n
 K6LwNuvGVZcRSh2cKGYR+7q0pcFM64qGQgoRBDv7AlUPR6mRIek3OgHKLEkYMFu8Fniu
 CF2RK6gbdhx/l0Q5W9qOdA8rM4O3a84o2Mu4mhHQGEk9H7JJ+CGSsWJW+rn+8uym6kpn
 kzibXUVp7SqTwfvgiocISp3o4bPkom+yqBh1IeK+mIQr/9SL0CN8eGFnvJoeSoV0H61u
 w1ua4hrhK1+T4QY4ykMEHPD+F7+Ka1aoI0TC6U9r74PdmUOZN/kF4qfbS2sUTQ3ZISUE
 kbRQ==
X-Gm-Message-State: ABy/qLaCABMQbXSoxuehbudslthiXWVaRDwjgjBsxK+HHx0YN4vE3UZL
 kG5QilyT4PwyCxcpU5N1G6JrJxFm56rzdB7kk/5ktQtqHHimmpkDsmrlMrUHRiEJc/BqnFYkEE7
 +mXh7j1ZzenPI+Uc=
X-Received: by 2002:a05:6402:6c2:b0:51d:f37c:e3b0 with SMTP id
 n2-20020a05640206c200b0051df37ce3b0mr1891568edy.11.1689955636657; 
 Fri, 21 Jul 2023 09:07:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXxNzNR75FEWPCHXgjUE9a7/PGJAFAGvUrfVSiozAFa7G5GlINvH/E9IsUk+ZGzcPAAK1lBQ==
X-Received: by 2002:a05:6402:6c2:b0:51d:f37c:e3b0 with SMTP id
 n2-20020a05640206c200b0051df37ce3b0mr1891556edy.11.1689955636338; 
 Fri, 21 Jul 2023 09:07:16 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 o23-20020aa7dd57000000b0051e0cb4692esm2261545edw.17.2023.07.21.09.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 09:07:15 -0700 (PDT)
Message-ID: <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
Date: Fri, 21 Jul 2023 18:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione <gmaglione@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
 <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 21.07.23 17:25, Eugenio Perez Martin wrote:
> On Tue, Jul 11, 2023 at 5:52 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>> Move the `suspended` field from vhost_vdpa into the global vhost_dev
>> struct, so vhost_dev_stop() can check whether the back-end has been
>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
>> there is no need to reset it; the reset is just a fall-back to stop
>> device operations for back-ends that do not support suspend.
>>
>> Unfortunately, for vDPA specifically, RESUME is not yet implemented, so
>> when the device is re-started, we still have to do the reset to have it
>> un-suspend.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   include/hw/virtio/vhost-vdpa.h |  2 --
>>   include/hw/virtio/vhost.h      |  8 ++++++++
>>   hw/virtio/vhost-vdpa.c         | 11 +++++++----
>>   hw/virtio/vhost.c              |  8 +++++++-
>>   4 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
>> index e64bfc7f98..72c3686b7f 100644
>> --- a/include/hw/virtio/vhost-vdpa.h
>> +++ b/include/hw/virtio/vhost-vdpa.h
>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
>>       bool shadow_vqs_enabled;
>>       /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
>>       bool shadow_data;
>> -    /* Device suspended successfully */
>> -    bool suspended;
>>       /* IOVA mapping used by the Shadow Virtqueue */
>>       VhostIOVATree *iova_tree;
>>       GPtrArray *shadow_vqs;
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 6a173cb9fa..69bf59d630 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -120,6 +120,14 @@ struct vhost_dev {
>>       uint64_t backend_cap;
>>       /* @started: is the vhost device started? */
>>       bool started;
>> +    /**
>> +     * @suspended: Whether the vhost device is currently suspended.  Set
>> +     * and reset by implementations (vhost-user, vhost-vdpa, ...), which
>> +     * are supposed to automatically suspend/resume in their
>> +     * vhost_dev_start handlers as required.  Must also be cleared when
>> +     * the device is reset.
>> +     */
>> +    bool suspended;
>>       bool log_enabled;
>>       uint64_t log_size;
>>       Error *migration_blocker;
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 7b7dee468e..f7fd19a203 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
>>
>>   static int vhost_vdpa_reset_device(struct vhost_dev *dev)
>>   {
>> -    struct vhost_vdpa *v = dev->opaque;
>>       int ret;
>>       uint8_t status = 0;
>>
>>       ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>>       trace_vhost_vdpa_reset_device(dev);
>> -    v->suspended = false;
>> +    dev->suspended = false;
>>       return ret;
>>   }
>>
>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
>>           if (unlikely(r)) {
>>               error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
>>           } else {
>> -            v->suspended = true;
>> +            dev->suspended = true;
>>               return;
>>           }
>>       }
>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>>               return -1;
>>           }
>>           vhost_vdpa_set_vring_ready(dev);
>> +        if (dev->suspended) {
>> +            /* TODO: When RESUME is available, use it instead of resetting */
>> +            vhost_vdpa_reset_status(dev);
> How is that we reset the status at each vhost_vdpa_dev_start? That
> will clean all the vqs configured, features negotiated, etc. in the
> vDPA device. Or am I missing something?

What alternative do you propose?  We don’t have RESUME for vDPA in qemu, 
but we somehow need to lift the previous SUSPEND so the device will 
again respond to guest requests, do we not?

But more generally, is this any different from what is done before this 
patch?  Before this patch, vhost_dev_stop() unconditionally invokes 
vhost_reset_status(), so the device is reset in every stop/start cycle, 
that doesn’t change.  And we still won’t reset it on the first 
vhost_dev_start(), because dev->suspended will be false then, only on 
subsequent stop/start cycles, as before.  So the only difference is that 
now the device is reset on start, not on stop.

Hanna


