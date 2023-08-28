Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06978A3A0
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 02:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaPlM-0006Cr-IQ; Sun, 27 Aug 2023 20:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qaPl0-0006AC-0h
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 20:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qaPku-00016Q-P8
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 20:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693181119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibbxsoxCKoBvkUXcOjeA5GRQGxS837QbGPrgrI0q1/A=;
 b=FL4b0DLtE70anpbRysyKTTj+LSfdVgE8JYgPPO0pZICQuxzsAcrzVxn6MOb/amc/IObHlM
 Kq/oMOmwQ46qtV59fjHJc9nJx1RNIerhKxiZrDtPqnhnSkD7nQvABhjhdAHBhzt8Izr7/V
 ot7zxsqQF2n3V8Jsobb+nU6x9TvxBbg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56--iAI571IPTOeUP-341SPCA-1; Sun, 27 Aug 2023 20:05:17 -0400
X-MC-Unique: -iAI571IPTOeUP-341SPCA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d72f3290e6eso3269351276.3
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 17:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693181116; x=1693785916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibbxsoxCKoBvkUXcOjeA5GRQGxS837QbGPrgrI0q1/A=;
 b=O1jLIBW6eDIKJQg7A2NODeXnnUMob6iAwvzNW7sAspSL3gIECz6TrOR6yHXmD362h0
 0Ien7g0VFST9DCBvaG32yh2H4QLlbylC+M0BKPXvC1eRqKDQywY7hD1sWgK8hEOWzIuU
 +mAItV0lWyBa5t9xpZBP3GOjfIjB4AfRo8TjtjQDN6rklKWjSt++EnX0fsJQ2de122Sj
 sIm8LvEM8H8aS81+NoIJZa22xdX7VgiBQbROZSeusuo1b6TFe1CvedZjAK4663pb+VGD
 ELhOrEefRbTR55kIwvsVL74VnXvRKL5eQZkZEctfADE4EYu9XnMtJjr478APoauqoEko
 M9rg==
X-Gm-Message-State: AOJu0YxR5gDw42YF8H2HZxT+VkM59OB01v9Ffjq/OjltsP4G2L/KweDf
 u5s9u5OpF12NMziy1IXNaV0aCCeLPTdg0VW41p2ohExk/9kWR4OLpOmLVZUXjfbJyxNhuqLAjNA
 hSXUVt9AzfMGQIzg=
X-Received: by 2002:a5b:c4d:0:b0:c6c:e4f4:2fb1 with SMTP id
 d13-20020a5b0c4d000000b00c6ce4f42fb1mr23159084ybr.3.1693181116680; 
 Sun, 27 Aug 2023 17:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzTGnH/D9yks8HrxCxd1C2qlL/9q/iUYvVS74r5N4bfJiUroHlQVt3omDGJuT4KA1Dop6X2Q==
X-Received: by 2002:a5b:c4d:0:b0:c6c:e4f4:2fb1 with SMTP id
 d13-20020a5b0c4d000000b00c6ce4f42fb1mr23159074ybr.3.1693181116446; 
 Sun, 27 Aug 2023 17:05:16 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a63b14a000000b00566095dac12sm5920524pgp.19.2023.08.27.17.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 17:05:15 -0700 (PDT)
Message-ID: <4bd99ea8-46de-f66f-8e9e-aa981b26dc43@redhat.com>
Date: Mon, 28 Aug 2023 10:05:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] arm/kvm: Enable support for
 KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, ricarkol@google.com, kvm@vger.kernel.org,
 jonathan.cameron@huawei.com, linuxarm@huawei.com
References: <20230815092709.1290-1-shameerali.kolothum.thodi@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230815092709.1290-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.414, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


Hi Shameer,

On 8/15/23 19:27, Shameer Kolothum wrote:
> Now that we have Eager Page Split support added for ARM in the kernel,
> enable it in Qemu. This adds,
>   -eager-split-size to -accel sub-options to set the eager page split chunk size.
>   -enable KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE.
> 
> The chunk size specifies how many pages to break at a time, using a
> single allocation. Bigger the chunk size, more pages need to be
> allocated ahead of time.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> RFC v1: https://lore.kernel.org/qemu-devel/20230725150002.621-1-shameerali.kolothum.thodi@huawei.com/
>    -Updated qemu-options.hx with description
>    -Addressed review comments from Peter and Gavin(Thanks).
> ---
>   include/sysemu/kvm_int.h |  1 +
>   qemu-options.hx          | 14 +++++++++
>   target/arm/kvm.c         | 62 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 77 insertions(+)
> 

[...]

>   
> +static void kvm_arch_get_eager_split_size(Object *obj, Visitor *v,
> +                                          const char *name, void *opaque,
> +                                          Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +    uint64_t value = s->kvm_eager_split_size;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
> +                                          const char *name, void *opaque,
> +                                          Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +    uint64_t value;
> +
> +    if (s->fd != -1) {
> +        error_setg(errp, "Cannot set properties after the accelerator has been initialized");
> +        return;
> +    }
> +

Errors spotted by './scripts/checkpatch.pl', as below:

ERROR: line over 90 characters
#139: FILE: target/arm/kvm.c:1112:
+        error_setg(errp, "Cannot set properties after the accelerator has been initialized");

Thanks,
Gavin


