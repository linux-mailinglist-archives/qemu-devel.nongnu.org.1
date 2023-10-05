Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBDA7BAF05
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 01:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoXOr-0000Ev-0S; Thu, 05 Oct 2023 19:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoXOo-0000CT-EM
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 19:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoXOn-0001Lo-1e
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 19:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696547091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NexGcUxr9QMh1GaPEI3/Ke0CYe4YuPrBRYINF2s8+5g=;
 b=eZBG1N/+LjukK0jgbfDwzj/0itKj13JA5vauXUutuP1q8OFztpNZnsuUDXcMb/EVkXNnz7
 YSpVpEDC1UxR+McXrXbU5X2SvjS62lXG2AOXsBZ5QpauXnjJvfGEHq91+lR7BdlpZw8qBS
 VK7Pmfn9rXXAoN8bIFZuvGqt1OkhXVE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-sD2g-TkrOfKICsO5ZeyYUQ-1; Thu, 05 Oct 2023 19:04:48 -0400
X-MC-Unique: sD2g-TkrOfKICsO5ZeyYUQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b99b6b8315so129349666b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 16:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696547087; x=1697151887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NexGcUxr9QMh1GaPEI3/Ke0CYe4YuPrBRYINF2s8+5g=;
 b=ticFxE2UtxAt73EfWoRSlvhZvJoF0Dl2KmqsEpQXsz4+66lX4KXImV3Wr8FaLlNXWw
 V1BE9uuXXmCTPkigUvTtM161qksn7otSjM0jL3J9m8Q4tyGKED4Zx1Uu16ZAyszMLUOd
 v2p5TcJ1qbm0UtPFuNKlkM87xeZc6Ewm5Dihn/y3fn7iC/4qdoO2FjaLDsKPQViqx8mn
 GXh/sl3fGwHcN2Q2IUne6qb85weASIk2ZTjjR5eatxFDVNIBbWVkBM/a4JavpKYdvgP/
 N+SQVOAuZeHaWTqsO7UEn7lVE+BGKgl/J1IXooQHPrU8BdO6bhVJQH9qKNWrZEhfs62f
 Cc+w==
X-Gm-Message-State: AOJu0YxPKWyVvoMoAA1mrwyAG3mbpUMfJI+biPBN9ysjp1O0DoLu3T44
 P3QdDHECN0hBSIhJwGjvw7Qz45ptwSGPdL4b4XiHgjWOkpZ1+/ovaavC12DTPT6V3AnZL+LnBwv
 MJ5m13ofHW+ttGPw=
X-Received: by 2002:a17:906:2250:b0:9ae:54ea:5b0f with SMTP id
 16-20020a170906225000b009ae54ea5b0fmr6491956ejr.24.1696547087658; 
 Thu, 05 Oct 2023 16:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWdXPWHFer15UOARguizaa0rN6wDMKwO2ddd0URnnyHdYxCodn83ibOxmUYA6P4BCV+NAdaQ==
X-Received: by 2002:a17:906:2250:b0:9ae:54ea:5b0f with SMTP id
 16-20020a170906225000b009ae54ea5b0fmr6491940ejr.24.1696547087319; 
 Thu, 05 Oct 2023 16:04:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 t25-20020a1709063e5900b0098f33157e7dsm1840254eji.82.2023.10.05.16.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 16:04:46 -0700 (PDT)
Message-ID: <3a901d18-a07c-cc6c-f9ce-b500d07556cb@redhat.com>
Date: Fri, 6 Oct 2023 01:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/5] hw/intc/apic: Pass CPU using QOM link property
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-6-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231003082728.83496-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/3/23 10:27, Philippe Mathieu-Daudé wrote:
> -    /* TODO: convert to link<> */
> -    apic = APIC_COMMON(cpu->apic_state);
> -    apic->cpu = cpu;
> -    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
> +    qdev_prop_set_uint32(cpu->apic_state, "base-addr",
> +                         APIC_DEFAULT_ADDRESS | MSR_IA32_APIC

For this to use a link, it's missing the corresponding 
object_unref(apic->cpu) + apic->cpu = NULL assignment somewhere.  For 
example you can add it in apic_common_unrealize (called by 
device_unparent - which is called in turn by x86_cpu_unrealizefn).

Paolo


