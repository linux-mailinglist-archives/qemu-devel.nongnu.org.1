Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC7725AF0
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6phv-0000DD-9u; Wed, 07 Jun 2023 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6phs-0000AP-Gn; Wed, 07 Jun 2023 05:43:56 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6phq-0006aD-Vu; Wed, 07 Jun 2023 05:43:56 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-392116ae103so4671633b6e.0; 
 Wed, 07 Jun 2023 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686131032; x=1688723032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ZpIIuH9QcDmqABY5BhNXWSYyIKXFwQ+4PrO4paBFCE=;
 b=eQqmvYwWedxt1wl+OPE5YkhhkYIYzrhAG0l/JfJ/qG04oNOkUTqueAia0C+cRq4eGG
 e455faPMpnCBdgkMI6e2Z1XQM8gCoOtueaNSkJC/+lcSXRdovBxlKenrTV+0ED6wTAct
 GH4m2JDeNupOHGdr3I4sQN/doA40UhmkFr888eEfLvSBTM2SoowKe9JiQIeG8QLk1Zsy
 8WTKw4x1PP5W4xvBB+NQMkENJHY3Ox1iSwO97Dejwu0X6rCFpNnhnVGZ8OlshppVjCA2
 P9LtjX/R2k4xyiG+HOchbAX09IzbKNepHn+oVAZLGGYS0yaF3EV8/+somQ13BN3ihM7n
 Btmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686131032; x=1688723032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZpIIuH9QcDmqABY5BhNXWSYyIKXFwQ+4PrO4paBFCE=;
 b=Ov+mJEr5cR0xw7SiZcFhqPTNYCXtoKKxUtiu0lMltS/+8IIwmid0sh97nW+Z9xPt6W
 35FJUKyY9BHCX8MvkoeTrjY8mSzU3baFZ+fJ6qz24N+BsAwG16ACOAuc0/75jYXbLHwP
 /zR6AqOAJKyvOok4U+rJbgV39897BwKwRNYQmwjh9mBmidtoyDemOR3r8iGKqo3nAhwe
 NAnERTERGgx4J5KSmX9OHrOKijyYdfq9Bz7YG17yjkjFniT8k8wc441uiT2FPREU1VqL
 uIrbzwTejmbr3FmIkSlp21rZ9yNsOymdtSx23RJrRXiytFowtfCvyoRHC/0Gx4JNWEYx
 c7xQ==
X-Gm-Message-State: AC+VfDydNWyRm+D2CHAZOJcP2vIbNCneLnOjwcVkdtZ+DW8mb3eVkPnm
 JvsT1KMVTyKpSlym26VPCpk=
X-Google-Smtp-Source: ACHHUZ4ys/3+R+vPFrNEyZKUKMj1T4i/PNGIsKTa2Tt5nWC97AQvov/rA537s4yM+Ebm9f/GAeVswQ==
X-Received: by 2002:a05:6808:3dc:b0:398:111d:c44c with SMTP id
 o28-20020a05680803dc00b00398111dc44cmr2158682oie.39.1686131032025; 
 Wed, 07 Jun 2023 02:43:52 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 s186-20020acac2c3000000b0039c4aa4c88csm1459748oif.42.2023.06.07.02.43.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 02:43:51 -0700 (PDT)
Message-ID: <19d86aba-bb18-06a3-cdb3-15be8f70b12a@gmail.com>
Date: Wed, 7 Jun 2023 06:43:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/2] target/ppc: Fix decrementer time underflow and
 infinite timer loop
To: Michael Tokarev <mjt@tls.msk.ru>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, sdicaro@DDCI.com
References: <20230530131214.373524-1-npiggin@gmail.com>
 <66f4d0ef-9f1c-7199-9c83-5109e7b888e2@tls.msk.ru>
Content-Language: en-US
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <66f4d0ef-9f1c-7199-9c83-5109e7b888e2@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.094,
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



On 6/7/23 06:26, Michael Tokarev wrote:
> 30.05.2023 16:12, Nicholas Piggin wrote:
>> It is possible to store a very large value to the decrementer that it
>> does not raise the decrementer exception so the timer is scheduled, but
>> the next time value wraps and is treated as in the past.
>>
>> This can occur if (u64)-1 is stored on a zero-triggered exception, or
>> (u64)-1 is stored twice on an underflow-triggered exception, for
>> example.
>>
>> If such a value is set in DECAR, it gets stored to the decrementer by
>> the timer function, which then immediately causes another timer, which
>> hangs QEMU.
>>
>> Clamp the decrementer to the implemented width, and use that as the
>> value for the timer calculation, effectively preventing this overflow.
>>
>> Reported-by: sdicaro@DDCI.com
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> sdicaro@DDCI.com debugged and reported this, I just changed their fix
>> to extract variable bits so it works with large decrementer. So most
>> of the credit goes to them.
>>
>> Thanks,
>> Nick
>>
>>   hw/ppc/ppc.c | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> Is it a -stable material?  From the description it smells like it is.

Feel free to pick it for -stable.  Thanks,

Daniel

> 
> Thanks,
> 
> /mjt
> 

