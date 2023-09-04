Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF97917C7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9Gk-0006iX-7h; Mon, 04 Sep 2023 09:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qd9Gb-0006hc-51
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qd9GX-0003xh-9n
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693832715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AD4BeVtzQsrqgT26Kqx6tlVr0Z9wDrABFh/jgBJfYn4=;
 b=KiWazvvTmjyhzV9P9XO7KztAqmxVapn96d4BgSOxniYUACmwuH+lxpopw43iWfUW1GUGqA
 j5LuWNGHBWvpBQ8EZpBgJZoURkjfm36PVTMe6pXDXuDaEO/9IC35xoR/tutdLmYTsRM0S0
 xGfhU8UInMm+ZNQZmlBG3WuHaXKLdAQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-oCmKC4ErOWytRcy3I8TQAw-1; Mon, 04 Sep 2023 09:05:12 -0400
X-MC-Unique: oCmKC4ErOWytRcy3I8TQAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D3E3C0DDAD;
 Mon,  4 Sep 2023 13:05:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64CC7493114;
 Mon,  4 Sep 2023 13:05:11 +0000 (UTC)
Date: Mon, 4 Sep 2023 14:05:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 50/67] ui/console: move DisplaySurface to its own header
Message-ID: <ZPXWBOdt4SmLZtQw@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-51-marcandre.lureau@redhat.com>
 <ZPIeP6Gwm5AtfUgF@redhat.com>
 <CAJ+F1C+wwdoDV6bnuRbkHxpmmnrMAD_gcR3DU5-kD1dsQ2iuqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+wwdoDV6bnuRbkHxpmmnrMAD_gcR3DU5-kD1dsQ2iuqA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Mon, Sep 04, 2023 at 04:59:31PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Sep 1, 2023 at 9:24 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 01:38:24PM +0400, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > Mostly for readability reasons.
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  include/ui/console.h | 84 +---------------------------------------
> > >  include/ui/surface.h | 91 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 92 insertions(+), 83 deletions(-)
> > >  create mode 100644 include/ui/surface.h
> > >
> >
> > > diff --git a/include/ui/surface.h b/include/ui/surface.h
> > > new file mode 100644
> > > index 0000000000..37725a303e
> > > --- /dev/null
> > > +++ b/include/ui/surface.h
> > > @@ -0,0 +1,91 @@
> >
> > When you moved the VC bits out of console.h you added a GPL-2.0-or-later
> > SPDX tag, so by implication this ought to gain the same.
> >
> 
> 
> Done. R-B with that change?

Yep, Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
with the GPL-2.0-or-later addition

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


