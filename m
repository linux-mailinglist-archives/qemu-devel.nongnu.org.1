Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6724773FDCE
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9fe-0007vh-Te; Tue, 27 Jun 2023 10:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE9fS-0007v0-Eg
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:27:43 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE9fO-0002Yy-Ko
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:27:41 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51d884a22e7so4425861a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687876057; x=1690468057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+JxuZKlt7rEQ6Do2L/qjII+HMlmfBcZln2gs6DAb+0w=;
 b=SYbJjSWhHiFPxNZAd1tqKhfavO/QcO7YPLaf+mgwvbFLmdOS+VmOuXxvlM8iRqNKhr
 UGhKyK2tK/h95HfypgFcQGXUGxwVc6nYTGfwpeeBjj3iS9GeBgqBqzW9Wz8207vEvyTA
 6qNsxX81rR2j1jWaAEqOT+lf9DBDT+ziQhk4bDk0JQ5uJBtM/bEXXmFF7Umq7LvBXx+E
 0ZzxN+xhQqhIdtgFSSmMa/G7GoD9I4Ucxasq0jGtXNK8N7FZLnnTDLpPC39AzQ4e6Wwo
 wXiH4tnsfLc4LUjcXXnf5klRHzSY4f8GwtMzxU8ZrVJoTGxM9C+g61eK/dr+e5WiNtac
 1C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687876057; x=1690468057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+JxuZKlt7rEQ6Do2L/qjII+HMlmfBcZln2gs6DAb+0w=;
 b=dnHJKfaueI/KuaeEhfBIYouV7Kr9j0aSJOoMdyLYdzDkfV1EQmJUHJRngHDBbcoBB3
 HeSSqtj/jhuoL8CnktBPsT8ExX9qJHTmgjzESf1sD3leWd9asvJA0UMRLGoIO84KZ3XJ
 Y4N/OhqIT6Of46US2M7FwFMi4XExcfoC28kOjc4Mzshyii7cKRo2rGLs/dfCnoRtHP+J
 S+ajaHieFxTDllJ/qj2doanu465n6a0tKBKg17lTroKDL1IfJLZaFmxutiGHtBHT4Llr
 O4aHGXcCizpu+IVIZ4QTK0DdrWwIT40S23NEwb/pXRF+fK2TQPExZKYA33jwpL9It60t
 z4VQ==
X-Gm-Message-State: AC+VfDwGhjDz+1qxT9+mArYg+H7QROG9QcvsmCnY6pl5+jkTgC3TqK2O
 sh3Eb1V2qw7Mr1bdYf0fyucVJvvgHhHkcV19ZPhU3g==
X-Google-Smtp-Source: ACHHUZ5d2F67GKdEoCzeKXH+ZYffDrX+YuK6c0bx+Mv5wImkIki5d89vPPNRHmoB8hK/w91hGT14dM1ewvgA9RdftMs=
X-Received: by 2002:aa7:c257:0:b0:51c:ef63:380a with SMTP id
 y23-20020aa7c257000000b0051cef63380amr7341736edo.27.1687876056952; Tue, 27
 Jun 2023 07:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
 <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
 <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
 <d8e93b7b-5e86-5e26-21cd-fefb76f88204@quicinc.com>
In-Reply-To: <d8e93b7b-5e86-5e26-21cd-fefb76f88204@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 15:27:26 +0100
Message-ID: <CAFEAcA8L--h_3QvKff66mw3VG7G__hwv=syw2hU2Qby8jkJPRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 27 Jun 2023 at 15:09, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
> On 2023-06-27 14:27, Peter Maydell wrote:
> > OK. This is the kind of rationale that needs to be described
> > in the commit message and comments, though, so it's clear
> > why the PCI controller is special in this way.
>
> I mean, ultimately it's not. We've kept static mappings for the items
> that it wouldn't really provide any additional benefit anywhere to be
> able to shuffle around. (Which failed with EHCI.)
> Having the UART static has minor debug advantages. Everything else is
> static because it's poor return on investment (it doesn't let us test
> anything interesting in the firmware stacks) to make them dynamic.
>
> > What I'm trying to avoid here is that we start off saying
> > "the dtb we pass to the firmware is just a convenient format
> > for passing a tiny amount of information to it" and then
> > gradually add more and more stuff to it until we've backed
> > ourselves into "actually it's almost a complete dtb except
> > it's not compliant with the spec". That means there needs
> > to be a clear rationale for what is in the dtb versus
> > what is "the firmware knows what hardware it runs on".
>
> Yet again I find myself wishing I'd invented a custom format instead of
> using a DT to pass the information across. And I'm not even being sarky
> - it keeps confusing people, and across multiple projects we're being
> asked to repeatedly justify why we're not conforming to bindings that
> are not designed for what we want to do, when we only opted to use an
> existing storage format in order to maximise code reuse.
>
> The purpose of the DT in this platform is to pass information about the
> machine configuration to the highest-level firmware that in real
> hardware it would have means of determining programmatically *handwavy*
> "in other ways", so that that higher-level firmware can abstract the
> information away behind SMC calls that lower levels of firmware can
> access throug into reusable libraries that will also be useful for
> actual hardware platforms.
> *and* let us wiggle things around to try to shake out bugs in those (and
> other) firmware components.
>
> Serious question: would it be preferable if we moved to a custom DT node
> where we stick everything in as KEY=VALUE pairs to reduce this confusion?

I don't really mind, I just want it to be clear what is going on here
so that when I'm reviewing patches I have a design I can keep in mind.
The way this was presented to me originally, at least as I recall
it, was "this board will work the way that real hardware does, ie
the firmware knows what hardware it was built for". In that
setup QEMU doesn't need to tell the firmware anything, except
a very limited set of things which it's more convenient to have
flexible and specifiable on the QEMU command line, like number of
CPUs and size of RAM. And that's what the comments in the source say
at the moment:

/*
 * Firmware on this machine only uses ACPI table to load OS, these limited
 * device tree nodes are just to let firmware know the info which varies from
 * command line parameters, so it is not necessary to be fully compatible
 * with the kernel CPU and NUMA binding rules.
 */

So that's the design I've been implicitly reviewing these changes
against.

It is pretty surprising to me to hear that in real-world systems
the firmware is not built to know exactly where its UART, USB
controller, etc are and that it is instead asking some board
management controller chip for all this information and being
fully-flexible in the firmware that runs on the application CPU,
but I have zero experience in that area so that's just my
lack of knowledge speaking.

If there's a standard/common protocol for how the BMC communicates
that info to the application-CPU firmware then it might be
less confusing to use it, I guess. But I'm not inherently
opposed to putting this stuff in a dtb-format blob.

(Side note: is the commit message line "Trusted Firmware will
read it and provide to next firmware level." intended to
mean "TF will take this dtb node and pass it on", or merely
"TF will take the information in this dtb node and use
it to construct or modify the ACPI tables it passes to the
next level"?)

thanks
-- PMM

