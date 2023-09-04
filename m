Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4B7917C6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9HH-0006oE-2z; Mon, 04 Sep 2023 09:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qd9H6-0006n2-Lo
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qd9H4-00047t-61
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:05:52 -0400
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-KwB1uegrNJmamFdGjHQySw-1; Mon, 04 Sep 2023 09:05:46 -0400
X-MC-Unique: KwB1uegrNJmamFdGjHQySw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7336912B66;
 Mon,  4 Sep 2023 13:05:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D04BC124A;
 Mon,  4 Sep 2023 13:05:44 +0000 (UTC)
Date: Mon, 4 Sep 2023 14:05:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 49/67] ui/vc: split off the VC part from console.c
Message-ID: <ZPXWJQUrCSZrOyDr@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-50-marcandre.lureau@redhat.com>
 <ZPId9976tOP7o8XS@redhat.com>
 <CAJ+F1C+mLdhOZgQs+v+7Me8m42re9i4D2LuVaqEimFXW+3X02w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+mLdhOZgQs+v+7Me8m42re9i4D2LuVaqEimFXW+3X02w@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 04, 2023 at 04:57:45PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Sep 1, 2023 at 9:23 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 01:38:23PM +0400, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > Move common declarations to console-priv.h, and add a new unit
> > > console-vc.c which will handle VC/chardev rendering, when pixman is
> > > available.
> > >
> > > (if necessary, the move could be done chunk by chunks)
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  ui/console-priv.h |   43 ++
> > >  ui/console-vc.c   | 1079 ++++++++++++++++++++++++++++++++++++++++++++
> > >  ui/console.c      | 1096 +--------------------------------------------
> > >  ui/meson.build    |    1 +
> > >  4 files changed, 1126 insertions(+), 1093 deletions(-)
> > >  create mode 100644 ui/console-priv.h
> > >  create mode 100644 ui/console-vc.c
> > >
> > > diff --git a/ui/console-vc.c b/ui/console-vc.c
> > > new file mode 100644
> > > index 0000000000..656f099556
> > > --- /dev/null
> > > +++ b/ui/console-vc.c
> > > @@ -0,0 +1,1079 @@
> > > +/*
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + * QEMU VC
> >
> > This code is moved out of console.c, which (surprisingly) appears
> > to have an MIT license header.
> >
> 
> updated
> 
> >
> > The include/ui/console.h header meanwhile has no license, so is
> > valid to assume it is GPL-2.0-or-later I guess.
> >
> 
> Do you think I should split this patch in multiple patches? or can you
> r-b it with the license change?

No need to split IMHO. With the MIT license for the .c file,

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


