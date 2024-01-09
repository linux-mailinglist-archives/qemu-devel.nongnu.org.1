Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B18828827
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:32:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rND9F-0004c7-HX; Tue, 09 Jan 2024 09:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND97-0004YG-Kk
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:32:02 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND95-0002ut-Im
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:32:01 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-555f581aed9so3515086a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704810716; x=1705415516; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsS6+YkRY5vAthM/VY5PFJaTHwQ/THen7TrPMDAeGWs=;
 b=IMtKy9ch3GSctgAKMIp4jaCasNUTUKlp1DIhFC07Pg/S5z3lB/6/R3iPaIulTKVsXL
 /fHy73MGoowaiBUOgPxMfhxPwcQ3sF+X5xVuUw/kHLEpCbR3QCxCxhZ20LY5GJt/s8wo
 HkoCqOFnXvge6eym7ZHSg8xfHIZZezmc8bxZpRgXevq3uKHWfOKyAKBkqtXKkPXSrSrA
 e8tqVgL0uq/+2JHwLOelz2R9nFtSVoQ/jKpW875hdzmAF53B1g7i1Fwgwxp3svnXIoRB
 V0h9fwaabTl4BUN3ulTn3/XNr04adtyVQbgUQ0ModUihjfi08xuHH8s7jVD4i34O9zSy
 ZM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810716; x=1705415516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsS6+YkRY5vAthM/VY5PFJaTHwQ/THen7TrPMDAeGWs=;
 b=JXsgJ5bKT5NbfK06nDF3VFXGpPJ0sDxMHAINN4aD2apL9Sw2SWQSkf+1kCSQ/Rfq/x
 V4Tg6oOMm+q2j54wx3DNcOeWhnAXbXyQnBj9rX8fCKYOIlU2l5KkHkbpHkgAsHhwmuUB
 lCO1VcQfBkOdNuFtkqJLrUL83nY1N9dhvq1UDT6ipLwYkMRTDmLk9y0naCRbVENmzyid
 Up0eKD5T4nGMXNEo0sabed1ERD6qS2uWFiz0/bid3viG1+OCivJeQm6IDNMYKUtnaoLb
 pd5AJwj3WhW2hq9L0c0O4yxI+JYy8JRXNSsNaXCNNVEnXBZ7PKAN1Da7AqcKRWo0RkCg
 vL2g==
X-Gm-Message-State: AOJu0Yya+xLJKGBxzXZ5GGFGUyo3mliwcqG+VuFywyHvvoi6cmLOt+yX
 SrfGBsoIBRNrwv9Qzm9qwPgVaXBDOTLubO8HOQc21lNvXY1UWOtOB4JEYo1C
X-Google-Smtp-Source: AGHT+IGuCgZbsoL6QcQgA7UJAkrle+U3fy1tj4fb/KodyuzPX2SmRu3ANUqeJSvDv83Dczvna7fc/Az4Ez+AL17hibQ=
X-Received: by 2002:a05:6402:1503:b0:553:4ec4:6980 with SMTP id
 f3-20020a056402150300b005534ec46980mr3005424edw.80.1704810716661; Tue, 09 Jan
 2024 06:31:56 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
 <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
 <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
 <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
 <CAFEAcA87qdWR-GLEjkGpGHxMhviFidi2=k7c=OFC3+hzn1P0Dw@mail.gmail.com>
 <87bk9uh9jd.fsf@draig.linaro.org>
In-Reply-To: <87bk9uh9jd.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 14:31:45 +0000
Message-ID: <CAFEAcA9K2jf3BfHY3xpP4T-_iH9nNX=XLrNp=mPg5nqZURBOrw@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 9 Jan 2024 at 14:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 9 Jan 2024 at 11:33, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >> On Mon, 8 Jan 2024 at 17:38, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >> > Speaking of config. This is standard debian config, I'm attaching on=
e
> >> > to this email.  It can be found in the package, eg
> >> > http://deb.debian.org/debian/pool/main/l/linux/linux-image-6.6.9-arm=
mp_6.6.9-1_armhf.deb
> >> > in /boot/config-$(uname -r).
> >>
> >> It does seem to be a config thing -- on a plain upstream
> >> v6.6.9 my config works and that debian default one does
> >> not. Now to try to identify which particular config
> >> difference is at fault. (It's not the CONFIG_VMSPLIT one,
> >> I just tried that.)
> >
> > Oh, your kernel isn't an LPAE one (i.e. CONFIG_LPAE is not
> > set). That will obviously never be able to access registers
> > above the 4GB mark (though the kernel's error message in this
> > situation is a bit unhelpful and could perhaps be improved).
> > If I set CONFIG_LPAE on the non-working config it starts working.
> >
> > I think then the answer is:
> >  * if you want to use the (default) highmem setup, use an LPAE kernel
> >  * if you want to use a non-LPAE kernel, tell QEMU to avoid
> >    highmem using '-machine virt,highmem=3Doff'
>
> Could we expand the "highmem" description in
> https://www.qemu.org/docs/master/system/arm/virt.html to make it
> clearer. I'm sure this isn't the first time there have been 32bit
> difficulties with non-LPAE kernels?

Sure. We could make the highmem property description read:

# Set on/off to enable/disable placing devices and RAM in physical
# address space above 32 bits. The default is on for machine types
# later than virt-2.12 when the CPU supports an address space
# bigger than 32 bits (i.e. 64-bit CPUs, and 32-bit CPUs with the
# Large Physical Address Extension (LPAE) feature). If you want to
# boot a 32-bit kernel which does not have CONFIG_LPAE enabled on
# a CPU type which implements LPAE, you will need to manually set
# this to 'off'; otherwise some devices, such as the PCI controller,
# will not be accessible.

How's that ?

thanks
-- PMM

