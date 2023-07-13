Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F33752334
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJwBe-0001cY-JH; Thu, 13 Jul 2023 09:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJwBa-0001bh-Om
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJwBW-0004WA-9U
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689254200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eVRSo2tSIKZgDQQHtb1nILbj8XZwK9dV3+NgNbNYkQ=;
 b=ZruM/yXCKm3qkwq+UEoJ7SvTKpVd+XfCPHdOZAbEmOUZ/qD4AVsxju7vux8dBzLKMPgBs+
 Wj//KOSxFlr5ErZ/woPBp7k6+Tk4N6mtv/u8FNAx6Bg5FiQM0OT4/eBs7a37fkj1aHdm0D
 rBMqSWdPUnEvEYpvvM5V4UQPewJDD7U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-z6M2EfsMNo-cXMYoe8XflA-1; Thu, 13 Jul 2023 09:16:39 -0400
X-MC-Unique: z6M2EfsMNo-cXMYoe8XflA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-67c2f6fb908so322015b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 06:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689254198; x=1691846198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8eVRSo2tSIKZgDQQHtb1nILbj8XZwK9dV3+NgNbNYkQ=;
 b=ckL7Gcy+qDu3l+UEBJ47Q3hdJyxmcyUjz1cVtpOdjuQ0I3xdci+T0ZlWtfwRE4wDf6
 OyZHm8WUO2h+gbMk6F2FR++m2DuINr6B6/biSJKzlo8poDFrVzbZLVn7nhQ63EBnNC9B
 u5j0FVV4I7ukH5FQ6cnlxLABFYSl0Qgi5axvM4ha+C4V676AZwi1/5iUKeU2Io8HFf6m
 1sIVFl8V1teuZCn086BGiyEbkiGc9NsSHhrSmjzXw7W4eI1XDgCwU0CiouWtc7Te75dL
 rApMvy5jKfA0Hdla2sx8T0km5rXaTEQdwTDKGL65rR6M8iyPZsg3oJ+531z4iQ1MWq9L
 TVXw==
X-Gm-Message-State: ABy/qLanTuhv+e/zjFJvBLOwVOweZa8jkYg7WAn3C2AEV5ruNOfTQhBF
 5vGWki+WI0RDRXoEPXjCOAzNuHlhBocvCRP2aDrk0N75x6q48k52LMfMGJc6rDBvVxOGAIHIhdS
 hJmazA5VMZIqOyEI=
X-Received: by 2002:a05:6a20:7348:b0:133:6e6e:2b11 with SMTP id
 v8-20020a056a20734800b001336e6e2b11mr788155pzc.2.1689254198518; 
 Thu, 13 Jul 2023 06:16:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvHOgCIua/9i6Uehfo7kHduz/LEGmL/g6KPijMoBsj9nANKPj746jig9EN2CwmnJuB32Rjaw==
X-Received: by 2002:a05:6a20:7348:b0:133:6e6e:2b11 with SMTP id
 v8-20020a056a20734800b001336e6e2b11mr788131pzc.2.1689254198212; 
 Thu, 13 Jul 2023 06:16:38 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 ff24-20020a056a002f5800b00682562bf477sm5414090pfb.82.2023.07.13.06.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 06:16:37 -0700 (PDT)
Message-ID: <d735c41b-d835-8c35-bb03-6a7a4462210d@redhat.com>
Date: Thu, 13 Jul 2023 23:16:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] hw/arm/virt: Support host CPU type only when KVM or
 HVF is configured
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <20230713054502.410911-4-gshan@redhat.com> <87o7kgq8rq.fsf@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <87o7kgq8rq.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Connie,

On 7/13/23 22:46, Cornelia Huck wrote:
> On Thu, Jul 13 2023, Gavin Shan <gshan@redhat.com> wrote:
> 
>> The CPU type 'host-arm-cpu' class won't be registered until KVM or
>> HVF is configured in target/arm/cpu64.c. Support the corresponding
>> CPU type only when KVM or HVF is configured.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/arm/virt.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 43d7772ffd..ad28634445 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -217,7 +217,9 @@ static const char *valid_cpu_types[] = {
>>   #endif
>>       ARM_CPU_TYPE_NAME("cortex-a53"),
>>       ARM_CPU_TYPE_NAME("cortex-a57"),
>> +#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>>       ARM_CPU_TYPE_NAME("host"),
>> +#endif
>>       ARM_CPU_TYPE_NAME("max"),
>>       NULL
>>   };
> 
> Doesn't the check in parse_cpu_option() already catch the case where
> the "host" cpu model isn't registered? I might be getting lost in the
> code flow, though.
> 

Right, it's guranteed that the needed CPU type (class) is registered by parse_cpu_option().
However, we have different story here. The CPU type invalidation intends to limit the CPU type
(class) into a range for the specific machine (board). Taking "cortex-a8-arm-cpu" as an example,
it's not expected by hw/arm/virt machines even it has been registered when we have CONFIG_TCG=y.
the list of supported CPU type (class) will be dumped by hw/core/machine.c::validate_cpu_type()
in PATCH[1], "host" is obviously invalid when we have CONFIG_KVM=n and CONFIG_HVF=n. We can't
tell user that "host" is supported, to confuse user.

Thanks,
Gavin


