Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED50749F46
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQCH-0004e0-NY; Thu, 06 Jul 2023 10:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQCF-0004dq-Ue
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQCD-0005V7-Bo
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688654579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoUXulB0FhdIPiTwkRiLCzbGiv9d3G4Gt1pu+o5URo0=;
 b=UB9V+Tgsuih+up9p1YmL+9P/8W9nFR5m1bI/YLkQhV0Xi0Z0bfeGYAotCmKaAK1BPwX1Ka
 7dWHe3EwUtfUvrLudkhbhMRet6Duc7D94hQhcQuf073sf8C4PinImZJK9suvd8YIQeviW1
 Rfp/wYth3cna60IV7OjANCeFWB1P+5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-FcOZmqNrOzymc_TknIxR8A-1; Thu, 06 Jul 2023 10:42:55 -0400
X-MC-Unique: FcOZmqNrOzymc_TknIxR8A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A681E805951;
 Thu,  6 Jul 2023 14:42:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F729492C13;
 Thu,  6 Jul 2023 14:42:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A16221E6A1F; Thu,  6 Jul 2023 16:42:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Juan
 Quintela <quintela@redhat.com>,  "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v7 2/9] qapi/migration: Introduce
 x-vcpu-dirty-limit-period parameter
References: <168853615963.17240.15832775267134683267-2@git.sr.ht>
Date: Thu, 06 Jul 2023 16:42:53 +0200
In-Reply-To: <168853615963.17240.15832775267134683267-2@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 21:32:59 +0800")
Message-ID: <87pm55p0cy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> writes:

> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Introduce "x-vcpu-dirty-limit-period" migration experimental
> parameter, which is in the range of 1 to 1000ms and used to
> make dirtyrate calculation period configurable.
>
> Currently with the "x-vcpu-dirty-limit-period" varies, the
> total time of live migration changes, test results show the
> optimal value of "x-vcpu-dirty-limit-period" ranges from
> 500ms to 1000 ms. "x-vcpu-dirty-limit-period" should be made
> stable once it proves best value can not be determined with
> developer's experiments.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration-hmp-cmds.c |  8 ++++++++
>  migration/options.c            | 28 ++++++++++++++++++++++++++++
>  qapi/migration.json            | 34 +++++++++++++++++++++++++++-------
>  3 files changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmd=
s.c
> index 9885d7c9f7..352e9ec716 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -364,6 +364,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const=
 QDict *qdict)
>                  }
>              }
>          }
> +
> +        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
> +        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PE=
RIOD),
> +        params->x_vcpu_dirty_limit_period);
>      }
>=20=20
>      qapi_free_MigrationParameters(params);
> @@ -620,6 +624,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
Dict *qdict)
>          error_setg(&err, "The block-bitmap-mapping parameter can only be=
 set "
>                     "through QMP");
>          break;
> +    case MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD:
> +        p->has_x_vcpu_dirty_limit_period =3D true;
> +        visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
> +        break;
>      default:
>          assert(0);
>      }
> diff --git a/migration/options.c b/migration/options.c
> index 5a9505adf7..1de63ba775 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -80,6 +80,8 @@
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
>=20=20
> +#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseco=
nds */
> +
>  Property migration_properties[] =3D {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>                       store_global_state, true),
> @@ -163,6 +165,9 @@ Property migration_properties[] =3D {
>      DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds=
),
>      DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_ho=
stname),
>      DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz=
),
> +    DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
> +                       parameters.x_vcpu_dirty_limit_period,
> +                       DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
>=20=20
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -908,6 +913,9 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
>                         s->parameters.block_bitmap_mapping);
>      }
>=20=20
> +    params->has_x_vcpu_dirty_limit_period =3D true;
> +    params->x_vcpu_dirty_limit_period =3D s->parameters.x_vcpu_dirty_lim=
it_period;
> +
>      return params;
>  }
>=20=20
> @@ -940,6 +948,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_announce_max =3D true;
>      params->has_announce_rounds =3D true;
>      params->has_announce_step =3D true;
> +    params->has_x_vcpu_dirty_limit_period =3D true;
>  }
>=20=20
>  /*
> @@ -1100,6 +1109,15 @@ bool migrate_params_check(MigrationParameters *par=
ams, Error **errp)
>      }
>  #endif
>=20=20
> +    if (params->has_x_vcpu_dirty_limit_period &&
> +        (params->x_vcpu_dirty_limit_period < 1 ||
> +         params->x_vcpu_dirty_limit_period > 1000)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "x-vcpu-dirty-limit-period",
> +                   "a value between 1 and 1000");
> +        return false;
> +    }
> +
>      return true;
>  }
>=20=20
> @@ -1199,6 +1217,11 @@ static void migrate_params_test_apply(MigrateSetPa=
rameters *params,
>          dest->has_block_bitmap_mapping =3D true;
>          dest->block_bitmap_mapping =3D params->block_bitmap_mapping;
>      }
> +
> +    if (params->has_x_vcpu_dirty_limit_period) {
> +        dest->x_vcpu_dirty_limit_period =3D
> +            params->x_vcpu_dirty_limit_period;
> +    }
>  }
>=20=20
>  static void migrate_params_apply(MigrateSetParameters *params, Error **e=
rrp)
> @@ -1317,6 +1340,11 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
>              QAPI_CLONE(BitmapMigrationNodeAliasList,
>                         params->block_bitmap_mapping);
>      }
> +
> +    if (params->has_x_vcpu_dirty_limit_period) {
> +        s->parameters.x_vcpu_dirty_limit_period =3D
> +            params->x_vcpu_dirty_limit_period;
> +    }
>  }
>=20=20
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **er=
rp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 47dfef0278..384b768e03 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -789,9 +789,14 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> +#                             live migration. Should be in the range 1 t=
o 1000ms,
> +#                             defaults to 1000ms. (Since 8.1)
> +#
>  # Features:
>  #
> -# @unstable: Member @x-checkpoint-delay is experimental.
> +# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> +#            are experimental.

Please format like

   # @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
   #     limit during live migration.  Should be in the range 1 to
   #     1000ms, defaults to 1000ms.  (Since 8.1)
   #
   # Features:
   #
   # @unstable: Members @x-checkpoint-delay and
   #     @x-vcpu-dirty-limit-period are experimental.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

>  #
>  # Since: 2.4
>  ##
> @@ -809,8 +814,9 @@
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
> -           'multifd-zlib-level' ,'multifd-zstd-level',
> -           'block-bitmap-mapping' ] }
> +           'multifd-zlib-level', 'multifd-zstd-level',
> +           'block-bitmap-mapping',
> +           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable=
'] } ] }
>=20=20
>  ##
>  # @MigrateSetParameters:
> @@ -945,9 +951,14 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> +#                             live migration. Should be in the range 1 t=
o 1000ms,
> +#                             defaults to 1000ms. (Since 8.1)
> +#
>  # Features:
>  #
> -# @unstable: Member @x-checkpoint-delay is experimental.
> +# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> +#            are experimental.
>  #

Likewise.

>  # TODO: either fuse back into MigrationParameters, or make
>  #     MigrationParameters members mandatory
> @@ -982,7 +993,9 @@
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> +                                            'features': [ 'unstable' ] }=
 } }
>=20=20
>  ##
>  # @migrate-set-parameters:
> @@ -1137,9 +1150,14 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> +#                             live migration. Should be in the range 1 t=
o 1000ms,
> +#                             defaults to 1000ms. (Since 8.1)
> +#
>  # Features:
>  #
> -# @unstable: Member @x-checkpoint-delay is experimental.
> +# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> +#            are experimental.
>  #

Likewise.

>  # Since: 2.4
>  ##
> @@ -1171,7 +1189,9 @@
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> +                                            'features': [ 'unstable' ] }=
 } }
>=20=20
>  ##
>  # @query-migrate-parameters:


