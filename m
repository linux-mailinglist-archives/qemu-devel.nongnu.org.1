Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508857A94D7
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJos-0002Iv-AO; Thu, 21 Sep 2023 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjJoq-0002I1-HV
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:34:12 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjJoo-00086s-IL
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:34:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-532e6f8125cso1095523a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695303249; x=1695908049; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SLFyIa4pNfHrRrFVoK4W/7yOB5ezN6IY3vzVujeQWwk=;
 b=VxTFarMb8zozoEY4fcGzUGLO1+5v+z83GZuPgBQGw0fDKmrAJXbiIe5aD6Sk3CKrLf
 yHHRYpGEGOGQz+GyM1s6HfmadE0Q43dYNsQ+J6OVBRv87DejfxMKnTFlgP7ihIt20dGi
 xpYNWXhbr4fL9luJvPZsgZ/2Mb8k/dVWRWvA9UR97VDvTrZ4d0AAkPpAUtLecGyDUgoL
 T9/9++A4mu5DE34VsOBEjaFvKwdRh22Ild8S5THEuHl/u2zAwjbBsxRjDyG7QNfaX4bp
 CX5j92+EQeO2rtHMhobS4fMEdKOe0x/9W56kP4yW/5pdUpCJLp1tcxALw2DpP6Tg9OPB
 MEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303249; x=1695908049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SLFyIa4pNfHrRrFVoK4W/7yOB5ezN6IY3vzVujeQWwk=;
 b=lDJ3ZC2th2CSWp9oHLEy/PSWkYquQHud1IIZ5XQJdP5wbaMrKx3ydrWI+B10NoWY0m
 c3CObrIf2V/dX5qWq9qnZgWGidnOBJXaL0pehcnT44VBf0TzQRIHHdzVQ58v9osi+XO8
 7KMkyIebydL9EjldwMtebWEj18ZThU287WrTdrwqw2cQ8pbLG0YzateveUB0rSsrvTmJ
 pxAX1IIQiLJwuf/gykZLL4ty4tWLnXTcHBCWBwvyY7OveOrP+qJDP4+CCnCqst/QsRnQ
 JzkDXRMT303g0R23kBKve617vT2IACSK5RuHP/nnSoCBVx6h3qPl4Sp/KLPQ1d5WaDy+
 Gjww==
X-Gm-Message-State: AOJu0YzS1VjzdJoK2s5+NAFhgvuuNECa0IVfU7pZc1R/eDa1nWbkDSN+
 /yHwwUi4PteQ9Dz5ADRLE0lzngPaMjEQfJHoegQo9ri9ZvssMlZwCJQ=
X-Google-Smtp-Source: AGHT+IHSkQ8f8dAM1bbBde2nHASKpT8QXWY5hcVmzsVUDmW/7AlposkLeqWQB5YEfDT9yRQHRvNIKem8/RqCHbNikX8=
X-Received: by 2002:a05:6402:3d7:b0:52c:9f89:4447 with SMTP id
 t23-20020a05640203d700b0052c9f894447mr4590180edw.4.1695303248906; Thu, 21 Sep
 2023 06:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221201102728.69751-1-akihiko.odaki@daynix.com>
 <CAFEAcA_ORM9CpDCvPMs1XcZVhh_4fKE2wnaS_tp1s4DzZCHsXQ@mail.gmail.com>
 <a3cc1116-272d-a8e5-a131-7becf98115e0@daynix.com>
 <ed62645a-ec48-14ff-4b7e-15314a0da30e@daynix.com>
 <CAFEAcA-pOKf1r+1BzURpv5FnFS79D2V=SSeY_a2Wene1wf+P1A@mail.gmail.com>
 <a5cd5a46-7f33-42b6-99eb-b09159af42d7@daynix.com>
In-Reply-To: <a5cd5a46-7f33-42b6-99eb-b09159af42d7@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2023 14:33:49 +0100
Message-ID: <CAFEAcA9cfrS4bqUX6G9qL8jNhJw0z2nMbqiHxYOutnqVOyb2yQ@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm/kvm-all: Handle register access errors
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 21 Sept 2023 at 08:25, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> On 2023/06/19 21:19, Peter Maydell wrote:
> > On Sat, 10 Jun 2023 at 04:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >> On 2022/12/01 20:00, Akihiko Odaki wrote:
> >>> On 2022/12/01 19:40, Peter Maydell wrote:
> >>>> On Thu, 1 Dec 2022 at 10:27, Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> wrote:
> >>>>> A register access error typically means something seriously wrong
> >>>>> happened so that anything bad can happen after that and recovery is
> >>>>> impossible.
> >>>>> Even failing one register access is catastorophic as
> >>>>> architecture-specific code are not written so that it torelates such
> >>>>> failures.
> >>>>>
> >>>>> Make sure the VM stop and nothing worse happens if such an error occurs.
> >>>>>
> >>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> >> QEMU 8.0 is already released so I think it's time to revisit this.
> >
> > Two months ago would have been a better time :-) We're heading up
> > towards softfreeze for 8.1 in about three weeks from now.

> Hi Peter,
>
> Please apply this.

Looking again at the patch I see it hasn't been reviewed by
anybody on the KVM side of things. Paolo, does this seem like
the right way to handle errors from kvm_arch_get_registers()
and kvm_arch_put_registers() ?

The original patch is at:
https://patchew.org/QEMU/20221201102728.69751-1-akihiko.odaki@daynix.com/

thanks
-- PMM

