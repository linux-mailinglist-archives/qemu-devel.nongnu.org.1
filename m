Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F36847EECB4
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:37:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3tOk-0000gi-PT; Fri, 17 Nov 2023 02:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3tOj-0000gG-34; Fri, 17 Nov 2023 02:36:17 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3tOh-00020l-EY; Fri, 17 Nov 2023 02:36:16 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso1550156b3a.3; 
 Thu, 16 Nov 2023 23:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700206573; x=1700811373; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U272Shfbi09nmiC8esoIUSvWSwAt7r+8XrgEzsrEX0=;
 b=eb7s+6MNUk3FgeHwpsMU8x36pCTC+85RXe35xOQP428OvPjN6v3rn1mLxr37pmaHW/
 eyFnzXoyBzpuDJCnn4dnEIN4qcqUFYakEw2L8tIoedb4MRbVHnXESe/LPcYp5N26qeuo
 FoaWxvezdefFNEYotmIXpfB804anWoUN32FhqBRUpC3Hd+Pey87X0f6GmVM0UeQks3hR
 7Y507ikSNmiunfLIUYTZlTonI471yNTqledSdLh0HxrdMO/D5aWPiisIJTvVfx9ABXC0
 31lWxUWsDkxvgX51U5eFq7ayqgLYkF3/LmAIWiD1qDBgrMs6djTUKkFc0hhNmgRBms49
 dqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700206573; x=1700811373;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/U272Shfbi09nmiC8esoIUSvWSwAt7r+8XrgEzsrEX0=;
 b=xAgbqVFgkYtrMM/UtPrCEHwHwZ3fIzGzVeSzv0pXJxKcuGfuh854qV7caHaMjcpv8I
 mG+pY1z3bQjdacIwtXBzMfuNT7+KnTRRsu31Hf5RP3vIa/I0e8BwA7yczJS7SoaSuPEf
 AHZkPaEUF5lFlTbfEouMEcSJgNp1urv3YvpJb+TIh9Tavu7bjXXoQnlEBDeI7J1AikSD
 WcD4+FITB5Csd6Qava+pTkNiICl6goSnYNoubG0gUNrmC1J5smAVFW1nPGXuE9MRx40B
 abZcDTqkoMCBskoK08McrzJ0NP6Dk2ZS/8dry/UCOPhgZ8o40l9cDD1TSG0ROjrHcQHb
 RAPw==
X-Gm-Message-State: AOJu0YwF+EDi0WRoh+ktqO6BGd/su7gZADPvMZmQ8QYruEpASTLLlvOh
 TazB+UK3dpUnEkCr59WLLnE=
X-Google-Smtp-Source: AGHT+IGZzxxr2DLAaavstft3FInE/Z0ZL1zZ7tDcYcOrSfTPJ1l1Xp+caq2FjdalyYyrCmwkEt8yJA==
X-Received: by 2002:aa7:8550:0:b0:6c5:7a6:e1d with SMTP id
 y16-20020aa78550000000b006c507a60e1dmr16823253pfn.29.1700206572832; 
 Thu, 16 Nov 2023 23:36:12 -0800 (PST)
Received: from localhost ([1.146.110.245]) by smtp.gmail.com with ESMTPSA id
 p17-20020a056a000b5100b006889511ab14sm853246pfo.37.2023.11.16.23.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 23:36:12 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Nov 2023 17:35:42 +1000
Message-Id: <CX0WX30H69LM.3MYDJODZ4LQWF@wheely>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Cleber Rosa" <crosa@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Ani Sinha" <anisinha@redhat.com>, =?utf-8?b?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?=
 <berrange@redhat.com>, "John Snow" <jsnow@redhat.com>,
 <qemu-ppc@nongnu.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/3] tests/avocado: Enable reverse_debugging.py tests in
 gitlab CI
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-3-npiggin@gmail.com>
 <24a194bc-81c6-44ae-9113-94ed28cc4f71@redhat.com>
In-Reply-To: <24a194bc-81c6-44ae-9113-94ed28cc4f71@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Nov 17, 2023 at 4:11 AM AEST, Thomas Huth wrote:
> On 16/11/2023 12.53, Nicholas Piggin wrote:
> > Let's try enable reverse_debugging.py in gitlab CI.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Maybe we could try this again at some point? The bug might have been
> > noticed sooner.
> >=20
> > They only take a couple of seconds to run so should not take too much
> > overhead. But my gitlab CI pipeline doesn't run the avocado tests for
> > some reason, so I can't see if it's still causing problems.
> >=20
> > Thanks,
> > Nick
> > ---
> >=20
> >   tests/avocado/reverse_debugging.py | 7 -------
> >   1 file changed, 7 deletions(-)
>
> FYI, I gave it a try, and it survived my CI run:
>
>   https://gitlab.com/thuth/qemu/-/jobs/5552213972#L403
>
> So I went ahead and put it (together with the first patch) in my current=
=20
> pull request, let's see how it goes...

Great, thank you.

> (for the second patch, I hope our chardev maintainer Marc-Andr=C3=A9 coul=
d=20
> comment on that first)

Yeah that would be good, no rush for that one. Maybe it's not desirable
for other reasons too.

Thanks,
Nick


