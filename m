Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52C7B8714
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo68l-0008OP-Km; Wed, 04 Oct 2023 13:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qo68j-0008IX-0Y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qo68h-0002bH-BK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696442306;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TB+aiQuT+PO2eBoKD3ya5CFBCsXjM1rpYv5lWm4oYXs=;
 b=DbKQtNLP8QA/cKrtsz9bxkSzgsbzaPXmjUhvyynPjVM5iINHeeuMaQptGoeSZ83ZptBByC
 c2raW1zQGUV81j+ZzXrsZ2xzlhtWt7nq2N6rVvuxtfdp1zW3ngcmqZGkIgscZ3dI9mNtRr
 tg/87gwqO/7WBSlut37p9y7gX3/69Zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-I5NNNjb0Md2i7POMc6D7pg-1; Wed, 04 Oct 2023 13:58:22 -0400
X-MC-Unique: I5NNNjb0Md2i7POMc6D7pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7721B85A5BE;
 Wed,  4 Oct 2023 17:58:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E2CDC15BB8;
 Wed,  4 Oct 2023 17:58:20 +0000 (UTC)
Date: Wed, 4 Oct 2023 18:58:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Message-ID: <ZR2nuqQ7s1D5BweM@redhat.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-3-het.gala@nutanix.com>
 <87jzs2phxb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzs2phxb.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Wed, Oct 04, 2023 at 11:43:12AM -0300, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
> 
> > This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
> > string containing migration connection related information
> > and stores them inside well defined 'MigrateAddress' struct.
> >
> > Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  migration/exec.c      |  1 -
> >  migration/exec.h      |  4 ++++
> >  migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/exec.c b/migration/exec.c
> > index 2bf882bbe1..32f5143dfd 100644
> > --- a/migration/exec.c
> > +++ b/migration/exec.c
> > @@ -27,7 +27,6 @@
> >  #include "qemu/cutils.h"
> >  
> >  #ifdef WIN32
> > -const char *exec_get_cmd_path(void);
> >  const char *exec_get_cmd_path(void)
> >  {
> >      g_autofree char *detected_path = g_new(char, MAX_PATH);
> > diff --git a/migration/exec.h b/migration/exec.h
> > index b210ffde7a..736cd71028 100644
> > --- a/migration/exec.h
> > +++ b/migration/exec.h
> > @@ -19,6 +19,10 @@
> >  
> >  #ifndef QEMU_MIGRATION_EXEC_H
> >  #define QEMU_MIGRATION_EXEC_H
> > +
> > +#ifdef WIN32
> > +const char *exec_get_cmd_path(void);
> > +#endif
> >  void exec_start_incoming_migration(const char *host_port, Error **errp);
> >  
> >  void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 6d3cf5d5cd..dcbd509d56 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -65,6 +65,7 @@
> >  #include "sysemu/qtest.h"
> >  #include "options.h"
> >  #include "sysemu/dirtylimit.h"
> > +#include "qemu/sockets.h"
> >  
> >  static NotifierList migration_state_notifiers =
> >      NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
> > @@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
> >                        QAPI_CLONE(SocketAddress, address));
> >  }
> >  
> > +static bool migrate_uri_parse(const char *uri,
> > +                              MigrationAddress **channel,
> > +                              Error **errp)
> > +{
> > +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> 
> This cannot be g_autoptr because you're passing it out of scope at the
> end of the function.

It is still good to use g_autoptr to deal with the error paths.

On the success path though you need   g_steal_pointer(&addr) to
prevent the autofree cleanup running.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


