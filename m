Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38E79866C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZbK-0005O7-MN; Fri, 08 Sep 2023 07:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZaW-0004Vn-St
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:23:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZaS-0003vG-R9
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:23:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso1730729f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694172222; x=1694777022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OyDUm3nOUboduikcw5vwRl3oBHDOs0WSIkZ457il4g0=;
 b=V15+s+IVaUFpE1yVd0YYSH+r18Yy4xG8xPk6pnsNreBt8R3IGI+clH8jQwC3EG0mt9
 4EwIiYO91NEcN8Sozz2Mns60VIHPQ8FubENfTFcvrAljuUHplarY162m+J7HPABxwFzG
 /PKUSy6AO3u4owX92aJhUb1mfzBB1ULLqyIo/eljDBSKSP8QDzaDyqmgaJ0CJ8mpLWKh
 kE2bxRuwggyjPceIQ3AEYTpM9gtafyAbEnPDvj4p8SYQLUqxpwCQrwK24P743D+wHoqo
 A2nWDQLm4V8DX8OnntRaAf83AmWPhgz21oOT0lZWoaWNGwquA5mUwVTM2Kh6OWF0E64v
 tJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694172222; x=1694777022;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OyDUm3nOUboduikcw5vwRl3oBHDOs0WSIkZ457il4g0=;
 b=FJBwOkOO57n+SCCpizJks/j6PGyIJeHk6gfjsm+6JjrUe1qyo0nHJPut6a8P6KUpKS
 g7Nzv1X/iUKea0lXjS9EuvP5FsvqhxO0SdoetKkl89Ubgj7nYKs6VBFV1uSM9XlBIYH8
 scaImOkLw1dWik87E0m/0B5ohMDypTMPK1INmEpqN5Ki3hnFyNPEQwZgKg7ERqcLYKqw
 MqRxNh+K41IvXk5I4U013JUqWDVtC5fuEi20s67szMBykSlIBmSoVCbJw69yp99I/v3/
 qw8fsn63Jp1jWU4HONmlBKfRClyKHwEdjQnWRBuT+68mPClLnKpj2YiCT9R7v2tPC9oE
 114w==
X-Gm-Message-State: AOJu0YyNE9Kc7BlKD/1PVRXtuj5+DFcM2oRPLD8KQpwihCyDHrSZE68D
 8llXRUxrUnpEloNpyJhp6i9FVg==
X-Google-Smtp-Source: AGHT+IHWsFA6E+u7tey1w1HsvX/y+0kVM6Jf2FnNkmLhjDHfJlMCQIEDL/IvsrXCILki5JOGDkOYdQ==
X-Received: by 2002:a5d:6ace:0:b0:318:fa5:d84e with SMTP id
 u14-20020a5d6ace000000b003180fa5d84emr1733752wrw.70.1694172222525; 
 Fri, 08 Sep 2023 04:23:42 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a5d4751000000b003197b85bad2sm1869253wrs.79.2023.09.08.04.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 04:23:42 -0700 (PDT)
Message-ID: <a8298b7b-309d-8986-2b2c-d53d50832987@linaro.org>
Date: Fri, 8 Sep 2023 13:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 15/32] target/s390x: Use generic helper to show CPU
 model names
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, imp@bsdimp.com, kevans@freebsd.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org, laurent@vivier.eu,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 mrolnik@gmail.com, edgar.iglesias@gmail.com, bcain@quicinc.com,
 gaosong@loongson.cn, yangxiaojuan@loongson.cn, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, crwulff@gmail.com, marex@denx.de, shorne@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, ysato@users.sourceforge.jp, thuth@redhat.com,
 iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, pbonzini@redhat.com,
 imammedo@redhat.com, shan.gavin@gmail.com
References: <20230907003553.1636896-1-gshan@redhat.com>
 <20230907003553.1636896-16-gshan@redhat.com>
 <698b58e2-0c41-856d-cd79-71c8d0b3ff79@redhat.com>
 <ab07d81c-da98-a270-c3f6-0625912c6d0b@redhat.com>
 <5e3a1a66-9d33-cf14-56f7-0fa097b27fcb@linaro.org>
In-Reply-To: <5e3a1a66-9d33-cf14-56f7-0fa097b27fcb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/9/23 10:04, Philippe Mathieu-Daudé wrote:
> On 8/9/23 01:44, Gavin Shan wrote:
>>
>> On 9/7/23 18:20, David Hildenbrand wrote:
>>> On 07.09.23 02:35, Gavin Shan wrote:
>>>> For target/s390x, the CPU type name is always the combination of the
>>>> CPU modle name and suffix. The CPU model names have been correctly
>>>> shown in s390_print_cpu_model_list_entry() and create_cpu_model_list().
>>>>
>>>> Use generic helper cpu_model_from_type() to show the CPU model names
>>>> in the above two functions. Besides, we need validate the CPU class
>>>> in s390_cpu_class_by_name(), as other targets do.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>   target/s390x/cpu_models.c        | 18 +++++++++++-------
>>>>   target/s390x/cpu_models_sysemu.c |  9 ++++-----
>>>>   2 files changed, 15 insertions(+), 12 deletions(-)


>>>>   static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
>>>> @@ -916,7 +915,12 @@ ObjectClass *s390_cpu_class_by_name(const char 
>>>> *name)
>>>>       oc = object_class_by_name(typename);
>>>>       g_free(typename);
>>>> -    return oc;
>>>> +    if (object_class_dynamic_cast(oc, TYPE_S390_CPU) &&
>>>> +        !object_class_is_abstract(oc)) {
>>>> +        return oc;
>>>> +    }
>>>> +
>>>> +    return NULL;
>>>
>>> Why is that change required?
>>>
>>
>> Good question. It's possible that other class's name conflicts with
>> CPU class's name. For example, class "abc-base-s390x-cpu" has been
>> registered for a misc class other than a CPU class. We don't want
>> s390_cpu_class_by_name() return the class for "abc-base-s390x-cpu".
>> Almost all other target does similar check.
> 
> I agree with David there is some code smell here.
> 
> IMO this check belong to cpu_class_by_name(), not to each impl.

Suggestion implemented here:
https://lore.kernel.org/qemu-devel/20230908112235.75914-1-philmd@linaro.org/


