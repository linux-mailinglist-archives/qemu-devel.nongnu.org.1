Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729DF779251
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTcY-0003Li-Pd; Fri, 11 Aug 2023 11:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUTcS-0003Kv-IG
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUTcQ-00047i-TE
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691766000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeqeOWBNv9vOHhEwLnfF+r5JIkRbDBAW0AFuzAz8+y4=;
 b=ZlFmGH2WkdEIsA1fZxRRAdau+PP+69F7woS2iKAfznRN/xJ6JFSab8/qF5IL0DJ3R+pK3T
 NJuZmSqQGoqNr9hppAlNglL4n8UNxOvrWd2Ab3OXKzPT27Ka7Ul0JMRoTPiL8i26VweNS+
 lxIUcm/B2Wu5KY+TSwGVjAoONDqc84k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-GAyYzttkMa6UDSmKldyaZQ-1; Fri, 11 Aug 2023 10:59:59 -0400
X-MC-Unique: GAyYzttkMa6UDSmKldyaZQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso1175249f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691765998; x=1692370798;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LeqeOWBNv9vOHhEwLnfF+r5JIkRbDBAW0AFuzAz8+y4=;
 b=GSbeZgEe2q2vApO4yAotkTRcnFdEon+2nJ1V9gGahafg1zUjPTsPnZwYy3Tar19vRi
 kSf0st+gQKs0eOPfwRczBmdc47LfaNSFG1Qx27LH3z4BLpL06GiMw3SLOC20E60pg4az
 ijvWcjLIEbHzIIiv+vhdoSlTWIUtpQDxmXrsLaxZOS2h79QOBMWQixw1IfaLNJpLaR8z
 23pJOpyj1BKXSx/s3z0Lwqb9mFyl+eNZihhZL+ctfSyHky0+Hn+6SmSGwjT8eOYp6Wml
 4waz4XjxxI4Fpnepto48zSsUa5Hxi4AfhYIUOU6EcvXOT1KzgILrBNk12t7ekdH7Y+Ou
 2J+w==
X-Gm-Message-State: AOJu0Yzo4f8hrwBlG4iwgf0ANxfXK524UXjvV/PZWkcF7XxxCfEpNsTg
 PiZzASHL89MSUPm1Z9lc7NW6YRbReutgMueTC4q/6+oTt2Fmx1NIiSo7/wunnmhQnRe5I1j9ZQE
 ZFvnOYdtpAuYqxd4=
X-Received: by 2002:a7b:cd0f:0:b0:3fe:5053:1a0b with SMTP id
 f15-20020a7bcd0f000000b003fe50531a0bmr1922351wmj.11.1691765998035; 
 Fri, 11 Aug 2023 07:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFggcWKMUaJNMLPuK6Z4UN1x3ZaboRdLSvinWBw8o+so2/eT0aT+7lJFHtmasVtSskTZNGDVA==
X-Received: by 2002:a7b:cd0f:0:b0:3fe:5053:1a0b with SMTP id
 f15-20020a7bcd0f000000b003fe50531a0bmr1922341wmj.11.1691765997678; 
 Fri, 11 Aug 2023 07:59:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20?
 (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de.
 [2003:cb:c71a:3000:973c:c367:3012:8b20])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c044a00b003fbc9d178a8sm8384176wmb.4.2023.08.11.07.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 07:59:57 -0700 (PDT)
Message-ID: <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
Date: Fri, 11 Aug 2023 16:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, ThinerLogoer <logoerthiner1@163.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <ZNVVmxuQAsSEHqZq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10.08.23 23:24, Peter Xu wrote:
> On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
>>> I think we have the following options (there might be more)
>>>
>>> 1) This patch.
>>>
>>> 2) New flag for memory-backend-file. We already have "readonly" and
>>> "share=". I'm having a hard time coming up with a good name that really
>>> describes the subtle difference.
>>>
>>> 3) Glue behavior to the QEMU machine
>>>
>>
>> 4) '-deny-private-discard' argv, or environment variable, or both
> 
> I'd personally vote for (2).  How about "fdperm"?  To describe when we want
> to use different rw permissions on the file (besides the access permission
> of the memory we already provided with "readonly"=XXX).  IIUC the only sane
> value will be ro/rw/default, where "default" should just use the same rw
> permission as the memory ("readonly"=XXX).

Hmm, I'm not particularly happy about that.

> 
> Would that be relatively clean and also work in this use case?
> 

I get the feeling that we are over-engineering something that probably 
should never have been allowed: MAP_PRIVATE mapping of a file and 
opening it rw because someone might punch holes into it.

Once we start adding new parameters just for that, I get a bit skeptical 
that this is what we want. The number of people that care about that are 
probably close to 0.

The only real use case where this used to make sense (by accident I 
assume) was with hugetlb. And somehow, we decided that it was a good 
idea for "-mem-path" to use MAP_PRIVATE.

So, what stops us from

a) Leaving -mem-path alone. Keep opening files rw.
b) Make memory-backend-file with shared=off,readonly=off open the file
    read-only
c) Gluing that behavior to a QEMU compat machine

fallocate(PUNCH_HOLE) will fail, and we can probably let 
virtio-mem/virtio-balloon and postcopy refuse to even start (virtio-mem 
already does that) as early as possible.

People that care about any such use case would already get a warning 
when punching a hole today.

If we ever support discarding RAM in that configuration, we can simply 
unlock it again.

Am I missing any important use case?

-- 
Cheers,

David / dhildenb


