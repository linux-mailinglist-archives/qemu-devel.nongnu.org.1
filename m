Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8378715FDB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yTm-0001yC-JS; Tue, 30 May 2023 08:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yTL-0001j9-Vb
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:29:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yTJ-0000un-KL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:29:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30aef0b8837so1266753f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449744; x=1688041744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yW9amAzmO5UV26tyXoeUP61v+x/0eo0a2juus0uHX/g=;
 b=b/T+ytY79o9OSCoffTNKDAcbUl2gbdJRxoR45lxVeWG0pK53XG4rQZIwL+5O/OwNLv
 liuv9uY79PzKUZe7n9s1bBVJr4QLdnpYidfmtyAT/C9dS3nwGgxbIRKSF8yJoEgnWcWv
 tMTmpm6TMJIqGFuMjpsjub13TN6Nw1t1bOsydl9gcF+I5Ed5iBxDMiFG8pGViIyLkngT
 7Hcle0f+QAG5RDLoi+XyT+1tCY+JN1b4OhQo9Knj/gE5wxxwaiwoEDWMbfj8JOL+6NJ4
 IMYAhV4ADAIsUSNb6W2bZLoMSyfwC6rzDARAbuZSs8ZdBsk/YLib7OgmeO8KqkJq116J
 zQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449744; x=1688041744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yW9amAzmO5UV26tyXoeUP61v+x/0eo0a2juus0uHX/g=;
 b=BlBlH0GDAEDeSRJdnwU+RSdNEK/m8H4XzFrD24wZHIrIy8uOJ5EVDtpEtbeVG1dSl4
 taEGwbhYqjK5L97R/yDV4VURjAH8Jkf5lHpY1qVgcY4oZZvmn5lt54oCfUUWImbk0xyH
 UFSFRNvBGBiHHc4fM1EjHcIo7/3IHlVr1IB2qvUcAYpCwfMselScRCIIcnh3/ikDJ+Rv
 ghYP0GuIJXU9tO/947dA7xu56lkfr+dP6zn/vWtf9Zj6c0KlExv64NP18mxHdGcAd3w/
 tdR4KqnLNFUVKWeBPh2usyXmTAjEv3Pn//fpvp6C02gAOrd42BCaQbg9nKr6Mz1DmlSY
 CWQw==
X-Gm-Message-State: AC+VfDyoyB9SlOyNkhUMLXAs8Qo/tw3VN3doTccXZ2j7YA0Ax+Rjc1iD
 BKcGTX6A/iGTFGOC9APEhj2F/w==
X-Google-Smtp-Source: ACHHUZ48o9iP96F+UbNUxoPHtZZxPf8eZZpI8KAQmVssm2DQ9ec8YKqtCCcC78H5uaWnkZtiJPhQIg==
X-Received: by 2002:a5d:4d02:0:b0:309:5dc:4c30 with SMTP id
 z2-20020a5d4d02000000b0030905dc4c30mr1307862wrt.62.1685449743968; 
 Tue, 30 May 2023 05:29:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 x15-20020adfdd8f000000b0030ae3a6be4asm3149982wrl.72.2023.05.30.05.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:29:03 -0700 (PDT)
Message-ID: <7ff1f897-7244-258e-34a5-a4a781f679dc@linaro.org>
Date: Tue, 30 May 2023 14:29:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 02/10] memory-device: Introduce memory_devices_init()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-3-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi David,

On 30/5/23 13:38, David Hildenbrand wrote:
> Let's intrduce a new helper that we will use to replace existing memory
> device setup code during machine initialization. We'll enforce that the
> size has to be > 0.
> 
> Once all machines were converted, we'll only allocate ms->device_memory
> if the size > 0.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/mem/memory-device.c         | 14 ++++++++++++++
>   include/hw/mem/memory-device.h |  2 ++
>   2 files changed, 16 insertions(+)


> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index 48d2611fc5..6e8a10e2f5 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -16,6 +16,7 @@
>   #include "hw/qdev-core.h"
>   #include "qapi/qapi-types-machine.h"
>   #include "qom/object.h"
> +#include "exec/hwaddr.h"
>   
>   #define TYPE_MEMORY_DEVICE "memory-device"
>   
> @@ -113,5 +114,6 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
>   void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
>   uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
>                                          Error **errp);
> +void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);


While hw/mem/memory-device.c contains the implementation, all callers
are expected to be around Machine object, right? Thus maybe this _init()
could be declared in "hw/boards.h", already included by machines
(eventually renaming as machine_init_memory_devices() ). Then machines
implementation don't have to all include "hw/mem/memory-device.h".

Alternatively, keep memory_devices_init() declared here, but implement
machine_init_memory_devices() in hw/core/machine.c, declaring it in
"hw/boards.h", so again machines don't have to include
"hw/mem/memory-device.h".

What do you think?

