Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAD712614
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2W3S-0008TP-2H; Fri, 26 May 2023 07:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2W3M-0008Ot-5A
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2W3K-00018e-E0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685102173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tj3bPHgQUygW4vkM/m7RuVDN2EAu7BfagOs8r7Ie/GY=;
 b=HfQntK/W+6Xej/No4mCZhpdpzJeqOhDi7B32mPSJo7CM/0A8HhqwQ8JY+zPt541jw3vB5H
 7FjuRItFxPYgixU7dJ5HFhNIlY+y9PrJ9sfsidGISchoODfaEBBS7qV7Taj09onQGzULAO
 lDUe9a9Id8f4i/Tpvms21M/7ixdEvvE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-qz-87vSyOO2aujeZCZYNtw-1; Fri, 26 May 2023 07:56:12 -0400
X-MC-Unique: qz-87vSyOO2aujeZCZYNtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1CA72A2AD5C;
 Fri, 26 May 2023 11:56:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD60C7C2A;
 Fri, 26 May 2023 11:56:07 +0000 (UTC)
Date: Fri, 26 May 2023 12:56:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 3/6] tests/qtest: capture RESUME events during migration
Message-ID: <ZHCeUa4a9OYhNMRn@redhat.com>
References: <20230421171411.566300-1-berrange@redhat.com>
 <20230421171411.566300-4-berrange@redhat.com>
 <87leikgama.fsf@secure.mitica> <ZEZRoFtQg/MEdKi1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEZRoFtQg/MEdKi1@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Apr 24, 2023 at 10:53:36AM +0100, Daniel P. Berrangé wrote:
> On Fri, Apr 21, 2023 at 11:59:25PM +0200, Juan Quintela wrote:
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > When running migration tests we monitor for a STOP event so we can skip
> > > redundant waits. This will be needed for the RESUME event too shortly.
> > >
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > 
> > i.e. it is better that what we have now.
> > 
> > But
> > 
> > 
> > > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> > > index f6f3c6680f..61396335cc 100644
> > > --- a/tests/qtest/migration-helpers.c
> > > +++ b/tests/qtest/migration-helpers.c
> > > @@ -24,14 +24,20 @@
> > >  #define MIGRATION_STATUS_WAIT_TIMEOUT 120
> > >  
> > >  bool got_stop;
> > > +bool got_resume;
> > >  
> > > -static void check_stop_event(QTestState *who)
> > > +static void check_events(QTestState *who)
> > >  {
> > >      QDict *event = qtest_qmp_event_ref(who, "STOP");
> > >      if (event) {
> > >          got_stop = true;
> > >          qobject_unref(event);
> > >      }
> > > +    event = qtest_qmp_event_ref(who, "RESUME");
> > > +    if (event) {
> > > +        got_resume = true;
> > > +        qobject_unref(event);
> > > +    }
> > >  }
> > 
> > What happens if we receive the events in the order RESUME/STOP (I mean
> > in the big scheme of things, not that it makes sense in this particular
> > case).
> > 
> > QDict *qtest_qmp_event_ref(QTestState *s, const char *event)
> > {
> >     while (s->pending_events) {
> > 
> >         GList *first = s->pending_events;
> >         QDict *response = (QDict *)first->data;
> > 
> >         s->pending_events = g_list_delete_link(s->pending_events, first);
> > 
> >         if (!strcmp(qdict_get_str(response, "event"), event)) {
> >             return response;
> >         }
> >         qobject_unref(response);
> >     }
> >     return NULL;
> > }
> > 
> > if we don't found the event that we are searching for, we just drop it.
> > Does this makes sense if we are searching only for more than one event?
> 
> You are right about this code being broken in general for multiple events.
> 
> In this particular series though we're looking at STOP on the src host and
> RESUME on the dst host, so there's no ordering problem to worry about.

What I wrote is nonsense. This is broken, because on the dst host,
check_events will look for STOP and discard all remaining events,
so we'll never find the RESUME that we are looking for.

qtest_qmp_event_ref is essentially broken by design right now and
I'll need to fix it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


