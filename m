Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1802791906
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9sT-0000jo-Sc; Mon, 04 Sep 2023 09:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qd9sR-0000ht-QB
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qd9sP-00045c-7J
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693835063;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnfCxHVle/HtYPTq0AyWkvLFzuiG8y6Do7FnW90pDso=;
 b=gw2YVzGLbe3/YJcHyymIzRCRGAisBOc8GBXwIJsebCLsWtZem8S5wW6QcDjCOWHdPE/6YO
 Z8ucYhtI2YRXbja354X3ObhGAHVbZXHIVXnD2OfMJi/TaCCacOyqDDghEyM0cB8CFZIlnc
 Qkyam09qAUWofMFBweKkA73zAr3L5Io=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-NW7_mtB0MpWywvROCvMwcw-1; Mon, 04 Sep 2023 09:44:20 -0400
X-MC-Unique: NW7_mtB0MpWywvROCvMwcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FEE3912B66;
 Mon,  4 Sep 2023 13:44:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9440C02996;
 Mon,  4 Sep 2023 13:44:19 +0000 (UTC)
Date: Mon, 4 Sep 2023 14:44:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 54/67] ui/vc: console-vc requires PIXMAN
Message-ID: <ZPXfMcJwKqN9H4Np@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-55-marcandre.lureau@redhat.com>
 <ZPIfJd0h6h5zeiMa@redhat.com>
 <CAJ+F1C+ZAzG16vaPoDgzUybSbnk0sWjDhH0nSjU7P71btp2d9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+ZAzG16vaPoDgzUybSbnk0sWjDhH0nSjU7P71btp2d9g@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Mon, Sep 04, 2023 at 05:41:23PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Sep 1, 2023 at 9:28 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 01:38:28PM +0400, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > Add stubs for the fallback paths.
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  ui/console-vc-stubs.c | 59 +++++++++++++++++++++++++++++++++++++++++++
> > >  ui/meson.build        |  2 +-
> > >  2 files changed, 60 insertions(+), 1 deletion(-)
> > >  create mode 100644 ui/console-vc-stubs.c
> > >
> > > diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
> > > new file mode 100644
> > > index 0000000000..76ea880d27
> > > --- /dev/null
> > > +++ b/ui/console-vc-stubs.c
> > > @@ -0,0 +1,59 @@
> > > +/*
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + * QEMU VC stubs
> > > + */
> > > +#include "qemu/osdep.h"
> > > +
> > > +#include "qapi/error.h"
> > > +#include "qemu/error-report.h"
> > > +#include "qemu/option.h"
> > > +#include "chardev/char.h"
> > > +#include "ui/console-priv.h"
> > > +
> > > +void qemu_text_console_select(QemuTextConsole *c)
> > > +{
> > > +}
> > > +
> > > +const char * qemu_text_console_get_label(QemuTextConsole *c)
> > > +{
> > > +    return NULL;
> > > +}
> > > +
> > > +void qemu_text_console_update_cursor(void)
> > > +{
> > > +}
> > > +
> > > +void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
> > > +{
> > > +}
> > > +
> > > +#define TYPE_CHARDEV_VC "chardev-vc"
> > > +
> > > +static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
> > > +{
> > > +    const char *id = qemu_opts_id(opts);
> > > +
> > > +    warn_report("%s: this is a dummy VC driver. "
> > > +                "Use '-nographic' or a different chardev.", id);
> > > +}
> >
> > Why should this be an error_setg() call given we have a errp
> > parameter, so make this unsupportable config into an error ?
> > Ignoring invalid user configs is not desirable in general.
> 
> This was to keep starting as default, regardless of pixman support.
> 
> Since, by default, QEMU will create the following VCs (vl.c):
> 
>             add_device_config(DEV_SERIAL, "vc:80Cx24C");
>             add_device_config(DEV_PARALLEL, "vc:80Cx24C");
>             monitor_parse("vc:80Cx24C", "readline", false);
> 
> With SDL or VNC, this will associate the QemuTextConsole(s), which is
> disabled without pixman. Maybe we shouldn't create those VC by default
> when the backend doesn't support it (but to null instead).

Yeah, probably best to just use 'null' of 'vc' for that scenario,
since the stub is effectively 'null' anyway.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


