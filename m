Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C19745AEA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHcB-0007zS-MC; Mon, 03 Jul 2023 07:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGHc9-0007zJ-Vz
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:21:06 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGHc7-0000gf-T5
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:21:05 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51dec0b6fecso3862215a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688383262; x=1690975262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aaxuyB7vGuagaqQUYjGz/kmZqiJj1BGeop9qxlq17n4=;
 b=ATsXqfSdBwKIA4vVVdoM6T16TPaM0flKx5lFx6JtZMbpRsk4nqxET9OdVrJh2sVOfI
 egMs0OmCLvcT9EA2lrt5nUX4xqgMO65tbu3jN6EEEZC2G9+ulAPfJW2AYAEPV4eG8w4c
 8MUBSfud2mBwj4y1CbWceKLtFaoZsoONjRkSpDHEsb5f3JeRZ9vYjXU0BzPHHm9RcWJ0
 auOQHkr7xFjSbAHJ71MWu7klhYAswZslIa7sLcvaFyOOIGn6PPkGpzel7wT9dpWnLf07
 kA2tWYNgIc44nFRMu7R0dEKbrT4h+6m6RQmnktv9BQ47jtv1DAdbrG+kEnv+h4mN6sjy
 AxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688383262; x=1690975262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aaxuyB7vGuagaqQUYjGz/kmZqiJj1BGeop9qxlq17n4=;
 b=RsEQo3JX/f1CiL7IghNVmN33N3pCWWYmwfZ7VwzuXMjOoHR7jSeVS3ZZn3j88h53Jl
 aK1bkBoWQhKXfnconsyEv0k1uLD1uV72L4h7lGkgFc61kPZSVCL1GH5uRbpEl7qBd5S+
 xi+H8HTr37Ki6r9RIJxAK/QxiiJoEU/FKX14j1Voxr4hwr8v4bLmsovbyXGiUD4mDw4A
 ikLxVotyj1CJYMzR7NjAPsR6e8TzZsWe5zPuflhiICbFQH29S4Mt34BZMLpK/Rhy/P8T
 AUOQEcIR2yyQa/Jry9IOBz4hTh8cSDGtwM8XHsIHWXAVJiJQSavSKYV16skHSkytkHkq
 qVwA==
X-Gm-Message-State: ABy/qLYCWFxCMCg+D8+rS3h+jE6gEaS9EQSh4BGUrc+6kDY8AV9Mr/BU
 kHZhaRhItt/qT8BSprWCW78GkMsVRTmv/Jcv88BjXA==
X-Google-Smtp-Source: APBJJlEiqBE/KbloJCsV7lryU+SQVgzSxyt2p/yAhRDWrYLR2yt44uArQ3OMDdK2WvQr4pUEGPLJt6i5ecJtJNuCvXg=
X-Received: by 2002:a05:6402:134a:b0:51b:d567:cfed with SMTP id
 y10-20020a056402134a00b0051bd567cfedmr7410406edw.5.1688383262470; Mon, 03 Jul
 2023 04:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <j6_NJPGssQ1eBAedcPGs0eURXeMcehbzMcwJtaGvzN_FdUbQKyTP1cyEJWC759G72UNSVpX-QmQ4u6iJvZmt2c_vRO7rhryDQs9icVy5iEI=@laplante.io>
 <CAFEAcA-L=LsAiLAeeQUH1AFFdNJw3D=mNtd4sQW7ZVDme4yhyw@mail.gmail.com>
 <qy_CVPE85v6mhzp6uqOrcOH8ZTGsRDVzv4I4n1WWEjnOr4hSeYVEw9BvjbINNK7mCtMxWSyWBFhUGEZLSgAzJWPHZcfnEEX15e-kwZGEEGE=@laplante.io>
In-Reply-To: <qy_CVPE85v6mhzp6uqOrcOH8ZTGsRDVzv4I4n1WWEjnOr4hSeYVEw9BvjbINNK7mCtMxWSyWBFhUGEZLSgAzJWPHZcfnEEX15e-kwZGEEGE=@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2023 12:20:51 +0100
Message-ID: <CAFEAcA-4A0Lzy2g2vk0Ja3Bw_j904ePMfD0Z9eNc5ZVkrLpfKA@mail.gmail.com>
Subject: Re: Emulation of 'System OFF' mode in ARM nRF51 SoCs
To: Chris Laplante <chris@laplante.io>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sat, 1 Jul 2023 at 20:29, Chris Laplante <chris@laplante.io> wrote:
>
> Hi Peter,
>
> > The reference manual is very unclear about what this "emulated
> > system off" mode actually does. I think that implementing
> > real "system off" is probably simpler. For that you should be able
> > to implement it something like this:
> >
> > (1) the power management device implements the SYSTEMOFF register
> > to call arm_set_cpu_off() when a 1 is written
> > (2) make sure the GPIO device implements DETECT as a GPIO output
> > signal, ie an outbound qemu_irq (if we don't do this already
> > the functionality will need to be added to the device model)
>
> Working on adding this now. One question - if the CPU is off (via arm_set_cpu_off), will the 'DETECT' IRQ I add to nrf51_gpio.c still fire?

Yes. The only thing that turning the CPU off affects is
the CPU -- all the rest of the devices in the system
continue to behave as normal.

> > (3) similarly for ANADETECT from the LPCOMP device
> > (4) Wire those qemu_irq GPIO outputs up to inputs on the
> > power management device. When the power management device
> > sees those signals go high and the CPU is in system off mode,
> > it should trigger the reset of the CPU by calling
> > arm_set_cpu_on_and_reset().
> >
>
> There is no power management IC or device in this system.

The manual says there is: chapter 12 describes the
power management and the registers involved, which are
in the POWER peripheral part of the SoC, starting at
0x4000_0000. QEMU just doesn't model that yet.

thanks
-- PMM

