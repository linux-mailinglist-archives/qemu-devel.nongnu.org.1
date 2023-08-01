Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4300876BB20
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQt4E-0002lR-GC; Tue, 01 Aug 2023 13:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQt4A-0002lB-QK
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQt48-0003fg-8D
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690910493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROo/Ae0SLVWvc31NlQ3/7ySJDiQ2R4inbuWZXREp8R4=;
 b=LENlKo14YJJTS+6RYXRGGlGx6xFCQmXrVqjKykBSv/vVRieK8wEKHcm7LMUTiUsVATOYOL
 vFG/PlHn+++4pDVd/BWim54yqK+1AcLcZxCeWLR+V6Bf12VTtiKvQ01CfoCSITellJuEFz
 KdVGxLNmxk0+XtUOeQcQAvW2iIxwEeI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-HrlL0K6oMqCW3oUJ5quozg-1; Tue, 01 Aug 2023 13:21:29 -0400
X-MC-Unique: HrlL0K6oMqCW3oUJ5quozg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso3648758f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 10:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690910488; x=1691515288;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ROo/Ae0SLVWvc31NlQ3/7ySJDiQ2R4inbuWZXREp8R4=;
 b=B3hQDy42jZFexVXdTDBNPySwLvNkrVcWWzp3H8R8Df18dfkzaXmkda/heOpzJDpQNv
 l6fsNLH0sffDmFv1T7nV4j7xH9EZ+r7A5VOaIBJJk+KsfuWqJB7r7MpT4p48RGpZgrI5
 woHqvU7CGe4xGU6v9wA+I+jlEGssXcolxEPnjWRgBATPmaUpo6ytdS+x7L8GJi3fk+70
 mnqXiXWhSWAQzgpu617aoFDms1CPEkytb1EDDQtqg2wh11FgnF+MTH9eGVyyF6/u85+Q
 GxwL4vOdKkNF9K8v2XbWEp5kRFnUhE/tRXN5UVhTqB0haMUShGHqU6BemBzEtjyzs72Z
 POLg==
X-Gm-Message-State: ABy/qLaElwkY/dxEkFMJQDOnZqbET1A0xCmJ/qTsv4nD5QSr4Vz5pHx6
 ZS8WKDMAvLuli/WlZAB8RK23lOMu/h6Jr+p/YMXk/V2Gt4iuwDIVTmIc4C8wId/FZkCvYDggmJR
 D1pDGU5psS6xVjCE=
X-Received: by 2002:adf:ce8a:0:b0:317:5c18:f31d with SMTP id
 r10-20020adfce8a000000b003175c18f31dmr2742478wrn.35.1690910488350; 
 Tue, 01 Aug 2023 10:21:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHA/lZAv6MlzSEtAu652lxjKogfAOHacftQnt8E9vLvWLgVkO5LUHNn2DntUItyYxZZiKjDow==
X-Received: by 2002:adf:ce8a:0:b0:317:5c18:f31d with SMTP id
 r10-20020adfce8a000000b003175c18f31dmr2742452wrn.35.1690910487918; 
 Tue, 01 Aug 2023 10:21:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247?
 (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de.
 [2003:cb:c705:d100:871b:ec55:67d:5247])
 by smtp.gmail.com with ESMTPSA id
 x7-20020adff647000000b00317731a6e07sm16638322wrp.62.2023.08.01.10.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 10:21:27 -0700 (PDT)
Message-ID: <f8e40f1a-729b-f520-299a-4132e371be61@redhat.com>
Date: Tue, 1 Aug 2023 19:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
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
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230731162201.271114-9-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 31.07.23 18:21, Xiaoyao Li wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   backends/hostmem.c       | 18 ++++++++++++++++++
>   include/sysemu/hostmem.h |  2 +-
>   qapi/qom.json            |  4 ++++
>   3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 747e7838c031..dbdbb0aafd45 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -461,6 +461,20 @@ static void host_memory_backend_set_reserve(Object *o, bool value, Error **errp)
>       }
>       backend->reserve = value;
>   }
> +
> +static bool host_memory_backend_get_private(Object *o, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> +
> +    return backend->private;
> +}
> +
> +static void host_memory_backend_set_private(Object *o, bool value, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> +
> +    backend->private = value;
> +}
>   #endif /* CONFIG_LINUX */
>   
>   static bool
> @@ -541,6 +555,10 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
>           host_memory_backend_get_reserve, host_memory_backend_set_reserve);
>       object_class_property_set_description(oc, "reserve",
>           "Reserve swap space (or huge pages) if applicable");
> +    object_class_property_add_bool(oc, "private",
> +        host_memory_backend_get_private, host_memory_backend_set_private);
> +    object_class_property_set_description(oc, "private",
> +        "Use KVM gmem private memory");
>   #endif /* CONFIG_LINUX */
>       /*
>        * Do not delete/rename option. This option must be considered stable
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 39326f1d4f9c..d88970395618 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -65,7 +65,7 @@ struct HostMemoryBackend {
>       /* protected */
>       uint64_t size;
>       bool merge, dump, use_canonical_path;
> -    bool prealloc, is_mapped, share, reserve;
> +    bool prealloc, is_mapped, share, reserve, private;
>       uint32_t prealloc_threads;
>       ThreadContext *prealloc_context;
>       DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 7f92ea43e8e1..e0b2044e3d20 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -605,6 +605,9 @@
>   # @reserve: if true, reserve swap space (or huge pages) if applicable
>   #     (default: true) (since 6.1)
>   #
> +# @private: if true, use KVM gmem private memory
> +#           (default: false) (since 8.1)
> +#

But that's not what any of this does.

This patch only adds a property and doesn't even explain what it intends 
to achieve with that.

How will it be used from a user? What will it affect internally? What 
will it modify in regards of the memory backend?

That all should go into the surprisingly empty patch description.

-- 
Cheers,

David / dhildenb


