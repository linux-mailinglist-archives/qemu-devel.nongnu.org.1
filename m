Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9FE7164C3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40ct-0007J6-Sg; Tue, 30 May 2023 10:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40cY-0006uI-Ha
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:46:46 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40cX-0007An-1E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:46:46 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f3a9ad31dbso5296191e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685458003; x=1688050003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=abTvgi7dXQPgKjz/i/nLAv1wfSctEKaGwYlJqZgruSs=;
 b=RGdTJYv6y4XcXIVOez4i4/go3ww5RIRg2YvIXYjCP5SD3BmyNeD80Lz8/+pkgveQEI
 LpALFqYKX5eiXpLM+YzOGu4XT1k5BBugow3Vy+7aYk5qRyb7wk4UUHzD5EP5mtboHIxO
 /7/Pipz7wxp+bsgPN2XQPENTmWE9IIicBMWWWCsfh24eUXsdRxNrCuOwTswZAQOBTQn/
 zoda/pWZn7yBKjofoFpSC7xf9N/5K3NMGJLZ7CAdeB/3PaHLOesEeOP8kY+npyPxBBaH
 N2bnQ0U7BajpJPWuouTLAt+/cnDa6+Zx7qSQReWWBYROToLuXAo8woxb64BA4QQWaXR9
 EDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458003; x=1688050003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=abTvgi7dXQPgKjz/i/nLAv1wfSctEKaGwYlJqZgruSs=;
 b=UcsMuYxwwsz6R0vruVPTr1KAPrsd8mpXm5kmirIzJAS6plU91bzT9keMDsDMUbt77v
 YrpIfz8WM8dQQ7Kt7gzVXobuxhPUpw8/aiwGCZDOlNgV+jWS2FgjNFueQ6hg+RAbZuS/
 +X+xsxOq3V/lOtdPuoN3HRplUPtqoaaNXKGXWKvEgawXV1gjrU+quhLFAZdGEbWYbg5b
 JqnhUuiAdtbl/OsvMTg6og5ONDkduDZxXk/9Is+Y8mQm1clLV7/YTICSCr3tVkt+O84I
 17n5lsUOOn/+vkb28ecEYZbjzF5937LiF1COI6gEq2A9omhnzts0zjjsyYJYWs9l72dI
 BDiA==
X-Gm-Message-State: AC+VfDwCzpN0D3gHBJp9sypO/4/szD7WJ3HruLxJ34jSOdPJulmJbp6U
 wN1lH6DzmkFeON0EDRzZCiouA516rtW+l9dZOoEBNA==
X-Google-Smtp-Source: ACHHUZ4eoUr16PhXJTs8qZMUe3cuh6Jb6kpq2wMLS9XtB4bubx2TSliXhgc9nyf1sDfDH2Iq/XMsRPFlouV5XhaLpJ4=
X-Received: by 2002:a19:ee0d:0:b0:4ed:bdac:7a49 with SMTP id
 g13-20020a19ee0d000000b004edbdac7a49mr744988lfb.54.1685458002999; Tue, 30 May
 2023 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
In-Reply-To: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 15:46:31 +0100
Message-ID: <CAFEAcA9gb5rVKEQSZWHj3KZBP1Y27YiObFGdvnGj+JEDV2hHxQ@mail.gmail.com>
Subject: Re: [RFC] Native Library Calls
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Tue, 30 May 2023 at 15:26, Yeqi Fu <fufuyqqqqqq@gmail.com> wrote:
>
> This patch introduces a set of feature instructions for native calls
> and provides helpers to translate these instructions to corresponding
> native functions. A shared library is also implemented, where native
> functions are rewritten as feature instructions. At runtime, user
> programs load the shared library, and feature instructions are
> executed when native functions are called. This patch is applicable
> to user programs with architectures x86, x86_64, arm, aarch64, mips,
> and mips64. To build, compile libnative.c into a shared library for
> the user program's architecture and run the
> '../configure --enable-user-native-call && make' command.

So it's essentially providing a QEMU-specific ABI that
(somewhat similarly to semihosting) allows guest programs
to use particular instructions/instruction patterns to
say "do a memcpy/memset/memcmp" ?

Is this an ABI that's implemented by anybody else?

I'm pretty strongly negative about this as an idea -- I don't
think we should be adding QEMU-specific guest-facing ABIs,
especially if the usage of them is likely to be very very low.
At any rate, it needs a lot more justification for why it's
worthwhile than the commit message has provided.

thanks
-- PMM

