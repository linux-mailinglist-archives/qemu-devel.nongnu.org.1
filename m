Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1181F9C3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 16:46:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIsZ8-00046m-1L; Thu, 28 Dec 2023 10:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rIsZ5-00045A-6d
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 10:44:55 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rIsZ2-00012I-MV
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 10:44:54 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9bc8939d0so1161713b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703778288; x=1704383088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZT+m7ZDYFdfUgkHgqHLH3dSY5t76wF7h1UjfZisTdlQ=;
 b=TwnOr8MqicOtnE0FzQZMdti15fxFGQADPAqwb5+ayKI+paZqm18PITwDNnaftFFOUD
 O8aS1iVLq5X0VP2QYDTEy9+ZEgxOyVPLjY0MBqDuDDWcH8x58p978BAtOvlBjRz6fKNt
 CVSf5eHkhiV7XahRKf9NEtyKwV3DOFMzVGmxCXgipCUH0tPdNBl2q4wSpd2BwDRQPV+S
 +4FypHxkLlfNGTqpDp2zVWfkQjBEOjUvQz7jtzkSfMdE66USboYOPnvEBeIYrJ6AiTip
 xgPtpRvg+ZCIWNy6sH7JKzjfwwq6K49Sh05ILNkJHQrDIky8XesbFJfci4E9d4H5jFVr
 FmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703778288; x=1704383088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZT+m7ZDYFdfUgkHgqHLH3dSY5t76wF7h1UjfZisTdlQ=;
 b=Yc9Sax11/arOt3pMiif5HLht7YcZ/AP4azaIwCB4/pfBythQI4WdXGWZSV5kjVot+3
 xhuN7ajBeo7jx62bu0zWP1Vkv3Md1SO8p1qXVQFfFBcxCT3zsRntoE/E1LWq7kbIA2JA
 ImNCJisnzoAWFPfbRf5+QvNr4QYTXkM8KA4K3f7fT2SSKzlRSkk0IJH5gaNCxR3eKCIy
 eWjgoA/MDD5t1tUtA+tYIWYosU2EmZXZ5Nt3s8Np+3Gk4JPjr5ukE4k1Me4ffB+zIpHT
 CdJXjfpbnOtMfV0DzHRbl9lro6QRYIiMdE2PwKfVUHRsfoEg68sZAbK0m1Fw887Dmawb
 TC7g==
X-Gm-Message-State: AOJu0YxIxeqPRkkWoqFX+B9RYy116EAtOSLyPnGfs0JI5NgdfzPRRYRD
 HyQ96xekP3DVH21OH14BCfo=
X-Google-Smtp-Source: AGHT+IGCHTBGzWwmwtSkoSVA6zDTIxzzZL0Puu9yL5M+evU+RULTcbVtA5VvrOkzxUAMGETDhg5UnA==
X-Received: by 2002:a05:6a20:1aaf:b0:194:f2af:7f2f with SMTP id
 ci47-20020a056a201aaf00b00194f2af7f2fmr4436637pzb.35.1703778288502; 
 Thu, 28 Dec 2023 07:44:48 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:8f4d:de74:dc83:8d45?
 ([2001:ee0:50f4:9050:8f4d:de74:dc83:8d45])
 by smtp.gmail.com with ESMTPSA id
 f34-20020a056a000b2200b006d97eaba6cesm8470474pfu.21.2023.12.28.07.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 07:44:48 -0800 (PST)
Message-ID: <e3f17b85-697b-4f71-854d-411a3878db00@gmail.com>
Date: Thu, 28 Dec 2023 22:44:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] Support x2APIC mode with TCG accelerator
Content-Language: en-US
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
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20231226042009-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x432.google.com
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

On 12/26/23 16:21, Michael S. Tsirkin wrote:
> On Mon, Dec 25, 2023 at 11:40:54PM +0700, Bui Quang Minh wrote:
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
> 
> Seems to break build for windows/amd64
> https://gitlab.com/mstredhat/qemu/-/pipelines/1118886361/failures

I saw the CI test "pages" failed too. On my CI, most of the time, it 
failed with

$ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU 
sourcecode"
00:24
htags: Negative exec line limit = -8099

It only succeeded once. I could not reproduce locally. Do you have any 
ideas what the problem is?

Thanks,
Quang Minh.

