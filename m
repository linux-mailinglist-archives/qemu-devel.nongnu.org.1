Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9B73B34B
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCco7-00077j-SY; Fri, 23 Jun 2023 05:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCco5-00076z-Vx
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:10:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCco4-0006bQ-9a
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:10:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51be8edc657so387648a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687511413; x=1690103413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0SrNqzbZv2I41sbjAyhZIJ65TFui8JJKzaQciLBsjkg=;
 b=MBl/vk6slg1q9dEx3SPPcrTPr2zyLDB7gF1stxadv680/feNrVJrRPdp5kM+pidtX/
 nOWLwkNXbB8L63GyeCILh1Azw9PUt6FRtHShYG9ehaL5rXI9tx8VEdWiw8b86nLOtLJI
 ipivpzAx8el+hmgQQ80BpVo7UeyRklyXodxCJ3q3f4baPMkEQjr5q/woV57oXc1fgyQl
 a3Bg5NVbgJWwWYCdw2LZffmJFwIOdD6QVRarbfRkevr0WdVGCzBcN6+gGqOV7O5faF/D
 mSDOLEObmGBApyjESbwOTtp+8/Fud3k4a0e/loIhzUdwpRrkVtRml/E5LNjL/GpailGq
 5NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687511413; x=1690103413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0SrNqzbZv2I41sbjAyhZIJ65TFui8JJKzaQciLBsjkg=;
 b=hVVlRhI3MTyzrpr2Ez2/i9ttBYDMINfS+FdqU5i6VytRJml9sBpIFbkDMyK9Dy4EYk
 WWsJbttSVTnz6oc2QraE5n1FVvGmjdA2m50P2eyt9drkssHuo3LwNRZZb4a4folwxYTe
 qRQscgyK5e78ebF7f9T249Q0lB3Pkyo9mDhGzHJvAnZ2i8REWHuqxCf1t3Y2eSfwMzOm
 Sw9sdrHICA+avjdAo6Ylx8R3AYyVIEqegLtIfOsDx7L8y9XQSH63PzCRsPSIQ18mbkkn
 TNjZdzQf66ACWp2VVsSsJMMXgIbbiBBg0FobF+aIEWbJsZbt9rRM+yFZLVIM3mKfFTrD
 vsww==
X-Gm-Message-State: AC+VfDxvEN8w5P/C5qIGsMh7rVf9PQWUkiPNmAjD6c2TwShMwyOKRkMe
 lTYzp3D6R9nXRpk492sStsx9oHOviUCNyZY+ZhL4cQ==
X-Google-Smtp-Source: ACHHUZ5wS/5kGgOBTl7GEYB26zQuHW/X+Qxk2pve8Zm04YUbjqTkhZZ0CQn0X/42fZXEJC67fWwM1fzeOfPV/a3IY7g=
X-Received: by 2002:a05:6402:111a:b0:514:a110:6bed with SMTP id
 u26-20020a056402111a00b00514a1106bedmr13639933edv.27.1687511412974; Fri, 23
 Jun 2023 02:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230623081953.290875-1-npiggin@gmail.com>
In-Reply-To: <20230623081953.290875-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 10:10:02 +0100
Message-ID: <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> ppc has always silently ignored access to real (physical) addresses
> with nothing behind it, which can make debugging difficult at times.
>
> It looks like the way to handle this is implement the transaction
> failed call, which most target architectures do. Notably not x86
> though, I wonder why?

Much of this is historical legacy. QEMU originally had no
concept of "the system outside the CPU returns some kind
of bus error and the CPU raises an exception for it".
This is turn is (I think) because the x86 PC doesn't do
that: you always get back some kind of response, I think
-1 on reads and writes ignored. We added the do_transaction_failed
hook largely because we wanted it to give more accurate
emulation of this kind of thing on Arm, but as usual with new
facilities we left the other architectures to do it themselves
if they wanted -- by default the behaviour remained the same.
Some architectures have picked it up; some haven't.

The main reason it's a bit of a pain to turn the correct
handling on is because often boards don't actually implement
all the devices they're supposed to. For a pile of legacy Arm
boards, especially where we didn't have good test images,
we use the machine flag ignore_memory_transaction_failures to
retain the legacy behaviour. (This isn't great because it's
pretty much going to mean we have that flag set on those
boards forever because nobody is going to care enough to
investigate and test.)

> Other question is, sometimes I guess it's nice to avoid crashing in
> order to try to quickly get past some unimplemented MMIO. Maybe a
> command line option or something could turn it off? It should
> probably be a QEMU-wide option if so, so that shouldn't hold this
> series up, I can propose a option for that if anybody is worried
> about it.

I would not recommend going any further than maybe setting the
ignore_memory_transaction_failures flag for boards you don't
care about. (But in an ideal world, don't set it and deal with
any bug reports by implementing stub versions of missing devices.
Depends how confident you are in your test coverage.)

thanks
-- PMM

