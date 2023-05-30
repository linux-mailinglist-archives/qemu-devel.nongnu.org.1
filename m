Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F22017166E2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q419E-0006wq-SY; Tue, 30 May 2023 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q419C-0006we-Lv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:20:30 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q419B-0007yz-4W
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:20:30 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51492ae66a4so4819049a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685460027; x=1688052027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GDXilflpx3Ll8uFTtkz22qWsjmWaSnwuzJ17wAGAaBU=;
 b=O5LMimjyLqjZPdJUupNDjFvZ8rFZ1adzpU0dYObXhLQz3qVU7GoNPjlN0k61w2zgjN
 9UIkRDwOk/an84fB1FBlE+SP7fWAA3I9p3AO8UvXwpD/5dH+yk97USDzWwfvu08sdOgt
 yzXGFOajXbRsdGoVx4bFOY13PV3EnZ9Kf2j5oLWgvj4+rLPbAGXp/TZhIkP73gBg/1vr
 NtSDLoCYh7h753m+AHFXdi24jFuBHkIIhzRdXJNdxfy3FCQFxUsG79DEHbZz7GDY+wmJ
 r+ZozsT6joZjSm2+/h5koHgf29X5NvEpn6xXhJbJedQH1UBeadNZJFbU6cnJnaIPgNVc
 vsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460027; x=1688052027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDXilflpx3Ll8uFTtkz22qWsjmWaSnwuzJ17wAGAaBU=;
 b=H2IwGBdeVt/8sH9Nnanhi6xJ2G0hkAxvzECPADw8WCfElNMy2eTGwife7Vy7Lwdwa7
 DO1DbPXQ3GoSj8vX6avx04Gfml+3EDBVB4K5rFzbzcHhSQZCXFs5dKz1OXGsLW4xcPz+
 /OHwsqzbWI/m1A0rF9J25u81sHiDOncHwIAn+/7WJYWDAeJO3p1xQ7sn/6a7l1VZbZys
 iX5yCvJtWVIfS34oFkO0xCKea8o30uy5baiLt0UmRM7a0XgFfgN7yslPiO1ziGDyjUrT
 DyoGCc5lfvLp/ie7wiMGgDfgip1c7ctV7j/itB6NNP7Ohce1JUCP7llk/Q7/RG0z6jGE
 zDig==
X-Gm-Message-State: AC+VfDx8msMIYUJ5ZJoCv3OMnmCYazCDs/X0c4U8IPuuFN0uzKeQskuX
 HwYXFkX+OSiqXxPoZK+Z4YOsY/9c6czRFGfhhqdcCjQqIJG+rusK
X-Google-Smtp-Source: ACHHUZ47Bc1eUK3Qv0QQdItsrc2lvwRhJKpmdDTxcZSU+1Ibk6f39BFI+crgHlENst1aB3ITFdKdQy8tIIpVuuRpkdk=
X-Received: by 2002:a05:6402:b0a:b0:514:98c8:9d7c with SMTP id
 bm10-20020a0564020b0a00b0051498c89d7cmr1824501edb.4.1685460027509; Tue, 30
 May 2023 08:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
 <CAFEAcA9gb5rVKEQSZWHj3KZBP1Y27YiObFGdvnGj+JEDV2hHxQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9gb5rVKEQSZWHj3KZBP1Y27YiObFGdvnGj+JEDV2hHxQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:20:16 +0100
Message-ID: <CAFEAcA_42ZeQRVbLRxZBF17aL4PmLOC32RuEeDc65799W1zxMg@mail.gmail.com>
Subject: Re: [RFC] Native Library Calls
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 30 May 2023 at 15:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 30 May 2023 at 15:26, Yeqi Fu <fufuyqqqqqq@gmail.com> wrote:
> >
> > This patch introduces a set of feature instructions for native calls
> > and provides helpers to translate these instructions to corresponding
> > native functions. A shared library is also implemented, where native
> > functions are rewritten as feature instructions. At runtime, user
> > programs load the shared library, and feature instructions are
> > executed when native functions are called. This patch is applicable
> > to user programs with architectures x86, x86_64, arm, aarch64, mips,
> > and mips64. To build, compile libnative.c into a shared library for
> > the user program's architecture and run the
> > '../configure --enable-user-native-call && make' command.
>
> So it's essentially providing a QEMU-specific ABI that
> (somewhat similarly to semihosting) allows guest programs
> to use particular instructions/instruction patterns to
> say "do a memcpy/memset/memcmp" ?
>
> Is this an ABI that's implemented by anybody else?

Ah, I hadn't realised this was an Outreachy project. I'll
let Alex work with you on iterating on this...

thanks
-- PMM

