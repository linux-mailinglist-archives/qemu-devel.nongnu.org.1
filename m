Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E038251C1
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:19:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhIT-0006Tx-GV; Fri, 05 Jan 2024 05:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLhIQ-0006TG-Vt
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:19:23 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLhIM-0001qO-KO
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:19:20 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50ea9daac4cso1591963e87.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704449955; x=1705054755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JrpZJsC+JCf4DKhNEEKL+YgSEbHMOxskxIftU0vEodU=;
 b=OatCxACRDqIQhAUiVMmjpMDUtT9F1ygNGRbswS9eCcfeyccdbRrJyyIj2ViME3giCi
 GBI/elw0FSgyayH/L33Y6GdESiAQlmE4Ju5EJg50xp7Rbb7u6Ynsi+5f9I/DIHH/thRf
 YvPEJ3i+QUTVfFkw9JrPU03kVdyJHHM5cEBR9NfDEKdtx9/jdDAwLCoq1VhKkhhMiLZt
 48aIXnWPXIVrcHjUlIRSwXKTKgvSkY8vsD72GmQtyY/CA4KipcnkdTg75+nbrl3eTqzr
 xYJqVc3NUZcEbQuob01Xb4Y/yPiTXHC3uk1CGd5o05YjNsoMRW1D5b/hyVk4LoieVqG4
 xbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704449955; x=1705054755;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrpZJsC+JCf4DKhNEEKL+YgSEbHMOxskxIftU0vEodU=;
 b=VS0e9Ixh4NbmHtn24Bv9wykS63YnnkS/oERtyv43IEZ5XaBWxpPez4k7KzIeoZXlbg
 2kFMQxseR0AGG+oO/1j/JUGJMyGrlvLVpWoERyfMDk3oUL2bailgs00srjlarER3RC6K
 Eoh2jIrDQFCjcEZNB2K8qTAVKLZzuU28o5DL86sr8jRPI0L8WjgT7HPQxxgz16m+dd2Z
 JNI7lPmOQyQgqOGT3i7DNJbJsqGIk0RjjjrNIQq6lD+Iv1xYTwU7qcQY5uiFKS9iMdGd
 QwWa44kLxkpP/Irqc6Yw5Dyj1NO5leC/fc99tVfTJHOqtUZb4dzCDRi6yd3NepviDFKj
 uLPQ==
X-Gm-Message-State: AOJu0YwQ4TwQ91ICn6Ye/c9v1gr3T1/XiUjHGDZThbFqSkutxB5VyELy
 0Cc5qLp7RdgFGE+0i6PQigZQqwzqEO+Qgw==
X-Google-Smtp-Source: AGHT+IHVkagXCx3fkpSIjgLt9WHN15EDl/XDVnrpgRaotm6vc3qL2n1cXtP+BBxz4rpWyMt8rbVuIQ==
X-Received: by 2002:a05:6512:3e05:b0:50e:7bbb:55c with SMTP id
 i5-20020a0565123e0500b0050e7bbb055cmr1140634lfv.139.1704449955448; 
 Fri, 05 Jan 2024 02:19:15 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 p4-20020a170906604400b00a298ade2e72sm83965ejj.195.2024.01.05.02.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 02:19:14 -0800 (PST)
Message-ID: <805ca196-5464-4023-a1c1-97d5a6699c1b@linaro.org>
Date: Fri, 5 Jan 2024 11:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: inesvarhol <inesvarhol@proton.me>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
 <61fd13b3-7cc9-4e27-bf91-bd2b4aedf97b@linaro.org>
 <ZjC6phtwjcDoQP-NDP6GF-dvCVK8Ctk9EeW_JezuNBqnQq4-V6NU6eAhECMqxJzMDRxwjbb-LPcHTvysc6YGuLD7ckWhbtpqD1g9lnklofI=@proton.me>
 <5f624a13-0ba0-4d9a-8910-2ef1c784a295@linaro.org>
In-Reply-To: <5f624a13-0ba0-4d9a-8910-2ef1c784a295@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/1/24 11:13, Philippe Mathieu-Daudé wrote:
> (+Mark & Eduardo)
> 
> On 4/1/24 14:37, inesvarhol wrote:
>>
>> Le jeudi 4 janvier 2024 à 14:05, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> a écrit :
>>
>> Hello,
>>
>>>> +static void test_edge_selector(void)
>>>> +{
>>>> + enable_nvic_irq(EXTI0_IRQ);
>>>> +
>>>> + / Configure EXTI line 0 irq on rising edge */
>>>> + qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
>>>
>>>
>>> Markus, this qtest use seems to expect some stability in QOM path...
>>>
>>> Inès, Arnaud, having the SoC unattached is dubious, it belongs to
>>> the machine.
>>
>> Noted, we will fix that.
>> Should we be concerned about the "stability in QOM path" ?
> 
> Don't worry about this Inès, I wanted to raise Markus attention on this.
> 
> You showed a legit use of stable QOM path, and Markus told me recently
> there is no contract for QOM paths (it shouldn't be considered as a
> stable API). IIRC Markus explanation, "/unattached" container was
> added as a temporary hack to allow migrating QDev objects to QOM (see
> around commit da57febfed "qdev: give all devices a canonical path",
> 11 years ago).

Hmm am I getting confused with "/peripheral-anon" (commit 8eb02831af
"dev: add an anonymous peripheral container")?

> I agree anything under "/unattached" can be expected to be stable
> (but we need a community consensus). Then the big question remaining
> is "can any qom-path out of /unattached be considered stable?"
> 
> Regards,
> 
> Phil.


