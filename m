Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 769057E5363
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:30:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0foA-0005NM-0x; Wed, 08 Nov 2023 05:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fo1-0005Mn-Fv
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:29:06 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fny-0007zY-M4
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:29:04 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9df8d0c556eso524999066b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699439338; x=1700044138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/R0DyfONmdVfKsQLsbbhRQ8OB6qFWk3yoaVwXxr/+8=;
 b=EjmJ5AWSjDBydW+7ZK7Xhj+uzcUQBb0XNIcex6uVeXYEe1oHFUv7OfqhkXWK273ujk
 SfWN0/r4AnVQR1NsI+RKLgGYbqGq7nHDkyJUR/2+SjF/cfcFpyDiLA6E3uioKAmGdF77
 Up5Y0xm4a1PhVpG44riIKeQ6SPluYSG6yklp/Bgab60kF+PunMCHAJzO/oB5WIHSi9gF
 3+MAaTyci/GQs3SXPlFj2m4PKTOnEDsiGMHAAhObzhpOmxWYXPbQPNN/IV4cla+IHB2m
 zUCee1pANn4dNCq50fIBwmot/3nRLl1OdQfs7mtWr0D7RjAswqEBpeYBfW7t64Wu082v
 UR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699439338; x=1700044138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/R0DyfONmdVfKsQLsbbhRQ8OB6qFWk3yoaVwXxr/+8=;
 b=IMkCXadBsePRPbk8WPLMIQD9wgaplLadFp9ecde0YAN6F+80CZ//JOnWaBjaunaE/2
 XNSSb9GQA+4ptNvu4O6namp94lK9n7cvsAyZVKp6NEkn8J7/wVkpmHsJfTS5l/9QQpi6
 OKDFoAnJcv8Ni71RzklB2PhgOcRkXUdMK0Z919BRPapNjEw2XQ8qOSP289CxlFINfPbs
 AyLgZzNnoPDrGmKqSXpEaKEyFytzBwUIqHiPmuGAiWOG3dzpxktL9EcBOIp+flzCzDjX
 xzQFUgaLq12ucMcJ+HkJbxHqCJQBY3aF+wSY+1QMnx4QxDt7ulCwW7CFGkPPEYbwb/4P
 hQ6Q==
X-Gm-Message-State: AOJu0Yyg0zkSriMWfF6kRlLoASH9ROMbxMaWR8+nLD6jFa3AmepKgh2/
 csH/GqaJ3zCrzSiLLN9eO47t0Q==
X-Google-Smtp-Source: AGHT+IGXz54CMETEAIPt43IvYm8QrT8fdhRCY5QeVZ6Vlvyc1ISP1S6xVc1LpzfUdgKIYajiljkgNw==
X-Received: by 2002:a17:907:843:b0:9bd:7b0b:2657 with SMTP id
 ww3-20020a170907084300b009bd7b0b2657mr966992ejb.61.1699439338511; 
 Wed, 08 Nov 2023 02:28:58 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 t27-20020a170906179b00b009a1dbf55665sm803390eje.161.2023.11.08.02.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:28:57 -0800 (PST)
Message-ID: <c1322f3b-2ae2-4ca7-9a76-a2a434dc8315@linaro.org>
Date: Wed, 8 Nov 2023 11:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] hw/audio/pcspk: Inline pcspk_init()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231020171509.87839-1-philmd@linaro.org>
 <D0ECDB9D-F04B-46F5-BFE6-94257FB4FF65@gmail.com>
 <87cywr1ahe.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cywr1ahe.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/11/23 09:56, Markus Armbruster wrote:
> Bernhard Beschow <shentey@gmail.com> writes:
> 
>> Am 20. Oktober 2023 17:15:04 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>> Unfortunately v2 was merged as commit 40f8214fcd,
>>> so adapt v3 to clean the mess.
>>>
>>> Philippe Mathieu-Daudé (4):
>>>   hw/i386/pc: Pass Error** argument to pc_basic_device_init()
>>>   hw/i386/pc: Propagate error if HPET device creation failed
>>>   hw/i386/pc: Propagate error if PC_SPEAKER device creation failed
>>
>> I'm not sure if I'd do these first three patches. The reason is that machines don't inherit from DeviceState and therefore don't have canonical methods such as realize() to propagate errors. Propagating the errors in the machine init helper methods seem a bit ad-hoc to me.
> 
> The Error interface enables separation of error detection and error
> handling.  On detection, we create an Error object, and handling
> consumes it.
> 
> A function that leaves error handling to its callers generally requires
> its callees to leave it, too.  Use of &error_fatal is wrong then.
> 
> Even when error handling need not be left to callers, leaving it can
> result in simpler or more robust code.
> 
> When a function handles errors itself, say by use of &error_fatal or
> error_report(), it's only usable in contexts where this handling is
> appropriate.
> 
> Sometimes the context is obvious enough, and unlikely to change.
> Handling directly is fine then, and can be simpler.
> 
> When the context isn't that obvious, leaving error handling to callers
> liberates you from thinking about the context, and also enables safe
> reuse of the function in other contexts.
> 
> I think pc_basic_device_init() doesn't *need* the change, as it's
> context is obvious enough.  But the change is fine, and if we apply it,
> we never have to think about the context again.  Matter of taste.

I disagree with Bernhard because pc_basic_device_init() could end up
refactored and called elsewhere where error can be propagated -- think
qdev modules --, and in its current form we'll keep ignoring the caller
errp and use &error_fatal (see patch #2 and #3). Also, better to have
an unified style rather that trying to "optimize" arguments on a per
case basis. Anyhow, my 2 cents.

> 
>>>   hw/isa/i82378: Propagate error if PC_SPEAKER device creation failed
>>
>> The reason I suggested use of `errp` here is that it is already a parameter.
> 
> Use of &error_fatal in a function taking @errp is almost always wrong.
> The patch fixes an instance of "wrong".

Due to Bernhard concerns, I'm only queuing patch #4.

Regards,

Phil.


