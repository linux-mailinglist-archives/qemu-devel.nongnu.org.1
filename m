Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 110447CE65F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBFI-0005ew-IX; Wed, 18 Oct 2023 14:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBF3-0005Vr-TL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:26:02 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBEx-00039Z-PV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:25:59 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so6483209e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697653554; x=1698258354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=luUIFfDg0a88T8tG/op5ev0d7DWUNCX4ymwUFyZS6tg=;
 b=jlqVqPYU/od0ttExRY3sbeI5KhZJJ6jyjqgVquk8JrQ+LoBwu6CY6aWoE5TU1t9pv3
 D7QPY1E65f4qIvBEzwtdKU/80VHSK0ol6j7Mr+OaLqM8oRhz1aBifK7a4o65KIMQyDNQ
 Vh5N1T2Bh76TZyAx73/6ZgZvxykPhFg0uzl0YVqBa/B8bSIRlXMur4E33ggsnsCZ/6UF
 Ix4NCYp7d6kuAq3mV+/p5Wqb1R0NOGM2D1wHQU0NHQ2FvB66DOh1FKnXUZrm74bZkbKT
 ZnT3Mk4QfqLzUN1mwTqJCdfbI2ftLvithw2P82wcXvz6mKpjIdcXvVHop+q6cwdR/DKX
 qH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697653554; x=1698258354;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=luUIFfDg0a88T8tG/op5ev0d7DWUNCX4ymwUFyZS6tg=;
 b=rC6uVKONzD8w2EOjabAsX3hZiE1ea4C2BL+KJP15xtCLcELzBYi1pb3pg5iGG2kk5f
 EF0NuhlmJfilce+CYejvGG7+9JcMXgR65imQ3bIEsSJVZTjthTzELWxzGElFdwYw1ToS
 ws67wgz0HL6TX+/axhaAgiubtJ6If2JmiGOBZj49f7b2OwcRCegK+1WF2hD1Yc6tjHb/
 xHwB4iYcyRCO6isJuzelfgOEo01bx+XZl7ABBUDacyAokRAWL+Lv9HsBovMFKuYzZe8c
 nmrC44o+mR4IfchJuVk9DtrIxT5Ln3Z71HAjJJh4xbW2EchGv3AjS5/n21RrsGKA2Dt2
 pQaw==
X-Gm-Message-State: AOJu0YwUexGWEO4ByQB7dvD25975FCBnicPUfQUItX1BBdVW5QTDiYVF
 4vhZBMhkGrTAWQeN2/fqaSx6WA==
X-Google-Smtp-Source: AGHT+IE7XFwhwK91lchcty3U2o90AduTK7KSy1v8q89W3Vs5rsNPeMDD2+5hHW/XpUXG94J2UT2kkA==
X-Received: by 2002:ac2:4da3:0:b0:503:3816:c42c with SMTP id
 h3-20020ac24da3000000b005033816c42cmr4310458lfe.41.1697653553824; 
 Wed, 18 Oct 2023 11:25:53 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 gh6-20020a170906e08600b00977cad140a8sm2148969ejb.218.2023.10.18.11.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 11:25:53 -0700 (PDT)
Message-ID: <70a34b74-aa36-0805-1400-f7f8a41640d9@linaro.org>
Date: Wed, 18 Oct 2023 20:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 00/12] hw: Strengthen SysBus & QBus API
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
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
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> 
>   10/433 qemu:qtest+qtest-ppc64 / qtest-ppc64/qom-test              
> ERROR           0.72s   killed by signal 6 SIGABRT
>  >>> MALLOC_PERTURB_=217 QTEST_QEMU_IMG=./qemu-img 
> G_TEST_DBUS_DAEMON=/home/thuth/devel/qemu/tests/dbus-vmstate-daemon.sh 
> PYTHON=/home/thuth/tmp/qemu-build/pyvenv/bin/python3 
> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
> QTEST_QEMU_BINARY=./qemu-system-ppc64 
> /home/thuth/tmp/qemu-build/tests/qtest/qom-test --tap -k
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― 
> ✀ ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> stderr:
> qemu-system-ppc64: sysbus_mmio_map(type:power9_v2.2-pnv-chip, index:0, 
> addr:0x603fc00000000, prio:0) but object is not realized
> Broken pipe
> ../../devel/qemu/tests/qtest/libqtest.c:203: kill_qemu() detected QEMU 
> death from signal 6 (Aborted) (core dumped)
> 
> (test program exited with status code -6)
> 
> TAP parsing error: Too few tests run (expected 17, got 0)

Sorry, I forgot to add:

Based-on: <20231018133059.85765-1-philmd@linaro.org>
           "hw/ppc: SysBus simplifications"
https://lore.kernel.org/qemu-devel/20231018133059.85765-1-philmd@linaro.org/


