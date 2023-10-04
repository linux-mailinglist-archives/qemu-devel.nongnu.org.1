Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E3E7B8657
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5X1-0005c3-HR; Wed, 04 Oct 2023 13:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qo5Wz-0005bi-BY
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qo5Wx-0004Fb-M2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696439966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rXwgxWXkvpXv7famprq8S8SkXNUrJM4jCzOz0eJKgY=;
 b=e7HFhbp/NR+43z+kYV62i27gGdIonWZL+VXdCLVO+FSy3i1s2TQVMij3gdlOc6pjbeAPss
 shz7Re+n4LDR8dsKR+YrNh/+XlZ4+p5//yQvdzlo+BgVpptFiwpnMmKNc078BzNSzfIu0y
 EvD18gDeyy1Qh4sr1dTvfE7tPIcLeoI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-dVQGsBtcM-2E_zp87vMtTQ-1; Wed, 04 Oct 2023 13:19:20 -0400
X-MC-Unique: dVQGsBtcM-2E_zp87vMtTQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7742bab9c0cso3215785a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439960; x=1697044760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6rXwgxWXkvpXv7famprq8S8SkXNUrJM4jCzOz0eJKgY=;
 b=NvqEgw09V7LPQ1qfjvfFRt6SOAzcbj4bvl7V7BDQAgYGQmmtbc+Ye4R23fF4RZu6bY
 56QI/h0CTLaHzgYBqrqGjGeRPGA+qjjnXiASTIFkrZTL0Rz/PEuLbf6qKAZIKxFdU892
 XLp8/gT4KZENh6Y9amptLRtJOGW+83llacC3NKLphE4XYqt2scutiEAk9DFA3TPDnxgU
 ZP7vm0fEaGiHO/hFnBvXWuJZji5MqzghAIZxzF6FewZ6e8yyAlbCymkQffIwCToCpg+i
 W6ZnCbHhJUUeNdLOt0ldWPGRA5+Sb1Xei1skjVZJbpLPEW8mAnsn9KhxZIYwsEfoUUTL
 iu6g==
X-Gm-Message-State: AOJu0YzIOnye86jUdrtgclMFb9a8SMEvQwdEI2Q4QbXNQx7zh+bTkYd/
 zvqdDJlrQc9WwmNNNECqjFiX0wtP7WTXi/keVfnbeDTsC5r7VePByBDbLGS27Y4fHzv0rnzOt+B
 y1GfKDWNwNQ7dsFg=
X-Received: by 2002:a05:620a:45a7:b0:774:1875:edb1 with SMTP id
 bp39-20020a05620a45a700b007741875edb1mr3627069qkb.20.1696439959809; 
 Wed, 04 Oct 2023 10:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHrJdbaoG+NVv7AY8Ue6dd/7Yj3pGaViwfuAF/59ON82SxpCmMZ4gnq465ty1jlUS1HbgOQ==
X-Received: by 2002:a05:620a:45a7:b0:774:1875:edb1 with SMTP id
 bp39-20020a05620a45a700b007741875edb1mr3627056qkb.20.1696439959568; 
 Wed, 04 Oct 2023 10:19:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 vv22-20020a05620a563600b0076ca9f79e1fsm1411605qkn.46.2023.10.04.10.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:19:18 -0700 (PDT)
Message-ID: <32928bb3-f237-8e0b-0fdc-3e8adc13fb3a@redhat.com>
Date: Wed, 4 Oct 2023 19:19:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm.c: Set the qemu_irq/gsi mapping for
 VFIO platform
Content-Language: en-US
To: Luca Wei <Luca.Wei@verisilicon.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "eric.auger@linaro.org" <eric.auger@linaro.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Zijian Wang <Zijian.Wang@verisilicon.com>, Zhe Pan <Zhe.Pan@verisilicon.com>
References: <2FDAC4096138FA4DB2F2BDCE0F9521C00182151E@SHASXM06.verisilicon.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <2FDAC4096138FA4DB2F2BDCE0F9521C00182151E@SHASXM06.verisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

Hi Luca,
On 9/19/23 08:56, Luca Wei wrote:
> Eric added the qemu_irq/gsi hash table to let VFIO platform device
> setup irqfd when kvm enabled [1]. And he setup the qemu_irq/gsi
> mapping in arm_gic_kvm.c [2]. But this mapping is not setting up in
> arm_gicv3_kvm.c. When VM use VFIO platform device with gicv3,
> the irqfd setup will fail and fallback to userspace handled eventfd
> in `vfio_start_irqfd_injection`.

sorry your patch fell through the cracks :-(

I would drop "for VFIO platform" in the commit title and any mention to
"platform" in the message as I think this is likely to be used in PCI no
MSI mode. I am surprised we haven't noticed before tbh.

Also please directly mention the GICv2 patch instead of the email refs
below:
6a1a9cfa1c4a ("ntc: arm_gic_kvm: set the qemu_irq/gsi mapping")

Also this does not sound a Stable patch to me.

Thanks

Eric


> 
> This patch will setup the qemu_irq/gsi mapping for gicv3, so that
> VFIO platform device with gicv3 can use kvm irqfd to accelerate.
> 
> [1] https://lore.kernel.org/qemu-devel/20150706183506.15635.61812.stgit@gimli.home/
> [2] https://lore.kernel.org/qemu-devel/20150706183512.15635.915.stgit@gimli.home/


> 
> Signed-off-by: Luca Wei <Luca.Wei@verisilicon.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 72ad916d3d..7e90f8b723 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -807,6 +807,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
> 
>      gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
> 
> +    for (i = 0; i < s->num_irq - GIC_INTERNAL; i++) {
> +        qemu_irq irq = qdev_get_gpio_in(dev, i);
> +        kvm_irqchip_set_qemuirq_gsi(kvm_state, irq, i);
> +    }
> +
>      for (i = 0; i < s->num_cpu; i++) {
>          ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
> 
> --
> 2.41.0.windows.3
> 


