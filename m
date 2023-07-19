Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F57597C1
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:10:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7s6-00072H-CO; Wed, 19 Jul 2023 10:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7s5-000728-Ad
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7s3-0003wz-43
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689775778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTzw3yGcHWk5syUQvcy/CqZS4xpw/1CZKUGwzZgcPe8=;
 b=EivvKSNV+SgrBstl32HiLCobdhJ6tadbqZR5a/tLThqD92x1+PJOfBXcraoVuvvJP4wKZV
 E1s7dPfcHcfAXQpt7Yy6Gd1Yt+nGDXxZfoe8rX9n5vEykzvuznSFI+SJUCNzql5PO375oa
 0lRAKBGEk/cPwS8VzP0oxfcZEBcTwtI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-vZNy5SuxNKO48L0m3-nFew-1; Wed, 19 Jul 2023 10:09:37 -0400
X-MC-Unique: vZNy5SuxNKO48L0m3-nFew-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-978a991c3f5so409629266b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689775775; x=1692367775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTzw3yGcHWk5syUQvcy/CqZS4xpw/1CZKUGwzZgcPe8=;
 b=Te6CuBpRIsTW6QJK9ZQ+LuGgUkm7bauKHqyYccCykJtrIW5HIEH9mWJ8sdoSNmuI1L
 6K+IlDmh+nr+klsoSLivyBXtQd8pZ2d5JSK7FkEwRapgyhzm5KSzMxa6m5u8bQlx878B
 f87y6aMF8tB0cSnvy72WGwSCuk2B+S5ziufXGxlB3JvAtBgs4ELJWKtE5l4rzWAkEcg9
 CBpF32xzSxjuSJJCT3liRcayMayr0aZDlYWrqF5ZSsAnPRLC7yjgIgcWuGNRT9WXH8UI
 RP/5ZroEZJFTnY+q/BowcrIJe00Hq+lmNm+rbyUc4uy7p8j3VAkPST4pEWdgIzYuqnA8
 79wQ==
X-Gm-Message-State: ABy/qLb04ZbeyoG99SZnrFZOUL0zBRGb8spUkrHcuyfr5MWoZw8x06jH
 q7/FSY3Xl9w4meJneCIdtWYPtY/3VslGCSpBhRWltPPs3K0dZtmGp1eRlPmk1pHh3yT3sA4N+Dy
 AbvFxbL8m5KNsZsE=
X-Received: by 2002:a17:906:20e:b0:994:2eda:d31c with SMTP id
 14-20020a170906020e00b009942edad31cmr2560551ejd.44.1689775775719; 
 Wed, 19 Jul 2023 07:09:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEnxTkHBLz0czWXjaH1dFO6C8xxrJYNmkmg7nejTBht2a9Fkyg5O4rsDk+9BswYnTd6rpSy0g==
X-Received: by 2002:a17:906:20e:b0:994:2eda:d31c with SMTP id
 14-20020a170906020e00b009942edad31cmr2560535ejd.44.1689775775443; 
 Wed, 19 Jul 2023 07:09:35 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a170906680600b009890e402a6bsm2389132ejr.221.2023.07.19.07.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:09:34 -0700 (PDT)
Message-ID: <82796f23-c9a7-7a52-96c4-f70d10a06d0a@redhat.com>
Date: Wed, 19 Jul 2023 16:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] vhost-vdpa: Match vhost-user's status reset
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-6-hreitz@redhat.com> <20230718145032.GF44841@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230718145032.GF44841@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18.07.23 16:50, Stefan Hajnoczi wrote:
> On Tue, Jul 11, 2023 at 05:52:27PM +0200, Hanna Czenczek wrote:
>> vhost-vdpa and vhost-user differ in how they reset the status in their
>> respective vhost_reset_status implementations: vhost-vdpa zeroes it,
>> then re-adds the S_ACKNOWLEDGE and S_DRIVER config bits.  S_DRIVER_OK is
>> then set in vhost_vdpa_dev_start().
>>
>> vhost-user in contrast just zeroes the status, and does no re-add any
>> config bits until vhost_user_dev_start() (where it does re-add all of
>> S_ACKNOWLEDGE, S_DRIVER, and S_DRIVER_OK).
>>
>> There is no documentation for vhost_reset_status, but its only caller is
>> vhost_dev_stop().  So apparently, the device is to be stopped after
>> vhost_reset_status, and therefore it makes more sense to keep the status
>> field fully cleared until the back-end is re-started, which is how
>> vhost-user does it.  Make vhost-vdpa do the same -- if nothing else it's
>> confusing to have both vhost implementations handle this differently.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   hw/virtio/vhost-vdpa.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> Hi Hanna,
> The VIRTIO spec lists the Device Initialization sequence including the
> bits set in the Device Status Register here:
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-1070001
>
> ACKNOWLEDGE and DRIVER must be set before FEATURES_OK. DRIVER_OK is set
> after FEATURES_OK.
>
> The driver may read the Device Configuration Space once ACKNOWLEDGE and
> DRIVER are set.
>
> QEMU's vhost code should follow this sequence (especially for vDPA where
> full VIRTIO devices are implemented).
>
> vhost-user is not faithful to the VIRTIO spec here. That's probably due
> to the fact that vhost-user didn't have the concept of the Device Status
> Register until recently and back-ends mostly ignore it.
>
> Please do the opposite of this patch: bring vhost-user in line with the
> VIRTIO specification so that the Device Initialization sequence is
> followed correctly. I think vhost-vdpa already does the right thing.

Hm.  This sounds all very good, but what leaves me lost is the fact that 
we never actually expose the status field to the guest, as far as I can 
see.  We have no set_status callback, and as written in the commit 
message, the only caller of reset_status is vhost_dev_stop().  So the 
status field seems completely artificial in vhost right now.  That is 
why I’m wondering what the flags even really mean.

Another point I made in the commit message is that it is strange that we 
reset the status to 0, and then add the ACKNOWLEDGE and DRIVER while the 
VM is still stopped.  It doesn’t make sense to me to set these flags 
while the guest driver is not operative.

If what you’re saying is that we must set FEATURES_OK only after 
ACKNOWLEDGE and DRIVER, wouldn’t it be still better to set all of these 
flags only in vhost_*_dev_start(), but do it in two separate SET_STATUS 
calls?

(You mentioned the configuration space – is that accessed while between 
vhost_dev_stop and vhost_dev_start?)

Hanna

>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index f7fd19a203..0cde8b40de 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -1294,8 +1294,6 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>>       }
>>   
>>       vhost_vdpa_reset_device(dev);
>> -    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>> -                               VIRTIO_CONFIG_S_DRIVER);
>>       memory_listener_unregister(&v->listener);
>>   }
>>   
>> @@ -1334,7 +1332,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>>           }
>>           memory_listener_register(&v->listener, dev->vdev->dma_as);
>>   
>> -        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>> +        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>> +                                          VIRTIO_CONFIG_S_DRIVER |
>> +                                          VIRTIO_CONFIG_S_DRIVER_OK);
>>       }
>>   
>>       return 0;
>> -- 
>> 2.41.0
>>


