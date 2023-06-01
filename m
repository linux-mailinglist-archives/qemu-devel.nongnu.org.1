Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7C4719CC9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hqs-0003WH-Cs; Thu, 01 Jun 2023 08:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hqp-0003W1-Dy
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hqn-0006vq-HM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685624180;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hy96/9kTdnNS2TTMewN/sjTVGrWURQhRVV+4Y2NHlgk=;
 b=BhGHNS+p9ZwkpN+WV1h1WYL/ue+NRogGmv8OcaAd+6MVxhdy6uCKuhCwByyzeSyid0Y2Rt
 OpXo0YocgoBztwG/KTV/BCDwoInwC+nQu8iu8kCynULzgsr4GSr5rA1/CYriTJf0vdxN4a
 So/8eLJxehW+EAjBvjrNxf42Az24mKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-FkLW3gjGMKCL34LGVoLcUg-1; Thu, 01 Jun 2023 08:56:19 -0400
X-MC-Unique: FkLW3gjGMKCL34LGVoLcUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27BA3811E78
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 12:56:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6FA140E6A43;
 Thu,  1 Jun 2023 12:56:17 +0000 (UTC)
Date: Thu, 1 Jun 2023 13:56:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/9] tests/qtest: add support for callback to receive
 QMP events
Message-ID: <ZHiVbkRkTFCqIzXg@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-3-berrange@redhat.com>
 <87zg5js7lb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg5js7lb.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Thu, Jun 01, 2023 at 02:14:08PM +0200, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> > Currently code must call one of the qtest_qmp_event* functions to
> > fetch events. These are only usable if the immediate caller knows
> > the particular event they want to capture, and are only interested
> > in one specific event type. Adding ability to register an event
> > callback lets the caller capture a range of events over any period
> > of time.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> First of all, I *love* the idea of the patch, but ...
> 
> >  static GHookList abrt_hooks;
> > @@ -703,8 +705,14 @@ QDict *qtest_qmp_receive(QTestState *s)
> >          if (!qdict_get_try_str(response, "event")) {
> >              return response;
> >          }
> > -        /* Stash the event for a later consumption */
> > -        s->pending_events = g_list_append(s->pending_events, response);
> > +
> > +        if (s->eventCB) {
> > +            s->eventCB(s, qdict_get_str(response, "event"),
> > +                       response, s->eventData);
> > +        } else {
> > +            /* Stash the event for a later consumption */
> > +            s->pending_events = g_list_append(s->pending_events, response);
> > +        }
> >      }
> 
> s->eventCB returns a bool that you are not using.  I think this part of
> the code would be more usefule if:
> 
>         if (!s->eventCB || !s->eventCB(s, qdict_get_str(response, "event"),
>                                        response, s->eventData)) {
>             /* Stash the event for a later consumption */
>             s->pending_events = g_list_append(s->pending_events, response);
>         }
> 
> So if we are not handling the event, we put it on the pending_events
> list.
> 
> What do you think?

Sure, it is easy enough to do.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


