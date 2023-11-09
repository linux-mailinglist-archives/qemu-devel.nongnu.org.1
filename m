Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02DA7E6C93
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:44:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16F2-0008C6-Sm; Thu, 09 Nov 2023 09:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r16F0-0008Bi-H7
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:42:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r16Ey-0000MH-PR
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:42:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so7902445ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699540959; x=1700145759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BU/2Tm5IJQo8WQ+D9/H4U7J+F1ejivNnReQmp/7v34s=;
 b=h5bYWjQk9ssgRtsnWk7rcc0gNVoBd+svPB6mPhqAwhpiEaKnR+wKsLEEMddtiON5eG
 DUFNtFmhO/TZWo77prpH64tRbExPFkH+WS2y/hyOzA+IV/p2KpvB3qBc/tovf3o18ihA
 4BHkSnJ2KbaZ13nZ9eyLpxv99FdQEUYS434XQtgfAHO/y8cgI5+guBqvu17nCVL3fyOV
 GJX/5BYrx/eQ6oBVpMm7KnWlyF0xk6pkHKy4SuYZVBw3/DuP5fYiLOtZQ7NRzaVvCkZU
 WqjjfdRq/gdZpVbWKkwj+wineJb6l8YTgPuclOq27OYEGAI/cHAgkpAvI9W0Iz32kZSh
 Td+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699540959; x=1700145759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BU/2Tm5IJQo8WQ+D9/H4U7J+F1ejivNnReQmp/7v34s=;
 b=pRDKrpmvmgyaojf37pwKiQ8UWmZnN+7pqG1l3QAzh8nqJA9c+MGkfCeQVedVTR6shp
 RFJgV3IWYLxNhBLtBxNOzWZB7YDSzVx0S9OH6b1m2CZM+99u+8Px4xvtFyQhLbxfb7O/
 XiwlxpydtnuJyqu9KEjF4wNDYNHpXbs/J2gG2k4BftxuAaZzoA+y0t6NMf8K54YtPynz
 bN3zndzb3taBw6sWX28T6qtFgXDDYiGfWZmk/8Qnbary1Dt/zqjYyd/j/5bcYK0INusV
 7u2F8lY00UigElmGmIDULI/q4x1gbW+gC8O+I1O+N1f45LnxeGBp8+0ZqaBb/cVsPLxV
 anFg==
X-Gm-Message-State: AOJu0YzWQDoPw06F0t+6iBbWn25Kh7KmdY35bw193/vdqgdQrDqkjFcE
 C5r4MIUbd7GpDtiqiDarV7cy6SHR0Ycnjg==
X-Google-Smtp-Source: AGHT+IGidJdzcsZd/wu2ALDgnNw3mh+Q1uzu7glIlXXS4ZEBspXmpIjixNxrixDmX7gtgNJQVQfpWA==
X-Received: by 2002:a17:902:ce01:b0:1cc:3daa:d368 with SMTP id
 k1-20020a170902ce0100b001cc3daad368mr6246421plg.65.1699540958650; 
 Thu, 09 Nov 2023 06:42:38 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:b178:6138:397c:2ce7?
 ([2001:ee0:50f4:9050:b178:6138:397c:2ce7])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1709027e8700b001b7f40a8959sm3688022pla.76.2023.11.09.06.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 06:42:38 -0800 (PST)
Message-ID: <7a56029c-8637-4abd-a38f-7b838a059749@gmail.com>
Date: Thu, 9 Nov 2023 21:42:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] Support x2APIC mode with TCG accelerator
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Phil Dennis-Jordan <lists@philjordan.eu>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <8bbae7b9-3923-b5cd-ff89-50baeccb5d02@amd.com>
 <1c4cf652-9b31-4b22-8bb9-df27dce74cfd@gmail.com>
 <756919c3-13ed-4fcc-a4b2-30cd431746a4@oracle.com>
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <756919c3-13ed-4fcc-a4b2-30cd431746a4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 11/9/23 21:32, Joao Martins wrote:
> On 09/11/2023 14:10, Bui Quang Minh wrote:
>> On 11/9/23 17:11, Santosh Shukla wrote:
>>> On 10/24/2023 8:51 PM, Bui Quang Minh wrote:
>>>> Hi everyone,
>>>>
>>>> This series implements x2APIC mode in userspace local APIC and the
>>>> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
>>>> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
>>>> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
>>>> using either Intel or AMD iommu.
>>>>
>>>> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
>>>> with enabled x2APIC and can enumerate CPU with APIC ID 257
>>>>
>>>> Using Intel IOMMU
>>>>
>>>> qemu/build/qemu-system-x86_64 \
>>>>     -smp 2,maxcpus=260 \
>>>>     -cpu qemu64,x2apic=on \
>>>>     -machine q35 \
>>>>     -device intel-iommu,intremap=on,eim=on \
>>>>     -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>>     -m 2G \
>>>>     -kernel $KERNEL_DIR \
>>>>     -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial
>>>> net.ifnames=0" \
>>>>     -drive file=$IMAGE_DIR,format=raw \
>>>>     -nographic \
>>>>     -s
>>>>
>>>> Using AMD IOMMU
>>>>
>>>> qemu/build/qemu-system-x86_64 \
>>>>     -smp 2,maxcpus=260 \
>>>>     -cpu qemu64,x2apic=on \
>>>>     -machine q35 \
>>>>     -device amd-iommu,intremap=on,xtsup=on \
>>>>     -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>>     -m 2G \
>>>>     -kernel $KERNEL_DIR \
>>>>     -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial
>>>> net.ifnames=0" \
>>>>     -drive file=$IMAGE_DIR,format=raw \
>>>>     -nographic \
>>>>     -s
>>>>
>>>> Testing the emulated userspace APIC with kvm-unit-tests, disable test
>>>> device with this patch
>>>>
>>>> diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
>>>> index 1734afb..f56fe1c 100644
>>>> --- a/lib/x86/fwcfg.c
>>>> +++ b/lib/x86/fwcfg.c
>>>> @@ -27,6 +27,7 @@ static void read_cfg_override(void)
>>>>
>>>>           if ((str = getenv("TEST_DEVICE")))
>>>>                   no_test_device = !atol(str);
>>>> +       no_test_device = true;
>>>>
>>>>           if ((str = getenv("MEMLIMIT")))
>>>>                   fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
>>>>
>>>> ~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
>>>> ./run_tests.sh -v -g apic
>>>>
>>>> TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
>>>> -cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
>>>> apic-split (54 tests, 8 unexpected failures, 1 skipped)
>>>> TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
>>>> 1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
>>>> TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
>>>> qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
>>>> 1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
>>>> 2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
>>>> 6 unexpected failures, 2 skipped)
>>>>
>>>>     FAIL: apic_disable: *0xfee00030: 50014
>>>>     FAIL: apic_disable: *0xfee00080: f0
>>>>     FAIL: apic_disable: *0xfee00030: 50014
>>>>     FAIL: apic_disable: *0xfee00080: f0
>>>>     FAIL: apicbase: relocate apic
>>>>
>>>> These errors are because we don't disable MMIO region when switching to
>>>> x2APIC and don't support relocate MMIO region yet. This is a problem
>>>> because, MMIO region is the same for all CPUs, in order to support these we
>>>> need to figure out how to allocate and manage different MMIO regions for
>>>> each CPUs. This can be an improvement in the future.
>>>>
>>>>     FAIL: nmi-after-sti
>>>>     FAIL: multiple nmi
>>>>
>>>> These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.
>>>>
>>>>     FAIL: TMCCT should stay at zero
>>>>
>>>> This error is related to APIC timer which should be addressed in separate
>>>> patch.
>>>>
>>>> Version 9 changes,
>>>
>>> Hi Bui,
>>>
>>> I have tested v9 on EPYC-Genoa system with kvm acceleration mode on, I could
>>> see > 255 vCPU for Linux and Windows Guest.
>>>
>>> Tested-by: Santosh Shukla <Santosh.Shukla@amd.com>
>>
>> Hi Santosh,
>>
>> With KVM enabled, you may be using the in kernel APIC from KVM not the emulated
>> APIC in userspace as in this series.
>>
> 
> Your XTSup code isn't necessarily userspace APIC specific. You can have
> accel=kvm with split irqchip and things will still work. I suspect that's how
> Santosh tested it.

Ah, I got it. Thanks Santosh, Joao.
Quang Minh.

