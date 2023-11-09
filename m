Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E177D7E6C41
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:13:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15kU-00015s-0w; Thu, 09 Nov 2023 09:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r15kL-0000zv-07
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:11:03 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r15kI-0001Mp-TE
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:11:00 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso876772b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699539057; x=1700143857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U411sozw5w/ihVxc5s9QbqvmvunlH19Wp0MN7bwe/b8=;
 b=aHBwfAlgVzJ0FQydJpVu8iGoBsrUifo4L/559k+ElfsbeT4nA7dH8wdzGtBr5GdVJC
 12pmPOi0GkXTJo6KH/3qI0IOnf/OQ8Tx5hb7PU/25Yq3tWVr6TSqYzVwHE+ZYjSpvb5R
 VJmaZWINOBx+ZEKkY0K2NI/z6DurBz2zo2f5F1KQbAOyMo4TAaKpyKgRgKA9Z9jIt7nW
 3F0A87TWaCHxu78oa3VaJkx7aUgscgMzu4FCAcjgyqpP6QV2Sf4nPzVQt3/VtAr84Y+F
 DiMDFfU43w1PtjnX7Igx5aSvgnUwOcj9vXK+5RbqwK9sd7c3XSGQs2RQnCCJ4nnAk2FK
 ml+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699539057; x=1700143857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U411sozw5w/ihVxc5s9QbqvmvunlH19Wp0MN7bwe/b8=;
 b=T81vRtGOitpttnLIo9oXc2qs3N4+KD0vpQfusUvkeHIbHMz14djA8t0RGDvegM2m4F
 NaI+PqPY5tfttOkwdbvW2oFyFWkHbjBSn7zVGDBHiEin4iNX1yHmXBRcvVJHMOrVCYN7
 paWADuviXsVzTJRQzIqjKdS39eEzJJcKluDA0MNpohAJr1mSgj6rzCD5EftbzckhNKNF
 RPRRweN1PB9m6RnL5kJohDsam9XQ/mciGJtaJieQB/XJmgqKr/xgAZ79LUMuqmeGpJJS
 i7WDWRoJDDLElAZeDbnOTfklIOQ99/oI0Dh0i8MXtl4VDcPzsDJIsjI/hcqMS8fsuhHn
 BONA==
X-Gm-Message-State: AOJu0Yz8pFmIkA/rwZlc+Gh/rug2B5rGSaRD+qZ6EpHi5LZm+rduu031
 ScwCgDTG/Y3UJVijmT4mWSA=
X-Google-Smtp-Source: AGHT+IGzfwGtBVQHjJ0QnjKILNTBqeJajrYQrRiawcJOhNcWG0283S3SQMOI9X1qY2MazltpNqHayw==
X-Received: by 2002:a05:6a00:a1a:b0:6c3:75e1:9dcd with SMTP id
 p26-20020a056a000a1a00b006c375e19dcdmr5186952pfh.18.1699539056632; 
 Thu, 09 Nov 2023 06:10:56 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:3366:c285:960c:ac78?
 ([2001:ee0:50f4:9050:3366:c285:960c:ac78])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a63d407000000b005742092c211sm4846189pgh.64.2023.11.09.06.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 06:10:55 -0800 (PST)
Message-ID: <1c4cf652-9b31-4b22-8bb9-df27dce74cfd@gmail.com>
Date: Thu, 9 Nov 2023 21:10:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] Support x2APIC mode with TCG accelerator
To: Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <8bbae7b9-3923-b5cd-ff89-50baeccb5d02@amd.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <8bbae7b9-3923-b5cd-ff89-50baeccb5d02@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x42c.google.com
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

On 11/9/23 17:11, Santosh Shukla wrote:
> On 10/24/2023 8:51 PM, Bui Quang Minh wrote:
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
>>
>> Version 9 changes,
> 
> Hi Bui,
> 
> I have tested v9 on EPYC-Genoa system with kvm acceleration mode on, I could
> see > 255 vCPU for Linux and Windows Guest.
> 
> Tested-by: Santosh Shukla <Santosh.Shukla@amd.com>

Hi Santosh,

With KVM enabled, you may be using the in kernel APIC from KVM not the 
emulated APIC in userspace as in this series.

Thanks,
Quang Minh.

