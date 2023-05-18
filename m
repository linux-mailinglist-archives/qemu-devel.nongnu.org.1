Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB770814A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:30:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcla-0002hp-Dg; Thu, 18 May 2023 08:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzclY-0002hg-4j
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzclW-0003lX-Ia
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684412993;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X7Q9GoTeyFkQRXjb3dCo7FKCBS8VJLRFSSvobb6LBXE=;
 b=dCK3q5Z3Egm5QYoz3478/MvHa94DUiU9s5gAGVcvMlMjbs+wotszEkE0urvMSYjT57BWh3
 bAK5XQN7lonK4nSVlv1ZJZ/pjPOf1lgttFpm7s39J/oiHpSzV+sxj6dwt4DFKWBmaaseHF
 8CAryGtRm91egfBA5jVYV/4zA9aE0Z8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-rpisL_VuP0WxtkaGdQwRow-1; Thu, 18 May 2023 08:29:50 -0400
X-MC-Unique: rpisL_VuP0WxtkaGdQwRow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D403C0F180;
 Thu, 18 May 2023 12:29:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF36C14171C0;
 Thu, 18 May 2023 12:29:48 +0000 (UTC)
Date: Thu, 18 May 2023 13:29:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
Message-ID: <ZGYaOu3F3hsiPj5N@redhat.com>
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <DS0PR11MB6373D659BCA67BD75D8ECC5DDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373D659BCA67BD75D8ECC5DDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 18, 2023 at 09:13:58AM +0000, Wang, Wei W wrote:
> On Thursday, May 18, 2023 4:52 PM, Wang, Lei4 wrote:
> > When destination VM is launched, the "backlog" parameter for listen() is set
> > to 1 as default in socket_start_incoming_migration_internal(), which will
> > lead to socket connection error (the queue of pending connections is full)
> > when "multifd" and "multifd-channels" are set later on and a high number of
> > channels are used. Set it to a hard-coded higher default value 512 to fix this
> > issue.
> > 
> > Reported-by: Wei Wang <wei.w.wang@intel.com>
> > Signed-off-by: Lei Wang <lei4.wang@intel.com>
> > ---
> >  migration/socket.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/migration/socket.c b/migration/socket.c index
> > 1b6f5baefb..b43a66ef7e 100644
> > --- a/migration/socket.c
> > +++ b/migration/socket.c
> > @@ -179,7 +179,7 @@
> > socket_start_incoming_migration_internal(SocketAddress *saddr,
> >      QIONetListener *listener = qio_net_listener_new();
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> >      size_t i;
> > -    int num = 1;
> > +    int num = 512;
> > 
> 
> Probably we need a macro for it, e.g.
> #define MIGRATION_CHANNEL_MAX  512
> 
> Also, I think below lines could be removed, as using a larger value of num (i.e. 512)
> doesn't seem to consume more resources anywhere:
> -    if (migrate_use_multifd()) {
> -        num = migrate_multifd_channels();
> -    } else if (migrate_postcopy_preempt()) {
> -        num = RAM_CHANNEL_MAX;
> -    }

Given that this code already exists, why is it not already sufficient ?

The commit description is saying we're setting backlog == 1 wit
multifd, but this later code is setting it to match the multfd
channels.  Why isn't that enough ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


