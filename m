Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A237D0E77
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnkQ-0001WJ-R6; Fri, 20 Oct 2023 07:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtnkP-0001U0-6c
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtnkJ-0000dk-VN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697801571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OMOe71SNc/XdZpC7WgYj9+kUlCJbmA/xo23cKGD+HA=;
 b=AUXQ+L75wSFkO+8wu9SMjJkzQtcvIv9zIJPMpb6/GnKdXYLDQmiiJu8vND7M2IPD4KT4AC
 ewFENKZ5rfAtA6BdGDXPaze5lFnlyCeosGFvlfFt/pP/2Fsyh/0M+RwTTvurj9pxaTb0Q3
 T2yQkVFyuPsW5sjQLVPVuSr5djnCsNw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624--M-5Y4cTNzmG461dFnjvIw-1; Fri, 20 Oct 2023 07:32:46 -0400
X-MC-Unique: -M-5Y4cTNzmG461dFnjvIw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 355B93C0FCA8;
 Fri, 20 Oct 2023 11:32:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78869492BFB;
 Fri, 20 Oct 2023 11:32:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FCD621E6A1F; Fri, 20 Oct 2023 13:32:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org,  Juan Quintela
 <quintela@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>,  Alberto Garcia
 <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  John Snow <jsnow@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 11/22] qapi: Inline QERR_INVALID_PARAMETER_VALUE
 definition (constant value)
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-12-philmd@linaro.org>
Date: Fri, 20 Oct 2023 13:32:42 +0200
In-Reply-To: <20231005045041.52649-12-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:28
 +0200")
Message-ID: <87cyx94jhh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> vcpu_dirty_limit
>
> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Mechanical transformation using the following
> coccinelle semantic patch:
>
>     @match@
>     expression errp;
>     constant param;
>     constant value;
>     @@
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);
>
>     @script:python strformat depends on match@
>     param << match.param;
>     value << match.value;
>     fixedfmt; // new var
>     @@
>     fixedfmt =3D "\"Parameter '%s' expects %s\"" % (param[1:-1], value[1:=
-1])
>     coccinelle.fixedfmt =3D cocci.make_ident(fixedfmt)
>
>     @replace@
>     expression match.errp;
>     constant match.param;
>     constant match.value;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);
>     +    error_setg(errp, fixedfmt);
>
> Then manually splitting lines over 90 characters.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  backends/cryptodev-vhost-user.c |  4 +-
>  backends/rng-egd.c              |  4 +-
>  backends/rng-random.c           |  3 +-
>  block/quorum.c                  |  3 +-
>  blockdev.c                      |  9 ++--
>  blockjob.c                      |  3 +-
>  chardev/char.c                  |  3 +-
>  hw/usb/redirect.c               |  4 +-
>  migration/migration.c           |  4 +-
>  migration/options.c             | 92 ++++++++++++++-------------------
>  migration/page_cache.c          |  8 +--
>  migration/ram.c                 |  4 +-
>  monitor/fds.c                   |  8 +--
>  monitor/qmp-cmds.c              |  3 +-
>  net/filter-buffer.c             |  3 +-
>  net/filter.c                    |  7 ++-
>  net/net.c                       |  9 ++--
>  qga/commands-win32.c            |  4 +-
>  qom/object_interfaces.c         |  2 +-
>  qom/qom-qmp-cmds.c              |  7 ++-
>  softmmu/balloon.c               |  2 +-
>  softmmu/cpus.c                  |  3 +-
>  softmmu/qdev-monitor.c          | 11 ++--
>  ui/ui-qmp-cmds.c                |  2 +-
>  util/qemu-option.c              |  3 +-
>  25 files changed, 89 insertions(+), 116 deletions(-)
>
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-u=
ser.c
> index c3283ba84a..d93ccd5528 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -136,8 +136,8 @@ cryptodev_vhost_claim_chardev(CryptoDevBackendVhostUs=
er *s,
>      Chardev *chr;
>=20=20
>      if (s->chr_name =3D=3D NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "chardev", "a valid character device");
> +        error_setg(errp,
> +                   "Parameter 'chardev' expects a valid character device=
");
>          return NULL;
>      }
>=20=20
> diff --git a/backends/rng-egd.c b/backends/rng-egd.c
> index 684c3cf3d6..8f101afadc 100644
> --- a/backends/rng-egd.c
> +++ b/backends/rng-egd.c
> @@ -90,8 +90,8 @@ static void rng_egd_opened(RngBackend *b, Error **errp)
>      Chardev *chr;
>=20=20
>      if (s->chr_name =3D=3D NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "chardev", "a valid character device");
> +        error_setg(errp,
> +                   "Parameter 'chardev' expects a valid character device=
");
>          return;
>      }
>=20=20
> diff --git a/backends/rng-random.c b/backends/rng-random.c
> index 80eb5be138..9cb7d26cb5 100644
> --- a/backends/rng-random.c
> +++ b/backends/rng-random.c
> @@ -72,8 +72,7 @@ static void rng_random_opened(RngBackend *b, Error **er=
rp)
>      RngRandom *s =3D RNG_RANDOM(b);
>=20=20
>      if (s->filename =3D=3D NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "filename", "a valid filename");

Misuse of QERR_INVALID_PARAMETER_VALUE.

This function is RngBackendClass method opened(), which runs within
interface UserCreatableClass method complete(), which runs right after
an object with this interface was created.  "Parameters" need not exist
in this context.

The actual issue is property "filename" has not been set.  So let's
report that: "property 'filename' is required".

Separate patch, to keep this one mechanical.

> +        error_setg(errp, "Parameter 'filename' expects a valid filename"=
);
>      } else {
>          s->fd =3D qemu_open_old(s->filename, O_RDONLY | O_NONBLOCK);
>          if (s->fd =3D=3D -1) {
> diff --git a/block/quorum.c b/block/quorum.c
> index 05220cab7f..8e9f279568 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -882,8 +882,7 @@ static int quorum_valid_threshold(int threshold, int =
num_children, Error **errp)
>  {
>=20=20
>      if (threshold < 1) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "vote-threshold", "a value >=3D 1");
> +        error_setg(errp, "Parameter 'vote-threshold' expects a value >=
=3D 1");
>          return -ERANGE;
>      }
>=20=20
> diff --git a/blockdev.c b/blockdev.c
> index da39da457e..ed90365329 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2340,7 +2340,7 @@ void coroutine_fn qmp_block_resize(const char *devi=
ce, const char *node_name,
>      }
>=20=20
>      if (size < 0) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 siz=
e");
> +        error_setg(errp, "Parameter 'size' expects a >0 size");

The message is awful.  Not your patch's fault.  Could improve it on top.

>          return;
>      }
>=20=20
> @@ -2905,13 +2905,12 @@ static void blockdev_mirror_common(const char *jo=
b_id, BlockDriverState *bs,
>      }
>=20=20
>      if (granularity !=3D 0 && (granularity < 512 || granularity > 104857=
6 * 64)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
> -                   "a value in range [512B, 64MB]");
> +        error_setg(errp,
> +                   "Parameter 'granularity' expects a value in range [51=
2B, 64MB]");
>          return;
>      }
>      if (granularity & (granularity - 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
> -                   "a power of 2");
> +        error_setg(errp, "Parameter 'granularity' expects a power of 2");
>          return;
>      }

Contracting the two checks so we can report "expects a power of 2
between 512 and 64MiB" would be better.  Maybe on top.

We could quibble about the use of a unit.  There is none in QMP.  Moving
on.

>=20=20
> diff --git a/blockjob.c b/blockjob.c
> index 58c5d64539..f95f73244e 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -297,8 +297,7 @@ bool block_job_set_speed_locked(BlockJob *job, int64_=
t speed, Error **errp)
>          return false;
>      }
>      if (speed < 0) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
> -                   "a non-negative value");
> +        error_setg(errp, "Parameter 'speed' expects a non-negative value=
");
>          return false;
>      }
>=20=20
> diff --git a/chardev/char.c b/chardev/char.c
> index 996a024c7a..447b4d9d06 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -517,8 +517,7 @@ static const ChardevClass *char_get_class(const char =
*driver, Error **errp)
>      }
>=20=20
>      if (object_class_is_abstract(oc)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> -                   "an abstract device type");
> +        error_setg(errp, "Parameter 'driver' expects an abstract device =
type");
>          return NULL;
>      }
>=20=20
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index c9893df867..ac6fa34ad1 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1435,8 +1435,8 @@ static void usbredir_realize(USBDevice *udev, Error=
 **errp)
           i =3D usbredirfilter_string_to_rules(dev->filter_str, ":", "|",
>                                             &dev->filter_rules,
>                                             &dev->filter_rules_count);
>          if (i) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "filter",
> -                       "a usb device filter string");

Misuse of QERR_INVALID_PARAMETER_VALUE.

This is a realize() method.  "Parameters" need not exist in this
context.

The actual issue is property "filter" cannot be parsed (i =3D=3D -EINVAL),
or we're out of memory (i =3D=3D -ENOMEM).  This should arguable be checked
then the property is set, because the error reporting will be better
there.  Requires creating a suitable PropertyInfo.

I'm not asking for that now.  Instead, I suggest "property 'filter' is
not a valid USB redirection filter".  Bogus when -ENOMEM, but that's
unlikely and no worse than before.

Separate patch, to keep this one mechanical.  Not mentioning this again
from now on.

> +            error_setg(errp,
> +                       "Parameter 'filter' expects a usb device filter s=
tring");
>              return;
>          }
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 6d3cf5d5cd..b7f6818a15 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1703,8 +1703,8 @@ void qmp_migrate(const char *uri, bool has_blk, boo=
l blk,
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_outgoing_migration(s, p, &local_err);
>      } else {
> -        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
> -                   "a valid migration protocol");
> +        error_setg(&local_err,
> +                   "Parameter 'uri' expects a valid migration protocol");
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);
>          block_cleanup_parameters();
> diff --git a/migration/options.c b/migration/options.c
> index 79fce0c3a9..4f6c8e810c 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1002,137 +1002,124 @@ bool migrate_params_check(MigrationParameters *=
params, Error **errp)
>  {
>      if (params->has_compress_level &&
>          (params->compress_level > 9)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
> -                   "a value between 0 and 9");
> +        error_setg(errp, "Parameter 'compress_level' expects"
> +                         " a value between 0 and 9");
>          return false;
>      }
>=20=20
>      if (params->has_compress_threads && (params->compress_threads < 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "compress_threads",
> -                   "a value between 1 and 255");
> +        error_setg(errp, "Parameter 'compress_threads' expects"
> +                         " a value between 1 and 255");
>          return false;
>      }
>=20=20
>      if (params->has_decompress_threads && (params->decompress_threads < =
1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "decompress_threads",
> -                   "a value between 1 and 255");
> +        error_setg(errp, "Parameter 'decompress_threads' expects"
> +                         " a value between 1 and 255");
>          return false;
>      }
>=20=20
>      if (params->has_throttle_trigger_threshold &&
>          (params->throttle_trigger_threshold < 1 ||
>           params->throttle_trigger_threshold > 100)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "throttle_trigger_threshold",
> -                   "an integer in the range of 1 to 100");
> +        error_setg(errp, "Parameter 'throttle_trigger_threshold' expects"
> +                         " an integer in the range of 1 to 100");
>          return false;
>      }
>=20=20
>      if (params->has_cpu_throttle_initial &&
>          (params->cpu_throttle_initial < 1 ||
>           params->cpu_throttle_initial > 99)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "cpu_throttle_initial",
> -                   "an integer in the range of 1 to 99");
> +        error_setg(errp, "Parameter 'cpu_throttle_initial' expects"
> +                         " an integer in the range of 1 to 99");
>          return false;
>      }
>=20=20
>      if (params->has_cpu_throttle_increment &&
>          (params->cpu_throttle_increment < 1 ||
>           params->cpu_throttle_increment > 99)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "cpu_throttle_increment",
> -                   "an integer in the range of 1 to 99");
> +        error_setg(errp, "Parameter 'cpu_throttle_increment' expects"
> +                         " an integer in the range of 1 to 99");
>          return false;
>      }
>=20=20
>      if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX))=
 {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "max_bandwidth",
> -                   "an integer in the range of 0 to "stringify(SIZE_MAX)
> -                   " bytes/second");
> +        error_setg(errp, "Parameter 'max_bandwidth' expects"
> +                         " an integer in the range of 0"
> +                         " to " stringify(SIZE_MAX) " bytes/second");
>          return false;
>      }
>=20=20
>      if (params->has_downtime_limit &&
>          (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "downtime_limit",
> -                   "an integer in the range of 0 to "
> -                    stringify(MAX_MIGRATE_DOWNTIME)" ms");
> +        error_setg(errp,
> +                   "Parameter 'downtime_limit' expects"
> +                   " an integer in the range of 0"
> +                   " to " stringify(MAX_MIGRATE_DOWNTIME) " ms");
>          return false;
>      }
>=20=20
>      /* x_checkpoint_delay is now always positive */
>=20=20
>      if (params->has_multifd_channels && (params->multifd_channels < 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "multifd_channels",
> -                   "a value between 1 and 255");
> +        error_setg(errp, "Parameter 'multifd_channels' expects"
> +                         " a value between 1 and 255");
>          return false;
>      }
>=20=20
>      if (params->has_multifd_zlib_level &&
>          (params->multifd_zlib_level > 9)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_lev=
el",
> -                   "a value between 0 and 9");
> +        error_setg(errp, "Parameter 'multifd_zlib_level' expects"
> +                         " a value between 0 and 9");
>          return false;
>      }
>=20=20
>      if (params->has_multifd_zstd_level &&
>          (params->multifd_zstd_level > 20)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_lev=
el",
> -                   "a value between 0 and 20");
> +        error_setg(errp, "Parameter 'multifd_zstd_level' expects"
> +                         " a value between 0 and 20");
>          return false;
>      }
>=20=20
>      if (params->has_xbzrle_cache_size &&
>          (params->xbzrle_cache_size < qemu_target_page_size() ||
>           !is_power_of_2(params->xbzrle_cache_size))) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "xbzrle_cache_size",
> -                   "a power of two no less than the target page size");
> +        error_setg(errp, "Parameter 'xbzrle_cache_size' expects"
> +                         " a power of two no less than the target page s=
ize");
>          return false;
>      }
>=20=20
>      if (params->has_max_cpu_throttle &&
>          (params->max_cpu_throttle < params->cpu_throttle_initial ||
>           params->max_cpu_throttle > 99)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "max_cpu_throttle",
> -                   "an integer in the range of cpu_throttle_initial to 9=
9");
> +        error_setg(errp, "Parameter 'max_cpu_throttle' expects"
> +                         " an integer in the range of cpu_throttle_initi=
al to 99");
>          return false;
>      }
>=20=20
>      if (params->has_announce_initial &&
>          params->announce_initial > 100000) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "announce_initial",
> -                   "a value between 0 and 100000");
> +        error_setg(errp, "Parameter 'announce_initial' expects"
> +                         " a value between 0 and 100000");
>          return false;
>      }

Yet another "not your patch's fault": migration.json declares
@announce-initial as 'size', even though it's a time.  The other
@announce-FOO are similarly wrong.

>      if (params->has_announce_max &&
>          params->announce_max > 100000) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "announce_max",
> -                   "a value between 0 and 100000");
> +        error_setg(errp, "Parameter 'announce_max' expects"
> +                         " a value between 0 and 100000");
>         return false;
>      }
>      if (params->has_announce_rounds &&
>          params->announce_rounds > 1000) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "announce_rounds",
> -                   "a value between 0 and 1000");
> +        error_setg(errp, "Parameter 'announce_rounds' expects"
> +                         " a value between 0 and 1000");
>         return false;
>      }
>      if (params->has_announce_step &&
>          (params->announce_step < 1 ||
>          params->announce_step > 10000)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "announce_step",
> -                   "a value between 0 and 10000");
> +        error_setg(errp, "Parameter 'announce_step' expects"
> +                         " a value between 0 and 10000");
>         return false;
>      }
>=20=20
> @@ -1155,9 +1142,8 @@ bool migrate_params_check(MigrationParameters *para=
ms, Error **errp)
>      if (params->has_x_vcpu_dirty_limit_period &&
>          (params->x_vcpu_dirty_limit_period < 1 ||
>           params->x_vcpu_dirty_limit_period > 1000)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "x-vcpu-dirty-limit-period",
> -                   "a value between 1 and 1000");
> +        error_setg(errp, "Parameter 'x-vcpu-dirty-limit-period' expects"
> +                         " a value between 1 and 1000");
>          return false;
>      }
>=20=20
> diff --git a/migration/page_cache.c b/migration/page_cache.c
> index 6d4f7a9bbc..d430ce742b 100644
> --- a/migration/page_cache.c
> +++ b/migration/page_cache.c
> @@ -45,15 +45,15 @@ PageCache *cache_init(uint64_t new_size, size_t page_=
size, Error **errp)
>      PageCache *cache;
>=20=20
>      if (new_size < page_size) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
> -                   "is smaller than one target page size");

The parameter name is obviously wrong: it contains a space.

So let's see where it comes from.  Callers:

* qmp_migrate_set_parameters() via migrate_params_apply() and
  xbzrle_cache_resize()

  qmp_migrate_set_parameters() receives its parameters in a
  MigrationParameters struct, and passes them to migrate_params_apply().
  That one passes the value of parameter "xbzrle-cache-size" via
  xbzrle_cache_resize() to cache_init().

  xbzrle_cache_resize() is wrong the same way, visible below.

  Correct text for this call chain: "parameter 'xbzrle-cache-size'".

* ram_save_setup() via ram_init_all() via xbzrle_init()

  xbzrle_init() passes the value of migrate_xbzrle_cache_size(), which
  returns value of migration parameter "xbzrle-cache-size".

  This seems to run early in migration.  Wrong place for basic
  configuration sanity checking.  Redundant with he check above?

  Correct text for this call chain: "migration parameter
  'xbzrle-cache-size'.

* qemu_plugin_install() via caches_init(), both in
  contrib/plugins/cache.c

  qemu_plugin_install() appears to parse a command line argument.  Yet
  another ad hoc parser.  The cache sizes come from dblksize=3D...,
  iblksize=3D..., and l2blksize=3D...

  Correct text for this call chain would use these names.

Yuck!

> +        error_setg(errp,
> +                   "Parameter 'cache size' expects is smaller than one t=
arget page size");
>          return NULL;
>      }
>=20=20
>      /* round down to the nearest power of 2 */
>      if (!is_power_of_2(num_pages)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
> -                   "is not a power of two number of pages");

Likewise.

> +        error_setg(errp,
> +                   "Parameter 'cache size' expects is not a power of two=
 number of pages");
>          return NULL;
>      }
>=20=20
> diff --git a/migration/ram.c b/migration/ram.c
> index e4bfd39f08..0a4a0d7a0e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -165,8 +165,8 @@ int xbzrle_cache_resize(uint64_t new_size, Error **er=
rp)
>=20=20
>      /* Check for truncation */
>      if (new_size !=3D (size_t)new_size) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
> -                   "exceeding address space");

Same crap, as mentioned above.

Correct text: "parameter 'xbzrle-cache-size'".

> +        error_setg(errp,
> +                   "Parameter 'cache size' expects exceeding address spa=
ce");
>          return -1;
>      }
>=20=20
> diff --git a/monitor/fds.c b/monitor/fds.c
> index d86c2c674c..17e9c126e3 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -67,8 +67,8 @@ static bool monitor_add_fd(Monitor *mon, int fd, const =
char *fdname, Error **err
>=20=20
>      if (qemu_isdigit(fdname[0])) {
>          close(fd);
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdname",

> -                   "a name not starting with a digit");
> +        error_setg(errp,
> +                   "Parameter 'fdname' expects a name not starting with =
a digit");
>          return false;
>      }
>=20=20
> @@ -353,8 +353,8 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdse=
t_id, int64_t fdset_id,
>=20=20
>          if (has_fdset_id) {
>              if (fdset_id < 0) {
> -                error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdset-id=
",
> -                           "a non-negative value");
> +                error_setg(errp,
> +                           "Parameter 'fdset-id' expects a non-negative =
value");
>                  return NULL;
>              }
>              /* Use specified fdset ID */
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index b0f948d337..2d2e71b867 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -173,8 +173,7 @@ char *qmp_human_monitor_command(const char *command_l=
ine, bool has_cpu_index,
>      if (has_cpu_index) {
>          int ret =3D monitor_set_cpu(&hmp.common, cpu_index);
>          if (ret < 0) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
> -                       "a CPU number");
> +            error_setg(errp, "Parameter 'cpu-index' expects a CPU number=
");
>              goto out;
>          }
>      }
> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
> index 283dc9cbe6..071029a6c7 100644
> --- a/net/filter-buffer.c
> +++ b/net/filter-buffer.c
> @@ -121,8 +121,7 @@ static void filter_buffer_setup(NetFilterState *nf, E=
rror **errp)
>       * or COLO use this filter to release packets on demand.
>       */
>      if (!s->interval) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "interval",
> -                   "a non-zero interval");

Misuse of QERR_INVALID_PARAMETER_VALUE.

This function is interface UserCreatableClass method complete(), which
runs right after an object with this interface was created.
"Parameters" need not exist in this context.

The error is about the value of property "interval".  So let's report
that: "property 'interval' requires a non-zero value".


> +        error_setg(errp, "Parameter 'interval' expects a non-zero interv=
al");
>          return;
>      }
>=20=20
> diff --git a/net/filter.c b/net/filter.c
> index 3335908771..1621513bab 100644
> --- a/net/filter.c
> +++ b/net/filter.c
> @@ -232,8 +232,7 @@ static void netfilter_complete(UserCreatable *uc, Err=
or **errp)
>                                            NET_CLIENT_DRIVER_NIC,
>                                            MAX_QUEUE_NUM);
>      if (queues < 1) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "netdev",
> -                   "a network backend id");

Likewise, property "netdev".

> +        error_setg(errp, "Parameter 'netdev' expects a network backend i=
d");
>          return;
>      } else if (queues > 1) {
>          error_setg(errp, "multiqueue is not supported");
> @@ -251,8 +250,8 @@ static void netfilter_complete(UserCreatable *uc, Err=
or **errp)
>          char *position_id;
>=20=20
>          if (!g_str_has_prefix(nf->position, "id=3D")) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "position",
> -                       "'head', 'tail' or 'id=3D<id>'");

Likewise, property "position".

The parsing should be done in the property setter
netfilter_set_position() instead.

> +            error_setg(errp,
> +                       "Parameter 'position' expects 'head', 'tail' or '=
id=3D<id>'");
>              return;
>          }
>=20=20
> diff --git a/net/net.c b/net/net.c
> index 1c0bfdaa6c..5cdbd9c218 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1236,8 +1236,8 @@ static int net_client_init(QemuOpts *opts, bool is_=
netdev, Error **errp)
>=20=20
>          substrings =3D g_strsplit(ip6_net, "/", 2);
>          if (!substrings || !substrings[0]) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "ipv6-net",
> -                       "a valid IPv6 prefix");
> +            error_setg(errp,
> +                       "Parameter 'ipv6-net' expects a valid IPv6 prefix=
");
>              goto out;
>          }
>=20=20
> @@ -1247,8 +1247,7 @@ static int net_client_init(QemuOpts *opts, bool is_=
netdev, Error **errp)
           prefix_addr =3D substrings[0];

           /* Handle user-specified prefix length. */
>          if (substrings[1] &&
>              qemu_strtoul(substrings[1], NULL, 10, &prefix_len))
>          {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                       "ipv6-prefixlen", "a number");

Wrong.  We're still checking parameter "ipv6-net".  The part after '/'.

> +            error_setg(errp, "Parameter 'ipv6-prefixlen' expects a numbe=
r");
>              goto out;
>          }
>=20=20
> @@ -1283,7 +1282,7 @@ void netdev_add(QemuOpts *opts, Error **errp)
>  void qmp_netdev_add(Netdev *netdev, Error **errp)
>  {
>      if (!id_wellformed(netdev->id)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identif=
ier");
> +        error_setg(errp, "Parameter 'id' expects an identifier");
>          return;
>      }
>=20=20
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6beae659b7..946dbafbb6 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -328,8 +328,8 @@ void qmp_guest_shutdown(const char *mode, Error **err=
p)
>      } else if (strcmp(mode, "reboot") =3D=3D 0) {
>          shutdown_flag |=3D EWX_REBOOT;
>      } else {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "mode",
> -                   "'halt', 'powerdown', or 'reboot'");

Correct, but the parameter should be an enum, and then we wouldn't neet
this.

> +        error_setg(errp,
> +                   "Parameter 'mode' expects 'halt', 'powerdown', or 're=
boot'");
>          return;
>      }
>=20=20
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 7d31589b04..be04b2c5ab 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -84,7 +84,7 @@ Object *user_creatable_add_type(const char *type, const=
 char *id,
>      Error *local_err =3D NULL;
>=20=20
>      if (id !=3D NULL && !id_wellformed(id)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identif=
ier");
> +        error_setg(errp, "Parameter 'id' expects an identifier");
>          error_append_hint(errp, "Identifiers consist of letters, digits,=
 "
>                            "'-', '.', '_', starting with a letter.\n");
>          return NULL;
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 7c087299de..3d014f1bea 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -136,8 +136,8 @@ ObjectPropertyInfoList *qmp_device_list_properties(co=
nst char *typename,
>=20=20
>      if (!object_class_dynamic_cast(klass, TYPE_DEVICE)
>          || object_class_is_abstract(klass)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
> -                   "a non-abstract device type");
> +        error_setg(errp,
> +                   "Parameter 'typename' expects a non-abstract device t=
ype");
>          return NULL;
>      }
>=20=20
> @@ -194,8 +194,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const=
 char *typename,
>      }
>=20=20
>      if (!object_class_dynamic_cast(klass, TYPE_OBJECT)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
> -                   "a QOM type");
> +        error_setg(errp, "Parameter 'typename' expects a QOM type");
>          return NULL;
>      }
>=20=20
> diff --git a/softmmu/balloon.c b/softmmu/balloon.c
> index e0e8969a4b..d941c6b9c1 100644
> --- a/softmmu/balloon.c
> +++ b/softmmu/balloon.c
> @@ -97,7 +97,7 @@ void qmp_balloon(int64_t target, Error **errp)
>      }
>=20=20
>      if (target <=3D 0) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "target", "a size=
");

Wrong.  The parameter is named "value" in the schema.

> +        error_setg(errp, "Parameter 'target' expects a size");
>          return;
>      }
>=20=20
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index 0848e0dbdb..7fc70f9166 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -753,8 +753,7 @@ void qmp_memsave(int64_t addr, int64_t size, const ch=
ar *filename,
>=20=20
>      cpu =3D qemu_get_cpu(cpu_index);
>      if (cpu =3D=3D NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
> -                   "a CPU number");
> +        error_setg(errp, "Parameter 'cpu-index' expects a CPU number");
>          return;
>      }
>=20=20
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index a964bd80df..b17aec4357 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -246,16 +246,15 @@ static DeviceClass *qdev_get_device_class(const cha=
r **driver, Error **errp)
>      }
>=20=20
>      if (object_class_is_abstract(oc)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> -                   "a non-abstract device type");
> +        error_setg(errp,
> +                   "Parameter 'driver' expects a non-abstract device typ=
e");
>          return NULL;
>      }
>=20=20
>      dc =3D DEVICE_CLASS(oc);
>      if (!dc->user_creatable ||
>          (phase_check(PHASE_MACHINE_READY) && !dc->hotpluggable)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> -                   "a pluggable device type");
> +        error_setg(errp, "Parameter 'driver' expects a pluggable device =
type");
>          return NULL;
>      }
>=20=20
> @@ -263,8 +262,8 @@ static DeviceClass *qdev_get_device_class(const char =
**driver, Error **errp)
>          /* sysbus devices need to be allowed by the machine */
>          MachineClass *mc =3D MACHINE_CLASS(object_get_class(qdev_get_mac=
hine()));
>          if (!device_type_is_dynamic_sysbus(mc, *driver)) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> -                       "a dynamic sysbus device type for the machine");
> +            error_setg(errp,
> +                       "Parameter 'driver' expects a dynamic sysbus devi=
ce type for the machine");
>              return NULL;
>          }
>      }
> diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
> index 41ca0100e7..a95fd35948 100644
> --- a/ui/ui-qmp-cmds.c
> +++ b/ui/ui-qmp-cmds.c
> @@ -209,7 +209,7 @@ void qmp_client_migrate_info(const char *protocol, co=
nst char *hostname,
>          return;
>      }
>=20=20
> -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "'spice'"=
);
> +    error_setg(errp, "Parameter 'protocol' expects 'spice'");
>  }
>=20=20
>  #ifdef CONFIG_PNG
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 201f7a87f3..62dd80a5ae 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -622,8 +622,7 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const =
char *id,
>      } else if (id) {
>          assert(fail_if_exists);
>          if (!id_wellformed(id)) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id",
> -                       "an identifier");
> +            error_setg(errp, "Parameter 'id' expects an identifier");
>              error_append_hint(errp, "Identifiers consist of letters, dig=
its, "
>                                "'-', '.', '_', starting with a letter.\n"=
);
>              return NULL;


