Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99BA19779
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 18:23:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taeQp-0008FW-KM; Wed, 22 Jan 2025 12:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1taeQm-0008FJ-Mn
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:22:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1taeQi-0000mT-9T
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737566533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1DJ3mbYYPtF1dv0zGBztNPdVkwXOqkZhsg/5shleGqQ=;
 b=i/oSmrnuiPhcugf4Y1692+geIR6yJ1udtgSuYne1SrjT1KIhrfUt9/70PSpAbkmHoRjuHT
 lrVsvXRrSw4gFr4iB59Vh/qPhlrCVCVYgsBgecx4iNt4kctVifSTY4N2voTzYpyelZ4f7f
 PgcN3wg9SPl8E1KATqznFBrtCKd6n0E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-AgAsHOZjPSmharBSSSRahA-1; Wed, 22 Jan 2025 12:22:09 -0500
X-MC-Unique: AgAsHOZjPSmharBSSSRahA-1
X-Mimecast-MFC-AGG-ID: AgAsHOZjPSmharBSSSRahA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so4253470f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566528; x=1738171328;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DJ3mbYYPtF1dv0zGBztNPdVkwXOqkZhsg/5shleGqQ=;
 b=fL5kHdOtKZGmkEx5XX4wSQtAijV+Z3lkWel+T8vlwoAqvaDSCW5wTWWJupP/TJJhZq
 SVtCOM2CSupcU3lhUZFYC56SnL2BVR3WOb1Uz/RKcxw03VNH/gHVJVO7aZfV0tCUEI1g
 VCEDJ+XWtnQRZUNHPBOpwK5l+wAExg5vxRNXdhMSMhVsqO8ClH5QBkravd2RKjBDiEGp
 wegKAsk0WebsOd9LWb/wU8urio6drRs9g5eBF5q0qiJj++kb8RIKreRhyQm5Sm+OrYHO
 k4vU5J8gCOGyOgrmU6vu2eHWVFohVHw9Igg0iqsUT120pPSmJU5IU0bySYnfLcLJDXl7
 hqNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf8KNOsJpGMNibRcw2uzzZhAtmIxUNJbXDsX3F5A5Y4jr/Wj+fGhk5u9mIEGV43qTRtg6snLGL6FnX@nongnu.org
X-Gm-Message-State: AOJu0YxgU+VWx9gMYqKimahWseA7jWZ9ahfoQ+CqZojrnIEoEcVoKdqc
 YpMxveiTUaAG8aErAGMvUOilUiVnDTU7bRCUbFM4O7SAN16A4Ket0o1PTXjzmMIi6uVwY+zMG0V
 G3cjnzpl3aFiepwpQenztmCdsXBezCNhh5Pq0zIoEzcLo8R9EVYET
X-Gm-Gg: ASbGncsvJw7DES1BbPJu79X7NbltnYVYVZtykV6QY+KGQegTR3EncBgLC4/DdgQLCO7
 yIJgZF6pJrhxiYfIDf+YQJZMLsfk3iLDogcshyvoNCyzif3gld/EwulOtzfRLZ6KnpjdPAgwXWw
 ll7f6FiDqsqRn5m6AvARuYrtd6aswUQKDCm81kb748gKzWt2HSdGcE3DSQ/SGgeqyTe1ISXWDkK
 1qGZr0XgMWQTBEeBd2DPfjheDYVsdpFntIyeWP04VF2cENkrQkus34YIlXrwaBpq+SiHIeDvh9i
 Q+LzZVfFlNhj1uHItyk3oiytVg4Fu21L
X-Received: by 2002:a5d:6d86:0:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-38bf5655264mr20411908f8f.2.1737566527594; 
 Wed, 22 Jan 2025 09:22:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYaaPyTGr+NwzUj0uLmP1jn5nym4AB8vtz5FsJratfEkKmlVsi8jgEk9+v+5mhDw9YC5LKlQ==
X-Received: by 2002:a5d:6d86:0:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-38bf5655264mr20411880f8f.2.1737566527203; 
 Wed, 22 Jan 2025 09:22:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221db2sm16571188f8f.29.2025.01.22.09.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 09:22:06 -0800 (PST)
Message-ID: <28e3e395-0eaa-4eeb-bd61-1cb031d8da7f@redhat.com>
Date: Wed, 22 Jan 2025 18:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On 22/01/2025 17:51, Stefano Garzarella wrote:
> On Wed, Jan 22, 2025 at 05:41:15PM +0100, Laurent Vivier wrote:
>> On 22/01/2025 17:20, Stefano Garzarella wrote:
>>> On Wed, Jan 22, 2025 at 08:59:22AM -0500, Michael S. Tsirkin wrote:
>>>> On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote:
>>>>> On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
>>>>>> In vhost_user_receive() if vhost_net_notify_migration_done() reports
>>>>>> an error we display on the console:
>>>>>>
>>>>>>   Vhost user backend fails to broadcast fake RARP
>>>>>>
>>>>>> This message can be useful if there is a problem to execute
>>>>>> VHOST_USER_SEND_RARP but it is useless if the backend doesn't
>>>>>> support VHOST_USER_PROTOCOL_F_RARP.
>>>>>>
>>>>>> Don't report the error if vhost_net_notify_migration_done()
>>>>>> returns -ENOTSUP (from vhost_user_migration_done())
>>>>>>
>>>>>> Update vhost_net-stub.c to return -ENOTSUP too.
>>>>>>
>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>> ---
>>>>>> hw/net/vhost_net-stub.c | 2 +-
>>>>>> net/vhost-user.c        | 2 +-
>>>>>> 2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>>>>>> index 72df6d757e4d..875cd6c2b9c8 100644
>>>>>> --- a/hw/net/vhost_net-stub.c
>>>>>> +++ b/hw/net/vhost_net-stub.c
>>>>>> @@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState 
>>>>> *net, VirtIODevice *dev, bool mask)
>>>>>>
>>>>>> int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
>>>>>> {
>>>>>> -    return -1;
>>>>>> +    return -ENOTSUP;
>>>>>> }
>>>>>>
>>>>>> VHostNetState *get_vhost_net(NetClientState *nc)
>>>>>> diff --git a/net/vhost-user.c b/net/vhost-user.c
>>>>>> index 12555518e838..636fff8a84a2 100644
>>>>>> --- a/net/vhost-user.c
>>>>>> +++ b/net/vhost-user.c
>>>>>> @@ -146,7 +146,7 @@ static ssize_t 
>>>>> vhost_user_receive(NetClientState *nc, const uint8_t *buf,
>>>>>>
>>>>>>          r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
>>>>>>
>>>>>> -        if ((r != 0) && (display_rarp_failure)) {
>>>>>> +        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
>>>>>>              fprintf(stderr,
>>>>>>                      "Vhost user backend fails to broadcast fake RARP\n");
>>>>>>              fflush(stderr);
>>>>>> -- 
>>>>>> 2.47.1
>>>>>>
>>>>>
>>>>> IIUC the message was there since the introduction about 10 years ago
>>>>> from commit 3e866365e1 ("vhost user: add rarp sending after live
>>>>> migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
>>>>> and F_GUEST_ANNOUNCE are not negotiated.
>>>>>
>>>>> That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,
>>>>
>>>> rarp is to have destination host broadcast a message with VM address
>>>> to update the network. Guest announce is when it will instead
>>>> ask the guest to do this.
>>>
>>> Okay, thanks for explaining to me.
>>> So if both features are not negotiated, no one is going to broadcast
>>> the message, right?
>>>
>>> Could that be a valid reason to print an error message in QEMU?
>>>
>>> To me it might be reasonable because the user might experience some
>>> network problems, but I'm not a network guy :-)
>>
>> I'm working on adding vhost-user to passt[1], and in this case we don't need to 
>> broadcast any message.
> 
> Okay, so please can you add that to the commit description and also
> explaining why you don't need that?
> 
>>
>> So I don't implement VHOST_USER_SEND_RARP and I don't want the error message to spoil my 
>> console.
> 
> Fair enough, but at that point, if it's valid to have both feature not
> negotiated, IMHO is better to return 0 in vhost_user_migration_done().
> Maybe adding also a comment to explain that in your scenario you don't
> need to do nothing (like if guest supports GUEST_ANNOUNCE).

I agree.

> 
>>
>> -ENOTSUP is an error message for developer not for user.
> 
> I was referring to the "Vhost user backend fails to broadcast fake RARP"
> error message we are skipping here.

So in the end my real question at this point is:

is it better to suppress the error message in QEMU (1) or implement an empty 
VHOST_USER_SEND_RARP in Passt (2)?

As this discussion is going on I'm no longer sure that (1) is the right one.

Thanks,
Laurent


