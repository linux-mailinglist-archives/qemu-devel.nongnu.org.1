Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D579F752850
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 18:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJzC8-0003tZ-Vp; Thu, 13 Jul 2023 12:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJzC6-0003so-A9
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:29:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJzC3-00063E-J4
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:29:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31441bc0092so1059508f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689265766; x=1691857766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j57510LUxxzsgzXCD2lvplw+84bFWXkvUzpWGy7Vq50=;
 b=X8Ms1UdzjLDOsmHKVLc2YAOoSuwS0yOMrUGiEOi5CpYmszlhVj0G0nVSy/8bgAyFiO
 LiUrlR9WaMDKF0yLD+vQ4VRYDa3ygVYgN2rzjGVR4R4IhcbXFZ+yn5D4c5SyDaeVLhgt
 RlljIuZkdeAuxWPiC5c5HrmSk3g8KZTa1LRS1VQpDtYmB9JeB4pE4hjs8olsxOYwTKrO
 rQTvwRzjWcWrVIU2nfLXUW3nwUyD+WCV+LV5/GWxNXmmaG+EqvNCjvv0EWQO4Hc1xp14
 8acKGrRW5sD0nBj10YHOcdgBtcv25tJVZU8H7sg70+JAM2dudpydnX6oejU3PWWyeBO6
 oucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689265766; x=1691857766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j57510LUxxzsgzXCD2lvplw+84bFWXkvUzpWGy7Vq50=;
 b=daS/bjsGACk6ZXf0ivzHG6G0YsQ4PV69J4PcRPqPyXMCSKphTTG7K/+B0von/lTqsw
 stD57fscaHR9T73nAJR4t2llAzKY7J4757/yZ/m/tOMibG2Stm+Hl7PUXqIvHvsG8SUQ
 UFnDfi2NdBl9MDWVQyYESyZivYFhWYpLqgU7rBryKSz0z06NEkT5E7br9/9VW1lIQAQs
 qdzxLZSSYHyn9zC984dQ14X86FjTsuEWWFERgfkwGSdXRyq8D3Q9hHy+k9HaRw1uKupc
 utLjroVTU6Ggkaoj365loftgfwm9gOdoA2h7BZX6QEq2l9ebieKB503s/ucmAvMoTm1T
 s1Og==
X-Gm-Message-State: ABy/qLZxsccYVOwEfUAmjxJU6ieZIIDcjXsYECp6d4Ez422AboQhpYwl
 R/wIa/xBbFLv7UwVdvdEF0X6OA==
X-Google-Smtp-Source: APBJJlGkxXXXXsXEQH7a4uPeJxAYwAea4tYpjMGMjMgnLsK/i+0cFrCdTpDQUevJw7fHQqtJwWcZAA==
X-Received: by 2002:adf:ed4c:0:b0:313:f347:eea0 with SMTP id
 u12-20020adfed4c000000b00313f347eea0mr1871608wro.60.1689265765777; 
 Thu, 13 Jul 2023 09:29:25 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 d9-20020adff2c9000000b00313e4d02be8sm8356290wrp.55.2023.07.13.09.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 09:29:25 -0700 (PDT)
Message-ID: <7ad244d7-2e29-74b4-e8bf-949925697880@linaro.org>
Date: Thu, 13 Jul 2023 18:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <3a392615-5aca-f384-197f-84beb3086a29@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <3a392615-5aca-f384-197f-84beb3086a29@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/7/23 14:34, Gavin Shan wrote:
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
>> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for 
>> other architectures.
>>
>> I like the change but it (IMHO) needs to cut "-{TYPE_*_CPU}" string 
>> from names:
>>
>> 13:37 marcin@applejack:qemu$ 
>> ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-r5
>> qemu-system-aarch64: Invalid CPU type: cortex-r5-arm-cpu
>> The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, 
>> cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, 
>> cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu, 
>> neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, 
>> host-arm-cpu, max-arm-cpu
>>
>> 13:37 marcin@applejack:qemu$ 
>> ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu 
>> cortex-a57-arm-cpu
>> qemu-system-aarch64: unable to find CPU model 'cortex-a57-arm-cpu'
>>
> 
> The suffix of CPU types are provided in hw/arm/virt.c::valid_cpu_types 
> in PATCH[2].
> In the generic validation, the complete CPU type is used. The error 
> message also
> have complete CPU type there.

In some places (arm_cpu_list_entry, arm_cpu_add_definition) we use:

   g_strndup(typename, strlen(typename) - strlen("-" TYPE_ARM_CPU))

Maybe extract as a helper? cpu_typename_name()? :)

