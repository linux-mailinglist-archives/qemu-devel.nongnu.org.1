Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777876B565
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQp1l-000635-2g; Tue, 01 Aug 2023 09:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQp1h-000602-CM
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:03:02 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQp1e-0006jF-RF
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:03:01 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso736257366b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690894976; x=1691499776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=klSTu61CDjOUh4jZq+cTDj0qpMvAL0hByIWB9k27MjY=;
 b=WxUrYB8wEGchvBrdaK7GNuXP3ZpJI0mxNcXpoTT0nWscwZYLtcbwBg79vNbtX81zIG
 u/fG62rgdtzxQXdHPinTjQznXcrNQCaJJqa6iPv9iNwbtx5ZhEMgbjbVpOvmAOYLD1kk
 fwwIWRFIA4JGzqFGht+FUGPuCc6vP5vMqBK4YUz2jId70PCHMqr1cNEnAm6ZyNuH8DjH
 ef7Lq8G48z6MOZNtIaW3Ca5BsqpQdweCOmqPhF/HlDfKRNtWhje+jSk2ce2DFZlQP43t
 CU7qH/IYLtLM6n9YyUOJYh8j8+jVbX7HuZZrHUKGrZb+/idDkCNVxOXQvSOV4gBpUViA
 2MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690894976; x=1691499776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=klSTu61CDjOUh4jZq+cTDj0qpMvAL0hByIWB9k27MjY=;
 b=WM4Z/PXaOYb8QaGi7aAKmUGfBwHa5hBPSjpBFdKSgZcB/t3fWx73k+OQ96xDSopuRw
 sUJITG0e/wQZSe3ky2UXq+6FgElM/jj/Ycly9SyzbcxRcjcVCT7xs4aivEVvCxav9y/F
 XSe2XbkajJ44Z/in9Sqp3GkXg1ZlpNBd90Js+zPrxSpQvHoxnXXkxhb+jAQzyN8tRkLa
 A5lW7fzP25XhUPcghi2qWOmKkdDj/mWPs2iQEWk0xw5xysM/13kTkeaATRL8g1TaJ++H
 HdSOk7o+4Gbbg1ovspZecYWv1wkLRY4t0phYOt0rchsrhZsa3zan/3UR1TQeHJoGyfQl
 JYpQ==
X-Gm-Message-State: ABy/qLZCVSJYaBdc7ofvDugAEBJ7qj9vFF9zyQeqRHzM+xvFKySh0KQ/
 +YxGNyo8CtIROllPGNQi6yTxt+7e0kB4fXyMGKrwCuH4qjQ=
X-Google-Smtp-Source: APBJJlG47wzmffoFTkgBe7G6sWPf4d60YATRJAYCSCkgSclSsfBlA4KwBPaVa3ZBm2Vn1OYurCkMVmdwCGJBzCFjt5c=
X-Received: by 2002:a17:906:3188:b0:973:d076:67ab with SMTP id
 8-20020a170906318800b00973d07667abmr2547313ejy.42.1690894975789; Tue, 01 Aug
 2023 06:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-4-dinahbaum123@gmail.com>
In-Reply-To: <20230730064057.357598-4-dinahbaum123@gmail.com>
From: Dinah B <dinahbaum123@gmail.com>
Date: Tue, 1 Aug 2023 09:02:44 -0400
Message-ID: <CAH50XRdKKK7Zt+XDVrFouQzWDPKGYY8uJ0bYiOvpyeU1RhVK5A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] cpu, softmmu/vl.c: Change parsing of -cpu argument
 to allow -cpu cpu,
 help to print options for the CPU type similar to how the
 '-device' option works.
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000626f260601dc2a95"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=dinahbaum123@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000626f260601dc2a95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just realized that the commit message on this one got a little mangled. I'm
happy to revise it but I'd prefer to get the code reviewed first before
doing a purely commit message change.

-Dinah

On Sun, Jul 30, 2023 at 2:41=E2=80=AFAM Dinah Baum <dinahbaum123@gmail.com>=
 wrote:

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1480
> Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
>
> Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
> ---
>  cpu.c                    | 41 ++++++++++++++++++++++++++++++++++++++++
>  include/qapi/qmp/qdict.h |  1 +
>  qemu-options.hx          |  7 ++++---
>  qobject/qdict.c          |  5 +++++
>  softmmu/vl.c             | 35 +++++++++++++++++++++++++++++++++-
>  5 files changed, 85 insertions(+), 4 deletions(-)
>
> diff --git a/cpu.c b/cpu.c
> index a99d09cd47..9971ffeeba 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -43,6 +43,10 @@
>  #include "trace/trace-root.h"
>  #include "qemu/accel.h"
>  #include "qemu/plugin.h"
> +#include "qemu/cutils.h"
> +#include "qemu/qemu-print.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qobject.h"
>
>  uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
> @@ -312,6 +316,43 @@ CpuModelExpansionInfo
> *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      return get_cpu_model_expansion_info(type, model, errp);
>  }
>
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
> +        qdict =3D qobject_to(QDict, expansion_info->model->props);
> +        if (qdict) {
> +            qemu_printf("%s features:\n", model->name);
> +            array =3D g_ptr_array_new();
> +            for (qdict_entry =3D (QDictEntry *)qdict_first(qdict);
> qdict_entry;
> +                 qdict_entry =3D (QDictEntry *)qdict_next(qdict,
> qdict_entry)) {
> +                g_ptr_array_add(array, qdict_entry);
> +            }
> +            g_ptr_array_sort(array, (GCompareFunc)dict_key_compare);
> +            for (i =3D 0; i < array->len; i++) {
> +                qdict_entry =3D array->pdata[i];
> +                key =3D qdict_entry_key(qdict_entry);
> +                obj =3D qdict_get(qdict, key);
> +                q_type =3D qobject_type(obj);
> +                type_name =3D QType_str(q_type);
> +                qemu_printf("  %s=3D<%s>\n", key, type_name);
> +            }
> +        }
> +    }
> +}
> +
>  #if defined(CONFIG_USER_ONLY)
>  void tb_invalidate_phys_addr(hwaddr addr)
>  {
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index 82e90fc072..d0b6c3d358 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -67,5 +67,6 @@ bool qdict_get_try_bool(const QDict *qdict, const char
> *key, bool def_value);
>  const char *qdict_get_try_str(const QDict *qdict, const char *key);
>
>  QDict *qdict_clone_shallow(const QDict *src);
> +int dict_key_compare(QDictEntry **entry1, QDictEntry **entry2);
>
>  #endif /* QDICT_H */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 29b98c3d4c..e0f0284927 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -169,11 +169,12 @@ SRST
>  ERST
>
>  DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
> -    "-cpu cpu        select CPU ('-cpu help' for list)\n", QEMU_ARCH_ALL=
)
> +    "-cpu cpu        select CPU ('-cpu help' for list)\n"
> +    "                use '-cpu cpu,help' to print possible properties\n"=
,
> QEMU_ARCH_ALL)
>  SRST
>  ``-cpu model``
> -    Select CPU model (``-cpu help`` for list and additional feature
> -    selection)
> +    Select CPU model (``-cpu help`` and ``-cpu cpu,help``) for list and
> additional feature
> +    selection
>  ERST
>
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
> +    return g_strcmp0(qdict_entry_key(*entry1), qdict_entry_key(*entry2))=
;
> +}
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..1fd87f2c06 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -501,6 +501,15 @@ static QemuOptsList qemu_action_opts =3D {
>      },
>  };
>
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
> @@ -1159,6 +1168,26 @@ static int device_init_func(void *opaque, QemuOpts
> *opts, Error **errp)
>      return 0;
>  }
>
> +static int cpu_help_func(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    CpuModelInfo *model;
> +
> +    if (cpu_option && is_help_option(cpu_option)) {
> +        list_cpus();
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
> +    list_cpu_model_expansion(CPU_MODEL_EXPANSION_TYPE_FULL, model, errp)=
;
> +    return 1;
> +}
> +
>  static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      Error *local_err =3D NULL;
> @@ -2466,7 +2495,9 @@ static void qemu_process_help_options(void)
>          list_cpus();
>          exit(0);
>      }
> -
> +    if (qemu_opts_foreach(qemu_find_opts("cpu"), cpu_help_func, NULL,
> NULL)) {
> +        exit(0);
> +    }
>      if (qemu_opts_foreach(qemu_find_opts("device"),
>                            device_help_func, NULL, NULL)) {
>          exit(0);
> @@ -2704,6 +2735,7 @@ void qemu_init(int argc, char **argv)
>      qemu_add_opts(&qemu_semihosting_config_opts);
>      qemu_add_opts(&qemu_fw_cfg_opts);
>      qemu_add_opts(&qemu_action_opts);
> +    qemu_add_opts(&qemu_cpu_opts);
>      module_call_init(MODULE_INIT_OPTS);
>
>      error_init(argv[0]);
> @@ -2755,6 +2787,7 @@ void qemu_init(int argc, char **argv)
>              switch(popt->index) {
>              case QEMU_OPTION_cpu:
>                  /* hw initialization will check this */
> +                qemu_opts_parse_noisily(qemu_find_opts("cpu"), optarg,
> true);
>                  cpu_option =3D optarg;
>                  break;
>              case QEMU_OPTION_hda:
> --
> 2.30.2
>
>

--000000000000626f260601dc2a95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Just realized that the commit message on this one got=
 a little mangled. I&#39;m happy to revise it but I&#39;d prefer to get the=
 code reviewed first before doing a purely commit message change.</div><div=
><br></div><div>-Dinah<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sun, Jul 30, 2023 at 2:41=E2=80=AFAM Din=
ah Baum &lt;<a href=3D"mailto:dinahbaum123@gmail.com">dinahbaum123@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1480" r=
el=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/=
issues/1480</a><br>
Signed-off-by: Dinah Baum &lt;<a href=3D"mailto:dinahbaum123@gmail.com" tar=
get=3D"_blank">dinahbaum123@gmail.com</a>&gt;<br>
<br>
Signed-off-by: Dinah Baum &lt;<a href=3D"mailto:dinahbaum123@gmail.com" tar=
get=3D"_blank">dinahbaum123@gmail.com</a>&gt;<br>
---<br>
=C2=A0cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 41 ++++++++++++++++++++++++++++++++++++++++<br>
=C2=A0include/qapi/qmp/qdict.h |=C2=A0 1 +<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++++---<b=
r>
=C2=A0qobject/qdict.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++++<br>
=C2=A0softmmu/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 35 ++++=
+++++++++++++++++++++++++++++-<br>
=C2=A05 files changed, 85 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/cpu.c b/cpu.c<br>
index a99d09cd47..9971ffeeba 100644<br>
--- a/cpu.c<br>
+++ b/cpu.c<br>
@@ -43,6 +43,10 @@<br>
=C2=A0#include &quot;trace/trace-root.h&quot;<br>
=C2=A0#include &quot;qemu/accel.h&quot;<br>
=C2=A0#include &quot;qemu/plugin.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
+#include &quot;qemu/qemu-print.h&quot;<br>
+#include &quot;qapi/qmp/qdict.h&quot;<br>
+#include &quot;qapi/qmp/qobject.h&quot;<br>
<br>
=C2=A0uintptr_t qemu_host_page_size;<br>
=C2=A0intptr_t qemu_host_page_mask;<br>
@@ -312,6 +316,43 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(C=
puModelExpansionType type,<br>
=C2=A0 =C2=A0 =C2=A0return get_cpu_model_expansion_info(type, model, errp);=
<br>
=C2=A0}<br>
<br>
+void list_cpu_model_expansion(CpuModelExpansionType type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CpuModelInfo *model,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 CpuModelExpansionInfo *expansion_info;<br>
+=C2=A0 =C2=A0 QDict *qdict;<br>
+=C2=A0 =C2=A0 QDictEntry *qdict_entry;<br>
+=C2=A0 =C2=A0 const char *key;<br>
+=C2=A0 =C2=A0 QObject *obj;<br>
+=C2=A0 =C2=A0 QType q_type;<br>
+=C2=A0 =C2=A0 GPtrArray *array;<br>
+=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 const char *type_name;<br>
+<br>
+=C2=A0 =C2=A0 expansion_info =3D get_cpu_model_expansion_info(type, model,=
 errp);<br>
+=C2=A0 =C2=A0 if (expansion_info) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict =3D qobject_to(QDict, expansion_info-&gt=
;model-&gt;props);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qdict) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_printf(&quot;%s features:\n=
&quot;, model-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 array =3D g_ptr_array_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (qdict_entry =3D (QDictEntry=
 *)qdict_first(qdict); qdict_entry;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdict_entry =
=3D (QDictEntry *)qdict_next(qdict, qdict_entry)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_ptr_array_add(ar=
ray, qdict_entry);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_ptr_array_sort(array, (GCompar=
eFunc)dict_key_compare);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; array-&gt;l=
en; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_entry =3D ar=
ray-&gt;pdata[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D qdict_entr=
y_key(qdict_entry);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D qdict_get(=
qdict, key);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q_type =3D qobject=
_type(obj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type_name =3D QTyp=
e_str(q_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_printf(&quot;=
=C2=A0 %s=3D&lt;%s&gt;\n&quot;, key, type_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0#if defined(CONFIG_USER_ONLY)<br>
=C2=A0void tb_invalidate_phys_addr(hwaddr addr)<br>
=C2=A0{<br>
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h<br>
index 82e90fc072..d0b6c3d358 100644<br>
--- a/include/qapi/qmp/qdict.h<br>
+++ b/include/qapi/qmp/qdict.h<br>
@@ -67,5 +67,6 @@ bool qdict_get_try_bool(const QDict *qdict, const char *k=
ey, bool def_value);<br>
=C2=A0const char *qdict_get_try_str(const QDict *qdict, const char *key);<b=
r>
<br>
=C2=A0QDict *qdict_clone_shallow(const QDict *src);<br>
+int dict_key_compare(QDictEntry **entry1, QDictEntry **entry2);<br>
<br>
=C2=A0#endif /* QDICT_H */<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 29b98c3d4c..e0f0284927 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -169,11 +169,12 @@ SRST<br>
=C2=A0ERST<br>
<br>
=C2=A0DEF(&quot;cpu&quot;, HAS_ARG, QEMU_OPTION_cpu,<br>
-=C2=A0 =C2=A0 &quot;-cpu cpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 select CPU (&#39;-=
cpu help&#39; for list)\n&quot;, QEMU_ARCH_ALL)<br>
+=C2=A0 =C2=A0 &quot;-cpu cpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 select CPU (&#39;-=
cpu help&#39; for list)\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 use &#39;-cpu cpu,help&#39; to print possible properties\n&quot;, QEMU_=
ARCH_ALL)<br>
=C2=A0SRST<br>
=C2=A0``-cpu model``<br>
-=C2=A0 =C2=A0 Select CPU model (``-cpu help`` for list and additional feat=
ure<br>
-=C2=A0 =C2=A0 selection)<br>
+=C2=A0 =C2=A0 Select CPU model (``-cpu help`` and ``-cpu cpu,help``) for l=
ist and additional feature<br>
+=C2=A0 =C2=A0 selection<br>
=C2=A0ERST<br>
<br>
=C2=A0DEF(&quot;accel&quot;, HAS_ARG, QEMU_OPTION_accel,<br>
diff --git a/qobject/qdict.c b/qobject/qdict.c<br>
index 8faff230d3..31407e62f6 100644<br>
--- a/qobject/qdict.c<br>
+++ b/qobject/qdict.c<br>
@@ -447,3 +447,8 @@ void qdict_unref(QDict *q)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qobject_unref(q);<br>
=C2=A0}<br>
+<br>
+int dict_key_compare(QDictEntry **entry1, QDictEntry **entry2)<br>
+{<br>
+=C2=A0 =C2=A0 return g_strcmp0(qdict_entry_key(*entry1), qdict_entry_key(*=
entry2));<br>
+}<br>
diff --git a/softmmu/vl.c b/softmmu/vl.c<br>
index b0b96f67fa..1fd87f2c06 100644<br>
--- a/softmmu/vl.c<br>
+++ b/softmmu/vl.c<br>
@@ -501,6 +501,15 @@ static QemuOptsList qemu_action_opts =3D {<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0};<br>
<br>
+static QemuOptsList qemu_cpu_opts =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;cpu&quot;,<br>
+=C2=A0 =C2=A0 .implied_opt_name =3D &quot;cpu&quot;,<br>
+=C2=A0 =C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(qemu_cpu_opts.head),<br>
+=C2=A0 =C2=A0 .desc =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { /* end of list */ }<br>
+=C2=A0 =C2=A0 },<br>
+};<br>
+<br>
=C2=A0const char *qemu_get_vm_name(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return qemu_name;<br>
@@ -1159,6 +1168,26 @@ static int device_init_func(void *opaque, QemuOpts *=
opts, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+static int cpu_help_func(void *opaque, QemuOpts *opts, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 CpuModelInfo *model;<br>
+<br>
+=C2=A0 =C2=A0 if (cpu_option &amp;&amp; is_help_option(cpu_option)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 list_cpus();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!cpu_option || !qemu_opt_has_help_opt(opts)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 model =3D g_new0(CpuModelInfo, 1);<br>
+=C2=A0 =C2=A0 model-&gt;name =3D (char *)qemu_opt_get(opts, &quot;cpu&quot=
;);<br>
+=C2=A0 =C2=A0 /* TODO: handle other expansion cases */<br>
+=C2=A0 =C2=A0 list_cpu_model_expansion(CPU_MODEL_EXPANSION_TYPE_FULL, mode=
l, errp);<br>
+=C2=A0 =C2=A0 return 1;<br>
+}<br>
+<br>
=C2=A0static int chardev_init_func(void *opaque, QemuOpts *opts, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
@@ -2466,7 +2495,9 @@ static void qemu_process_help_options(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_cpus();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
+=C2=A0 =C2=A0 if (qemu_opts_foreach(qemu_find_opts(&quot;cpu&quot;), cpu_h=
elp_func, NULL, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(0);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_opts_foreach(qemu_find_opts(&quot;device&quot;=
),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0device_help_func, NULL, NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
@@ -2704,6 +2735,7 @@ void qemu_init(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0qemu_add_opts(&amp;qemu_semihosting_config_opts);<br>
=C2=A0 =C2=A0 =C2=A0qemu_add_opts(&amp;qemu_fw_cfg_opts);<br>
=C2=A0 =C2=A0 =C2=A0qemu_add_opts(&amp;qemu_action_opts);<br>
+=C2=A0 =C2=A0 qemu_add_opts(&amp;qemu_cpu_opts);<br>
=C2=A0 =C2=A0 =C2=A0module_call_init(MODULE_INIT_OPTS);<br>
<br>
=C2=A0 =C2=A0 =C2=A0error_init(argv[0]);<br>
@@ -2755,6 +2787,7 @@ void qemu_init(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch(popt-&gt;index) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_OPTION_cpu:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* hw initial=
ization will check this */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_opts_parse_no=
isily(qemu_find_opts(&quot;cpu&quot;), optarg, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_option =
=3D optarg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_OPTION_hda:<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div>

--000000000000626f260601dc2a95--

