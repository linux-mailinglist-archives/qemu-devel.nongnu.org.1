Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB9C7971CB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDGK-0005Bx-66; Thu, 07 Sep 2023 07:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qeDGH-000577-Hi
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:33:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qeDGE-0008TC-0C
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:33:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c34c9cc9b9so6378125ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1694086400; x=1694691200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mH3CuHS3CcgC9+2e8HMd3FlDE3alt/tQ7muKoMnaXo=;
 b=Py8dQQfeO8hHSuSSQS7XBIkUt9FUkpw+JMzsv/GMSVU4bgLdge2N6kJAc8ENGqMKHG
 /mzocXEFLsxxID0j3VrS7jVeBFDDUvYhYQK2R7fouqJdVZzYjLbej8yJhYReD1RimgCb
 PrB989goTlVTIVCjAyhdNjV1b/elMSVqxztAbqvC3ap8RWVUPmUnSYQxyQOdp9hJoe0L
 LP+cwD3Df+ZkZPNi7tlC3r1hVx67akiPjL1as1ZhGl8Uy7RqDS73ffOv1cyyr3RVLlsx
 X+RYPOJKxh5NB0nkR7HphBwGMH55xInmebDw80hIr6hgOI1gJUHuwd0YtFKoxCWxZ2w6
 3aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694086400; x=1694691200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mH3CuHS3CcgC9+2e8HMd3FlDE3alt/tQ7muKoMnaXo=;
 b=dcEzLq2YSH7ZwzY27vZtIeBeS4LVcB9oL7RPaeL2OdHVH0829VG+hhupnzd/cwnYrR
 mF0Wm6koKVyk3w5ACxLkk5CsuukQxnYAhI0+04ZR0ynPHSmaPaciUYhzjjbMXldBz5n7
 ZOcY2gP1W4PsB5paeWBQ8pt+NU8weaBUysffTcnWpIrvRtbiY6MiJCKMx7wbK7Rn9Ckv
 DbALHaWItc7FFEdGStUrZ9NN1ub7v/BW1XhUmVvNmPZ8CTK9f+vfI3u5k85Nq6pflAvn
 KnqC1V03iwLXaPaQkDKSDVMjVGuBN2krlRy+fluuoBeXDQpjUgCVUiDGoVyaEhHshimL
 4nDw==
X-Gm-Message-State: AOJu0YzBYlz2Q6JGK+3FmQTrmaAH33iJx1kVvrBBVY+CxcbbEAT8bt0m
 zfo7H+ho3lh6+sxGajE33zp0qbyHzdMRnzufeVLArw==
X-Google-Smtp-Source: AGHT+IHMHvjKHZBrpRSDWCWTTa8DGcwsXhpMfMNVkvBY98yrhHeIcTbq2cQiQ0OTUAVsNY/3l0py3EbD7BMHazbeajA=
X-Received: by 2002:a17:90a:d24d:b0:269:13f0:4b9a with SMTP id
 o13-20020a17090ad24d00b0026913f04b9amr16214505pjw.7.1694086399788; Thu, 07
 Sep 2023 04:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230823070735.363197-1-chigot@adacore.com>
 <CAFEAcA9EHpyPuJOCAbLCn8=F+aaSZ=yzwDPwT70VUyCgMDLmYw@mail.gmail.com>
 <CAJ307EjBudxJTFo9HQMttKzKwQN0WaRzenhDKRL_wDGTHCtdhg@mail.gmail.com>
 <CAFEAcA-BBAHQy944JKS8ZSf5mJTxK0V2+p6XO8W9dpArKtc-_A@mail.gmail.com>
 <CAJ307EhcGpQDhx=MA+jw==zUGnXJ-FLh_0T8RzZVtqe5Kr7kog@mail.gmail.com>
In-Reply-To: <CAJ307EhcGpQDhx=MA+jw==zUGnXJ-FLh_0T8RzZVtqe5Kr7kog@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 7 Sep 2023 13:33:08 +0200
Message-ID: <CAJ307EjMiXuxzWs9s1chgFnDa=8pUhLV4Bsah3Y1VsjCk96ExA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gdbstub: replace exit(0) with proper shutdown
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=chigot@adacore.com; helo=mail-pl1-x62b.google.com
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

Hi Peter,

On Mon, Sep 4, 2023 at 2:46=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adacore.=
com> wrote:
>
> On Mon, Sep 4, 2023 at 11:42=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Mon, 4 Sept 2023 at 10:36, Cl=C3=A9ment Chigot <chigot@adacore.com> =
wrote:
> > >
> > > On Mon, Sep 4, 2023 at 11:23=E2=80=AFAM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> > > >
> > > > On Wed, 23 Aug 2023 at 08:07, Cl=C3=A9ment Chigot <chigot@adacore.c=
om> wrote:
> > > > >
> > > > > This replaces the exit(0) call by a shutdown request, ensuring a =
proper
> > > > > cleanup of Qemu. Otherwise, some connections could be broken with=
out
> > > > > being correctly flushed.
> > > > >
> > > > > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >
> > > > > +    /*
> > > > > +     * Shutdown request is a clean way to stop the QEMU, compare=
d
> > > > > +     * to a direct call to exit(). But we can't pass the exit co=
de
> > > > > +     * through it so avoid doing that when it can matter.
> > > > > +     * As this function is also called during the cleanup proces=
s,
> > > > > +     * avoid sending the request if one is already set.
> > > > > +     */
> > > > > +    if (code) {
> > > > > +        exit(code);
> > > > > +    } else if (!qemu_shutdown_requested_get()) {
> > > > > +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDO=
WN);
> > > > > +    }
> > > > >  }
> > > >
> > > > This definitely doesn't look right. Either exit() is OK
> > > > to call, or it is not. We shouldn't be exiting one way
> > > > if the exit status is 0 and another way if it is non-0.
> > >
> > > I do agree but AFAIK, this isn't possible to pass the exit code using
> > > qemu_system_shutdown_request.
> >
> > That would mean that we should add a mechanism to do so.
> >
> > But my opinion is still what I said about the first version
> > of this patchset: we should fix whatever the problem is
> > that means that gdb_exit() is not correctly ensuring that
> > gdb gets the packet response, not paper over it like this.
>
> The main issue is that calling exit(0) bypasses the call of qemu_cleanup(=
).
> For the two other patches, the wrong behavior is obvious: qemu_cleanup
> being not called so is gdb_exit and then the gdb packet is never even
> created, let alone being sent. Replacing exit by a shutdown request
> ensures that the softmmu main loop terminates and that
> qemu_cleanup/gdb_exit is being called.
>
> For this one, I have to verify a bit further. Honestly, I did include
> it for the sake of coherence and because we used to need it. However,
> I've realized that this was earlier to commit b9e10c6c (which adds
> explicit calls to gdb_exit). It might not be mandatory after all, even
> if I still think that this is an improvement as bypassing qemu_cleanup
> could lead to many leaks if contributors expect it to be called once
> the softmmu main loop has started.

For the cases I've tried, there was indeed no leak if qemu_cleanup was
not called.
However, digging a bit in the qemu, I found that net/vhost-vdpa.c is
mentioning that its cleanup function has to be called through
qemu_cleanup in some cases to perform its final sanitation.
Thus, I've improved and kept the commit dealing with gdbstub (in v3
just sent). If you really think it's safer to avoid that, I'm ok to
drop it until I find a leak/issue (if any) caused by qemu_cleanup not
being called here.

Thanks,
Cl=C3=A9ment

