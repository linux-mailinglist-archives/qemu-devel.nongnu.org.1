Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 523BB750B85
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 16:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJbHC-0007CM-4G; Wed, 12 Jul 2023 10:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qJbHA-0007Bn-NR
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:57:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qJbH8-0006lm-TM
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:57:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b8b2886364so46743135ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689173825; x=1691765825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5crkUarh5eDxof+qGb0EV7yFtYIsjUsykHsVksb0pc=;
 b=WUguWFnt9q8DtJpvv8lCBXG1bmMCPirGdRLRzXejxXvS2gWflKc/98c2uspcvIKpcp
 82ngxi7gd45EGPcuRgo2sq0tdLKmjx4h6a+POx5BQir4i2BXlXYoJ7IkjFiploDsYImA
 lNyB0S/b4CmTepSYh97eAR3vJHzNtdpIVRJIkAus7jDfVjvpnXCfbdkbm8F+SY+QhJHz
 LhuvDneo9O/TMWCcGsOx3psGbcSxVWWKw40W+1f20yvXyofScydlWQ2iEqHLeLss/5TT
 j++wKQSkdRPHlMWaf5jr+qEuExBCeuYw2NmhtHVTppQA1XBEyO+YAeWXQN2mJk1lInEn
 Be8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689173825; x=1691765825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5crkUarh5eDxof+qGb0EV7yFtYIsjUsykHsVksb0pc=;
 b=JTGRxRDACK1RivNHJqAr62U62yLXE28nwxX6JSb+Wf2SHknop9vI7Ln070pyWAN9uU
 s4y0LfN5mivhZJaLDPxp+TXh+5HbAc8GbgbYtlXqnOqIRuGWckQPj2UtSkl5vvJ58NGE
 AiUZ+LblUBiwwGDeRtf/0i+ecUxzl6ShL0ZjlO7xwr4i5w/GnRdxaZgvReyauN+PBoKb
 P0oR/4WCa4RxY9P0Vbq295RpIyEAanhdHnY4SkfIbeaO5QRrebnYphOpR6wQ0c4mMt9W
 XpNufdQ81tL4JXeuZsXtxBTpWvwgwLnOGtL3g1KVZFXD1i9FcQ40TPd0lg9QS3C7cc5O
 iRzw==
X-Gm-Message-State: ABy/qLa8muu44URqIgcLcmdk8Q6kDTNt9rBLXwcADK4FIinOT6TU1y8J
 duBH0jd6Y6PHo2WHjlHHqNE=
X-Google-Smtp-Source: APBJJlHI4rlGAYAeBuzn0p9FLc9bBxFh4axEr1c9JPwmYkCCM5mPApRkW7/fwgBtepi8QNCmHn01Hg==
X-Received: by 2002:a17:903:110f:b0:1b0:3a74:7fc4 with SMTP id
 n15-20020a170903110f00b001b03a747fc4mr17485351plh.24.1689173824952; 
 Wed, 12 Jul 2023 07:57:04 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fb3:b780:5ea2:5564:750c:fa4e?
 ([2001:ee0:4fb3:b780:5ea2:5564:750c:fa4e])
 by smtp.gmail.com with ESMTPSA id
 ij12-20020a170902ab4c00b001b84cd8814bsm4141823plb.65.2023.07.12.07.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 07:57:04 -0700 (PDT)
Message-ID: <63d7ea3c-2a85-b594-5dcc-96b5201546f2@gmail.com>
Date: Wed, 12 Jul 2023 21:57:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/5] Support x2APIC mode with TCG accelerator
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230522163157.9754-1-minhquangbui99@gmail.com>
 <20230710143726-mutt-send-email-mst@kernel.org>
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20230710143726-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.11,
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

On 7/11/23 01:39, Michael S. Tsirkin wrote:
> On Mon, May 22, 2023 at 11:31:52PM +0700, Bui Quang Minh wrote:
>> Hi everyone,
>>
>> This series implements x2APIC mode in userspace local APIC and the
>> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
>> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
>> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
>> using either Intel or AMD iommu.
>>
>> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
>> with enabled x2APIC and can enumerate CPU with APIC ID 257
>>
>> Using Intel IOMMU
>>
>> qemu/build/qemu-system-x86_64 \
>>    -smp 2,maxcpus=260 \
>>    -cpu qemu64,x2apic=on \
>>    -machine q35 \
>>    -device intel-iommu,intremap=on,eim=on \
>>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>    -m 2G \
>>    -kernel $KERNEL_DIR \
>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>>    -drive file=$IMAGE_DIR,format=raw \
>>    -nographic \
>>    -s
>>
>> Using AMD IOMMU
>>
>> qemu/build/qemu-system-x86_64 \
>>    -smp 2,maxcpus=260 \
>>    -cpu qemu64,x2apic=on \
>>    -machine q35 \
>>    -device amd-iommu,intremap=on,xtsup=on \
>>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>    -m 2G \
>>    -kernel $KERNEL_DIR \
>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>>    -drive file=$IMAGE_DIR,format=raw \
>>    -nographic \
>>    -s
>>
>> Testing the emulated userspace APIC with kvm-unit-tests, disable test
>> device with this patch
>>
>> diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
>> index 1734afb..f56fe1c 100644
>> --- a/lib/x86/fwcfg.c
>> +++ b/lib/x86/fwcfg.c
>> @@ -27,6 +27,7 @@ static void read_cfg_override(void)
>>   
>>          if ((str = getenv("TEST_DEVICE")))
>>                  no_test_device = !atol(str);
>> +       no_test_device = true;
>>   
>>          if ((str = getenv("MEMLIMIT")))
>>                  fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
>>
>> ~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
>> ./run_tests.sh -v -g apic
>>
>> TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
>> -cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
>> apic-split (54 tests, 8 unexpected failures, 1 skipped)
>> TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
>> 1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
>> TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
>> qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
>> 1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
>> 2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
>> 6 unexpected failures, 2 skipped)
>>
>>    FAIL: apic_disable: *0xfee00030: 50014
>>    FAIL: apic_disable: *0xfee00080: f0
>>    FAIL: apic_disable: *0xfee00030: 50014
>>    FAIL: apic_disable: *0xfee00080: f0
>>    FAIL: apicbase: relocate apic
>>
>> These errors are because we don't disable MMIO region when switching to
>> x2APIC and don't support relocate MMIO region yet. This is a problem
>> because, MMIO region is the same for all CPUs, in order to support these we
>> need to figure out how to allocate and manage different MMIO regions for
>> each CPUs. This can be an improvement in the future.
>>
>>    FAIL: nmi-after-sti
>>    FAIL: multiple nmi
>>
>> These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.
>>
>>    FAIL: TMCCT should stay at zero
>>
>> This error is related to APIC timer which should be addressed in separate
>> patch.
> 
> So, I'm not sure how safe it is to merge as is - are we
> creating a way for users to shoot themselves in the foot?
> Would be better to just fix these issues before we merge.

I may be biased as I am the author and willing this to be merged. These 
issues are not created by this series, the current APIC implementation 
fails those tests too.

Currently, I only have some ideas to fix the timer failed test case. The 
timer failed test case is that when the timer is in one-shot mode, the 
initial count is non-zero. If the current count reaches 0, a timer 
interrupt is delivered and no more interrupt. At this time, if we write 
to timer LVT to change to periodic mode, according to Intel SDM Section 
11.5.4 APIC timer

"Changing the mode of the APIC timer (from one-shot to periodic or vice 
versa) by writing to the
timer LVT entry does not start the timer. To start the timer, it is 
necessary to write to the initial-
count register as described above"

So it is expected that periodic mode does not start until initial count 
is written. However, in our current implementation, we see the initial 
is non-zero, so we start the new periodic timer. The solution might be 
not calling apic_timer_update when timer LVT written anymore and make 
the apic_get_current_count returns 0 in the above case.

In my opinion, this series is expected to add the x2APIC feature, so if 
the user wants to use it, they need to enable this CPU feature flag. 
Otherwise, with their old configuration, it is expected to behave the same.

>> Version 4 changes,
>> - Patch 5:
>>    + Instead of replacing IVHD type 0x10 with type 0x11, export both types
>>    for backward compatibility with old guest operating system
>>    + Flip the xtsup feature check condition in amdvi_int_remap_ga for
>>    readability
>>
>> Version 3 changes,
>> - Patch 2:
>>    + Allow APIC ID > 255 only when x2APIC feature is supported on CPU
>>    + Make physical destination mode IPI which has destination id 0xffffffff
>>    a broadcast to xAPIC CPUs
>>    + Make cluster address 0xf in cluster model of xAPIC logical destination
>>    mode a broadcast to all clusters
>>    + Create new extended_log_dest to store APIC_LDR information in x2APIC
>>    instead of extending log_dest for backward compatibility in vmstate
>>
>> Version 2 changes,
>> - Add support for APIC ID larger than 255
>> - Adjust AMD iommu for x2APIC suuport
>> - Reorganize and split patch 1,2 into patch 1,2,3 in version 2
>>
>> Thanks,
>> Quang Minh.
>>
>> Bui Quang Minh (5):
>>    i386/tcg: implement x2APIC registers MSR access
>>    apic: add support for x2APIC mode
>>    apic, i386/tcg: add x2apic transitions
>>    intel_iommu: allow Extended Interrupt Mode when using userspace APIC
>>    amd_iommu: report x2APIC support to the operating system
>>
>>   hw/i386/acpi-build.c                 | 127 +++++----
>>   hw/i386/amd_iommu.c                  |  21 +-
>>   hw/i386/amd_iommu.h                  |  16 +-
>>   hw/i386/intel_iommu.c                |  11 -
>>   hw/i386/x86.c                        |   8 +-
>>   hw/intc/apic.c                       | 395 +++++++++++++++++++++------
>>   hw/intc/apic_common.c                |  16 +-
>>   hw/intc/trace-events                 |   4 +-
>>   include/hw/i386/apic.h               |   6 +-
>>   include/hw/i386/apic_internal.h      |   7 +-
>>   target/i386/cpu-sysemu.c             |  18 +-
>>   target/i386/cpu.c                    |   5 +-
>>   target/i386/cpu.h                    |   9 +
>>   target/i386/tcg/sysemu/misc_helper.c |  31 +++
>>   14 files changed, 500 insertions(+), 174 deletions(-)
>>
>> -- 
>> 2.25.1
> 

