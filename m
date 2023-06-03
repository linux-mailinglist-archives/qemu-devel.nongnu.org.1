Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE21E721133
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 18:21:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5TyL-0005m2-Nb; Sat, 03 Jun 2023 12:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q5TyJ-0005lM-PS
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 12:19:19 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q5TyI-0001I4-2c
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 12:19:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51496f57e59so4317684a12.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685809155; x=1688401155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VA+YzqgIpFcYLlBlrPTBzjLSYTAFBcz3KlXovQg/1Ck=;
 b=F/Gobysvdn/5F7VVB2LchhvihO0800bWOUMaNddbA/biLN2bu0miR3pdo/7/T3tz9F
 ffjv8Shuk5ByEG/dmpm77hNt3HId88n9XyCB4y4u4tWVgkqwf/1MOqv0iS2lewn82hNO
 lc7J6CsAmSPxR//1CuybniB8TIdsg9IlAJei/7ruji5nnyZm+d7a1dpYkD3l8f07C/5d
 2rpieyVH06YH9ZRomGaGunjBQYCz5yuZI3/GtxIwslJzbXqtQIbOOzvPUhXsplqdsn7A
 q5bTgHXfU18pUfnfw1dp1hyqYnqNn6Gg8uxXvWX5GhlhhUQyTBh6lQ+b6inI2dq8qKZU
 pssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685809155; x=1688401155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VA+YzqgIpFcYLlBlrPTBzjLSYTAFBcz3KlXovQg/1Ck=;
 b=SnKQjxKMVdyYXNNdGEdOQBXdQ+r1Q20riWA2nc55v3FNSG+Zyp93/4lkePmMmoN3EO
 M5kEkWhr3tBdQvkLdb0SqgJ4dAADjEle34KE/+v8JoZEMizff7nracu+R4JLtIpjxDRa
 q2vHaYpwHPEPiwDEWTL8VzrUJzuspKEtYQuuvTEdnThi1K3uyh+hIGh6Og/EZeCxdMEl
 fVXWlRxnWpAP5XykBmJK7w45EC5+UsHvfMF4imIC9Nb60j1PmwMt8ceQVZHLo4t+4e+I
 YTYV3Bm3cOYJCu05qnqvX0mJQ4xZyTeptWO7h3UMyiH2a3mE19A74xohjSmzt3KekoK+
 Eglw==
X-Gm-Message-State: AC+VfDy1ZYVpnXIkvSUULwOp5BFg9QVDbqfySxNb25heiAAFvWeIIdMz
 CRVL5YWqwMCmnku954Yb/O1X62+/GFdxbnfbi9Yq/Q==
X-Google-Smtp-Source: ACHHUZ5VpE6zQ1Kb43nDYtF7MZThjnGEp55o/tySc93CqZ+fY2mnC8BiObsAkmBe6oAsHucC3bzJC869Ru8LBcPZVxI=
X-Received: by 2002:aa7:df81:0:b0:514:af52:e49a with SMTP id
 b1-20020aa7df81000000b00514af52e49amr4004988edy.25.1685809155571; Sat, 03 Jun
 2023 09:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-14-peter.maydell@linaro.org>
 <13e60074-adc0-f3f2-e5fe-f48e6778cf04@linaro.org>
In-Reply-To: <13e60074-adc0-f3f2-e5fe-f48e6778cf04@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Jun 2023 17:18:43 +0100
Message-ID: <CAFEAcA9mi0KxN5Ncvm-h5h0Ydjh1X6q2Xbq-9PtxSC2LdTtGDg@mail.gmail.com>
Subject: Re: [PATCH 13/20] target/arm: Convert LDR/STR with 12-bit immediate
 to decodetree
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 2 Jun 2023 at 21:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Peter,
>
> On 2/6/23 17:52, Peter Maydell wrote:
> > Convert the LDR and STR instructions which use a 12-bit immediate
> > offset to decodetree. We can reuse the existing LDR and STR
> > trans functions for these.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/tcg/a64.decode      |  25 ++++++++
> >   target/arm/tcg/translate-a64.c | 103 +++++---------------------------=
-
> >   2 files changed, 41 insertions(+), 87 deletions(-)
> >
> > diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> > index 4dfb7bbdc2e..c3a6d0b740a 100644
> > --- a/target/arm/tcg/a64.decode
> > +++ b/target/arm/tcg/a64.decode
>
>
> > +# Load/store with an unsigned 12 bit immediate, which is scaled by the
> > +# element size. The function gets the sz:imm and returns the scaled im=
mediate.
> > +%uimm_scaled   10:12 sz:3 !function=3Duimm_scaled
> > +
> > +@ldst_uimm      .. ... . .. .. ............ rn:5 rt:5 &ldst_imm unpriv=
=3D0 p=3D0 w=3D0 imm=3D%uimm_scaled
> > +
> > +STR_i           sz:2 111 0 01 00 ............ ..... ..... @ldst_uimm s=
ign=3D0 ext=3D0
> > +LDR_i           00 111 0 01 01 ............ ..... ..... @ldst_uimm sig=
n=3D0 ext=3D1 sz=3D0
> > +LDR_i           01 111 0 01 01 ............ ..... ..... @ldst_uimm sig=
n=3D0 ext=3D1 sz=3D1
> > +LDR_i           10 111 0 01 01 ............ ..... ..... @ldst_uimm sig=
n=3D0 ext=3D1 sz=3D2
> > +LDR_i           11 111 0 01 01 ............ ..... ..... @ldst_uimm sig=
n=3D0 ext=3D0 sz=3D3
> > +LDR_i           00 111 0 01 10 ............ ..... ..... @ldst_uimm sig=
n=3D1 ext=3D0 sz=3D0
> > +LDR_i           01 111 0 01 10 ............ ..... ..... @ldst_uimm sig=
n=3D1 ext=3D0 sz=3D1
> > +LDR_i           10 111 0 01 10 ............ ..... ..... @ldst_uimm sig=
n=3D1 ext=3D0 sz=3D2
> > +LDR_i           00 111 0 01 11 ............ ..... ..... @ldst_uimm sig=
n=3D1 ext=3D1 sz=3D0
> > +LDR_i           01 111 0 01 11 ............ ..... ..... @ldst_uimm sig=
n=3D1 ext=3D1 sz=3D1
>
> Why not use "sz:2 111 0 01 sign:1 ext:1", returning false for the
> cases not covered?

That would also catch the PRFM case (which is size=3D0b11 sign=3D1 ext=3D0
in your pattern); and it gives the wrong ext value for 11 111 0 01 01.

You could do more of the decode in the trans_ functions and less
here; but my impression is that we tend to prefer decoding in the
.decode file where we can.

thanks
-- PMM

