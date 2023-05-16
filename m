Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D415704A57
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:20:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrnA-0003Jf-Uz; Tue, 16 May 2023 06:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afonsobordado@gmail.com>)
 id 1pyrn8-0003Es-Sd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:20:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <afonsobordado@gmail.com>)
 id 1pyrn7-0007SN-7E
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:20:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f475366522so45732275e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684232423; x=1686824423;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AiwBXP0vUWEORt+lKtRp68xgWgCl2/t8VPMd8lryUT4=;
 b=cGGIdqBAIwmCBDbK7dwgMR829AMXzr3DMIUIpR/xlnP/+j/dE0KaypN/vgg9tNBe5V
 EcG3ixYrwWMPySqkwsbiNGBO9vlkOhncLyNviK2Go5X0Zr89rj2rvxWg9E0wr0Hgk6S7
 eaC3T1peNaL8whCMMGNczVQdULXL3/ZjBmqT7pHhDiUXIxe/oLzws+MpugrE9fELfR35
 R0/I/fvu/VgZ+X/5Q2dRPo5kia5ZxehuXf9sFOcrc7Gatay8S+h0oj99DgeJnMAp9b2X
 HLAhRfl67AoGejPYcxQ4Wey+7r9jFypp4JmkYCMlTARuSnEZJLAjfrHRhMYJ5M7ikel4
 O4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684232423; x=1686824423;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AiwBXP0vUWEORt+lKtRp68xgWgCl2/t8VPMd8lryUT4=;
 b=L1bgZURJ1Kto+8Z/6JZjP+cusIxKrRWdWOiZo9VdYOlgafLne78PhGwrbmUawqFT7X
 rIJkNH2Xd0NHwoCLNKQ0l9Dow+0h5hkkp3CC6F9tjKOnQRPIeAjIOO0GK4EeptPkYs89
 /yPXfn1WLdEx1sYBecXvRQ2dw/aFc8NKZ3Y4r8EJ6sSs7uUXyqvbLaQFeJHFPNpVMOuj
 /J34Cf3fBHbwe6Llj42KjtxbVluzNIS20ysxglcl3AFMTRfHZ9dOh8JZ4NS/l3gNx7vU
 gZwX5wEy3RAVZ1HvwQiRdXz9176Gxp1SkJvYJ6TA/clrD3rN4oP49O36nP7YNOL81/0P
 6u6w==
X-Gm-Message-State: AC+VfDySjRUsnVtLT1Xx9vnUXoM9XPmBn63wtqUEv+HhzJ09KL9TnCz2
 w6FcrOpCYs0sbByCskuS+Lk=
X-Google-Smtp-Source: ACHHUZ6obbGbEXy0sm33WKJk152TBYd249wzZEsutGrLt+ugfIxuqDNEkg9iLM+lJ6A4p7yoi0US+w==
X-Received: by 2002:a1c:7212:0:b0:3f4:e4f5:1f63 with SMTP id
 n18-20020a1c7212000000b003f4e4f51f63mr10798954wmc.41.1684232422930; 
 Tue, 16 May 2023 03:20:22 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6c7b:b200:5199:78fd:6c46:a15e?
 ([2001:8a0:6c7b:b200:5199:78fd:6c46:a15e])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a7bc314000000b003f182cc55c4sm1859565wmj.12.2023.05.16.03.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 03:20:22 -0700 (PDT)
Message-ID: <ba62e65c-5ddc-ad64-6181-ffe832b50fa1@gmail.com>
Date: Tue, 16 May 2023 11:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/9] Linux user for 8.1 patches
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230515083113.107056-1-laurent@vivier.eu>
 <4a37146d-b3b7-206d-cc75-617dc2a3674a@linaro.org>
 <c05bbb2e-2739-c8c8-33c5-908a8a2c36e1@vivier.eu>
 <d36d5b46-fb6a-41bc-47e9-6a7ad0e2441f@vivier.eu>
From: Afonso Bordado <afonsobordado@gmail.com>
In-Reply-To: <d36d5b46-fb6a-41bc-47e9-6a7ad0e2441f@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=afonsobordado@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.811, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hey Laurent,

I was having some issues reproducing this bug, but that looks like a 
likely explanation!

Should I resubmit the patch with that diff applied?

Thanks!

On 5/16/2023 10:11 AM, Laurent Vivier wrote:
> Le 15/05/2023 à 17:50, Laurent Vivier a écrit :
>> Le 15/05/2023 à 15:55, Richard Henderson a écrit :
>>> On 5/15/23 01:31, Laurent Vivier wrote:
>>>> The following changes since commit 
>>>> 7c18f2d663521f1b31b821a13358ce38075eaf7d:
>>>>
>>>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into 
>>>> staging (2023-04-29 23:07:17 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://github.com/vivier/qemu.git 
>>>> tags/linux-user-for-8.1-pull-request
>>>>
>>>> for you to fetch changes up to 
>>>> 015ebc4aaa47612514a5c846b9db0d76b653b75f:
>>>>
>>>>    linux-user: fix getgroups/setgroups allocations (2023-05-14 
>>>> 18:08:04 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> linux-user pull request 20230512-v2
>>>>
>>>> add open_tree(), move_mount()
>>>> add /proc/cpuinfo for riscv
>>>> fixes and cleanup
>>>
>>> The new test in patch 1 fails:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/4285710689#L4825
>>>
>>>    TEST    cpuinfo on riscv64
>>> cpuinfo: /builds/qemu-project/qemu/tests/tcg/riscv64/cpuinfo.c:20: 
>>> main: Assertion `strcmp(buffer, "isa\t\t: 
>>> rv64imafdc_zicsr_zifencei\n") == 0' failed.
>>> timeout: the monitored command dumped core
>>> Aborted
>>> make[1]: *** [Makefile:174: run-cpuinfo] Error 134
>>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:56: 
>>> run-tcg-tests-riscv64-linux-user] Error 2
>>> make: *** Waiting for unfinished jobs....
>>>
>>>
>>> r~
>>
>> Strange, it worked for me:
>>
>> https://gitlab.com/laurent_vivier/qemu/-/jobs/4281774977#L4844
>>
>
> I think if the host has more than 12 processors there is a buffer 
> overflow.
>
> something like this can mitigate avoid the problem:
>
> diff --git a/tests/tcg/riscv64/cpuinfo.c b/tests/tcg/riscv64/cpuinfo.c
> index 296abd0a8cf9..5c2b79022e9c 100644
> --- a/tests/tcg/riscv64/cpuinfo.c
> +++ b/tests/tcg/riscv64/cpuinfo.c
> @@ -22,6 +22,7 @@ int main(void)
>              assert(strcmp(buffer, "mmu\t\t: sv48\n") == 0);
>          } else if (strstr(buffer, "uarch") != NULL) {
>              assert(strcmp(buffer, "uarch\t\t: qemu\n") == 0);
> +            break;
>          }
>      }
>
> Thanks,
> Laurent
>

