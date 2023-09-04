Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3779179E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd958-0007W3-If; Mon, 04 Sep 2023 08:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qd94T-00071Z-7K
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:52:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qd93h-0007dd-BP
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:52:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf092a16c9so10986945ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1693831908; x=1694436708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NgifOIEfe5qybip7R+A5p4SgKu8q0aPNQ5OhmuRD574=;
 b=LRRH82FUbydjAfuSc7f9fPovfI8wtV+/mXmFpNJeS+uEfDth3Wbix31l6OMqSKjw3/
 dGN91knsP4F+x/D4mh2lHmP+DjeutdYEEB/P1EC1p9X13/gLI1pSleoKGTjZOMYaR+WW
 Mj9aZbBPjfW/R7/x1JAKidyuuazDUPrQjHYBhKq0K6hlXXibvJmUzj19kj/YSX6N2+Yi
 YbFWoaaT42VMAsPjwAufhaQBlG8RsmpTZOjhnMl+m2T7PVWkU9zvqJ+NDuoMfAtIvf1l
 KmJeFzbcbKbPRL03WnKH7CxCD8zDsmXuTOwTZPfIE0dGvfuQlUEjI+J0idscNkiHJVar
 iSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831908; x=1694436708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NgifOIEfe5qybip7R+A5p4SgKu8q0aPNQ5OhmuRD574=;
 b=PLuhnWoWiQitWoewYUZXdJCusrKxAgEWD6j6Qt6+QjRB9bF6LJehn7IgG7S8o7sRve
 tP15eMGO/FIKhu/3H4CaiYS0BCrgG5ukjnUHANWwuc3+oJy4+tvnOZ+PeqgshYG+eYgu
 SxRgZjWFNrICsKG+hf/f3fS72idQHECcoAJPN78/poc9WuNhrDQXGt43ekZyGavMdJt1
 vqC6x5p+/uB1UZe8uQ5dVGvBDwEVYQR8bSjgdatUTeJPQkmcqdQwDvJcSDqRNh09cG3w
 d1sKs8rpncI6wxtvmism541CnTJ6ovgnw1RZ+5dW/FxVnRkwUXzxwGDSOXezZroHZ6sx
 ebHw==
X-Gm-Message-State: AOJu0YyZoYTbZfkof/eP9sTpL6Era416jO/XDrw9VhN4QZIcnPuQl04O
 93jjzMG23F/Dlkp70+Hc5jDU35nS4ukwhwFOdAw=
X-Google-Smtp-Source: AGHT+IGhTVukzW80QjgXGbtm+jqoVlHfCyd/gFessby50KHnfZ1M38iz5do2IHrgalIR1ch8Wk5YGA==
X-Received: by 2002:a17:903:1d2:b0:1bd:fbc8:299e with SMTP id
 e18-20020a17090301d200b001bdfbc8299emr12875992plh.4.1693831908171; 
 Mon, 04 Sep 2023 05:51:48 -0700 (PDT)
Received: from [10.84.152.215] ([203.208.167.147])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a170902f7cb00b001b9e9f191f2sm7559096plw.15.2023.09.04.05.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 05:51:47 -0700 (PDT)
Message-ID: <499fe9b1-54f5-4d0f-ae2b-165cb0f3e6b3@bytedance.com>
Date: Mon, 4 Sep 2023 20:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2,1/1] memory: avoid updating ioeventfds for some
 address_space
Content-Language: en-US
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: david@redhat.com, philmd@linaro.org, peterx@redhat.com
References: <20230830032906.12488-1-hongmianquan@bytedance.com>
From: hongmainquan <hongmianquan@bytedance.com>
In-Reply-To: <20230830032906.12488-1-hongmianquan@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Friendly ping...
Hello, this patch has already received a R-b from PeterXu. Could you 
please help me review it as well and see if there are any issues? If 
everything is fine, could you please consider merging it? Thank you!

在 2023/8/30 11:29 上午, hongmianquan 写道:
> When updating ioeventfds, we need to iterate all address spaces,
> but some address spaces do not register eventfd_add|del call when
> memory_listener_register() and they do nothing when updating ioeventfds.
> So we can skip these AS in address_space_update_ioeventfds().
> 
> The overhead of memory_region_transaction_commit() can be significantly
> reduced. For example, a VM with 8 vhost net devices and each one has
> 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
> 
> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> -nothing has changed, just pick PeterXu's review.
> ---
>   include/exec/memory.h |  1 +
>   softmmu/memory.c      | 12 ++++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 7f5c11a0cc..556f4f1871 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1089,6 +1089,7 @@ struct AddressSpace {
>       struct FlatView *current_map;
>   
>       int ioeventfd_nb;
> +    int ioeventfd_notifiers;
>       struct MemoryRegionIoeventfd *ioeventfds;
>       QTAILQ_HEAD(, MemoryListener) listeners;
>       QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 7d9494ce70..178816c845 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -842,6 +842,10 @@ static void address_space_update_ioeventfds(AddressSpace *as)
>       AddrRange tmp;
>       unsigned i;
>   
> +    if (!as->ioeventfd_notifiers) {
> +        return;
> +    }
> +
>       /*
>        * It is likely that the number of ioeventfds hasn't changed much, so use
>        * the previous size as the starting value, with some headroom to avoid
> @@ -3075,6 +3079,10 @@ void memory_listener_register(MemoryListener *listener, AddressSpace *as)
>       }
>   
>       listener_add_address_space(listener, as);
> +
> +    if (listener->eventfd_add || listener->eventfd_del) {
> +        as->ioeventfd_notifiers++;
> +    }
>   }
>   
>   void memory_listener_unregister(MemoryListener *listener)
> @@ -3083,6 +3091,10 @@ void memory_listener_unregister(MemoryListener *listener)
>           return;
>       }
>   
> +    if (listener->eventfd_add || listener->eventfd_del) {
> +        listener->address_space->ioeventfd_notifiers--;
> +    }
> +
>       listener_del_address_space(listener, listener->address_space);
>       QTAILQ_REMOVE(&memory_listeners, listener, link);
>       QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);

