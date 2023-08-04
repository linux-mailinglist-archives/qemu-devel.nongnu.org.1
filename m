Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DCE770640
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 18:47:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRxwf-0000pH-Kj; Fri, 04 Aug 2023 12:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRxwZ-0000oz-23
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRxwW-00022y-Dy
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691167583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5uF9RV3tgerh1IiCs5M+i/JpsH6sclkZBRoHieGJ2c=;
 b=GLVJXu9FfPlmL857PHqMuySmykqAb5fn0nzFapxTSRShEbVMJlUaKhxWXLO2ZLHxObey0R
 /zwxrAVFAE0vPs3sWj7ZYjwE75wLM/VILGOCOQhoJ8ZKxsAfLkaFrYJLhoOEqPrbkzNoNb
 soLNkC86NM3hQw4dnlJofNLAX9hkUEA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-2DoJr5LpOXWI4t5TolOPgw-1; Fri, 04 Aug 2023 12:46:21 -0400
X-MC-Unique: 2DoJr5LpOXWI4t5TolOPgw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63d2b88325bso4679626d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 09:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691167581; x=1691772381;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K5uF9RV3tgerh1IiCs5M+i/JpsH6sclkZBRoHieGJ2c=;
 b=lE6L+5SiynwASF1srVmkuGaghnx7IjoRTUkeywe+WWE3oNhsCikJMAQxIjFFO4dKHf
 YZRyaywmkhUgSAzi8xLA3RmN8b2T04gEmWRsViOlaG0l03KqRtrxuNLC696Xgk75SGau
 wK1vvmrkZkH8NE9QGJ7Nt//B8752mm97GWr0qcahTAF3g95QP/s+7FHD+3JDu56YXBqP
 Zg0V9ALIaYKQ+RTEgf0/TjJwZSRSwl3U5JMRQKKum48KJ8FyIx+lKiRdbtGJmMVu/s6h
 IN9EWvvtmOjp284IUkRWTp59FJeED+HdzBV9SpQQdTMIHZj3qJA2VG8czHxX++Jeh3mX
 79DQ==
X-Gm-Message-State: ABy/qLZPe5beqTwQ/qDkAKoWev3UommfK1wrDfGNzV3a7MI5rMrqxqj6
 iosY+mVGTPcfoYyGhCkXvfP9Pp8byO6NSeHbSWaSQ3m+9oilYxspOGaZSjcEid6VMeIkc/P1w9I
 XFCvTEUO1Z9/CnkY=
X-Received: by 2002:a05:6214:c8d:b0:63c:7427:e7e9 with SMTP id
 r13-20020a0562140c8d00b0063c7427e7e9mr23685563qvr.6.1691167581228; 
 Fri, 04 Aug 2023 09:46:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHz8OsV6gq7vLKfn4BfR2491o/U2akcQYTYMSEjWddi3NUEfjN2KzoQU3dWHqeVE20YGOnyPQ==
X-Received: by 2002:a05:6214:c8d:b0:63c:7427:e7e9 with SMTP id
 r13-20020a0562140c8d00b0063c7427e7e9mr23685549qvr.6.1691167580927; 
 Fri, 04 Aug 2023 09:46:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cc984000000b00637615a1f33sm783913qvk.20.2023.08.04.09.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 09:46:20 -0700 (PDT)
Date: Fri, 4 Aug 2023 12:46:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Zhiyi Guo <zhguo@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
Message-ID: <ZM0rWiHF8voqOdyp@x1n>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
 <ZM0g8iNXzv9LRo+w@x1n> <ZM0nX8qt1T3aZgNK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM0nX8qt1T3aZgNK@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 04, 2023 at 05:29:19PM +0100, Daniel P. Berrangé wrote:
> On Fri, Aug 04, 2023 at 12:01:54PM -0400, Peter Xu wrote:
> > On Fri, Aug 04, 2023 at 02:59:07PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Aug 04, 2023 at 02:28:05PM +0200, Markus Armbruster wrote:
> > > > Peter Xu <peterx@redhat.com> writes:
> > > > 
> > > > > We used to have three objects that have always the same list of parameters
> > > > 
> > > > We have!
> > > > 
> > > > > and comments are always duplicated:
> > > > >
> > > > >   - @MigrationParameter
> > > > >   - @MigrationParameters
> > > > >   - @MigrateSetParameters
> > > > >
> > > > > Before we can deduplicate the code, it's fairly straightforward to
> > > > > deduplicate the comments first, so for each time we add a new migration
> > > > > parameter we don't need to copy the same paragraphs three times.
> > > > 
> > > > De-duplicating the code would be nice, but we haven't done so in years,
> > > > which suggests it's hard enough not to be worth the trouble.
> > > 
> > > The "MigrationParameter" enumeration isn't actually used in
> > > QMP at all.
> > > 
> > > It is only used in HMP for hmp_migrate_set_parameter and
> > > hmp_info_migrate_parameters. So it is questionable documenting
> > > that enum in the QMP reference docs at all.
> > > 
> > > 1c1
> > > < { 'struct': 'MigrationParameters',
> > > ---
> > > > { 'struct': 'MigrateSetParameters',
> > > 14,16c14,16
> > > <             '*tls-creds': 'str',
> > > <             '*tls-hostname': 'str',
> > > <             '*tls-authz': 'str',
> > > ---
> > > >             '*tls-creds': 'StrOrNull',
> > > >             '*tls-hostname': 'StrOrNull',
> > > >             '*tls-authz': 'StrOrNull',
> > > 
> > > Is it not valid to use StrOrNull in both cases and thus
> > > delete the duplication here ?
> > 
> > I tested removing MigrateSetParameters by replacing it with
> > MigrationParameters and it looks all fine here... I manually tested qmp/hmp
> > on set/query parameters, and qtests are all happy.
> 
> I meant the other way around, such we would be using 'StrOrNull'
> in all scenarios.

Yes, that should also work and even without worrying on nulls.  I just took
a random one replacing the other.

> 
> > 
> > The only thing I see that may affect it is we used to logically allow
> > taking things like '"tls-authz": null' in the json input, but now we won't
> > allow that because we'll be asking for a string type only.
> > 
> > Since we have query-qmp-schema I suppose we're all fine, because logically
> > the mgmt app (libvirt?) will still query that to understand the protocol,
> > so now we'll have (response of query-qmp-schema):
> > 
> >         {
> >             "arg-type": "144",
> >             "meta-type": "command",
> >             "name": "migrate-set-parameters",
> >             "ret-type": "0"
> >         },
> > 
> > Where 144 can start to point to MigrationParameters, rather than
> > MigrateSetParameters.
> > 
> > Ok, then what if the mgmt app doesn't care and just used "null" in tls-*
> > fields when setting?  Funnily I tried it and actually anything that does
> > migrate-set-parameters with a "null" passed over to tls-* fields will
> > already crash qemu...
> > 
> > ./migration/options.c:1333: migrate_params_apply: Assertion `params->tls_authz->type == QTYPE_QSTRING' failed.
> > 
> > #0  0x00007f72f4b2a844 in __pthread_kill_implementation () at /lib64/libc.so.6
> > #1  0x00007f72f4ad9abe in raise () at /lib64/libc.so.6
> > #2  0x00007f72f4ac287f in abort () at /lib64/libc.so.6
> > #3  0x00007f72f4ac279b in _nl_load_domain.cold () at /lib64/libc.so.6
> > #4  0x00007f72f4ad2147 in  () at /lib64/libc.so.6
> > #5  0x00005573308740e6 in migrate_params_apply (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1333
> > #6  0x0000557330874591 in qmp_migrate_set_parameters (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1433
> > #7  0x0000557330cb9132 in qmp_marshal_migrate_set_parameters (args=0x7f72e00036d0, ret=0x7f72f133cd98, errp=0x7f72f133cd90) at qapi/qapi-commands-migration.c:214
> > #8  0x0000557330d07fab in do_qmp_dispatch_bh (opaque=0x7f72f133ce30) at ../qapi/qmp-dispatch.c:128
> > #9  0x0000557330d33bbb in aio_bh_call (bh=0x5573337d7920) at ../util/async.c:169
> > #10 0x0000557330d33cd8 in aio_bh_poll (ctx=0x55733356e7d0) at ../util/async.c:216
> > #11 0x0000557330d17a19 in aio_dispatch (ctx=0x55733356e7d0) at ../util/aio-posix.c:423
> > #12 0x0000557330d34117 in aio_ctx_dispatch (source=0x55733356e7d0, callback=0x0, user_data=0x0) at ../util/async.c:358
> > #13 0x00007f72f5a8848c in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> > #14 0x0000557330d358d4 in glib_pollfds_poll () at ../util/main-loop.c:290
> > #15 0x0000557330d35951 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> > #16 0x0000557330d35a5f in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> > #17 0x000055733083aee0 in qemu_main_loop () at ../softmmu/runstate.c:732
> > #18 0x0000557330b0921b in qemu_default_main () at ../softmmu/main.c:37
> > #19 0x0000557330b09251 in main (argc=35, argv=0x7ffc74fd0ec8) at ../softmmu/main.c:48
> > 
> > Then I suppose it means all mgmt apps are not using "null" anyway, and it
> > makes more sense to me to just remove MigrateSetParameters (by replacing it
> > with MigrationParameters).
> 
> It shouldn't be crashing,  because qmp_migrate_set_parameters()
> is turning 'null' into  "", which means the assert ought to
> never fire. Did you have a local modiification that caused
> this crash perhaps ?

I think it just got overlooked when introducing tls-authz to not have added
that special code in qmp_migrate_set_parameters(), the other two are fine.

Thanks,

-- 
Peter Xu


