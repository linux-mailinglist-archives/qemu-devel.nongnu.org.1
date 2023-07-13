Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C3752216
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJvw7-0002y1-7d; Thu, 13 Jul 2023 09:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJvw3-0002xc-Oq
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJvw2-00083C-B4
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689253240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KVspK4Yi5j3UqTEjGhaqzh33UwKcUOEgAdtql+oH04=;
 b=WZUUIY98Nb2MWbVdkuRfMcAeSc7EPTE2rS7lWH2NOyEZKKn7+nyh9+z02YV1P/CFw6SQbs
 H+G1jGIUyn6rxXScODiBxk4BT7G8ss6bHsT11GIZLEXu6JjgBjhI2EZRIRc6oJE3xVA+QJ
 zQLh4uF8Foq3v0spEyB8MlZydMd/CYs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-McEl5tsqN0if6QB_JKpzjw-1; Thu, 13 Jul 2023 09:00:38 -0400
X-MC-Unique: McEl5tsqN0if6QB_JKpzjw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b8a7e21f15so4469005ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 06:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689253236; x=1691845236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3KVspK4Yi5j3UqTEjGhaqzh33UwKcUOEgAdtql+oH04=;
 b=O1JzOtED/5EsUVwAOGgLKlRMbtrhJD1t+LU7/4/mnfFpTVhMWvxGn3pT7JxdVBai8M
 yQh6ncb8Zw4iXHqTMzB6TDQvaSY7FxuX19Z/6h8W0oeObs/83EbFb/adfT7GSMl1auX4
 r7DKtW2DzwzHwlF8IjvzJh9k/A//10AvSOcoqPc9zHsQCUXPPS/lXQfJLbAhxcAsqPnd
 v5TdYEVmQsMXhLVT34lw0GcPwWhXscAOytTJyJmjZb3+U++kLQA1yK/t8WJ8gxMU7gYV
 TaruCoOfct+QD1+v2iZ1l3AOw0uPB6tu2w3VoypB/rkPFP0ctvFu27Mq+qudT3pQwg9E
 SKtQ==
X-Gm-Message-State: ABy/qLZz2hEsWy8iIIl7ylVl4I9y2WwkRa5NEXtiAKT4x8VfoKCLS4NJ
 hI6GyFtnjpNp/OatkvQUB8+KmKz/oXpd/ucdhsR/9LmANhdkxObI8U6Gtb659qoRYqjaPBBiVXm
 2YQIhiAmg4Cmh6JQ=
X-Received: by 2002:a17:902:e80a:b0:1b0:3d03:4179 with SMTP id
 u10-20020a170902e80a00b001b03d034179mr2195881plg.6.1689253235841; 
 Thu, 13 Jul 2023 06:00:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGx7+mZGNERmNbavfbF9qSZd1sD8zXpgzgP5JisK3SLpkfTd9QnNfkf86w6KSj/0/CmJiM2ug==
X-Received: by 2002:a17:902:e80a:b0:1b0:3d03:4179 with SMTP id
 u10-20020a170902e80a00b001b03d034179mr2195816plg.6.1689253235081; 
 Thu, 13 Jul 2023 06:00:35 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a170902904200b001b8013ed362sm5863643plz.96.2023.07.13.06.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 06:00:34 -0700 (PDT)
Message-ID: <12d0c82a-f9d7-03d0-f2cd-0fead92d3156@redhat.com>
Date: Thu, 13 Jul 2023 23:00:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <3a392615-5aca-f384-197f-84beb3086a29@redhat.com>
 <2e1fbb6c-e7b4-df42-c64c-59de47f05981@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <2e1fbb6c-e7b4-df42-c64c-59de47f05981@linaro.org>
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

Hi Marcin,

On 7/13/23 22:44, Marcin Juszkiewicz wrote:
> W dniu 13.07.2023 o 14:34, Gavin Shan pisze:
>> On 7/13/23 21:52, Marcin Juszkiewicz wrote:
>>> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
>>>
>>>> I see this isn't a change in this patch, but given that what the user specifies is not "cortex-a8-arm-cpu" but "cortex-a8", why
>>>> do we include the "-arm-cpu" suffix in the error messages? It's
>>>> not valid syntax to say "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
> 
>>> I like the change but it (IMHO) needs to cut "-{TYPE_*_CPU}"
>>> string from names:
> 
>> Peter and Marcin, how about to split the CPU types to two fields, as below? In this way, the complete CPU type will be used for validation
>> and the 'internal' names will be used for the error messages.
> 
> Note that it should probably propagate to all architectures handled in QEMU, not only Arm ones. I do not know which machines have list of supported cpu types like arm/virt or arm/sbsa-ref ones.

Right, there are more boards eligible for this generic CPU type invalidation. I will
cover all of them in next revision. Currently, the pattern of prefix + suffix, used
to split the CPU type name, can work well for all cases.

[gshan@gshan hw]$ git grep strcmp.*cpu_type
arm/bananapi_m2u.c:    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
arm/cubieboard.c:    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a8")) != 0) {
arm/mps2-tz.c:    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
arm/mps2.c:    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
arm/msf2-som.c:    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
arm/musca.c:    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
arm/npcm7xx_boards.c:    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
arm/orangepi.c:    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
avr/boot.c:        if (strcmp(elf_cpu, mcu_cpu_type)) {                                       <<<<< needsn't CPU type validation
riscv/shakti_c.c:    if (strcmp(mstate->cpu_type, TYPE_RISCV_CPU_SHAKTI_C) != 0) {


>>> I can change sbsa-ref to follow that change but let it be userfriendly.
> 
>> Yes, sbsa-ref needs an extra patch to use the generic invalidation.
>> I can add one patch on the top for that in next revision if you
>> agree, Marcin.
> 
> I am fine with it.
> 

Thanks a lot for your confirm, Marcin.

Thanks,
Gavin


