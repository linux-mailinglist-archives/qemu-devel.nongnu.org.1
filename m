Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF18704B07
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysCb-00050Q-2M; Tue, 16 May 2023 06:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pysCZ-0004zw-1B
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:46:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pysCU-0005RX-8G
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:46:42 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MsIfc-1qIBGa3joI-00tomH; Tue, 16 May 2023 12:46:35 +0200
Message-ID: <3f1b8863-e101-e7eb-bce1-3ceb70c90203@vivier.eu>
Date: Tue, 16 May 2023 12:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/9] Linux user for 8.1 patches
Content-Language: fr
To: Afonso Bordado <afonsobordado@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230515083113.107056-1-laurent@vivier.eu>
 <4a37146d-b3b7-206d-cc75-617dc2a3674a@linaro.org>
 <c05bbb2e-2739-c8c8-33c5-908a8a2c36e1@vivier.eu>
 <d36d5b46-fb6a-41bc-47e9-6a7ad0e2441f@vivier.eu>
 <ba62e65c-5ddc-ad64-6181-ffe832b50fa1@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <ba62e65c-5ddc-ad64-6181-ffe832b50fa1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:m30RDYze74/hGZRn2p9OHfovFihgiP2eGhTCMO2DnncurRNq5Wh
 37zrwhrw1sB0qYe14bzZyaDYoz8DHCL5mfBEeLVNo3u0erq9JN4RnskJnENnGh2Gi/kGGXi
 3RgukVwv4Z7rEm4kBQ0mL9ARf0HalxyUgCjZMlIp3QDIzBszY1ZVyEYoHNiYuDjQKdv5+YQ
 oplzgH/GEjn4dsLX7mZpg==
UI-OutboundReport: notjunk:1;M01:P0:b3rYmo5+cjY=;3t19FZ4vm8onZ51Ezfac0WdQQoc
 Wkd8jBpTm7623bwFBAQZhBYA95skw+EwnIOX88OcOOHJrN1jFCAkBdCsiyOJAgwmdULk63bHD
 ifsmGMxje1IzszXUz4veMrBvmute1tXWX9lqECA5JzHWqNAKkuYbDqOj0mG31LGbx9UCWmUqO
 Vk4ZcDljkMWftviKMqOb4wz6euEb5Uidva9ovEVT774JOWW1XK0MboVie5d2zL8tVuBCp+dRR
 YKNJ63EcQMTwQ0wRD+FBHoilUyuZIkOSJDR9s68SIvS8XJqlFMinnnD14lxsBU2UB1IROKJes
 6O8h33YT+whAQjhi2ow26J1q2qTp4T9eCceDbF9XnPY8yGpLkWIrGzsYC5mUR2teG14Icj1+b
 2AUxOQDhoaMJ1kwJiCy2NfTRyRItiSn+K4MA7igXzkBmHYdOrnd9gIWCCV7dmIXP5zgrisrUr
 x9fi0CBq5wqzPfW+flWZXG/bPSjshW05cq+E1IdkcaO3ysfW+q2xYrpvXcI3o441kAD3jxJHs
 jPO3YJan/uuOzB90xp7AsLdVs0NgtHOOdkRYL3O18HKfAKA8QZoaj+FZv+qQtkNuRgvIiBrok
 Kl5N1V79QWIzM1kCbsLKNyMyO9qcJ+kdR99Xbjt+YuynMhuKcp2bhWLAlEnVq1J57hII6vunq
 aG4fumeyTix/KQ7vdK9+OLusar6s+D9VvhMrdSW3Sg==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.666,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 16/05/2023 à 12:20, Afonso Bordado a écrit :
> Hey Laurent,
> 
> I was having some issues reproducing this bug, but that looks like a likely explanation!
> 
> Should I resubmit the patch with that diff applied?

No, I'm going to update it.

Thanks,
Laurent

> 
> Thanks!
> 
> On 5/16/2023 10:11 AM, Laurent Vivier wrote:
>> Le 15/05/2023 à 17:50, Laurent Vivier a écrit :
>>> Le 15/05/2023 à 15:55, Richard Henderson a écrit :
>>>> On 5/15/23 01:31, Laurent Vivier wrote:
>>>>> The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:
>>>>>
>>>>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-04-29 
>>>>> 23:07:17 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>    https://github.com/vivier/qemu.git tags/linux-user-for-8.1-pull-request
>>>>>
>>>>> for you to fetch changes up to 015ebc4aaa47612514a5c846b9db0d76b653b75f:
>>>>>
>>>>>    linux-user: fix getgroups/setgroups allocations (2023-05-14 18:08:04 +0200)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> linux-user pull request 20230512-v2
>>>>>
>>>>> add open_tree(), move_mount()
>>>>> add /proc/cpuinfo for riscv
>>>>> fixes and cleanup
>>>>
>>>> The new test in patch 1 fails:
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/4285710689#L4825
>>>>
>>>>    TEST    cpuinfo on riscv64
>>>> cpuinfo: /builds/qemu-project/qemu/tests/tcg/riscv64/cpuinfo.c:20: main: Assertion 
>>>> `strcmp(buffer, "isa\t\t: rv64imafdc_zicsr_zifencei\n") == 0' failed.
>>>> timeout: the monitored command dumped core
>>>> Aborted
>>>> make[1]: *** [Makefile:174: run-cpuinfo] Error 134
>>>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:56: 
>>>> run-tcg-tests-riscv64-linux-user] Error 2
>>>> make: *** Waiting for unfinished jobs....
>>>>
>>>>
>>>> r~
>>>
>>> Strange, it worked for me:
>>>
>>> https://gitlab.com/laurent_vivier/qemu/-/jobs/4281774977#L4844
>>>
>>
>> I think if the host has more than 12 processors there is a buffer overflow.
>>
>> something like this can mitigate avoid the problem:
>>
>> diff --git a/tests/tcg/riscv64/cpuinfo.c b/tests/tcg/riscv64/cpuinfo.c
>> index 296abd0a8cf9..5c2b79022e9c 100644
>> --- a/tests/tcg/riscv64/cpuinfo.c
>> +++ b/tests/tcg/riscv64/cpuinfo.c
>> @@ -22,6 +22,7 @@ int main(void)
>>              assert(strcmp(buffer, "mmu\t\t: sv48\n") == 0);
>>          } else if (strstr(buffer, "uarch") != NULL) {
>>              assert(strcmp(buffer, "uarch\t\t: qemu\n") == 0);
>> +            break;
>>          }
>>      }
>>
>> Thanks,
>> Laurent
>>


