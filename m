Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5C7A92E8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:01:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFXS-000154-MW; Thu, 21 Sep 2023 04:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFXJ-0000zt-6m
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFXH-00068d-Dm
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695286784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwNdHTnGAsOSkRghTMU2fettnfW7luTA9H+gP/0MCjk=;
 b=XLW4FkeZ6lohQCFTDA0utpEbFJv2mg5zeHyJ8ZtPwVUC3AEReoMltbSUDYCdG33jj1ZtwA
 ckYV4j59SHY/UspEPE3vXTVUhoKGJuCbko/35IrIB1b3kvh6cwJMU4Qt6iPrKyYj9Co2Zp
 cTGofwIgk0ParcXi9tPFwnv8ZQZHCxo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-aQy-BZQhNXmen8HhvaDTog-1; Thu, 21 Sep 2023 04:59:42 -0400
X-MC-Unique: aQy-BZQhNXmen8HhvaDTog-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso469395f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695286781; x=1695891581;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwNdHTnGAsOSkRghTMU2fettnfW7luTA9H+gP/0MCjk=;
 b=GF8U6I2ruiWEV10wSCpI9XkUrZwSvNzjWuoIC+iytm8sajwrdtZei1gEQrcoyFkGBy
 roq1O9ez6RB9fh8eLO97/s4Fdno3CeTP9od5w33PXLrH1rpOOdmrwIHWvpJw5Jzsi6ah
 fGKl4SP/2d/fQtAlQWDe6JlJbvEkJuLbfbTMzJHnxeVZn3A9e9z9m0cdh1PLdZ00eXKE
 nt6SzRJ7gkNn0Dop7u5v+tTOYOy09PzE+7plI9ZYxAx6hbhl4KeCnm/0yd360qAYodq1
 3IH1Kg2tXWXhUOm4Y7UVTG/JXZUIklY8vJSQxCvbNX8zCoHBwLVpATObl0QFjaaSB5OD
 ZxDQ==
X-Gm-Message-State: AOJu0Yx8BDeDKKPGgP1d8rKQ55vwtZu+PCX/GYfaoCQsUXGbdd+wf1Sx
 Y4NmKp9aPw2v94g5c4uHLEnG5YI51E9N0TwgVrXUjIp0U4ygIdU/2bIwnjLxhpVW83oyVZyXnkU
 EXHFd0JMuFbCv0os=
X-Received: by 2002:adf:fe8e:0:b0:319:f9d6:a769 with SMTP id
 l14-20020adffe8e000000b00319f9d6a769mr4482684wrr.45.1695286780863; 
 Thu, 21 Sep 2023 01:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEziUe1J4+dVh5+sqL7Z79Q8p6L47JpR6xiZOAY7lmymJAZ32eWWEWvamD4E+nv0Lei4fu7pA==
X-Received: by 2002:adf:fe8e:0:b0:319:f9d6:a769 with SMTP id
 l14-20020adffe8e000000b00319f9d6a769mr4482661wrr.45.1695286780389; 
 Thu, 21 Sep 2023 01:59:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056000008c00b0031f3b04e7cdsm1143623wrx.109.2023.09.21.01.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:59:39 -0700 (PDT)
Message-ID: <822f80df-9bde-3d98-8fd2-44895cee08aa@redhat.com>
Date: Thu, 21 Sep 2023 10:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 00/21] QEMU gmem implemention
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
 <a8cf6824-4228-8de5-0727-96ea6c5bad36@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a8cf6824-4228-8de5-0727-96ea6c5bad36@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

>>>
>>> This version still leave some opens to be discussed:
>>> 1. whether we need "private" propery to be user-settable?
>>>
>>>      It seems unnecessary because vm-type is determined. If the VM is
>>>      confidential-guest, then the RAM of the guest must be able to be
>>>      mapped as private, i.e., have kvm gmem backend. So QEMU can
>>>      determine the value of "private" property automatiacally based on vm
>>>      type.
>>>
>>>      This also aligns with the board internal MemoryRegion that needs to
>>>      have kvm gmem backend, e.g., TDX requires OVMF to act as private
>>>      memory so bios memory region needs to have kvm gmem fd associated.
>>>      QEMU no doubt will do it internally automatically.
>>
>> Would it make sense to have some regions without "pivate" semantics?
>> Like NVDIMMs?
> 
> Of course it can have regions without "private" semantics.

I meant "RAM memory regions on such a special VM". Does it make sense to 
have !private there? I assume "for now, not".

>>>
>>> 2. hugepage support.
>>>
>>>      KVM gmem can be allocated from hugetlbfs. How does QEMU determine
>>>      when to allocate KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE. The
>>>      easiest solution is create KVM gmem with
>>> KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
>>>      only when memory backend is HostMemoryBackendFile of hugetlbfs.
>>
>> Good question.
>>
>> Probably "if the memory backend uses huge pages, also use huge pages for
>> the private gmem" makes sense.
>>
>> ... but it becomes a mess with preallocation ... which is what people
>> should actually be using with hugetlb. Andeventual double
>> memory-consumption ... but maybe that's all been taken care of already?
>>
>> Probably it's best to leave hugetlb support as future work and start
>> with something minimal.
>>
> 
> As Sean replied, I had some misunderstanding of
> KVM_GUEST_MEMFD_ALLOW_HUGEPAGE. If it's for THP, I think we can allow it
> for every gmem.

Right, just like we do a MADV_HUGEPAGE rather blindly on all memory.

-- 
Cheers,

David / dhildenb


