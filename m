Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA67442F8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFKAM-00058f-JM; Fri, 30 Jun 2023 15:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFKAK-00057w-Dq; Fri, 30 Jun 2023 15:52:24 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFKAI-0004oL-Ll; Fri, 30 Jun 2023 15:52:24 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-56347da4a50so1503428eaf.2; 
 Fri, 30 Jun 2023 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688154741; x=1690746741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vU+0ru5ZA9rjC66UurAC56J5Gt0lL+/hcBbnl05z5wo=;
 b=E9RTBg5U7X4HCg/634ZGx8rQX2Adxac8WVGtcJDhpwbSxUnwO0naWAxQsraXT3LV2Z
 6E2g/Gq/rzwuNQB/IU3RybVq3w0xYAOgX8JRUPdQP+uMlTywo3ceUc74u+U/OlvrQljY
 bPJ5zCHSR2FWURThcHuem2ojl5bubnqaJ15L1bK3JZ+UUOGQW6CAb3QyuUNyL4cTKt29
 RprQEyXll+89p634XpzCfoCkzw0ZOg6GVajv//9oCmStQUCzBIk5SpZJr/HkFvgTs/s6
 jwc2XixLsO2aM4mt8EnGPIGokt0ljkf7OECXWDAANTOGS+t7pGt+Gq9DL4xcmrGnXmBT
 FT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688154741; x=1690746741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vU+0ru5ZA9rjC66UurAC56J5Gt0lL+/hcBbnl05z5wo=;
 b=CEbxIaxZ2WSjvO1ziv5xBs8OGyFA6qpX9+sKMwsQmZOedNvVtifX+WmUIcJNEAqTQI
 CSad+1jCcpntqPhQmrBUsRWciFjwzXLy1VkZXcRkzfCUfJwQ7jl6QbNzqkZAUpWNf8f5
 ykXV64w13L65u37YV5OTm8YxJvKtIeQo78ma1m5axLfVjjZ2M09QhfqL+B0vSoWVddCP
 ATTEXLQ9kRCIIF2Fc9/50x8V4zVy742gTYnmupaLd2TlwdRklZ9Oc87tani2Rz2WUEpK
 Ze1wF/GlAjvWfgcq+u8y1eoXTuPeJ7HtKl8Fi3gkz9slwYwfthFa8ISQ2KaehFxY7Mpz
 n0tQ==
X-Gm-Message-State: AC+VfDwzy6Hjy8ppD+IWkt1FSJb8ge5kzBz6qsdL0EWCveOf+jfTrcGj
 zYEdkXg1iRxqYub1N5kyIRfZdM6+d+I=
X-Google-Smtp-Source: ACHHUZ6Mt/3zLHbmyjEfrW5id4Egxl1XZLbGhK6zVkAjdFkDYxveJacS4Z2LUVUbv11+gz8aCzDC+w==
X-Received: by 2002:a05:6808:1884:b0:3a1:e200:fdfd with SMTP id
 bi4-20020a056808188400b003a1e200fdfdmr4270906oib.46.1688154741232; 
 Fri, 30 Jun 2023 12:52:21 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 e17-20020a056808149100b003a392bd501csm155159oiw.20.2023.06.30.12.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:52:20 -0700 (PDT)
Message-ID: <92e3591e-cce7-c3e7-7d73-a0bd24de8c2c@gmail.com>
Date: Fri, 30 Jun 2023 16:52:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 00/14] Misc clean ups to target/ppc exception handling
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <cover.1686868895.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <cover.1686868895.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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

Zoltan,


Patches 1, 2, 3, 5, 7 and 11 are queued.

If you would be so kind to get the remaining patches, rebase them
on top of my ppc-next and resend, I believe there's more stuff
to be queued.



Thanks,


Daniel

On 6/15/23 20:03, BALATON Zoltan wrote:
> These are some small clean ups for target/ppc/excp_helper.c trying to
> make this code a bit simpler. No functional change is intended.
> 
> v2: Patch 3 changes according to review, added tags
> v3: Address more review comments: don't change cpu_interrupt_exittb()
> parameter, add back lev, add scv patch from Nick + add some more
> patches to clean up #ifdefs
> 
> Regards,
> BALATON Zoltan
> 
> BALATON Zoltan (13):
>    target/ppc: Remove some superfluous parentheses
>    target/ppc: Remove unneeded parameter from powerpc_reset_wakeup()
>    target/ppc: Move common check in exception handlers to a function
>    target/ppc: Use env_cpu for cpu_abort in excp_helper
>    target/ppc: Remove some more local CPUState variables only used once
>    target/ppc: Readability improvements in exception handlers
>    target/ppd: Remove unused define
>    target/ppc: Fix gen_sc to use correct nip
>    target/ppc: Simplify syscall exception handlers
>    target/ppc: Get CPUState in one step
>    target/ppc: Clean up ifdefs in excp_helper.c, part 1
>    target/ppc: Clean up ifdefs in excp_helper.c, part 2
>    target/ppc: Clean up ifdefs in excp_helper.c, part 3
> 
> Nicholas Piggin (1):
>    target/ppc: Move patching nip from exception handler to helper_scv
> 
>   target/ppc/cpu.h         |   1 +
>   target/ppc/excp_helper.c | 570 ++++++++++++---------------------------
>   target/ppc/translate.c   |  15 +-
>   3 files changed, 178 insertions(+), 408 deletions(-)
> 

