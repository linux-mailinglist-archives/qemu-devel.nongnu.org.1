Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC37031DD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaSh-000280-10; Mon, 15 May 2023 11:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyaSf-00025z-1z
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:50:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyaSd-0006pI-9F
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:50:08 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJEtx-1pir9k3UnD-00Kj1Y; Mon, 15 May 2023 17:50:03 +0200
Message-ID: <c05bbb2e-2739-c8c8-33c5-908a8a2c36e1@vivier.eu>
Date: Mon, 15 May 2023 17:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/9] Linux user for 8.1 patches
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Afonso Bordado <afonsobordado@gmail.com>
References: <20230515083113.107056-1-laurent@vivier.eu>
 <4a37146d-b3b7-206d-cc75-617dc2a3674a@linaro.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <4a37146d-b3b7-206d-cc75-617dc2a3674a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:871spqKQmdV4nbm8mfUW6bfBxhTzfK2mYF3I3w7MewQ9RFvN28w
 obSwfR3PzKoA6PjlchnN7+nQSfKIPVpx3GdC2T9Y9Cw8xOy9vDwJOBxW2OFnIiPqcvm9OKv
 HDuurcT0UBFbxWNGvrPOCnGRUk6IQ+eAd4rYQqTwGrEwX3b53dvxegl/KERSjkcLzOhAsk8
 H2vSKTn3s110so2GamfqA==
UI-OutboundReport: notjunk:1;M01:P0:GvSlVtP3lK4=;+mypRPZ+JBAnQBUD+YCruTeYjLO
 UeuNtqBy+JysJGMTOy9O35jEq+JFbrox3BNes6NyMBEhyWcdN+OV7V5PbnIsZ/gndpBMmATn0
 k2p3BHoFFNPSA6awmbXB9iyyu2R3j3RfzeaOZ0Ym8nEpB0s+gBq7Ux+epGqHmOFr8AvUc54cd
 ruy5UfPW1kOc1J38xBpAOyK8M9OMolnmtq5UbSSwJm28c2sXmBZlIwmYCG5fPyKWGh2CNpxdc
 NIBdfyYinieP2/4prfRizwIaoMlpmsdiFk/pecvW827oED629IJjIxrLNIwYfLHmx+Xw2Grbt
 3mzdaNLrnUprvq8GBUA/m8gcNYTq/GWuoYELT1GB49k6JhiwgUCrMh02BKUMjlMOTNhvXiTAV
 u4Cte5HmMTPWol6HitOnGPI8II2Fk57mDApeaX1381K5/Vc2aqqXKJcWT9V/aQhNGK/SzMf9v
 xDgXwH3YJ3wcUo5f7QrYad6ZWdefs+1PtVD9jNxNP9A2UhMR/CYwJA1BS5yfDqsCBvMyhM2s9
 Eak2uOSMDCKTmkTsbKfIwNcKlYC931snzmTcwLn/965oe/FObJKmPpu1rxekm2zLhLFcg2O0k
 Mtj92XJb7fGMkmd+CkwaNU51i4ucvNfnsBfmW4ZxKs/SAPgVPRJYHZQw8Z359DV9V1Z5AM9mb
 /W2nIJtCvuKOAEqyH1KG8p+cUD6sgVdeQcAYdX+Ihg==
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

Le 15/05/2023 à 15:55, Richard Henderson a écrit :
> On 5/15/23 01:31, Laurent Vivier wrote:
>> The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:
>>
>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-04-29 23:07:17 
>> +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/vivier/qemu.git tags/linux-user-for-8.1-pull-request
>>
>> for you to fetch changes up to 015ebc4aaa47612514a5c846b9db0d76b653b75f:
>>
>>    linux-user: fix getgroups/setgroups allocations (2023-05-14 18:08:04 +0200)
>>
>> ----------------------------------------------------------------
>> linux-user pull request 20230512-v2
>>
>> add open_tree(), move_mount()
>> add /proc/cpuinfo for riscv
>> fixes and cleanup
> 
> The new test in patch 1 fails:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4285710689#L4825
> 
>    TEST    cpuinfo on riscv64
> cpuinfo: /builds/qemu-project/qemu/tests/tcg/riscv64/cpuinfo.c:20: main: Assertion `strcmp(buffer, 
> "isa\t\t: rv64imafdc_zicsr_zifencei\n") == 0' failed.
> timeout: the monitored command dumped core
> Aborted
> make[1]: *** [Makefile:174: run-cpuinfo] Error 134
> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:56: run-tcg-tests-riscv64-linux-user] 
> Error 2
> make: *** Waiting for unfinished jobs....
> 
> 
> r~

Strange, it worked for me:

https://gitlab.com/laurent_vivier/qemu/-/jobs/4281774977#L4844

Afonso, could you have a look?

Thanks,
Laurent

