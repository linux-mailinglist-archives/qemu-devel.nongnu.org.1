Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA08AE8145
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Jun 2025 13:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUOLw-0002rC-4h; Wed, 25 Jun 2025 07:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUOLs-0002pD-HD
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUOLo-00052m-Ra
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750851092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKix2Wzt8o657jjDmWRqjHEPGlgRMeKET/liRkISC8E=;
 b=Cza46t8rIvEt/Ygl/U8aNhT8uPBopw89oMlKDSJ9f8+946aOhICMBapVQkTUJ7HsgEnetv
 NJfX6tmChziUSxZLgagqMhSQr/nlBppM0fciYSi9N5k5Kh3F0Sn/eH6/5uqKKFa+NnUiO6
 kvb47lkdW42lWzYUHqO66XEf95ucfUg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-LTtzQspHPBixy_lU4NSX4g-1; Wed,
 25 Jun 2025 07:31:31 -0400
X-MC-Unique: LTtzQspHPBixy_lU4NSX4g-1
X-Mimecast-MFC-AGG-ID: LTtzQspHPBixy_lU4NSX4g_1750851090
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 515E11808984; Wed, 25 Jun 2025 11:31:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6A93300022A; Wed, 25 Jun 2025 11:31:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E355F21E6A27; Wed, 25 Jun 2025 13:31:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 02/21] migration: Remove MigrateSetParameters
In-Reply-To: <20250603013810.4772-3-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 2 Jun 2025 22:37:51 -0300")
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-3-farosas@suse.de>
Date: Wed, 25 Jun 2025 13:31:26 +0200
Message-ID: <87y0tg5a7l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Now that the TLS options have been made the same between
> migrate-set-parameters and query-migrate-parameters, a single type can
> be used. Remove MigrateSetParameters.
>
> The TLS options documentation from MigrationParameters were replaced
> with the ones from MigrateSetParameters which was more complete.
>
> I'm choosing to somewhat ignore any ambiguity between "query" and
> "set" because other options' docs are already ambiguous in that
> regard.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c |   4 +-
>  migration/options.c            |   6 +-
>  qapi/migration.json            | 221 +++------------------------------
>  3 files changed, 20 insertions(+), 211 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index bc8179c582..aacffdc532 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -490,7 +490,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      const char *param = qdict_get_str(qdict, "parameter");
>      const char *valuestr = qdict_get_str(qdict, "value");
>      Visitor *v = string_input_visitor_new(valuestr);
> -    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
> +    MigrationParameters *p = g_new0(MigrationParameters, 1);
>      uint64_t valuebw = 0;
>      uint64_t cache_size;
>      Error *err = NULL;
> @@ -656,7 +656,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      qmp_migrate_set_parameters(p, &err);
>  
>   cleanup:
> -    qapi_free_MigrateSetParameters(p);
> +    qapi_free_MigrationParameters(p);
>      visit_free(v);
>      hmp_handle_error(mon, err);
>  }
> diff --git a/migration/options.c b/migration/options.c
> index 45a95dc6da..e49d584a99 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1227,7 +1227,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>      return true;
>  }
>  
> -static void migrate_params_test_apply(MigrateSetParameters *params,
> +static void migrate_params_test_apply(MigrationParameters *params,
>                                        MigrationParameters *dest)
>  {
>      *dest = migrate_get_current()->parameters;
> @@ -1350,7 +1350,7 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      }
>  }
>  
> -static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> +static void migrate_params_apply(MigrationParameters *params, Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
>  
> @@ -1479,7 +1479,7 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      }
>  }
>  
> -void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> +void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>  {
>      MigrationParameters tmp;
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index fa42d94810..080968993a 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -914,202 +914,6 @@
>             'zero-page-detection',
>             'direct-io'] }
>  
> -##
> -# @MigrateSetParameters:

Only use is argument type of migrate-set-parameters.  You're replacing
it by MigrationParameters there.  Let's compare the deleted docs to
their replacement.  I'll quote replacement docs exactly where they
differ.

   # @MigrationParameters:
   #
   # Migration parameters. Optional members are optional when used with
   # an input command, otherwise mandatory.

Figuring out which commands are input commands is left to the reader.
Why not simply "optional with migrate-set-parameters"?

However, it doesn't end there.  The paragraph creates a problem with
John Snow's "inliner", which I hope to merge later this year.  Let me
explain.

Generated command documentation normally looks like this:

    Command migrate-set-capabilities (Since: 1.2)

       Enable/Disable the following migration capabilities (like xbzrle)

       Arguments:
          * **capabilities** ("[""MigrationCapabilityStatus""]") -- json
            array of capability modifications to make

Except when we happen to use a named type for the arguments.  This
should be an implementation detail, and it is, except for generated
documentation, which looks like

    Command migrate-set-parameters (Since: 2.4)

       Set various migration parameters.

       Arguments:
          * The members of "MigrationParameters".

The arguments are hidden behind a link.  The "inliner" will show the
them normally *always*, for better usability.  It will not, however,
inline the introductory paragraph above.  I can explain why if
necessary.

To compensate for the loss of that paragraph, we'll have to add suitable
text to migrate-set-parameters's doc comment.

I think we could just as well do that *now*: scratch the paragraph here,
add a suitable paragraph there.

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
> -# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
> -#     bytes_xfer_period to trigger throttling.  It is expressed as
> -#     percentage.  The default value is 50.  (Since 5.0)
> -#
> -# @cpu-throttle-initial: Initial percentage of time guest cpus are
> -#     throttled when migration auto-converge is activated.  The
> -#     default value is 20.  (Since 2.7)
> -#

   # @cpu-throttle-initial: Initial percentage of time guest cpus are
   #     throttled when migration auto-converge is activated.  (Since
   #     2.7)

We no longer document the default value.

> -# @cpu-throttle-increment: throttle percentage increase each time
> -#     auto-converge detects that migration is not making progress.
> -#     The default value is 10.  (Since 2.7)

   # @cpu-throttle-increment: throttle percentage increase each time
   #     auto-converge detects that migration is not making progress.
   #     (Since 2.7)

Likewise.

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
> -#     credentials must be for a 'server' endpoint.  Setting this to a
> -#     non-empty string enables TLS for all migrations.  An empty
> -#     string means that QEMU will use plain text mode for migration,
> -#     rather than TLS.  This is the default.  (Since 2.7)
> -#
> -# @tls-hostname: migration target's hostname for validating the
> -#     server's x509 certificate identity.  If empty, QEMU will use the
> -#     hostname from the migration URI, if any.  A non-empty value is
> -#     required when using x509 based TLS credentials and the migration
> -#     URI does not include a hostname, such as fd: or exec: based
> -#     migration.  (Since 2.7)
> -#
> -#     Note: empty value works only since 2.9.
> -#
> -# @tls-authz: ID of the 'authz' object subclass that provides access
> -#     control checking of the TLS x509 certificate distinguished name.
> -#     This object is only resolved at time of use, so can be deleted
> -#     and recreated on the fly while the migration server is active.
> -#     If missing, it will default to denying access (Since 4.0)
> -#
> -# @max-bandwidth: maximum speed for migration, in bytes per second.
> -#     (Since 2.8)
> -#
> -# @avail-switchover-bandwidth: to set the available bandwidth that
> -#     migration can use during switchover phase.  NOTE!  This does not
> -#     limit the bandwidth during switchover, but only for calculations
> -#     when making decisions to switchover.  By default, this value is
> -#     zero, which means QEMU will estimate the bandwidth
> -#     automatically.  This can be set when the estimated value is not
> -#     accurate, while the user is able to guarantee such bandwidth is
> -#     available when switching over.  When specified correctly, this
> -#     can make the switchover decision much more accurate.
> -#     (Since 8.2)
> -#
> -# @downtime-limit: set maximum tolerated downtime for migration.
> -#     maximum downtime in milliseconds (Since 2.8)
> -#
> -# @x-checkpoint-delay: The delay time (in ms) between two COLO
> -#     checkpoints in periodic mode.  (Since 2.8)

   # @x-checkpoint-delay: the delay time between two COLO checkpoints.
   #     (Since 2.8)

We no longer mention periodic mode.

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
> -#     more CPU.  Defaults to 1.  (Since 5.0)
> -#
> -# @multifd-qatzip-level: Set the compression level to be used in live
> -#     migration. The level is an integer between 1 and 9, where 1 means
> -#     the best compression speed, and 9 means the best compression
> -#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
> -#
> -# @multifd-zstd-level: Set the compression level to be used in live
> -#     migration, the compression level is an integer between 0 and 20,
> -#     where 0 means no compression, 1 means the best compression
> -#     speed, and 20 means best compression ratio which will consume
> -#     more CPU.  Defaults to 1.  (Since 5.0)
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
> -#     limit during live migration.  Should be in the range 1 to
> -#     1000ms.  Defaults to 1000ms.  (Since 8.1)
> -#
> -# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> -#     Defaults to 1.  (Since 8.1)
> -#
> -# @mode: Migration mode.  See description in @MigMode.  Default is
> -#     'normal'.  (Since 8.2)
> -#
> -# @zero-page-detection: Whether and how to detect zero pages.
> -#     See description in @ZeroPageDetection.  Default is 'multifd'.
> -#     (since 9.0)
> -#
> -# @direct-io: Open migration files with O_DIRECT when possible.  This
> -#     only has effect if the @mapped-ram capability is enabled.
> -#     (Since 9.1)
> -#
> -# Features:
> -#
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> -#
> -# TODO: either fuse back into MigrationParameters, or make
> -#     MigrationParameters members mandatory

The TODO is gone.  Makes sense.

> -#
> -# Since: 2.4
> -##
> -{ 'struct': 'MigrateSetParameters',
> -  'data': { '*announce-initial': 'size',
> -            '*announce-max': 'size',
> -            '*announce-rounds': 'size',
> -            '*announce-step': 'size',
> -            '*throttle-trigger-threshold': 'uint8',
> -            '*cpu-throttle-initial': 'uint8',
> -            '*cpu-throttle-increment': 'uint8',
> -            '*cpu-throttle-tailslow': 'bool',
> -            '*tls-creds': 'StrOrNull',
> -            '*tls-hostname': 'StrOrNull',
> -            '*tls-authz': 'StrOrNull',
> -            '*max-bandwidth': 'size',
> -            '*avail-switchover-bandwidth': 'size',
> -            '*downtime-limit': 'uint64',
> -            '*x-checkpoint-delay': { 'type': 'uint32',
> -                                     'features': [ 'unstable' ] },
> -            '*multifd-channels': 'uint8',
> -            '*xbzrle-cache-size': 'size',
> -            '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle': 'uint8',
> -            '*multifd-compression': 'MultiFDCompression',
> -            '*multifd-zlib-level': 'uint8',
> -            '*multifd-qatzip-level': 'uint8',
> -            '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> -            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> -                                            'features': [ 'unstable' ] },
> -            '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode',
> -            '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> -
>  ##
>  # @migrate-set-parameters:
>  #
> @@ -1124,12 +928,13 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'migrate-set-parameters', 'boxed': true,
> -  'data': 'MigrateSetParameters' }
> +  'data': 'MigrationParameters' }
>  
>  ##
>  # @MigrationParameters:
>  #
> -# The optional members aren't actually optional.
> +# Migration parameters. Optional members are optional when used with
> +# an input command, otherwise mandatory.
>  #
>  # @announce-initial: Initial delay (in milliseconds) before sending
>  #     the first announce (Since 4.0)
> @@ -1172,21 +977,25 @@
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
>  #     must be for a 'client' endpoint, while for the incoming side the
> -#     credentials must be for a 'server' endpoint.  An empty string
> -#     means that QEMU will use plain text mode for migration, rather
> -#     than TLS.  (Since 2.7)
> -#
> -#     Note: 2.8 omits empty @tls-creds instead.
> +#     credentials must be for a 'server' endpoint.  Setting this to a
> +#     non-empty string enables TLS for all migrations.  An empty
> +#     string means that QEMU will use plain text mode for migration,
> +#     rather than TLS.  This is the default.  (Since 2.7)
>  #
>  # @tls-hostname: migration target's hostname for validating the
>  #     server's x509 certificate identity.  If empty, QEMU will use the
> -#     hostname from the migration URI, if any.  (Since 2.7)
> +#     hostname from the migration URI, if any.  A non-empty value is
> +#     required when using x509 based TLS credentials and the migration
> +#     URI does not include a hostname, such as fd: or exec: based
> +#     migration.  (Since 2.7)
>  #
> -#     Note: 2.8 omits empty @tls-hostname instead.
> +#     Note: empty value works only since 2.9.
>  #
>  # @tls-authz: ID of the 'authz' object subclass that provides access
>  #     control checking of the TLS x509 certificate distinguished name.
> -#     (Since 4.0)
> +#     This object is only resolved at time of use, so can be deleted
> +#     and recreated on the fly while the migration server is active.
> +#     If missing, it will default to denying access (Since 4.0)
>  #
>  # @max-bandwidth: maximum speed for migration, in bytes per second.
>  #     (Since 2.8)


