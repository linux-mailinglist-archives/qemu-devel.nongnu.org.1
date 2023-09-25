Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF87AD84D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:55:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl5e-00073M-Iy; Mon, 25 Sep 2023 08:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qkl5X-00072j-0K
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:53:24 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qkl5T-0001ct-Uj
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:53:22 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59be6bcf408so74527037b3.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695646398; x=1696251198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bG3DxdmW4T2/hj4PUhCE/Ne2Xr1uo4ivJK25lPStJ8=;
 b=PQ1BPdyo5itC0Sc6OUehxorXsOVTqy7k2LmhJCKt8cJnZ2gg27FrMeSoAfgx2H6SIs
 j24p+v2t6HaZ3vs971oXxDOYvo9qUBI1reg/JP+61dv3unnManHO+QoVQdg5NRzJ/8jB
 yqkAwGeRnHLfI2Eqp190KFfegAR+XAER0o40RXj2LGf4IQv010AwLCZ0jQRJctE+sXlJ
 j3e7VDgMTucxDGMl8u96t2heDPgWZX6Q2lRkMFGr8ossw+nuSHwfOFz+GF7XcgVFOu9e
 efaqU8XrL2MVAxuGOFuufmjEY64FzC7ZF7/44McimySASrDjD4aJ1SLrD8iOZOlTBhys
 6tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695646398; x=1696251198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bG3DxdmW4T2/hj4PUhCE/Ne2Xr1uo4ivJK25lPStJ8=;
 b=auuWlCK1Ryx0nmYHMTLlsX+0Q971ypWWOXM0D0h7X+gzQqWHHt1MW1WFepCZK/cfVP
 cZ+moK/GHtmT92OgCygHipskzyO4s+LK3UoAWwzyS29uIDzWStgwUlMTL7cDI7B9zeG4
 yC746V5ugfmXcOxkULjX4yVnyeyQWerWErLq9/XpL41p5i9oSebuYf0WSiIjD0KelDmW
 ASfVhJzfniMId8otufQfz4XKx4d/Hxc1f1VJebuF2ocJA8mpx3dI/f5wSuXneOIu9l0t
 bgv7QKf8MLACzYojUrVz3hlokhrnnDgECfz4vQW+d8KnBXlaVeGBW7qIS7XMPPDHfUyL
 z5mg==
X-Gm-Message-State: AOJu0Yyn0gQPi4QBxsKOsuGsHMO76D+INIGaMA6hMc01peYXPL6vkxJb
 pKnuf02KW99WzvSDOraacKXTWWuXE8+zGPDN45k=
X-Google-Smtp-Source: AGHT+IFiXPqhrkg7vY8KWq4hxyIO++4Lf/YIs/VgSEj0+0qJq6XgGzu8Zvib6j0+Xzpsrk619PLZbCdtZPmhGA3Pc7w=
X-Received: by 2002:a0d:f884:0:b0:59b:dbb7:5c74 with SMTP id
 i126-20020a0df884000000b0059bdbb75c74mr6682684ywf.32.1695646398116; Mon, 25
 Sep 2023 05:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230914175835.382972-1-tfanelli@redhat.com>
 <ZQQplEOUE2GhBL07@redhat.com>
 <CAFEAcA-DnH4oQ5kUioTiQr7COEbAqCKdkDPkBS0iJ3XUrKzOLw@mail.gmail.com>
 <CAJSP0QWprJhr_yiTLBuJ+aPDsanFdO-CfaTvoti-KT5V2kRK8g@mail.gmail.com>
In-Reply-To: <CAJSP0QWprJhr_yiTLBuJ+aPDsanFdO-CfaTvoti-KT5V2kRK8g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 25 Sep 2023 16:53:06 +0400
Message-ID: <CAJ+F1CJ7Hw8GTEGD56MzWb89qd=M10M_-3LAKSzyDgwpnvafBw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Tyler Fanelli <tfanelli@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com,
 mtosatti@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112f.google.com
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

Hi

On Fri, Sep 15, 2023 at 9:10=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Fri, 15 Sept 2023 at 09:50, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >
> > On Fri, 15 Sept 2023 at 10:54, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > > My summary, is that I'd personally be in favour of opening the door
> > > to Rust code as a mandatory pre-requisite for QEMU, at the very least
> > > for system emulators. Not because this particular series is compellin=
g,
> > > but because I think Rust could be more beneficial to QEMU over the lo=
ng
> > > term than we expect. In terms of consuming it though, if we're going
> > > to replace existing QEMU functionality, then I think we need to bundl=
e
> > > the Rust code and natively integrate it into the build system, as we
> > > have recently started doing with our python deps, to detach ourselves
> > > from the limits of what distros ship.
> >
> > I'm not against this, but there is a fair amount of work here
> > in figuring out how exactly to integrate Rust components
> > into the build system, questions like what our minimum required
> > rust version would be, liasing with downstream distros to
> > check that what we're proposing isn't a nightmare for them
> > to package, etc.
>
> Those details are similar to what librsvg2, libblkio, and other
> libraries (like the sev crate in this patch series) have had to solve.
>
> libblkio uses meson as the build system and has C tests that cover the
> C API. Cargo is still used to build the Rust code. It is possible to
> integrate the two and I think QEMU could take that approach. It's a
> little ugly to glue together the two build systems, but it has been
> shown to work.

That's also what I did ~2y ago, when I added QAPI rust generator:
https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.c=
om/

But meson has learned to support rust better during that time, and
there is some upcoming cargo support in 1.3
(https://github.com/mesonbuild/meson/pull/11856).

(I don't know the details)

--=20
Marc-Andr=C3=A9 Lureau

