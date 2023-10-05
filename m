Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E957BA306
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQcl-0004ll-0b; Thu, 05 Oct 2023 11:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qoQce-0004lT-08
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:50:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qoQcc-0003yS-4P
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:50:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c60cec8041so7954305ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696521040; x=1697125840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oEyJp3OLT4G/4QfLW0WtDjhoZ3wt/0kL5xj5oYHKVfE=;
 b=i/y4oNdTvJka14zjhILP3XDeQAKGP/TcFyXxdTtp2UXCvy2j12ElhpYC+N+EmFCdLw
 7kvbDVaRw1W7ccOnAaBZ7fw24HXygzZXHybG0pXQEIaG8z1jKAPq7aIFf1USk0BDX8Ut
 9DpWL2tSS+bSEiv7zI1eVoPzxN6b41A9gyGyMuDRKdqk+mwD3PSmZIdfBbaJMtUxynJ9
 ntMD2k62r4Mae2+tBjGnmHTtZ1NUAkGnz5k/jphutc6mhQzXP1JdKpFipH0+g9r/TrBF
 TVR4IfPIZzv6vFqpfJ/YFjFc5ylKUs87qArHj7Mpf+yTkRfvq0WNifSLQP3QruuDsS4u
 0owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696521040; x=1697125840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEyJp3OLT4G/4QfLW0WtDjhoZ3wt/0kL5xj5oYHKVfE=;
 b=en3QbEnCPZLwhyKnYCPtEiTJnRA717DZRdD9lzTSScUCYumbTiu27/G9Z9fY4lZUPb
 kADhVak+rkWBryR0i9NgIrfzk7Z8F53K2t8CTPmIiZiTNfzzfz2a1HAUjMZdVabU/D7U
 Q/w/gUtvn4obA4EuOrlv6sco+rU+dmSnW/droEiUP/86gf/5GpaumRL+StPM7QSX6wVH
 jeJ+zfkQFH6f/rlIyqA667ZhYMlsKRrbiXOQw9cpWKvc5ROJMNlxQKJgaXYJhk9ceDzR
 xFF/6S76Ye7epcYZaZNuwnETz/cua3cHOjgtvfsthc3JX0o4a/C6IM4QzXHLDiTj8SAq
 iDhw==
X-Gm-Message-State: AOJu0YzF35OLRUbqtt5wCrSDzJIRBQ4WqVDRRcRw9P10OH8omDAl7unt
 qy7T1KhGtaFs90dCKYCH76OEmWxSF0I/Ag==
X-Google-Smtp-Source: AGHT+IGf97ZUtZZsb3u3HHq51Y/TS3pwM4Yk6fS6i2MvL0k5g1D8He2AAKNJdwdKS1mgwlZOdGLQzA==
X-Received: by 2002:a17:902:edd0:b0:1c7:69a1:751e with SMTP id
 q16-20020a170902edd000b001c769a1751emr4388471plk.43.1696521039885; 
 Thu, 05 Oct 2023 08:50:39 -0700 (PDT)
Received: from ?IPV6:2001:ee0:50f4:9050:b98f:b88b:1a9d:6699?
 ([2001:ee0:50f4:9050:b98f:b88b:1a9d:6699])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a170902968e00b001bf044dc1a6sm1865071plp.39.2023.10.05.08.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 08:50:39 -0700 (PDT)
Message-ID: <b05e4594-aa41-477f-9914-2835ebe9643b@gmail.com>
Date: Thu, 5 Oct 2023 22:50:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Support x2APIC mode with TCG accelerator
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20230926160637.27995-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/26/23 23:06, Bui Quang Minh wrote:
> Hi everyone,
> 
> This series implements x2APIC mode in userspace local APIC and the
> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
> using either Intel or AMD iommu.
> 
> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
> with enabled x2APIC and can enumerate CPU with APIC ID 257
> 
> Using Intel IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>    -smp 2,maxcpus=260 \
>    -cpu qemu64,x2apic=on \
>    -machine q35 \
>    -device intel-iommu,intremap=on,eim=on \
>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>    -m 2G \
>    -kernel $KERNEL_DIR \
>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>    -drive file=$IMAGE_DIR,format=raw \
>    -nographic \
>    -s
> 
> Using AMD IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>    -smp 2,maxcpus=260 \
>    -cpu qemu64,x2apic=on \
>    -machine q35 \
>    -device amd-iommu,intremap=on,xtsup=on \
>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>    -m 2G \
>    -kernel $KERNEL_DIR \
>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>    -drive file=$IMAGE_DIR,format=raw \
>    -nographic \
>    -s
> 
> Testing the emulated userspace APIC with kvm-unit-tests, disable test
> device with this patch
> 
> diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
> index 1734afb..f56fe1c 100644
> --- a/lib/x86/fwcfg.c
> +++ b/lib/x86/fwcfg.c
> @@ -27,6 +27,7 @@ static void read_cfg_override(void)
> 
>          if ((str = getenv("TEST_DEVICE")))
>                  no_test_device = !atol(str);
> +       no_test_device = true;
> 
>          if ((str = getenv("MEMLIMIT")))
>                  fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
> 
> ~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
> ./run_tests.sh -v -g apic
> 
> TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
> -cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
> apic-split (54 tests, 8 unexpected failures, 1 skipped)
> TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
> 1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
> TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
> qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
> 1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
> 2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
> 6 unexpected failures, 2 skipped)
> 
>    FAIL: apic_disable: *0xfee00030: 50014
>    FAIL: apic_disable: *0xfee00080: f0
>    FAIL: apic_disable: *0xfee00030: 50014
>    FAIL: apic_disable: *0xfee00080: f0
>    FAIL: apicbase: relocate apic
> 
> These errors are because we don't disable MMIO region when switching to
> x2APIC and don't support relocate MMIO region yet. This is a problem
> because, MMIO region is the same for all CPUs, in order to support these we
> need to figure out how to allocate and manage different MMIO regions for
> each CPUs. This can be an improvement in the future.

I've tried to address these failed tests with the idea of creating 
separate APIC MMIO region per CPU. I've created a working patch with 
this approach and will send it in reply to this message, you can see the 
detail in the patch. However, it has a big drawback, it breaks MSI 
handler. With that patch, device needs to call apic_send_msi directly 
instead of writing to 0xfee00000 in system memory. Furthermore, I think 
APIC MMIO relocation is a very unusual use case and APIC MMIO disable is 
not much important for normal system software. I'm pleased to receive 
any comments on that patch.

Thank you,
Quang Minh.

