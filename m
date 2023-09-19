Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4E7A5E39
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:38:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXB6-0007e2-Gb; Tue, 19 Sep 2023 05:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXB3-0007dU-3Y
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:37:54 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXB0-00058N-DJ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:37:52 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b974031aeaso89300611fa.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695116267; x=1695721067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fNuKcrCa7CjC9RiahdhY9e/FWz9s48bP0kp+MPU30YA=;
 b=C26W54UhZocX0Uuaorcz12RRsEH2R4Qihdtwtl5ClvMnBQX/HtDY8Fkmb2TrixXBHi
 +UwGtHxtDadaOqzZjuV22gbEjUA3+fIxRqrIvbdVRSyOnbap3UINLYQF0wzOzWFxkJSl
 sznpOJ814OUY/4qHhaMcpvzPv0gylRz2Y6Fbioui9boZTsuPZm3oakrecmdDEkJJoqww
 ZfSxXUbSIkOYd3qBNyHmbs5ug4k5OcYkGBKz+jecxJ27mdq3FwxRD2Zf86URD8T3SvKU
 91YggrZ2NLdqhz/7p8qq+ncjzLiiob+1U8ytqhxFqy59NyGfkVyxqTJ/ecIPweuLDmr7
 2eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695116267; x=1695721067;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNuKcrCa7CjC9RiahdhY9e/FWz9s48bP0kp+MPU30YA=;
 b=d04FGNq1IwX2A9yopmrK6Ze4UkoAS6LdFNzd4M6NpGZntwhq+43MAxRzGYGJBnL4Rj
 tKKSC/g1r9pi8kFe5Ml4V3zq/NggNmUtPREdl8e+547kbHe/anvzEItVONj7At4JRunT
 QLA8sCPmSHbBg3ppM6ysb6YrdE3HjDN67nyADAYvj4tj8Da8FUzqDsQ5/vqL7k+ocT2x
 PjPoBZcsAfl6GOm7/OieDaxohJsoFnLUY/2XfPJT/hd9ZbUfiiAUT8mZLZdDzaOwN1Kf
 S//mQ4f+F86K8mJFlZ3tUcz1gyWbFoCVqesyeFA/qsfNEZAh5luU2q0oPb63Ypd6LbxX
 X7kw==
X-Gm-Message-State: AOJu0YwDb8C0fLMqaznKoEqluliZYBB/InMIzoLqlkrWDyEEgAK2A4s6
 QjJh8k4MUydL/aKRV4Uh3yJ53g==
X-Google-Smtp-Source: AGHT+IHriN2U+VUSmViLz+d86TADQZeQ3aOcrbjAQ9Ic783UK1aEXgt+i2fVosZOeNVoydoxKYsl9Q==
X-Received: by 2002:a2e:be28:0:b0:2bf:eccb:548 with SMTP id
 z40-20020a2ebe28000000b002bfeccb0548mr7886461ljq.0.1695116266982; 
 Tue, 19 Sep 2023 02:37:46 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 u17-20020a17090657d100b009a5c98fd82asm7571801ejr.81.2023.09.19.02.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 02:37:46 -0700 (PDT)
Message-ID: <4beba72a-968a-d32e-1fcb-ba09a7bf6fce@linaro.org>
Date: Tue, 19 Sep 2023 11:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] accel/tcg: Always require can_do_io
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914174436.1597356-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 19:44, Richard Henderson wrote:
> Require i/o as the last insn of a TranslationBlock always,
> not only with icount.  This is required for i/o that alters
> the address space, such as a pci config space write.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c      | 20 +++++++-------------
>   target/mips/tcg/translate.c |  1 -
>   2 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


