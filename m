Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B75007179B7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GxM-0006CO-CB; Wed, 31 May 2023 04:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4Gwd-0005v9-VW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4Gwb-0007Rx-U0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685520750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcqEViUKmHmOKxMS86MOL4sIVQTy2Wj6IB/b/yM089I=;
 b=D3yuHlhAm3C/FChGxsVR7QShLJHKfsodV7QVAFAt6YV9JSz1yQEX/NRBf+LlaARaPBNPYM
 df688GAKd7oEoPTXJgg6LENlGcuvrLtMudma7sq5JaqqRdz1aMeDYO87TkAjIFdBXrDJl1
 fatgspbdSwpv7j1S2DJABxW41xfLC60=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-p1LN1GUtP3C3jUDCY0sVWA-1; Wed, 31 May 2023 04:12:29 -0400
X-MC-Unique: p1LN1GUtP3C3jUDCY0sVWA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5fffb828eso2721315e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 01:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685520748; x=1688112748;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XcqEViUKmHmOKxMS86MOL4sIVQTy2Wj6IB/b/yM089I=;
 b=B9qCO9M00Uw3XhiXK9uiGW5tx8Nryzizy0U23ND/m6zwSByK9l9QHUb1mzbXWAD0yp
 UKuMEcVgH3Po6dHpW1qP1Yrc1vC00swIzXCdvHl+ra1ip0oHzxx2fmfFC21pvwQnM9+j
 5MvuXC3Q5rrZoircPokSHwb1YQ637Soo3YiHnpPEUlq9kcK58CxQhXYbYFEjXoW96HbS
 7toaH+n3nDs9I1AV+jgdYCXrYlAvnou7qRIaOWaWJG6kNe3gLpF8DFPpg6KdoH2H5SZS
 1C9zTCM58TEZ5YJYJn5WkjDYdkwx/RR9gV1oyv+xAGuQLMMyiVLOxbyeJ06ywL7dkTkH
 usuA==
X-Gm-Message-State: AC+VfDx3UJIcoFJ7J/1EgNwMEdczGey+x7H6WOYBaPKdt1GtoFRPeO+8
 b7169ieSlU59v6xWY3oZWsOpdf+sNjgbR8Pvt94eB2LRWAlDcNtF5A3850iHNlhhA7YnKB/M7Mt
 kc5WvogDFP9rxhvw=
X-Received: by 2002:a1c:6a0a:0:b0:3f6:3486:1391 with SMTP id
 f10-20020a1c6a0a000000b003f634861391mr3747684wmc.13.1685520748377; 
 Wed, 31 May 2023 01:12:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xj/HBCjVekc2v7X8tVl7pEs2q3ISWig5az0nlsJG/ZBlrw4sInb9/yI5qYpprXTduC9M3PA==
X-Received: by 2002:a1c:6a0a:0:b0:3f6:3486:1391 with SMTP id
 f10-20020a1c6a0a000000b003f634861391mr3747660wmc.13.1685520748008; 
 Wed, 31 May 2023 01:12:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26?
 (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de.
 [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a7bc405000000b003f31cb7a203sm19805384wmi.14.2023.05.31.01.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 01:12:27 -0700 (PDT)
Message-ID: <ada6956d-028f-2c62-d3f9-3d6b2ae3c42e@redhat.com>
Date: Wed, 31 May 2023 10:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "T.J. Alumbaugh" <talumbau@google.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yuanchu Xie <yuanchu@google.com>,
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
References: <20230525222016.35333-1-talumbau@google.com>
 <20230525222016.35333-2-talumbau@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 1/5] virtio-balloon: Add Working Set Reporting
 feature
In-Reply-To: <20230525222016.35333-2-talumbau@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26.05.23 00:20, T.J. Alumbaugh wrote:

Hi,

please try writing a comprehensive patch description: the goal should be 
that one can understand what's happening in the single patch without all 
of the following patches at hand. [ that's how I am reading them, and 
ahve to ask many stupid questions :P ]

> Balloon header includes:
>   - feature bit for Working Set Reporting
>   - number of Working Set bins member in balloon config
>   - types for communicating Working Set information
> 

Can you briefly summarize how all the bits here interact?

I assume, once VIRTIO_BALLOON_F_WS_REPORTING has been negotiated

(1) There is a new virtqueue for sending WS-related requests from the
     device (host) to the driver (guest).

-> How does a request look like?
-> How does a response look like?
-> Error cases?

(2) There is a new config space option.

-> Who's supposed to read this, who's supposed to write it?
-> Can it be changed dynamically?
-> What's the meaning / implication of that value.

> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>   .../standard-headers/linux/virtio_balloon.h   | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> index f343bfefd8..df61eaceee 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>   #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>   #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>   #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING	6 /* Working set report virtqueues */

... are there multiple virtqueues? How many?

>   
>   /* Size of a PFN in the balloon interface. */
>   #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -59,6 +60,9 @@ struct virtio_balloon_config {
>   	};
>   	/* Stores PAGE_POISON if page poisoning is in use */
>   	uint32_t poison_val;
> +	/* Stores the number of histogram bins if WS reporting in use */
> +	uint8_t working_set_num_bins;
> +	uint8_t padding[3];
>   };
>   
>   #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -116,4 +120,20 @@ struct virtio_balloon_stat {
>   	__virtio64 val;
>   } QEMU_PACKED;
>   
> +enum virtio_balloon_working_set_op {
> +    VIRTIO_BALLOON_WS_REQUEST = 1, /* a Working Set request from the host */
> +    VIRTIO_BALLOON_WS_CONFIG = 2,  /* a Working Set config from the host */
> +};
> +
> +struct virtio_balloon_working_set {
> +	/* A tag for additional metadata */
> +	__virtio16 tag;
> +	/* The NUMA node for this report. */
> +	__virtio16 node_id;

How will we handle the case when the guest decides to use a different 
NUMA layout (e.g., numa disabled, fake numa, ...).

Is the guest supposed to detect that and *not* indicate a NUMA ID then?


Also, I wonder

> +	uint8_t reserved[4];
> +	__virtio64 idle_age_ms;
> +	/* A bin each for anonymous and file-backed memory. */

Why not have them separately, and properly named?

I'm not sure if it's a good idea to distinguish them based on anon vs. 
file-backed.

What would you do with shmem? It can be swapped like anon memory, ... if 
swap is enabled.

What's the main motivation for splitting this up? Is the "file-backed" 
part supposed to give some idea about the pagecache size? But what about 
mlock or page pinning?


Now I should take a step back and read the cover letter :)

-- 
Thanks,

David / dhildenb


