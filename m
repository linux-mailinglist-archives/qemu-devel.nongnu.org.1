Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C2179A0A9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 01:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfUDT-0006B8-Fn; Sun, 10 Sep 2023 19:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qfUDR-0006Az-Ne
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 19:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qfUDP-0001FR-AD
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 19:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694389902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1qxxh2+fI+mesrtDkof8J1FbUtQfmGsY47dCNqq+Z4=;
 b=H1/To7Yf2mLyOW4mwLbJxpTEDvJhoR2KxGBK/LtzDBYhFjVZkUzIGll2lDP/JGQ8jFBGRm
 onelZiGIs0d9OqRFXEhhbZENr76ivlbE+3DKGh8jkmWMmBvfVxVPgHbCv6Ry8zcrJPIoyE
 7Qfxf/i61FyyB7sEL8Czl+atM+6/20w=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-uhrHRvZEM1mN3LjMAubkHQ-1; Sun, 10 Sep 2023 19:51:40 -0400
X-MC-Unique: uhrHRvZEM1mN3LjMAubkHQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6bf0c48643fso3906266a34.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 16:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694389900; x=1694994700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U1qxxh2+fI+mesrtDkof8J1FbUtQfmGsY47dCNqq+Z4=;
 b=rlz5RLR9kHG3nrchTTQ2lGOtj3A7dQP7IlJzi4qV7YKHVbAZWhDTw8w0aY1TJGsgrA
 acbHCVoCuU53BiS4M3Lun6/og7wXMqFPaF6zWF3uY1zX4x1RvqepM7VQOf7hsSCFT0vo
 uU4pfmEYrtIOgtpXetUk96zoY1tQPS3Hj1i2u6assmEdpbMgtLx3d0lXnvCLxiBdOiO6
 cMqMgnHYO0BH6z3fBLu3FeWKi4VxZcAZfrT/2qq5yCDvwEU2NMfqwjeyjGLkDqd6ut07
 zTz/hwkUtCtrB9319I0ItZtWBmpeLooZdAm2M8NpJ5wGi9I8x9eHvqY6cjG1W/Snh1t6
 iwsA==
X-Gm-Message-State: AOJu0YzYPsfKPfpQtPrQ94xnctkXTKGpJglua7wtFyMMLiDCr13WQ9nV
 uavn7Pj3HU4Pt4MmVNOAXZ0l7bPs97d2u3Ex9e53qrTDAMhFyJbgJfbxTHXeuTIhjJ+hgIqNiWK
 +T3HhEmx6twljkDs=
X-Received: by 2002:a05:6358:8829:b0:129:c50d:6a37 with SMTP id
 hv41-20020a056358882900b00129c50d6a37mr9335591rwb.16.1694389899808; 
 Sun, 10 Sep 2023 16:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNAd7d0QSgqYbpK9NrmrLgGcUx1FjyAB6qy+AUOeRJTs0J6E0qfgPoPZUzbVaDhbwx4siE6Q==
X-Received: by 2002:a05:6358:8829:b0:129:c50d:6a37 with SMTP id
 hv41-20020a056358882900b00129c50d6a37mr9335541rwb.16.1694389899474; 
 Sun, 10 Sep 2023 16:51:39 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 cq27-20020a056a00331b00b0068fb9965036sm1380014pfb.109.2023.09.10.16.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Sep 2023 16:51:38 -0700 (PDT)
Message-ID: <9af2e956-ad3c-b1ab-ad23-72d72d2a31d3@redhat.com>
Date: Mon, 11 Sep 2023 09:51:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 15/32] target/s390x: Use generic helper to show CPU
 model names
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org
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
 <a8298b7b-309d-8986-2b2c-d53d50832987@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <a8298b7b-309d-8986-2b2c-d53d50832987@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/8/23 21:23, Philippe Mathieu-Daudé wrote:
> On 8/9/23 10:04, Philippe Mathieu-Daudé wrote:
>> On 8/9/23 01:44, Gavin Shan wrote:
>>>
>>> On 9/7/23 18:20, David Hildenbrand wrote:
>>>> On 07.09.23 02:35, Gavin Shan wrote:
>>>>> For target/s390x, the CPU type name is always the combination of the
>>>>> CPU modle name and suffix. The CPU model names have been correctly
>>>>> shown in s390_print_cpu_model_list_entry() and create_cpu_model_list().
>>>>>
>>>>> Use generic helper cpu_model_from_type() to show the CPU model names
>>>>> in the above two functions. Besides, we need validate the CPU class
>>>>> in s390_cpu_class_by_name(), as other targets do.
>>>>>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>> ---
>>>>>   target/s390x/cpu_models.c        | 18 +++++++++++-------
>>>>>   target/s390x/cpu_models_sysemu.c |  9 ++++-----
>>>>>   2 files changed, 15 insertions(+), 12 deletions(-)
> 
> 
>>>>>   static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
>>>>> @@ -916,7 +915,12 @@ ObjectClass *s390_cpu_class_by_name(const char *name)
>>>>>       oc = object_class_by_name(typename);
>>>>>       g_free(typename);
>>>>> -    return oc;
>>>>> +    if (object_class_dynamic_cast(oc, TYPE_S390_CPU) &&
>>>>> +        !object_class_is_abstract(oc)) {
>>>>> +        return oc;
>>>>> +    }
>>>>> +
>>>>> +    return NULL;
>>>>
>>>> Why is that change required?
>>>>
>>>
>>> Good question. It's possible that other class's name conflicts with
>>> CPU class's name. For example, class "abc-base-s390x-cpu" has been
>>> registered for a misc class other than a CPU class. We don't want
>>> s390_cpu_class_by_name() return the class for "abc-base-s390x-cpu".
>>> Almost all other target does similar check.
>>
>> I agree with David there is some code smell here.
>>
>> IMO this check belong to cpu_class_by_name(), not to each impl.
> 
> Suggestion implemented here:
> https://lore.kernel.org/qemu-devel/20230908112235.75914-1-philmd@linaro.org/
> 

Right. That is better way to consolidate the checks. I've provided my
comments for your code changes. I believe I need to rebase my v4 series
on top your changes. Philippe, please let me know if I need include your
patches to my v4 series, modify the code accordingly and send them together
for review.

Thanks,
Gavin


