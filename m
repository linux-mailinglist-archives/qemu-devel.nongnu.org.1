Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4D74ADE9
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhuq-0007Vg-AY; Fri, 07 Jul 2023 05:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qHhuo-0007UL-AV
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qHhum-0000tN-5C
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688722689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yz1C/j3fpDV+3qKoIACdnHqaJPv1ql4+qSLsiQ3694=;
 b=LxyVd9o6vj0SgEPWfTQgHC3PSxdCZcp+hDog9pqHeUvgufWRs0D7JVE3e8/m3SYTkgRHTW
 mBzcZhpgYBKzjEyfPvroGwiSySGzAZuT4UAo8NPsFPaDlBq5ulKq+o7zo/zYzVu8l1vtjI
 C2oKUHLjWh81ZibbD+JD1Uc1uOGNBPE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-ThswCoQqOCCdWzfPpmFhJw-1; Fri, 07 Jul 2023 05:38:07 -0400
X-MC-Unique: ThswCoQqOCCdWzfPpmFhJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8C1F1C04B63;
 Fri,  7 Jul 2023 09:38:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D50BF640B;
 Fri,  7 Jul 2023 09:38:04 +0000 (UTC)
Date: Fri, 7 Jul 2023 10:38:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 jiangyegen <jiangyegen@huawei.com>
Subject: Re: [PATCH] io: remove io watch if TLS channel is closed during
 handshake
Message-ID: <ZKfc+kL7PEEZ7h96@redhat.com>
References: <20230705181718.387522-1-berrange@redhat.com>
 <CAJ+F1CJt1PPSVwMAstLRog5PtPvAvA4xuccZgenTDc5SBLTGQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJt1PPSVwMAstLRog5PtPvAvA4xuccZgenTDc5SBLTGQQ@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 07, 2023 at 01:30:16PM +0400, Marc-André Lureau wrote:
> On Wed, Jul 5, 2023 at 10:20 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > The TLS handshake make take some time to complete, during which time an
> > I/O watch might be registered with the main loop. If the owner of the
> > I/O channel invokes qio_channel_close() while the handshake is waiting
> > to continue the I/O watch must be removed. Failing to remove it will
> > later trigger the completion callback which the owner is not expecting
> > to receive. In the case of the VNC server, this results in a SEGV as
> > vnc_disconnect_start() tries to shutdown a client connection that is
> > already gone / NULL.
> >
> > CVE-2023-3354
> > Reported-by: jiangyegen <jiangyegen@huawei.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> 
> 
> 
> > ---
> >  include/io/channel-tls.h |  1 +
> >  io/channel-tls.c         | 18 ++++++++++++------
> >  2 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
> > index 5672479e9e..26c67f17e2 100644
> > --- a/include/io/channel-tls.h
> > +++ b/include/io/channel-tls.h
> > @@ -48,6 +48,7 @@ struct QIOChannelTLS {
> >      QIOChannel *master;
> >      QCryptoTLSSession *session;
> >      QIOChannelShutdown shutdown;
> > +    guint hs_ioc_tag;
> >  };
> >
> >  /**
> > diff --git a/io/channel-tls.c b/io/channel-tls.c
> > index 9805dd0a3f..e327e6a5c2 100644
> > --- a/io/channel-tls.c
> > +++ b/io/channel-tls.c
> > @@ -198,12 +198,13 @@ static void
> > qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
> >          }
> >
> >          trace_qio_channel_tls_handshake_pending(ioc, status);
> > -        qio_channel_add_watch_full(ioc->master,
> > -                                   condition,
> > -                                   qio_channel_tls_handshake_io,
> > -                                   data,
> > -                                   NULL,
> > -                                   context);
> > +        ioc->hs_ioc_tag =
> > +            qio_channel_add_watch_full(ioc->master,
> > +                                       condition,
> > +                                       qio_channel_tls_handshake_io,
> > +                                       data,
> > +                                       NULL,
> > +                                       context);
> >      }
> >  }
> >
> > @@ -218,6 +219,7 @@ static gboolean
> > qio_channel_tls_handshake_io(QIOChannel *ioc,
> >      QIOChannelTLS *tioc = QIO_CHANNEL_TLS(
> >          qio_task_get_source(task));
> >
> > +    tioc->hs_ioc_tag = 0;
> >      g_free(data);
> >      qio_channel_tls_handshake_task(tioc, task, context);
> >
> > @@ -378,6 +380,10 @@ static int qio_channel_tls_close(QIOChannel *ioc,
> >  {
> >      QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
> >
> > +    if (tioc->hs_ioc_tag) {
> > +        g_source_remove(tioc->hs_ioc_tag);
> >
> 
> set it to 0 ?
> or
> g_clear_handle_id(&tios->hs_ioc_tag, g_source_remove);

Yes, close can be called mutliple times, so we must set to zero.

> > +    }
> > +
> >      return qio_channel_close(tioc->master, errp);
> >  }
> >
> > --
> > 2.41.0
> >
> >
> >
> 
> -- 
> Marc-André Lureau

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


