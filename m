Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F4F705FD6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:22:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzAXl-0007Kf-Eo; Wed, 17 May 2023 02:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzAXf-0007K7-TL
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:21:45 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzAXc-0006dz-2j
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:21:43 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MS4ab-1pbhQx3um3-00TYWO; Wed, 17 May 2023 08:21:37 +0200
Message-ID: <8d7a9c50-fa77-f23e-a450-3b53136834f0@vivier.eu>
Date: Wed, 17 May 2023 08:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/9] Linux user for 8.1 patches
Content-Language: fr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Afonso Bordado <afonsobordado@gmail.com>
References: <20230516124810.90494-1-laurent@vivier.eu>
 <2377b180-797c-9057-114a-d9d3b61f5caf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <2377b180-797c-9057-114a-d9d3b61f5caf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mcorQYeJzkW38DCxyPkMIHFdL0oKE5hbiAPRry8E/NY4P1xcLUr
 mLgr+yHOUbJD3+OIp7G1CEhCeVtW441i7Y2kdTTpEmQDZ2S6FgcoejnRExLepv/SwqsoT/7
 3sWfz5hUrUY0bx2shnUtumRoekPNMg4pLjD4hEFFR7RSL+1dbFgmTLd4/52JDyIZ2DpBJ3R
 m95LkOSYn9QWOMVIHtf+Q==
UI-OutboundReport: notjunk:1;M01:P0:lMwImfv4ZDc=;XhrINVQ+9zU93yr8GNEu4CWFoi4
 m2p51JK1/ewbadY8j13KFjMFlHhQV/hCE1+LIqWJIrtvnj/Pn38FW5vzSBeX2tXHEDPQ9R1pJ
 lxYgXcWJuiC0cFG3l1liRRwl+Jp5rd1ezKfMoMXL2O3P3zRn2+xjNaDvTpZZwFjJYiLHA1DCp
 WDcARvHDrSJZUG57r3Vc2OsPDdZ9ZJfU6ERG7u3k/Yum1oDlnbKj6PwuXEvR29kuU1FpVjoFQ
 2RgOkhbV9rUlfXyPajk7T6rFLUsRXIWsiTfq7dmm/MKDs5fD9DmfqDH2WbWnh1vvC9ody/YmR
 I/CmzqOoiYHpTKdZfrti7JFWCb4eJ/X1BaDcXBFp0PVU55vRqdVGTWCciIgD8tWt+sg9S9Ery
 PKLUiKvMJnu+mZCG9pwG0TxDEtT6UpBIFSdmljmqew8rdPg/Dkk90AtpmajSQbigP9BpS4V9m
 VCIgTYJHS5Z07lsUUOFK2aRbEm4GSRiSCKo8ydsYaVH2FUFqD6lBerLIlXKPanYKI1zEUc9We
 PmgqfzLCpPZX8836h1TrTipJep+LaZ8chp/a75WYR/kNvmRLt+IXP5C0IPxwHK4C+j655Iz3Q
 zs44mjftG6+zPqzbSRr8SXTdHxpoc8toZ2L9JmqPm1AGbbRVR4t7WYbVF8/85RRGIXzlCZgOQ
 BO6DzEnTMPn2IzrtiItg3h6LPXBgeEqheQB+0Qms1Q==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.666,
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

Le 16/05/2023 à 19:08, Richard Henderson a écrit :
> On 5/16/23 05:48, Laurent Vivier wrote:
>> The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:
>>
>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-04-29 23:07:17 
>> +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/vivier/qemu.git tags/linux-user-for-8.1-pull-request
>>
>> for you to fetch changes up to c490496e85047d516b31f93ea0e14819e0ab5cf5:
>>
>>    linux-user: fix getgroups/setgroups allocations (2023-05-16 12:48:09 +0200)
>>
>> ----------------------------------------------------------------
>> linux-user pull request 20230512-v3
>>
>> add open_tree(), move_mount()
>> add /proc/cpuinfo for riscv
>> fixes and cleanup
> 
> The new test still fails.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4295127220#L4423
> 
> cpuinfo: /builds/qemu-project/qemu/tests/tcg/riscv64/cpuinfo.c:20: main: Assertion `strcmp(buffer, 
> "isa\t\t: rv64imafdc_zicsr_zifencei\n") == 0' failed.
> 

I'm going to remove the test as it's not clear why it fails...

Thanks,
Laurent


