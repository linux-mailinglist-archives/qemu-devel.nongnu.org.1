Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9021734EB6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBAcy-0004Nz-SW; Mon, 19 Jun 2023 04:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu.linux@gmail.com>)
 id 1qBAcp-0004JA-RP
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:52:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <like.xu.linux@gmail.com>)
 id 1qBAcn-0003XF-Rw
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:52:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b52132181aso13878245ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687164756; x=1689756756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o32zhHPH9dlxXlg+cTuJYce/UWbfkcquDipPvOEOnS0=;
 b=rX4AYXOcRmpTowP6pa8hgvZgRZW/8ttJaztoyr9rPMgotBNE9djJAL8t8ahcEZ9rHD
 qICpWZZ7GXIYKIPBjOT1OM8oVmAXNh/ObbesLWgk6n/ydZCGQ5A1vNnK+Cy8tdiBxXf0
 SmxpPE3Bhaf2zXOXtJIl2CGHdZsd/pb5rOfu5IKDm8er8HfBTS1NiUlS9I4s0cTlvSBa
 PktcAeV2KOx0g3jTigvthGtI4MxXuFFcXv7yMeg9ANe38m1yM9FyhtkU+hxV0+S8r4b6
 Wn7574gsL8BDvPSFwNZLYLtcqWm2f36wU54mEf1PVomCGrNa1J9zxR8L24OFrOb5grPU
 v6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687164756; x=1689756756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o32zhHPH9dlxXlg+cTuJYce/UWbfkcquDipPvOEOnS0=;
 b=PZYQQ42Ta6dUor+Cjye0nfSnCcVVNdj5rpgFJwGxA99FdQ50cSc3QZS1KVtVCRBI9M
 M65qEWjMJBrS6D0inuBKKaCLFRoMvafUjWLGONHxMwkfppZ1kup+I2OdNaNup7MBsY+1
 avgv6JRkCAABuDcoSOX5qsZCSfL3EsX9rPcB5lrjie7LuQzlGczbSXueieQRqMcCbn2Y
 pYo6QFZhcUf8j4btlETiQQkX+ICE7zbmNBDmyoSAjFjportBI64drYCwjv6GsKis7pp4
 hDL/ogJahZhIMhQFBy6LTSInH5hUPUPLiBthTECLwX6/B/lmRZN4lsEqp/221DQZ8vsx
 pODA==
X-Gm-Message-State: AC+VfDzui+WhKnLNuYQGD7I8ThSZw0qHygcZrHyMalRX89qSRf3kskpU
 rZo4qrR/6E9aXSVMcxsKiAs=
X-Google-Smtp-Source: ACHHUZ457fDHQcHQZeJbaCaNYKn6K1hwnN2BhiUC7y/R6VnJXGQlOND+/7n93OHM9VShzMn04QLVFw==
X-Received: by 2002:a17:902:ec86:b0:1b0:378e:279f with SMTP id
 x6-20020a170902ec8600b001b0378e279fmr5972089plg.19.1687164755880; 
 Mon, 19 Jun 2023 01:52:35 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.32])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a1709028c8b00b001ae0152d280sm19799901plo.193.2023.06.19.01.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 01:52:35 -0700 (PDT)
Message-ID: <36d749a2-b349-e5f4-3683-a4d595bafec9@gmail.com>
Date: Mon, 19 Jun 2023 16:52:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 0/2] target/i386/kvm: fix two svm pmu virtualization
 bugs
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, zhenyuw@linux.intel.com
Cc: pbonzini@redhat.com, mtosatti@redhat.com, joe.jin@oracle.com,
 groug@kaod.org, lyan@digitalocean.com, qemu-devel@nongnu.org,
 kvm list <kvm@vger.kernel.org>
References: <20221202002256.39243-1-dongli.zhang@oracle.com>
 <895f5505-db8c-afa4-bfb1-26ecbe27690a@oracle.com>
 <eea7b6ba-c0bd-8a1e-b2a8-2f08c954628b@oracle.com>
From: Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <eea7b6ba-c0bd-8a1e-b2a8-2f08c954628b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=like.xu.linux@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I think we've been stuck here too long. Sorry Dongli.

+zhenyu, could you get someone to follow up on this, or I will start working on 
that.

On 9/1/2023 9:19 am, Dongli Zhang wrote:
> Ping?
> 
> About [PATCH v2 2/2], the bad thing is that the customer will not be able to
> notice the issue, that is, the "Broken BIOS detected" in dmesg, immediately.
> 
> As a result, the customer VM many panic randomly anytime in the future (once
> issue is encountered) if "/proc/sys/kernel/unknown_nmi_panic" is enabled.
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> On 12/19/22 06:45, Dongli Zhang wrote:
>> Can I get feedback for this patchset, especially the [PATCH v2 2/2]?
>>
>> About the [PATCH v2 2/2], currently the issue impacts the usage of PMUs on AMD
>> VM, especially the below case:
>>
>> 1. Enable panic on nmi.
>> 2. Use perf to monitor the performance of VM. Although without a test, I think
>> the nmi watchdog has the same effect.
>> 3. A sudden system reset, or a kernel panic (kdump/kexec).
>> 4. After reboot, there will be random unknown NMI.
>> 5. Unfortunately, the "panic on nmi" may panic the VM randomly at any time.
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>> On 12/1/22 16:22, Dongli Zhang wrote:
>>> This patchset is to fix two svm pmu virtualization bugs, x86 only.
>>>
>>> version 1:
>>> https://lore.kernel.org/all/20221119122901.2469-1-dongli.zhang@oracle.com/
>>>
>>> 1. The 1st bug is that "-cpu,-pmu" cannot disable svm pmu virtualization.
>>>
>>> To use "-cpu EPYC" or "-cpu host,-pmu" cannot disable the pmu
>>> virtualization. There is still below at the VM linux side ...
>>>
>>> [    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
>>>
>>> ... although we expect something like below.
>>>
>>> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
>>> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
>>>
>>> The 1st patch has introduced a new x86 only accel/kvm property
>>> "pmu-cap-disabled=true" to disable the pmu virtualization via
>>> KVM_PMU_CAP_DISABLE.
>>>
>>> I considered 'KVM_X86_SET_MSR_FILTER' initially before patchset v1.
>>> Since both KVM_X86_SET_MSR_FILTER and KVM_PMU_CAP_DISABLE are VM ioctl. I
>>> finally used the latter because it is easier to use.
>>>
>>>
>>> 2. The 2nd bug is that un-reclaimed perf events (after QEMU system_reset)
>>> at the KVM side may inject random unwanted/unknown NMIs to the VM.
>>>
>>> The svm pmu registers are not reset during QEMU system_reset.
>>>
>>> (1). The VM resets (e.g., via QEMU system_reset or VM kdump/kexec) while it
>>> is running "perf top". The pmu registers are not disabled gracefully.
>>>
>>> (2). Although the x86_cpu_reset() resets many registers to zero, the
>>> kvm_put_msrs() does not puts AMD pmu registers to KVM side. As a result,
>>> some pmu events are still enabled at the KVM side.
>>>
>>> (3). The KVM pmc_speculative_in_use() always returns true so that the events
>>> will not be reclaimed. The kvm_pmc->perf_event is still active.
>>>
>>> (4). After the reboot, the VM kernel reports below error:
>>>
>>> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
>>> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
>>>
>>> (5). In a worse case, the active kvm_pmc->perf_event is still able to
>>> inject unknown NMIs randomly to the VM kernel.
>>>
>>> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
>>>
>>> The 2nd patch is to fix the issue by resetting AMD pmu registers as well as
>>> Intel registers.
>>>
>>>
>>> This patchset does not cover PerfMonV2, until the below patchset is merged
>>> into the KVM side.
>>>
>>> [PATCH v3 0/8] KVM: x86: Add AMD Guest PerfMonV2 PMU support
>>> https://lore.kernel.org/all/20221111102645.82001-1-likexu@tencent.com/
>>>
>>>
>>> Dongli Zhang (2):
>>>        target/i386/kvm: introduce 'pmu-cap-disabled' to set KVM_PMU_CAP_DISABLE
>>>        target/i386/kvm: get and put AMD pmu registers
>>>
>>>   accel/kvm/kvm-all.c      |   1 +
>>>   include/sysemu/kvm_int.h |   1 +
>>>   qemu-options.hx          |   7 +++
>>>   target/i386/cpu.h        |   5 ++
>>>   target/i386/kvm/kvm.c    | 129 +++++++++++++++++++++++++++++++++++++++++-
>>>   5 files changed, 141 insertions(+), 2 deletions(-)
>>>
>>> Thank you very much!
>>>
>>> Dongli Zhang
>>>
>>>
> 
> 

