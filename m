Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279A67CE6A7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBLO-0002lA-Ip; Wed, 18 Oct 2023 14:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBLN-0002kq-6H
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:32:33 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBLL-0003uC-5f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:32:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso1156935366b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697653949; x=1698258749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mbtYO3FVscziXI6WqkBGQAZiD+XUBy2z2f1p9zcPQPw=;
 b=T/w2x0r0qVrjxKF35MGg6aGDE7h/TZH5+6PyUlp/zuTL2nVZp/o4RJ4VRI574ARbUa
 3MEwOGR6C1ACBlISGy5TTSfJqEZabLF8HAPwpVbT1pyzJdKJFN8bcwSvGyEdlli8WmEg
 fnHItTC0OyylbAPoQHaWPMOc718Hd7iadex6aLMDb6P2UYxc9hUItDa6YHLbPEruh+n4
 gJfxvaYvWBmCDxm2oOQVxzucqkfc/yc/tMcFWMJqMQ+EAQIxinlzCyDxGlIGwjhc7m2T
 6tstre63mcXm/VzP+3BhFE++CTUnjVAkL+9n2SK0XzdIqo7hlWxe2/fU4cLJoNVK7PkN
 v6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697653949; x=1698258749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbtYO3FVscziXI6WqkBGQAZiD+XUBy2z2f1p9zcPQPw=;
 b=dyDRTqHUTNEo05ZWk4HCpMJPAhhF3yUB8QlYt+01f7+tXTm9f6Z9op0JjSmWYQsBwS
 eEoY54qEweXAz0tM3GniRXrxmFo+/cQPdnubYrHyBZ3ke6nmfMj4f2J2FyXpYLnR4InE
 JL7xdujk3rg1AIMyLxIDgHOjqga5kiUZdtDtZo5tP7eLnd3IWGlZmHBv2Ml6NBW379Dj
 1kC62GfAVYKKio4LXJBiXjKdtDi+yAI1/ezGIsoPNqGnh4gla9UOiIqFcI5HQvHzMo+q
 J/+ql2UCFDZ1z9VMUvbRqiCgegUwGHvHOfL/TxGDf+p6uQcbQMICO2+NeZvXb2Qk04v7
 NkbQ==
X-Gm-Message-State: AOJu0YyANirXKkiINpzaIsGsRWbJh/+CCoR8SRFxVqEpfiXOop49obRg
 z9UWzESqdTe/iVnX6/2t3WEZAw==
X-Google-Smtp-Source: AGHT+IHBAfRr+/x2bJw8ayHDGy2EREASDcrGt7mraaG+8BaIAMTogx32v9eiFpvhq5Z9YdPAh85Ztg==
X-Received: by 2002:a17:907:3687:b0:99d:e617:abeb with SMTP id
 bi7-20020a170907368700b0099de617abebmr82140ejc.23.1697653949135; 
 Wed, 18 Oct 2023 11:32:29 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a1709060d9400b0099bd046170fsm2144780eji.104.2023.10.18.11.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 11:32:28 -0700 (PDT)
Message-ID: <66f04f0f-604a-e609-2d21-39b881d4ab64@linaro.org>
Date: Wed, 18 Oct 2023 20:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 00/12] hw: Strengthen SysBus & QBus API
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231018141151.87466-1-philmd@linaro.org>
 <393f1aa0-afb5-4269-8499-80afd5b98e48@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <393f1aa0-afb5-4269-8499-80afd5b98e48@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 18/10/23 18:24, Thomas Huth wrote:
> On 18/10/2023 16.11, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> This series ensure:
>>
>> - qbus_new() and sysbus_init_mmio() are called *before*
>>    a device is realized,
>> - sysbus_mmio_map() is called *after* it is realized.
>>
>> First we fix some abuse, then we enforce in qdev/sysbus
>> core code.
> 
> I like the idea, and just had a try with "make check-qtest" with the 
> patches here, but seems like there are more spots that need attention:


>   24/433 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test              
> ERROR           5.94s   killed by signal 6 SIGABRT
>  >>> QTEST_QEMU_BINARY=./qemu-system-aarch64 
> G_TEST_DBUS_DAEMON=/home/thuth/devel/qemu/tests/dbus-vmstate-daemon.sh 
> QTEST_QEMU_IMG=./qemu-img 
> PYTHON=/home/thuth/tmp/qemu-build/pyvenv/bin/python3 
> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
> MALLOC_PERTURB_=105 /home/thuth/tmp/qemu-build/tests/qtest/qom-test 
> --tap -k
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― 
> ✀ ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> stderr:
> qemu-system-aarch64: sysbus_init_mmio(type:pxa2xx_pic) but object is 
> realized
> Broken pipe
> ../../devel/qemu/tests/qtest/libqtest.c:203: kill_qemu() detected QEMU 
> death from signal 6 (Aborted) (core dumped)

I neglected to mention that in the cover letter. This is mentioned here
https://lore.kernel.org/qemu-devel/1b159c7a-f52c-3705-8757-c2b80a04965b@linaro.org/

I ping'd Peter on IRC because I'm not sure how to fix this PXA2xx code.
Apparently it cames from commit 3f6c925f37 ("Use i2c_slave_init() to
allocate the PXA (dummy) I2C slave"), which I presume was how to model
slave<->master transactions *before* I2C bus modelling.

Regards,

Phil.

