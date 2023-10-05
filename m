Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D02587B9BF9
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoKD3-0000n8-8I; Thu, 05 Oct 2023 04:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoKD0-0000mK-Py
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoKCz-0003aq-1Z
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696496384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQ1lH6Tb6EfmTkUMHD79lpe0sUeMDs86V0+o3oVILBQ=;
 b=hbof/CZ10rO2pxSOHTExNYlZzfXWtF5dX2lBGLCwuhcraXrkqMfwfif0dZmUhmf5R2E8gy
 ZbKAxWtT6qTDT6sSZ9Ri/IwgB+9B56jEMq3gG+nzad9p4LdhUF5aLcMPPAqJu45i1qEaWD
 NvNNFyZ4cW5G14IMihR2zBPJQvC3mbc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-tdHXATKcNQyS7zsirrFaWQ-1; Thu, 05 Oct 2023 04:59:43 -0400
X-MC-Unique: tdHXATKcNQyS7zsirrFaWQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A57F7811E98;
 Thu,  5 Oct 2023 08:59:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E9E0492C37;
 Thu,  5 Oct 2023 08:59:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C9DF21E6904; Thu,  5 Oct 2023 10:59:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 14/16] softmmu/vl: Clean up global variable shadowing
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-15-philmd@linaro.org>
Date: Thu, 05 Oct 2023 10:59:41 +0200
In-Reply-To: <20231004120019.93101-15-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Oct 2023 14:00:17
 +0200")
Message-ID: <8734yp8mwy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

> Fix:
>
>   softmmu/vl.c:1069:44: error: declaration shadows a variable in the glob=
al scope [-Werror,-Wshadow]
>   static void parse_display_qapi(const char *optarg)
>                                              ^
>   softmmu/vl.c:1224:39: error: declaration shadows a variable in the glob=
al scope [-Werror,-Wshadow]
>   static void monitor_parse(const char *optarg, const char *mode, bool pr=
etty)
>                                         ^
>   softmmu/vl.c:1634:17: error: declaration shadows a variable in the glob=
al scope [-Werror,-Wshadow]
>       const char *optarg =3D qdict_get_try_str(qdict, "type");
>                   ^
>   softmmu/vl.c:1784:45: error: declaration shadows a variable in the glob=
al scope [-Werror,-Wshadow]
>   static void object_option_parse(const char *optarg)
>                                               ^
>   /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.=
h:77:14: note: previous declaration is here
>   extern char *optarg;                    /* getopt(3) external variables=
 */
>                ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

How much we care about the shadowing is unclear, but that doesn't matter
if the patches make sense even if we pretend global @optarg doesn't
exist.  Let's check that.

> ---
>  softmmu/vl.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 98e071e63b..ae1ff9887d 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1066,12 +1066,12 @@ static void select_vgahw(const MachineClass *mach=
ine_class, const char *p)
>      }
>  }
>=20=20
> -static void parse_display_qapi(const char *optarg)
> +static void parse_display_qapi(const char *optstr)
>  {
>      DisplayOptions *opts;
>      Visitor *v;
>=20=20
> -    v =3D qobject_input_visitor_new_str(optarg, "type", &error_fatal);
> +    v =3D qobject_input_visitor_new_str(optstr, "type", &error_fatal);
>=20=20
>      visit_type_DisplayOptions(v, NULL, &opts, &error_fatal);
>      QAPI_CLONE_MEMBERS(DisplayOptions, &dpy, opts);

The actual argument is a string that is either JSON or KEY=3DVALUE,...
The fact that it's always an option argument now (actually the value of
global @optarg) is irrelevant here.

parse_display_qapi() passes its parameter to
qobject_input_visitor_new_str() parameter @str, which passes it to
qobject_from_json() parameter @string if JSON, or else to keyval_parse()
parameter @params.

I'd rename @optarg to @str here, like you do in the next hunk, to not
suggest a connection to CLI.  Not a demand.

> @@ -1221,21 +1221,21 @@ static int mon_init_func(void *opaque, QemuOpts *=
opts, Error **errp)
>      return monitor_init_opts(opts, errp);
>  }
>=20=20
> -static void monitor_parse(const char *optarg, const char *mode, bool pre=
tty)
> +static void monitor_parse(const char *str, const char *mode, bool pretty)
>  {
>      static int monitor_device_index =3D 0;
>      QemuOpts *opts;
>      const char *p;
>      char label[32];
>=20=20
> -    if (strstart(optarg, "chardev:", &p)) {
> +    if (strstart(str, "chardev:", &p)) {
>          snprintf(label, sizeof(label), "%s", p);
>      } else {
>          snprintf(label, sizeof(label), "compat_monitor%d",
>                   monitor_device_index);
> -        opts =3D qemu_chr_parse_compat(label, optarg, true);
> +        opts =3D qemu_chr_parse_compat(label, str, true);
>          if (!opts) {
> -            error_report("parse error: %s", optarg);
> +            error_report("parse error: %s", str);
>              exit(1);
>          }
>      }

The actual argument is either @optarg or a string literal, but that's
again irrelevant here.

> @@ -1631,13 +1631,13 @@ static const QEMUOption *lookup_opt(int argc, cha=
r **argv,
>=20=20
>  static MachineClass *select_machine(QDict *qdict, Error **errp)
>  {
> -    const char *optarg =3D qdict_get_try_str(qdict, "type");
> +    const char *machine_type =3D qdict_get_try_str(qdict, "type");
>      GSList *machines =3D object_class_get_list(TYPE_MACHINE, false);
>      MachineClass *machine_class;
>      Error *local_err =3D NULL;
>=20=20
> -    if (optarg) {
> -        machine_class =3D find_machine(optarg, machines);
> +    if (machine_type) {
> +        machine_class =3D find_machine(machine_type, machines);
>          qdict_del(qdict, "type");
>          if (!machine_class) {
>              error_setg(&local_err, "unsupported machine type");

Obvious improvement.

> @@ -1781,20 +1781,20 @@ static void object_option_add_visitor(Visitor *v)
>      QTAILQ_INSERT_TAIL(&object_opts, opt, next);
>  }
>=20=20
> -static void object_option_parse(const char *optarg)
> +static void object_option_parse(const char *optstr)
>  {
>      QemuOpts *opts;
>      const char *type;
>      Visitor *v;
>=20=20
> -    if (optarg[0] =3D=3D '{') {
> -        QObject *obj =3D qobject_from_json(optarg, &error_fatal);
> +    if (optstr[0] =3D=3D '{') {
> +        QObject *obj =3D qobject_from_json(optstr, &error_fatal);
>=20=20
>          v =3D qobject_input_visitor_new(obj);
>          qobject_unref(obj);
>      } else {
>          opts =3D qemu_opts_parse_noisily(qemu_find_opts("object"),
> -                                       optarg, true);
> +                                       optstr, true);
>          if (!opts) {
>              exit(1);
>          }

Same argument as for parse_display_qapi(), and same suggestion.

If this goes though my tree, I can implement my two suggestions, if you
agree.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


