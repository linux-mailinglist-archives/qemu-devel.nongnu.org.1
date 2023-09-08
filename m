Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22289798B7D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qefHJ-0004tp-OV; Fri, 08 Sep 2023 13:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qefHG-0004tG-6T
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:28:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qefHD-0007qN-Ey
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:28:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CC9CC2034F;
 Fri,  8 Sep 2023 20:29:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 37A2B26BF2;
 Fri,  8 Sep 2023 20:28:11 +0300 (MSK)
Message-ID: <82a5958c-df08-f977-7859-4a14955957c4@tls.msk.ru>
Date: Fri, 8 Sep 2023 20:28:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
 <ZPtW4PXsVTo83IpN@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZPtW4PXsVTo83IpN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

08.09.2023 20:16, Kevin Wolf:
> Am 08.09.2023 um 18:11 hat Philippe Mathieu-Daudé geschrieben:
>> Hi Kevin,
>>
>> On 8/9/23 17:01, Kevin Wolf wrote:
>>> Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
>>>> Applied, thanks.
>>>>
>>>> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
>>>
>>> Something in this has broken the build for me, it seems to be the
>>> linux-user binary that doesn't link any more:
>>>
>>>     /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
>>>     /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: undefined reference to `kvm_arch_get_supported_cpuid'
>>
>> My patches. I can not reproduce so far,
> 
> Hm, ok. I can try to bisect it further then.

     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
...
             if ((*ebx & CPUID_7_0_EBX_SGX) &&
                 (!kvm_enabled() ||
                  !(kvm_arch_get_supported_cpuid(cs->kvm_state, 0x7, 0, R_EBX) &
                     CPUID_7_0_EBX_SGX))) {
                 *ebx &= ~CPUID_7_0_EBX_SGX;
             }

             if ((*ecx & CPUID_7_0_ECX_SGX_LC) &&
                 (!(*ebx & CPUID_7_0_EBX_SGX) || !kvm_enabled() ||
                  !(kvm_arch_get_supported_cpuid(cs->kvm_state, 0x7, 0, R_ECX) &
                     CPUID_7_0_ECX_SGX_LC))) {
                 *ecx &= ~CPUID_7_0_ECX_SGX_LC;
             }

It is most likely patch "target/i386: Remove unused KVM stubs" which removed
kvm_arch_get_supported_cpuid().  Apparently clang isn't smart enough to eliminate
call to this function?

/mjt

