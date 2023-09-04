Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8757914ED
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:43:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd660-00081m-2v; Mon, 04 Sep 2023 05:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qd65y-00081K-Kk
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:42:10 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qd65w-0003DJ-B7
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:42:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso1615919a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693820526; x=1694425326; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LptqVxTJ6NVqTuYVKx88iEnT9ke8XsZsjtPuzi5a2Kc=;
 b=Gk/j49OkjVZnA7SYhm5f3drXmH0IjBndffvxxq4BDb6LgC03zGIP5kd4809/h51UZb
 eHWSUu+5j7maGfSodx7EqQpYkXPoXsHD54llP055/ngoJYRfpfwzsXB+lyZvqX/9U0d1
 B+mWmDWoD+LiiFlCMFtVj0n0zdMjY21dqxC8C37kxHj9BYg2UGgs1mOwPF1vHPEuYvcJ
 yMkY+IW0B+P7UNlm9Ge2NIcAD9Gbp7s4M/PtP6k7joWVa7p+w6Q+ueHPBZ050RAPzE/m
 Y6OSqm6PsVSsDZ903x4LqHoQRuCSdIKWPK7goBIy3Ji0W6FcZGx4Nph4YeWkCbql5uxj
 b2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693820526; x=1694425326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LptqVxTJ6NVqTuYVKx88iEnT9ke8XsZsjtPuzi5a2Kc=;
 b=IUGuOc009q6MJW7Kw4L6U5DjR8Tnas0o2tTKVk29aW4TCGpcq0Tuvfu8//5lVM/BAA
 SmhvIHOlv37u7v2GkSzHTzSCjMO2qg1rGkcTGcgvTwtSzPThQBxSPMSeJFWoabOp/co4
 UdKjNCQnGMrZF8szy0AZjQ543/sLrrMOA5qK6xYmTmI2xZvH1vMgAW9ObIci7gKjfrnM
 NtIOw2Dm2hIvE/WyGzcJF3T/ZKFB3ZxqG82lPOqexyvYD/POyWnx9ogxnZXIYEvG5dbB
 2KSD5gIy3Ouv96EdboXzEE9I689vqLGpGxOImuvVirQjmz+9+mIY3E3pNg4FaacZ0FKO
 AM2w==
X-Gm-Message-State: AOJu0YyQV65/7177q+9+2yZ9Z5WZ1WyOxgtqHAKGPLs/vyTNusCcFHJK
 vfMPXB+qX5/bgFIuwI0ksbuJ49xoRal6VpNG5YaLdw==
X-Google-Smtp-Source: AGHT+IETeEUA4C3+X5gjw1/Yci0lPbUWIb4fdseJq1IdP56pQhj2MJDpRivuo71qHyvzQRwAd6V4MSm/Xz1RxPWDkbs=
X-Received: by 2002:aa7:d3c3:0:b0:523:10c0:9dc with SMTP id
 o3-20020aa7d3c3000000b0052310c009dcmr7119980edr.8.1693820526443; Mon, 04 Sep
 2023 02:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230823070735.363197-1-chigot@adacore.com>
 <CAFEAcA9EHpyPuJOCAbLCn8=F+aaSZ=yzwDPwT70VUyCgMDLmYw@mail.gmail.com>
 <CAJ307EjBudxJTFo9HQMttKzKwQN0WaRzenhDKRL_wDGTHCtdhg@mail.gmail.com>
In-Reply-To: <CAJ307EjBudxJTFo9HQMttKzKwQN0WaRzenhDKRL_wDGTHCtdhg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2023 10:41:55 +0100
Message-ID: <CAFEAcA-BBAHQy944JKS8ZSf5mJTxK0V2+p6XO8W9dpArKtc-_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gdbstub: replace exit(0) with proper shutdown
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 4 Sept 2023 at 10:36, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> On Mon, Sep 4, 2023 at 11:23=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Wed, 23 Aug 2023 at 08:07, Cl=C3=A9ment Chigot <chigot@adacore.com> =
wrote:
> > >
> > > This replaces the exit(0) call by a shutdown request, ensuring a prop=
er
> > > cleanup of Qemu. Otherwise, some connections could be broken without
> > > being correctly flushed.
> > >
> > > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

> > > +    /*
> > > +     * Shutdown request is a clean way to stop the QEMU, compared
> > > +     * to a direct call to exit(). But we can't pass the exit code
> > > +     * through it so avoid doing that when it can matter.
> > > +     * As this function is also called during the cleanup process,
> > > +     * avoid sending the request if one is already set.
> > > +     */
> > > +    if (code) {
> > > +        exit(code);
> > > +    } else if (!qemu_shutdown_requested_get()) {
> > > +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > +    }
> > >  }
> >
> > This definitely doesn't look right. Either exit() is OK
> > to call, or it is not. We shouldn't be exiting one way
> > if the exit status is 0 and another way if it is non-0.
>
> I do agree but AFAIK, this isn't possible to pass the exit code using
> qemu_system_shutdown_request.

That would mean that we should add a mechanism to do so.

But my opinion is still what I said about the first version
of this patchset: we should fix whatever the problem is
that means that gdb_exit() is not correctly ensuring that
gdb gets the packet response, not paper over it like this.

thanks
-- PMM

