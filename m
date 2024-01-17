Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A7830827
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:33:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6yd-0001gY-BM; Wed, 17 Jan 2024 09:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rQ6ya-0001fw-Vy; Wed, 17 Jan 2024 09:33:09 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rQ6ya-0006eh-MX; Wed, 17 Jan 2024 09:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=uSteFaugoChVUU6HBtowSthk1ZbAz03szTuz8lpPGRQ=; b=lvcZy4bCli1AROKvqo3v
 Cdty9pPdPKM7CtrD98NbjVC+0oTnJwQU2yQAtuaWVU5D26MEzrXVuR4KT0IlQ69Px2nWOxcY2l/Kd
 hJ9i3NL207N7PqnUj9Be+JxO8gkH7F+SVeavPtdn7TsFnaaUBDaEgMq+ZuDWL984hycE1yiZ5ehvi
 lwuDF3tCUUolEHn58c2QrThVsSdtL+exMlQmLCNrS0LsSAvdMdVp1sGv3waULQnD3O/84Q7gHzkjl
 vyP6QP+D1SGup+oB3o5pAwG+z9MKBxwfpjcEs8HAAZoK4WF/iR+2Ni/fJ7FgU4iOwp+P3KglklNL+
 h1WIUGwQJAimBA==;
Date: Wed, 17 Jan 2024 15:33:06 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, bug-hurd@gnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
Message-ID: <20240117143306.lnycf2ijwkzycowj@begin>
Mail-Followup-To: Manolo de Medici <manolodemedici@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, bug-hurd@gnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
 <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
 <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Manolo de Medici, le mer. 17 janv. 2024 15:09:39 +0100, a ecrit:
> Hello Philippe,
> thank you for the feedback, I've checked that. The problem is that the
> Hurd fails that test due to the following:
> 
>         #if defined __stub_copy_file_range || defined __stub___copy_file_range
>         fail fail fail this function is not going to work
>         #endifefines the stub __copy_file_ran
> 
> rightfully so I'd say, because copy_file_range is just a stub on the Hurd.

Yes.

> As such, we really need to exclude the code that defines the stub in
> qemu on the Hurd.

But how do things work without the qemu stub?

Or put another way: what problem exactly the presence of the qemu stub
makes?

Samuel

> On Wed, Jan 17, 2024 at 2:56 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
> >
> > Hi Manolo,
> >
> > On 17/1/24 13:31, Manolo de Medici wrote:
> > > It's already defined as a stub on the GNU Hurd.
> >
> > Meson checks for this function and defines
> > HAVE_COPY_FILE_RANGE if available, see in meson.build:
> >
> >    config_host_data.set('HAVE_COPY_FILE_RANGE',
> >                         cc.has_function('copy_file_range'))
> >
> > Maybe some header is missing in "osdep.h" for GNU Hurd?
> >
> > > Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> > >
> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 35684f7e21..05426abb7d 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
> > >       return handle_aiocb_write_zeroes(aiocb);
> > >   }
> > >
> > > -#ifndef HAVE_COPY_FILE_RANGE
> > > +#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
> > >   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> > >                                off_t *out_off, size_t len, unsigned int flags)
> > >   {
> > > ---
> > >   block/file-posix.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 35684f7e21..05426abb7d 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
> > >       return handle_aiocb_write_zeroes(aiocb);
> > >   }
> > >
> > > -#ifndef HAVE_COPY_FILE_RANGE
> > > +#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
> > >   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> > >                                off_t *out_off, size_t len, unsigned int flags)
> > >   {
> > > --
> > > 2.43.0
> > >
> >

