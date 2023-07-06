Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4F9749736
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHK9b-0001Jl-D8; Thu, 06 Jul 2023 04:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHK9Z-0001Jb-1K
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHK9X-0007Ss-Eb
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688631350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MY8gRYeifrLY0yA5G77g1z5A7JTzvBqcj76bCNyOhFA=;
 b=dRxgg5RQt5MMdrBk0gik6/3OjxOCJ9AXO9iH5JJ4a7/+lAPgM2L76aj9qKRCQGS2DvRSHU
 N3Gdf52njvLGRAfzn3sLX1znzLjiYIZmvkFvJTbeWZzUBk4MmCHqZVYJR8eGCxDRNfjDnK
 YHwDSrUyynDbioRUvJf6SlqG0biOBK8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-OtJpcaiDOMWnAr5ERLqp8A-1; Thu, 06 Jul 2023 04:15:48 -0400
X-MC-Unique: OtJpcaiDOMWnAr5ERLqp8A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc7406cb5so433361e87.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631347; x=1691223347;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MY8gRYeifrLY0yA5G77g1z5A7JTzvBqcj76bCNyOhFA=;
 b=GxVIdJP5XtPAv7UmYb3MN1iTMwEcTfP+zhYFR3cqMfyU1L8vdTutSpRsY1CLndbKC2
 uHAbIgc4QCu54F04W0mwzP8SYIfZdTeyI8QKGb0bWulq4o5Shr7IVphFv1uVU7y2Rrwy
 LXoNuezNnveH0Dbmqu0U5Cl0Xw02ORqmcmSCYlwtER+iwwx2pEpi2PsyXvO/jbNlmZsK
 rdRddp/84ywBqlRtYz8BtI0Q5KM2tZhEOhXP9oh+cpubadv+qFXReK98cJalO2YguHlT
 MS8VEcQ9mJKOcBfMJlk5QCtQxPDRWb0PQLIC1WvTGpCaLt5JTBBssMU5s0aPAdi8M7zG
 DuVg==
X-Gm-Message-State: ABy/qLZwZhE2Wqzr9YLxcDOHUGx7ZnGN0odD7AiL00vtNmWdSpoC8y0k
 QN63R7joEkHAsHkhIiDHFtgEY0ooCufII0pp8ZoSlwurn8OOyBDn5O8RFNeSvPHJmVHT+F6UMAS
 if0xNuHBmojSkjG8=
X-Received: by 2002:a19:5f18:0:b0:4fb:95fe:58f6 with SMTP id
 t24-20020a195f18000000b004fb95fe58f6mr1304419lfb.6.1688631347157; 
 Thu, 06 Jul 2023 01:15:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEwI3H9G9KkYMZy1P4GuucLly/lS2Qu5PX5fst6H7oU+WxG7C2sVeAQ2wm8qhISRxrQlr7kHg==
X-Received: by 2002:a19:5f18:0:b0:4fb:95fe:58f6 with SMTP id
 t24-20020a195f18000000b004fb95fe58f6mr1304400lfb.6.1688631346754; 
 Thu, 06 Jul 2023 01:15:46 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 u5-20020a7bcb05000000b003fbcdba1a63sm1349490wmj.12.2023.07.06.01.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 01:15:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peng
 Tao <tao.peng@linux.alibaba.com>,  Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-mem: Skip most of virtio_mem_unplug_all()
 without plugged memory
In-Reply-To: <20230706075612.67404-3-david@redhat.com> (David Hildenbrand's
 message of "Thu, 6 Jul 2023 09:56:07 +0200")
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-3-david@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 10:15:45 +0200
Message-ID: <87fs61bglq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

David Hildenbrand <david@redhat.com> wrote:
> Already when starting QEMU we perform one system reset that ends up
> triggering virtio_mem_unplug_all() with no actual memory plugged yet.
> That, in turn will trigger ram_block_discard_range() and perform some
> other actions that are not required in that case.
>
> Let's optimize virtio_mem_unplug_all() for the case that no memory is
> plugged. This will be beneficial for x-ignore-shared support as well.
>
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

It works, so ...

Reviewed-by: Juan Quintela <quintela@redhat.com>

>      RAMBlock *rb = vmem->memdev->mr.ram_block;
>  
> -    if (virtio_mem_is_busy()) {
> -        return -EBUSY;
> -    }
> -
> -    if (ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb))) {
> -        return -EBUSY;
> -    }
> -    virtio_mem_notify_unplug_all(vmem);
> -
> -    bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
>      if (vmem->size) {
> +        if (virtio_mem_is_busy()) {
> +            return -EBUSY;

I see that the only way that virtio_men_is_busy() is true is if we are
in the middle of a migration.  In the case that vmem is 0, we don't
care.  So we are good.



> +        }
> +        if (ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb))) {
> +            return -EBUSY;
> +        }

Nothing to discard, so also good.

> +        virtio_mem_notify_unplug_all(vmem);

Nothing to notify, so also good.

> +        bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
>          vmem->size = 0;
>          notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
>      }
> +
>      trace_virtio_mem_unplugged_all();
>      virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
>      return 0;

Once that we are here.  Do you remember _why_ do we allow virtio-mem
plug/unplug in the middle of a migration.

We forbid to plug/unplug everything else.  Why do we need to plug/unplug
virtio-mem during migration?

Thanks, Juan.


