Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DC79016A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:26:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7uQ-0002Wy-U1; Fri, 01 Sep 2023 13:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7u7-0002WX-6O
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7u4-0001EW-60
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693589151;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybKG+mP87ewv3f9de9EtOHrhIPuwwBrQv/VLHEuYE20=;
 b=JUKM5S+LUuMdEUYpq+PfpjeQ/KxmBYTiB2t9tF0CnDAiEwWW8BRr/iMXzgTMMWxEKZVft0
 6R7PfquQYmwlOAT5GLXv73GKYjtL16d+XfXB1t9Pdei9FoNIURjaUe9X6X5+xY3jyc6bUA
 poqb2saqtPekMJKyMNcHDQVSYyeAwws=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-JtSnsOCoMBKaPkV51l6cFg-1; Fri, 01 Sep 2023 13:25:49 -0400
X-MC-Unique: JtSnsOCoMBKaPkV51l6cFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ECBE381CC0B;
 Fri,  1 Sep 2023 17:25:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E021460FE5;
 Fri,  1 Sep 2023 17:25:48 +0000 (UTC)
Date: Fri, 1 Sep 2023 18:25:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 51/67] build-sys: add optional "pixman" feature
Message-ID: <ZPIemvwFKAVL7bJH@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-52-marcandre.lureau@redhat.com>
 <784947c2-3b2a-6452-b009-c4a21fd67d0a@linaro.org>
 <fa0b84b4-f513-0667-eca2-e8dd70ae677a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa0b84b4-f513-0667-eca2-e8dd70ae677a@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Wed, Aug 30, 2023 at 05:55:26PM +0200, Philippe Mathieu-Daudé wrote:
> On 30/8/23 17:48, Philippe Mathieu-Daudé wrote:
> > On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > 
> > > Set CONFIG_PIXMAN accordinly.
> > > 
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >   meson.build       | 6 ++++--
> > >   Kconfig.host      | 3 +++
> > >   meson_options.txt | 2 ++
> > >   3 files changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/meson.build b/meson.build
> > > index 98e68ef0b1..3bd7046099 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -836,8 +836,8 @@ if 'ust' in get_option('trace_backends')
> > >                        method: 'pkg-config')
> > >   endif
> > >   pixman = not_found
> > > -if have_system or have_tools
> > > -  pixman = dependency('pixman-1', required: have_system,
> > > version:'>=0.21.8',
> > > +if not get_option('pixman').auto() or have_system or have_tools
> > > +  pixman = dependency('pixman-1', required: get_option('pixman'),
> > > version:'>=0.21.8',
> > >                         method: 'pkg-config')
> 
> 
> > > diff --git a/meson_options.txt b/meson_options.txt
> > > index aaea5ddd77..89654fd77d 100644
> > > --- a/meson_options.txt
> > > +++ b/meson_options.txt
> > > @@ -216,6 +216,8 @@ option('l2tpv3', type : 'feature', value : 'auto',
> > >          description: 'l2tpv3 network backend support')
> > >   option('netmap', type : 'feature', value : 'auto',
> > >          description: 'netmap network backend support')
> > > +option('pixman', type : 'feature', value : 'auto',
> > > +       description: 'pixman support')
> > >   option('slirp', type: 'feature', value: 'auto',
> > >          description: 'libslirp user mode network backend support')
> > >   option('vde', type : 'feature', value : 'auto',
> > 
> > Apparently missing:
> > 
> > -- >8 --
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> > index 9da3fe299b..16957ea9f0 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -146,6 +146,7 @@ meson_options_help() {
> >     printf "%s\n" '  pa              PulseAudio sound support'
> >     printf "%s\n" '  parallels       parallels image format support'
> >     printf "%s\n" '  pipewire        PipeWire sound support'
> > +  printf "%s\n" '  pixman          pixman support'
> >     printf "%s\n" '  png             PNG support with libpng'
> >     printf "%s\n" '  pvrdma          Enable PVRDMA support'
> >     printf "%s\n" '  qcow1           qcow1 image format support'
> > @@ -397,6 +398,8 @@ _meson_option_parse() {
> >       --disable-parallels) printf "%s" -Dparallels=disabled ;;
> >       --enable-pipewire) printf "%s" -Dpipewire=enabled ;;
> >       --disable-pipewire) printf "%s" -Dpipewire=disabled ;;
> > +    --enable-pixman) printf "%s" -Dpixman=enabled ;;
> > +    --disable-pixman) printf "%s" -Dpixman=disabled ;;
> >       --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
> >       --enable-png) printf "%s" -Dpng=enabled ;;
> >       --disable-png) printf "%s" -Dpng=disabled ;;
> > ---
> 
> Many files fail to build when using --disable-pixman here:

I guess meson.build ought to (temporarily) report an
eror if pixman is missing and/or explicitly disabled,
which is then removed in the next patch that actually
makes it work.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


