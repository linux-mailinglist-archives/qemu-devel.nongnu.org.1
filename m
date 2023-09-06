Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC3793E7F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:15:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtIX-0007jO-OA; Wed, 06 Sep 2023 10:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdtIN-0007jB-5X
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdtII-0001Zw-IR
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694009648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzHtwompDH4ot0mG0goaqF7vDhNcRl6a7TGwlvNbsco=;
 b=aDuNRNIR8/fbbsi6YFD/h6FlbC4DyK0PjQsjbKLTXYbBp1cPp+i/pjo8YN+MvCkmbZZ77T
 J0bijqMc8oEAnI1APYdl/hYb92FmSKEctYbd521HYQPPfStC3w27smBkFa0d50JEcGk6eD
 f5zGcBrWMXmlte7zQ/X7gYriGAvsEII=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Lr37wRHsP_eUUY1rqkGpeA-1; Wed, 06 Sep 2023 10:14:07 -0400
X-MC-Unique: Lr37wRHsP_eUUY1rqkGpeA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c470305cfso1915436f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694009646; x=1694614446;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lzHtwompDH4ot0mG0goaqF7vDhNcRl6a7TGwlvNbsco=;
 b=kgowcy+l0KyNRchJSU+JuguN/oKof+EDW4jGQY4iff8Y3plFzWEZ/u7WQmN8UowVsf
 FJHefEQf7mHPU6/iNiZmymfSitoLzEiegPRq/LJPui6fCm3Xw9D0kWnL3/iIQNfOgRQS
 NZ4+yTuCa2kChKiih1A2QrmoSvZHzNUNsKizthgmjbSpKk5d/XjGqA9pK8NSecR0w79U
 sUgXUL8kd0K4YCzkLcym2dGk4kXmpc/NjU409HO2J7+gUbw0MDdgx78BkMeEq9uS+hBr
 TNZTQN1Ig7StybOiLufxFtSR17UWlP+9kuUoxwFmtpKE1jNBguiSK4pE3G8URo6Ixj0e
 lkBA==
X-Gm-Message-State: AOJu0YxM4V12uvZmqvC3N1Dp0PQKxnbQBzu6nie8xRGCMDHXyXJ7nI81
 iMI9WfDJPtjSBZbcf2EWvnwKiqADy872HgrKnWFk+ci9q6htHA7nJLhOnTIMUDlmCMmHuHec6wi
 YcwtrqXkTv6kO1i0=
X-Received: by 2002:a5d:474e:0:b0:314:4c1d:1c0a with SMTP id
 o14-20020a5d474e000000b003144c1d1c0amr2348508wrs.46.1694009645908; 
 Wed, 06 Sep 2023 07:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXHV85Qfrs1ZUl+gwI9DJTy3NJogPF2+CGxYJqLMVvXxXZdS0EA3zezyOq4W7Ai8SGu21k1g==
X-Received: by 2002:a5d:474e:0:b0:314:4c1d:1c0a with SMTP id
 o14-20020a5d474e000000b003144c1d1c0amr2348478wrs.46.1694009645490; 
 Wed, 06 Sep 2023 07:14:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853?
 (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de.
 [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a5d5012000000b00317b063590fsm20537277wrt.55.2023.09.06.07.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:14:05 -0700 (PDT)
Message-ID: <ee1bbc2b-3180-ab79-4f0d-6159577b2164@redhat.com>
Date: Wed, 6 Sep 2023 16:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/16] kvm: Return number of free memslots
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
References: <20230825132149.366064-1-david@redhat.com>
 <20230825132149.366064-5-david@redhat.com>
 <1d68ca74-ce92-ca5f-2c8b-e4567265e2fc@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1d68ca74-ce92-ca5f-2c8b-e4567265e2fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 29.08.23 00:26, Philippe Mathieu-Daudé wrote:
> On 25/8/23 15:21, David Hildenbrand wrote:
>> Let's return the number of free slots instead of only checking if there
>> is a free slot. While at it, check all address spaces, which will also
>> consider SMM under x86 correctly.
>>
>> Make the stub return UINT_MAX, such that we can call the function
>> unconditionally.
>>
>> This is a preparation for memory devices that consume multiple memslots.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    accel/kvm/kvm-all.c      | 33 ++++++++++++++++++++-------------
>>    accel/stubs/kvm-stub.c   |  4 ++--
>>    hw/mem/memory-device.c   |  2 +-
>>    include/sysemu/kvm.h     |  2 +-
>>    include/sysemu/kvm_int.h |  1 +
>>    5 files changed, 25 insertions(+), 17 deletions(-)
> 
> 
>> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
>> index 235dc661bc..f39997d86e 100644
>> --- a/accel/stubs/kvm-stub.c
>> +++ b/accel/stubs/kvm-stub.c
>> @@ -109,9 +109,9 @@ int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>>        return -ENOSYS;
>>    }
>>    
>> -bool kvm_has_free_slot(MachineState *ms)
>> +unsigned int kvm_get_free_memslots(void)
>>    {
>> -    return false;
>> +    return UINT_MAX;
> 
> Isn't it clearer returning 0 here and keeping kvm_enabled() below?

I tried doing it similarly to vhost_has_free_slot().

Also simplifies patch #12 :)

No strong opinion, though.

> 
> 
>> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
>> index 511b42bde5..8b09e78b12 100644
>> --- a/include/sysemu/kvm_int.h
>> +++ b/include/sysemu/kvm_int.h
>> @@ -40,6 +40,7 @@ typedef struct KVMMemoryUpdate {
>>    typedef struct KVMMemoryListener {
>>        MemoryListener listener;
>>        KVMSlot *slots;
>> +    int nr_used_slots;
> 
> Preferably using 'unsigned' here:

Sure, that should work.

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

-- 
Cheers,

David / dhildenb


