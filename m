Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71E80A1B1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:01:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBYbB-0002u6-Bs; Fri, 08 Dec 2023 06:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBYaU-0002k7-Ui
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:00:08 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBYaS-0007zR-15
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:00:05 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cb20c82a79so7923061fa.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702033202; x=1702638002; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgAEyjXcA6+XsFXPCGoIawIS9X69PWGz3B+P/ILXyTA=;
 b=hGLMt6sU6xpJ1wSTXePmhkWy13gImadNGj2kZ0arm1ZjLPF8uzAaRBoHfSxwRoDc7q
 Z1n7aNTcq97Gk/UfsVlus4n/UTU3XAF+BjCfVUpLZPaAydFq33HTZD+zfqUuspJvNOrq
 OJOYAo1vOZMHXTSNo1ZpyeYBrjNc0iUOsyF7hUZ0DIK/trIuBch4/WSLBOrzF5JOQitT
 azp123V0urumAWQSj/KhW2/W8vya4qjQPi1X2hAbhwdowXiGSBszZ2bpOQEERFYiNHaI
 mN1zb1cB+2yKVERkRhQCQWMs9JI+884mCi0en2tEWo/cZLe6nfmwg3MT1tmv+W+uo7WI
 OEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702033202; x=1702638002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgAEyjXcA6+XsFXPCGoIawIS9X69PWGz3B+P/ILXyTA=;
 b=h6j7K9/A/aX8G45FfCNXGAcc49KbvxXcZONBAAGn2ie0OL6oW/TsPOkP/nwrEfdIuQ
 FDjy7XElGrvvlxhj2u7DZaZSuXkr964Jh5oZSEl3rOW58vc8ipUklXPdKMXjfWs3Vx86
 tvZKP3gTNH2fOikTq9UM6gPYOmVC7KM5srBSSeqRt+uvT+9u4nP6xrBa+O2X4sHnfeNP
 h+0uLjBT0pW2Jjfujr3OSmWM0fru2RRZcttawNwcgm2TJalDwkecSRMjosF7tepNNlXY
 dVY3CTla7DzeFH1fM8qGQC16wSd4j24XqWgNvfnR4E3fBUGcZVewtDHzWm306qvNVMeU
 mchg==
X-Gm-Message-State: AOJu0YxGirUIGfjFS5aYd6QKlFWLx6jD+3iE+diJVcylJOAvGuF2rjoZ
 y4cVFHvTJwkHcm+ORTLhqGwyw0k3uQrkSnLeEpz4sw==
X-Google-Smtp-Source: AGHT+IH7P2rvcP0+mAak74CNK22ibeT93WwBRQRavQCQSlJAjyqy2ExYXRjgboMJPzh6uyEJOhn11SpFShaC6isc42A=
X-Received: by 2002:a05:651c:117:b0:2c9:ffd9:3c0a with SMTP id
 a23-20020a05651c011700b002c9ffd93c0amr2277939ljb.37.1702033201910; Fri, 08
 Dec 2023 03:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20231207154550.65087-1-philmd@linaro.org>
 <20231207154550.65087-3-philmd@linaro.org>
 <9508bf5e-a554-468f-ba94-4d6f1a5be7bf@linaro.org>
 <323be810-5f4e-4218-812a-7c0ebc858599@linaro.org>
In-Reply-To: <323be810-5f4e-4218-812a-7c0ebc858599@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Dec 2023 10:59:51 +0000
Message-ID: <CAFEAcA-HVf8vWLzmdStEo2NrSKQdZV612rBjiaj-gLW4vXyvpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] target/arm: Ensure icount is enabled when
 emulating INST_RETIRED
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Fri, 8 Dec 2023 at 10:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 7/12/23 23:12, Richard Henderson wrote:
> > On 12/7/23 07:45, Philippe Mathieu-Daud=C3=A9 wrote:
> >> pmu_init() register its event checking the pm_event::supported()
> >> handler. For INST_RETIRED, the event is only registered and the
> >> bit enabled in the PMU Common Event Identification register when
> >> icount is enabled as ICOUNT_PRECISE.
> >>
> >> Assert the pm_event::get_count() and pm_event::ns_per_count()
> >> handler will only be called under this icount mode.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   target/arm/helper.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/target/arm/helper.c b/target/arm/helper.c
> >> index adb0960bba..333fd5f4bf 100644
> >> --- a/target/arm/helper.c
> >> +++ b/target/arm/helper.c
> >> @@ -940,11 +940,13 @@ static bool instructions_supported(CPUARMState
> >> *env)
> >>   static uint64_t instructions_get_count(CPUARMState *env)
> >>   {
> >> +    assert(icount_enabled() =3D=3D ICOUNT_PRECISE);
> >>       return (uint64_t)icount_get_raw();
> >>   }
> >>   static int64_t instructions_ns_per(uint64_t icount)
> >>   {
> >> +    assert(icount_enabled() =3D=3D ICOUNT_PRECISE);
> >>       return icount_to_ns((int64_t)icount);
> >>   }
> >>   #endif
> >
> > I don't think an assert is required -- that's exactly what the
> > .supported field is for. If you think this needs additional
> > clarification, a comment is sufficient.
>
> Without this I'm getting this link failure with TCG disabled:
>
> ld: Undefined symbols:
>    _icount_to_ns, referenced from:
>        _instructions_ns_per in target_arm_helper.c.o
> clang: error: linker command failed with exit code 1 (use -v to see
> invocation)

I think we should fix this earlier by not trying to enable
these TCG-only PMU event types in a non-TCG config.

-- PMM

