Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C673825D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwHQ-0001Zh-LJ; Wed, 21 Jun 2023 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBwHO-0001ZQ-0Z
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBwHM-00025B-21
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687347938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h20O3O19p3zZ+SaMus+WvYul1u6vT3KbwPAUjfiveGA=;
 b=SXutqPy2Xo4nimh5g/NXXRgV6CWjjMBP2VlkH3ppYYhNpLGS6z71CCKiBtccAZvAGAOfrh
 AUE1SMM20zAEbeQsKU/V+rCWEHj6DMzm/+xgbjx0Y1eWVoV2vxwr+eDMrFQaEOvuo83Bck
 GsKd7oIH3IkHyCuNVRreNFEcY3XnJEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-K-49lxrgPOSQEVm5qWjWfA-1; Wed, 21 Jun 2023 07:45:37 -0400
X-MC-Unique: K-49lxrgPOSQEVm5qWjWfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 045E4101A54E;
 Wed, 21 Jun 2023 11:45:37 +0000 (UTC)
Received: from localhost (unknown [10.39.194.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 733E22166B32;
 Wed, 21 Jun 2023 11:45:36 +0000 (UTC)
Date: Wed, 21 Jun 2023 13:45:34 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 5/6] migration: Deprecate block migration
Message-ID: <20230621114534.GA2681260@fedora>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jz3pHFYx8l5DTLYg"
Content-Disposition: inline
In-Reply-To: <20230612193344.3796-6-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--jz3pHFYx8l5DTLYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 09:33:43PM +0200, Juan Quintela wrote:
> It is obsolete.  It is better to use driver_mirror+NBD instead.
>=20
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Hanna Czenczek <hreitz@redhat.com>
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
>=20
> Can any of you give one example of how to use driver_mirror+NBD for
> deprecated.rst?

Please see "QMP invocation for live storage migration with
``drive-mirror`` + NBD" in docs/interop/live-block-operations.rst for a
detailed explanation.

>=20
> Thanks, Juan.
> ---
>  docs/about/deprecated.rst |  6 ++++++
>  qapi/migration.json       | 29 +++++++++++++++++++++++++----
>  migration/block.c         |  2 ++
>  migration/options.c       |  7 +++++++
>  4 files changed, 40 insertions(+), 4 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 518672722d..173c5ba5cb 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -454,3 +454,9 @@ Everything except ``-incoming defer`` are deprecated.=
  This allows to
>  setup parameters before launching the proper migration with
>  ``migrate-incoming uri``.
> =20
> +block migration (since 8.1)
> +'''''''''''''''''''''''''''
> +
> +Block migration is too inflexible.  It needs to migrate all block
> +devices or none.  Use driver_mirror+NBD instead.

blockdev-mirror with NBD

> +
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b71e00737e..a8497de48d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -258,11 +258,16 @@
>  #     blocked.  Present and non-empty when migration is blocked.
>  #     (since 6.0)
>  #
> +# Features:
> +#
> +# @deprecated: @disk migration is deprecated.  Use driver_mirror+NBD

blockdev-mirror with NBD

> +#     instead.
> +#
>  # Since: 0.14
>  ##
>  { 'struct': 'MigrationInfo',
>    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
> -           '*disk': 'MigrationStats',
> +           '*disk': { 'type': 'MigrationStats', 'features': ['deprecated=
'] },
>             '*vfio': 'VfioStats',
>             '*xbzrle-cache': 'XBZRLECacheStats',
>             '*total-time': 'int',
> @@ -497,6 +502,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: @block migration is deprecated.  Use driver_mirror+NBD

blockdev-mirror with NBD

> +#     instead.
> +#
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>  #
>  # Since: 1.2
> @@ -506,7 +514,8 @@
>             'compress', 'events', 'postcopy-ram',
>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>             'release-ram',
> -           'block', 'return-path', 'pause-before-switchover', 'multifd',
> +           { 'name': 'block', 'features': [ 'deprecated' ] },
> +           'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
> @@ -789,6 +798,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: Member @block-incremental is obsolete. Use
> +#     driver_mirror+NBD instead.

blockdev-mirror with NBD

> +#
>  # @unstable: Member @x-checkpoint-delay is experimental.
>  #
>  # Since: 2.4
> @@ -803,7 +815,7 @@
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'downtime-limit',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> -           'block-incremental',
> +           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
> @@ -945,6 +957,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: Member @block-incremental is obsolete. Use
> +#     driver_mirror+NBD instead.

blockdev-mirror with NBD

> +#
>  # @unstable: Member @x-checkpoint-delay is experimental.
>  #
>  # TODO: either fuse back into MigrationParameters, or make
> @@ -972,7 +987,8 @@
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> -            '*block-incremental': 'bool',
> +            '*block-incremental': { 'type': 'bool',
> +                                    'features': [ 'deprecated' ] },
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> @@ -1137,6 +1153,9 @@
>  #
>  # Features:
>  #
> +# @deprecated: Member @block-incremental is obsolete. Use
> +#     driver_mirror+NBD instead.

blockdev-mirror with NBD

> +#
>  # @unstable: Member @x-checkpoint-delay is experimental.
>  #
>  # Since: 2.4
> @@ -1161,6 +1180,8 @@
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> +            '*block-incremental': { 'type': 'bool',
> +                                    'features': [ 'deprecated' ] },
>              '*block-incremental': 'bool',
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
> diff --git a/migration/block.c b/migration/block.c
> index b9580a6c7e..2521a22269 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -722,6 +722,8 @@ static int block_save_setup(QEMUFile *f, void *opaque)
>      trace_migration_block_save("setup", block_mig_state.submitted,
>                                 block_mig_state.transferred);
> =20
> +    warn_report("block migration is deprecated.  Use mirror jobs instead=
=2E");

blockdev-mirror with NBD

> +
>      qemu_mutex_lock_iothread();
>      ret =3D init_blk_migration(f);
>      if (ret < 0) {
> diff --git a/migration/options.c b/migration/options.c
> index b62ab30cd5..374dc0767e 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -12,6 +12,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -437,6 +438,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_ca=
ps, Error **errp)
>          return false;
>      }
>  #endif
> +    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
> +        warn_report("Block migration is deprecated. "
> +                    "Use driver_mirror+NBD instead.");

blockdev-mirror with NBD

> +    }
> =20
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> @@ -1257,6 +1262,8 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
>      }
> =20
>      if (params->has_block_incremental) {
> +        warn_report("Block migration is deprecated. "
> +                    "Use driver_mirror+NBD instead.");

blockdev-mirror with NBD

>          s->parameters.block_incremental =3D params->block_incremental;
>      }
>      if (params->has_multifd_channels) {
> --=20
> 2.40.1
>=20

--jz3pHFYx8l5DTLYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSS4t4ACgkQnKSrs4Gr
c8hZyQf/SCuy+AKOc4W4aWFF4QPLmI12expm33dwsV/B3G8LPu8BLJH48WczuX5c
5nT47s+1qIw5ZLPjo5ItPnoTPicG3gtJy4D006Pgatvnzqpl9GnCYTrf60LPw39N
oZG0JrBoxgWyEJRtV3iHqkIQRq7qBiZ/9opqbCMWoyvtX+BqPVLqZUx9Srhbjlvo
BOj2WiZNE30q0Bzs5hceGENXJeAqDxh4yks31lkXPIuRd5CXf+0n6Jer0mF1+zQS
K52pW7E531Fz+HAtd1nyixqgN4WEtwwXRtB0LXSB/rZZWteTH4J+1ruWPxpIAZD/
/XupsgTgigxcHYXNYOgAGPPlSKVMYg==
=7KtM
-----END PGP SIGNATURE-----

--jz3pHFYx8l5DTLYg--


