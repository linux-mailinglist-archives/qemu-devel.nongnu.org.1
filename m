Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106D8287FC
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rND24-0005qo-9z; Tue, 09 Jan 2024 09:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND21-0005hC-7n
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:24:41 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND1w-0008Pf-Pt
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:24:40 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cd1232a2c7so34941681fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704810275; x=1705415075; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8HxaG5jHfA5eynq0h7OpV8E28iukh4gGlIHSF5LPaM=;
 b=r+W3EsX4x39fsw0fKnFdy0s+nTe4R8mWJUgJIybqiNdLumY+Wy2wtdmYQcLI7Kl936
 oRZNTjXrVHXoQ+5xNt1pDcgxOWusMWvWAZoDEo/UYYBlf4frtOvsKXslUtA+e2JVCTOE
 Hfv4Qxd0kUULDpMy6jk62M9NFZWRi3abj0t4rTqeRR89+waJcmMCrJctHGGCIi0dGFJm
 /YNNiNUNLxWEE+GBp+5rLKpNesyhJGRphNmxv1LGhUvemo3qKpcnRXL1d5yl992sa8dv
 M7tXdd0JxMW2OeVJL41XDDt8xTV5JLi+8jDzY5+7Q8mP5cBH+QKf79Xe01/+r1gI2evl
 E9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810275; x=1705415075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8HxaG5jHfA5eynq0h7OpV8E28iukh4gGlIHSF5LPaM=;
 b=EDLq5ru2++suT0TTVuMIiI2Ry//3QG0rDzPxcilC9lAMa1UmDr92vqFI5W1ApFOXuq
 CZ4Fo7b2WbzAZ+YdQZfJ0zG4/n/LUDEpgJqlUbvwLLil3+/yj5qp8qrXC5Klkj5qKjOC
 NQ4nUnk4w2WJ2psyzGlpiu0ATVl6xY+BOHTljFnoBQbA/TNGeD7ZtTZPTvgd8k8I3u86
 OCRolWKZIk9mETLCzDwNMu+3y5d+VhTWR+15mLtHcMJOl53tiVwAb0ilhEHkFYzzHGAE
 LmaTpkzZuL7s+8JsD71KrWSbm8MK+POGQht9zzMcgBhnMYLXP6i+S15J+aouxWytLzNJ
 R8ow==
X-Gm-Message-State: AOJu0Yztp2Xof+sOJYEkZuB2aUNAJpjjbj14M5wLufCUr9kEerR+vJLM
 Xb136optW965mJXNfabemxGfYA/fbT6pNu6wBbizSdFof/8b2A==
X-Google-Smtp-Source: AGHT+IGK7vR8DzSVYBskXinT44vEEounbS1tbmNcOO0I2Mp5BPx/5hHxV0oXrSjmPg82Rc92EUkl4Wnf15zP33dpimE=
X-Received: by 2002:a2e:98d7:0:b0:2cc:6fe2:4ddc with SMTP id
 s23-20020a2e98d7000000b002cc6fe24ddcmr2422322ljj.3.1704810274859; Tue, 09 Jan
 2024 06:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
 <CAFEAcA-ETd9nuLB83ZgD9XBG5zMNTxhzQ8Jfg8Cfe9teTBq_+g@mail.gmail.com>
In-Reply-To: <CAFEAcA-ETd9nuLB83ZgD9XBG5zMNTxhzQ8Jfg8Cfe9teTBq_+g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 14:24:24 +0000
Message-ID: <CAFEAcA-9U4y3Q28=P8bFSPBweTVaTP4upXX=ccTMtOR-XsPaig@mail.gmail.com>
Subject: Re: [PULL 00/13] replay fixes for replay_kernel
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Tue, 9 Jan 2024 at 14:23, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Mon, 8 Jan 2024 at 15:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> >
> > The following changes since commit 0c1eccd368af8805ec0fb11e6cf25d0684d3=
7328:
> >
> >   Merge tag 'hw-cpus-20240105' of https://github.com/philmd/qemu into s=
taging (2024-01-05 16:08:58 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/stsquad/qemu.git tags/pull-replay-fixes-080124-1
> >
> > for you to fetch changes up to c2ef5ee89d76f0ab77c4dd6a1c9eeed4d35d20ed=
:
> >
> >   tests/avocado: remove skips from replay_kernel (2024-01-08 13:59:06 +=
0000)
> >
> > ----------------------------------------------------------------
> > Record/replay fixes for replay_kernel tests
> >
> >   - add a 32 bit x86 replay test case
> >   - fix some typos
> >   - use modern snapshot setting for tests
> >   - update replay_dump for current ABI
> >   - remove stale replay variables
> >   - improve kdoc for ReplayState
> >   - introduce common error path for replay
> >   - always fully drain chardevs when in replay
> >   - catch unexpected waitio on playback
> >   - remove flaky tags from replay_kernel tests
>
>
>
> Applied to target-arm.next, thanks.

Whoops, wrong canned response. I meant:


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

