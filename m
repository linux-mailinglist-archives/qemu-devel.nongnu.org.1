Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12F836937
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:56:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwdY-0003vD-Cp; Mon, 22 Jan 2024 10:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRwdW-0003tB-C5
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:54:58 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRwdU-0002v4-NP
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:54:58 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55c2e6f0542so1346350a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705938895; x=1706543695; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FQ89/gHU/0fCqpWPcNOOU1hTDbxZXHtbw+6dvcE8kJI=;
 b=TlgJfG5du08CNPy4Vmzo1a/CPigw6ajCf9CxiDcweFM8UumSkgmXUz86Mn/5tqp8OG
 E6dE2q6mTgIKtjx5YNX918G46D+qZlQ0rk+HulG0wirjG/z45ORKRYYEunXWohwhxWvI
 j4BoITpqtSP1gfg7qY7zygMYJKt32y+gmlFyEHOBpzgmiaCIMziupUMVKmJqbrkLwkm5
 iOdbgq9J6kT0PpXUojHCWwrTZk12sH93fyvBYEJNExr7B1Xxg9fqeH4YDS0EUTgI327E
 NjAUo0Ln+E+j6/J1/XPUcpQjfD15zMA+be4ReA1NhZTgNFaiEC3lKcu36tJ4Y2Fti48R
 zn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705938895; x=1706543695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQ89/gHU/0fCqpWPcNOOU1hTDbxZXHtbw+6dvcE8kJI=;
 b=FUOSwKc+ofJ2MkGaVf3021k2qeydS2QKtNlDaWn28fPmCsUPesEyWxZO08VKlVgc3E
 vxbpMuSR43OlL09ZM6Uko5mChBGqYr00hz0jCB9pgp67YwDWzViLJdfpNCY4AIgdqfBC
 JCaYRHsdtIBZZCSejvuzXhbGD8vj7u9M+sFuV7OPo0xZbdEqZXR2tuGQmuRFHjlohB3T
 QyxkQPI38QOuOruPisiePnEe59dV/48QVDynRjj0X223tgi7IVxwmXh6LyxccvtDQUBD
 PcOoAYxkSmaMuLjC1hcVU2w52yEBr8BBmQvLx3Wq+G0cF3zAfgGDiMikCN1iRQxyrbSV
 xzzQ==
X-Gm-Message-State: AOJu0Yyjmda8G7fxesbZYd1BXae5300PV24WSNyPzL1AUVMMNCK6t7g0
 XWLo3RzUy3a+7bJ6ScFyslcvw85Wj1Y/qrnDMvBQ0rVlYfR8u1qVZBql5w1yE/dBDHKxbVpnnOr
 y3q613ee70mb/A+QMHoUN0nGB2S987aWIHslXSw==
X-Google-Smtp-Source: AGHT+IHZ4AmYYS41l1+oY4P1F0NcI9IjYzzNjkEVmsOGCTIDiinLeIqy97GATBO/I31sJUp8DyAu1vKgqbzjCmdgWd8=
X-Received: by 2002:a05:6402:b90:b0:559:d8eb:e443 with SMTP id
 cf16-20020a0564020b9000b00559d8ebe443mr49313edb.80.1705938895269; Mon, 22 Jan
 2024 07:54:55 -0800 (PST)
MIME-Version: 1.0
References: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
 <CAFEAcA_5ip7q0Wp=jJkV7sJg=w=e08JCRqPmQuOObNe8AMZLDA@mail.gmail.com>
In-Reply-To: <CAFEAcA_5ip7q0Wp=jJkV7sJg=w=e08JCRqPmQuOObNe8AMZLDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 15:54:43 +0000
Message-ID: <CAFEAcA_sX50fnyR8GqrmM4=gtm9cMg-U6Ooh5gK39-sWcrTRJQ@mail.gmail.com>
Subject: Re: [PATCH] Fixed '-serial none' usage breaks following '-serial ...'
 usage
To: Bohdan Kostiv <bogdan.kostiv@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
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

On Mon, 15 Jan 2024 at 16:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> (I've cc'd a few people who might have opinions on possible
> command-line compatibility breakage.)
>
> On Wed, 10 Jan 2024 at 14:38, Bohdan Kostiv <bogdan.kostiv@gmail.com> wrote:
> >
> > Hello,
> >
> > I have faced an issue in using serial ports when I need to skip a couple of ports in the CLI.
> >
> > For example the ARM machine netduinoplus2 supports up to 7 UARTS.
> > Following case works (the first UART is used to send data in the firmware):
> > qemu-system-arm -machine netduinoplus2 -nographic -serial mon:stdio -kernel path-to-fw/firmware.elf
> > But this one doesn't  (the third UART is used to send data in the firmware):
> > qemu-system-arm -machine netduinoplus2 -nographic -serial none -serial none -serial mon:stdio -kernel path-to-fw/firmware.elf
>
> Putting the patch inline for more convenient discussion:
>
> > Subject: [PATCH] Fixed '-serial none' usage breaks following '-serial ...' usage
> >
> > Signed-off-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
> > ---
> >  system/vl.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/system/vl.c b/system/vl.c
> > index 2bcd9efb9a..b8744475cd 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -1442,8 +1442,11 @@ static int serial_parse(const char *devname)
> >      int index = num_serial_hds;
> >      char label[32];
> >
> > -    if (strcmp(devname, "none") == 0)
> > +    if (strcmp(devname, "none") == 0) {
> > +        num_serial_hds++;
> >          return 0;
> > +    }
> > +
> >      snprintf(label, sizeof(label), "serial%d", index);
> >      serial_hds = g_renew(Chardev *, serial_hds, index + 1);
> >

While I was testing this patch, I discovered that it has a bug:
if you run 'qemu-system-x86_64 -serial none' it now crashes.
This happens because the serial_hd() function assumes that
serial_hds points to enough memory for num_serial_hds
pointers, and now we are increasing num_serial_hds but
skipping the g_renew() that enlarges the array.

I'll send a patch which gets that part right and also has
an expanded commit message which mentions some of the
things we've discussed in this thread.

thanks
-- PMM

