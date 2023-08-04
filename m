Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF2770A55
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS1wc-0001YK-NL; Fri, 04 Aug 2023 17:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qS1wb-0001YB-AI
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qS1wW-0003ny-PE
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691182959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ky23xE0vVpWtHgxOqdgfPbv1m6O94/0dOPbDnEe4J8=;
 b=GtFUf++eWyFK7tqSVp2GTbwS+W1nV9J7w2bLlhbNWHBljLrYNVTAYSGjEWMSUB2FwYKFau
 3et2uu4JCUEDgcSO0W40zG+n+MYh1bjmzN7A+EUOBe8tCdlt0dUwKpho9rZaXWjoziJReM
 duQzky0Rzav2NrmU/SX8JPHirAC7G68=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-lv9aWbWFM9WqcCYKADEPZQ-1; Fri, 04 Aug 2023 17:02:37 -0400
X-MC-Unique: lv9aWbWFM9WqcCYKADEPZQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3a70500dc39so449231b6e.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691182956; x=1691787756;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ky23xE0vVpWtHgxOqdgfPbv1m6O94/0dOPbDnEe4J8=;
 b=fxdsy7R4hOcBYB/U1lQtCVl+yBTWLISQ4NV9SrUs4AYlJpSlhdHLPHLtOgC42Y1hzD
 JtE3svIocmStAxdmj/lF2cd1VRC7kpMpBdaTNRJpIfXvWZdsM18aP4EWLUkOFrPRCZSO
 0wkOUFrF3G1GYihayi/88aQ/V/XS+GgnZgJA5/5UP4jQC65lGy4XY8Xte7DouOUYRIji
 RvXsd1AsSIj+exsxeifi3Qlqx/dUDzS2ra68Fj5wlzFBk1BnrWPHi+MSJHGMH+EkB+zT
 1R/aPPp3kVVf0dbzHsG0Xu8zQRCiEBIIiHEBj6Hl3PkADMXQFaz3/Rcxj5EXEu2ggwps
 bA4Q==
X-Gm-Message-State: ABy/qLap9BkjtV0Pm0VvkLhACui9Z55a1061UrXS4FYtDo9nokdBR86C
 nJwkteUsUzyBuSxSeKewmF6LvV11pm7HOtJUEtjfW49QeCCbbhjFpI9pc1VbDBAKx6PIb5nFPnb
 s+EYp9yTgnSBEdUw=
X-Received: by 2002:a05:6358:cb1c:b0:135:24ed:510b with SMTP id
 gr28-20020a056358cb1c00b0013524ed510bmr9090878rwb.3.1691182956431; 
 Fri, 04 Aug 2023 14:02:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGGnIh/cNIgA2CVV5N7efUlnQ1ckXxRFHHTe9zJyTxs1t5fnmAF9FVnUBpK1q6Xo+wC8mnaw==
X-Received: by 2002:a05:6358:cb1c:b0:135:24ed:510b with SMTP id
 gr28-20020a056358cb1c00b0013524ed510bmr9090856rwb.3.1691182955879; 
 Fri, 04 Aug 2023 14:02:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s12-20020a0ce30c000000b0062df126ca11sm928858qvl.21.2023.08.04.14.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:02:33 -0700 (PDT)
Date: Fri, 4 Aug 2023 17:02:21 -0400
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
Message-ID: <ZM1nXbjxWx9jvbjz@x1n>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
 <ZM0g8iNXzv9LRo+w@x1n> <ZM0nX8qt1T3aZgNK@redhat.com>
 <ZM0rWiHF8voqOdyp@x1n> <ZM0r8VoF8w5vGw7p@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM0r8VoF8w5vGw7p@redhat.com>
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

On Fri, Aug 04, 2023 at 05:48:49PM +0100, Daniel P. Berrangé wrote:
> On Fri, Aug 04, 2023 at 12:46:18PM -0400, Peter Xu wrote:
> > On Fri, Aug 04, 2023 at 05:29:19PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Aug 04, 2023 at 12:01:54PM -0400, Peter Xu wrote:
> > > > On Fri, Aug 04, 2023 at 02:59:07PM +0100, Daniel P. Berrangé wrote:
> > > > > On Fri, Aug 04, 2023 at 02:28:05PM +0200, Markus Armbruster wrote:
> > > > > > Peter Xu <peterx@redhat.com> writes:
> > > > > > 
> > > > > > > We used to have three objects that have always the same list of parameters
> > > > > > 
> > > > > > We have!
> > > > > > 
> > > > > > > and comments are always duplicated:
> > > > > > >
> > > > > > >   - @MigrationParameter
> > > > > > >   - @MigrationParameters
> > > > > > >   - @MigrateSetParameters
> > > > > > >
> > > > > > > Before we can deduplicate the code, it's fairly straightforward to
> > > > > > > deduplicate the comments first, so for each time we add a new migration
> > > > > > > parameter we don't need to copy the same paragraphs three times.
> > > > > > 
> > > > > > De-duplicating the code would be nice, but we haven't done so in years,
> > > > > > which suggests it's hard enough not to be worth the trouble.
> > > > > 
> > > > > The "MigrationParameter" enumeration isn't actually used in
> > > > > QMP at all.
> > > > > 
> > > > > It is only used in HMP for hmp_migrate_set_parameter and
> > > > > hmp_info_migrate_parameters. So it is questionable documenting
> > > > > that enum in the QMP reference docs at all.
> > > > > 
> > > > > 1c1
> > > > > < { 'struct': 'MigrationParameters',
> > > > > ---
> > > > > > { 'struct': 'MigrateSetParameters',
> > > > > 14,16c14,16
> > > > > <             '*tls-creds': 'str',
> > > > > <             '*tls-hostname': 'str',
> > > > > <             '*tls-authz': 'str',
> > > > > ---
> > > > > >             '*tls-creds': 'StrOrNull',
> > > > > >             '*tls-hostname': 'StrOrNull',
> > > > > >             '*tls-authz': 'StrOrNull',
> > > > > 
> > > > > Is it not valid to use StrOrNull in both cases and thus
> > > > > delete the duplication here ?
> > > > 
> > > > I tested removing MigrateSetParameters by replacing it with
> > > > MigrationParameters and it looks all fine here... I manually tested qmp/hmp
> > > > on set/query parameters, and qtests are all happy.
> > > 
> > > I meant the other way around, such we would be using 'StrOrNull'
> > > in all scenarios.
> > 
> > Yes, that should also work and even without worrying on nulls.  I just took
> > a random one replacing the other.
> > 
> > > 
> > > > 
> > > > The only thing I see that may affect it is we used to logically allow
> > > > taking things like '"tls-authz": null' in the json input, but now we won't
> > > > allow that because we'll be asking for a string type only.
> > > > 
> > > > Since we have query-qmp-schema I suppose we're all fine, because logically
> > > > the mgmt app (libvirt?) will still query that to understand the protocol,
> > > > so now we'll have (response of query-qmp-schema):
> > > > 
> > > >         {
> > > >             "arg-type": "144",
> > > >             "meta-type": "command",
> > > >             "name": "migrate-set-parameters",
> > > >             "ret-type": "0"
> > > >         },
> > > > 
> > > > Where 144 can start to point to MigrationParameters, rather than
> > > > MigrateSetParameters.
> > > > 
> > > > Ok, then what if the mgmt app doesn't care and just used "null" in tls-*
> > > > fields when setting?  Funnily I tried it and actually anything that does
> > > > migrate-set-parameters with a "null" passed over to tls-* fields will
> > > > already crash qemu...
> > > > 
> > > > ./migration/options.c:1333: migrate_params_apply: Assertion `params->tls_authz->type == QTYPE_QSTRING' failed.
> > > > 
> > > > #0  0x00007f72f4b2a844 in __pthread_kill_implementation () at /lib64/libc.so.6
> > > > #1  0x00007f72f4ad9abe in raise () at /lib64/libc.so.6
> > > > #2  0x00007f72f4ac287f in abort () at /lib64/libc.so.6
> > > > #3  0x00007f72f4ac279b in _nl_load_domain.cold () at /lib64/libc.so.6
> > > > #4  0x00007f72f4ad2147 in  () at /lib64/libc.so.6
> > > > #5  0x00005573308740e6 in migrate_params_apply (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1333
> > > > #6  0x0000557330874591 in qmp_migrate_set_parameters (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1433
> > > > #7  0x0000557330cb9132 in qmp_marshal_migrate_set_parameters (args=0x7f72e00036d0, ret=0x7f72f133cd98, errp=0x7f72f133cd90) at qapi/qapi-commands-migration.c:214
> > > > #8  0x0000557330d07fab in do_qmp_dispatch_bh (opaque=0x7f72f133ce30) at ../qapi/qmp-dispatch.c:128
> > > > #9  0x0000557330d33bbb in aio_bh_call (bh=0x5573337d7920) at ../util/async.c:169
> > > > #10 0x0000557330d33cd8 in aio_bh_poll (ctx=0x55733356e7d0) at ../util/async.c:216
> > > > #11 0x0000557330d17a19 in aio_dispatch (ctx=0x55733356e7d0) at ../util/aio-posix.c:423
> > > > #12 0x0000557330d34117 in aio_ctx_dispatch (source=0x55733356e7d0, callback=0x0, user_data=0x0) at ../util/async.c:358
> > > > #13 0x00007f72f5a8848c in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> > > > #14 0x0000557330d358d4 in glib_pollfds_poll () at ../util/main-loop.c:290
> > > > #15 0x0000557330d35951 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> > > > #16 0x0000557330d35a5f in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> > > > #17 0x000055733083aee0 in qemu_main_loop () at ../softmmu/runstate.c:732
> > > > #18 0x0000557330b0921b in qemu_default_main () at ../softmmu/main.c:37
> > > > #19 0x0000557330b09251 in main (argc=35, argv=0x7ffc74fd0ec8) at ../softmmu/main.c:48
> > > > 
> > > > Then I suppose it means all mgmt apps are not using "null" anyway, and it
> > > > makes more sense to me to just remove MigrateSetParameters (by replacing it
> > > > with MigrationParameters).
> > > 
> > > It shouldn't be crashing,  because qmp_migrate_set_parameters()
> > > is turning 'null' into  "", which means the assert ought to
> > > never fire. Did you have a local modiification that caused
> > > this crash perhaps ?
> > 
> > I think it just got overlooked when introducing tls-authz to not have added
> > that special code in qmp_migrate_set_parameters(), the other two are fine.
> 
> Oh right yes, pre-existing bug.

So do we really care about "null" in any form over "" (empty str) here for
tls-* parameters?

To fix this tls-authz bug we can add one more QTYPE_QNULL to QTYPE_QSTRING
convertion, but I'd rather just use "str" for all tls* fields and remove
the other two instead, if "null" is not important to anyone.

In all cases, I've appended with the two patches I'm currently testing
with.  It should also fix the tls-authz crash over 'null' by just rejecting
that.  But I'm open to anything - the patch (more than RFC) is more for
reference of whether we can drop the two objects in qapi/migration.

Thanks,

===8<===

From cd07ae2c048fe2265845bcf3f1ef4529854b71a1 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 4 Aug 2023 11:02:26 -0400
Subject: [PATCH 1/2] migration/qapi: Replace @MigrateSetParameters with
 @MigrationParameters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These two structs are mostly identical besides some fields (quote from
Daniel P. Berrangé in his reply):

1c1
< { 'struct': 'MigrationParameters',
---
> { 'struct': 'MigrateSetParameters',
14,16c14,16
<             '*tls-creds': 'str',
<             '*tls-hostname': 'str',
<             '*tls-authz': 'str',
---
>             '*tls-creds': 'StrOrNull',
>             '*tls-hostname': 'StrOrNull',
>             '*tls-authz': 'StrOrNull',

Here the difference is @MigrateSetParameters object would allow 'null'
values for any tls-* fields passed in.

Is that really important?  It seems not, because right now if anyone tries
to pass over a 'null' value to any of them, QEMU will already crash:

./migration/options.c:1333: migrate_params_apply: Assertion `params->tls_authz->type == QTYPE_QSTRING' failed.

And it's actually important to fix this crash instead.

To fix it, we can either change the code to handle QTYPE_NULL, or rather we
can directly replace all @MigrateSetParameters references with
@MigrationParameters knowing that no user is anyway using 'null' as an
input.

This greatly deduplicates the code not only in qapi/migration.json, but
also in the generic migration code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 185 +--------------------------------
 migration/migration-hmp-cmds.c |  16 +--
 migration/options.c            | 140 ++-----------------------
 3 files changed, 12 insertions(+), 329 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..0416da65b5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -851,189 +851,6 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit'] }
 
-##
-# @MigrateSetParameters:
-#
-# @announce-initial: Initial delay (in milliseconds) before sending
-#     the first announce (Since 4.0)
-#
-# @announce-max: Maximum delay (in milliseconds) between packets in
-#     the announcement (Since 4.0)
-#
-# @announce-rounds: Number of self-announce packets sent after
-#     migration (Since 4.0)
-#
-# @announce-step: Increase in delay (in milliseconds) between
-#     subsequent packets in the announcement (Since 4.0)
-#
-# @compress-level: compression level
-#
-# @compress-threads: compression thread count
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: decompression thread count
-#
-# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
-#     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
-#
-# @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  The
-#     default value is 20. (Since 2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     The default value is 10. (Since 2.7)
-#
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
-#     the tail stage of throttling, the Guest is very sensitive to CPU
-#     percentage while the @cpu-throttle -increment is excessive
-#     usually at tail stage.  If this parameter is true, we will
-#     compute the ideal CPU percentage used by the Guest, which may
-#     exactly make the dirty rate match the dirty rate threshold.
-#     Then we will choose a smaller throttle increment between the one
-#     specified by @cpu-throttle-increment and the one generated by
-#     ideal CPU percentage.  Therefore, it is compatible to
-#     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.  (Since
-#     5.1)
-#
-# @tls-creds: ID of the 'tls-creds' object that provides credentials
-#     for establishing a TLS connection over the migration data
-#     channel.  On the outgoing side of the migration, the credentials
-#     must be for a 'client' endpoint, while for the incoming side the
-#     credentials must be for a 'server' endpoint.  Setting this to a
-#     non-empty string enables TLS for all migrations.  An empty
-#     string means that QEMU will use plain text mode for migration,
-#     rather than TLS (Since 2.9) Previously (since 2.7), this was
-#     reported by omitting tls-creds instead.
-#
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7) An empty string means that QEMU will use
-#     the hostname associated with the migration URI, if any.  (Since
-#     2.9) Previously (since 2.7), this was reported by omitting
-#     tls-hostname instead.
-#
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: the delay time between two COLO checkpoints.
-#     (Since 2.8)
-#
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
-# @multifd-channels: Number of channels used to migrate data in
-#     parallel.  This is the same number that the number of sockets
-#     used for migration.  The default value is 2 (since 4.0)
-#
-# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
-#     needs to be a multiple of the target page size and a power of 2
-#     (Since 2.11)
-#
-# @max-postcopy-bandwidth: Background transfer bandwidth during
-#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
-#     (Since 3.0)
-#
-# @max-cpu-throttle: maximum cpu throttle percentage.  The default
-#     value is 99. (Since 3.1)
-#
-# @multifd-compression: Which compression method to use.  Defaults to
-#     none.  (Since 5.0)
-#
-# @multifd-zlib-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @multifd-zstd-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 20,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#     aliases for the purpose of dirty bitmap migration.  Such aliases
-#     may for example be the corresponding names on the opposite site.
-#     The mapping must be one-to-one, but not necessarily complete: On
-#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
-#     will be ignored.  On the destination, encountering an unmapped
-#     alias in the incoming migration stream will result in a report,
-#     and all further bitmap migration data will then be discarded.
-#     Note that the destination does not know about bitmaps it does
-#     not receive, so there is no limitation or requirement regarding
-#     the number of bitmaps received, or how they are named, or on
-#     which nodes they are placed.  By default (when this parameter
-#     has never been set), bitmap names are mapped to themselves.
-#     Nodes are mapped to their block device name if there is one, and
-#     to their node name otherwise.  (Since 5.2)
-#
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to 1000ms.
-#     Defaults to 1000ms.  (Since 8.1)
-#
-# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#     Defaults to 1.  (Since 8.1)
-#
-# Features:
-#
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#     are experimental.
-#
-# TODO: either fuse back into MigrationParameters, or make
-#     MigrationParameters members mandatory
-#
-# Since: 2.4
-##
-{ 'struct': 'MigrateSetParameters',
-  'data': { '*announce-initial': 'size',
-            '*announce-max': 'size',
-            '*announce-rounds': 'size',
-            '*announce-step': 'size',
-            '*compress-level': 'uint8',
-            '*compress-threads': 'uint8',
-            '*compress-wait-thread': 'bool',
-            '*decompress-threads': 'uint8',
-            '*throttle-trigger-threshold': 'uint8',
-            '*cpu-throttle-initial': 'uint8',
-            '*cpu-throttle-increment': 'uint8',
-            '*cpu-throttle-tailslow': 'bool',
-            '*tls-creds': 'StrOrNull',
-            '*tls-hostname': 'StrOrNull',
-            '*tls-authz': 'StrOrNull',
-            '*max-bandwidth': 'size',
-            '*downtime-limit': 'uint64',
-            '*x-checkpoint-delay': { 'type': 'uint32',
-                                     'features': [ 'unstable' ] },
-            '*block-incremental': 'bool',
-            '*multifd-channels': 'uint8',
-            '*xbzrle-cache-size': 'size',
-            '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle': 'uint8',
-            '*multifd-compression': 'MultiFDCompression',
-            '*multifd-zlib-level': 'uint8',
-            '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
-            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
-
 ##
 # @migrate-set-parameters:
 #
@@ -1048,7 +865,7 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
-  'data': 'MigrateSetParameters' }
+  'data': 'MigrationParameters' }
 
 ##
 # @MigrationParameters:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..a64672f640 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -497,7 +497,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
-    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
+    MigrationParameters *p = g_new0(MigrationParameters, 1);
     uint64_t valuebw = 0;
     uint64_t cache_size;
     Error *err = NULL;
@@ -546,19 +546,13 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
         break;
     case MIGRATION_PARAMETER_TLS_CREDS:
-        p->tls_creds = g_new0(StrOrNull, 1);
-        p->tls_creds->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_creds->u.s, &err);
+        visit_type_str(v, param, &p->tls_creds, &err);
         break;
     case MIGRATION_PARAMETER_TLS_HOSTNAME:
-        p->tls_hostname = g_new0(StrOrNull, 1);
-        p->tls_hostname->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_hostname->u.s, &err);
+        visit_type_str(v, param, &p->tls_hostname, &err);
         break;
     case MIGRATION_PARAMETER_TLS_AUTHZ:
-        p->tls_authz = g_new0(StrOrNull, 1);
-        p->tls_authz->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_authz->u.s, &err);
+        visit_type_str(v, param, &p->tls_authz, &err);
         break;
     case MIGRATION_PARAMETER_MAX_BANDWIDTH:
         p->has_max_bandwidth = true;
@@ -657,7 +651,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     qmp_migrate_set_parameters(p, &err);
 
  cleanup:
-    qapi_free_MigrateSetParameters(p);
+    qapi_free_MigrationParameters(p);
     visit_free(v);
     hmp_handle_error(mon, err);
 }
diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..7967c572fc 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1172,113 +1172,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrateSetParameters *params,
-                                      MigrationParameters *dest)
-{
-    *dest = migrate_get_current()->parameters;
-
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
-
-    if (params->has_compress_level) {
-        dest->compress_level = params->compress_level;
-    }
-
-    if (params->has_compress_threads) {
-        dest->compress_threads = params->compress_threads;
-    }
-
-    if (params->has_compress_wait_thread) {
-        dest->compress_wait_thread = params->compress_wait_thread;
-    }
-
-    if (params->has_decompress_threads) {
-        dest->decompress_threads = params->decompress_threads;
-    }
-
-    if (params->has_throttle_trigger_threshold) {
-        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
-    }
-
-    if (params->has_cpu_throttle_initial) {
-        dest->cpu_throttle_initial = params->cpu_throttle_initial;
-    }
-
-    if (params->has_cpu_throttle_increment) {
-        dest->cpu_throttle_increment = params->cpu_throttle_increment;
-    }
-
-    if (params->has_cpu_throttle_tailslow) {
-        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
-    }
-
-    if (params->tls_creds) {
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = params->tls_creds->u.s;
-    }
-
-    if (params->tls_hostname) {
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = params->tls_hostname->u.s;
-    }
-
-    if (params->has_max_bandwidth) {
-        dest->max_bandwidth = params->max_bandwidth;
-    }
-
-    if (params->has_downtime_limit) {
-        dest->downtime_limit = params->downtime_limit;
-    }
-
-    if (params->has_x_checkpoint_delay) {
-        dest->x_checkpoint_delay = params->x_checkpoint_delay;
-    }
-
-    if (params->has_block_incremental) {
-        dest->block_incremental = params->block_incremental;
-    }
-    if (params->has_multifd_channels) {
-        dest->multifd_channels = params->multifd_channels;
-    }
-    if (params->has_multifd_compression) {
-        dest->multifd_compression = params->multifd_compression;
-    }
-    if (params->has_xbzrle_cache_size) {
-        dest->xbzrle_cache_size = params->xbzrle_cache_size;
-    }
-    if (params->has_max_postcopy_bandwidth) {
-        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
-    }
-    if (params->has_max_cpu_throttle) {
-        dest->max_cpu_throttle = params->max_cpu_throttle;
-    }
-    if (params->has_announce_initial) {
-        dest->announce_initial = params->announce_initial;
-    }
-    if (params->has_announce_max) {
-        dest->announce_max = params->announce_max;
-    }
-    if (params->has_announce_rounds) {
-        dest->announce_rounds = params->announce_rounds;
-    }
-    if (params->has_announce_step) {
-        dest->announce_step = params->announce_step;
-    }
-
-    if (params->has_block_bitmap_mapping) {
-        dest->has_block_bitmap_mapping = true;
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
-    }
-
-    if (params->has_x_vcpu_dirty_limit_period) {
-        dest->x_vcpu_dirty_limit_period =
-            params->x_vcpu_dirty_limit_period;
-    }
-    if (params->has_vcpu_dirty_limit) {
-        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
-    }
-}
-
-static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
+static void migrate_params_apply(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1318,20 +1212,17 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 
     if (params->tls_creds) {
         g_free(s->parameters.tls_creds);
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
+        s->parameters.tls_creds = g_strdup(params->tls_creds);
     }
 
     if (params->tls_hostname) {
         g_free(s->parameters.tls_hostname);
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
+        s->parameters.tls_hostname = g_strdup(params->tls_hostname);
     }
 
     if (params->tls_authz) {
         g_free(s->parameters.tls_authz);
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+        s->parameters.tls_authz = g_strdup(params->tls_authz);
     }
 
     if (params->has_max_bandwidth) {
@@ -1404,28 +1295,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 }
 
-void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
+void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
-    MigrationParameters tmp;
-
-    /* TODO Rewrite "" to null instead */
-    if (params->tls_creds
-        && params->tls_creds->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_creds->u.n);
-        params->tls_creds->type = QTYPE_QSTRING;
-        params->tls_creds->u.s = strdup("");
-    }
-    /* TODO Rewrite "" to null instead */
-    if (params->tls_hostname
-        && params->tls_hostname->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_hostname->u.n);
-        params->tls_hostname->type = QTYPE_QSTRING;
-        params->tls_hostname->u.s = strdup("");
-    }
-
-    migrate_params_test_apply(params, &tmp);
-
-    if (!migrate_params_check(&tmp, errp)) {
+    if (!migrate_params_check(params, errp)) {
         /* Invalid parameter */
         return;
     }
-- 
2.41.0

===8<===

From 4d0661be6be85631f64c6bcb8cec9f30a49bc805 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 4 Aug 2023 12:32:21 -0400
Subject: [PATCH 2/2] migration/qapi: Drop @MigrationParameter enum

Drop the enum in qapi because it is never used in QMP APIs.  Instead making
it an internal definition for QEMU so that we can decouple it from QAPI,
and also we can deduplicate the QAPI documentations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 179 ---------------------------------
 migration/options.h            |  47 +++++++++
 migration/migration-hmp-cmds.c |   3 +-
 migration/options.c            |  51 ++++++++++
 4 files changed, 100 insertions(+), 180 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 0416da65b5..4846b2a98e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -672,185 +672,6 @@
       'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
   } }
 
-##
-# @MigrationParameter:
-#
-# Migration parameters enumeration
-#
-# @announce-initial: Initial delay (in milliseconds) before sending
-#     the first announce (Since 4.0)
-#
-# @announce-max: Maximum delay (in milliseconds) between packets in
-#     the announcement (Since 4.0)
-#
-# @announce-rounds: Number of self-announce packets sent after
-#     migration (Since 4.0)
-#
-# @announce-step: Increase in delay (in milliseconds) between
-#     subsequent packets in the announcement (Since 4.0)
-#
-# @compress-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU.
-#
-# @compress-threads: Set compression thread count to be used in live
-#     migration, the compression thread count is an integer between 1
-#     and 255.
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: Set decompression thread count to be used in
-#     live migration, the decompression thread count is an integer
-#     between 1 and 255. Usually, decompression is at least 4 times as
-#     fast as compression, so set the decompress-threads to the number
-#     about 1/4 of compress-threads is adequate.
-#
-# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
-#     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
-#
-# @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  The
-#     default value is 20. (Since 2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     The default value is 10. (Since 2.7)
-#
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
-#     the tail stage of throttling, the Guest is very sensitive to CPU
-#     percentage while the @cpu-throttle -increment is excessive
-#     usually at tail stage.  If this parameter is true, we will
-#     compute the ideal CPU percentage used by the Guest, which may
-#     exactly make the dirty rate match the dirty rate threshold.
-#     Then we will choose a smaller throttle increment between the one
-#     specified by @cpu-throttle-increment and the one generated by
-#     ideal CPU percentage.  Therefore, it is compatible to
-#     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.  (Since
-#     5.1)
-#
-# @tls-creds: ID of the 'tls-creds' object that provides credentials
-#     for establishing a TLS connection over the migration data
-#     channel.  On the outgoing side of the migration, the credentials
-#     must be for a 'client' endpoint, while for the incoming side the
-#     credentials must be for a 'server' endpoint.  Setting this will
-#     enable TLS for all migrations.  The default is unset, resulting
-#     in unsecured migration at the QEMU level.  (Since 2.7)
-#
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7)
-#
-# @tls-authz: ID of the 'authz' object subclass that provides access
-#     control checking of the TLS x509 certificate distinguished name.
-#     This object is only resolved at time of use, so can be deleted
-#     and recreated on the fly while the migration server is active.
-#     If missing, it will default to denying access (Since 4.0)
-#
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: The delay time (in ms) between two COLO
-#     checkpoints in periodic mode.  (Since 2.8)
-#
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
-# @multifd-channels: Number of channels used to migrate data in
-#     parallel.  This is the same number that the number of sockets
-#     used for migration.  The default value is 2 (since 4.0)
-#
-# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
-#     needs to be a multiple of the target page size and a power of 2
-#     (Since 2.11)
-#
-# @max-postcopy-bandwidth: Background transfer bandwidth during
-#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
-#     (Since 3.0)
-#
-# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
-#     (Since 3.1)
-#
-# @multifd-compression: Which compression method to use.  Defaults to
-#     none.  (Since 5.0)
-#
-# @multifd-zlib-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @multifd-zstd-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 20,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#     aliases for the purpose of dirty bitmap migration.  Such aliases
-#     may for example be the corresponding names on the opposite site.
-#     The mapping must be one-to-one, but not necessarily complete: On
-#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
-#     will be ignored.  On the destination, encountering an unmapped
-#     alias in the incoming migration stream will result in a report,
-#     and all further bitmap migration data will then be discarded.
-#     Note that the destination does not know about bitmaps it does
-#     not receive, so there is no limitation or requirement regarding
-#     the number of bitmaps received, or how they are named, or on
-#     which nodes they are placed.  By default (when this parameter
-#     has never been set), bitmap names are mapped to themselves.
-#     Nodes are mapped to their block device name if there is one, and
-#     to their node name otherwise.  (Since 5.2)
-#
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to 1000ms.
-#     Defaults to 1000ms.  (Since 8.1)
-#
-# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#     Defaults to 1.  (Since 8.1)
-#
-# Features:
-#
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#     are experimental.
-#
-# Since: 2.4
-##
-{ 'enum': 'MigrationParameter',
-  'data': ['announce-initial', 'announce-max',
-           'announce-rounds', 'announce-step',
-           'compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread', 'throttle-trigger-threshold',
-           'cpu-throttle-initial', 'cpu-throttle-increment',
-           'cpu-throttle-tailslow',
-           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'downtime-limit',
-           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'block-incremental',
-           'multifd-channels',
-           'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level', 'multifd-zstd-level',
-           'block-bitmap-mapping',
-           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit'] }
-
 ##
 # @migrate-set-parameters:
 #
diff --git a/migration/options.h b/migration/options.h
index 045e2a41a2..b1b3a26604 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -65,6 +65,53 @@ bool migrate_cap_set(int cap, bool value, Error **errp);
 
 /* parameters */
 
+typedef enum {
+    MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
+    MIGRATION_PARAMETER_ANNOUNCE_MAX,
+    MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
+    MIGRATION_PARAMETER_ANNOUNCE_STEP,
+    MIGRATION_PARAMETER_COMPRESS_LEVEL,
+    MIGRATION_PARAMETER_COMPRESS_THREADS,
+    MIGRATION_PARAMETER_DECOMPRESS_THREADS,
+    MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
+    MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
+    MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
+    MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
+    MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
+    MIGRATION_PARAMETER_TLS_CREDS,
+    MIGRATION_PARAMETER_TLS_HOSTNAME,
+    MIGRATION_PARAMETER_TLS_AUTHZ,
+    MIGRATION_PARAMETER_MAX_BANDWIDTH,
+    MIGRATION_PARAMETER_DOWNTIME_LIMIT,
+    MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
+    MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
+    MIGRATION_PARAMETER_MULTIFD_CHANNELS,
+    MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
+    MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
+    MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
+    MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
+    MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
+    MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
+    MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
+    MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
+    MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
+    MIGRATION_PARAMETER__MAX,
+} MigrationParameter;
+
+extern const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX];
+#define  MigrationParameter_str(p)  MigrationParameter_string[p]
+
+/**
+ * @MigrationParameter_from_str(): Parse string into a MigrationParameter
+ *
+ * @param: input string
+ * @errp: error message if failed to parse the string
+ *
+ * Returns MigrationParameter enum (>=0) if succeed, or negative otherwise
+ * which will always setup @errp.
+ */
+int MigrationParameter_from_str(const char *param, Error **errp);
+
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a64672f640..68c68079c2 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -31,6 +31,7 @@
 #include "ui/qemu-spice.h"
 #include "sysemu/sysemu.h"
 #include "migration.h"
+#include "migration/options.h"
 
 static void migration_global_dump(Monitor *mon)
 {
@@ -503,7 +504,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     int val, ret;
 
-    val = qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err);
+    val = MigrationParameter_from_str(param, &err);
     if (val < 0) {
         goto cleanup;
     }
diff --git a/migration/options.c b/migration/options.c
index 7967c572fc..0e661bc251 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -84,6 +84,57 @@
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
+const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX] = {
+    [MIGRATION_PARAMETER_ANNOUNCE_INITIAL] = "announce-initial",
+    [MIGRATION_PARAMETER_ANNOUNCE_MAX] = "announce-max",
+    [MIGRATION_PARAMETER_ANNOUNCE_ROUNDS] = "announce-rounds",
+    [MIGRATION_PARAMETER_ANNOUNCE_STEP] = "announce-step",
+    [MIGRATION_PARAMETER_COMPRESS_LEVEL] = "compress-level",
+    [MIGRATION_PARAMETER_COMPRESS_THREADS] = "compress-threads",
+    [MIGRATION_PARAMETER_DECOMPRESS_THREADS] = "decompress-threads",
+    [MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD] = "compress-wait-thread",
+    [MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD] = "throttle-trigger-threshold",
+    [MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL] = "cpu-throttle-initial",
+    [MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT] = "cpu-throttle-increment",
+    [MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW] = "cpu-throttle-tailslow",
+    [MIGRATION_PARAMETER_TLS_CREDS] = "tls-creds",
+    [MIGRATION_PARAMETER_TLS_HOSTNAME] = "tls-hostname",
+    [MIGRATION_PARAMETER_TLS_AUTHZ] = "tls-authz",
+    [MIGRATION_PARAMETER_MAX_BANDWIDTH] = "max-bandwidth",
+    [MIGRATION_PARAMETER_DOWNTIME_LIMIT] = "downtime-limit",
+    [MIGRATION_PARAMETER_X_CHECKPOINT_DELAY] = "x-checkpoint-delay",
+    [MIGRATION_PARAMETER_BLOCK_INCREMENTAL] = "block-incremental",
+    [MIGRATION_PARAMETER_MULTIFD_CHANNELS] = "multifd-channels",
+    [MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE] = "xbzrle-cache-size",
+    [MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH] = "max-postcopy-bandwidth",
+    [MIGRATION_PARAMETER_MAX_CPU_THROTTLE] = "max-cpu-throttle",
+    [MIGRATION_PARAMETER_MULTIFD_COMPRESSION] = "multifd-compression",
+    [MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL] = "multifd-zlib-level",
+    [MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL] = "multifd-zstd-level",
+    [MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING] = "block-bitmap-mapping",
+    [MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD] = "x-vcpu-dirty-limit-period",
+    [MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT] = "vcpu-dirty-limit",
+};
+
+int MigrationParameter_from_str(const char *param, Error **errp)
+{
+    int i;
+
+    if (!param) {
+        error_setg(errp, "Missing parameter value");
+        return -1;
+    }
+
+    for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
+        if (!strcmp(param, MigrationParameter_string[i])) {
+            return i;
+        }
+    }
+
+    error_setg(errp, "Invalid parameter value: %s", param);
+    return -1;
+}
+
 Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
-- 
2.41.0

===8<===

-- 
Peter Xu


