Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7623988A20
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Sep 2024 20:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFoB-0001J3-Jj; Fri, 27 Sep 2024 14:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1suFo4-0001Fk-2e
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 14:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1suFnz-0001GE-Tv
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 14:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727462101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GWg8vZp/Vb4oBnw7lR4TAf+m8i+ZfkkiFBOpaXgJQ20=;
 b=grvxR7YmEmb/gC7koSCGddG1lCd52mkkYFYxDgJKnXI3Ik8nIc8smJOsvCVt6E0wlLp/th
 Fw3iKRfFb25PfEX3XMNHtRIw1SmoisOL7ViA+CfsrrPWru5VHzeqnmRrMzdSPba/bIOjVN
 7uLPzToHbB9xOTy/umQ0Yh4XQbrmukM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-rqek2BIGPLSAiTcABoT7fg-1; Fri, 27 Sep 2024 14:35:00 -0400
X-MC-Unique: rqek2BIGPLSAiTcABoT7fg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42e77b5d3dcso15174495e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 11:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727462099; x=1728066899;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWg8vZp/Vb4oBnw7lR4TAf+m8i+ZfkkiFBOpaXgJQ20=;
 b=Womv9SFB5DXsmcSiA/Mka4RtQWoKG5umiLJCXAi+IfLbZoLwi52sZDqHaWgplydZVN
 W3J82e1N8k7mUDPf1ht0RsVhSuzMWq7YEFpfqFfwJ05w3xGNNzOphFmkMJW/PJCSImrL
 aWedu7idKK3+09o/h6NviCDHohe7e2R/RPsk5LTn8b8Uq1/miKWUOf5aaC4kB+gYZ9Su
 CnczZtjBDgNE+bGHA1PCaO4L+AK/qXoODa9Rb4qSzjB4mUAqgX4sMBy+L3ktBaidsnwR
 BOX1J71pGi0TqYyj0gONJaY5yokVyqD6ZUXsl0M34DQfsqtj5MklZ5AFRsPpMat/zpE3
 rwuA==
X-Gm-Message-State: AOJu0YzWL59jkA+PeTDHYAZgqvBXlEebYQUH41T2XN5PJxFxOMJ12CmN
 CRfULFGMqj8TU41r1FUQ1FFuBzXRjShvKkBWZnQqxU21dYCoWtKKZtnnrg0xdVyfX+BnXS2JaFx
 vCuop0RRtkRtXIwBsTyuE8M1yIq8Z7lnRpZIQhHP0WB2XVDhra0Hp
X-Received: by 2002:a05:600c:4454:b0:42c:b58d:98ad with SMTP id
 5b1f17b1804b1-42f5843312amr29433625e9.14.1727462098862; 
 Fri, 27 Sep 2024 11:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6H+yZEmNMA0ASqZfwXS3WTR9568RxWFI73244sjafb7ND/+iaAPWNrG/VdCY7t1D7SxMiMw==
X-Received: by 2002:a05:600c:4454:b0:42c:b58d:98ad with SMTP id
 5b1f17b1804b1-42f5843312amr29433415e9.14.1727462098312; 
 Fri, 27 Sep 2024 11:34:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:8000:b502:8c1c:3624:99d4?
 (p200300cbc7098000b5028c1c362499d4.dip0.t-ipconnect.de.
 [2003:cb:c709:8000:b502:8c1c:3624:99d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dec19bsm34387485e9.26.2024.09.27.11.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 11:34:57 -0700 (PDT)
Message-ID: <a5b9e4e7-b1af-425e-8fc6-07e194c7bf08@redhat.com>
Date: Fri, 27 Sep 2024 20:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
To: Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
 <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
 <20240927200525.5a90f172.pasic@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240927200525.5a90f172.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 27.09.24 20:05, Halil Pasic wrote:
> On Thu, 12 Sep 2024 10:19:00 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>>> diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
>>> index b7ac29f444..f0ca62bcbb 100644
>>> --- a/hw/s390x/s390-hypercall.h
>>> +++ b/hw/s390x/s390-hypercall.h
>>> @@ -18,6 +18,7 @@
>>>    #define DIAG500_VIRTIO_RESET            1 /* legacy */
>>>    #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
>>>    #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
>>> +#define DIAG500_STORAGE_LIMIT           4
>>>    
>>>    int handle_diag_500(CPUS390XState *env);
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> Sounds very reasonable to me - but it would be good to get an
>> Ack/Reviewed-by from IBM folks here (in case they prefer a different
>> interface)... hope they'll join the discussion!
>>
>>    Thomas
> 
> According to Documentation/virt/kvm/s390/s390-diag.rst in the
> linux source tree DIAG 500 is for kvm virtio funcions.

I assume you skimmed the QEMU patches, including the one that suggest 
changing (or rather extending) that.

> 
> Based on the commit message this storagelimit DIAG is rather loosely
> tied to virtio if at all, so from that perspective DIAG may not be a
> perfect fit. OTOH I don't see a better fit either. I would prefer to
> have Christian's opinion on this. I have no strong opinion myself.
> 
 > If we decide to go with a DIAG, I would like to see> 
Documentation/virt/kvm/s390/s390-diag.rst
> updated accordingly.

I'll document wherever people fancy. I'll even document in multiple 
locations :)

> 
> Also if decide to go with DIAG 500, maybe leaving some space
> between the codes more closely tied to virtio and between
> the ones less closely tied to virito (for the unlikely case
> that we end up wanting another DIAG 500 subcode for virtio)
> might make sense. I.e e could make DIAG500_STORAGE_LIMIT
> 8 or 16 instead of 4. Again nothing important, just an idea.

I don't see a reason to do that, but in the end I don't care as long as 
people let me know what to do instead.

Thanks for taking a look!

-- 
Cheers,

David / dhildenb


