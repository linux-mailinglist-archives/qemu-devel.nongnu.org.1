Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8A7D2F88
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurvJ-0006Hk-Fg; Mon, 23 Oct 2023 06:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qurvH-0006GU-AQ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:12:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qurvD-0004pH-BC
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:12:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so4771122a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698055949; x=1698660749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A7tENxU+s90CZuhFWuppWsz1Ary2e3txF+/4i3eE1GE=;
 b=N+8C3iA3RPW8+cDAuQWOxlihwPj6KaDC02sqyKCM0eC2vNw98hip3Vd28NUluzlWty
 ZRP6FxICZRa7xnlTdyZ6fDiq9suBXik/yY832jkoDFzn6qVK4QveBEEUWTnGC/VFPn2e
 8n+nzFLBSw+HsgTNQh7iKCDRgFcbG5PhZ3sRT8ArrI4jrEe2WtJoDov8EW7Jb8/MoITR
 YJ8TPyx8ATyTfrE4crLtJKJjElKTutdUfGNY7POcFccUz7elFVFkpEwU72V0ytwK26D7
 sttOUEwsTEope1IiYYnzPaN3SaAHLFsJljn78gRumMepvhaSNDQnfpvvYDfllaq1IXUS
 Rz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698055949; x=1698660749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7tENxU+s90CZuhFWuppWsz1Ary2e3txF+/4i3eE1GE=;
 b=qwAWGjDkPZ3rKWQujyqWWS17WJnP59f3aSjD4M/d270fQfnrCRU5CE5bAyq3IDhJZp
 fc5yQHemFxkgB4x39f1qolQ2r1Axt+lCYs6CgBS91ufW3jR6oyS/7daBquJi/fqx0QnJ
 S1JWUVcLbN6MM7wD2D2Wt9F7gHaBmTt/B6Bg4pqZOr48f8RsdWJEkw2qHOUrpymuaHRr
 YklwdavM/MQJ8J3tCUmKQ5+NHwIlEwRBIv1UaxoD3oGrm5s4vFX1piJ6TKaG5CWkBO2O
 FUI+QlZpYMG/lkyo6nc/a+KHFlUpFLI7ZjQbjHsoEyd5n7DYkiwUM/77qFWcgFjo8adl
 YPuA==
X-Gm-Message-State: AOJu0YxJOFzGYV7M2+xMhNzMxuJCLBbfiS0FXORyY6aea3PbYAoMZ3pZ
 7sFooQzxEOqaVjYQ4Rzxy4obubeQeVs6L3YNzVq9pw==
X-Google-Smtp-Source: AGHT+IEYfB7d2N6Q9dQ04YXt6K0Zt6Z7gN/BNI8/ZW3OdHVU1LYJgkrb+9JOW+9Xiq5djfVNOgXtdB3CbJHW8mXOKyg=
X-Received: by 2002:a05:6402:354d:b0:53e:6db7:ea63 with SMTP id
 f13-20020a056402354d00b0053e6db7ea63mr7127294edd.14.1698055948902; Mon, 23
 Oct 2023 03:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <4831384.GXAFRqVoOG@linux-e202.suse.de>
 <779fbc42-c397-44e0-8682-9a330cd1ec4f@tls.msk.ru>
In-Reply-To: <779fbc42-c397-44e0-8682-9a330cd1ec4f@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Oct 2023 11:12:18 +0100
Message-ID: <CAFEAcA_3Uay1=7O4t5sXM7ujyFM6tkwQ_BOeDe6K+s2VtXwdBg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabian Vogt <fvogt@suse.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 21 Oct 2023 at 13:30, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 13.09.2023 14:57, Fabian Vogt :
> > Just like d7ef5e16a17c sets SCR_EL3.HXEn for FEAT_HCX, this commit
> > handles SCR_EL3.FGTEn for FEAT_FGT:
> >
> > When we direct boot a kernel on a CPU which emulates EL3, we need to
> > set up the EL3 system registers as the Linux kernel documentation
> > specifies:
> >      https://www.kernel.org/doc/Documentation/arm64/booting.rst
> >
> >> For CPUs with the Fine Grained Traps (FEAT_FGT) extension present:
> >> - If EL3 is present and the kernel is entered at EL2:
> >>    - SCR_EL3.FGTEn (bit 27) must be initialised to 0b1.
>
> Am I right assuming this makes no sense to pick up for stable-7.2 since
> it doesn't even have aa64_fgt definitions (commit 15126d9ce2
> "target/arm: Define the FEAT_FGT registers"), or should this commit
> be picked up too?

Correct. stable-7.2 doesn't implement FEAT_FGT, so it doesn't
need this fix for that feature's implementation.

> This and subsequent change in this area, "target/arm: Fix CNTPCT_EL0
> trapping from EL0 when HCR_EL2.E2H is 0"

That's a safe bugfix back to any QEMU that has the code that it's
patching, but it's also not super high priority, since the code has
been that way since 2020 and we only just noticed :-) (Affects
running Xen in emulation under QEMU.)

thanks
-- PMM

