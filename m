Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067CA7C41EC
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:53:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJj8-0004Qc-UI; Tue, 10 Oct 2023 16:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqJj7-0004QH-8Q; Tue, 10 Oct 2023 16:53:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqJj5-0000dw-FM; Tue, 10 Oct 2023 16:53:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-692d2e8c003so196104b3a.1; 
 Tue, 10 Oct 2023 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696971189; x=1697575989; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0Z6pAIKZFmOc2GaxXJWN2cPkG39K3drQfFFmwpIovA=;
 b=W0Dw6FPNvonR4VPr7t9p8I6ZvzJTcd0LqAqf4OTtsYf6QQzDgTq+b3suc3tr2YPiUh
 pWByF3eRMsFuchG9ZokrzOib4wOJMUkIN+SSbVrXUQaX//3EoEwJ2zATudjY2hxtge7V
 pBq7d+L1dXgyRfQ+NQ3zbcxrx3TFdvKLWTsY2fauSXgZlqDaJ3sT/6VLFSo4FTZIw8Gj
 WxW5BMRXQhYN5FnKIbK9yYukwf3/A89EGNgsCBjkfp/lW67HhDnum2FJvZlypcen8gVW
 KuV4JBU7r4+sC+sPVEr7s1kFkId6v8F1q4S45APRb7g/GbV1Z9KoHjQIa/t0dxSHKTGE
 AHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696971189; x=1697575989;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B0Z6pAIKZFmOc2GaxXJWN2cPkG39K3drQfFFmwpIovA=;
 b=iV6b6EA/kdJVJLMwkeBx+v1Zbifxb985uUrBeF22D70aMD2vP1j/QC9eXJBX/Qe2PX
 mU0+Ix2QJuMAqgFSnkpTNAC1AvEuouYdAwNjRErDMJnW9wDEgvM2zDoaZJFPlqjiXSCX
 ouwUja8y4Eo2WOWhJ/QOqE7WbtKHUX0fe9RNbjnfeVPBy/RzMYXD2g9VXO6LIJSjmjP7
 9VljDX8hF+au0C9Zs+8rudN/35bcQvnRZfUccPxgtm8sJkGY0rOaGjsweZJoHGQ/A8VQ
 4xORuMHClzSecPSPcFE7TgV4sl+lelbNsoCMXMtIgPy+fHhXtwiyOIkhffIqVgdNPRvA
 M3ZA==
X-Gm-Message-State: AOJu0Ywx38j7ZtwUh9QWnQld5hw9JEEzYPiec7ypurdhTtb6GR2sqhGv
 i0C3ADUs1cShodwJAGMBGsI=
X-Google-Smtp-Source: AGHT+IESzIazsqUgraxHv4GCJfcSVjgyqeCVKsJYAwkwTkg2EKu+YtbYRpXcfcizHltFkuR/Ahn1YA==
X-Received: by 2002:a05:6a20:8415:b0:128:ffb7:dcfe with SMTP id
 c21-20020a056a20841500b00128ffb7dcfemr27926709pzd.1.1696971189529; 
 Tue, 10 Oct 2023 13:53:09 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 fb15-20020a056a002d8f00b006932657075bsm6904799pfb.82.2023.10.10.13.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 13:53:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2023 06:53:04 +1000
Message-Id: <CW522VQRHMHA.3DKAX1WTT3YAX@wheely>
To: "Joel Stanley" <joel@jms.id.au>, "Michael Ellerman" <mpe@ellerman.id.au>
Cc: <qemu-ppc@nongnu.org>, "Cleber Rosa" <crosa@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 05/11] testing/avocado: ppc add new BookE
 boot_linux_console.py tests
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-6-npiggin@gmail.com>
 <CACPK8XcS05gQemgRKFTvhAaQzDLg+5MKH0sVyuU=pOs=Oo_=SA@mail.gmail.com>
In-Reply-To: <CACPK8XcS05gQemgRKFTvhAaQzDLg+5MKH0sVyuU=pOs=Oo_=SA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Oct 10, 2023 at 10:03 PM AEST, Joel Stanley wrote:
> On Tue, 10 Oct 2023 at 18:23, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Add simple Linux kernel boot tests for BookE 64-bit and 32-bit CPUs
> > using Guenter Roeck's rootfs images for Linux testing, and a gitlab
> > repository with kernel images that I built since there are very few
> > sources of modern BookE images now.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> Should we get mpe to add a https://github.com/linuxppc/qemu-ci-images
> for you to keep those kernel images? But perhaps you'd prefer to keep
> them on gitlab. Just a suggestion.

Not a bad idea. Or we could try for gitlab/qemu/ci-images I suppose.

>
> > ---
> >  tests/avocado/boot_linux_console.py | 53 +++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_l=
inux_console.py
> > index 9434304cd3..dc3346ef49 100644
> > --- a/tests/avocado/boot_linux_console.py
> > +++ b/tests/avocado/boot_linux_console.py
> > @@ -1355,6 +1355,59 @@ def test_ppc64_e500(self):
> >          tar_hash =3D '6951d86d644b302898da2fd701739c9406527fe1'
> >          self.do_test_advcal_2018('19', tar_hash, 'uImage')
> >
> > +    def test_ppc64_e6500(self):
> > +        """
> > +        :avocado: tags=3Darch:ppc64
> > +        :avocado: tags=3Dmachine:ppce500
> > +        :avocado: tags=3Dcpu:e6500
> > +        :avocado: tags=3Daccel:tcg
> > +        """
> > +        kernel_url =3D ('https://gitlab.com/npiggin/qemu-ci-images/-/r=
aw/main/ppc/corenet64_vmlinux?ref_type=3Dheads&inline=3Dfalse')
>
> Is the ref_type?heads=3Dinline-false required? I seem to get the file
> successfully with wget and those omitted.

I just copied the download link, so if it works without then
I'll remove it.

Thanks,
Nick

