Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC07BDAAF
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpp1p-0006HW-L4; Mon, 09 Oct 2023 08:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpp1n-0006Cm-AM
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpp1l-0007PS-Mt
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696853184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RaBBDfKRsIGmx6/f95RNJjHmQcYKAWu4Z1/oOBkirIo=;
 b=CGX9lOntGhgDViOytW4baPidIpp1HcdKtXz9XADRvc2DCAGPYTILgjX8pY+WdlPI1YIE59
 lbYWQebYeFGgEO5z7ZAdSHfxPy/2NMB3kU5l4VWgTiio7AYvwrtyVEY9FDPQJngrzei6CG
 B9KD8RDn+rTfiYs1cX0jJmSsnNd9CGs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-p7JSoWSYPS-kBrGyTXOVaQ-1; Mon, 09 Oct 2023 08:06:23 -0400
X-MC-Unique: p7JSoWSYPS-kBrGyTXOVaQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32686c75f8fso3214815f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696853182; x=1697457982;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RaBBDfKRsIGmx6/f95RNJjHmQcYKAWu4Z1/oOBkirIo=;
 b=Yd4N25F9jWEXLEniK5ARTvo5wjjY92iE4sKwdl3THG3aTqJqgEdPgJkO3/HVXK3++Q
 22P2JekG9xc7wBB0SsH9GhwS7nVmRwbz/OWr/NaRK2nd98EvbpVzWUHAbeDBlxCX4uHg
 9ZR8gFIHsezg99x5W4iuqsezLI5UA7RhjxdUUNfrevDgswPp7hjEGPLZiDn8mSx84R3L
 qtFdLLlQEQnUM+2sXm/MzxdSroqpWFMvXxCWqjm94PaDO9SUG1zquToe/havhdCnz5W3
 jIy7rBfrJg/67ymYQ1Jr1vFESLuIw+krwmZj8wKEUkw5Kme2Ux4qH1WR0iT5MsMTDX16
 gXMQ==
X-Gm-Message-State: AOJu0YyB2Q3SkZGUQ6ikUS+0vCREnO/aIjRnzJPbehFVOLrMX8eHOs74
 +qtEB1lgZKbL0Cpth9C0BlZxLAJl8RDuYbOVDwz20G/8Z4T1ITaMWg5Mm4Pxk7fzdUjHVRwmJIg
 3AZOnoW6pKSuj5ZQ=
X-Received: by 2002:adf:e852:0:b0:315:9e1b:4ea6 with SMTP id
 d18-20020adfe852000000b003159e1b4ea6mr12931573wrn.58.1696853182032; 
 Mon, 09 Oct 2023 05:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbldICPehREYFZOhEmXusOZpkfbjnMa7Vk9hA3Kdz3FYraV/rvml5ntWkoT7ReFybJqXabfw==
X-Received: by 2002:adf:e852:0:b0:315:9e1b:4ea6 with SMTP id
 d18-20020adfe852000000b003159e1b4ea6mr12931519wrn.58.1696853180866; 
 Mon, 09 Oct 2023 05:06:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a5d6902000000b003250aec5e97sm9612447wru.4.2023.10.09.05.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:06:20 -0700 (PDT)
Message-ID: <c997692c-1b30-c336-067e-ca293a5ba970@redhat.com>
Date: Mon, 9 Oct 2023 14:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] memory: initialize 'fv' in MemoryRegionCache to make
 Coverity happy
Content-Language: en-US
To: Ilya Maximets <i.maximets@ovn.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20231009104322.3085887-1-i.maximets@ovn.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009104322.3085887-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 09.10.23 12:43, Ilya Maximets wrote:
> Coverity scan reports multiple false-positive "defects" for the
> following series of actions in virtio.c:
> 
>    MemoryRegionCache indirect_desc_cache;
>    address_space_cache_init_empty(&indirect_desc_cache);
>    address_space_cache_destroy(&indirect_desc_cache);
> 
> For some reason it's unable to recognize the dependency between 'mrs.mr'
> and 'fv' and insists that '!mrs.mr' check in address_space_cache_destroy
> may take a 'false' branch, even though it is explicitly initialized to
> NULL in the address_space_cache_init_empty():
> 
>    *** CID 1522371:  Memory - illegal accesses  (UNINIT)
>    /qemu/hw/virtio/virtio.c: 1627 in virtqueue_split_pop()
>    1621         }
>    1622
>    1623         vq->inuse++;
>    1624
>    1625         trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
>    1626     done:
>    >>>     CID 1522371:  Memory - illegal accesses  (UNINIT)
>    >>>     Using uninitialized value "indirect_desc_cache.fv" when
>    >>>     calling "address_space_cache_destroy".
>    1627         address_space_cache_destroy(&indirect_desc_cache);

Yeah, it doesn't even care about what that function actually does, just 
that it is called with a datastructure that is partially uninitialized.

>    1628
>    1629         return elem;
>    1630
>    1631     err_undo_map:
>    1632         virtqueue_undo_map_desc(out_num, in_num, iov);
> 
>    ** CID 1522370:  Memory - illegal accesses  (UNINIT)
> 
> Instead of trying to silence these false positive reports in 4
> different places, initializing 'fv' as well, as this doesn't result
> in any noticeable performance impact.
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>   include/exec/memory.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index c99842d2fc..1ce80c4e82 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2770,6 +2770,8 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
>   static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
>   {
>       cache->mrs.mr = NULL;
> +    /* There is no real need to initialize fv, but it makes Coverity happy. */
> +    cache->fv = NULL;
>   }
>   
>   /**

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


