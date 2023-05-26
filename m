Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 448AC711FA1
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:09:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QcW-0003P9-A3; Fri, 26 May 2023 02:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2QcU-0003P1-Ev
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2QcS-0005uO-2j
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685081286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MWQhxFCRwhIwQGoDN1HqtuRjcYzy4cQtiubU3YUOrA=;
 b=ixD6759n09u14slLlc33ofR6e3M3UUcVvPeaO220d3RfNP5u3Ov2s7g8Ok/+lNWWAnOmPn
 s4ldJAZmyLPcQyrHzNXSWEIvFNKew6CdsA0QuQzE/LAJZjqgsMjeobm9VqZoj9U9yliGaP
 GOoW53HlpECsOGIXD2PdTXO0NhmoIPU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563--vbPOdqbNL67OgN7zUQ9Jg-1; Fri, 26 May 2023 02:08:01 -0400
X-MC-Unique: -vbPOdqbNL67OgN7zUQ9Jg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F5302811BC7;
 Fri, 26 May 2023 06:08:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8CAB40C6CCF;
 Fri, 26 May 2023 06:07:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4E9C21E692E; Fri, 26 May 2023 08:07:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dinah Baum <dinahbaum123@gmail.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/3] cpu, qdict, vl: Enable printing options for CPU
 type
References: <20230404011956.90375-1-dinahbaum123@gmail.com>
 <20230404011956.90375-4-dinahbaum123@gmail.com>
Date: Fri, 26 May 2023 08:07:58 +0200
In-Reply-To: <20230404011956.90375-4-dinahbaum123@gmail.com> (Dinah Baum's
 message of "Mon, 3 Apr 2023 21:19:56 -0400")
Message-ID: <878rdbfww1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is really, really, *really* for maintainers of the code parsing
-cpu to review.  Code parsing -cpu:

* parse_cpu_option() in cpu.c

  Eduardo Habkost <eduardo@habkost.net> (supporter:Machine core)
  Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:Machine core)
  "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org> (reviewer:Machine core)
  Yanan Wang <wangyanan55@huawei.com> (reviewer:Machine core)

* cpu_common_parse_features() in hw/core/cpu-common.c

  No maintainers *boggle*

* x86_cpu_parse_featurestr() in qemu/target/i386/cpu.c

  No maintainers *BOGGLE*

* sparc_cpu_parse_features() in target/sparc/cpu.c

  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:SPARC TCG CP=
Us)
  Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC TCG CPUs)

Paolo, Richard, Eduardo, care to get these covered in MAINTAINERS?

Since the patch has been waiting for review for so long, I'll give it a
try, even though I'm only passingly familiar with -cpu parsing.

Paolo, I have a question for you further down.

Dinah Baum <dinahbaum123@gmail.com> writes:

> Change parsing of -cpu argument to allow -cpu cpu,help
> to print options for the CPU type similar to
> how the '-device' option works.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1480
>
> Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
> ---
>  cpu.c                     | 41 +++++++++++++++++++++++++++++++++++++++
>  include/exec/cpu-common.h |  2 ++
>  include/qapi/qmp/qdict.h  |  2 ++
>  qemu-options.hx           |  7 ++++---
>  qobject/qdict.c           |  5 +++++
>  softmmu/vl.c              | 36 ++++++++++++++++++++++++++++++++--
>  6 files changed, 88 insertions(+), 5 deletions(-)
>
> diff --git a/cpu.c b/cpu.c
> index daf4e1ff0d..5f8a72e51f 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -23,7 +23,9 @@
>  #include "exec/target_page.h"
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
> +#include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  #include "migration/vmstate.h"
>  #ifdef CONFIG_USER_ONLY
>  #include "qemu.h"
> @@ -43,6 +45,8 @@
>  #include "trace/trace-root.h"
>  #include "qemu/accel.h"
>  #include "qemu/plugin.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qobject.h"
>=20=20
>  uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
> @@ -312,6 +316,43 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
(CpuModelExpansionType type,
>      return get_cpu_model_expansion_info(type, model, errp);
>  }
>=20=20
> +void list_cpu_model_expansion(CpuModelExpansionType type,
> +                              CpuModelInfo *model,
> +                              Error **errp)
> +{
> +    CpuModelExpansionInfo *expansion_info;
> +    QDict *qdict;
> +    QDictEntry *qdict_entry;
> +    const char *key;
> +    QObject *obj;
> +    QType q_type;
> +    GPtrArray *array;
> +    int i;
> +    const char *type_name;
> +
> +    expansion_info =3D get_cpu_model_expansion_info(type, model, errp);
> +    if (expansion_info) {

Avoid nesting:

       if (!expansion_info) {
           return;
       }

       ... work with expansion_info ...

> +        qdict =3D qobject_to(QDict, expansion_info->model->props);
> +        if (qdict) {

Likewise.

> +            qemu_printf("%s features:\n", model->name);
> +            array =3D g_ptr_array_new();

Name it @props, please.

> +            for (qdict_entry =3D (QDictEntry *)qdict_first(qdict); qdict=
_entry;
> +                 qdict_entry =3D (QDictEntry *)qdict_next(qdict, qdict_e=
ntry)) {
> +                g_ptr_array_add(array, qdict_entry);
> +            }

@qdict can change while we're using it here (if it could, your code
would be wrong).  So, no need for a flexible array.  Create a dynamic
one with g_new(QDictEntry, qdict_size(qdict), fill it, then sort with
qsort().

> +            g_ptr_array_sort(array, (GCompareFunc)dict_key_compare);

Casting function pointers is iffy.  The clean way is to define the
function so it is a GCompareFunc exactly, and have it cast its arguments
if necessary.

> +            for (i =3D 0; i < array->len; i++) {
> +                qdict_entry =3D array->pdata[i];
> +                key =3D qdict_entry_key(qdict_entry);
> +                obj =3D qdict_get(qdict, key);
> +                q_type =3D qobject_type(obj);
> +                type_name =3D QType_str(q_type);
> +                qemu_printf("  %s=3D<%s>\n", key, type_name);

Contract to

                   qemu_printf("  %s=3D<%s>\n",
                               key, QType_str(qobject_type(obj)));

Actually, don't use QType_str(), because the type comes out as "qnum",
"qstring", "qbool" (bad), or as "qdict", "qlist" (worse), or as "qnull"
(still worse, but impossible, I think).

Is CpuModelInfo the appropriate source?  Could we get properties
straight from QOM instead, like we do for "-device TYPE,help" and
"-object TYPE,help"?  I guess this question is for Paolo.

> +            }
> +        }
> +    }
> +}
> +
>  #if defined(CONFIG_USER_ONLY)
>  void tb_invalidate_phys_addr(target_ulong addr)
>  {
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index ec6024dfde..8fc05307ad 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -174,5 +174,7 @@ typedef void (*cpu_model_expansion_func)(CpuModelExpa=
nsionType type,
>  CpuModelExpansionInfo *get_cpu_model_expansion_info(CpuModelExpansionTyp=
e type,
>                                                      CpuModelInfo *model,
>                                                      Error **errp);
> +void list_cpu_model_expansion(CpuModelExpansionType type,
> +                              CpuModelInfo *model, Error **errp);
>=20=20
>  #endif /* CPU_COMMON_H */
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index 82e90fc072..1ff9523a13 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -68,4 +68,6 @@ const char *qdict_get_try_str(const QDict *qdict, const=
 char *key);
>=20=20
>  QDict *qdict_clone_shallow(const QDict *src);
>=20=20
> +int dict_key_compare(QDictEntry **entry1, QDictEntry **entry2);
> +
>  #endif /* QDICT_H */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 59bdf67a2c..10601626b7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -169,11 +169,12 @@ SRST
>  ERST
>=20=20
>  DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
> -    "-cpu cpu        select CPU ('-cpu help' for list)\n", QEMU_ARCH_ALL)
> +    "-cpu cpu        select CPU ('-cpu help' for list)\n"
> +    "                use '-cpu cpu,help' to print possible properties\n"=
, QEMU_ARCH_ALL)
>  SRST
>  ``-cpu model``
> -    Select CPU model (``-cpu help`` for list and additional feature
> -    selection)
> +    Select CPU model (``-cpu help`` and ``-cpu cpu,help``) for list and =
additional feature
> +    selection
>  ERST
>=20=20
>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 8faff230d3..31407e62f6 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -447,3 +447,8 @@ void qdict_unref(QDict *q)
>  {
>      qobject_unref(q);
>  }
> +
> +int dict_key_compare(QDictEntry **entry1, QDictEntry **entry2)
> +{
> +    return g_strcmp0(qdict_entry_key(*entry1), qdict_entry_key(*entry2));
> +}

This file's external functions start with qdict_, not dict_.

There is just one caller.  Let's put the function next to it, and make
it static.

> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ea20b23e4c..af6753a7e3 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -500,6 +500,15 @@ static QemuOptsList qemu_action_opts =3D {
>      },
>  };
>=20=20
> +static QemuOptsList qemu_cpu_opts =3D {
> +    .name =3D "cpu",
> +    .implied_opt_name =3D "cpu",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_cpu_opts.head),
> +    .desc =3D {
> +        { /* end of list */ }
> +    },
> +};
> +
>  const char *qemu_get_vm_name(void)
>  {
>      return qemu_name;
> @@ -1147,6 +1156,26 @@ static int device_init_func(void *opaque, QemuOpts=
 *opts, Error **errp)
>      return 0;
>  }
>=20=20
> +static int cpu_help_func(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    CpuModelInfo *model;
> +
> +    if (cpu_option && is_help_option(cpu_option)) {
> +        list_cpus(cpu_option);
> +        return 1;
> +    }
> +
> +    if (!cpu_option || !qemu_opt_has_help_opt(opts)) {
> +        return 0;
> +    }
> +
> +    model =3D g_new0(CpuModelInfo, 1);
> +    model->name =3D (char *)qemu_opt_get(opts, "cpu");
> +    /* TODO: handle other expansion cases */
> +    list_cpu_model_expansion(CPU_MODEL_EXPANSION_TYPE_FULL, model, errp);
> +    return 1;
> +}
> +
>  static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      Error *local_err =3D NULL;
> @@ -2431,8 +2460,9 @@ static void qemu_process_help_options(void)
>       * type and the user did not specify one, so that the user doesn't n=
eed
>       * to say '-cpu help -machine something'.
>       */
> -    if (cpu_option && is_help_option(cpu_option)) {
> -        list_cpus(cpu_option);
> +    Error *errp =3D NULL;
> +    if (qemu_opts_foreach(qemu_find_opts("cpu"),
> +                          cpu_help_func, NULL, &errp)) {
>          exit(0);
>      }
>=20=20
> @@ -2673,6 +2703,7 @@ void qemu_init(int argc, char **argv)
>      qemu_add_opts(&qemu_semihosting_config_opts);
>      qemu_add_opts(&qemu_fw_cfg_opts);
>      qemu_add_opts(&qemu_action_opts);
> +    qemu_add_opts(&qemu_cpu_opts);
>      module_call_init(MODULE_INIT_OPTS);
>=20=20
>      error_init(argv[0]);
> @@ -2724,6 +2755,7 @@ void qemu_init(int argc, char **argv)
>              switch(popt->index) {
>              case QEMU_OPTION_cpu:
>                  /* hw initialization will check this */
> +                qemu_opts_parse_noisily(qemu_find_opts("cpu"), optarg, t=
rue);

No :)

We have bespoke parsers for the argument of -cpu: parse_cpu_option()
together with CPUClass methods parse_features().  The syntax they parse
is superficially similar to QemuOpts (parts separated with comma), but
it's not the same.  If it was, we'd use QemuOpts and ditch the bespoke
parsers.

If qemu_opts_parse_noisily() rejects @optarg here, it reports an error,
and we continue anyway.

If parse_cpu_option() also rejects @optarg later on, the error is
reported twice.  Bad.

If it doesn't, the error qemu_opts_parse_noisily() reported is bogus.

If both succeed, they may well yield different parse results.  I can try
to dig up examples if necessary.

As far as I can see, you use the result of qemu_opts_parse_noisily()
only with cpu_help_func().  Can we slot the help feature into the
bespoke parser instead?  Let's have a look.

When the argument of -cpu is "help", qemu_process_help_options() shows
help and exits before we call parse_cpu_option().

parse_cpu_option() splits the argument of -cpu at the first comma into
CPU class name and features.

If you factor the splitting out of parse_cpu_option(), you can call it
from qemu_process_help_options(), then check whether the features are
"help".

>                  cpu_option =3D optarg;
>                  break;
>              case QEMU_OPTION_hda:


