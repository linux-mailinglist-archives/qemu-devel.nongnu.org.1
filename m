Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC7744702
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUH0-0004dn-HT; Sat, 01 Jul 2023 02:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFUGy-0004dW-7n; Sat, 01 Jul 2023 02:39:56 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFUGw-0001JM-Bq; Sat, 01 Jul 2023 02:39:55 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1b0748bc78dso1675492fac.0; 
 Fri, 30 Jun 2023 23:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688193592; x=1690785592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cA55PiZF8Hdq6XyIvRHB4iehf3DlV+NvehQgt8nVdI=;
 b=ZW9NuAXo5ccv9MkrynQKTi309tzBU+j/r49hqREBWbIal4oERJ0GeSRAiebNc2KXrc
 oh+DngrOG5QemuoNETD36j/oIkE7fc31GJaGXaD4UCuMZPreUA/9o2ug4OIKtVuKotDS
 Wel0BZxlJ0l0tjYt7i+c2255Zsx2GQGcgzj+LF4SX8hUBzSrDtTLt6vB6LSrDOvmPFyL
 ukxRT3QQ+md0HQW/Xan+buR5tUjiP6g7gn+sAQX3V+yJffvxpz5Vk5blKOhuIUncscwY
 Hphb19/YSsFGETdITWQQJvEzfwN5Ks97NoPmg6XAjrxJpNqnmgrKvf2RM96lPCmMNZl0
 Xziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688193592; x=1690785592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cA55PiZF8Hdq6XyIvRHB4iehf3DlV+NvehQgt8nVdI=;
 b=NYdd/Ov+rBoEwHfdSm1tbkQrH1xi8nDn0nIOqrvMrBm0hLzPjcfxj63POaVwQ4724c
 HrNdMQ6n5jQ8GYvwvhqyc478OzFD3ezYIAMZJRa+EuKMSykoDaKRBCV2+YZQE/80lC4o
 Ot6MiZS50dgRg2meYFKhrRhIqSjVsdeZYkLpzS4TrBMvA/KEpHTbLLCu386YA/FxTSs7
 dfvHp9Qmf8jsmrYvtC1iDN/CF/slIq9MS4KtxiIE+8aPbxD4gLzgmg4bJosPsk0pCVFQ
 il8IGnO9+LAkPynNUhCtf2a8Eb5Hiw389+90ydzKOZkJ7WI8Z1EeoMLof+GPgrIXkENQ
 2aRw==
X-Gm-Message-State: AC+VfDwG1uNcxch55ondBIB8uTHE0mZ9h+RM5PXYlQVRlaW2NI1hz6VU
 pQluEaYqBUcEv76KL/byGnE=
X-Google-Smtp-Source: ACHHUZ402gCJsAP12NlD8wv5DktSRUhdgo/6Ji3n9nxl6lf5LyLjeqhBTm60uOq6PwmVKxDU4HOY1A==
X-Received: by 2002:a05:6870:a909:b0:1ad:1637:ee30 with SMTP id
 eq9-20020a056870a90900b001ad1637ee30mr4838124oab.19.1688193591941; 
 Fri, 30 Jun 2023 23:39:51 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 v41-20020a056870b52900b001b053e47bb3sm6472577oap.43.2023.06.30.23.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 23:39:51 -0700 (PDT)
Message-ID: <03e0c0c0-d3e5-bc4c-6c07-db642d2e6f52@gmail.com>
Date: Sat, 1 Jul 2023 03:39:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 00/14] Misc clean ups to target/ppc exception handling
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <92e3591e-cce7-c3e7-7d73-a0bd24de8c2c@gmail.com>
 <1726bfcd-0e6e-0a72-bc97-be7a79f95340@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <1726bfcd-0e6e-0a72-bc97-be7a79f95340@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x33.google.com
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



On 6/30/23 19:57, BALATON Zoltan wrote:
> On Fri, 30 Jun 2023, Daniel Henrique Barboza wrote:
>> Patches 1, 2, 3, 5, 7 and 11 are queued.
>>
>> If you would be so kind to get the remaining patches, rebase them
>> on top of my ppc-next and resend, I believe there's more stuff
>> to be queued.
> 
> Thanks for taking care of these. I'll do the rebase of remaining patches once the current queue is merged, they aren't urgent so I can come back to those later. I'm working on some sam460ex patches but don't know yet when can I send it so don't wait for me now.

Got it. Just bear in mind the current release schedule. Code freeze is July 11th:

https://wiki.qemu.org/Planning/8.1

I'll send one last PR before freeze (probably on July 10th) and then it'll be only
bug fixes until end of August.


Thanks,

Daniel

> 
> Regards,
> BALATON Zoltan
> 
>>
>>
>> Thanks,
>>
>>
>> Daniel
>>
>> On 6/15/23 20:03, BALATON Zoltan wrote:
>>> These are some small clean ups for target/ppc/excp_helper.c trying to
>>> make this code a bit simpler. No functional change is intended.
>>>
>>> v2: Patch 3 changes according to review, added tags
>>> v3: Address more review comments: don't change cpu_interrupt_exittb()
>>> parameter, add back lev, add scv patch from Nick + add some more
>>> patches to clean up #ifdefs
>>>
>>> Regards,
>>> BALATON Zoltan
>>>
>>> BALATON Zoltan (13):
>>>    target/ppc: Remove some superfluous parentheses
>>>    target/ppc: Remove unneeded parameter from powerpc_reset_wakeup()
>>>    target/ppc: Move common check in exception handlers to a function
>>>    target/ppc: Use env_cpu for cpu_abort in excp_helper
>>>    target/ppc: Remove some more local CPUState variables only used once
>>>    target/ppc: Readability improvements in exception handlers
>>>    target/ppd: Remove unused define
>>>    target/ppc: Fix gen_sc to use correct nip
>>>    target/ppc: Simplify syscall exception handlers
>>>    target/ppc: Get CPUState in one step
>>>    target/ppc: Clean up ifdefs in excp_helper.c, part 1
>>>    target/ppc: Clean up ifdefs in excp_helper.c, part 2
>>>    target/ppc: Clean up ifdefs in excp_helper.c, part 3
>>>
>>> Nicholas Piggin (1):
>>>    target/ppc: Move patching nip from exception handler to helper_scv
>>>
>>>   target/ppc/cpu.h         |   1 +
>>>   target/ppc/excp_helper.c | 570 ++++++++++++---------------------------
>>>   target/ppc/translate.c   |  15 +-
>>>   3 files changed, 178 insertions(+), 408 deletions(-)
>>>
>>
>>

