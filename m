Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90998260A1
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 17:35:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM9cK-0001cQ-LN; Sat, 06 Jan 2024 11:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rM9cD-0001cI-0r
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 11:33:41 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rM9cB-0002t2-8l
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 11:33:40 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-360852ae88fso1674985ab.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704558817; x=1705163617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gcZC8DXEse5Sxz+x5JPExLCpeQDyRaul2DdRhgTgxgQ=;
 b=CvYsA+4TW+QGqLt14lUveMb51ONiV+fgjp/Krna+GGG5JR5L5fzWbQhDq/NdH8M7MQ
 RuU8Y7tgJhU7gW+Fsycoj/+CZDMN66Wivm/7bxDOkqY9LGTreN57Z1v1lV5vqEGjOqAK
 QDclet34DLMX6+bCa4/RIGikoYTOH+qRCXOQx1NekJ8IIcyo0ynkvJCX/JS9ad+jkS27
 6QdwNOh3GahNNGcMkODwLM7PJR3S+eA4tJ0AUSkdz9+6kn8JMIQ60JrB58nt88iGsp6z
 2kDzrTBrI7bUsYvI5qOfuuMLy0XkhUHegzk87gsrigWCd3pYIq6w3i0rKNSSPIj+KhZU
 xJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704558817; x=1705163617;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gcZC8DXEse5Sxz+x5JPExLCpeQDyRaul2DdRhgTgxgQ=;
 b=L6Up2EfzQRXi+C+7b8ZXYmbJCcxCvYI2kelVCwxF4dKcr8q7jKioDCvk6RGoic0G51
 q4V/nfMpDauHFqYYQEZ9pMzwyBdZ7bdSdadpiYhxm3/uxzZVUMp7GGFSGmcfg1fbnlAC
 KXiDJwOfqwxyMvZPJADFq4j+OJxQbVgfPU7SLpt0CQhM+gt7EhZHtK+/kPq+kqYlskyG
 oNvrsVQqTNIY3CNJsIfsgzDDa+w5QXUndm7CVn3mmo6oSZFUaKCMP4rnyJSIp1sBkofI
 rBMOqpc3o2UOnDEi+NizbsavX6egGM/L3zO8invIObt5cg9STK+wnACuvoDxKOqsR9NF
 Siww==
X-Gm-Message-State: AOJu0Yxo55H0P6Jl0guSmBEPFlGuqdepju1tsroH1uzSm9ULbUVZJSQV
 Qu5xZ1m4XG/9FrnCj096QkU=
X-Google-Smtp-Source: AGHT+IGYP9uKo7QhOAQYji9Rhvd8mkMEOPu8QjQc6DwrlADlnmCwjtOT0rIeoZPGcsq7DRk2koUEDw==
X-Received: by 2002:a05:6e02:2205:b0:35f:f5c7:cce3 with SMTP id
 j5-20020a056e02220500b0035ff5c7cce3mr2378339ilf.33.1704558817381; 
 Sat, 06 Jan 2024 08:33:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:107:82a4:587c:d207?
 ([2001:ee0:50f4:9050:107:82a4:587c:d207])
 by smtp.gmail.com with ESMTPSA id
 q196-20020a632acd000000b005cee9115cb3sm1574600pgq.0.2024.01.06.08.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jan 2024 08:33:36 -0800 (PST)
Message-ID: <322c9b6b-84fa-46a3-b173-34e6e9acc00d@gmail.com>
Date: Sat, 6 Jan 2024 23:33:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] Support x2APIC mode with TCG accelerator
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>
References: <20231225164101.105958-1-minhquangbui99@gmail.com>
 <20231226042009-mutt-send-email-mst@kernel.org>
 <e3f17b85-697b-4f71-854d-411a3878db00@gmail.com>
Content-Language: en-US
In-Reply-To: <e3f17b85-697b-4f71-854d-411a3878db00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=minhquangbui99@gmail.com; helo=mail-il1-x12e.google.com
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

On 12/28/23 22:44, Bui Quang Minh wrote:
> On 12/26/23 16:21, Michael S. Tsirkin wrote:
>> On Mon, Dec 25, 2023 at 11:40:54PM +0700, Bui Quang Minh wrote:
>>> Hi everyone,
>>>
>>> This series implements x2APIC mode in userspace local APIC and the
>>> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel 
>>> iommu
>>> and AMD iommu are adjusted to support x2APIC interrupt remapping. 
>>> With this
>>> series, we can now boot Linux kernel into x2APIC mode with TCG 
>>> accelerator
>>> using either Intel or AMD iommu.
>>>
>>> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully 
>>> boot
>>> with enabled x2APIC and can enumerate CPU with APIC ID 257
>>>
>>> Using Intel IOMMU
>>>
>>> qemu/build/qemu-system-x86_64 \
>>>    -smp 2,maxcpus=260 \
>>>    -cpu qemu64,x2apic=on \
>>>    -machine q35 \
>>>    -device intel-iommu,intremap=on,eim=on \
>>>    -device 
>>> qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>    -m 2G \
>>>    -kernel $KERNEL_DIR \
>>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial 
>>> net.ifnames=0" \
>>>    -drive file=$IMAGE_DIR,format=raw \
>>>    -nographic \
>>>    -s
>>>
>>> Using AMD IOMMU
>>>
>>> qemu/build/qemu-system-x86_64 \
>>>    -smp 2,maxcpus=260 \
>>>    -cpu qemu64,x2apic=on \
>>>    -machine q35 \
>>>    -device amd-iommu,intremap=on,xtsup=on \
>>>    -device 
>>> qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>    -m 2G \
>>>    -kernel $KERNEL_DIR \
>>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial 
>>> net.ifnames=0" \
>>>    -drive file=$IMAGE_DIR,format=raw \
>>>    -nographic \
>>>    -s
>>>
>>> Testing the emulated userspace APIC with kvm-unit-tests, disable test
>>> device with this patch
>>
>> Seems to break build for windows/amd64
>> https://gitlab.com/mstredhat/qemu/-/pipelines/1118886361/failures
> 
> I saw the CI test "pages" failed too. On my CI, most of the time, it 
> failed with
> 
> $ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU 
> sourcecode"
> 00:24
> htags: Negative exec line limit = -8099
> 
> It only succeeded once. I could not reproduce locally. Do you have any 
> ideas what the problem is?

I think I briefly understand why pages test fails. Internally, htags 
call global to parse the output of gtags. When executing command, it 
expects the size of argv and env to 20*1024 
(https://github.com/harai/gnu-global/blob/f86ba74d867385353815f8656c4a6cf4029c1f0b/libutil/xargs.c#L92-L105). 
The failed test case only happens when the last commit is patch 7 (test: 
bios-tables-test: add IVRS changed binary) which has a very long commit 
message (around 9000 bytes). By default, Gitlab appends some environment 
variables to the runner and one of them is CI_COMMIT_MESSAGE which 
contains the long commit message. So it exceeds the limit of 20*1024 
bytes and fails.

In my opinion, this failed test is not so critical and seems unrelated 
to the series so I skip this failed test. I will post the new version to 
fix the windows/amd64 build soon.

Thanks,
Quang Minh.

