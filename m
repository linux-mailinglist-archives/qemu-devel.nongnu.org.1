Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C781C82519E
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:15:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhCt-0004fc-RX; Fri, 05 Jan 2024 05:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLhCs-0004f2-2z
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:13:38 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLhCq-00014j-Gi
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:13:37 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a28f66dc7ffso77588266b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704449615; x=1705054415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xjJ+95yF+JJvIZcDqZBEdqJd9NZpOgcervqv2+aiesI=;
 b=ow2c92kf2ztypgtQ8z4Z55zev/zMRz+yaiYkC5g4I1iTMhSE8eVAUxwHpM62tJGMV6
 YijRN4PeJ2R96EIoFl0l3zMi1XE/El6Stl9YYvJE1h7GJXHAwMUFl09ZYt6XCCTijXKs
 ldGlVDwAA5JRJpfKAwKOpFUtlc0ud/Y8KUlNPs5wAg8lSiUI7N13Zx5lpQNvORm05Tlw
 V3SSfhe9EXZPrg2LBtKh/Rw15LcaoGNHe5ifgqcJog6aIY1tgWWIXVGPQCiA/rfO/pbx
 aXzePGz6yhVthAb11QHmRBjdO6rEdoFdGD4LUY39GULp/kGsFeD/cXeN3+hzvHasZEoZ
 IUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704449615; x=1705054415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xjJ+95yF+JJvIZcDqZBEdqJd9NZpOgcervqv2+aiesI=;
 b=TMVL99EwehH367FLF6DR+uCKF0itwxIYKHEznpUhcccubGdfJ3vMcvns6eWWXnBvxS
 fQJ1fCSD0cuEY8r5lTc8qiG9uq6ioLcLbhSsmm0S90ZTnWBAI3/8wbY28nH5tTyEQ/vP
 vYMhAIH3epiO4J3l9+c/WhFvGhGXiRAoTvWEDopzBeDaQ3U2NqhEvYkwRZL75NzZvAE9
 hlnrXV2l9wUyylr6kFmIBWufEzBg4Xb+oDyJUJYtwRwmDde03VUstD8quP6rnNEOJ02S
 OXV8lNXoLqZbAmBNlO+ImaCmj6llAwJk4u3r4pDR/7IdsxV8AqbBDA3I+CARHMekc14/
 Etsw==
X-Gm-Message-State: AOJu0YzE8PoacFjsIMeVlXWICMphF82b6oI9i1Wpdt24W1u/4tNMB+sZ
 M3W0biGja/M6WTGr0DP8mWI5OYiyTli98Q==
X-Google-Smtp-Source: AGHT+IEmUAI8ujLL2lsKAadyZ8Bh4ixOcY30kzp2L95VDoKkFq3hvUPq9MQOF2vacMfvvTwKbhLoEA==
X-Received: by 2002:a17:906:4a4e:b0:a28:26e9:a13d with SMTP id
 a14-20020a1709064a4e00b00a2826e9a13dmr1732495ejv.55.1704449614711; 
 Fri, 05 Jan 2024 02:13:34 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 t13-20020a170906178d00b00a28cf49520asm701067eje.203.2024.01.05.02.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 02:13:34 -0800 (PST)
Message-ID: <5f624a13-0ba0-4d9a-8910-2ef1c784a295@linaro.org>
Date: Fri, 5 Jan 2024 11:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZjC6phtwjcDoQP-NDP6GF-dvCVK8Ctk9EeW_JezuNBqnQq4-V6NU6eAhECMqxJzMDRxwjbb-LPcHTvysc6YGuLD7ckWhbtpqD1g9lnklofI=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

(+Mark & Eduardo)

On 4/1/24 14:37, inesvarhol wrote:
> 
> Le jeudi 4 janvier 2024 à 14:05, Philippe Mathieu-Daudé <philmd@linaro.org> a écrit :
> 
> Hello,
> 
>>> +static void test_edge_selector(void)
>>> +{
>>> + enable_nvic_irq(EXTI0_IRQ);
>>> +
>>> + / Configure EXTI line 0 irq on rising edge */
>>> + qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
>>
>>
>> Markus, this qtest use seems to expect some stability in QOM path...
>>
>> Inès, Arnaud, having the SoC unattached is dubious, it belongs to
>> the machine.
> 
> Noted, we will fix that.
> Should we be concerned about the "stability in QOM path" ?

Don't worry about this Inès, I wanted to raise Markus attention on this.

You showed a legit use of stable QOM path, and Markus told me recently
there is no contract for QOM paths (it shouldn't be considered as a
stable API). IIRC Markus explanation, "/unattached" container was
added as a temporary hack to allow migrating QDev objects to QOM (see
around commit da57febfed "qdev: give all devices a canonical path",
11 years ago).

I agree anything under "/unattached" can be expected to be stable
(but we need a community consensus). Then the big question remaining
is "can any qom-path out of /unattached be considered stable?"

Regards,

Phil.

