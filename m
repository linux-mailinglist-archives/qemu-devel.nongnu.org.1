Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A2704857
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:58:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqVc-0000D9-7N; Tue, 16 May 2023 04:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyqVY-00009d-7U
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyqVU-0005Gm-35
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684227487;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1rtqFgAj/KuRcMH6GzTwTJmpKTJlQbeyLmHTKp8K/E=;
 b=BM7how9Qmn7bZIZgcCdjcUsgrYHFx+qZwe2xe9UQNLkVC0Dfa9LP5XH4RRY1f3wRVA+yfL
 ilgcLb35EPQzw88k4CzmyLVqnxTuf7DWyWbqYiUtpeRPJDcYSo1Sx+DwDzECpVzrHSi2go
 Exue3Jo8vEpxpqd9PNpoJuy5Sqv4emE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-cM9jAQZdPwqM0sR51WVUKA-1; Tue, 16 May 2023 04:58:03 -0400
X-MC-Unique: cM9jAQZdPwqM0sR51WVUKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65DFF282380B;
 Tue, 16 May 2023 08:58:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB6863ABB;
 Tue, 16 May 2023 08:58:00 +0000 (UTC)
Date: Tue, 16 May 2023 09:57:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v4 6/8] migration: modified 'migrate' QAPI to accept
 'channels' argument for migration
Message-ID: <ZGNFlsLsIE/68+NS@redhat.com>
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-7-het.gala@nutanix.com>
 <ZGILNQxb6VD0CwSR@redhat.com>
 <04881f8e-f903-9886-a39f-141605d634a5@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04881f8e-f903-9886-a39f-141605d634a5@nutanix.com>
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

On Tue, May 16, 2023 at 11:18:16AM +0530, Het Gala wrote:
> 
> On 15/05/23 4:06 pm, Daniel P. Berrangé wrote:
> > On Fri, May 12, 2023 at 02:32:38PM +0000, Het Gala wrote:
> > > MigrateChannelList ideally allows to connect accross multiple interfaces.
> > > 
> > > Added MigrateChannelList struct as argument to 'migrate' qapi. Introduced
> > > MigrateChannelList in hmp_migrate() and qmp_migrate() functions.
> > > 
> > > Future patchset series plans to include multiple MigrateChannels
> > > for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
> > > is the preferred choice of argument over 'MigrateChannel' and making 'migrate'
> > > QAPI future proof.
> > > 
> > > For current patch, have just limit size of MigrateChannelList to 1 element as
> > > a runtime check.
> > > 
> > > Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> > > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > > ---
> > >   migration/migration-hmp-cmds.c | 113 ++++++++++++++++++++++++++++++++-
> > >   migration/migration.c          |  17 ++++-
> > >   qapi/migration.json            |  69 +++++++++++++++++++-
> > >   3 files changed, 192 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > > index 4e9f00e7dc..f098d04542 100644
> > > --- a/migration/migration-hmp-cmds.c
> > > +++ b/migration/migration-hmp-cmds.c
> > > @@ -51,6 +51,101 @@ static void migration_global_dump(Monitor *mon)
> > >                      ms->clear_bitmap_shift);
> > >   }
> > > +static bool
> > > +migrate_channel_from_qdict(MigrateChannel **channel,
> > > +                           const QDict *qdict, Error **errp)
> > > +{
> > > +    Error *err = NULL;
> > > +    const char *channeltype  = qdict_get_try_str(qdict, "channeltype");
> > > +    const char *transport_str = qdict_get_try_str(qdict, "transport");
> > > +    const char *socketaddr_type = qdict_get_try_str(qdict, "type");
> > > +    const char *inet_host = qdict_get_try_str(qdict, "host");
> > > +    const char *inet_port = qdict_get_try_str(qdict, "port");
> > > +    const char *unix_path = qdict_get_try_str(qdict, "path");
> > > +    const char *vsock_cid = qdict_get_try_str(qdict, "cid");
> > > +    const char *vsock_port = qdict_get_try_str(qdict, "port");
> > > +    const char *fd = qdict_get_try_str(qdict, "str");
> > > +    QList *exec = qdict_get_qlist(qdict, "exec");
> > THis seems to be implicitly defining a huge set of extra parameters
> > for the migrate 'HMP' command, but none of it is actually defined
> > at the hmp-commands.hx
> I don't have a lot of knowledge on HMP commands. I had code changes here in
> HMP merely to to keep it compatible with QMP command as it used to call
> qmp_migrate() function.
> > Do we even need todo this ?  For HMP it is not unreasonable to just
> > keep using the URI syntax forever?
> 
> Daniel, I didn't completely understand your ask here. Are you implying that
> for the HMP wrapper on top of QMP, we should pass it as a string only to
> qmp_migrate() function ?

Yeah, that's my thought. HMP is targetted at humans and aims for
user friendliness, and does not need to have 100% parity with QMP.
For the multi-channel setup, I think that's going to be something
only mgmt apps do, unlikely humans using HMP need this.

> 
> In that case, we won't be needing migrate_channel_from_qdict() function at
> all right ? Please guide.

Yeah, I think it is redundant.

An earlier patch already added an API to convert a "char *uri" into a
MigrateChannel object. So we can keep HMP using a URI, but pass it to
QMP using the MigrateChannel struct.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


