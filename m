Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DB76CFD0
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 16:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCco-0003zQ-2N; Wed, 02 Aug 2023 10:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qRCcX-0003o5-35
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qRCcV-00005N-Ct
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690985674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pWRRzjhSSkGcC+rU+LOHToBtc9IeE5pNfkjeHK/DFY=;
 b=LXiHt5sex6G/QzHZkJfrPgVv1GI0u81GR2tCXLmz6R2wj4j8xPlSgcp2755oLSXbtKYTPl
 SUrnfcu7/LmZpCGqiCD0QArsdSRLi24pOCIlp9BkE4AyMPZG8JRCeB/dZEpAWA6zPXE3Jx
 pA9zPdhgEFTVCeP+sPDZm6iIgFU9p0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-m2lyB0yHP-iZzj-Sq4VnQA-1; Wed, 02 Aug 2023 10:14:33 -0400
X-MC-Unique: m2lyB0yHP-iZzj-Sq4VnQA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31775a8546fso4200641f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 07:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690985672; x=1691590472;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0pWRRzjhSSkGcC+rU+LOHToBtc9IeE5pNfkjeHK/DFY=;
 b=bLm6LUA/LKUB65iTIMZe3L4Jnylyld0HDa5DGjPEhaOulgzBYfn0mUonhzf/I7WQsN
 9+67f6RPRDew1uDvgLe/adjzoi5AIXeHfBjz7JWhi7r/jiRXUMjq357jb1tQEcja2Djj
 13NymFAjBZjx3Dp4OFWLRlFiW5JZSVgI1jL0dzTEft4sUv8n5PbyBsxkbBeQNPhbspAE
 MXCtGP7XsXoyCULBx/cnAogEtJN59tTC7D/Lnezn3gbTYGioq9W+OZNC1EDx3ZPS8ZoE
 hTsQtWHWkbWQCx5Mpr1Lvd8uRitJZMGej2MJFavOIFPxC3r5OlAWpFfOcOdixp92atzD
 HYYg==
X-Gm-Message-State: ABy/qLaWrj6/a+3qEj8EBVgFpx23R1SKFnJqPzJi+wcHE9BkTb4gxnMI
 jnVoSKjHw2br5PJuNYOFGmgJM4ZdMiMh8Z5BqWV5NQ8OIWZZC0t4KVLLkYmHBlQS1Z4TCnaf+1L
 xOZau3AQ6YNu7FhQ=
X-Received: by 2002:a5d:4572:0:b0:317:6639:852d with SMTP id
 a18-20020a5d4572000000b003176639852dmr5063720wrc.43.1690985672434; 
 Wed, 02 Aug 2023 07:14:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8UMI9LjEyKhH2GPvXA6mnI73VXxZyXz27zjP3IAExZ1GtjBfqs4WqPMc2T6ZInymIYZ8Uag==
X-Received: by 2002:a5d:4572:0:b0:317:6639:852d with SMTP id
 a18-20020a5d4572000000b003176639852dmr5063698wrc.43.1690985672008; 
 Wed, 02 Aug 2023 07:14:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf?
 (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de.
 [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a5d508a000000b0031773e3cf46sm19183969wrt.61.2023.08.02.07.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 07:14:31 -0700 (PDT)
Message-ID: <a154c33d-b24d-b713-0dc0-027d54f2340f@redhat.com>
Date: Wed, 2 Aug 2023 16:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Igor Mammedov
 <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-9-xiaoyao.li@intel.com>
 <f8e40f1a-729b-f520-299a-4132e371be61@redhat.com>
 <2addfff0-88bf-59aa-f2f3-8129366a006d@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
In-Reply-To: <2addfff0-88bf-59aa-f2f3-8129366a006d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 02.08.23 10:03, Xiaoyao Li wrote:
> On 8/2/2023 1:21 AM, David Hildenbrand wrote:
>> On 31.07.23 18:21, Xiaoyao Li wrote:
>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>
>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>    backends/hostmem.c       | 18 ++++++++++++++++++
>>>    include/sysemu/hostmem.h |  2 +-
>>>    qapi/qom.json            |  4 ++++
>>>    3 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>>> index 747e7838c031..dbdbb0aafd45 100644
>>> --- a/backends/hostmem.c
>>> +++ b/backends/hostmem.c
>>> @@ -461,6 +461,20 @@ static void
>>> host_memory_backend_set_reserve(Object *o, bool value, Error **errp)
>>>        }
>>>        backend->reserve = value;
>>>    }
>>> +
>>> +static bool host_memory_backend_get_private(Object *o, Error **errp)
>>> +{
>>> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
>>> +
>>> +    return backend->private;
>>> +}
>>> +
>>> +static void host_memory_backend_set_private(Object *o, bool value,
>>> Error **errp)
>>> +{
>>> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
>>> +
>>> +    backend->private = value;
>>> +}
>>>    #endif /* CONFIG_LINUX */
>>>    static bool
>>> @@ -541,6 +555,10 @@ host_memory_backend_class_init(ObjectClass *oc,
>>> void *data)
>>>            host_memory_backend_get_reserve,
>>> host_memory_backend_set_reserve);
>>>        object_class_property_set_description(oc, "reserve",
>>>            "Reserve swap space (or huge pages) if applicable");
>>> +    object_class_property_add_bool(oc, "private",
>>> +        host_memory_backend_get_private,
>>> host_memory_backend_set_private);
>>> +    object_class_property_set_description(oc, "private",
>>> +        "Use KVM gmem private memory");
>>>    #endif /* CONFIG_LINUX */
>>>        /*
>>>         * Do not delete/rename option. This option must be considered
>>> stable
>>> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
>>> index 39326f1d4f9c..d88970395618 100644
>>> --- a/include/sysemu/hostmem.h
>>> +++ b/include/sysemu/hostmem.h
>>> @@ -65,7 +65,7 @@ struct HostMemoryBackend {
>>>        /* protected */
>>>        uint64_t size;
>>>        bool merge, dump, use_canonical_path;
>>> -    bool prealloc, is_mapped, share, reserve;
>>> +    bool prealloc, is_mapped, share, reserve, private;
>>>        uint32_t prealloc_threads;
>>>        ThreadContext *prealloc_context;
>>>        DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 7f92ea43e8e1..e0b2044e3d20 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -605,6 +605,9 @@
>>>    # @reserve: if true, reserve swap space (or huge pages) if applicable
>>>    #     (default: true) (since 6.1)
>>>    #
>>> +# @private: if true, use KVM gmem private memory
>>> +#           (default: false) (since 8.1)
>>> +#
>>
>> But that's not what any of this does.
>>
>> This patch only adds a property and doesn't even explain what it intends
>> to achieve with that.
>>
>> How will it be used from a user? What will it affect internally? What
>> will it modify in regards of the memory backend?
> 
> How it will be used is in the next patch, patch 09.
> 
> for kvm_x86_sw_protected_vm type VM, it will allocate private gmem with
> KVM ioctl if the memory backend has property "private" on.

It feels wired up the wrong way.

When creating/initializing the memory backend, we should also take care 
of allocating the gmem_fd, for example, by doing some gmem allocation 
callback, ideally *internally* creating the RAM memory region / RAMBlock.

And we should fail if that is impossible (gmem does not apply to the VM) 
or creating the gmem_fd failed for other reason.

Like passing a RAM_GMEM flag to memory_region_init_ram_flags_nomigrate() 
in ram_backend_memory_alloc(), to then handle it internally, failing if 
there is an error.

-- 
Cheers,

David / dhildenb


