Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E9670E2BC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VoN-0001MG-T8; Tue, 23 May 2023 13:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1VoD-0001LB-6l
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1VoB-0006jf-1n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684862900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq75jWkYFMuZQ29brWOzRCscg+6BjW9+/kf9NoRxE0g=;
 b=Et7LeWQH2w+ieHOxFPULl6o5RuZz2uWw+iaWe7TdmSPtMm2MlNtHuB2MqQk7CAY7zHIjXn
 UdeLOn4FyLp6Dn+id+yX+btuTPmrUcOk8x3RM8RVTQ87/Haeo8PJh1ybygbKd7/OWFDpHb
 OVxIMh7qWkqtmAqqsa2NWFmBT6FjbnA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Jderh6oWMDeSx90PW_6ydg-1; Tue, 23 May 2023 13:28:16 -0400
X-MC-Unique: Jderh6oWMDeSx90PW_6ydg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f611d31577so146635e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684862895; x=1687454895;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vq75jWkYFMuZQ29brWOzRCscg+6BjW9+/kf9NoRxE0g=;
 b=iHhMzidAGuY1WQrvbdwP15ldE3BbT3WecpP3m92/ERO3SjTmiRf0ED8UzJyNZowAiW
 HYPaaS4B9YimRlAA5fYe69MGKY+07ZyrWxgIG7naKnw31w99nnZ/IlQCGI+QzS+t6Oll
 02/LzrUYjQKDKE7r1cp28bmUk4a7bvg1WSWIlIY0Tuxp322Jld/ZTu9De9UV0LCFZt1g
 U+h4yAiwTYNO9QrgghmH2vMscin86Qa/BfTAL9ITPKRVtaLHki1mKlHMLDRKHmh+1PZA
 MoZ94+MbSp+UToJVqPcny3GIUlnKPc2cQ7r4r26OS0AUYjiRf9NdSpThgZgWazDdPqo9
 nr+w==
X-Gm-Message-State: AC+VfDxBxcjTOet3E8sX4p8ln2fxnPAwmXLyAtcqsvS6g8cJnUh6pSN9
 SwhwsO9ZSklBqPCHzQDmUvHapbKJiKFsqhiNp7hn4+ct3iFrc12xnQfMk/77xVx/bZ0EfBvaNRH
 0NDUx36USVFvxTrs=
X-Received: by 2002:a5d:6a04:0:b0:30a:8a64:ad0c with SMTP id
 m4-20020a5d6a04000000b0030a8a64ad0cmr5922969wru.20.1684862895216; 
 Tue, 23 May 2023 10:28:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TtHIf8uNC/fuHUxwgx6h2WUkWCeCFjGU0nQlI/w60nIqGd1UeOcskaDbzV6qr2o+kONZJFw==
X-Received: by 2002:a5d:6a04:0:b0:30a:8a64:ad0c with SMTP id
 m4-20020a5d6a04000000b0030a8a64ad0cmr5922957wru.20.1684862894822; 
 Tue, 23 May 2023 10:28:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd?
 (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de.
 [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a7bce83000000b003f4fb5532a1sm12464337wmj.43.2023.05.23.10.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:28:14 -0700 (PDT)
Message-ID: <0b3cfc1c-007a-5671-9db5-c8c729bc1046@redhat.com>
Date: Tue, 23 May 2023 19:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/11] hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-7-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230523163600.83391-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23.05.23 18:35, Philippe Mathieu-Daudé wrote:
> Avoid accessing RAMBlock internals, use the provided
> qemu_ram_get_fd() getter to get the file descriptor.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 538b695c29..74e63bd47a 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -135,7 +135,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
>        * anonymous RAM. In any other case, reading unplugged *can* populate a
>        * fresh page, consuming actual memory.
>        */
> -    return !qemu_ram_is_shared(rb) && rb->fd < 0 &&
> +    return !qemu_ram_is_shared(rb) && qemu_ram_get_fd(rb) < 0 &&
>              qemu_ram_pagesize(rb) == qemu_real_host_page_size();
>   }
>   #endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


