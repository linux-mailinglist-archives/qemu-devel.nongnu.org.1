Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A40F7E2789
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:48:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00tP-0002cg-Vw; Mon, 06 Nov 2023 09:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1r00tN-0002Yn-3p
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1r00tL-00035R-1j
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699282069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhIMbQBoRSAH1VC5RrcuVVI6m7CdC9M01r6oiFd1hZU=;
 b=XYXfYCOqy170Bge7EOdRWblf9/Xt33v+EBB3uehCsO/+KGDLW2iEtd7mUldION/HqW7B9C
 ywmlPG2pXpTOCi/2VkbS7Eni230NUAZjZvxVFc2176QT0icBTzoN3qj1dB6zYGPQN66wsX
 Wu6mWXyGhXuXJcxXxyt2UueM6B1OhDo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-5kg_XRqYMKilHLFwyToPeQ-1; Mon, 06 Nov 2023 09:47:48 -0500
X-MC-Unique: 5kg_XRqYMKilHLFwyToPeQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d03dcdc6bso56304576d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282068; x=1699886868;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhIMbQBoRSAH1VC5RrcuVVI6m7CdC9M01r6oiFd1hZU=;
 b=WQW/wlVr6qPmenrFpXIBg5P8vvbm44wXtpaBxIscruU+AJuEmp/Ri6SwR2B9n/nDpg
 4urWEpDrKYqL+5/EAMFdmXu1e/c3LzidlL+pG+ZbAXFQiNwt/UMckaucPMsDSABT2r3S
 Ju55xQl7zYHUyAs9BRSvHI9FayzsrMJ4MCO7p4AEqsFuVUji5NIrm1wz1Srd0ziWJ7eF
 q+RyuUjrp6Ji7wHtMIj05q7L+peau9LQfCSLx0iGO0D+2w6zrrvMYUU255daK8/AfxBU
 J7AheEzDN0VkjeNz1/M2tdN3mzt4D6nLDbqGiXdzuYlhhccwTspul3XFjm0TjUj1hpgN
 CxMw==
X-Gm-Message-State: AOJu0Yxlpg1CoeFWJWAoueMnY64LYtqKRTpISoBYEjhaEKUFW5QhsQb2
 Adxba5PMJDo6hWBR92CAc1ySRaHdjq9zjq3+opweUtP7RUnrb1+uUJV9VN5MXUnEwjZ2oGAbXMp
 YP5ZsGSf9ptiSe5U=
X-Received: by 2002:a05:6214:260c:b0:66f:bb36:9a51 with SMTP id
 gu12-20020a056214260c00b0066fbb369a51mr30987328qvb.36.1699282067766; 
 Mon, 06 Nov 2023 06:47:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3giIRPyFZILBb5Dv+o8pDdqXAwRy6h/fVA19SUIOTL6ovljJk7cRKOEDE5N0+6swXH/x5eQ==
X-Received: by 2002:a05:6214:260c:b0:66f:bb36:9a51 with SMTP id
 gu12-20020a056214260c00b0066fbb369a51mr30987314qvb.36.1699282067464; 
 Mon, 06 Nov 2023 06:47:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a0ce848000000b0065d89f4d537sm3472656qvo.45.2023.11.06.06.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:47:47 -0800 (PST)
Message-ID: <108a94d0-b262-4d4c-8533-059f6652c6a8@redhat.com>
Date: Mon, 6 Nov 2023 15:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intermittent qtest-aarch64/xlnx-canfd-test test failure
Content-Language: en-US
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers
 <qemu-devel@nongnu.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <fd2b7868-2ac5-64a1-d66f-3025c1da6bd1@tls.msk.ru>
 <76165393-f7ef-40fb-883f-ba8654856467@redhat.com> <ZUFhOhQpj6UVawyZ@amd.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <ZUFhOhQpj6UVawyZ@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/31/23 21:19, Vikram Garhwal wrote:
> Hi Michael & Cedric,
> On Mon, Oct 30, 2023 at 05:19:38PM +0100, Cédric Le Goater wrote:
>> On 9/21/23 09:51, Michael Tokarev wrote:
>>> Hi!
>>>
>>> While doing stable-8.1.1 preparation, I've a CI failure of ubuntu-20.04-s390x-all here:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/5132720046
>>>
>>> ▶ ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: \
>>>     assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
>>>
>>>    qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test  \
>>>              ERROR           0.77s   killed by signal 6 SIGABRT
>>>
>>> Re-run of this test went successfully.  However, the assert looks
>>> a bit scary, and the fact that it does not fail in a reliable way
>>> is a bit troubling too.  Is it a flaky test or there's something
>>> else in qemu with concurrent threads?
>>>
>>> I don't see this assert in previous test runs.  But ubuntu-20.04-s390x-all
>>> test fails quite often due to other reasons, so it isn't conclusive.
>>>
>>> Should something be done with this?
>>>
>>> The testing is done for commit f2fc49c302036315db6e8c9f74592decc3be0476,
>>> which is in staging-8.1 branch only temporarily.
>>>
> I tried with staging-8.1 and didn't see this error. I ran it with registry.gitlab.com/legoater/qemu/qemu/fedora-i386-cross:latest on a x86 host machine. Can you please share more about how you are running
> the testes? It will be greatly helpful to me in reproducing the issue and fixing

I simply ran :

while [ 1 ]; do QTEST_QEMU_BINARY=build/aarch64-softmmu/qemu-system-aarch64 QTEST_QEMU_IMG=qemu-img build/tests/qtest/xlnx-canfd-test || break; done
....
# starting QEMU: exec build/aarch64-softmmu/qemu-system-aarch64 -qtest unix:/tmp/qtest-689050.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-689050.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine xlnx-versal-virt -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus -accel qtest
**
ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
Bail out! ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
Aborted (core dumped)


It is always the same error : 0x88000000 == 0x80000000

Thanks,

C.

> it.
>>> Thanks,
>>>
>>> /mjt
>>>
>>
>> I had the same CI error in job https://gitlab.com/legoater/qemu/-/jobs/5416150239
>> ▶ 170/258 ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648) ERROR
>> 170/258 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test           ERROR           0.49s   killed by signal 6 SIGABRT
>>>>> QTEST_QEMU_BINARY=./qemu-system-aarch64 PYTHON=/builds/legoater/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=60 G_TEST_DBUS_DAEMON=/builds/legoater/qemu/tests/dbus-vmstate-daemon.sh /builds/legoater/qemu/build/tests/qtest/xlnx-canfd-test --tap -k
>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>> stderr:
>> **
>> ERROR:../tests/qtest/xlnx-canfd-test.c:265:match_rx_tx_data: assertion failed ((buf_rx[size] & DLC_FD_BIT_MASK) == (buf_tx[size] & DLC_FD_BIT_MASK)): (2281701376 == 2147483648)
>> (test program exited with status code -6)
>>
>> I could reproduce on PPC64 and s390x systems.
>>
>> C.
>>
> 


