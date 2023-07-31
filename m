Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763277698D3
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTR9-00029Q-Kd; Mon, 31 Jul 2023 09:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTQz-00028V-Jf
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:59:42 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTQx-0004O2-Vw
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:59:41 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fbf09a9139so7270520e87.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690811978; x=1691416778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eIlR4BoF2nBjyUeOXB3sARoLt5mEj/QjMr/NfpKp6H4=;
 b=bP6QpsBEbZjwrsHc+8g4CeWeCRgEhaD/RVDYthhfhbqnKu5VgKqY323HKLqDkZOsH4
 M90BWAc4dbfh2zl7PNetyAew6+/SFdbL0u1f6wXF6KJoa9HapComRuZ7dNF8U7erK0lU
 fHQjbOhkOd/y7MyEKTcpNwdwtsebYU7nSbNljqDAthKQpl/TX48LSRRKFrWhdlA/zvfu
 CXUCYcfxMbdlnxuguteytgeTazFdYKXeapf3X4yob9Ahq9XI2ByOgtqWv+J1F/b16ruc
 jNu7Wx9vghZu0E1Qwq4ORH8oC9yuOoXg2CePa9wCQ5poQG9cbkMT727QdrijUT5uT+j8
 8U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690811978; x=1691416778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIlR4BoF2nBjyUeOXB3sARoLt5mEj/QjMr/NfpKp6H4=;
 b=QKcxsBC7ykkHJm/4ORV+v4BKGeqd/IELA2rv8D4qkJZojFzCt8UnFNuKoXGc61Oe/P
 +ti03HxT/HhULnkIhw/LUkbwWBW1FC18rf+oBxL4wEs5NTjKAY1FCi7+FaqFCfNr3qb0
 FbAmzxr/75SgYL2dRqDRg4m2GORIooxtZJ9hzSh42TG+M6R368hvlAmvhYlRFOXJY4kA
 FTmewxK5WXpoHDMdoBh0hWwXaDKs9FZbk7omgfON0a8u7BTfoKvi6TXAlAP9bHUpD0yz
 tj46oA/RlG5mUdw5dRmtG/kdg3LbOL0CJiKDqHASWt1rje2JnITEDgKj1pP325Tv1qhr
 erdg==
X-Gm-Message-State: ABy/qLYrZUHvtX1JGDoFR2WKicOB78m1cocmCQoegmy85Hw9th2lz2Eo
 ZerhY/Ca1lRzw1XHa7dbc9FSOoe2K22DPm1LkeS+PQ==
X-Google-Smtp-Source: APBJJlEWKwj4qm0WnrzdcPslGs+5WQHsyIjSutO1Nt6aRPuVXUyk+BwrpWJhZeM1V9+/0TbX1rU0/M8wzT7piFZ06Fs=
X-Received: by 2002:ac2:4f0c:0:b0:4f8:6a29:b59b with SMTP id
 k12-20020ac24f0c000000b004f86a29b59bmr6838836lfr.64.1690811977739; Mon, 31
 Jul 2023 06:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230711085903.304496-1-npiggin@gmail.com>
 <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
 <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
 <CACPK8Xf-fa4qKZpgg4FvMkgzwbqgP1rh4=qLmv12N1JFcBn3Cg@mail.gmail.com>
 <CUFEQY5EGPAK.BFTBD2ZPJV5A@wheely>
 <CACPK8XdTVArJCVh0UaSe2mwY2FtO3zpMepkqPfkDy7zAmc16jQ@mail.gmail.com>
In-Reply-To: <CACPK8XdTVArJCVh0UaSe2mwY2FtO3zpMepkqPfkDy7zAmc16jQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 14:59:26 +0100
Message-ID: <CAFEAcA-oB2U=eTzRqdHJVw2DZWPEnR_tS3M_+=yiF5GHtv_3tw@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
To: Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, alex.bennee@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>, fbarrat@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Mon, 31 Jul 2023 at 07:59, Joel Stanley <joel@jms.id.au> wrote:
>
> On Sun, 30 Jul 2023 at 09:43, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Wed Jul 26, 2023 at 4:35 PM AEST, Joel Stanley wrote:
> > > On Wed, 12 Jul 2023 at 02:12, Nicholas Piggin <npiggin@gmail.com> wrote:
> > > >
> > > > On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
> > > > > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > > >
> > > > > > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > > > > > index 6911b73c07..ce8b42eb15 100644
> > > > > > --- a/gdbstub/gdbstub.c
> > > > > > +++ b/gdbstub/gdbstub.c
> > > > > > @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
> > > > > >              return;
> > > > > >      }
> > > > > >      if (runstate_is_running()) {
> > > > > > -        /* when the CPU is running, we cannot do anything except stop
> > > > > > -           it when receiving a char */
> > > > > > +        /*
> > > > > > +         * When the CPU is running, we cannot do anything except stop
> > > > > > +         * it when receiving a char. This is expected on a Ctrl-C in the
> > > > > > +         * gdb client. Because we are in all-stop mode, gdb sends a
> > > > > > +         * 0x03 byte which is not a usual packet, so we handle it specially
> > > > > > +         * here, but it does expect a stop reply.
> > > > > > +         */
> > > > > > +        if (ch != 0x03) {
> > > > > > +            warn_report("gdbstub: client sent packet while target running\n");
> > > > > > +        }
> > > > > > +        gdbserver_state.allow_stop_reply = true;
> > > > > >          vm_stop(RUN_STATE_PAUSED);
> > > > > >      } else
> > > > > >  #endif
> > > > >
> > > > > Makes sense to me, but shouldn't we send the stop-reply packet only for
> > > > > Ctrl+C/0x03?
> > > >
> > > > Good question.
> > > >
> > > > I think if we get a character here that's not a 3, we're already in
> > > > trouble, and we eat it so even worse. Since we only send a stop packet
> > > > back when the vm stops, then if we don't send one now we might never
> > > > send it. At least if we send one then the client might have some chance
> > > > to get back to a sane state. And this does at least take us back to
> > > > behaviour before the stop filtering patch.
> > > >
> > > > Could go further and only stop the machine if it was a 3, or send a
> > > > stop packet even if we were stopped, etc. but all that get further from
> > > > a minimal fix.
> > >
> > > I was taking a look at -rc1 and it looks like this hasn't made it in.
> > > Is it something we want to propose including?
> > >
> > > As a user of qemu I'd vote for it to go in.
> >
> > I think it should, gdb is hardly usable without it.
>
> I think I hit this issue when debugging u-boot in the aspeed arm
> machines. Your patch fixed things:
>
> Tested-by: Joel Stanley <joel@jms.id.au>
>
> Alex, Philippe, can we get this queued for 8.1?

I'm doing a pullreq today anyway, so I can grab it.

thanks
-- PMM

