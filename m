Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778E7048B6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqiW-0004aX-TH; Tue, 16 May 2023 05:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyqiO-0004aI-Vi
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:11:29 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyqiN-0008PT-2H
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:11:28 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MZSym-1pdOEm2wZa-00WYBz; Tue, 16 May 2023 11:11:22 +0200
Message-ID: <d36d5b46-fb6a-41bc-47e9-6a7ad0e2441f@vivier.eu>
Date: Tue, 16 May 2023 11:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/9] Linux user for 8.1 patches
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Afonso Bordado <afonsobordado@gmail.com>
References: <20230515083113.107056-1-laurent@vivier.eu>
 <4a37146d-b3b7-206d-cc75-617dc2a3674a@linaro.org>
 <c05bbb2e-2739-c8c8-33c5-908a8a2c36e1@vivier.eu>
In-Reply-To: <c05bbb2e-2739-c8c8-33c5-908a8a2c36e1@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8OOlBrMFl5Tp3MG9jjPm/o9XRh7gv8Cpy8aKWGXg2mRQjRmJ86X
 MxuziVwReKzobY+ZGD8p42EMQBpX8zG4cgpW6OpnwKPQAGndbcp0TQClor06dzJ+HPC2Rdg
 YdGA3ZAo7W4xL49jlybC+XyvYyPC8FK5eP3vC5VEyN0eJJxE2inbExhjkhOwrsVl7sfoxOH
 cfOVoiiGlzIlU8DuaOV+A==
UI-OutboundReport: notjunk:1;M01:P0:GZWTS181OwY=;A4319GvlnjkDCwCxQgy5f+NrtMi
 wfMcz7X0eoylWFRI/VOuCqI622awHzRMvPchFcbTXJxb3VWklEl07puU+iJ9J9k4xRLFE7Woa
 Bjq2iyxykeE9Yboa3+3psWbKV/f1IeBatblHyQ1eoJgPx3tQTXXru1lFPVYCFOVqS8bYVyZIO
 h0l07149ASMBisH7bh4d+2CRpIx+OPmSvKiLkV2QwbggKiwVs56FuTHvNZuP2mUbDYWdKdzQs
 m1qTl+BShPiOo7C7Vb/Iah+wGycNNj3j3zEi07lEsJ950gpBXyaAKvdQJBOW2af0XBBYKEZTQ
 GzQ6Ndp0/NWidHc6j9amKr9D7bS/myStwtiVAuDrVNhWbJSMGcyNcTHqO2zi+C/GbRN35iTpb
 KC4josyHN70lJnJ2JRyAbHsZ3hkgti3g9VEuGm4PbAt4Q+PzOBGHjfSFcOQrYd+vOzD7wN/2X
 +76p3MiUYYYkaZ9LGWb3qizn1Ad12DGZqf348y81j8TWMNGYguhoS+Y2GHZMzlV/00aaJa/dZ
 YPBkeYY35vu+YDVIoefcQN377dBcDcau7S2dkOBIZruo8GyD/bjmXt2b0sKc6U2Q3j/609Dyt
 Sn7yr8xOFkfsFL5gBJ6apajdF6dFhZKhsOX57U/+/NmDpwn7khOgin7oUFagk2HS5z/pV5Gaj
 gROFrjIusSzAABKhmcyT79KrzSdtkm+dat742hLfQw==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 15/05/2023 à 17:50, Laurent Vivier a écrit :
> Le 15/05/2023 à 15:55, Richard Henderson a écrit :
>> On 5/15/23 01:31, Laurent Vivier wrote:
>>> The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:
>>>
>>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-04-29 23:07:17 
>>> +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/vivier/qemu.git tags/linux-user-for-8.1-pull-request
>>>
>>> for you to fetch changes up to 015ebc4aaa47612514a5c846b9db0d76b653b75f:
>>>
>>>    linux-user: fix getgroups/setgroups allocations (2023-05-14 18:08:04 +0200)
>>>
>>> ----------------------------------------------------------------
>>> linux-user pull request 20230512-v2
>>>
>>> add open_tree(), move_mount()
>>> add /proc/cpuinfo for riscv
>>> fixes and cleanup
>>
>> The new test in patch 1 fails:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4285710689#L4825
>>
>>    TEST    cpuinfo on riscv64
>> cpuinfo: /builds/qemu-project/qemu/tests/tcg/riscv64/cpuinfo.c:20: main: Assertion `strcmp(buffer, 
>> "isa\t\t: rv64imafdc_zicsr_zifencei\n") == 0' failed.
>> timeout: the monitored command dumped core
>> Aborted
>> make[1]: *** [Makefile:174: run-cpuinfo] Error 134
>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:56: run-tcg-tests-riscv64-linux-user] 
>> Error 2
>> make: *** Waiting for unfinished jobs....
>>
>>
>> r~
> 
> Strange, it worked for me:
> 
> https://gitlab.com/laurent_vivier/qemu/-/jobs/4281774977#L4844
> 

I think if the host has more than 12 processors there is a buffer overflow.

something like this can mitigate avoid the problem:

diff --git a/tests/tcg/riscv64/cpuinfo.c b/tests/tcg/riscv64/cpuinfo.c
index 296abd0a8cf9..5c2b79022e9c 100644
--- a/tests/tcg/riscv64/cpuinfo.c
+++ b/tests/tcg/riscv64/cpuinfo.c
@@ -22,6 +22,7 @@ int main(void)
              assert(strcmp(buffer, "mmu\t\t: sv48\n") == 0);
          } else if (strstr(buffer, "uarch") != NULL) {
              assert(strcmp(buffer, "uarch\t\t: qemu\n") == 0);
+            break;
          }
      }

Thanks,
Laurent


