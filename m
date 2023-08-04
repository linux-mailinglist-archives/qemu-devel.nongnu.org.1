Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F77770600
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 18:30:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRxgF-00085x-JK; Fri, 04 Aug 2023 12:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRxgB-00085X-Os
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRxg8-00030a-2H
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691166565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZG9+wDU/4Rm13LidjCGyOklrZxjx2OsxRuQEZbWWq0A=;
 b=d9/QgBJe2fNYZrOrqn2FTUfmCVcyYkm/9Lt2eFxUrxqzxkPexGidbOI2RRacN2HV50pcKS
 Q9j3Plo1CI0y+ERAbvT/7ksK+l+3uuWpBvCXedBuC5aLaUH2gRAiQuBu7OB2Hv+31xLGGQ
 VOo6Al1wNi9+OVJ95OrxcYlLwuw2llY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-Fhv7k4SsP_meXTXKUxOV6A-1; Fri, 04 Aug 2023 12:29:23 -0400
X-MC-Unique: Fhv7k4SsP_meXTXKUxOV6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ACAD86F12C;
 Fri,  4 Aug 2023 16:29:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4211207B34D;
 Fri,  4 Aug 2023 16:29:21 +0000 (UTC)
Date: Fri, 4 Aug 2023 17:29:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Zhiyi Guo <zhguo@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
Message-ID: <ZM0nX8qt1T3aZgNK@redhat.com>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
 <ZM0g8iNXzv9LRo+w@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM0g8iNXzv9LRo+w@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On Fri, Aug 04, 2023 at 12:01:54PM -0400, Peter Xu wrote:
> On Fri, Aug 04, 2023 at 02:59:07PM +0100, Daniel P. Berrangé wrote:
> > On Fri, Aug 04, 2023 at 02:28:05PM +0200, Markus Armbruster wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > We used to have three objects that have always the same list of parameters
> > > 
> > > We have!
> > > 
> > > > and comments are always duplicated:
> > > >
> > > >   - @MigrationParameter
> > > >   - @MigrationParameters
> > > >   - @MigrateSetParameters
> > > >
> > > > Before we can deduplicate the code, it's fairly straightforward to
> > > > deduplicate the comments first, so for each time we add a new migration
> > > > parameter we don't need to copy the same paragraphs three times.
> > > 
> > > De-duplicating the code would be nice, but we haven't done so in years,
> > > which suggests it's hard enough not to be worth the trouble.
> > 
> > The "MigrationParameter" enumeration isn't actually used in
> > QMP at all.
> > 
> > It is only used in HMP for hmp_migrate_set_parameter and
> > hmp_info_migrate_parameters. So it is questionable documenting
> > that enum in the QMP reference docs at all.
> > 
> > 1c1
> > < { 'struct': 'MigrationParameters',
> > ---
> > > { 'struct': 'MigrateSetParameters',
> > 14,16c14,16
> > <             '*tls-creds': 'str',
> > <             '*tls-hostname': 'str',
> > <             '*tls-authz': 'str',
> > ---
> > >             '*tls-creds': 'StrOrNull',
> > >             '*tls-hostname': 'StrOrNull',
> > >             '*tls-authz': 'StrOrNull',
> > 
> > Is it not valid to use StrOrNull in both cases and thus
> > delete the duplication here ?
> 
> I tested removing MigrateSetParameters by replacing it with
> MigrationParameters and it looks all fine here... I manually tested qmp/hmp
> on set/query parameters, and qtests are all happy.

I meant the other way around, such we would be using 'StrOrNull'
in all scenarios.

> 
> The only thing I see that may affect it is we used to logically allow
> taking things like '"tls-authz": null' in the json input, but now we won't
> allow that because we'll be asking for a string type only.
> 
> Since we have query-qmp-schema I suppose we're all fine, because logically
> the mgmt app (libvirt?) will still query that to understand the protocol,
> so now we'll have (response of query-qmp-schema):
> 
>         {
>             "arg-type": "144",
>             "meta-type": "command",
>             "name": "migrate-set-parameters",
>             "ret-type": "0"
>         },
> 
> Where 144 can start to point to MigrationParameters, rather than
> MigrateSetParameters.
> 
> Ok, then what if the mgmt app doesn't care and just used "null" in tls-*
> fields when setting?  Funnily I tried it and actually anything that does
> migrate-set-parameters with a "null" passed over to tls-* fields will
> already crash qemu...
> 
> ./migration/options.c:1333: migrate_params_apply: Assertion `params->tls_authz->type == QTYPE_QSTRING' failed.
> 
> #0  0x00007f72f4b2a844 in __pthread_kill_implementation () at /lib64/libc.so.6
> #1  0x00007f72f4ad9abe in raise () at /lib64/libc.so.6
> #2  0x00007f72f4ac287f in abort () at /lib64/libc.so.6
> #3  0x00007f72f4ac279b in _nl_load_domain.cold () at /lib64/libc.so.6
> #4  0x00007f72f4ad2147 in  () at /lib64/libc.so.6
> #5  0x00005573308740e6 in migrate_params_apply (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1333
> #6  0x0000557330874591 in qmp_migrate_set_parameters (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1433
> #7  0x0000557330cb9132 in qmp_marshal_migrate_set_parameters (args=0x7f72e00036d0, ret=0x7f72f133cd98, errp=0x7f72f133cd90) at qapi/qapi-commands-migration.c:214
> #8  0x0000557330d07fab in do_qmp_dispatch_bh (opaque=0x7f72f133ce30) at ../qapi/qmp-dispatch.c:128
> #9  0x0000557330d33bbb in aio_bh_call (bh=0x5573337d7920) at ../util/async.c:169
> #10 0x0000557330d33cd8 in aio_bh_poll (ctx=0x55733356e7d0) at ../util/async.c:216
> #11 0x0000557330d17a19 in aio_dispatch (ctx=0x55733356e7d0) at ../util/aio-posix.c:423
> #12 0x0000557330d34117 in aio_ctx_dispatch (source=0x55733356e7d0, callback=0x0, user_data=0x0) at ../util/async.c:358
> #13 0x00007f72f5a8848c in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> #14 0x0000557330d358d4 in glib_pollfds_poll () at ../util/main-loop.c:290
> #15 0x0000557330d35951 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> #16 0x0000557330d35a5f in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> #17 0x000055733083aee0 in qemu_main_loop () at ../softmmu/runstate.c:732
> #18 0x0000557330b0921b in qemu_default_main () at ../softmmu/main.c:37
> #19 0x0000557330b09251 in main (argc=35, argv=0x7ffc74fd0ec8) at ../softmmu/main.c:48
> 
> Then I suppose it means all mgmt apps are not using "null" anyway, and it
> makes more sense to me to just remove MigrateSetParameters (by replacing it
> with MigrationParameters).

It shouldn't be crashing,  because qmp_migrate_set_parameters()
is turning 'null' into  "", which means the assert ought to
never fire. Did you have a local modiification that caused
this crash perhaps ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


