Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E968678D57F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJG8-0003wo-Oy; Wed, 30 Aug 2023 07:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbJG6-0003wG-SB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbJG4-0006Ff-5v
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693394471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTR34d595pJr6oKP/2WuO/wseuhw1t9Ci0hmHReg+4A=;
 b=L8/o8m8wo3uVFy6kJrpM9bfHb/thER2bXyfWSoJzaegc4YsQH0APtk41d80yfnJruhQ0ls
 E4QWOftIjkJw0nYyylDRtqWSK84dOD6jKN5X0O61Dv0Vr8QOqq5xEpl5umT8enRnTffFKr
 mfPl93xhqpKyUQ0S1QrooZPWyZMf/YQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-fFzMRDwXPt6MvGvEKTSCyQ-1; Wed, 30 Aug 2023 07:21:10 -0400
X-MC-Unique: fFzMRDwXPt6MvGvEKTSCyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6801185A78F;
 Wed, 30 Aug 2023 11:21:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1342E2166B25;
 Wed, 30 Aug 2023 11:21:08 +0000 (UTC)
Date: Wed, 30 Aug 2023 12:21:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/67] Make pixman an optional dependency
Message-ID: <ZO8mIo+xdXK022k/@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <740c7ad9-1c6f-ec7f-29d5-153bfc5f68ab@redhat.com>
 <CAMxuvazwReV-_W-DAGNc46xRck5OofnB60xVPSUW1BeacVahYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazwReV-_W-DAGNc46xRck5OofnB60xVPSUW1BeacVahYA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Aug 30, 2023 at 03:01:27PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Aug 30, 2023 at 2:53 PM Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 30/08/2023 11.37, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > Hi,
> > >
> > > QEMU system emulators can be made to compile and work without pixman.
> > >
> > > Given how pervasively pixman types and API is used in all the code base, it was
> > > a bit difficult to figure out how to cut the dependency.
> > >
> > > I decided that it was important to keep VGA and graphics device working for
> > > compatibility reasons, although some devices, such as xlnx Display Port, have
> > > stronger dependency and have to be disabled. The ui/console code also has a lot
> > > of pixman usage and a bit of a mess to deal with. I made large refactoring to
> > > allow to compile out the VC code.
> > >
> > > The series can be roughly divded as:
> > > - a few related preliminary cleanups
> > > - ui/console refactoring to allow ui/vc split
> > > - add a 'pixman' option, and a minimal pixman-compat.h
> > > - make some parts depend on 'pixman'
> > >
> > > Graphic -display still work, although with some caveats. For ex, -display sdl or
> > > cocoa don't have VCs, so starting QEMU will print the following warnings when
> > > pixman is disabled:
> >
> > I just had a quick look at the series, but for me it looks like this is
> > adding a lot of additional complexity to the code (adds lots of #ifdefs, and
> > adds a subset of the pixman library to the code base), which seems somewhat
> 
> The #ifdef aren't so bad (at least I can bare it). Just a quick stat:
> 
> $ git diff origin/master | grep "+#ifdef CONFIG_PIXMAN" | wc -l
> 11
> 
> > unfortunate for such a marginal feature request. What's really so bad about
> > requiring pixman for building QEMU?
> 
> Not that a good part of the series is cleaning up ui/console.c code
> that really deserved it. It makes it use QOM, and split VC code. It's
> still worth it regardless of the outcome for pixman.

I've done a review of the start and like the cleanup patches, and the
adaption to make sane use of inheritance in QOM rather than the poor
man's inheritance via the console type field. I agree that's worthwhile
regardless of what we think about pixman optionality.

> > IMHO, if we really want to go down this path, I think we should rather
> > disable all graphic related stuff in QEMU instead, i.e. disable VGA cards,
> > Spice, SDL, etc. completely. I think this is also what has been requested in
> >
> 
> The various features and devices can be disabled by other means. I
> think we should aim at making the different configure options
> orthogonal, so QEMU without pixman can still provide most gfx/vga/UI
> experience too, by default.

To me where this series becomes dubious is roughly around the patch
that adds pixman-compat.h providing a bunch of pixman API as stubs.

If we can use Kconfig and/or meson options to simply drop the build
of files in QEMU that require pixman that's reasonable. If we're
adding compat APIs the provide local impls of pixman APIs it feels
wrong to me.

> > the original gitlab issue ticket where the reporter wanted to compile a
> > text-mode only QEMU binary...?
> 
> So that is not an incompatible goal, further tuning of configure
> options can help.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


