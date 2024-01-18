Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E5831683
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 11:14:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQPOv-00047B-3M; Thu, 18 Jan 2024 05:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQPOt-00046t-Nh
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:13:31 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQPOs-0007P1-0k
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:13:31 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5578485fc0eso11321757a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705572808; x=1706177608; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7D0Z1axAix8rix1vng4BO8uUyitRZROZbMumnWaVGs=;
 b=RonPfxAzrj8YQNZ7mqMC117We7v1tQQn1Ad9ChDAvy/ShBWY7CBv6hk38vyWsCPS9t
 wFaGsEtkvvxcoSMzhNRko+MIJaJ0gL219oj5unse/SMhpmyhZo/ZhxmmEeCLwGku6rlv
 Py8PbQtAJzdY/2ze6BkEOV2ggpIq5G8gQb6isUljIh5ly0bl6OuIOnzJ/h0Zbaq9cvTh
 FWt2lFtY1f1c4O3WfwuXNS9aOHW7/T0hZtTfaQOWbJisrmFoGhr7vZ3ZA982YzgfTKjS
 OzfJRDQKr3Ws0FPu0VY1m4/24x1quNioxOF6GqII4fPLR84/YQHk11hIloATCjgLY8C0
 Y8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705572808; x=1706177608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7D0Z1axAix8rix1vng4BO8uUyitRZROZbMumnWaVGs=;
 b=p+kEnGYszx5HpUsFrd3PmdDjURNwJGUJUNyPVahyIRqqbC0DpCClK6R450v1xZmUf0
 B/WL5Iebb2I+GNrGMqB0FfUVERD4whW8VdrGT6QqTYy9u1DLLLHqXe7bSoC+q+EMP7xv
 J034yohhWChhjNyrLze3khViB9vQz/wup7j6usaXXVyMXvwTdiWrWtJvXXaLefgqCUmu
 NrgAfCLcK+LoE4FCdfp4zs62UNKM4Lbnv6D8CcJh1kSaeCgmRn6KnsVamVOBf/x1OK34
 LR5/5OPbtUC9gOCc9A4ov+4XZ8gkuRpK++ZQ0+j/jRRyKIzHcZ7WERNcCzw9kiFiKe6U
 VQGg==
X-Gm-Message-State: AOJu0YwL/n43BRrRRMAxlpuW229SK6dZu2m1Q7KLo5aZlqHo5r2QCUni
 4RWpRm6wGLe0CiOVD4n/EYr4hNu1GQ6Pwt+rzIR38bBxVTG/jWwfk2zv4KSwDw9nwNZfFz/Rqqq
 GJyFeaWCzH9wU7j4n/dOmxkRmCuwHUIoTPcW/0Q==
X-Google-Smtp-Source: AGHT+IHWKcRix4BN8axqL1YzBg/HEf3+1QboWlEHxPMfIDiK6KlGcjB90MwoPo6yM4+bYK54qgncyQDOINdxCLQQJZI=
X-Received: by 2002:a50:ee14:0:b0:557:562f:7872 with SMTP id
 g20-20020a50ee14000000b00557562f7872mr396014eds.47.1705572808293; Thu, 18 Jan
 2024 02:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20240116104809.250076-1-alex.bennee@linaro.org>
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 10:13:17 +0000
Message-ID: <CAFEAcA89wjboMG4DVkuu4hS4YdW4siChFK690kpF7d2pqqcLhg@mail.gmail.com>
Subject: Re: [PULL 00/22] gdb cleanups and tcg plugin register access
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 16 Jan 2024 at 10:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e39=
3c:
>
>   Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad=
/qemu into staging (2024-01-12 14:02:53 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-registers-for-plugins-160=
124-2
>
> for you to fetch changes up to 87bed6910aa0d0942244b5eedee60b4f8b162c05:
>
>   docs/devel: document some plugin assumptions (2024-01-16 10:34:20 +0000=
)
>
> ----------------------------------------------------------------
> read-only register access for plugins:
>
>   - move misa_mxl to CPU class for riscv
>   - use GDBFeature for arm XML
>   - use GDBFeature for ppc XML
>   - use GDBFeature for riscv XML
>   - unify gdb code to use GDBFeature
>   - move dynamic XML generation to core GDB code
>   - provide introspection APIs for rest of QEMU
>   - expose a plugin API to access registers
>   - fix memory re-use in execlog
>   - extend execlog to track registers
>   - optimise instrumentation based on disassembly
>   - tweak API docs and expand on assumptions

I see that Akihiko has asked for this not to be merged, so I'll
drop this pull req.

Akihiko: for the future, if you want an on-list pullreq
to not be merged, please reply to the cover letter, not to
an individual patch. I am very unlikely to notice replies
to individual patches before I do a merge. (I only noticed
in this case because somebody happened to point it out to
me on IRC.)

thanks
-- PMM

