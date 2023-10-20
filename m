Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B467D0945
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjkW-0000lm-8M; Fri, 20 Oct 2023 03:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtjkG-0000Pu-Gz
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtjkD-0002Rx-R1
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697786189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gA9kSnR9GDB57XSmXZ5+TPxYkjZnexghC7rSOqfT2xI=;
 b=gdb5QJWgI9YtGBlvFkEqYjHhNxAJ9YrwAIPyM52zX4lhc6cviwfjCHuv1E1Ad1XEPJ2yA8
 XhrpdRdGPVT5vwdHm4buKj7QGJmjwaJvCLvNeY1TxI8U6lQaeHVjYImCr/u3OMDh+7taou
 eqADoKa+GHpYK7k5aDnmducbSfDYpKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-dZhrgmaFN5a7ZUa8iBhhgw-1; Fri, 20 Oct 2023 03:16:22 -0400
X-MC-Unique: dZhrgmaFN5a7ZUa8iBhhgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF6C010201F4;
 Fri, 20 Oct 2023 07:16:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6558F2026D4C;
 Fri, 20 Oct 2023 07:16:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 657EF21E6A1F; Fri, 20 Oct 2023 09:16:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 06/22] qapi: Inline and remove QERR_INVALID_PARAMETER
 definition
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-7-philmd@linaro.org>
Date: Fri, 20 Oct 2023 09:16:20 +0200
In-Reply-To: <20231005045041.52649-7-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:23
 +0200")
Message-ID: <87r0lp9323.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
> Mechanical transformation using:
>
>   $ sed -i -e "s/QERR_INVALID_PARAMETER,/\"Invalid parameter '%s'\",/" \
>     $(git grep -lw QERR_INVALID_PARAMETER)
>
> then manually removing the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  monitor/hmp-cmds.c        | 2 +-
>  qapi/opts-visitor.c       | 2 +-
>  util/qemu-option.c        | 8 ++++----
>  4 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index e93211085a..63ab775dc5 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -17,9 +17,6 @@
>   * add new ones!
>   */
>=20=20
> -#define QERR_INVALID_PARAMETER \
> -    "Invalid parameter '%s'"
> -
>  #define QERR_INVALID_PARAMETER_TYPE \
>      "Invalid parameter type for '%s', expected: %s"
>=20=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 6c559b48c8..9d6533643d 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -138,7 +138,7 @@ void hmp_sync_profile(Monitor *mon, const QDict *qdic=
t)
       const char *op =3D qdict_get_try_str(qdict, "op");

       if (op =3D=3D NULL) {
           bool on =3D qsp_is_enabled();

           monitor_printf(mon, "sync-profile is %s\n", on ? "on" : "off");
           return;
       }
       if (!strcmp(op, "on")) {
           qsp_enable();
       } else if (!strcmp(op, "off")) {
           qsp_disable();
       } else if (!strcmp(op, "reset")) {
           qsp_reset();
>      } else {
>          Error *err =3D NULL;
>=20=20
> -        error_setg(&err, QERR_INVALID_PARAMETER, op);

The use of QERR_INVALID_PARAMETER is wrong: (1) it takes a parameter
name, but we pass a parameter value, and (2) parameter @op is valid, its
value isn't.

> +        error_setg(&err, "Invalid parameter '%s'", op);
>          hmp_handle_error(mon, err);
>      }
>  }
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 8f1efab8b9..3d1a28b419 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -184,7 +184,7 @@ opts_check_struct(Visitor *v, Error **errp)
>          const QemuOpt *first;
>=20=20
>          first =3D g_queue_peek_head(any);
> -        error_setg(errp, QERR_INVALID_PARAMETER, first->name);
> +        error_setg(errp, "Invalid parameter '%s'", first->name);
>          return false;
>      }
>      return true;
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index fb391a7904..201f7a87f3 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -498,7 +498,7 @@ static bool opt_validate(QemuOpt *opt, Error **errp)
>=20=20
>      desc =3D find_desc_by_name(list->desc, opt->name);
>      if (!desc && !opts_accepts_any(list)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
> +        error_setg(errp, "Invalid parameter '%s'", opt->name);
>          return false;
>      }
>=20=20
> @@ -531,7 +531,7 @@ bool qemu_opt_set_bool(QemuOpts *opts, const char *na=
me, bool val,
>=20=20
>      desc =3D find_desc_by_name(list->desc, name);
>      if (!desc && !opts_accepts_any(list)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, name);
> +        error_setg(errp, "Invalid parameter '%s'", name);
>          return false;
>      }
>=20=20
> @@ -554,7 +554,7 @@ bool qemu_opt_set_number(QemuOpts *opts, const char *=
name, int64_t val,
>=20=20
>      desc =3D find_desc_by_name(list->desc, name);
>      if (!desc && !opts_accepts_any(list)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, name);
> +        error_setg(errp, "Invalid parameter '%s'", name);
>          return false;
>      }
>=20=20
> @@ -1103,7 +1103,7 @@ bool qemu_opts_validate(QemuOpts *opts, const QemuO=
ptDesc *desc, Error **errp)
>      QTAILQ_FOREACH(opt, &opts->head, next) {
>          opt->desc =3D find_desc_by_name(desc, opt->name);
>          if (!opt->desc) {
> -            error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
> +            error_setg(errp, "Invalid parameter '%s'", opt->name);
>              return false;
>          }


