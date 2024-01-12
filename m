Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3489682BFF4
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:48:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOGxE-0002XZ-E0; Fri, 12 Jan 2024 07:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOGxB-0002UE-2L
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:48:05 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOGx8-0002QB-7c
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:48:04 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5574feb7958so7506829a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705063679; x=1705668479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s0qjXo2lu52sIxdIsndME8SnUbloRjPO0qhAbgQ3Mvg=;
 b=Njm32GKIC2Kz4DqsMKdBCelRev197GPRaZUT8MHFwzlR5oAjJkAjw6RfGocZUK+RCM
 i9irWZo1DcTx5vCamt9p2yxCT57UUa3OStywRNWPMeYnPO3XMF+q2rAtkk37SLObbEW7
 WO458Ouoo0Dla1OiMkTc8eiBR3NOUSZf9I2xGu5TwwWf5GjsYjU7O+Z4bXzv7tvO1U1C
 f3CsRmUJOKwP+EaJTXYtv48GZ5BU+YVOAgevNrX8FIB+QT8eBfXJj/jhVFCJXEcAJe0D
 Wk6rRF9dtC7guANJc8a7K7rPDfVgP4CBMX4nqKODL6VSUMxea5bChHL2WF83MZlzljbv
 utGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705063679; x=1705668479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0qjXo2lu52sIxdIsndME8SnUbloRjPO0qhAbgQ3Mvg=;
 b=X1TrqWsL9GVWii4mWprW2hu7Wj7Hi2G+61oyieXkXHRJMCxJFMcaCMkQQPpr4LK/6l
 nRro2EAKYAEf9T6JJGqu9pptT3A21t0FuCZodD+Ie8J10H6AX5IB1YSzH2tlQzQn+lzF
 UcwkbihSve9E31AsRt39C8Jc/FFPIvZJm6CfqbEwK6uMq5i5tP8gYt4xFNsZtWpu1zH/
 rWfcFq01fAHUZ20VOBM9WG49TNAqnUQwXVIR5/a6UcrEcPbpso+lo6SH+rAAygikTA0u
 4clD9UVeeXsRyByXDdzdC6oaumtgOVpcO0TdqvTLhIwSP5CuwMBaizm7aU6tkM6iwIZ0
 v3JQ==
X-Gm-Message-State: AOJu0YxMtr+sk13n54IVzgFqINDnPW9vssfmW1M8Dj1a8mXUNyzgyeFX
 ZudZQ6Q47tnrWzUHO+fDDH4yAec+a34tQbbwD/0lY0bjidfkuA==
X-Google-Smtp-Source: AGHT+IGj0guQvroWmRCefFY+I9Etrr5YwKqXCRQY+bGajrqx8Azq6NtTvAXtFxdzVutTBe9juZzK8BltEoqKWV/KSk4=
X-Received: by 2002:a05:6402:f8b:b0:557:40ff:b3bb with SMTP id
 eh11-20020a0564020f8b00b0055740ffb3bbmr600609edb.38.1705063679288; Fri, 12
 Jan 2024 04:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
 <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
 <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
 <e2hpw77r6t2ge6h233cq75qdadou6koz62sfktcsrlc2gzeqnq@4ejyxysmmulo>
In-Reply-To: <e2hpw77r6t2ge6h233cq75qdadou6koz62sfktcsrlc2gzeqnq@4ejyxysmmulo>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 12:47:48 +0000
Message-ID: <CAFEAcA_f0Q7LkSQ2+sxgBcRQNSTenykq1R28QMuGyW22PtxW2Q@mail.gmail.com>
Subject: Re: Re: [PULL 0/6] Firmware/edk2 20231213 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 11 Jan 2024 at 16:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Jan 11, 2024 at 04:02:38PM +0000, Peter Maydell wrote:
> > On Thu, 11 Jan 2024 at 15:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Thu, 11 Jan 2024 at 14:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >
> > > > Ping.
> > > >
> > > > As expected this missed the 8.2 boat.  Now the devel tree is open again
> > > > and people are back from xmas + new year vacations, can this be picked
> > > > up for master and eventually 8.2-stable?
> > >
> > > I can queue it, sure. Do we need to respin it to add cc: qemu-stable
> > > tags, or can it be applied as-is ?
> >
> > ...PS did you mean to cc qemu-stable, not the nonexistent edk2-stable
> > on this pullreq email?
>
> Yes, Cc'ing qemu-stable was the intention, thanks for fixing it up.
>
> I'd leave it to the stable maintainer(s).  If they prefer a respin with
> Cc qemu-stable added to all patches I surely can do that.  If being
> notified with this reply is good enough I'm happy too.

Well, it all made it through the CI fine, and I think MJT is
fairly flexible about stable- notifications, so I'm going to
push this merge to git.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

