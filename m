Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9AE7F34E9
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:25:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5UUc-0000Ok-MY; Tue, 21 Nov 2023 12:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r5UUb-0000OV-6U
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:24:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r5UUZ-0006O1-Ay
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:24:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso19844315e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700587494; x=1701192294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJQ/onAn2xH3uj0/HxmqCjRnsjukcL+sLDS7EdDUbac=;
 b=SkY5BI5u1sfnM3mVVaZ/YPZo1sAK4Qd9mBeHticSLkoH1mOUrtKgSL4OYz3YDd3kyJ
 YcEdh1ekwVPW4NXz//byp82fOMtQlNDAjCqf5QEDD0zlOoFY4jA7rN4Gm2DidOdA4AT1
 6RxWJ5JthkRsvy2FAc8jc6e4h7TGqLdJIXP0ZUZb2NCVKm4i+Ug55odCIjFEgSxaia7S
 mWOHJsNWWEbHqzDf2gP3izTNMNjt7vuj2BdXZybey5mB9ICGdDYWsmwIs5ykoENZInTI
 6fVVffwNvJssDpEGrTf24GX+oEFF6N+Ms9ff6STUdoxl0owrix7KYir3Y8D7WSKLzPAr
 +OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700587494; x=1701192294;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fJQ/onAn2xH3uj0/HxmqCjRnsjukcL+sLDS7EdDUbac=;
 b=w8wyt7S8omsiBDarBCua61i5MLTudbL32yfvl0n3YDctO8mN77W604fz+nL2bi48Be
 lY1tRdEPPICI6u/928rkV+QR3WrqsycKm6QUGDJF4BMFlylEigfmVGFgHNHKwfeKfbtT
 lfobLb6UJPTPeGbiMg5M0x3jYkw+HeaQz1beOk2YgOXLLkvhaGvCIImjKT5Q53Bh0I53
 sVFOSG6HlsG73SMtRkAO9aBqMmSrUv32eZXwldSbbMUx1rOI5Nkzn3wXqMTBYkqJuME6
 wfwtQ43CSjLkkY3nE0mKBPImKC15ZJms2z/lqKYBxoHqzoj33GwkcEEmOnHiyIJwaWOp
 sUew==
X-Gm-Message-State: AOJu0Yy0/XsK2FNB20TzfSQgup73UPibUeykF6tVGF24vS8hIgoyxwDt
 Qtgku1pRclCjly1FGLUYy7aTmw==
X-Google-Smtp-Source: AGHT+IFkr9I6QCeo/tXCoh3jHDkkk8mcpYSfEX/zxoJFHyfFIU2b8NvKqrMKQHzwq3AOeU/s/Jdw/Q==
X-Received: by 2002:a05:600c:45c7:b0:401:c8b9:4b86 with SMTP id
 s7-20020a05600c45c700b00401c8b94b86mr12067wmo.9.1700587493671; 
 Tue, 21 Nov 2023 09:24:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d34-20020a05600c4c2200b0040a48430837sm21650332wmp.13.2023.11.21.09.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:24:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5D185F74B;
 Tue, 21 Nov 2023 17:24:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: Re: Instruction virtual address in TCG Plugins
In-Reply-To: <f79fe2c0d7e5457ca7172862e96fd886@yadro.com> (Mikhail Tyutin's
 message of "Tue, 21 Nov 2023 16:39:25 +0000")
References: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com>
 <87leb1xtdx.fsf@draig.linaro.org>
 <e44e7be4b0b44ea2882fbfe09f3b58f4@yadro.com>
 <874jhoy54t.fsf@draig.linaro.org>
 <f79fe2c0d7e5457ca7172862e96fd886@yadro.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Tue, 21 Nov 2023 17:24:52 +0000
Message-ID: <878r6rf28r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Mikhail Tyutin <m.tyutin@yadro.com> writes:

>> >> > I suspect it is because of memory mappings by guest OS that changes=
 virtual addresses for that block.
>> >> >
>> >> > I also looked at gen_empty_udata_cb() function and considered to ex=
tend plugin API to pass a program counter
>> >> > value as additional callback argument. I thought it would always gi=
ve me valid virtual address of an instruction.
>> >> > Unfortunately, I didn't find a way to get value of that register in=
 architecture agnostic way (it is 'pc' member in
>> >> > CPUArchState structure).
>> >>
>> >> When we merge the register api you should be able to do that. Although
>> >> during testing I realised that PC acted funny compared to everything
>> >> else because we don't actually update the shadow register every
>> >> instruction.
>> >
>> > We implemented similar API to read registers (by coincidence, I posted=
 this patch at the same time as the API you
>> > mentioned) and I observe similar behavior. As far as I see, CPU state =
is only updated in between of executed translation
>> > blocks. Switching to 'singlestep' mode helps to fix that, but executio=
n overhead is huge.
>> >
>> > There is also blocks 'chaining' mechanism which is likely contributes =
to corrupted blocks vaddr inside of callbacks.
>> > My guess is that 'pc' value for those chained blocks points to the fir=
st block of entire chain. Unfortunately, It is very
>> > hard to debug, because I can only see block chains when I run whole Li=
nux guest OS. Does Qemu has small test
>> > application to trigger long enough chain of translation blocks?
>>=20
>> No all registers should be resolved by the end of any block. There is
>> currently no optimisation of register usage between TBs. If you are
>> seeing PC corruption that would be a bug - but fundamentally things
>> would break pretty quick if tb_lookup() and friends didn't have an
>> accurate PC.
>
> I managed to root cause source of corrupted addresses in plugin callbacks.
> There were basically 2 problems:
>
> 1. Memory IO operations force TCG to create special translation blocks to
> process that memory load/store operation. The plugin gets notification for
> this translation block as well, but instrumentation callbacks other than
> memory ones are silently ignored. To make it correct, the plugin has to m=
atch
> instruction execution callback from previous TB to memory callback from t=
hat
> special TB. The fix was to expose internal =E2=80=98memOnly=E2=80=99 TB f=
lag to the plugin to
> handle such TBs differently.

Are you talking about the CF_MEMI_ONLY compile flag? We added this to
avoid double counting executed instructions. Has there been a clash with
the other changes to always cpu_recompile_io? This was a change added to
fix: https://gitlab.com/qemu-project/qemu/-/issues/1866

Richard is going to look at optimising the cpu_recompile_io code so we
"lock in" a shortened translation once we discover a block is doing
MMIO. See https://linaro.atlassian.net/browse/QEMU-605 for an overview.

> 2. Another problem is related to interrupts handling. Since we can insert=
 pre-
> callback on instructions only, the plugin is not aware if instruction is
> actually executed or interrupted by an interrupt or exception. In fact, it
> mistakenly interprets all interrupted instructions as executed. Adding API
> to receive interrupt notification and appropriate handling of it fixes
> the problem.

We don't process any interrupts until the start of each block so no
asynchronous IRQs should interrupt execution. However it is possible
that any given instruction could generate a synchronous exception so if
you need a precise count of execution you need to instrument every
single instruction. With enough knowledge the plugin could avoid
instrumenting stuff that will never fault but that relies on baking
additional knowledge into the plugin.

Generally its only memory operations that can fault (although I guess
FPU and some more esoteric integer ops can).

>
> I will send those patches for review shortly and thank you for dissuading=
 me
> from going to wrong direction!

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

