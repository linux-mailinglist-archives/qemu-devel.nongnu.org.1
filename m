Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E070E0CB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:43:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UAN-0002Ec-Bi; Tue, 23 May 2023 11:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1UAG-0001uy-VI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1UAE-0004yr-2y
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VeeBIDA1fw0moH+QHQ6iHY9l7RHyt+5FOeXzuf7uTk=;
 b=WOrNs/zTIuCK2p+GJ+3QizcoXEnHwIIcPyVbTIAv/+c3WBdVIVPFzz+QQjcVTlwCKWfvzJ
 97670/fv40h+j963txEZ+lUWGZL0YyPrdEIAn6i0L6ziBB7JQzsoz9LXVWjUoTh/Lu9177
 cdt7GBD0LTuJhu1z2TAESl7xcHLFQS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-YgnrljmkPxKjl6Huoennmw-1; Tue, 23 May 2023 11:43:03 -0400
X-MC-Unique: YgnrljmkPxKjl6Huoennmw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30953bcb997so1775288f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684856581; x=1687448581;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5VeeBIDA1fw0moH+QHQ6iHY9l7RHyt+5FOeXzuf7uTk=;
 b=f2mI0+kcHpuzLI8r3SOGLW3RSrO32zx+W+gyqUeYiTtIgLPmkfQHP+Q5FMrK3+kWmp
 MeGlmlPjjcqeW5xnABpJdwjU4g1o29OhrsYDDdOSlAb4FKR7bxa8jza62/YUrLZvF2aI
 vRj+aqDLUNVb50N/ZEpjRdaxQYmTScJCd6jZGGUBWAZ964hIzfEH3tcYam+V+DR8ZAWN
 57fzqx/qNG/Qd3HpX/bYVvXdPd9BnAvyMfUO18QWuQ6VOoE7u3L82WYoMfweQtNymvK2
 yFehFrb2q3+/qfn0UMZqBUK77cCaI4Hf7En4VCYwIOZ7zQha++DmPlRbgkIAhT+bRt6V
 soEw==
X-Gm-Message-State: AC+VfDzP0kxPBUqUiE1Gp0jUUiSBOq0/Ppij3VS5lnZAgmGXH465O4qk
 g3ulfg6SGGwYWWYmwjp21GAME70/53OGvtM3gbXCf90Q99XU2zSoz0T8af+bJdY/0iF4p5jHv74
 NErBm91DbnPNyr9w=
X-Received: by 2002:a5d:5007:0:b0:306:46c4:d313 with SMTP id
 e7-20020a5d5007000000b0030646c4d313mr9897089wrt.28.1684856581631; 
 Tue, 23 May 2023 08:43:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zkyFJ4RHgzIlyjSW9jqTqT8Jo5ZCMPt0QViFQXdzdWUoMythDACfOZcZUZuaZTT64jsjzTg==
X-Received: by 2002:a5d:5007:0:b0:306:46c4:d313 with SMTP id
 e7-20020a5d5007000000b0030646c4d313mr9897070wrt.28.1684856581236; 
 Tue, 23 May 2023 08:43:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd?
 (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de.
 [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a5d62c5000000b003068f5cca8csm11450895wrv.94.2023.05.23.08.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 08:43:00 -0700 (PDT)
Message-ID: <ba3eaff4-83e7-b9be-bf8b-9fa21d16e11d@redhat.com>
Date: Tue, 23 May 2023 17:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Tiwei Bie <tiwei.bie@intel.com>
References: <20230503172121.733642-1-david@redhat.com>
 <20230503172121.733642-2-david@redhat.com> <ZGzdIfLy+7rSh6fW@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/3] vhost: Rework memslot filtering and fix
 "used_memslot" tracking
In-Reply-To: <ZGzdIfLy+7rSh6fW@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[...]

>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -46,20 +46,33 @@
>>   static struct vhost_log *vhost_log;
>>   static struct vhost_log *vhost_log_shm;
>>   
>> +/* Memslots used by backends that support private memslots (without an fd). */
>>   static unsigned int used_memslots;
>> +
>> +/* Memslots used by backends that only support shared memslots (with an fd). */
>> +static unsigned int used_shared_memslots;
> 
> It's just that these vars are updated multiple times when >1 vhost is
> there, accessing these fields are still a bit confusing - I think it's
> implicitly protected by BQL so looks always safe.

Yes, like the existing variable.

> 
> Since we already have the shared/private handling, maybe for the long term
> it'll be nicer to just keep such info per-device e.g. in vhost_dev so we
> can also drop vhost_backend_no_private_memslots().  Anyway the code is
> internal so can be done on top even if worthwhile.

Might be possible, but I remember there was a catch to it when 
hotplugging a device.

> 
>> +
>>   static QLIST_HEAD(, vhost_dev) vhost_devices =
>>       QLIST_HEAD_INITIALIZER(vhost_devices);
>>   
>>   bool vhost_has_free_slot(void)
>>   {
>> -    unsigned int slots_limit = ~0U;
>> +    unsigned int free = UINT_MAX;
>>       struct vhost_dev *hdev;
>>   
>>       QLIST_FOREACH(hdev, &vhost_devices, entry) {
>>           unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
>> -        slots_limit = MIN(slots_limit, r);
>> +        unsigned int cur_free;
>> +
>> +        if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
>> +            hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
>> +            cur_free = r - used_shared_memslots;
>> +        } else {
>> +            cur_free = r - used_memslots;
>> +        }
>> +        free = MIN(free, cur_free);
>>       }
>> -    return slots_limit > used_memslots;
>> +    return free > 1;
> 
> Should here be "free > 0" instead?
> 
> Trivial but maybe still matter when some device used exactly the size of
> all memslots of a device..

Very good catch, thanks Peter!

-- 
Thanks,

David / dhildenb


