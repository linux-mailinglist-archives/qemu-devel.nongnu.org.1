Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC44791788
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8yw-0000nn-0a; Mon, 04 Sep 2023 08:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qd8yM-0000Vz-BF
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:46:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qd8yI-0005ba-Iy
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:46:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a6f6a66e1so734489b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1693831584; x=1694436384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akybUmsE+1hTXU1b0qEH+AACc6vzgMugiewsnqJBMK8=;
 b=e42ggW697vZPnOL0oIM6NRMSmqsWxAQg239q5pBq2+MDnwLkaTHn9534RIKKr0kUrB
 SKBX3UYNFi++kfox5QtH3pMIOzg/Bb1NkvnAOM0Rqwm2HPrapFMHlHz9xDUtRQmKaYzg
 +mQTdJtAiMlOU8VpR7+KBcJJsV7sjHAPVm2ZAvZYQ1kPYE00Miyge9z1S0etlETI+5kJ
 38q7xyD20Op13i6hMhNCUugON/vw4rb/5PQMhwqobJwNJ6jikyJ2FdrU5DvAdtvW7fyR
 8BkSK4m6Wo7hEgGnGiy0wH/+Alke174oT+rHJoFZq/bwFK87HOWXYD1kEfdnQq6ZEoYy
 VyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831584; x=1694436384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akybUmsE+1hTXU1b0qEH+AACc6vzgMugiewsnqJBMK8=;
 b=VSbPKlQJejHyNAv8uKeNPskD7MNNpcfz4JDLrlJmkm7M+7aH7HDmG7yIFKqkoezFB8
 IVXAq/9zl6A6Ui2s412zJSaYsSWR0DgxLI0wDgZaWgMZzVB/yEAPYuSad8yCXzmvZ8Dp
 DKkHj26YXFUg4yZRuV9uCffRIPPKDG0r23sZyHmhLkGOMMNGLOmdRMe7QYHoNK7+qz9B
 y6DNd0A02KJsjouH8dLU7hugOdWKQkPwMI1RNJnl108T58L/Q5GWayCQASFDm47Pl5GE
 iVzaGMeK1R3Rm0msAiMIzm6lXTm+QAfzcIuge0cVb4tW9/xDGyjwBOa/fmQmatamJIQW
 kjfA==
X-Gm-Message-State: AOJu0YxL+JXfrccdXqKtVnCM+WyJeKklqaLAT6fhJHRgVBg6PikF67SH
 nRhIcKm65T/XK+SIuue5V6xQ34hm2NH5w5aK3AFm4g==
X-Google-Smtp-Source: AGHT+IGLSe2yDHa4TU/5qNJu7fHLA5GbciX5Myp+UVwru6at3ajrEg08fy39O7nZpgtqDogD2Ueinoi04030+oS966c=
X-Received: by 2002:a05:6a00:1914:b0:68b:dbbc:dce1 with SMTP id
 y20-20020a056a00191400b0068bdbbcdce1mr9017651pfi.16.1693831583916; Mon, 04
 Sep 2023 05:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230823070735.363197-1-chigot@adacore.com>
 <CAFEAcA9EHpyPuJOCAbLCn8=F+aaSZ=yzwDPwT70VUyCgMDLmYw@mail.gmail.com>
 <CAJ307EjBudxJTFo9HQMttKzKwQN0WaRzenhDKRL_wDGTHCtdhg@mail.gmail.com>
 <CAFEAcA-BBAHQy944JKS8ZSf5mJTxK0V2+p6XO8W9dpArKtc-_A@mail.gmail.com>
In-Reply-To: <CAFEAcA-BBAHQy944JKS8ZSf5mJTxK0V2+p6XO8W9dpArKtc-_A@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 4 Sep 2023 14:46:12 +0200
Message-ID: <CAJ307EhcGpQDhx=MA+jw==zUGnXJ-FLh_0T8RzZVtqe5Kr7kog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gdbstub: replace exit(0) with proper shutdown
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=chigot@adacore.com; helo=mail-pf1-x434.google.com
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

On Mon, Sep 4, 2023 at 11:42=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 4 Sept 2023 at 10:36, Cl=C3=A9ment Chigot <chigot@adacore.com> wr=
ote:
> >
> > On Mon, Sep 4, 2023 at 11:23=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Wed, 23 Aug 2023 at 08:07, Cl=C3=A9ment Chigot <chigot@adacore.com=
> wrote:
> > > >
> > > > This replaces the exit(0) call by a shutdown request, ensuring a pr=
oper
> > > > cleanup of Qemu. Otherwise, some connections could be broken withou=
t
> > > > being correctly flushed.
> > > >
> > > > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> > > > +    /*
> > > > +     * Shutdown request is a clean way to stop the QEMU, compared
> > > > +     * to a direct call to exit(). But we can't pass the exit code
> > > > +     * through it so avoid doing that when it can matter.
> > > > +     * As this function is also called during the cleanup process,
> > > > +     * avoid sending the request if one is already set.
> > > > +     */
> > > > +    if (code) {
> > > > +        exit(code);
> > > > +    } else if (!qemu_shutdown_requested_get()) {
> > > > +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN=
);
> > > > +    }
> > > >  }
> > >
> > > This definitely doesn't look right. Either exit() is OK
> > > to call, or it is not. We shouldn't be exiting one way
> > > if the exit status is 0 and another way if it is non-0.
> >
> > I do agree but AFAIK, this isn't possible to pass the exit code using
> > qemu_system_shutdown_request.
>
> That would mean that we should add a mechanism to do so.
>
> But my opinion is still what I said about the first version
> of this patchset: we should fix whatever the problem is
> that means that gdb_exit() is not correctly ensuring that
> gdb gets the packet response, not paper over it like this.

The main issue is that calling exit(0) bypasses the call of qemu_cleanup().
For the two other patches, the wrong behavior is obvious: qemu_cleanup
being not called so is gdb_exit and then the gdb packet is never even
created, let alone being sent. Replacing exit by a shutdown request
ensures that the softmmu main loop terminates and that
qemu_cleanup/gdb_exit is being called.

For this one, I have to verify a bit further. Honestly, I did include
it for the sake of coherence and because we used to need it. However,
I've realized that this was earlier to commit b9e10c6c (which adds
explicit calls to gdb_exit). It might not be mandatory after all, even
if I still think that this is an improvement as bypassing qemu_cleanup
could lead to many leaks if contributors expect it to be called once
the softmmu main loop has started.

Cl=C3=A9ment

