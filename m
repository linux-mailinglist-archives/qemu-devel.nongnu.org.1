Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A247A479F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:54:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBsl-0004JI-9s; Mon, 18 Sep 2023 06:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qiBsi-0004Iz-Nc
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:53:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qiBsf-0008Na-Tu
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:53:31 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso3050302b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695034408; x=1695639208; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGEs1ZuDwfjA6KXSIPo8Y9eCw7AWU32MJQyELGbr5Zg=;
 b=UAmjk3FfJ0e8ZFzev/+Rtx0aQ/1lPXqCenEhI0y3dgsNNpKjcj4oYD2JwJpQ6p8S/5
 4TwY3ujaY+C+BnU+ql20M9Cr5nc5Ssrbb0AT78HccH9wNEVc6QfDOmPjr5UrCAdHLfjL
 cjCFXLXv/fp2gInDtHVvensWPXo5e22atbmNrgvktS56FgHDXUQD83oB6UcAcTGKiDYG
 bo1idxWf49hrpZoOqzd7aBYh16zZ7xZ3qNww/l12sLqHctcfP+3foXNtEScWSjufILWf
 f9jMQPN3SatFdFLhBQ8etcNRV/VIJsde0DMWsjfIXx0oBN4B23m5GujnngQv/hbY2OAC
 2h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034408; x=1695639208;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iGEs1ZuDwfjA6KXSIPo8Y9eCw7AWU32MJQyELGbr5Zg=;
 b=NiKSHn2rmt+/mF/oPlPTr158qRXTkkQg4FwruDLPMWfRNkvZEnwrTMf/siT6Hy+Jnx
 UYGrGVbX4mLWIxmt9DsHal3hsw4nLqir5UBz1mzUv1OMDb1itH7jGImv6pmvAgCdiDXl
 +wlEKjs7Ok8eTTJR7ShUxIFGYUDGT5P8HMfyg/iDPXt+Y8f4AklPRQLaqkUAEAl4W6He
 6UTZjXIkYoFD61Cr8rYLJXGuNXmJw+BaT05zpU4UqrQMed1zcQJKuPMfG77Cz/Tq9f2G
 9kf8LZB2HPpARWs2c7aedX7KgFhUx92evCaIDa1broG9PfQK47yca7hgV5OFOZ9MwVzb
 u/1Q==
X-Gm-Message-State: AOJu0YzxUxpWYMLXLbybb3O+WJO+59Qk/XbFt4wPhBkaj4dOKf/2F+DP
 brWEKWi6OjcyS58t9pyy2IV6AuxWroc=
X-Google-Smtp-Source: AGHT+IHZEg7dxD8Xqe8LoN0GxsKXqShySVo9jfBaBmn074U1PnaZf5BwX5g3l9FLOZivTEF0cen+9A==
X-Received: by 2002:a05:6a00:8086:b0:68e:16ce:f2e3 with SMTP id
 eh6-20020a056a00808600b0068e16cef2e3mr16380363pfb.0.1695034408304; 
 Mon, 18 Sep 2023 03:53:28 -0700 (PDT)
Received: from localhost (61-68-209-218.tpgi.com.au. [61.68.209.218])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a62ed04000000b0068fb9965036sm6882144pfh.109.2023.09.18.03.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:53:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Sep 2023 20:53:23 +1000
Message-Id: <CVLZJR0IZQHP.2SLPV8WML9QJ0@wheely>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Ivan Warren"
 <ivan@vmfacility.fr>, <qemu-devel@nongnu.org>
Subject: Re: [PULL 01/39] accel/tcg: mttcg remove false-negative halted
 assertion
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230916033011.479144-1-richard.henderson@linaro.org>
 <20230916033011.479144-2-richard.henderson@linaro.org>
 <CVLU8T2IALFW.1BIYIZ1T0NEJ6@wheely> <87v8c7x668.fsf@linaro.org>
In-Reply-To: <87v8c7x668.fsf@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Sep 18, 2023 at 5:59 PM AEST, Alex Benn=C3=A9e wrote:
>
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
> > On Sat Sep 16, 2023 at 1:29 PM AEST, Richard Henderson wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >>
> >> mttcg asserts that an execution ending with EXCP_HALTED must have
> >> cpu->halted. However between the event or instruction that sets
> >> cpu->halted and requests exit and the assertion here, an
> >> asynchronous event could clear cpu->halted.
> >>
> >> This leads to crashes running AIX on ppc/pseries because it uses
> >> H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted =3D 1 and
> >> H_PROD sets other cpu->halted =3D 0 and kicks it.
> >>
> >> H_PROD could be turned into an interrupt to wake, but several other
> >> places in ppc, sparc, and semihosting follow what looks like a similar
> >> pattern setting halted =3D 0 directly. So remove this assertion.
> >>
> >> Reported-by: Ivan Warren <ivan@vmfacility.fr>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> Message-Id: <20230829010658.8252-1-npiggin@gmail.com>
> >> [rth: Keep the case label and adjust the comment.]
> >
> > Hey Richard,
> >
> > Thanks for picking this up.
> >
> > I think EXCP_HLT and EXCP_HALTED are effectively the same, so they coul=
d
> > be merged after this.
> >
> > I couldn't quite decipher the intended difference between them, HLT is
> > "hlt instruction reached", but it does tend to go into a mode where it
> > is halted waiting for external event. Is there some useful difference i=
n
> > semantics we should retain (and at least try to find a way to assert)?
>
> I always thought HALTED was where the system was halted (e.g. during a
> shutdown) but I agree its less than clear.

Maybe that was so. I didn't manage to track down the original intention
of them, but now they are not different, HALTED does just wait for event
too. EXCP_HALTED did previously require the operation set ->halted =3D 1
before calling (the assert only breaks due to concurrent wakeup clearing
it). But some ops that use EXCP_HLT also set ->halted.

So nowadays halted =3D=3D 1 means to check ->cpu_has_work() before running
the CPU again (and otherwise wait on io event as you say). And
EXCP_HLT/HALTED are both just ways to return from the cpu exec loop.

One thing I'm not sure of is why you would set EXCP_HLT without setting
halted. In some cases it could be a bug (e.g., avr helper_sleep()), but
there are a few ops that use it after a CPU reset or shutdown which
might be valid. Could call those ones something like EXCP_RESET or
EXCP_REEXEC.

Thanks,
Nick

