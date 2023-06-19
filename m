Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D664B735CB5
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBIHU-0007es-I3; Mon, 19 Jun 2023 13:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBIHR-0007eJ-Tf
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:03:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBIHO-00074H-Co
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:03:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f901f87195so18657995e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194180; x=1689786180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K17at/kt6r+0LxjfV/9MLRAJwZpbcUnsbV5xHInOpJ8=;
 b=JQo+dBbe3exZUWkQRxNzbzT72i2LVGOdNrj3ArHF7mweJYE2axyrezbtfhGY5yCoz0
 twn7feWjrdjXTnjrytCQWjB+SmMwhZ1KMKIZsXqFA0yumreIfvbGjb6gcCBicO1/TrSq
 f1jKjlRten5n82GFLwpW47b3ZuXPNDv13ebFMwiS0229QKsFbTgktodcuAJUvLbPCeAu
 jZ9Fso8eZ/uwwHWCtWW2TR3ciL4JXKQeCTc9Q4uUo7noIr7wKMfGbF3Dfh69qFP1djQv
 cd5YfR+IlsuywADuwlZ/kHM0J5KQM8LsJIKtVV0V4wgKkCOIdg/qk80xogP3Hy2Th7uT
 a13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194180; x=1689786180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K17at/kt6r+0LxjfV/9MLRAJwZpbcUnsbV5xHInOpJ8=;
 b=lnvsVyX19GorXpZBF0iVV6uv1arZ1aUDYeROuLgq58Gy/yb++g9vIrZQ81tmKzjxyn
 aKk8bWrsHhKkZpMDskj1CQTvYmcHE3Rxt7aSm1Q07zWOL1BuhPv2uv0AC1sR4cGPLPsc
 itIpW2gHEJO0PEwIdmuejiRbdaXz1eP2Uh0CCVDYULs6MaZIlF3ENAh+z4D8wKzFylnJ
 l7XsXL5b2x+Xh3fkHpglfVJdwBriHT6Dj6ps32sp29At+fWjqwMxcIJXbOhc75QnYvfv
 tBGbBspgVM+2vzK9CGhDY0BQMK0KH+fblzglZqI0k3EzbgKUgYx1KFKUA8/6MEp7mwPn
 flsA==
X-Gm-Message-State: AC+VfDy+qJnnLOXDNjGxnvkSQgDSxRXWrgFy8dy9soF9UF0m2+Qu2xsi
 1LoCChWdfbJe0a6JE2WgfpForQ==
X-Google-Smtp-Source: ACHHUZ6kvZqsNMAOiK4wzg7oSBgjEH7md49dpKNRhRypcQfCHli9C+/wwc/3McQTlv+G8In0akaxxA==
X-Received: by 2002:a05:600c:4fd2:b0:3f9:b5bb:d762 with SMTP id
 o18-20020a05600c4fd200b003f9b5bbd762mr366180wmq.9.1687194180413; 
 Mon, 19 Jun 2023 10:03:00 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 i3-20020a05600c290300b003f8140763c7sm215140wmd.30.2023.06.19.10.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 10:03:00 -0700 (PDT)
Message-ID: <8b14781d-f5e5-b5b1-90c3-2d6eae8ffdc9@linaro.org>
Date: Mon, 19 Jun 2023 19:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-2-npiggin@gmail.com>
 <CT4I52C30RXG.AESIFCY16U6T@wheely>
 <94a453bc-cfd5-5fb0-289d-dbb321c8b172@linaro.org>
 <CAFEAcA_hirbGc_iZUhsD22Ksjj_2OBevDJq-r1mvnVqKoTqCvA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_hirbGc_iZUhsD22Ksjj_2OBevDJq-r1mvnVqKoTqCvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:55, Peter Maydell wrote:
> On Mon, 19 Jun 2023 at 16:49, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 6/5/23 08:27, Nicholas Piggin wrote:
>>> On Sun Jun 4, 2023 at 8:28 PM AEST, Nicholas Piggin wrote:
>>>> Differently-sized larx/stcx. pairs can succeed if the starting address
>>>> matches. Add a size check to require stcx. exactly match the larx that
>>>> established the reservation.
>>>
>>> Hmm, question: reserve_addr is a VMSTATE field, but reserve_val is not
>>> (nor reserve_size after this patch).
>>>
>>> Blue Swirl added that with commit a456d59c20f ("VM load/save support for
>>> PPC CPU"), and when reserve_val was added in commit 18b21a2f83a
>>> ("target-ppc: retain l{w,d}arx loaded value") it did not get migrated.
>>>
>>> Could we end up with reserve_addr != -1, but with a bogus reserve_val,
>>> which could then permit a stcx. incorrectly? Not entirely outlandish if
>>> reserve_val starts out initialised to zero.
>>>
>>> Could we just clear the reserve in cpu_post_load? It is permitted to be
>>> lost for an implementation-specific reason. Doesn't seem necessary to
>>> try keep it alive over a migration.
>>
>> It's not a bad idea to flush the reservation over migrate.
> 
> Is there any particular reason to do so? The default simple
> thing is "if this is state that persists across instructions
> then migrate it"; we usually reserve "do something special in
> post-load" for oddball cases where "just copy the data" doesn't
> work.
> 
> target/arm migrates both the exclusive addr and value.

ppc is adding "size", which arm technically should have as well.

> target/mips migrates lladdr but has forgotten llval
> (and perhaps llval_wp and llnewval_wp, depending on what
> those fields do).

So, similarly, would need to handle migration for which all of the required data is not 
present.

The thought is, rather than migrate this new data also, and handle compatibility, simply 
discard all reservations.


r~


