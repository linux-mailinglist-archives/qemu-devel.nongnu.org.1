Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318A7D100E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp5I-0002gI-Fv; Fri, 20 Oct 2023 08:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtp5C-0002W2-5o
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtp59-0003rw-3f
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697806704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXghwWv3QXVcdOx0i/WltiklwiivciUsz/p0G2sNNuo=;
 b=U4URwuOwuaBvOrXM9+yUB2P+Emg5tEGXevLrj6OPYWUV7Qj9HdmSegmzPttBnWTIPE0tTO
 YOk4P3mRWPnJ/PcwHnnmJzedASBJwx8QiHJYKlTkMwjNiwMz/XGrSEDfG3lm7OZxqR6spm
 lc7zcWtb0f3Ey+1IsvtWMICiMsqTVoE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-PbBSns5hNDKGkkOLIBzkBg-1; Fri, 20 Oct 2023 08:58:20 -0400
X-MC-Unique: PbBSns5hNDKGkkOLIBzkBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD2D868005;
 Fri, 20 Oct 2023 12:58:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED8C41C060AE;
 Fri, 20 Oct 2023 12:58:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E35E321E6A1F; Fri, 20 Oct 2023 14:58:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org,  Stefan Berger
 <stefanb@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 integration@gluster.org
Subject: Re: [PATCH v2 16/22] qapi: Inline QERR_MISSING_PARAMETER definition
 (constant parameter)
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-17-philmd@linaro.org>
Date: Fri, 20 Oct 2023 14:58:18 +0200
In-Reply-To: <20231005045041.52649-17-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:33
 +0200")
Message-ID: <87fs251mdx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Mechanical transformation using the following
> coccinelle semantic patches:
>
>     @match@
>     expression errp;
>     constant param;
>     @@
>          error_setg(errp, QERR_MISSING_PARAMETER, param);
>
>     @script:python strformat depends on match@
>     param << match.param;
>     fixedfmt; // new var
>     @@
>     if param[0] =3D=3D '"': # Format skipping '"',
>         fixedfmt =3D f'"Parameter \'{param[1:-1]}\' is missing"'
>     else: # or use definition.
>         fixedfmt =3D f'"Parameter " {param} " is missing"'
>     coccinelle.fixedfmt =3D cocci.make_ident(fixedfmt)
>
>     @replace@
>     expression match.errp;
>     constant match.param;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_setg(errp, QERR_MISSING_PARAMETER, param);
>     +    error_setg(errp, fixedfmt);
>
> and:
>
>     @match@
>     constant param;
>     @@
>          error_report(QERR_MISSING_PARAMETER, param);
>
>     @script:python strformat depends on match@
>     param << match.param;
>     fixedfmt; // new var
>     @@
>     fixedfmt =3D f'"Parameter \'{param[1:-1]}\' is missing"'
>     coccinelle.fixedfmt =3D cocci.make_ident(fixedfmt)
>
>     @replace@
>     constant match.param;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_report(QERR_MISSING_PARAMETER, param);
>     +    error_report(fixedfmt);
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  backends/dbus-vmstate.c        |  2 +-
>  block/gluster.c                | 21 +++++++++++----------
>  block/monitor/block-hmp-cmds.c |  6 +++---
>  dump/dump.c                    |  4 ++--
>  hw/usb/redirect.c              |  2 +-
>  softmmu/qdev-monitor.c         |  2 +-
>  softmmu/tpm.c                  |  4 ++--
>  softmmu/vl.c                   |  4 ++--
>  ui/input-barrier.c             |  2 +-
>  ui/ui-qmp-cmds.c               |  2 +-
>  10 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
> index 57369ec0f2..e781ded17c 100644
> --- a/backends/dbus-vmstate.c
> +++ b/backends/dbus-vmstate.c
> @@ -413,7 +413,7 @@ dbus_vmstate_complete(UserCreatable *uc, Error **errp)
>      }
>=20=20
>      if (!self->dbus_addr) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "addr");

Misuse of QERR_MISSING_PARAMETER.

This function is interface UserCreatableClass method complete(), which
runs right after an object with this interface was created.
"Parameters" need not exist in this context.

The actual issue is property "addr" has not been set.  So let's report
that: "property 'addr' is required".

Separate patch, to keep this one mechanical.

> +        error_setg(errp, "Parameter 'addr' is missing");
>          return;
>      }
>=20=20
> diff --git a/block/gluster.c b/block/gluster.c
> index ad5fadbe79..8d97d698c3 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -530,20 +530,20 @@ static int qemu_gluster_parse_json(BlockdevOptionsG=
luster *gconf,
>=20=20
>      num_servers =3D qdict_array_entries(options, GLUSTER_OPT_SERVER_PATT=
ERN);
>      if (num_servers < 1) {
> -        error_setg(&local_err, QERR_MISSING_PARAMETER, "server");
> +        error_setg(&local_err, "Parameter 'server' is missing");
>          goto out;
>      }
>=20=20
>      ptr =3D qemu_opt_get(opts, GLUSTER_OPT_VOLUME);
>      if (!ptr) {
> -        error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_VOLUM=
E);
> +        error_setg(&local_err, "Parameter " GLUSTER_OPT_VOLUME " is miss=
ing");
>          goto out;
>      }
>      gconf->volume =3D g_strdup(ptr);
>=20=20
>      ptr =3D qemu_opt_get(opts, GLUSTER_OPT_PATH);
>      if (!ptr) {
> -        error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_PATH);
> +        error_setg(&local_err, "Parameter " GLUSTER_OPT_PATH " is missin=
g");
>          goto out;
>      }
>      gconf->path =3D g_strdup(ptr);
> @@ -562,7 +562,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
>=20=20
>          ptr =3D qemu_opt_get(opts, GLUSTER_OPT_TYPE);
>          if (!ptr) {
> -            error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_T=
YPE);
> +            error_setg(&local_err,
> +                       "Parameter " GLUSTER_OPT_TYPE " is missing");
>              error_append_hint(&local_err, GERR_INDEX_HINT, i);
>              goto out;
>=20=20
> @@ -592,16 +593,16 @@ static int qemu_gluster_parse_json(BlockdevOptionsG=
luster *gconf,
>=20=20
>              ptr =3D qemu_opt_get(opts, GLUSTER_OPT_HOST);
>              if (!ptr) {
> -                error_setg(&local_err, QERR_MISSING_PARAMETER,
> -                           GLUSTER_OPT_HOST);
> +                error_setg(&local_err,
> +                           "Parameter " GLUSTER_OPT_HOST " is missing");
>                  error_append_hint(&local_err, GERR_INDEX_HINT, i);
>                  goto out;
>              }
>              gsconf->u.inet.host =3D g_strdup(ptr);
>              ptr =3D qemu_opt_get(opts, GLUSTER_OPT_PORT);
>              if (!ptr) {
> -                error_setg(&local_err, QERR_MISSING_PARAMETER,
> -                           GLUSTER_OPT_PORT);
> +                error_setg(&local_err,
> +                           "Parameter " GLUSTER_OPT_PORT " is missing");
>                  error_append_hint(&local_err, GERR_INDEX_HINT, i);
>                  goto out;
>              }
> @@ -648,8 +649,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
>                  goto out;
>              }
>              if (!ptr) {
> -                error_setg(&local_err, QERR_MISSING_PARAMETER,
> -                           GLUSTER_OPT_PATH);
> +                error_setg(&local_err,
> +                           "Parameter " GLUSTER_OPT_PATH " is missing");
>                  error_append_hint(&local_err, GERR_INDEX_HINT, i);
>                  goto out;
>              }

I suspect pretty much everything you patch in this file is bad, but I'm
running out of steam.

> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index ca2599de44..90e593ed38 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -252,7 +252,7 @@ void hmp_drive_mirror(Monitor *mon, const QDict *qdic=
t)
>      };
>=20=20
>      if (!filename) {
> -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> +        error_setg(&err, "Parameter 'target' is missing");
>          goto end;
>      }
>      qmp_drive_mirror(&mirror, &err);
> @@ -281,7 +281,7 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdic=
t)
>      };
>=20=20
>      if (!filename) {
> -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> +        error_setg(&err, "Parameter 'target' is missing");
>          goto end;
>      }
>=20=20
> @@ -356,7 +356,7 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *q=
dict)
>           * In the future, if 'snapshot-file' is not specified, the snaps=
hot
>           * will be taken internally. Today it's actually required.
>           */
> -        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
> +        error_setg(&err, "Parameter 'snapshot-file' is missing");
>          goto end;
>      }
>=20=20
> diff --git a/dump/dump.c b/dump/dump.c
> index e173f1f14c..642b952985 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2096,11 +2096,11 @@ void qmp_dump_guest_memory(bool paging, const cha=
r *file,
>          return;
>      }
>      if (has_begin && !has_length) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "length");
> +        error_setg(errp, "Parameter 'length' is missing");
>          return;
>      }
>      if (!has_begin && has_length) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "begin");
> +        error_setg(errp, "Parameter 'begin' is missing");
>          return;
>      }
>      if (has_detach) {
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index ac6fa34ad1..83bfc9dc19 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1426,7 +1426,7 @@ static void usbredir_realize(USBDevice *udev, Error=
 **errp)
>      int i;
>=20=20
>      if (!qemu_chr_fe_backend_connected(&dev->cs)) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "chardev");

Misuse of QERR_MISSING_PARAMETER.

This is a realize() method.  "Parameters" need not exist in this
context.

The actual issue is property "chardev" has not been set.  So let's
report that: "property 'filename' is required".

Separate patch, to keep this one mechanical.  Not mentioning this again
from now on.

> +        error_setg(errp, "Parameter 'chardev' is missing");
>          return;
>      }
>=20=20
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index b17aec4357..b7b2bf18d4 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -622,7 +622,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *=
opts,
>=20=20
>      driver =3D qdict_get_try_str(opts, "driver");
>      if (!driver) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "driver");
> +        error_setg(errp, "Parameter 'driver' is missing");
>          return NULL;
>      }
>=20=20
> diff --git a/softmmu/tpm.c b/softmmu/tpm.c
> index 8437c4efc3..3a7d4b5c67 100644
> --- a/softmmu/tpm.c
> +++ b/softmmu/tpm.c
> @@ -106,13 +106,13 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *o=
pts, Error **errp)
>=20=20
>      id =3D qemu_opts_id(opts);
>      if (id =3D=3D NULL) {
> -        error_report(QERR_MISSING_PARAMETER, "id");
> +        error_report("Parameter 'id' is missing");
>          return 1;
>      }
>=20=20
>      value =3D qemu_opt_get(opts, "type");
>      if (!value) {
> -        error_report(QERR_MISSING_PARAMETER, "type");
> +        error_report("Parameter 'type' is missing");
>          tpm_display_backend_drivers();
>          return 1;
>      }
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 98e071e63b..840ac84069 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1801,7 +1801,7 @@ static void object_option_parse(const char *optarg)
>=20=20
>          type =3D qemu_opt_get(opts, "qom-type");
>          if (!type) {
> -            error_setg(&error_fatal, QERR_MISSING_PARAMETER, "qom-type");
> +            error_setg(&error_fatal, "Parameter 'qom-type' is missing");
>          }
>          if (user_creatable_print_help(type, opts)) {
>              exit(0);
> @@ -2266,7 +2266,7 @@ static int do_configure_accelerator(void *opaque, Q=
emuOpts *opts, Error **errp)
>      bool qtest_with_kvm;
>=20=20
>      if (!acc) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "accel");
> +        error_setg(errp, "Parameter 'accel' is missing");
>          goto bad;
>      }
>=20=20
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> index 2d57ca7079..ecbba4adc2 100644
> --- a/ui/input-barrier.c
> +++ b/ui/input-barrier.c
> @@ -493,7 +493,7 @@ static void input_barrier_complete(UserCreatable *uc,=
 Error **errp)
>      Error *local_err =3D NULL;
>=20=20
>      if (!ib->name) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "name");

Misuse of QERR_MISSING_PARAMETER.

This function is interface UserCreatableClass method complete(), which
runs right after an object with this interface was created.
"Parameters" need not exist in this context.

The actual issue is property "name" has not been set.  So let's report
that: "property 'name' is required".

> +        error_setg(errp, "Parameter 'name' is missing");
>          return;
>      }
>=20=20
> diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
> index a95fd35948..0e350fc333 100644
> --- a/ui/ui-qmp-cmds.c
> +++ b/ui/ui-qmp-cmds.c
> @@ -195,7 +195,7 @@ void qmp_client_migrate_info(const char *protocol, co=
nst char *hostname,
>          }
>=20=20
>          if (!has_port && !has_tls_port) {
> -            error_setg(errp, QERR_MISSING_PARAMETER, "port/tls-port");

Bad error message.  The actual issue is both "port" and "tls-port" are
missing, but we need at least one.  So let's report that: "parameter
'port' or 'tls-port' is required".

> +            error_setg(errp, "Parameter 'port/tls-port' is missing");
>              return;
>          }


