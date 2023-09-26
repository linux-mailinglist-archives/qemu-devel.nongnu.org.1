Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A32777AF578
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEu6-0001pm-L1; Tue, 26 Sep 2023 16:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlEu3-0001pH-NA
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlEu0-0003WP-QF
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695761008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuN6XxYhC77T3ZunAW/ew57lcscNeq0rBCWRUoTpouY=;
 b=gnVJ25lI9FRo/CgQP6/JMMCR6C9/xVPQwa65KbSafmefNpEceXiR/9dpcQSqR8M6LDqidn
 bIMHCGI/p6z8KbIKePcG813DELSvL7OFiJAUV2dad/84VTDbXcdsWsCeO1aFUhh6PP+g6C
 S+2pWKIgv7nyLyidL61AUXDYu8kUTFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-7ojbM8lUPcGfAwGgBOkAUg-1; Tue, 26 Sep 2023 16:43:24 -0400
X-MC-Unique: 7ojbM8lUPcGfAwGgBOkAUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4833A185A79B;
 Tue, 26 Sep 2023 20:43:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E010240C2064;
 Tue, 26 Sep 2023 20:43:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA31F21E6900; Tue, 26 Sep 2023 22:43:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
Date: Tue, 26 Sep 2023 22:43:22 +0200
In-Reply-To: <20230905162335.235619-5-peterx@redhat.com> (Peter Xu's message
 of "Tue, 5 Sep 2023 12:23:35 -0400")
Message-ID: <87a5t8is2d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> Drop the enum in qapi because it is never used in QMP APIs.  Instead maki=
ng
> it an internal definition for QEMU so that we can decouple it from QAPI,
> and also we can deduplicate the QAPI documentations.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

The enum is defined in the QAPI schema, because that gives us easy
conversion to and from strings (it also gives us
visit_type_MigrationParameter(), but we don't care for that).

I assume you move it out of the QAPI schema just so you don't have to
maintain the useless doc comment anymore.  Correct?

Let me take a step back.  Reasons for defining a type in the QAPI
schema:

0. QMP commands or events use the type.=20=20

1. CLI uses the type (QAPIfied option arguments).

2. QOM properties use the type.

3. Use internal to QEMU, say for easy conversion to and from strings.

Generated documentation includes all the types (unlike query-qmp-schema,
which describes exactly QMP).  Issues:

1. Documentation fails to connect types to the QOM properties using
   them.  Just one part of the bigger QOM documentation misery.

2. Likewise, types are not connected to the CLI options using them.

3. Types used only internally appear in documentation.

> ---
>  qapi/migration.json            | 179 ---------------------------------
>  migration/options.h            |  47 +++++++++
>  migration/migration-hmp-cmds.c |   3 +-
>  migration/options.c            |  51 ++++++++++
>  4 files changed, 100 insertions(+), 180 deletions(-)

At a glance, the diffstat looks like a win.  Less so once we drill into
it.  160 of 180 lines deleted from qapi/migration.json are doc comment.
The other 20 lines deleted there you replace by 100 lines of C code.
All this just to get rid of the useless doc comment.  Hmm.

We can't just delete it because the QAPI generator insists on
documentation.

Loophole...  Here's the stupidest solution that could possibly work:

    ##
    # @MigrationParameter:
    #
    # TODO: elide from generated documentation (type is used only
    #     internally, and not visible in QMP)
    #
    # Features:
    #
    # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
    #     are experimental.
    #
    # Since: 2.4
    ##

Works because the QAPI generator currently doesn't flag missing member
documentation, and quietly substitutes "Not documented" instead.  Looks
like

    "MigrationParameter" (Enum)
    ---------------------------


    Values
    ~~~~~~

    "announce-initial"
       Not documented

    "announce-max"
       Not documented

and so forth.  Sure ugly, but is it really worse than before?  It's now
obviously useless, whereas before it was unobviously useless.

This will break when we tighten up the QAPI generator to require member
documentation.  Along we a few hundred other violators.

We might want to add a way to say "members intentionally undocumented".
Could be useful for qapi/ui.json's QKeyCode.  Most of its 162 members
don't really need documentation...

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 45d69787ae..eeb1878c4f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -672,185 +672,6 @@
>        'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
>    } }
>=20=20
> -##
> -# @MigrationParameter:
> -#
> -# Migration parameters enumeration
> -#
> -# @announce-initial: Initial delay (in milliseconds) before sending
> -#     the first announce (Since 4.0)
> -#
> -# @announce-max: Maximum delay (in milliseconds) between packets in
> -#     the announcement (Since 4.0)
> -#
> -# @announce-rounds: Number of self-announce packets sent after
> -#     migration (Since 4.0)
> -#
> -# @announce-step: Increase in delay (in milliseconds) between
> -#     subsequent packets in the announcement (Since 4.0)
> -#
> -# @compress-level: Set the compression level to be used in live
> -#     migration, the compression level is an integer between 0 and 9,
> -#     where 0 means no compression, 1 means the best compression
> -#     speed, and 9 means best compression ratio which will consume
> -#     more CPU.
> -#
> -# @compress-threads: Set compression thread count to be used in live
> -#     migration, the compression thread count is an integer between 1
> -#     and 255.
> -#
> -# @compress-wait-thread: Controls behavior when all compression
> -#     threads are currently busy.  If true (default), wait for a free
> -#     compression thread to become available; otherwise, send the page
> -#     uncompressed.  (Since 3.1)
> -#
> -# @decompress-threads: Set decompression thread count to be used in
> -#     live migration, the decompression thread count is an integer
> -#     between 1 and 255. Usually, decompression is at least 4 times as
> -#     fast as compression, so set the decompress-threads to the number
> -#     about 1/4 of compress-threads is adequate.
> -#
> -# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
> -#     bytes_xfer_period to trigger throttling.  It is expressed as
> -#     percentage.  The default value is 50. (Since 5.0)
> -#
> -# @cpu-throttle-initial: Initial percentage of time guest cpus are
> -#     throttled when migration auto-converge is activated.  The
> -#     default value is 20. (Since 2.7)
> -#
> -# @cpu-throttle-increment: throttle percentage increase each time
> -#     auto-converge detects that migration is not making progress.
> -#     The default value is 10. (Since 2.7)
> -#
> -# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
> -#     the tail stage of throttling, the Guest is very sensitive to CPU
> -#     percentage while the @cpu-throttle -increment is excessive
> -#     usually at tail stage.  If this parameter is true, we will
> -#     compute the ideal CPU percentage used by the Guest, which may
> -#     exactly make the dirty rate match the dirty rate threshold.
> -#     Then we will choose a smaller throttle increment between the one
> -#     specified by @cpu-throttle-increment and the one generated by
> -#     ideal CPU percentage.  Therefore, it is compatible to
> -#     traditional throttling, meanwhile the throttle increment won't
> -#     be excessive at tail stage.  The default value is false.  (Since
> -#     5.1)
> -#
> -# @tls-creds: ID of the 'tls-creds' object that provides credentials
> -#     for establishing a TLS connection over the migration data
> -#     channel.  On the outgoing side of the migration, the credentials
> -#     must be for a 'client' endpoint, while for the incoming side the
> -#     credentials must be for a 'server' endpoint.  Setting this will
> -#     enable TLS for all migrations.  The default is unset, resulting
> -#     in unsecured migration at the QEMU level.  (Since 2.7)
> -#
> -# @tls-hostname: hostname of the target host for the migration.  This
> -#     is required when using x509 based TLS credentials and the
> -#     migration URI does not already include a hostname.  For example
> -#     if using fd: or exec: based migration, the hostname must be
> -#     provided so that the server's x509 certificate identity can be
> -#     validated.  (Since 2.7)
> -#
> -# @tls-authz: ID of the 'authz' object subclass that provides access
> -#     control checking of the TLS x509 certificate distinguished name.
> -#     This object is only resolved at time of use, so can be deleted
> -#     and recreated on the fly while the migration server is active.
> -#     If missing, it will default to denying access (Since 4.0)
> -#
> -# @max-bandwidth: to set maximum speed for migration.  maximum speed
> -#     in bytes per second.  (Since 2.8)
> -#
> -# @downtime-limit: set maximum tolerated downtime for migration.
> -#     maximum downtime in milliseconds (Since 2.8)
> -#
> -# @x-checkpoint-delay: The delay time (in ms) between two COLO
> -#     checkpoints in periodic mode.  (Since 2.8)
> -#
> -# @block-incremental: Affects how much storage is migrated when the
> -#     block migration capability is enabled.  When false, the entire
> -#     storage backing chain is migrated into a flattened image at the
> -#     destination; when true, only the active qcow2 layer is migrated
> -#     and the destination must already have access to the same backing
> -#     chain as was used on the source.  (since 2.10)
> -#
> -# @multifd-channels: Number of channels used to migrate data in
> -#     parallel.  This is the same number that the number of sockets
> -#     used for migration.  The default value is 2 (since 4.0)
> -#
> -# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
> -#     needs to be a multiple of the target page size and a power of 2
> -#     (Since 2.11)
> -#
> -# @max-postcopy-bandwidth: Background transfer bandwidth during
> -#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
> -#     (Since 3.0)
> -#
> -# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
> -#     (Since 3.1)
> -#
> -# @multifd-compression: Which compression method to use.  Defaults to
> -#     none.  (Since 5.0)
> -#
> -# @multifd-zlib-level: Set the compression level to be used in live
> -#     migration, the compression level is an integer between 0 and 9,
> -#     where 0 means no compression, 1 means the best compression
> -#     speed, and 9 means best compression ratio which will consume
> -#     more CPU. Defaults to 1. (Since 5.0)
> -#
> -# @multifd-zstd-level: Set the compression level to be used in live
> -#     migration, the compression level is an integer between 0 and 20,
> -#     where 0 means no compression, 1 means the best compression
> -#     speed, and 20 means best compression ratio which will consume
> -#     more CPU. Defaults to 1. (Since 5.0)
> -#
> -# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> -#     aliases for the purpose of dirty bitmap migration.  Such aliases
> -#     may for example be the corresponding names on the opposite site.
> -#     The mapping must be one-to-one, but not necessarily complete: On
> -#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
> -#     will be ignored.  On the destination, encountering an unmapped
> -#     alias in the incoming migration stream will result in a report,
> -#     and all further bitmap migration data will then be discarded.
> -#     Note that the destination does not know about bitmaps it does
> -#     not receive, so there is no limitation or requirement regarding
> -#     the number of bitmaps received, or how they are named, or on
> -#     which nodes they are placed.  By default (when this parameter
> -#     has never been set), bitmap names are mapped to themselves.
> -#     Nodes are mapped to their block device name if there is one, and
> -#     to their node name otherwise.  (Since 5.2)
> -#
> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> -#     limit during live migration.  Should be in the range 1 to 1000ms.
> -#     Defaults to 1000ms.  (Since 8.1)
> -#
> -# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> -#     Defaults to 1.  (Since 8.1)
> -#
> -# Features:
> -#
> -# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> -#     are experimental.
> -#
> -# Since: 2.4
> -##
> -{ 'enum': 'MigrationParameter',
> -  'data': ['announce-initial', 'announce-max',
> -           'announce-rounds', 'announce-step',
> -           'compress-level', 'compress-threads', 'decompress-threads',
> -           'compress-wait-thread', 'throttle-trigger-threshold',
> -           'cpu-throttle-initial', 'cpu-throttle-increment',
> -           'cpu-throttle-tailslow',
> -           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'downtime-limit',
> -           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> -           'block-incremental',
> -           'multifd-channels',
> -           'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle', 'multifd-compression',
> -           'multifd-zlib-level', 'multifd-zstd-level',
> -           'block-bitmap-mapping',
> -           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable=
'] },
> -           'vcpu-dirty-limit'] }
> -
>  ##
>  # @migrate-set-parameters:
>  #
> diff --git a/migration/options.h b/migration/options.h
> index 124a5d450f..4591545c62 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -66,6 +66,53 @@ bool migrate_cap_set(int cap, bool value, Error **errp=
);
>=20=20
>  /* parameters */
>=20=20
> +typedef enum {
> +    MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
> +    MIGRATION_PARAMETER_ANNOUNCE_MAX,
> +    MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
> +    MIGRATION_PARAMETER_ANNOUNCE_STEP,
> +    MIGRATION_PARAMETER_COMPRESS_LEVEL,
> +    MIGRATION_PARAMETER_COMPRESS_THREADS,
> +    MIGRATION_PARAMETER_DECOMPRESS_THREADS,
> +    MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
> +    MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
> +    MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
> +    MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
> +    MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
> +    MIGRATION_PARAMETER_TLS_CREDS,
> +    MIGRATION_PARAMETER_TLS_HOSTNAME,
> +    MIGRATION_PARAMETER_TLS_AUTHZ,
> +    MIGRATION_PARAMETER_MAX_BANDWIDTH,
> +    MIGRATION_PARAMETER_DOWNTIME_LIMIT,
> +    MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
> +    MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
> +    MIGRATION_PARAMETER_MULTIFD_CHANNELS,
> +    MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
> +    MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
> +    MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
> +    MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
> +    MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
> +    MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
> +    MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
> +    MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
> +    MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
> +    MIGRATION_PARAMETER__MAX,
> +} MigrationParameter;
> +
> +extern const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX];
> +#define  MigrationParameter_str(p)  MigrationParameter_string[p]

This is effectifely the code we no longer generate into
qapi-types-migration.h:

   typedef enum MigrationParameter {
       MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
       MIGRATION_PARAMETER_ANNOUNCE_MAX,
       MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
       MIGRATION_PARAMETER_ANNOUNCE_STEP,
       MIGRATION_PARAMETER_COMPRESS_LEVEL,
       MIGRATION_PARAMETER_COMPRESS_THREADS,
       MIGRATION_PARAMETER_DECOMPRESS_THREADS,
       MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
       MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
       MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
       MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
       MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
       MIGRATION_PARAMETER_TLS_CREDS,
       MIGRATION_PARAMETER_TLS_HOSTNAME,
       MIGRATION_PARAMETER_TLS_AUTHZ,
       MIGRATION_PARAMETER_MAX_BANDWIDTH,
       MIGRATION_PARAMETER_DOWNTIME_LIMIT,
       MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
       MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
       MIGRATION_PARAMETER_MULTIFD_CHANNELS,
       MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
       MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
       MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
       MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
       MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
       MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
       MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
       MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
       MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
       MIGRATION_PARAMETER__MAX,
   } MigrationParameter;
=20=20=20
   #define MigrationParameter_str(val) \
       qapi_enum_lookup(&MigrationParameter_lookup, (val))
=20=20=20
   extern const QEnumLookup MigrationParameter_lookup;

> +
> +/**
> + * @MigrationParameter_from_str(): Parse string into a MigrationParameter
> + *
> + * @param: input string
> + * @errp: error message if failed to parse the string
> + *
> + * Returns MigrationParameter enum (>=3D0) if succeed, or negative other=
wise
> + * which will always setup @errp.
> + */
> +int MigrationParameter_from_str(const char *param, Error **errp);
> +

This is in addition.  More below next to its definition.

>  const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
>  bool migrate_has_block_bitmap_mapping(void);
>=20=20
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmd=
s.c
> index 88a8ccb475..0a35a87b7e 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -31,6 +31,7 @@
>  #include "ui/qemu-spice.h"
>  #include "sysemu/sysemu.h"
>  #include "migration.h"
> +#include "migration/options.h"
>=20=20
>  static void migration_global_dump(Monitor *mon)
>  {
> @@ -505,7 +506,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QD=
ict *qdict)
>      Error *err =3D NULL;
>      int val, ret;
>=20=20
> -    val =3D qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err);
> +    val =3D MigrationParameter_from_str(param, &err);
>      if (val < 0) {
>          goto cleanup;
>      }

You replace qapi_enum_parse() by MigrationParameter_from_str().

> diff --git a/migration/options.c b/migration/options.c
> index 12e392f68c..c9b90d932d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -84,6 +84,57 @@
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseco=
nds */
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>=20=20
> +const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX] =3D {
> +    [MIGRATION_PARAMETER_ANNOUNCE_INITIAL] =3D "announce-initial",
> +    [MIGRATION_PARAMETER_ANNOUNCE_MAX] =3D "announce-max",
> +    [MIGRATION_PARAMETER_ANNOUNCE_ROUNDS] =3D "announce-rounds",
> +    [MIGRATION_PARAMETER_ANNOUNCE_STEP] =3D "announce-step",
> +    [MIGRATION_PARAMETER_COMPRESS_LEVEL] =3D "compress-level",
> +    [MIGRATION_PARAMETER_COMPRESS_THREADS] =3D "compress-threads",
> +    [MIGRATION_PARAMETER_DECOMPRESS_THREADS] =3D "decompress-threads",
> +    [MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD] =3D "compress-wait-thread=
",
> +    [MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD] =3D "throttle-trigg=
er-threshold",
> +    [MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL] =3D "cpu-throttle-initial=
",
> +    [MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT] =3D "cpu-throttle-incre=
ment",
> +    [MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW] =3D "cpu-throttle-tailsl=
ow",
> +    [MIGRATION_PARAMETER_TLS_CREDS] =3D "tls-creds",
> +    [MIGRATION_PARAMETER_TLS_HOSTNAME] =3D "tls-hostname",
> +    [MIGRATION_PARAMETER_TLS_AUTHZ] =3D "tls-authz",
> +    [MIGRATION_PARAMETER_MAX_BANDWIDTH] =3D "max-bandwidth",
> +    [MIGRATION_PARAMETER_DOWNTIME_LIMIT] =3D "downtime-limit",
> +    [MIGRATION_PARAMETER_X_CHECKPOINT_DELAY] =3D "x-checkpoint-delay",
> +    [MIGRATION_PARAMETER_BLOCK_INCREMENTAL] =3D "block-incremental",
> +    [MIGRATION_PARAMETER_MULTIFD_CHANNELS] =3D "multifd-channels",
> +    [MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE] =3D "xbzrle-cache-size",
> +    [MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH] =3D "max-postcopy-bandw=
idth",
> +    [MIGRATION_PARAMETER_MAX_CPU_THROTTLE] =3D "max-cpu-throttle",
> +    [MIGRATION_PARAMETER_MULTIFD_COMPRESSION] =3D "multifd-compression",
> +    [MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL] =3D "multifd-zlib-level",
> +    [MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL] =3D "multifd-zstd-level",
> +    [MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING] =3D "block-bitmap-mapping=
",
> +    [MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD] =3D "x-vcpu-dirty-li=
mit-period",
> +    [MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT] =3D "vcpu-dirty-limit",
> +};

This is almost the code we no longer generate into qapi-types-migration.c:

   const QEnumLookup MigrationParameter_lookup =3D {
       .array =3D (const char *const[]) {
           [MIGRATION_PARAMETER_ANNOUNCE_INITIAL] =3D "announce-initial",
           [MIGRATION_PARAMETER_ANNOUNCE_MAX] =3D "announce-max",
           [MIGRATION_PARAMETER_ANNOUNCE_ROUNDS] =3D "announce-rounds",
           [MIGRATION_PARAMETER_ANNOUNCE_STEP] =3D "announce-step",
           [MIGRATION_PARAMETER_COMPRESS_LEVEL] =3D "compress-level",
           [MIGRATION_PARAMETER_COMPRESS_THREADS] =3D "compress-threads",
           [MIGRATION_PARAMETER_DECOMPRESS_THREADS] =3D "decompress-threads=
",
           [MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD] =3D "compress-wait-th=
read",
           [MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD] =3D "throttle-t=
rigger-threshold",
           [MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL] =3D "cpu-throttle-ini=
tial",
           [MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT] =3D "cpu-throttle-i=
ncrement",
           [MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW] =3D "cpu-throttle-ta=
ilslow",
           [MIGRATION_PARAMETER_TLS_CREDS] =3D "tls-creds",
           [MIGRATION_PARAMETER_TLS_HOSTNAME] =3D "tls-hostname",
           [MIGRATION_PARAMETER_TLS_AUTHZ] =3D "tls-authz",
           [MIGRATION_PARAMETER_MAX_BANDWIDTH] =3D "max-bandwidth",
           [MIGRATION_PARAMETER_DOWNTIME_LIMIT] =3D "downtime-limit",
           [MIGRATION_PARAMETER_X_CHECKPOINT_DELAY] =3D "x-checkpoint-delay=
",
           [MIGRATION_PARAMETER_BLOCK_INCREMENTAL] =3D "block-incremental",
           [MIGRATION_PARAMETER_MULTIFD_CHANNELS] =3D "multifd-channels",
           [MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE] =3D "xbzrle-cache-size",
           [MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH] =3D "max-postcopy-b=
andwidth",
           [MIGRATION_PARAMETER_MAX_CPU_THROTTLE] =3D "max-cpu-throttle",
           [MIGRATION_PARAMETER_MULTIFD_COMPRESSION] =3D "multifd-compressi=
on",
           [MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL] =3D "multifd-zlib-level=
",
           [MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL] =3D "multifd-zstd-level=
",
           [MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING] =3D "block-bitmap-map=
ping",
           [MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD] =3D "x-vcpu-dirt=
y-limit-period",
           [MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT] =3D "vcpu-dirty-limit",
       },
       .special_features =3D (const unsigned char[MIGRATION_PARAMETER__MAX]=
) {
           [MIGRATION_PARAMETER_X_CHECKPOINT_DELAY] =3D 1u << QAPI_UNSTABLE,
           [MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD] =3D 1u << QAPI_U=
NSTABLE,
       },
       .size =3D MIGRATION_PARAMETER__MAX
   };

The difference is .special_features[].  Used only by visitor code, which
you don't need.  Okay.

> +
> +int MigrationParameter_from_str(const char *param, Error **errp)
> +{
> +    int i;
> +
> +    if (!param) {
> +        error_setg(errp, "Missing parameter value");
> +        return -1;
> +    }
> +
> +    for (i =3D 0; i < MIGRATION_PARAMETER__MAX; i++) {
> +        if (!strcmp(param, MigrationParameter_string[i])) {
> +            return i;
> +        }
> +    }
> +
> +    error_setg(errp, "Invalid parameter value: %s", param);
> +    return -1;
> +}
> +

This is qapi_enum_parse() specialized for MigrationParameter_string[].

Not needed if we simply keep using qapi_enum_parse().

>  Property migration_properties[] =3D {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>                       store_global_state, true),


