Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE0736E40
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbxF-0002hG-B8; Tue, 20 Jun 2023 10:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBbxC-0002gt-UL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:03:30 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBbxA-0006Pv-IR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:03:30 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9881b9d8cbdso580030966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687269807; x=1689861807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfUNYCBnnQD/am7YvVSIXPfXCApqXHfqQmO85bOs4Vk=;
 b=flxQ51hg/gNnrRM+3RuJyVSW4iiRWqT18UHZUJ3czTUiL/Yw6uEAQ68d6N84wvqUFZ
 ZgF30PgTTN1zfvsnyd01jF2bj0AG7VEYaaLZZzhJGK7OCK29R/gDcR1/XL/pZJkJNlE+
 L/2WDLVVbbuCM3XS3M5n3S/sQXPRQtGqM1Wu4BUnT01y6GAZe1cT3ejXW4H3KxJcOSGc
 bZM8KbfzFWCPJL67BdBpOy1XjH6ormd4CV8tzVj8cr1lbwvRjoqQCf/7H4f9+UZ8CWm1
 /1s5JVa4HIaaEAv2/RxM9P6javvBR1TqXlflKYhE/KzRSDjfG0B1A77KfzZI7pEbYGGN
 vBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687269807; x=1689861807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfUNYCBnnQD/am7YvVSIXPfXCApqXHfqQmO85bOs4Vk=;
 b=EhgwcWlbtSjzVrKoRPdv9MyyyyzTaV/E5rQplIfDDlO+imj/LUmdB5Q1czEmyIAdPW
 qyojxVOrzP7OyrBcVINvFkT4jq2x/jsfPXSHtft1mSIJapptLCJ0w32IOP94Fpl2cZig
 ZyM7Xhq3g55M8zTPjzZPET/1KPuu9y9n7KWpAM4vTm4FfjDEF6hdy9vr6+S6WnTS3tV1
 ryDSFKTmUVb4B0B6Zch38GVX+kxcC6ouIVpf4RwT7sxJ4ksg5KYkMmIRzf8/anAQ1q8x
 cvAv8EzI3XfGS8E+JAM+3CG0l251m12IkK1eBSR2IRl65EBvVwf8JRkrllNF+9F01+kf
 wqAQ==
X-Gm-Message-State: AC+VfDzksd+Qv2QHR1fe/l10tjqKFriO2uVuWIFbRcjoxEY6m1Af072U
 6eWqn5jWZ+bqDxS69DRu6D/ERnIvEdgRZOhckowech1J
X-Google-Smtp-Source: ACHHUZ61N+UH77cPZR2oO4mNzmreEnfm06RWQh1YXJEK4dKc8rqt3S1Y2aBKhx9fkWc55WjswJFCWA==
X-Received: by 2002:a17:907:1607:b0:982:b253:dc20 with SMTP id
 hb7-20020a170907160700b00982b253dc20mr11308475ejc.27.1687269806799; 
 Tue, 20 Jun 2023 07:03:26 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a170906068900b00988ca8b175dsm1474635ejb.119.2023.06.20.07.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 07:03:26 -0700 (PDT)
Message-ID: <d97d14f9-692f-8701-5637-d4566ea0075f@linaro.org>
Date: Tue, 20 Jun 2023 16:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 20/20] target/arm: Add cpu properties for enabling
 FEAT_RME
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230620124418.805717-1-richard.henderson@linaro.org>
 <20230620124418.805717-21-richard.henderson@linaro.org>
 <CAFEAcA-MpN2kM3c4F=ihSEgetSQJVd0T9-BTUakTu=CAc+4HTQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-MpN2kM3c4F=ihSEgetSQJVd0T9-BTUakTu=CAc+4HTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/20/23 15:52, Peter Maydell wrote:
> On Tue, 20 Jun 2023 at 13:46, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Add an x-rme cpu property to enable FEAT_RME.
>> Add an x-l0gptsz property to set GPCCR_EL3.L0GPTSZ,
>> for testing various possible configurations.
> 
> Looks OK to me, but I think we should document these
> (including that they're experimental and future syntax for
> enabling RME will change) in the "TCG VCPU Features"
> section of docs/system/arm/cpu-features.rst.
> 
> We could mention in the commit message here why we're
> making them experimental x- properties too.

Yes, of course.

r~


