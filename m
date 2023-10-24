Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB87D4738
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAet-0005il-IJ; Tue, 24 Oct 2023 02:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qvAeq-0005c2-Of
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qvAel-0000Fk-Pv
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698127966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xx7Cz1JqcH8VIMj5IeAEGDzYsV4t5FsY6FU3/OSDJQ0=;
 b=JEwHCor008MtVMR5UW4EujDLgdfQCzEWRMOBj2gKRARMCl3qRfCqyYbgW2tr+K0xujhDAl
 6jl0NMbD67Qd38ticB5xuv6a9GrjHGIZB376cZx+zIvEFWGykw/OCTvvUor0ISvxGK50JK
 WojfmTXaGmZxrL7EnsNfx0KmbG2c3cA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-v4a7IkJSP8uWOH2zl5D0oA-1; Tue, 24 Oct 2023 02:12:41 -0400
X-MC-Unique: v4a7IkJSP8uWOH2zl5D0oA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b08994e15so80097686d6.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 23:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698127961; x=1698732761;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xx7Cz1JqcH8VIMj5IeAEGDzYsV4t5FsY6FU3/OSDJQ0=;
 b=LZ3qYgVM0Fi7Ok4bkoTioCSP1ooKfmzQXQxDtARZS65srxCnoYnOXkHAlk4ri3jlzj
 Z4IQLB9RNkcOhQ1h1oAWrHGYQuNKkculNfWAXnf9eFUEiID/7PB+wdPCtvq+AXJVETlG
 YYIdSUy70Zcsc6KZ3jXX8iIqhx545dKjyuZchnN7sWy9Kz5JmJVYILclQXLvSWQzEt6f
 o7zZQBpmbto+MdwtHseGzLQNXKKK8wK2WwxMcIZdxPKO4qu5kLsy4BIXAH+n/dWcUOUX
 RT07cCV1r0CAAUD9SUsRFWP5HFfe3qeDgAWxtRhTJDjb09KNlK3ktUg61WaSGuxGeJbq
 xntg==
X-Gm-Message-State: AOJu0Yw07FnNouJdXW04NSROCAWAWhh1jy5SQiZZwLhhYKEan9rjGgVg
 SEcKuLVKtrhuBko4gAhlREkaMwKen19xhmFTc1oRHRel04M6tORoFJ/h3n101+1RX5jiUi60GOu
 Owcf8vrMyCyrLnmI=
X-Received: by 2002:ad4:5966:0:b0:66d:593f:9a4c with SMTP id
 eq6-20020ad45966000000b0066d593f9a4cmr17018855qvb.2.1698127961306; 
 Mon, 23 Oct 2023 23:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcXe9A27PPJ5goO+iTEPK7zysUkrLzqFmcbM3li2MhgscvUwaUMFLgZQZTCUlk7Rp6m3tpyw==
X-Received: by 2002:ad4:5966:0:b0:66d:593f:9a4c with SMTP id
 eq6-20020ad45966000000b0066d593f9a4cmr17018848qvb.2.1698127961079; 
 Mon, 23 Oct 2023 23:12:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 e20-20020ad442b4000000b0063c71b62239sm3431543qvr.42.2023.10.23.23.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 23:12:40 -0700 (PDT)
Message-ID: <98b77982-e8df-40b3-9ebc-b4762f3141af@redhat.com>
Date: Tue, 24 Oct 2023 08:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/s390x/kvm: Turn KVM_CAP_SYNC_REGS into a
 hard requirement
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>
References: <20231011080538.796999-1-thuth@redhat.com>
 <20231011080538.796999-2-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231011080538.796999-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/11/23 10:05, Thomas Huth wrote:
> Since we already require at least kernel 3.15 in the s390x KVM code,
> we can assume that the KVM_CAP_SYNC_REGS capability is always there.
> Thus turn this into a hard requirement now.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/s390x/kvm/kvm.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index bc5c56a305..b3e2eaa2eb 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -337,21 +337,29 @@ int kvm_arch_get_default_type(MachineState *ms)
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
> +    int required_caps[] = {
> +        KVM_CAP_DEVICE_CTRL,
> +        KVM_CAP_SYNC_REGS,
> +    };
> +
> +    for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
> +        if (!kvm_check_extension(s, required_caps[i])) {
> +            error_report("KVM is missing capability #%d - "
> +                         "please use kernel 3.15 or newer", required_caps[i]);
> +            return -1;
> +        }
> +    }
> +
>       object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
>                            false, NULL);
>   
> -    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
> -        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
> -                     "please use kernel 3.15 or newer");
> -        return -1;
> -    }
>       if (!kvm_check_extension(s, KVM_CAP_S390_COW)) {
>           error_report("KVM is missing capability KVM_CAP_S390_COW - "
>                        "unsupported environment");
>           return -1;
>       }
>   
> -    cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
> +    cap_sync_regs = true;
>       cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>       cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>       cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);


