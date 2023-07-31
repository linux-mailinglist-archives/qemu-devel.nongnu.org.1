Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563A768DF3
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:19:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNAg-0005wp-Eb; Mon, 31 Jul 2023 03:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQNAX-0005wB-QK
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQNAW-0006jH-49
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690787894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMk26EAq8L8ijc5ZaGiVV0fxfAolpQBv9JQamEGeqmc=;
 b=G0/GTRGWXSICsBKyLVWa/dKuQVztBvFauH42qX5PFy+vpQMD51yC21pMGECCnmnTXJEobc
 btOKooTwzLRlbPTG2vQeT3/eFM17zs9JJsSdfR/pPQoI0oQbOQCI3f9VPuevDJ7f2w3Ay9
 sNHQAziv7q/STwQXGysyaU0d1tdTbVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-tw1S6CvHOsy0vxqcPdvVhA-1; Mon, 31 Jul 2023 03:18:12 -0400
X-MC-Unique: tw1S6CvHOsy0vxqcPdvVhA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e6153f0eeso1992461f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690787891; x=1691392691;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sMk26EAq8L8ijc5ZaGiVV0fxfAolpQBv9JQamEGeqmc=;
 b=dT3EKIFJLlyMmrk6R/qrAKTvOzMc8nZlPH5GVb5V4YxuQaul9CNiISW0WDL6WYLear
 TMNTKD8L/58Qo19i8GMTzfl4zpkPe9ub1Md4RZKGzAZEjfGGRp6rvI+4bCOuhKi2LvFe
 vFjVLwWaF6p0ipZj61Xj6zVcNq+3u59wUvxeBPpVTikaOvTfLf4GjoIkIzJorJxl/Krx
 E/4j2O7fk5QCENjOSGH7f9+EOI+uYKOiV8FF67Ap3PobujTAyFIOjKOAGV8+gsqfP+pw
 XIC8zDidS+b3RJKeRJ3+Nll4HNBrMkOQs6aXlONCcCqJIHgsm5T9l/0keuqDvmYo6tLw
 rh5w==
X-Gm-Message-State: ABy/qLaR7i9FL7gbAmssK44UPakG7NH2Bm+StSaqMHnvAAJ/3JfAux1S
 sOKLrgiii37f6eW62cAIa5+hqJ+6ygz6YZOo6N6+62YMCIFMJA6iREDwT1yqWVYv+kyX+uzFSx/
 4e5n0nhqCFlCDft4=
X-Received: by 2002:a5d:6805:0:b0:315:83d4:7dd6 with SMTP id
 w5-20020a5d6805000000b0031583d47dd6mr6100455wru.5.1690787891016; 
 Mon, 31 Jul 2023 00:18:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGBr//7WrxXhTgUY1c3N/lFd9J/vDWViAmwcaSPrHkbojWwcX3SzE1pRxxkU7JYR1iybjWJqw==
X-Received: by 2002:a5d:6805:0:b0:315:83d4:7dd6 with SMTP id
 w5-20020a5d6805000000b0031583d47dd6mr6100439wru.5.1690787890648; 
 Mon, 31 Jul 2023 00:18:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3?
 (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de.
 [2003:cb:c723:4c00:5c85:5575:c321:cea3])
 by smtp.gmail.com with ESMTPSA id
 r6-20020adfce86000000b003179b3fd837sm4842452wrn.33.2023.07.31.00.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 00:18:10 -0700 (PDT)
Message-ID: <af597a7c-5580-ffc5-d435-dd7e0ccc63d2@redhat.com>
Date: Mon, 31 Jul 2023 09:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org, shan.gavin@gmail.com
References: <20230730234840.1989974-1-gshan@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] kvm: Fix crash by initializing kvm_state early
In-Reply-To: <20230730234840.1989974-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31.07.23 01:48, Gavin Shan wrote:
> Runs into core dump on arm64 and the backtrace extracted from the
> core dump is shown as below. It's caused by accessing @kvm_state which
> isn't initialized at that point due to commit 176d073029 ("hw/arm/virt:
> Use machine_memory_devices_init()"), where the machine's memory region
> is added ealier than before.

s/ealier/earlier/

> 
>      main
>      qemu_init
>      configure_accelerators
>      qemu_opts_foreach
>      do_configure_accelerator
>      accel_init_machine
>      kvm_init
>      virt_kvm_type
>      virt_set_memmap
>      machine_memory_devices_init
>      memory_region_add_subregion
>      memory_region_add_subregion_common
>      memory_region_update_container_subregions
>      memory_region_transaction_begin
>      qemu_flush_coalesced_mmio_buffer
>      kvm_flush_coalesced_mmio_buffer
> 
> Fix it by initializing @kvm_state early. With this applied, no crash
> is observed on arm64.

Interestingly, we register memory listeners in kvm_init() after setting 
kvm_state, so in theory it should have worked fine.

But it's rather surprising that we see kvm_flush_coalesced_mmio_buffer() 
call even though we didn't even setup a listener with 
kvm_coalesce_mmio_region / kvm_uncoalesce_mmio_region.

Such a notifier-specific flush might have been better placed in the 
MemoryListener->begin() call. But that needs more thought, as 
qemu_flush_coalesced_mmio_buffer() is called from a couple of places.
> 
> Fixes: 176d073029 ("hw/arm/virt: Use machine_memory_devices_init()")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 373d876c05..c825cba12f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2464,6 +2464,7 @@ static int kvm_init(MachineState *ms)
>       qemu_mutex_init(&kml_slots_lock);
>   
>       s = KVM_STATE(ms->accelerator);
> +    kvm_state = s;
>   
>       /*
>        * On systems where the kernel can support different base page
> @@ -2695,8 +2696,6 @@ static int kvm_init(MachineState *ms)
>   #endif
>       }
>   
> -    kvm_state = s;
> -
>       ret = kvm_arch_init(ms, s);
>       if (ret < 0) {
>           goto err;

As an alternative, we might simply do nothing in 
kvm_flush_coalesced_mmio_buffer(), in case kvm_state is not setup yet. 
We don't have any notifier registered in that case.

Thanks!

-- 
Cheers,

David / dhildenb


