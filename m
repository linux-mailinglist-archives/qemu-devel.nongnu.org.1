Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745975216B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJvfD-0004qJ-HV; Thu, 13 Jul 2023 08:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJvf9-0004pG-1g
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJvf7-0008Bo-8D
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689252192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NVgw3E/WrgewRYmyVCLpW8vORIcS2V+7DSFXSdXabwA=;
 b=KgMkHf0U+bDu8x+k5qQENW/8cv4mZp9HfFQFdkZ2GfZanvRQvaQHc+tLNVJWamDpqLpQKz
 SoyhtbiHHUBV5N5IRMAjLMseY6s3Q7hp1jjnOUcsXiGMin9yFoqYETwTXwhK9uk3NXocAj
 lMd/VD0aWpJ2w+tBuoimjb/Iy4CnhHY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-D1TPEdtcMGC2Nkado7yXxA-1; Thu, 13 Jul 2023 08:43:05 -0400
X-MC-Unique: D1TPEdtcMGC2Nkado7yXxA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1b439698cd8so1090149fac.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 05:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689252184; x=1691844184;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVgw3E/WrgewRYmyVCLpW8vORIcS2V+7DSFXSdXabwA=;
 b=HDnbL528YDYMoLAtmtZqtdDarsmyFvJCgsDSbNFDPmyah5+7kHT0m9iv04tJD0ZV+D
 nVSNuixwuQWiHds2WR2MC3VHWSL6RqWvfSQjmwRh/rrppvCAOu4aybXdJeCnpDu/cdcp
 /epCe3WSXdlPxeoYvtanNAmcRBX8u0XCr8n7gasKO2xao6NTeR0FDf6UOiv474RDRqpq
 Ob92ybzPLZIjNcASqOTxzyCwPncS31tw+TZ1l93tMjps7/mbDkBMn3DEsJ1+7YG0jTMa
 BLxXTuAUMct4Eg2443heEHCmxBJmU5u9KSfxlz2suFdXiyGL9yJ2AhENEGMu83/p1sZW
 rE5g==
X-Gm-Message-State: ABy/qLYmK3nbl6VYLY5a+xhS0ox2RmI5UVVhEAFdCT/DyCJbRpzOGMPg
 nsj9a9x0IHNRmouFULj1WqwXyra2LCGF3LPltgwEAdgXjIplQqczehXDVuKFwfQh1zbTRzrmTmC
 IKG/I3EjHX6NZsiQ=
X-Received: by 2002:a05:6871:1cd:b0:1b7:4b56:fe68 with SMTP id
 q13-20020a05687101cd00b001b74b56fe68mr2060696oad.3.1689252184529; 
 Thu, 13 Jul 2023 05:43:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3t/1m/fZB+lQpXNTxXfD/HZNbEQGCcfb+uQdvzm6n+JGwTk6Q+jo6f8Y0APGFl/t0H+ogMQ==
X-Received: by 2002:a05:6871:1cd:b0:1b7:4b56:fe68 with SMTP id
 q13-20020a05687101cd00b001b74b56fe68mr2060678oad.3.1689252184270; 
 Thu, 13 Jul 2023 05:43:04 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a17090aba1800b0026302348ee4sm11911677pjr.30.2023.07.13.05.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 05:43:03 -0700 (PDT)
Message-ID: <08a313fd-ddf8-538d-df51-03e28aee0d97@redhat.com>
Date: Thu, 13 Jul 2023 22:42:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
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

Hi Peter,

On 7/13/23 21:44, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 06:45, Gavin Shan <gshan@redhat.com> wrote:
>>
>> There is a generic CPU type invalidation in machine_run_board_init()
>> and we needn't a same and private invalidation for hw/arm/virt machines.
>> This series intends to use the generic CPU type invalidation on the
>> hw/arm/virt machines.
>>
>> PATCH[1] factors the CPU type invalidation logic in machine_run_board_init()
>>           to a helper validate_cpu_type().
>> PATCH[2] uses the generic CPU type invalidation for hw/arm/virt machines
>> PATCH[3] support "host-arm-cpu" CPU type only when KVM or HVF is visible
>>
>> Testing
>> =======
>>
>> With the following command lines, the output messages are varied before
>> and after the series is applied.
>>
>>    /home/gshan/sandbox/src/qemu/main/build/qemu-system-aarch64 \
>>    -accel tcg -machine virt,gic-version=3,nvdimm=on            \
>>    -cpu cortex-a8 -smp maxcpus=2,cpus=1                        \
>>      :
>>
>> Before the series is applied:
>>
>>    qemu-system-aarch64: mach-virt: CPU type cortex-a8-arm-cpu not supported
>>
>> After the series is applied:
>>
>>    qemu-system-aarch64: Invalid CPU type: cortex-a8-arm-cpu
>>    The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, \
>>    cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, \
>>    cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu,     \
>>    neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, \
>>    max-arm-cpu
> 
> I see this isn't a change in this patch, but given that
> what the user specifies is not "cortex-a8-arm-cpu" but
> "cortex-a8", why do we include the "-arm-cpu" suffix in
> the error messages? It's not valid syntax to say
> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
> 

Good point. Right, the complete CPU type names are provided by board (hw/arm/virt).
The compelte CPU type names are used in hw/core/machine.c to search the object
class. In the error messages in the same source file, the complete CPU type names
are also used. Actually, we need 'internal' names like 'cortex-a8' to be shown in the
error messages.

For the solution, I've suggested to split the MachineClass::valid_cpu_types to
two fields (valid_cpu_types and valid_cpu_type_suffix). Their combination is
the complete CPU type name and 'valid_cpu_types[i]' corresponds to the 'internal'
name, to be used in the error messages. Please take a look on that thread and reply
to it.

Thanks,
Gavin


