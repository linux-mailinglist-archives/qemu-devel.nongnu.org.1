Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A757B7CA37F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:06:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJYg-0006kM-5A; Mon, 16 Oct 2023 05:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qsJYH-0006et-HM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qsJYF-0004FW-6l
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697447173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+Pgu6xwPZDll+IT3/B54mKLFrkrQEtd3wETVyi/+Rf0=;
 b=YDqvZuBYen4BQsl/KW1XFS6sibZsFnUK9Gp0CQU610Ub+IY7jZYqplw11bQ3Re0j6d7Gd8
 7IRRiYv0YJL9upMCNVBqOWYjIcI3ijk+Cs28g3PJhoxC/PTblOJk/H3Pg0vcVEvovcFrZi
 CvYUNQuS+evmSpGoICV+CjYnNJy6ACU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-80Ku-92fPgi5PPXL_CGkcw-1; Mon, 16 Oct 2023 05:06:11 -0400
X-MC-Unique: 80Ku-92fPgi5PPXL_CGkcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394F3862DFD
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:06:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0D263F21;
 Mon, 16 Oct 2023 09:06:10 +0000 (UTC)
Date: Mon, 16 Oct 2023 10:06:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/vm: netbsd: install dtc
Message-ID: <ZSz9AFwxPBsoRMih@redhat.com>
References: <20231013153027.800327-1-pbonzini@redhat.com>
 <cee1cc9f-ed36-4300-a712-d3fbef4bb395@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cee1cc9f-ed36-4300-a712-d3fbef4bb395@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 16, 2023 at 11:00:14AM +0200, Thomas Huth wrote:
> On 13/10/2023 17.30, Paolo Bonzini wrote:
> > Install dtc as it is now a mandatory external dependency in order to build QEMU.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   tests/vm/netbsd | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> > index 939dc1b22a1..3ef1ec2d9cc 100755
> > --- a/tests/vm/netbsd
> > +++ b/tests/vm/netbsd
> > @@ -40,6 +40,9 @@ class NetBSDVM(basevm.BaseVM):
> >           "gsed",
> >           "gettext-tools",
> > +        # libs: basic
> > +        "dtc",
> > +
> >           # libs: crypto
> >           "gnutls",
> 
> Does this work for you? When I run "make vm-build-netbsd", I'm still getting
> a failure:
> 
> 76 packages to install:
>   git-base-2.41.0nb1 pkgconf-1.9.5 xz-5.4.3 python310-3.10.12
> py310-expat-3.10.12nb1 ninja-build-1.11.1
>   bash-5.2.15 gmake-4.4.1 gsed-4.9nb1 gettext-tools-0.21.1 dtc-1.7.0
> gnutls-3.8.0nb3 jpeg-9e png-1.6.39
>   capstone-4.0.2 SDL2-2.26.5nb1 gtk3+-3.24.38 zstd-1.5.5 libslirp-4.7.0nb1
> pcre2-10.42 curl-8.1.2
>   libuuid-2.32.1nb1 libffi-3.4.4 gettext-lib-0.21.1 p11-kit-0.24.1 nettle-3.9.1
>   mozilla-rootcerts-1.0.20230505 libtasn1-4.19.0 libcfg+-0.7.0 gmp-6.2.1nb3
> wayland-protocols-1.31nb1
>   wayland-1.21.0nb2 libxkbcommon-1.5.0nb1 libsamplerate-0.2.2nb4
> shared-mime-info-2.2nb2 pango-1.50.12nb1
>   libcups-2.4.6nb1 libXft-2.3.8 hicolor-icon-theme-0.17nb1 glib2-2.74.6nb1
> gdk-pixbuf2-2.42.10nb2
>   fribidi-1.0.13 freetype2-2.13.0nb1 fontconfig-2.14.2nb1
> cairo-gobject-1.16.0nb7 cairo-1.16.0nb9 atk-2.38.0
>   at-spi2-atk-2.38.0nb1 lz4-1.9.4 nghttp2-1.54.0 libidn2-2.3.4
> readline-8.2nb2 libsndfile-1.2.0nb2
>   fftw-3.3.10nb1 libxslt-1.1.38 libepoll-shim-0.0.20230411
> at-spi2-core-2.40.3nb2 lzo-2.10 brotli-1.0.9
>   tiff-4.5.1nb1 libpaper-2.1.0nb2 dbus-1.14.6 harfbuzz-7.3.0
> graphite2-1.3.14nb1 libunistring-1.1
>   libxml2-2.10.4nb1 libgcrypt-1.10.2 mpg123-1.31.3 libvorbis-1.3.7
> libopus-1.4 libogg-1.3.5nb1 lame-3.100nb5
>   flac-1.4.2 jbigkit-2.1nb1 xmlcatmgr-2.2nb1 libgpg-error-1.47
> [...]
> installing dtc-1.7.0...
> [...]
> The Meson build system
> Version: 0.63.3
> Source dir: /home/qemu/qemu-test.Li0spd/src
> Build dir: /home/qemu/qemu-test.Li0spd/build
> Build type: native build
> Project name: qemu
> Project version: 8.1.50
> C compiler for the host machine: cc -m64 -mcx16 (gcc 7.5.0 "cc (nb4
> 20200810) 7.5.0")
> C linker for the host machine: cc -m64 -mcx16 ld.bfd 2.31.1
> [...]
> Run-time dependency capstone found: YES 4.0.2
> Library fdt found: NO
> Initialized empty Git repository in
> /home/qemu/qemu-test.Li0spd/src/subprojects/dtc/.git/
> fatal: unable to access 'https://gitlab.com/qemu-project/dtc.git/': SSL
> certificate problem: unable to get local issuer certificate
> 
> ../src/meson.build:3076:4: ERROR: Git command failed: ['/usr/pkg/bin/git',
> 'fetch', '--depth', '1', 'origin',
> 'b6910bec11614980a21e46fbccc35934b671bd81']
> 
> A full log can be found at
> /home/qemu/qemu-test.Li0spd/build/meson-logs/meson-log.txt
> 
> ERROR: meson setup failed
> 
> ... so though the NetBSD people finally upgraded their dtc to a usable
> level, our meson.build seems to be unable to detect it?

They claim to have version 1.7.0

  https://ftp.netbsd.org/pub/pkgsrc/current/pkgsrc/sysutils/dtc/index.html

and we claim to want 1.5.0, so should be OK.

Suggests that our detection, or test compilation is failing. The
meson-log.txt might have more info, if you can access that ?


Also separately it appears we're missing the public CA cert bundle,
so we should not see a cert error from gitlab.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


