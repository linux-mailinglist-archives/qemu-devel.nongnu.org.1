Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A59752AE8
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 21:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK1ym-00072k-C4; Thu, 13 Jul 2023 15:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK1ye-00071I-Mm
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 15:27:49 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK1yc-00048L-JN
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 15:27:48 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-caf3a97aa3dso1061975276.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689276465; x=1691868465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0B6arGw+NdeZ6QBvsCOTbLXVf4WMh9swLYm9vsORCxg=;
 b=MF9WjM2E9o97kWuZyAiq3BXkDHO7dUPQZCcw2q3+vJhMmmikvsq+t3ICIKdLmL77oc
 qdY7izGQ/OF6C3V82kbLSEET8h9WaKIWz8dSbhGIP6otiT5yHr0vVeyDJuy6QKHW4KMR
 r7h22sWUFXSrdP/5Wuf5oFxuAGoV8bvO5/EUXrchtjEU+xr453A/am3pSxaWmICguUm0
 eEcvNYJzkAl8JpiqxYhoat/ie82fiT27d+8eDzE89knjJNBZVy8tM4YaxCiZwAYj6rbQ
 +rnUmsblmt8DlCJ4ae/0KJYj/ImFU9gg4l/0XZCxyAO1m7MkHbuSfo43A+h3K/tearTY
 E/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689276465; x=1691868465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0B6arGw+NdeZ6QBvsCOTbLXVf4WMh9swLYm9vsORCxg=;
 b=EknDi+914XEsqOW1sIf0hjHsP5B42MyGOcQfzTaWsk2fadnFqUChlNyZatRNc/AQwL
 2Chf21/r9Grbl9ag045vIofhom10T9bn2xV9xQVhZ1R9cIe96nE173GusknQw17iAZmO
 TK97rQFWiz5BDlF2gfvzG2l1joAl5Wj7Ul7AUraZG30wZFVkyr0dVImHpeZWFkkzkLqG
 nNhLOkwdRGDJ80QCSxmgLQgUr3sL/zVJtMnAcMbRaMEbvvKGIxyxRPJ0iIcZLCm/rfl9
 YVw9Q6/E6yzv9TIjYU7rPe1qx9oBQ1RpCLIJjXQoUbEIWvdY9Vbn8wepUGvURLXpn/JQ
 VHag==
X-Gm-Message-State: ABy/qLY5u2RbhvfPnp91ply+2RHnwolzGsn1HfK2aHEd06ncVnLvkpjz
 VxV4Ljb+coNMkI46AXEoC5PFBA==
X-Google-Smtp-Source: APBJJlGFEPLy7pZCyg0mqcEOEYObQCVda5bciNkYaSpmMmQ6NNqvIUV0rWuitrB1ihDoQBXla/iBhQ==
X-Received: by 2002:a25:e74e:0:b0:cb9:77ef:da4b with SMTP id
 e75-20020a25e74e000000b00cb977efda4bmr558649ybh.50.1689276465097; 
 Thu, 13 Jul 2023 12:27:45 -0700 (PDT)
Received: from [192.168.88.227] ([172.58.139.107])
 by smtp.gmail.com with ESMTPSA id
 66-20020a251145000000b00ca6d2ad070csm799291ybr.29.2023.07.13.12.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 12:27:44 -0700 (PDT)
Message-ID: <21752231-e869-033f-2a48-d5f06d001a48@linaro.org>
Date: Thu, 13 Jul 2023 20:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <3a392615-5aca-f384-197f-84beb3086a29@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3a392615-5aca-f384-197f-84beb3086a29@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/13/23 13:34, Gavin Shan wrote:
> Hi Peter and Marcin,
> 
> On 7/13/23 21:52, Marcin Juszkiewicz wrote:
>> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
>>
>>> I see this isn't a change in this patch, but given that
>>> what the user specifies is not "cortex-a8-arm-cpu" but
>>> "cortex-a8", why do we include the "-arm-cpu" suffix in
>>> the error messages? It's not valid syntax to say
>>> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
>>
>> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for other architectures.
>>
>> I like the change but it (IMHO) needs to cut "-{TYPE_*_CPU}" string from names:
>>
>> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu 
>> cortex-r5
>> qemu-system-aarch64: Invalid CPU type: cortex-r5-arm-cpu
>> The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, cortex-a35-arm-cpu, 
>> cortex-a55-arm-cpu, cortex-a72-arm-cpu, cortex-a76-arm-cpu, a64fx-arm-cpu, 
>> neoverse-n1-arm-cpu, neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, 
>> host-arm-cpu, max-arm-cpu
>>
>> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu 
>> cortex-a57-arm-cpu
>> qemu-system-aarch64: unable to find CPU model 'cortex-a57-arm-cpu'
>>
> 
> The suffix of CPU types are provided in hw/arm/virt.c::valid_cpu_types in PATCH[2].
> In the generic validation, the complete CPU type is used. The error message also
> have complete CPU type there.
> 
> Peter and Marcin, how about to split the CPU types to two fields, as below? In this
> way, the complete CPU type will be used for validation and the 'internal' names will
> be used for the error messages.
> 
> struct MachineClass {
>      const char *valid_cpu_type_suffix;
>      const char **valid_cpu_types;

While you're changing this:

const char * const *valid_cpu_types;


> };
> 
> hw/arm/virt.c
> -------------
> 
> static const char *valid_cpu_types[] = {

So that you can then do

static const char * const valid_cpu_types[]



r~

