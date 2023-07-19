Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3207597CE
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7tv-0000lL-Mc; Wed, 19 Jul 2023 10:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7tq-0000l4-IT
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7to-0004dS-Vm
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689775888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5W1XZDpfiUjBTaZ5geXLQmABHR7Nk/yltqKElnpKWE=;
 b=gcwBiEOukYRMQ4PQ5XtA1H8eCrwrefgGIfXF2IHYCgB8YoDqjmfbBv3C7npP5VAUYSJVrZ
 wvsrSdFkWVxqsK7ujElk5EB7W7ZXGxiL7agjYEoxvbynFCyPzYD+d6tr35eiLiaKDEviJY
 QEjVQ24ZyLhHsJOQyoh0Uejp/kbUoz4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-vGuGOKRsPGioFHkNTM42GQ-1; Wed, 19 Jul 2023 10:11:26 -0400
X-MC-Unique: vGuGOKRsPGioFHkNTM42GQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51dd4df2477so4877227a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689775886; x=1692367886;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5W1XZDpfiUjBTaZ5geXLQmABHR7Nk/yltqKElnpKWE=;
 b=T4YRgJCN/ALSZVASk99VKE6TIfRX9jxFGQrCWk8Gxtd3OHbklw2xsjNdMJPgRxZ6O7
 Zz3T8lNTIwkK94DCSdKFEb3eO7EmWNoQqgiOZrQoiSASVmD0fXENtm9x7NRnsgcZ1luE
 Y//2JZFLayeKIbc/ltjf1HmQv+TZE4i+6CRrllpBloQeG+VnjR6JXyD9oLxwMfKZMqbL
 gkOMvPb+aUqNQzYF7l7v07FWzjIOHiI47HnfXWf6Ns9zkBAvOfjK7jGH+QmmsMrlqFg4
 G+Fl2KuK+yRDQ7Xvy2X0ELCLWhuCU4F/lATr2ljANAu3dRcBpKMOFf1PDlAM80FS5UrL
 /q3g==
X-Gm-Message-State: ABy/qLaGhQeZNDNbDJ789jcMF8E1Warv0gd0Uwh72y/a58qYfwsS5iF5
 zspe1D149fnSmbgHal6sk2xKh+ZhURjDIr09Lacn29QqiMrKoV/W3cu1dZmgtVg7H5pjlv+2WVk
 QNSy5ql2WDHwx6Ng=
X-Received: by 2002:aa7:d416:0:b0:521:7186:bab1 with SMTP id
 z22-20020aa7d416000000b005217186bab1mr2364887edq.6.1689775885845; 
 Wed, 19 Jul 2023 07:11:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPskKBKe9R+7/JwVLvBLxAWm9rN+wf0YFO3ArhysN0nWcuoCbH/Ik6UDvRKsw/z/L1owJnYg==
X-Received: by 2002:aa7:d416:0:b0:521:7186:bab1 with SMTP id
 z22-20020aa7d416000000b005217186bab1mr2364872edq.6.1689775885514; 
 Wed, 19 Jul 2023 07:11:25 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a056402040800b0051e2809395bsm2720108edv.63.2023.07.19.07.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:11:25 -0700 (PDT)
Message-ID: <7ba1e055-e513-1735-5e60-eceb06fe877a@redhat.com>
Date: Wed, 19 Jul 2023 16:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] vhost-user: Have reset_status fall back to reset
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-7-hreitz@redhat.com> <20230718151044.GG44841@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230718151044.GG44841@fedora>
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

On 18.07.23 17:10, Stefan Hajnoczi wrote:
> On Tue, Jul 11, 2023 at 05:52:28PM +0200, Hanna Czenczek wrote:
>> The only user of vhost_user_reset_status() is vhost_dev_stop(), which
>> only uses it as a fall-back to stop the back-end if it does not support
>> SUSPEND.  However, vhost-user's implementation is a no-op unless the
>> back-end supports SET_STATUS.
>>
>> vhost-vdpa's implementation instead just calls
>> vhost_vdpa_reset_device(), implying that it's OK to fully reset the
>> device if SET_STATUS is not supported.
>>
>> To be fair, vhost_vdpa_reset_device() does nothing but to set the status
>> to zero.  However, that may well be because vhost-vdpa has no method
>> besides this to reset a device.  In contrast, vhost-user has
>> RESET_DEVICE and a RESET_OWNER, which can be used instead.
>>
>> While it is not entirely clear from documentation or git logs, from
>> discussions and the order of vhost-user protocol features, it appears to
>> me as if RESET_OWNER originally had no real meaning for vhost-user, and
>> was thus used to signal a device reset to the back-end.  Then,
>> RESET_DEVICE was introduced, to have a well-defined dedicated reset
>> command.  Finally, vhost-user received full STATUS support, including
>> SET_STATUS, so setting the device status to 0 is now the preferred way
>> of resetting a device.  Still, RESET_DEVICE and RESET_OWNER should
>> remain valid as fall-backs.
>>
>> Therefore, have vhost_user_reset_status() fall back to
>> vhost_user_reset_device() if the back-end has no STATUS support.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   hw/virtio/vhost-user.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 4507de5a92..53a881ec2a 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -2833,6 +2833,8 @@ static void vhost_user_reset_status(struct vhost_dev *dev)
>>       if (virtio_has_feature(dev->protocol_features,
>>                              VHOST_USER_PROTOCOL_F_STATUS)) {
>>           vhost_user_set_status(dev, 0);
>> +    } else {
>> +        vhost_user_reset_device(dev);
>>       }
>>   }
> Did you check whether DPDK treats setting the status to 0 as equivalent
> to RESET_DEVICE?

If it doesn’t, what’s even the point of using reset_status?

I will investigate, but if there’s a difference, that makes the whole 
reset_* thing even more questionable to me than it has already been so far.

Hanna

> My understanding is that SET_STATUS is mostly ignored by vhost-user
> back-ends today. Even those that implement it may not treat SET_STATUS 0
> as equivalent to RESET_DEVICE.
>
> If you decide it's safe to make this change, please also update
> vhost-user.rst to document that front-ends should use SET_STATUS 0,
> RESET_DEVICE, and RESET_OWNER in order of preference.
>
> Stefan


