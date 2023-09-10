Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D779A0AA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 01:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfUF0-00079Y-RO; Sun, 10 Sep 2023 19:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qfUEy-00078O-KW
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 19:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qfUEu-0001Rt-K7
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 19:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694389996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap8jyUrXwHgxdqod+JAjPn4oLiZqDgWz3jFfOIi6xsM=;
 b=i6wi8zAi7MKpD4kETDyKpsBQVP3vbE5Zee7V9eZktdA+yL09UEVUO29ZpHc2Oq+nFeaETu
 rw/5hZZhIcZrJ+ZEmBfHVj4v+aR+msJS3sdXtXyhItcA5X8xVAqfUXxAf6ppOHX/ueyck/
 sDXxDHcHyYUB8Xfll1+I38jFoVU0M6s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-SfzQMQXpO72UURzcI7BV7g-1; Sun, 10 Sep 2023 19:53:14 -0400
X-MC-Unique: SfzQMQXpO72UURzcI7BV7g-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-68fbd377d60so900559b3a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 16:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694389993; x=1694994793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ap8jyUrXwHgxdqod+JAjPn4oLiZqDgWz3jFfOIi6xsM=;
 b=jvb5efzFAPnB12sAbWlo4kezPI4pr4ZKizzcpykBxnbUm+7LJlKh5mW6UrqT08xFmQ
 5RTuTDSYWvWNNVskbqt9s7HgSOlEBK9M+iW4MCk4zGuTCYdkhgPRN29QEo9+oI1YIucD
 8rG9ywSA94y0STaCHkUlDpHZAiAC4rKhl4IqNG5Rx7SGUjBYALvPko7v6B6eSGw3/ty2
 LTBYxkjT1/9TGA7+Tb6NIhADerHJ8IyUQ9STEGqeYgvwkqHV1nVcR9nNqgVBMNGanZ8j
 yR+AuLtTvqPgiXCkVJZ9GRKjcpnYzxq0fJXOOcgsMEonBb78743s/WnF1AySKBC/993i
 MjAA==
X-Gm-Message-State: AOJu0YxgzGopuuYQBjARpWtQHTnw0LiEKEWW9EOGG/IjLUboFbzcmCFw
 eo3oySJI2EmNwyLSp7j+KNB8y4l5CaxGjWZ/6DHNzKNLqFuv5Xt5E5SIx8W+iSnmS9T+Qx6mpsl
 4GCRy0ZYujPeuOho=
X-Received: by 2002:a05:6a00:2301:b0:68a:5877:bfb1 with SMTP id
 h1-20020a056a00230100b0068a5877bfb1mr10314006pfh.20.1694389993504; 
 Sun, 10 Sep 2023 16:53:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDBUuwMY4+d9ys82hxbkhGiirWTD/Zaq3MUkjBpifVkaU03GyjGaYtt0tO90IjO+1+aeEeA==
X-Received: by 2002:a05:6a00:2301:b0:68a:5877:bfb1 with SMTP id
 h1-20020a056a00230100b0068a5877bfb1mr10313976pfh.20.1694389993225; 
 Sun, 10 Sep 2023 16:53:13 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a056a001c9400b0068fcc7f6b00sm80251pfw.74.2023.09.10.16.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Sep 2023 16:53:12 -0700 (PDT)
Message-ID: <a99d2893-de4c-c188-2f27-5130d34a867d@redhat.com>
Date: Mon, 11 Sep 2023 09:52:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 27/32] machine: Print CPU model name instead of CPU
 type name
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
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
 npiggin@gmail.com, ysato@users.sourceforge.jp, david@redhat.com,
 thuth@redhat.com, iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com,
 pbonzini@redhat.com, imammedo@redhat.com, shan.gavin@gmail.com
References: <20230907003553.1636896-1-gshan@redhat.com>
 <20230907003553.1636896-28-gshan@redhat.com>
 <5a87e81c-b28e-d117-7384-38945a2c5b8d@linaro.org>
 <d4aebe17-c077-90ad-2b99-a856b3a4cdcc@redhat.com>
 <a25899be-652a-f104-4efb-f24efcdf2358@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <a25899be-652a-f104-4efb-f24efcdf2358@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/8/23 17:56, Philippe Mathieu-Daudé wrote:
> On 8/9/23 01:49, Gavin Shan wrote:
>> On 9/7/23 19:05, Philippe Mathieu-Daudé wrote:
>>> On 7/9/23 02:35, Gavin Shan wrote:
>>>> The names of supported CPU models instead of CPU types should be
>>>> printed when the user specified CPU type isn't supported, to be
>>>> consistent with the output from '-cpu ?'.
>>>>
>>>> Correct the error messages to print CPU model names instead of CPU
>>>> type names.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>   hw/core/machine.c | 16 ++++++++++++----
>>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>>
>>>> @@ -1373,11 +1374,18 @@ static void is_cpu_type_supported(MachineState *machine, Error **errp)
>>>>           /* The user specified CPU type isn't valid */
>>>>           if (!mc->valid_cpu_types[i]) {
>>>> -            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
>>>> -            error_append_hint(errp, "The valid types are: %s",
>>>> -                              mc->valid_cpu_types[0]);
>>>> +            model = cpu_model_from_type(machine->cpu_type);
>>>> +            error_setg(errp, "Invalid CPU type: %s", model);
>>>> +            g_free(model);
>>>> +
>>>> +            model = cpu_model_from_type(mc->valid_cpu_types[0]);
>>>> +            error_append_hint(errp, "The valid types are: %s", model);
>>>> +            g_free(model);
>>>> +
>>>>               for (i = 1; mc->valid_cpu_types[i]; i++) {
>>>> -                error_append_hint(errp, ", %s", mc->valid_cpu_types[i]);
>>>> +                model = cpu_model_from_type(mc->valid_cpu_types[i]);
>>>
>>> cpu_model_from_type() can return NULL:
>>>
>>>   char *cpu_model_from_type(const char *typename)
>>>   {
>>>       const char *suffix = "-" CPU_RESOLVING_TYPE;
>>>
>>>       if (!object_class_by_name(typename)) {
>>>           return NULL;
>>>       }
>>>
>>> Don't we want to skip that case?
>>>
>>>                     if (!model) {
>>>                         continue;
>>>                     }
>>>
>>
>> No, it's intentional. "(null)" will be printed in this specific case so that
>> it can be identified quickly and mc->valid_cpu_types[] need to be fixed by
>> developers.
> 
> If you want to help developers, use g_assert().
> 

g_assert() wins. It will be included into v4 :)

Thanks,
Gavin


