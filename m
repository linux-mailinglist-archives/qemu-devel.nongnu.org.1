Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D853C737069
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdFZ-0008Ci-Hz; Tue, 20 Jun 2023 11:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBdFX-0008C3-9l
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:26:31 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBdFV-0002gq-Mk
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:26:31 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-987a977f62aso403956466b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687274788; x=1689866788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/W2IwaiZZ6tXBXg6MqJeRDXXIVTJ7hEke0yuOoz/Qk=;
 b=v61B2uLMalKvejLLkQ6YNNzl70LuSUuwYZRyskwUSlJEk/sdwjQ8078crAxFlA7fPg
 Pv2G2piTlQ262187278FYwHR1ll4TZyKuloLbdKpJGu6eAiZUlfGLEAXirQmj/A36AoN
 9b65rxeJ41VQZLBxp2splqv2f9WfzY/rcLxcTLbomWOpzsxbfXoHTTFm8LjfDVQ9kDp7
 WvT1Lwf2jNhG3Eu7VxEw24jtETraZ3S5usWfSLPByxHr/m9EljGK/EmiCF15IK3GbWdd
 0xY68b2R+ASun5cYP8jyWqfcSrAksOZ9uXCPpwGugQXNdS8ykEfl2b15NAaO1+HzatFN
 p2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274788; x=1689866788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E/W2IwaiZZ6tXBXg6MqJeRDXXIVTJ7hEke0yuOoz/Qk=;
 b=Co0xrQqjmRabVh81uGqNODIItj5bJdx6i/OHohhAb/4sSZHpLcDzfWC4MD9HIyaMjH
 GBgdKuZ3F02YIP1ntepXKkFjQQyvn16YSF65k73LqztIgaMjGDgohUtZ2wgBjLz7p+tB
 JEU0W2wPmVRjBroinVMKrhSCTcIk4O659CG3Wrp7gGrIt3XM/GtsGNn0QHX7DX+bRpm/
 L7zESFAzoJ8gKmOkEWX6pgBeOenzbjl+zhYP8w/pQGk2LLCCHPjI2ko9qF0SkXQie78h
 fnzYoEsmeEmtW6IMLgVbav08b575c04DFAirERU2bWLnBD8oxQmzT9/jrGbanl4/miaY
 ycBA==
X-Gm-Message-State: AC+VfDwnXQCUrLCsL1hXwVJ5u7TDJn+nFpkk338su0FNKZHxbAXVK+wB
 AtuaebN+nOWrhk0BX9THNGjGyQ==
X-Google-Smtp-Source: ACHHUZ5EOkhPAu0vJmdHYYn6fGxv6KNG6Bl39uLgz/wscXXw9CQFPSfa+KjzCk5uPXW2N7XJFmTxrw==
X-Received: by 2002:a17:907:720c:b0:988:6491:98da with SMTP id
 dr12-20020a170907720c00b00988649198damr4967799ejc.12.1687274788097; 
 Tue, 20 Jun 2023 08:26:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a170906394c00b00988b8ff849csm1575112eje.108.2023.06.20.08.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 08:26:27 -0700 (PDT)
Message-ID: <92d01a5a-2fd5-a2ff-0208-e94103be9a13@linaro.org>
Date: Tue, 20 Jun 2023 17:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/ppc/spapr: Test whether TCG is enabled with
 tcg_enabled()
Content-Language: en-US
To: Greg Kurz <groug@kaod.org>, Claudio Fontana <cfontana@suse.de>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
References: <20230620074802.86898-1-philmd@linaro.org>
 <eb064809-7253-899a-97d1-635eb652b7fd@suse.de>
 <20230620164803.0aa623e6@bahia>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230620164803.0aa623e6@bahia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 20/6/23 16:48, Greg Kurz wrote:
> On Tue, 20 Jun 2023 09:55:49 +0200
> Claudio Fontana <cfontana@suse.de> wrote:
> 
>> On 6/20/23 09:48, Philippe Mathieu-Daudé wrote:
>>> Although the PPC target only supports the TCG and KVM
>>> accelerators, QEMU supports more. We can no assume that
>>> '!kvm == tcg', so test for the correct accelerator. This
>>> also eases code review, because here we don't care about
>>> KVM, we really want to test for TCG.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> I don't remember anymore, but what about qtest ? It is usually the forgotten case in these kind of tests... so much complexity :-)

Good to think about this, since such changes indeed usually break,
qtests :)

> This check was added with TCG in mind because it is a known limitation.
> I don't see any reason to prevent qtest from being used with the rest
> of this function though.

We don't have any CPU core when using qtest accelerator, so this
check is irrelevant IMHO (not reachable with '-accel qtest').

>>> ---
>>>   hw/ppc/spapr.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index dcb7f1c70a..c4b666587b 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2524,7 +2524,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>>>       int ret;
>>>       unsigned int smp_threads = ms->smp.threads;
>>>   
>>> -    if (!kvm_enabled() && (smp_threads > 1)) {
>>> +    if (tcg_enabled() && (smp_threads > 1)) {
> 
> Bonjour Philippe,
> 
> Please drop the unneeded parens in the second check.

I wanted to do that but then thought someone would ask me to do one
change at once ;)

> With this fixed,
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!



