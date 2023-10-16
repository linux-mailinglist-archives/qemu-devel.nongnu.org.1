Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49F7CA463
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK5C-0006y7-UQ; Mon, 16 Oct 2023 05:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5A-0006wE-7S
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK57-0002X7-D3
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONMi70k75NqWS2Sp8Sm/dUhrIka8F2xW3dVfTgGPR2g=;
 b=Q3HEl3+o8Ymwf1A9I4tH3Ex4HgXGBpygLg66e1xPbaKvU3P3bsQ4PTIyw9GHXpqOsLCGfR
 BGkaNxbs9MRQr3dlAyn2mxYH6AZjg6BNcH62suw91CFT4rFv0lUgurJNddcojzijPyafsN
 wTZZqOZoDmriTlLbZrk/bHOVX4yRRxs=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Ca_YpcSyNECH_y-B14mIrQ-1; Mon, 16 Oct 2023 05:40:10 -0400
X-MC-Unique: Ca_YpcSyNECH_y-B14mIrQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7b5f427079cso1213915241.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449210; x=1698054010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONMi70k75NqWS2Sp8Sm/dUhrIka8F2xW3dVfTgGPR2g=;
 b=G6pd9qOc7FXw8qBavUIzA2hj45iKGiAI9migNOZFQtfls3Q235b79+MRQ5FfgyD5xj
 +7PanD3E6BHuXo0HdOJ+y5IG9d69SkztXBWw7VOlmQ1WnpbvxY6qEIw5GjpcksDJsWCU
 Mfzz0q0t3gXNSvzb/QDe7EWe9gSL5BV/ANQCw01GWdnttDanGFCQncWo92PFzzA10F65
 UlJO86V+tUog2i8upjU76ETCUUm0PbvyfSqhzYVXgOBze33+VHdDuGo6SN2N2ovfXVpx
 l/X7F8dQVfor639oviMPryx6ctpMCV4QzViO/e9b4LbOQg4wEOr4Tbbwx+wXioBYvRHT
 VQSQ==
X-Gm-Message-State: AOJu0YzK/zz216P82bTrF+uBa9/BngCmx4Xejf3YybeHQeIJHZr3sc8v
 Y/6IMbU73EuFNiihZi1BuDX+h6wehh23XGZ7biiRw9CVihYZvJ1AUpEytgKS7+gU/33uHQPKfUc
 G16bdZSnJ2iisGXbNFmP/qY/T9ZJIDsE=
X-Received: by 2002:a67:f918:0:b0:452:8e07:db61 with SMTP id
 t24-20020a67f918000000b004528e07db61mr30183842vsq.6.1697449209733; 
 Mon, 16 Oct 2023 02:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeEybi1nyWAay/SXDMqsZua1lNivchhLVR++qCAGqJtAyFdGpBHkUXtFhPc90GqYabdNRBB9zp7COEMpDXQm8=
X-Received: by 2002:a67:f918:0:b0:452:8e07:db61 with SMTP id
 t24-20020a67f918000000b004528e07db61mr30183829vsq.6.1697449209434; Mon, 16
 Oct 2023 02:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231013153027.800327-1-pbonzini@redhat.com>
 <cee1cc9f-ed36-4300-a712-d3fbef4bb395@redhat.com>
 <ZSz9AFwxPBsoRMih@redhat.com>
 <d956a7d4-35c2-4a59-9c56-6b69afbc3810@redhat.com>
In-Reply-To: <d956a7d4-35c2-4a59-9c56-6b69afbc3810@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Oct 2023 11:39:57 +0200
Message-ID: <CABgObfaM83R8dFft7m9FZbg5RUaxhCdqwPxg_z3mq2tSJs9O1w@mail.gmail.com>
Subject: Re: [PATCH] tests/vm: netbsd: install dtc
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Reinoud Zandijk <reinoud@netbsd.org>,
 Ryo ONODERA <ryoon@netbsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 16, 2023 at 11:21=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 16/10/2023 11.06, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Oct 16, 2023 at 11:00:14AM +0200, Thomas Huth wrote:
> >> On 13/10/2023 17.30, Paolo Bonzini wrote:
> >>> Install dtc as it is now a mandatory external dependency in order to =
build QEMU.
> >>>
> >>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> ---
> >>>    tests/vm/netbsd | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> >>> index 939dc1b22a1..3ef1ec2d9cc 100755
> >>> --- a/tests/vm/netbsd
> >>> +++ b/tests/vm/netbsd
> >>> @@ -40,6 +40,9 @@ class NetBSDVM(basevm.BaseVM):
> >>>            "gsed",
> >>>            "gettext-tools",
> >>> +        # libs: basic
> >>> +        "dtc",
> >>> +
> >>>            # libs: crypto
> >>>            "gnutls",
> >>
> >> Does this work for you? When I run "make vm-build-netbsd", I'm still g=
etting
> >> a failure:
> >>
> >> 76 packages to install:
> >>    git-base-2.41.0nb1 pkgconf-1.9.5 xz-5.4.3 python310-3.10.12
> >> py310-expat-3.10.12nb1 ninja-build-1.11.1
> >>    bash-5.2.15 gmake-4.4.1 gsed-4.9nb1 gettext-tools-0.21.1 dtc-1.7.0
> >> gnutls-3.8.0nb3 jpeg-9e png-1.6.39
> >>    capstone-4.0.2 SDL2-2.26.5nb1 gtk3+-3.24.38 zstd-1.5.5 libslirp-4.7=
.0nb1
> >> pcre2-10.42 curl-8.1.2
> >>    libuuid-2.32.1nb1 libffi-3.4.4 gettext-lib-0.21.1 p11-kit-0.24.1 ne=
ttle-3.9.1
> >>    mozilla-rootcerts-1.0.20230505 libtasn1-4.19.0 libcfg+-0.7.0 gmp-6.=
2.1nb3
> >> wayland-protocols-1.31nb1
> >>    wayland-1.21.0nb2 libxkbcommon-1.5.0nb1 libsamplerate-0.2.2nb4
> >> shared-mime-info-2.2nb2 pango-1.50.12nb1
> >>    libcups-2.4.6nb1 libXft-2.3.8 hicolor-icon-theme-0.17nb1 glib2-2.74=
.6nb1
> >> gdk-pixbuf2-2.42.10nb2
> >>    fribidi-1.0.13 freetype2-2.13.0nb1 fontconfig-2.14.2nb1
> >> cairo-gobject-1.16.0nb7 cairo-1.16.0nb9 atk-2.38.0
> >>    at-spi2-atk-2.38.0nb1 lz4-1.9.4 nghttp2-1.54.0 libidn2-2.3.4
> >> readline-8.2nb2 libsndfile-1.2.0nb2
> >>    fftw-3.3.10nb1 libxslt-1.1.38 libepoll-shim-0.0.20230411
> >> at-spi2-core-2.40.3nb2 lzo-2.10 brotli-1.0.9
> >>    tiff-4.5.1nb1 libpaper-2.1.0nb2 dbus-1.14.6 harfbuzz-7.3.0
> >> graphite2-1.3.14nb1 libunistring-1.1
> >>    libxml2-2.10.4nb1 libgcrypt-1.10.2 mpg123-1.31.3 libvorbis-1.3.7
> >> libopus-1.4 libogg-1.3.5nb1 lame-3.100nb5
> >>    flac-1.4.2 jbigkit-2.1nb1 xmlcatmgr-2.2nb1 libgpg-error-1.47
> >> [...]
> >> installing dtc-1.7.0...
> >> [...]
> >> The Meson build system
> >> Version: 0.63.3
> >> Source dir: /home/qemu/qemu-test.Li0spd/src
> >> Build dir: /home/qemu/qemu-test.Li0spd/build
> >> Build type: native build
> >> Project name: qemu
> >> Project version: 8.1.50
> >> C compiler for the host machine: cc -m64 -mcx16 (gcc 7.5.0 "cc (nb4
> >> 20200810) 7.5.0")
> >> C linker for the host machine: cc -m64 -mcx16 ld.bfd 2.31.1
> >> [...]
> >> Run-time dependency capstone found: YES 4.0.2
> >> Library fdt found: NO
> >> Initialized empty Git repository in
> >> /home/qemu/qemu-test.Li0spd/src/subprojects/dtc/.git/
> >> fatal: unable to access 'https://gitlab.com/qemu-project/dtc.git/': SS=
L
> >> certificate problem: unable to get local issuer certificate
> >>
> >> ../src/meson.build:3076:4: ERROR: Git command failed: ['/usr/pkg/bin/g=
it',
> >> 'fetch', '--depth', '1', 'origin',
> >> 'b6910bec11614980a21e46fbccc35934b671bd81']
> >>
> >> A full log can be found at
> >> /home/qemu/qemu-test.Li0spd/build/meson-logs/meson-log.txt
> >>
> >> ERROR: meson setup failed
> >>
> >> ... so though the NetBSD people finally upgraded their dtc to a usable
> >> level, our meson.build seems to be unable to detect it?
> >
> > They claim to have version 1.7.0
> >
> >    https://ftp.netbsd.org/pub/pkgsrc/current/pkgsrc/sysutils/dtc/index.=
html
> >
> > and we claim to want 1.5.0, so should be OK.
> >
> > Suggests that our detection, or test compilation is failing. The
> > meson-log.txt might have more info, if you can access that ?
>
> Look like libfdt is installed there in an unusual location?

Indeed, and it looks like it's intentional; from https://pkgin.net/,
for example:

> Invoke the configure script, for example:
>
> $ ./configure --prefix=3D/usr/pkg --with-libraries=3D/usr/pkg/lib --with-=
includes=3D/usr/pkg/include
>
> And finally build the binary:
>
> $ make

Paolo


