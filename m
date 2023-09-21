Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BF7A92F6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:11:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFiQ-0007RC-4S; Thu, 21 Sep 2023 05:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFiN-0007Qv-Re
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFiM-0000RN-3o
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695287472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=az+fkq8hztpdEGjaiUXR8BZ89IZXFCcBlHnioJmRZy0=;
 b=fMzx4xD8kt9TBtufc2/h2TGmIiJNi7sPtEDr5gjgdHkg2PzMrp5XHArzcuH+Pj5Psynr8A
 4PPvNik2KlUlQAcr67oHqXWr0WSMb5+N6TBQijkwSCeUn/RHHcGPw5E7Zb4XsBDJrHLXg5
 wdN5PPOa9olHHj+TXd5Ac90r3blRn38=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-zxfmsxctO6yGR8UlzJejjQ-1; Thu, 21 Sep 2023 05:11:09 -0400
X-MC-Unique: zxfmsxctO6yGR8UlzJejjQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-502d58d14beso1055001e87.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695287468; x=1695892268;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=az+fkq8hztpdEGjaiUXR8BZ89IZXFCcBlHnioJmRZy0=;
 b=oCtp76mkPliyCW91bQUwnwnuSyWLrxLsU37nFialWg4QGXL12gXSIUUcCh2y48sw7L
 NSwyYlqFS2Vd3lr2cS973E3XkxCmKVD3Tg+vfh2cPkPbautaWPzciwLzxkT2chmMkQaF
 hGHb4gORAOU8WOTI+0ZvYObk76ixzTqgz8gJ1dmNXFrzlLhDKTy3OEe4eoaWja7y/Sv/
 tD/XgIQgXyn9PeK5ArE8bOFq8xbHgWJ18Z/Ahyd/tlJ3OdOiwozQvILETVrk81pAx5Dc
 u9exfp+qNcXoaPjPFF+QQ+fzAuBlj9qKt8gpg2chJknCztO+IZHN8SGmoyroSC0nWRT+
 1EHQ==
X-Gm-Message-State: AOJu0YyI7XczozXNrvdkaXJGUnV8qMSRdIdfZXo7FJ4UXm4oSLkV3H3+
 PZMNwTtUUm5JsmaZ7FYDG4jhvg6GKVhrAdquPAiWPztg/mHiDjA1cfY+kmENGU5EolkmeEG0TpS
 KiwBzcMVakHrfjag=
X-Received: by 2002:a05:6512:a8b:b0:502:ff3b:7670 with SMTP id
 m11-20020a0565120a8b00b00502ff3b7670mr5755831lfu.4.1695287467718; 
 Thu, 21 Sep 2023 02:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWmfjgoq5vKLj4RywvmULLa91iZtxpjvElgwPt0f/+WqP0cNm4IOHYLQMqaUKq/fG0fBrmIQ==
X-Received: by 2002:a05:6512:a8b:b0:502:ff3b:7670 with SMTP id
 m11-20020a0565120a8b00b00502ff3b7670mr5755797lfu.4.1695287467295; 
 Thu, 21 Sep 2023 02:11:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 t10-20020adff60a000000b003143c9beeaesm1187087wrp.44.2023.09.21.02.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 02:11:06 -0700 (PDT)
Message-ID: <103096a6-f4b5-d88a-2aac-07dcc86825d6@redhat.com>
Date: Thu, 21 Sep 2023 11:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 00/21] QEMU gmem implemention
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 isaku.yamahata@gmail.com, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
 <ZQOu+OE8LWtLTyno@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQOu+OE8LWtLTyno@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

>>> 2. hugepage support.
>>>
>>>      KVM gmem can be allocated from hugetlbfs. How does QEMU determine
> 
> Not yet it can't.  gmem only supports THP, hugetlbfs is a future thing, if it's
> ever supported.  I wouldn't be at all surprised if we end up going down a slightly
> different route and don't use hugetlbfs directly.

Agreed. Certainly future work.

> 
>>>      when to allocate KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE. The
>>>      easiest solution is create KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
>>>      only when memory backend is HostMemoryBackendFile of hugetlbfs.
>>
>> Good question.
>>
>> Probably "if the memory backend uses huge pages, also use huge pages for the
>> private gmem" makes sense.
>>
>> ... but it becomes a mess with preallocation ... which is what people should
>> actually be using with hugetlb. Andeventual double memory-consumption ...
>> but maybe that's all been taken care of already?
>>
>> Probably it's best to leave hugetlb support as future work and start with
>> something minimal.
>>
>>>
>>> 3. What is KVM_X86_SW_PROTECTED_VM going to look like? and do we need it?
>>>
>>
>> Why implement it when you have to ask others for a motivation? ;)
>>
>> Personally, I'm not sure if it is really useful, especially in this state.
> 
> Yeah, as of today, KVM_X86_SW_PROTECTED_VM is mainly a development vehicle,
> e.g. so that testing gmem doesn't require TDX/SNP hardware, debugging gmem guests
> isn't brutally painful, etc.
> 
> Longer term, I have aspirations of being able to back most VMs with gmem, but
> that's going to require quite a bit more work, e.g. gmem needs to be mappable
> (when hardware allows it) so that gmem doesn't all but require double mapping,
> KVM obviously needs to be able to read/write gmem, etc.
> 
> The value proposition is that having a guest-first memory type will allow KVM to
> optimize and harden gmem in ways that wouldn't be feasible for a more generic
> memory implementation.  E.g. memory isn't mapped into host userspace by default
> (makes it harder to accidentally corrupt the guest), the guest can have *larger*
> mappings than host userspace, guest memory can be served from a dedicated pool
> (similar-ish to hugetlb), the pool can be omitted from the direct map, etc.
>
Thanks for that information. Personally, I don't believe "to back most 
VMs with gmem", but that's a different discussion.

As a development vehicle to get TDX up and running it might be very 
valuable indeed. But it doesn't necessarily have to be merged in QEMU 
for that case -- especially in a semi-finished form.

-- 
Cheers,

David / dhildenb


