Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013972E45A
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:41:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q94GF-0000td-Mr; Tue, 13 Jun 2023 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94GD-0000tI-9E
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:40:37 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94GB-0003tL-Cd
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:40:37 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5162d2373cdso9696598a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686663632; x=1689255632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WtAbCGxaViGK+p3L+6s6jnR8/DIRJBvGsykwgWN+hfQ=;
 b=adbI6uQBb0Jw1HhweHWjXn1ZRKIRaQvkMNKfh4mqaqU3dHQu3sB7JjrzyV6MZ6CMP6
 7pyX2AJPEsKi0s0fZgddBWq98g8yWmlvh8Bu6Ybz4TcHNwsolcHnFux0p7Vk8tu67+nt
 5HQhGNK4Gyv9TxH9gX74sVrSeU6ibRdCTzQFLS9rGeGrMNj34+dR668afbSClB63whh2
 yGL91ZlJm4AhhC/sEfDqzYpnt0UEaEGCiSb+WNMluTRwpeW76JcgOXPFpRFX665uFeyu
 NGIwRNYbvTxCpzKO+Oip6SOdy8oFgyG0nXADv9AZGceMYA7WKQ9pY1n5PnE5fL5nGNXj
 Ik1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686663632; x=1689255632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WtAbCGxaViGK+p3L+6s6jnR8/DIRJBvGsykwgWN+hfQ=;
 b=RR3veTtX9mhwbGnUEQmAcZy7rM7sRCf11Moeh3HenuzaG9HZTHYO8mCLxaVNGWH+0G
 +/LDtjZHxFTjScwaUm5cX0yhOlu+/bcH/CW4o9fiIT/v2FGpeRpcuMKSx59Pdi/EvT3W
 uqvIhmMt+jt2ycqkMCf8FdmAzPGgcvm0N72kd2aZq5vQI6pYmvAkCMOWxbMYGYwUcmEN
 Hq9sGLfnWjRMCo8SW39wXcNPtypUpumLToizFcWazM8ZXIQOiSYiZcYn/1jykyqd6Cl7
 vNH0RtYz9UZB5Xip/qLqowHjtVfXYmjiXow+3UNnNogGpp07sr+XZAQma0xlRywQn8Na
 qstg==
X-Gm-Message-State: AC+VfDyV4VCCzWf1Vh9FIUCu50nxIv0vgWSunmFHhKnNGaodVQAHYCW1
 cR94Pkqvqq6YINs1wMSLlRYfvwV08kNvrnSbedM=
X-Google-Smtp-Source: ACHHUZ7re3GYbfXQ0NZd7sRZd46jgmGFlD+Go3G8xloIsCgCaIXu0Xqaib/dDtOUzYNmvbOgjINNjA==
X-Received: by 2002:aa7:d0cc:0:b0:514:a565:6e28 with SMTP id
 u12-20020aa7d0cc000000b00514a5656e28mr7399008edo.18.1686663632525; 
 Tue, 13 Jun 2023 06:40:32 -0700 (PDT)
Received: from [10.200.8.212] ([213.235.133.109])
 by smtp.gmail.com with ESMTPSA id
 u3-20020aa7d543000000b00514bddcb87csm6581125edr.31.2023.06.13.06.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 06:40:32 -0700 (PDT)
Message-ID: <3b1710cc-b905-e005-a8ab-97513d3c6702@linaro.org>
Date: Tue, 13 Jun 2023 15:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 02/15] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
 <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
 <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
 <20230613044810-mutt-send-email-mst@kernel.org>
 <0ff30d22-25f9-750e-3ec1-f0988eee5668@eik.bme.hu>
 <20230613150502.74e46018@imammedo.users.ipa.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613150502.74e46018@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 13/6/23 15:05, Igor Mammedov wrote:
> On Tue, 13 Jun 2023 13:07:17 +0200 (CEST)
> BALATON Zoltan <balaton@eik.bme.hu> wrote:
> 
>> On Tue, 13 Jun 2023, Michael S. Tsirkin wrote:
>>> On Tue, Jun 13, 2023 at 09:46:53AM +0200, Bernhard Beschow wrote:
>>>> On Mon, Jun 12, 2023 at 3:01 PM Igor Mammedov <imammedo@redhat.com> wrote:
>>>>
>>>>      On Sun, 11 Jun 2023 12:33:59 +0200
>>>>      Bernhard Beschow <shentey@gmail.com> wrote:
>>>>   
>>>>     > Fixes the following clangd warning (-Winitializer-overrides):
>>>>     >
>>>>     >   q35.c:297:19: Initializer overrides prior initialization of this
>>>>      subobject
>>>>     >   q35.c:292:19: previous initialization is here
>>>>     >
>>>>     > Settle on native endian which causes the least overhead.
>>>>      indeed it doesn't matter which way we read all ones, so that should work.
>>>>      but does it really matter (I mean the overhead/what workload)?
>>>>      If not, I'd prefer explicit LE as it's now to be consistent
>>>>      the the rest of memops on Q35.

Meaning trying to optimize this single MR on big-endian is irrelevant :)

>>>>
>>>> I got a comment from Michael about this in [1], so I've changed it. I don't
>>>> mind changing it either way.
>>>>
>>>> Best regards,
>>>> Bernhard
>>>>
>>>> [1] https://patchew.org/QEMU/20230214131441.101760-1-shentey@gmail.com/
>>>> 20230214131441.101760-3-shentey@gmail.com/#
>>>> 20230301164339-mutt-send-email-mst@kernel.org
>>>
>>> Hmm it's not terribly important, and the optimization is trivial,
>>> but yes people tend to copy code, good point. Maybe add a comment?
>>> /*
>>> * Note: don't copy this!  normally use DEVICE_LITTLE_ENDIAN. This only
>>> * works because we don't allow writes and always read all-ones.
>>> */
>>
>> Why don't you leave DEVICE_LITTLE_ENDIAN and remove DEVICE_NATIVE_ENDIAN
>> instead? If this only returns all 1s then it does not matter and also
>> DEVICE_LITTLE_ENDIAN was the last assignment so likely that was effective
>> so far anyway.
> 
> I'm in favor of this as well,
> the 'optimization' and then piling comments on top to clarify confusion
> should be justified by usefulness of it (no perf numbers/usecase were present so far).
> In absence of above, I'd prefer real hw behavior (LE in this case).

