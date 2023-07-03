Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6083745B58
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHsR-0003jA-1q; Mon, 03 Jul 2023 07:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGHsK-0003if-5u
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:37:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGHsI-0004CM-AF
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:37:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-314172bac25so4748208f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688384264; x=1690976264;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbULPilg+niIVSwnZ5OHnI7KxwkskeQ4B4pMjIxe4nA=;
 b=xdl+EjJrMLI0juMln7+L585aB9taEJpPQDZMiFbFiBtvDSqAhb2yRSTuYI45pMm3ov
 +nMyNurOpl+KrB7BqGFEFa/28L2/FL6tmq9LlPSZ572xzwM2vVza9FPFN+VyLtKTUfrF
 wJoy7AuoZoSwGkUp56XfC2itL4LqpNWMUROJybOc4JAGOn4EsziupFaqiIhEBagod/Jh
 aj6YRXVNiSbenrX4q5ueg7PkroFtyV16mTakb//R/77FDv2gte7vSb3g+Oq2qllSm8sM
 AY029zsV/Oty9P3jeV4doorE0AZCURgRV+wnz8XTWZoQw88ak/d3ABeg2fpgSmpqE2Lh
 ZEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688384264; x=1690976264;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lbULPilg+niIVSwnZ5OHnI7KxwkskeQ4B4pMjIxe4nA=;
 b=UMwerDOLA9h+e8jxKDbeVNu1wN/rw68WwA+MTHg3nGszVp9VyW6qopX8k0B4QhVivU
 Qim863BGEaAwiIZa9Rk4xLAe31qMiPjvmyBW5crMvC3aO1eUqBf7aw25IKoyj8X1+wmy
 mOPAGVkyPI/cn04Z2jCONL0Z/Xc+MHwpFD8fW3ddtwrYciCGXgIm2ilj31F8UuEk1s4g
 c4jPgXrJk6fJ95w0ujaGevZMxxZ67aeDIJPkC5FPmfT7PdJlFJbYXyOKul+VtSjheJsO
 KF/tE/ZSfa+AUZ7xjcrNamsvzS9Qj0hwuR4s4Mk62+5fN4UWRW9od5RnDTziVItRABQ4
 TyMg==
X-Gm-Message-State: ABy/qLYyYDrJvqkE/aFhqxIkzY3iOhil8CNplkM1pNT+T+tzQ04hrzcG
 DJwdLP6IV/taXqkKQbVDRlN00g==
X-Google-Smtp-Source: APBJJlE8uNOb18/WrSbIkrhAF2TwUW1xepJTuIEdp7zXNdNaT8XEcIx83yHCHfvEOKz5VTRfn0xGDw==
X-Received: by 2002:a5d:61d2:0:b0:313:e57b:e96d with SMTP id
 q18-20020a5d61d2000000b00313e57be96dmr7138529wrv.36.1688384264116; 
 Mon, 03 Jul 2023 04:37:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a056000194a00b0031134bcdacdsm25410859wry.42.2023.07.03.04.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 04:37:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 58ED61FFBB;
 Mon,  3 Jul 2023 12:37:43 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-8-richard.henderson@linaro.org>
 <873525jpja.fsf@linaro.org>
 <575a4b78-8267-96b1-4764-2e492a69dcc6@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 07/24] accel/tcg: Introduce page_check_range_empty
Date: Mon, 03 Jul 2023 12:36:29 +0100
In-reply-to: <575a4b78-8267-96b1-4764-2e492a69dcc6@linaro.org>
Message-ID: <87lefxi5tk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/3/23 11:45, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> Examine the interval tree to validate that a region
>>> has no existing mappings.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/cpu-all.h | 11 +++++++++++
>>>   accel/tcg/user-exec.c  |  7 +++++++
>>>   2 files changed, 18 insertions(+)
>>>
>>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>>> index 8018ce783e..5b2c230d52 100644
>>> --- a/include/exec/cpu-all.h
>>> +++ b/include/exec/cpu-all.h
>>> @@ -224,6 +224,17 @@ void page_set_flags(target_ulong start, target_ulo=
ng last, int flags);
>>>   void page_reset_target_data(target_ulong start, target_ulong last);
>>>   int page_check_range(target_ulong start, target_ulong len, int flags);
>>>   +/**
>>> + * page_check_range_empty:
>>> + * @start: first byte of range
>>> + * @last: last byte of range
>> * Context: holding mmap lock
>
> Is this parsable magic? Two lines below I do say "memory lock must be
> held"...

Yeah - the kerneldoc describes it as:

 * Context: Describes whether the function can sleep, what locks it takes,
 *          releases, or expects to be held. It can extend over multiple
 *          lines.

We use it in a couple of places in the existing code although mostly
referring to the BQL.

>
>
> r~
>
>> Otherwise:
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

