Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF617715F9
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 17:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSg0z-0006ZW-OX; Sun, 06 Aug 2023 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qSg0x-0006Z8-6X
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 11:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qSg0u-0001d8-TP
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 11:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691336991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKXD2+mT9Sz3oJE472UpZI0H5jNCJ7zK8UDeJlASWGc=;
 b=Rw45AaJ41Id31zxw7ddcEKGA5cTL9hMSPavj0o0nw5P4At9oDy+WgeF3UgupLti0J7/A/A
 kPHKOgKz/nMQt/H8VJjZTvr60xBJDDtLkdUvkvehq2HLmzMFnr0pQD3eaaGTXNR/ers4rY
 2VDZDUFBGVWpoHitOgSu1Qrzf+f7Wik=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-uF4o4k-HNBWHg0mpfntUQg-1; Sun, 06 Aug 2023 11:49:49 -0400
X-MC-Unique: uF4o4k-HNBWHg0mpfntUQg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-40fd6d83c21so9584661cf.1
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 08:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691336989; x=1691941789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oKXD2+mT9Sz3oJE472UpZI0H5jNCJ7zK8UDeJlASWGc=;
 b=Z3W4Ns1DnTnWpK0Ml67x61X9ILlVexzFKJ/WY82rL/gK1LuUErbw1yfx3h/Cf4zvLe
 IWbvkOywrp3Dwh+vMSrLEByja7BDcLnrYtgzuA6AIiQ68/UpgBI6iNz/YhlGC7hiRyi/
 3bhSUosNGlrm7i/IPIUA3Pl1RBNd8vhMJ8Zv+4T6FsA+2wFvm31xIxxf8FU9oYskRrdc
 /avLSEw1JHWzsl15RW6P3pEaEBbmSYu5dy9IiwvDZy/2oWuwa+PhCR3kouSpvOpHJdAZ
 HmTtSMm28EUpLeBVyVnmIEE2HDRgu3fp1ANmBbh4ZC7Mz/cAjPYpYM08TOlVnczwB57C
 R82A==
X-Gm-Message-State: ABy/qLbb2012Fh7XI1C0wvpE7GKrArQLhgTMG6DHWjD6acLk6sp/4koW
 TvY8T9v1tbIS0mSgPvbwbvU+CeDZEbRLUzUfVeIiUVtiZ4TJ1T5wh7ABvjEx4dy8s6tyUhSbr7T
 18iU5b+eQuiRDDYE=
X-Received: by 2002:a05:622a:1a1b:b0:40f:dcda:ea10 with SMTP id
 f27-20020a05622a1a1b00b0040fdcdaea10mr18322890qtb.3.1691336988978; 
 Sun, 06 Aug 2023 08:49:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqVYIeWDDYuOc66SsD+AIkhz8mEsW2oYL6AHPRfYYYnpYxzV2sLcraDzGcwAuGr003NChO3g==
X-Received: by 2002:a05:622a:1a1b:b0:40f:dcda:ea10 with SMTP id
 f27-20020a05622a1a1b00b0040fdcdaea10mr18322866qtb.3.1691336988597; 
 Sun, 06 Aug 2023 08:49:48 -0700 (PDT)
Received: from xz-m1.local
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 iy3-20020a05622a700300b004069782c943sm2026503qtb.40.2023.08.06.08.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Aug 2023 08:49:48 -0700 (PDT)
Date: Sun, 6 Aug 2023 11:49:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Zhiyi Guo <zhguo@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
Message-ID: <ZM/BGoSiDutVUoTF@xz-m1.local>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
 <ZM0g8iNXzv9LRo+w@x1n> <ZM0nX8qt1T3aZgNK@redhat.com>
 <ZM0rWiHF8voqOdyp@x1n> <ZM0r8VoF8w5vGw7p@redhat.com>
 <ZM1nXbjxWx9jvbjz@x1n> <87zg35x60f.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg35x60f.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Aug 05, 2023 at 10:12:00AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Aug 04, 2023 at 05:48:49PM +0100, Daniel P. Berrangé wrote:
> >> On Fri, Aug 04, 2023 at 12:46:18PM -0400, Peter Xu wrote:
> >> > On Fri, Aug 04, 2023 at 05:29:19PM +0100, Daniel P. Berrangé wrote:
> >> > > On Fri, Aug 04, 2023 at 12:01:54PM -0400, Peter Xu wrote:
> >> > > > On Fri, Aug 04, 2023 at 02:59:07PM +0100, Daniel P. Berrangé wrote:
> >> > > > > On Fri, Aug 04, 2023 at 02:28:05PM +0200, Markus Armbruster wrote:
> >> > > > > > Peter Xu <peterx@redhat.com> writes:
> >> > > > > > 
> >> > > > > > > We used to have three objects that have always the same list of parameters
> >> > > > > > 
> >> > > > > > We have!
> >> > > > > > 
> >> > > > > > > and comments are always duplicated:
> >> > > > > > >
> >> > > > > > >   - @MigrationParameter
> >> > > > > > >   - @MigrationParameters
> >> > > > > > >   - @MigrateSetParameters
> >> > > > > > >
> >> > > > > > > Before we can deduplicate the code, it's fairly straightforward to
> >> > > > > > > deduplicate the comments first, so for each time we add a new migration
> >> > > > > > > parameter we don't need to copy the same paragraphs three times.
> >> > > > > > 
> >> > > > > > De-duplicating the code would be nice, but we haven't done so in years,
> >> > > > > > which suggests it's hard enough not to be worth the trouble.
> >> > > > > 
> >> > > > > The "MigrationParameter" enumeration isn't actually used in
> >> > > > > QMP at all.
> >> > > > > 
> >> > > > > It is only used in HMP for hmp_migrate_set_parameter and
> >> > > > > hmp_info_migrate_parameters. So it is questionable documenting
> >> > > > > that enum in the QMP reference docs at all.
> >> > > > > 
> >> > > > > 1c1
> >> > > > > < { 'struct': 'MigrationParameters',
> >> > > > > ---
> >> > > > > > { 'struct': 'MigrateSetParameters',
> >> > > > > 14,16c14,16
> >> > > > > <             '*tls-creds': 'str',
> >> > > > > <             '*tls-hostname': 'str',
> >> > > > > <             '*tls-authz': 'str',
> >> > > > > ---
> >> > > > > >             '*tls-creds': 'StrOrNull',
> >> > > > > >             '*tls-hostname': 'StrOrNull',
> >> > > > > >             '*tls-authz': 'StrOrNull',
> >> > > > > 
> >> > > > > Is it not valid to use StrOrNull in both cases and thus
> >> > > > > delete the duplication here ?
> >> > > > 
> >> > > > I tested removing MigrateSetParameters by replacing it with
> >> > > > MigrationParameters and it looks all fine here... I manually tested qmp/hmp
> >> > > > on set/query parameters, and qtests are all happy.
> >> > > 
> >> > > I meant the other way around, such we would be using 'StrOrNull'
> >> > > in all scenarios.
> >> > 
> >> > Yes, that should also work and even without worrying on nulls.  I just took
> >> > a random one replacing the other.
> >> > 
> >> > > 
> >> > > > 
> >> > > > The only thing I see that may affect it is we used to logically allow
> >> > > > taking things like '"tls-authz": null' in the json input, but now we won't
> >> > > > allow that because we'll be asking for a string type only.
> >> > > > 
> >> > > > Since we have query-qmp-schema I suppose we're all fine, because logically
> >> > > > the mgmt app (libvirt?) will still query that to understand the protocol,
> >> > > > so now we'll have (response of query-qmp-schema):
> >> > > > 
> >> > > >         {
> >> > > >             "arg-type": "144",
> >> > > >             "meta-type": "command",
> >> > > >             "name": "migrate-set-parameters",
> >> > > >             "ret-type": "0"
> >> > > >         },
> >> > > > 
> >> > > > Where 144 can start to point to MigrationParameters, rather than
> >> > > > MigrateSetParameters.
> >> > > > 
> >> > > > Ok, then what if the mgmt app doesn't care and just used "null" in tls-*
> >> > > > fields when setting?  Funnily I tried it and actually anything that does
> >> > > > migrate-set-parameters with a "null" passed over to tls-* fields will
> >> > > > already crash qemu...
> >> > > > 
> >> > > > ./migration/options.c:1333: migrate_params_apply: Assertion `params->tls_authz->type == QTYPE_QSTRING' failed.
> >> > > > 
> >> > > > #0  0x00007f72f4b2a844 in __pthread_kill_implementation () at /lib64/libc.so.6
> >> > > > #1  0x00007f72f4ad9abe in raise () at /lib64/libc.so.6
> >> > > > #2  0x00007f72f4ac287f in abort () at /lib64/libc.so.6
> >> > > > #3  0x00007f72f4ac279b in _nl_load_domain.cold () at /lib64/libc.so.6
> >> > > > #4  0x00007f72f4ad2147 in  () at /lib64/libc.so.6
> >> > > > #5  0x00005573308740e6 in migrate_params_apply (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1333
> >> > > > #6  0x0000557330874591 in qmp_migrate_set_parameters (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1433
> >> > > > #7  0x0000557330cb9132 in qmp_marshal_migrate_set_parameters (args=0x7f72e00036d0, ret=0x7f72f133cd98, errp=0x7f72f133cd90) at qapi/qapi-commands-migration.c:214
> >> > > > #8  0x0000557330d07fab in do_qmp_dispatch_bh (opaque=0x7f72f133ce30) at ../qapi/qmp-dispatch.c:128
> >> > > > #9  0x0000557330d33bbb in aio_bh_call (bh=0x5573337d7920) at ../util/async.c:169
> >> > > > #10 0x0000557330d33cd8 in aio_bh_poll (ctx=0x55733356e7d0) at ../util/async.c:216
> >> > > > #11 0x0000557330d17a19 in aio_dispatch (ctx=0x55733356e7d0) at ../util/aio-posix.c:423
> >> > > > #12 0x0000557330d34117 in aio_ctx_dispatch (source=0x55733356e7d0, callback=0x0, user_data=0x0) at ../util/async.c:358
> >> > > > #13 0x00007f72f5a8848c in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> >> > > > #14 0x0000557330d358d4 in glib_pollfds_poll () at ../util/main-loop.c:290
> >> > > > #15 0x0000557330d35951 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> >> > > > #16 0x0000557330d35a5f in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> >> > > > #17 0x000055733083aee0 in qemu_main_loop () at ../softmmu/runstate.c:732
> >> > > > #18 0x0000557330b0921b in qemu_default_main () at ../softmmu/main.c:37
> >> > > > #19 0x0000557330b09251 in main (argc=35, argv=0x7ffc74fd0ec8) at ../softmmu/main.c:48
> >> > > > 
> >> > > > Then I suppose it means all mgmt apps are not using "null" anyway, and it
> >> > > > makes more sense to me to just remove MigrateSetParameters (by replacing it
> >> > > > with MigrationParameters).
> >> > > 
> >> > > It shouldn't be crashing,  because qmp_migrate_set_parameters()
> >> > > is turning 'null' into  "", which means the assert ought to
> >> > > never fire. Did you have a local modiification that caused
> >> > > this crash perhaps ?
> >> > 
> >> > I think it just got overlooked when introducing tls-authz to not have added
> >> > that special code in qmp_migrate_set_parameters(), the other two are fine.
> >> 
> >> Oh right yes, pre-existing bug.
> >
> > So do we really care about "null" in any form over "" (empty str) here for
> > tls-* parameters?
> 
> In my opinion, the use of "" was a design mistake.  Here's my argument:
> 
> commit 01fa55982692fb51a16049b63b571651a1053989
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Tue Jul 18 14:42:04 2017 +0200
> 
>     migration: Use JSON null instead of "" to reset parameter to default
>     
>     migrate-set-parameters sets migration parameters according to is
>     arguments like this:
>     
>     * Present means "set the parameter to this value"
>     
>     * Absent means "leave the parameter unchanged"
>     
>     * Except for parameters tls_creds and tls_hostname, "" means "reset
>       the parameter to its default value
>     
>     The first two are perfectly normal: presence of the parameter makes
>     the command do something.
>     
>     The third one overloads the parameter with a second meaning.  The
>     overloading is *implicit*, i.e. it's not visible in the types.  Works
>     here, because "" is neither a valid TLS credentials ID, nor a valid
>     host name.
>     
>     Pressing argument values the schema accepts, but are semantically
>     invalid, into service to mean "reset to default" is not general, as
>     suitable invalid values need not exist.  I also find it ugly.
>     
>     To clean this up, we could add a separate flag argument to ask for
>     "reset to default", or add a distinct value to @tls_creds and
>     @tls_hostname.  This commit implements the latter: add JSON null to
>     the values of @tls_creds and @tls_hostname, deprecate "".
>     
>     Because we're so close to the 2.10 freeze, implement it in the
>     stupidest way possible: have qmp_migrate_set_parameters() rewrite null
>     to "" before anything else can see the null.  The proper way to do it
>     would be rewriting "" to null, but that requires fixing up code to
>     work with null.  Add TODO comments for that.
>     
>     Signed-off-by: Markus Armbruster <armbru@redhat.com>
>     Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>     Reviewed-by: Eric Blake <eblake@redhat.com>

I see.  Personally I think as long as the interface is 100% clear I'll be
all fine (say, no possible misuse of "").  But keeping StrOrNull may
definitely be cleaner I guess.

> 
> > To fix this tls-authz bug we can add one more QTYPE_QNULL to QTYPE_QSTRING
> > convertion, but I'd rather just use "str" for all tls* fields and remove
> > the other two instead, if "null" is not important to anyone.
> 
> "Important" sounds too much like absolutes :)
> 
> I think we have a tradeoff here.  If perpetuating the unclean and ugly
> use of "" is what it takes to de-triplicate migration parameters, we may
> decide to accept that.

I don't think it's a must.  As Dan raised, we can convert str -> StrOrNull
for MigrationParameters. I assume it won't affect query-migrate-parameters
anyway OTOH.

I assume it means there's nothing yet obvious that we overlooked on the
whole idea.  Let me propose the formal patchset early next week.  It'll be
mostly the patch I attached but just add those extra logics for StrOrNull,
so the diffstat might be less attractive but hopefully still good enough to
be accepted.

Thanks,

-- 
Peter Xu


