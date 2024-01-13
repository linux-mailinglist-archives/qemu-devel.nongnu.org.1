Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C682CCCD
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 14:27:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOe2Y-0000WJ-1e; Sat, 13 Jan 2024 08:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe2S-0000To-Fb
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:27:04 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe2Q-0003Fr-LZ
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:27:04 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so8814789a12.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705152421; x=1705757221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4E7p7rqv9QrDzAcefKqxjwbAZOy/bKLL4kgV3ObHpU=;
 b=c+b9oQnuIkL+1tmoe5yEM+0MsgiczLyx5ETw/DQWgFbbV2oWxPVU/Vizo6GZkLwtwZ
 uzh4tR4QPhrdMnW978NPu3NJ189QUcnYcdD3Z16u43RZ5D66BPdtvSag9B+CpRoCW+qK
 F+WiR/sDJIrXNLIxIQmcqNNFxz2YMMVT5jZy24WxifwK3nk/1g8isAxZy/Iz++u9Wy0C
 tNucDHEQMmBYdWs4wCxrTi9c0xOkEJl0rEOJqIU17mAVL7EQJdzijz3qTC0PRQbrndXg
 oAB4X8nbQAI9ABT68K4GnJJCPgp8PS2HFuWNoE9TmASwdnbkZtXAxMdcpveq3Rsg0/1O
 w5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705152421; x=1705757221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4E7p7rqv9QrDzAcefKqxjwbAZOy/bKLL4kgV3ObHpU=;
 b=hjVFaE0va63vAhD+hoU5ug3EyAyyTpEGSqvoaGnATgjJXeZFo1h67s1jlZdV3c9kuq
 31CnQnUDQx8lscjAdpV3kpQAJlAU1NnSgZ+69ZqTiAkSAtxsRnV1/JB4Dc5msd5kh523
 F75KHNKFV/SkP8jakbu4ZXvSJBSVeBO2tELCtk/4SFbI8prJbM1faw6FmZvSWpw0iPO2
 F4sx1hrPJID+cTADtTyKzVzh+a5i1sjV42XXYQgKt/pZuiWzGCWASNjji2dh+2Q9YcRC
 /fkDOgB97kijqlq5UyCnutE1JgnkmQchtIbJMKxgEGj4n6Awn/OmFnWh+S99HFnXVWFn
 UHIw==
X-Gm-Message-State: AOJu0YzfA1yr1mcfToMqBYbM5cJCB7AL/PPRsA4yIrH3yYcifa2ukpRw
 msttdNmovc86X2P4GxLwkr0B+IhH5POmGyV0dIF/+BaG8UCRSQ==
X-Google-Smtp-Source: AGHT+IF+dwRLiBap4Rsg/EOY6GTV+ITvrrulsmMMbDvR6Z13PiDA7mujtX9IeWPxKcLs8dtTXYvRQLH/dp2aOkqy/Do=
X-Received: by 2002:aa7:d483:0:b0:558:57f5:6474 with SMTP id
 b3-20020aa7d483000000b0055857f56474mr1077058edr.23.1705152421029; Sat, 13 Jan
 2024 05:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20240110195329.3995-1-philmd@linaro.org>
 <20240110195329.3995-3-philmd@linaro.org>
In-Reply-To: <20240110195329.3995-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 13:26:28 +0000
Message-ID: <CAFEAcA8x7iCgG5ESxGCmJW3w5UvacsFTQYPTQ=oiFjUe3Wn1_g@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] hw/arm/armv7m: Ensure requested CPU type
 implements ARM_FEATURE_M
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 10 Jan 2024 at 19:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> ARMV7M container can only accept M-profile CPU types.
> Check requested type is valid once to allow further simplifications.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/armv7m.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

