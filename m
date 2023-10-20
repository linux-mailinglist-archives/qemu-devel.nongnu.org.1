Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172AC7D0932
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjbW-00061q-34; Fri, 20 Oct 2023 03:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtjbS-0005vd-Su
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtjbQ-0007Pk-4K
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+X1X23/j5k8VGC3vFkIbGpmAoc7eq74NMIQkI8czSc=;
 b=TVJQoH+y31/1kuLDnNVxDbK5SNLWyeISxJiGbU3VITytaKsc3BxGFzNgkk0UKcfvTjjlre
 yDLPWn95rjoxnnjoYspfDuR657B73opNh7NrrLbfYae9GjmGPLEjM3T+ORlAiyqtl5om8z
 J92cpFim9jJ/ObTDyR/H/oNPh0Oki8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-HLgIQa_6NtKFG9USj4-tkA-1; Fri, 20 Oct 2023 03:07:14 -0400
X-MC-Unique: HLgIQa_6NtKFG9USj4-tkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93000185A78E;
 Fri, 20 Oct 2023 07:07:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53DD01C060AE;
 Fri, 20 Oct 2023 07:07:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 482CA21E6A1F; Fri, 20 Oct 2023 09:07:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>
Subject: Re: [PATCH v2 05/22] qapi: Inline QERR_INVALID_PARAMETER definition
 (constant parameter)
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-6-philmd@linaro.org>
Date: Fri, 20 Oct 2023 09:07:12 +0200
In-Reply-To: <20231005045041.52649-6-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:22
 +0200")
Message-ID: <87y1fx93hb.fsf@pond.sub.org>
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
> coccinelle semantic patch:
>
>     @match@
>     expression errp;
>     constant param;
>     @@
>          error_setg(errp, QERR_INVALID_PARAMETER, param);
>
>     @script:python strformat depends on match@
>     param << match.param;
>     fixedfmt; // new var
>     @@
>     fixedfmt =3D f'"Invalid parameter \'{param[1:-1]}\'"' # Format skippi=
ng '"'.
>     coccinelle.fixedfmt =3D cocci.make_ident(fixedfmt)
>
>     @replace@
>     expression match.errp;
>     constant match.param;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_setg(errp, QERR_INVALID_PARAMETER, param);
>     +    error_setg(errp, fixedfmt);
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  dump/dump.c        | 6 +++---
>  qga/commands.c     | 2 +-
>  ui/ui-qmp-cmds.c   | 2 +-
>  util/qemu-option.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index d4ef713cd0..e173f1f14c 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1810,7 +1810,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
>=20=20
>      s->fd =3D fd;
>      if (has_filter && !length) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, "length");

Incorrect use of QERR_INVALID_PARAMETER: the parameter is perfectly
valid, the problem is its invalid value.  Better:

           error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "a non-zero size"=
);

> +        error_setg(errp, "Invalid parameter 'length'");

Applying PATCH 12's transformation then results in

           error_setg(errp, "Parameter '%s' expects a non-zero size",
                      "length");

which you may want to contract to

           error_setg(errp, "Parameter 'length' expects a non-zero size");

But not in this patch.  Either before or after.  I'd pick before.

>          goto cleanup;
>      }
>      s->filter_area_begin =3D begin;
> @@ -1841,7 +1841,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
>=20=20
>      /* Is the filter filtering everything? */
>      if (validate_start_block(s) =3D=3D -1) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, "begin");
> +        error_setg(errp, "Invalid parameter 'begin'");
>          goto cleanup;
>      }
>=20=20
> @@ -2145,7 +2145,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*file,
   #if !defined(WIN32)
       if (strstart(file, "fd:", &p)) {
           fd =3D monitor_get_fd(monitor_cur(), p, errp);
           if (fd =3D=3D -1) {
               return;
           }
       }
   #endif

       if  (strstart(file, "file:", &p)) {
           fd =3D qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,=
 S_IRUSR);
           if (fd < 0) {
               error_setg_file_open(errp, errno, p);
               return;
           }
>      }
>=20=20
>      if (fd =3D=3D -1) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, "protocol");

This made me go "there is no parameter protocol", but then I
double-checked the schema, and realized there is.  It's just named @file
here.  We should rename it to match the schema.

Again, the use of QERR_INVALID_PARAMETER is wrong: @protocol is valid,
its value isn't.

More: we should use qemu_create() instead of qemu_open_old(), to not
throw away qemu_open_internal()'s error.


> +        error_setg(errp, "Invalid parameter 'protocol'");
>          return;
>      }
>=20=20
> diff --git a/qga/commands.c b/qga/commands.c
> index 09c683e263..871210ab0b 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -154,7 +154,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, E=
rror **errp)
>=20=20
>      gei =3D guest_exec_info_find(pid);
>      if (gei =3D=3D NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, "pid");

Again, the use of QERR_INVALID_PARAMETER is wrong: @pid is valid, its
value isn't.

> +        error_setg(errp, "Invalid parameter 'pid'");
>          return NULL;
>      }
>=20=20
> diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
> index debc07d678..41ca0100e7 100644
> --- a/ui/ui-qmp-cmds.c
> +++ b/ui/ui-qmp-cmds.c
> @@ -44,7 +44,7 @@ void qmp_set_password(SetPasswordOptions *opts, Error *=
*errp)
>          assert(opts->protocol =3D=3D DISPLAY_PROTOCOL_VNC);
>          if (opts->connected !=3D SET_PASSWORD_ACTION_KEEP) {
>              /* vnc supports "connected=3Dkeep" only */
> -            error_setg(errp, QERR_INVALID_PARAMETER, "connected");

Same misuse of QERR_INVALID_PARAMETER.

> +            error_setg(errp, "Invalid parameter 'connected'");
>              return;
>          }
>          /*
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index eedd08929b..fb391a7904 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -612,7 +612,7 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const =
char *id,
>=20=20
>      if (list->merge_lists) {
>          if (id) {
> -            error_setg(errp, QERR_INVALID_PARAMETER, "id");

This one is correct.

> +            error_setg(errp, "Invalid parameter 'id'");
>              return NULL;
>          }
>          opts =3D qemu_opts_find(list, NULL);

Score: 1 out of 6 points :)

None of this is your patch's fault.


