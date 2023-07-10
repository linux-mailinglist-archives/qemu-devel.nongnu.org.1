Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979E74D135
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImzb-0000re-CI; Mon, 10 Jul 2023 05:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qImzS-0000k9-22
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:15:30 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qImzP-0004X3-3Z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:15:29 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4009ea1597bso32372261cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688980521; x=1691572521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6+JLW9txDlA2BBjZtr7yRVP1kkIsd3ANtoyVajPTsg=;
 b=AX/wTgKFjs8UvXjrzGisnynSoVCFMw0v6DZQK+j2yBzoJXWGvWk3j2Y1qq4FaI6SR8
 7iD6WsfszYhyTAYk3CSEclhWTyC/x6NRl4kI8OgpETVQ7nQp1mP2RigTaVFaPshr7jsk
 m/GmSVfvL9d2zoeqYGsUwiqpWoRPqtcHq/VDkdEi+rOCdOZ1OJsCzaX8lc7Nf8zjMgJG
 NEvhN4j3fSRWItFAhlkuRjiSsz73AbM77QwexD73gADWWgyLOGrF1Xs17b9WAmvzFZZS
 IX8tnefQzExChKdxKZMJta6C7X47IoP2mtygXEF+6af06J4JCJiJXRgJSSeaVN3UVi79
 pP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688980521; x=1691572521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6+JLW9txDlA2BBjZtr7yRVP1kkIsd3ANtoyVajPTsg=;
 b=fMh9fNyyCrGeIcv1xZktAF6gZxADZq/d1x3wqHSWhZcROh5tn/N9KtHsyH9NFVihls
 6A0tfToCjVy1yZdHrFnluGT3APgbP3oApCSxbgxjawr1mFQLI1SvJFCV/BM+G+rL2Pk2
 BPI5qpIE/O+c98IedU/y+2HmWzK27fNXM6o4SMZCKko08OY8J1zxbT210Th+hsBZjc4+
 vBB5W9m5+gmgTw7HGLFty7jU6aJp4R7il5LTRf2SK1gaS9Velir4UXEpZriQejysA00J
 3qkbJsQ/IfG8JVmE04wc6omUPEUPHop+EaQnlsFMw6LHLW6HJ0ANs7WH76LuI3h51+Ze
 wrbw==
X-Gm-Message-State: ABy/qLamv24Ib1gD77ZiWl6SCbikiTo8LvXBo8ml91V8Ut4Qa8ZamnTA
 ravV9YiPnlPNQRqNOMisPX1rt2LvFOjuiL23E+zngRqEVXo=
X-Google-Smtp-Source: APBJJlGFyGJ7Xk56B3UiwqFcPoMnDpYvdt+1nDVyh1jwZ3ywBNOsHQSrxhwyB1WzPUpb4xCLMW1pg+LqBwuR4Isp2lM=
X-Received: by 2002:ac8:5c0c:0:b0:403:affc:d03e with SMTP id
 i12-20020ac85c0c000000b00403affcd03emr2722966qti.67.1688980521176; Mon, 10
 Jul 2023 02:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230706083035.623802-1-kkostiuk@redhat.com>
 <20230706083035.623802-3-kkostiuk@redhat.com>
In-Reply-To: <20230706083035.623802-3-kkostiuk@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jul 2023 13:15:09 +0400
Message-ID: <CAJ+F1CJjvzA2BUNuhqK7+=ScmYL9eWyJjHPn5rxJrn94J0gpZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] qga: Add new option --allow-rpcs
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000ff800606001e6b76"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000ff800606001e6b76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 12:32=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> The allow-rpcs option accepts a comma-separated list of RPCs to
> enable. This option is opposite to --block-rpcs. Using --block-rpcs
> and --allow-rpcs at the same time is not allowed.
>
> resolves: https://gitlab.com/qemu-project/qemu/-/issues/1505
>
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>




> ---
>  docs/interop/qemu-ga.rst |  5 +++
>  qga/main.c               | 85 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 84 insertions(+), 6 deletions(-)
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index a9183802d1..461c5a35ee 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -84,6 +84,11 @@ Options
>    Comma-separated list of RPCs to disable (no spaces, use ``help`` to
>    list available RPCs).
>
> +.. option:: -a, --allow-rpcs=3DLIST
> +
> +  Comma-separated list of RPCs to enable (no spaces, use ``help`` to
> +  list available RPCs).
> +
>  .. option:: -D, --dump-conf
>
>    Dump the configuration in a format compatible with ``qemu-ga.conf``
> diff --git a/qga/main.c b/qga/main.c
> index 121ff7a748..0f95fa87c0 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -87,6 +87,7 @@ struct GAState {
>      bool delimit_response;
>      bool frozen;
>      GList *blockedrpcs;
> +    GList *allowedrpcs;
>      char *state_filepath_isfrozen;
>      struct {
>          const char *log_filepath;
> @@ -261,6 +262,8 @@ QEMU_COPYRIGHT "\n"
>  #endif
>  "  -b, --block-rpcs  comma-separated list of RPCs to disable (no
> spaces,\n"
>  "                    use \"help\" to list available RPCs)\n"
> +"  -a, --allow-rpcs  comma-separated list of RPCs to enable (no spaces,\=
n"
> +"                    use \"help\" to list available RPCs)\n"
>  "  -D, --dump-conf   dump a qemu-ga config file based on current config\=
n"
>  "                    options / command-line parameters to stdout\n"
>  "  -r, --retry-path  attempt re-opening path if it's unavailable or
> closed\n"
> @@ -416,16 +419,38 @@ static void ga_disable_not_allowed_freeze(const
> QmpCommand *cmd, void *opaque)
>  /* [re-]enable all commands, except those explicitly blocked by user */
>  static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
>  {
> -    GList *blockedrpcs =3D opaque;
> +    GAState *s =3D opaque;
> +    GList *blockedrpcs =3D s->blockedrpcs;
> +    GList *allowedrpcs =3D s->allowedrpcs;
>      const char *name =3D qmp_command_name(cmd);
>
> -    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) =3D=3D NULL &&
> -        !qmp_command_is_enabled(cmd)) {
> +    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) =3D=3D NULL) {
> +        if (qmp_command_is_enabled(cmd)) {
> +            return;
> +        }
> +
> +        if (allowedrpcs &&
> +            g_list_find_custom(allowedrpcs, name, ga_strcmp) =3D=3D NULL=
) {
> +            return;
> +        }
> +
>          g_debug("enabling command: %s", name);
>          qmp_enable_command(&ga_commands, name);
>      }
>  }
>
> +/* disable commands that aren't allowed */
> +static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
> +{
> +    GList *allowedrpcs =3D opaque;
> +    const char *name =3D qmp_command_name(cmd);
> +
> +    if (g_list_find_custom(allowedrpcs, name, ga_strcmp) =3D=3D NULL) {
> +        g_debug("disabling command: %s", name);
> +        qmp_disable_command(&ga_commands, name, "the command is not
> allowed");
> +    }
> +}
> +
>  static bool ga_create_file(const char *path)
>  {
>      int fd =3D open(path, O_CREAT | O_WRONLY, S_IWUSR | S_IRUSR);
> @@ -497,8 +522,8 @@ void ga_unset_frozen(GAState *s)
>          s->deferred_options.pid_filepath =3D NULL;
>      }
>
> -    /* enable all disabled, non-blocked commands */
> -    qmp_for_each_command(&ga_commands, ga_enable_non_blocked,
> s->blockedrpcs);
> +    /* enable all disabled, non-blocked and allowed commands */
> +    qmp_for_each_command(&ga_commands, ga_enable_non_blocked, s);
>      s->frozen =3D false;
>      if (!ga_delete_file(s->state_filepath_isfrozen)) {
>          g_warning("unable to delete %s, fsfreeze may not function
> properly",
> @@ -984,7 +1009,9 @@ struct GAConfig {
>      const char *service;
>  #endif
>      gchar *bliststr; /* blockedrpcs may point to this string */
> +    gchar *aliststr; /* allowedrpcs may point to this string */
>      GList *blockedrpcs;
> +    GList *allowedrpcs;
>      int daemonize;
>      GLogLevelFlags log_level;
>      int dumpconf;
> @@ -1055,6 +1082,19 @@ static void config_load(GAConfig *config)
>          config->blockedrpcs =3D g_list_concat(config->blockedrpcs,
>                                            split_list(config->bliststr,
> ","));
>      }
> +    if (g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
> +        config->aliststr =3D
> +            g_key_file_get_string(keyfile, "general", "allow-rpcs",
> &gerr);
> +        config->allowedrpcs =3D g_list_concat(config->allowedrpcs,
> +                                          split_list(config->aliststr,
> ","));
> +    }
> +
> +    if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL) &&
> +        g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
> +        g_critical("wrong config, using --block-rpcs and --allow-rpcs at
> the"
> +                   " same time is not allowed");
>


It's not CLI usage here, it's the configuration file/keys. Please tweak the
warning.

Otherwise, lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> +        exit(EXIT_FAILURE);
> +    }
>

>  end:
>      g_key_file_free(keyfile);
> @@ -1115,6 +1155,9 @@ static void config_dump(GAConfig *config)
>      tmp =3D list_join(config->blockedrpcs, ',');
>      g_key_file_set_string(keyfile, "general", "block-rpcs", tmp);
>      g_free(tmp);
> +    tmp =3D list_join(config->allowedrpcs, ',');
> +    g_key_file_set_string(keyfile, "general", "allow-rpcs", tmp);
> +    g_free(tmp);
>
>      tmp =3D g_key_file_to_data(keyfile, NULL, &error);
>      if (error) {
> @@ -1130,8 +1173,9 @@ static void config_dump(GAConfig *config)
>
>  static void config_parse(GAConfig *config, int argc, char **argv)
>  {
> -    const char *sopt =3D "hVvdm:p:l:f:F::b:s:t:Dr";
> +    const char *sopt =3D "hVvdm:p:l:f:F::b:a:s:t:Dr";
>      int opt_ind =3D 0, ch;
> +    bool block_rpcs =3D false, allow_rpcs =3D false;
>      const struct option lopt[] =3D {
>          { "help", 0, NULL, 'h' },
>          { "version", 0, NULL, 'V' },
> @@ -1147,6 +1191,7 @@ static void config_parse(GAConfig *config, int argc=
,
> char **argv)
>          { "daemonize", 0, NULL, 'd' },
>          { "block-rpcs", 1, NULL, 'b' },
>          { "blacklist", 1, NULL, 'b' },  /* deprecated alias for
> 'block-rpcs' */
> +        { "allow-rpcs", 1, NULL, 'a' },
>  #ifdef _WIN32
>          { "service", 1, NULL, 's' },
>  #endif
> @@ -1206,6 +1251,17 @@ static void config_parse(GAConfig *config, int
> argc, char **argv)
>              }
>              config->blockedrpcs =3D g_list_concat(config->blockedrpcs,
>                                                  split_list(optarg, ","))=
;
> +            block_rpcs =3D true;
> +            break;
> +        }
> +        case 'a': {
> +            if (is_help_option(optarg)) {
> +                qmp_for_each_command(&ga_commands, ga_print_cmd, NULL);
> +                exit(EXIT_SUCCESS);
> +            }
> +            config->allowedrpcs =3D g_list_concat(config->allowedrpcs,
> +                                                split_list(optarg, ","))=
;
> +            allow_rpcs =3D true;
>              break;
>          }
>  #ifdef _WIN32
> @@ -1246,6 +1302,12 @@ static void config_parse(GAConfig *config, int
> argc, char **argv)
>              exit(EXIT_FAILURE);
>          }
>      }
> +
> +    if (block_rpcs && allow_rpcs) {
> +        g_critical("wrong commandline, using --block-rpcs and
> --allow-rpcs at the"
> +                   " same time is not allowed");
> +        exit(EXIT_FAILURE);
> +    }
>  }
>
>  static void config_free(GAConfig *config)
> @@ -1256,10 +1318,12 @@ static void config_free(GAConfig *config)
>      g_free(config->state_dir);
>      g_free(config->channel_path);
>      g_free(config->bliststr);
> +    g_free(config->aliststr);
>  #ifdef CONFIG_FSFREEZE
>      g_free(config->fsfreeze_hook);
>  #endif
>      g_list_free_full(config->blockedrpcs, g_free);
> +    g_list_free_full(config->allowedrpcs, g_free);
>      g_free(config);
>  }
>
> @@ -1374,6 +1438,15 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>          return NULL;
>      }
>
> +    if (config->allowedrpcs) {
> +        qmp_for_each_command(&ga_commands, ga_disable_not_allowed,
> config->allowedrpcs);
> +        s->allowedrpcs =3D config->allowedrpcs;
> +    }
> +
> +    /*
> +     * Some commands can be blocked due to system limitation.
> +     * Initialize blockedrpcs list even if allowedrpcs specified.
> +     */
>      config->blockedrpcs =3D
> ga_command_init_blockedrpcs(config->blockedrpcs);
>      if (config->blockedrpcs) {
>          GList *l =3D config->blockedrpcs;
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ff800606001e6b76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 12:32=E2=80=AF=
PM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">The allow-rpcs option accepts a comma-separated list of RPCs to<=
br>
enable. This option is opposite to --block-rpcs. Using --block-rpcs<br>
and --allow-rpcs at the same time is not allowed.<br>
<br>
resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1505" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/1505</a><br>
<br>
Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com=
" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br></blockquote><div><br></=
div><div><br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
---<br>
=C2=A0docs/interop/qemu-ga.rst |=C2=A0 5 +++<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 85=
 +++++++++++++++++++++++++++++++++++++---<br>
=C2=A02 files changed, 84 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst<br>
index a9183802d1..461c5a35ee 100644<br>
--- a/docs/interop/qemu-ga.rst<br>
+++ b/docs/interop/qemu-ga.rst<br>
@@ -84,6 +84,11 @@ Options<br>
=C2=A0 =C2=A0Comma-separated list of RPCs to disable (no spaces, use ``help=
`` to<br>
=C2=A0 =C2=A0list available RPCs).<br>
<br>
+.. option:: -a, --allow-rpcs=3DLIST<br>
+<br>
+=C2=A0 Comma-separated list of RPCs to enable (no spaces, use ``help`` to<=
br>
+=C2=A0 list available RPCs).<br>
+<br>
=C2=A0.. option:: -D, --dump-conf<br>
<br>
=C2=A0 =C2=A0Dump the configuration in a format compatible with ``qemu-ga.c=
onf``<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 121ff7a748..0f95fa87c0 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -87,6 +87,7 @@ struct GAState {<br>
=C2=A0 =C2=A0 =C2=A0bool delimit_response;<br>
=C2=A0 =C2=A0 =C2=A0bool frozen;<br>
=C2=A0 =C2=A0 =C2=A0GList *blockedrpcs;<br>
+=C2=A0 =C2=A0 GList *allowedrpcs;<br>
=C2=A0 =C2=A0 =C2=A0char *state_filepath_isfrozen;<br>
=C2=A0 =C2=A0 =C2=A0struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *log_filepath;<br>
@@ -261,6 +262,8 @@ QEMU_COPYRIGHT &quot;\n&quot;<br>
=C2=A0#endif<br>
=C2=A0&quot;=C2=A0 -b, --block-rpcs=C2=A0 comma-separated list of RPCs to d=
isable (no spaces,\n&quot;<br>
=C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 use \&quot;help\&quot; to list available RPCs)\n&quot;<br>
+&quot;=C2=A0 -a, --allow-rpcs=C2=A0 comma-separated list of RPCs to enable=
 (no spaces,\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 use \&quot;help\&quot; to list available RPCs)\n&quot;<br>
=C2=A0&quot;=C2=A0 -D, --dump-conf=C2=A0 =C2=A0dump a qemu-ga config file b=
ased on current config\n&quot;<br>
=C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 options / command-line parameters to stdout\n&quot;<br>
=C2=A0&quot;=C2=A0 -r, --retry-path=C2=A0 attempt re-opening path if it&#39=
;s unavailable or closed\n&quot;<br>
@@ -416,16 +419,38 @@ static void ga_disable_not_allowed_freeze(const QmpCo=
mmand *cmd, void *opaque)<br>
=C2=A0/* [re-]enable all commands, except those explicitly blocked by user =
*/<br>
=C2=A0static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque=
)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 GList *blockedrpcs =3D opaque;<br>
+=C2=A0 =C2=A0 GAState *s =3D opaque;<br>
+=C2=A0 =C2=A0 GList *blockedrpcs =3D s-&gt;blockedrpcs;<br>
+=C2=A0 =C2=A0 GList *allowedrpcs =3D s-&gt;allowedrpcs;<br>
=C2=A0 =C2=A0 =C2=A0const char *name =3D qmp_command_name(cmd);<br>
<br>
-=C2=A0 =C2=A0 if (g_list_find_custom(blockedrpcs, name, ga_strcmp) =3D=3D =
NULL &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 !qmp_command_is_enabled(cmd)) {<br>
+=C2=A0 =C2=A0 if (g_list_find_custom(blockedrpcs, name, ga_strcmp) =3D=3D =
NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qmp_command_is_enabled(cmd)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (allowedrpcs &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_list_find_custom(allowedrpcs, =
name, ga_strcmp) =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_debug(&quot;enabling command: %s&quot;,=
 name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qmp_enable_command(&amp;ga_commands, name=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+/* disable commands that aren&#39;t allowed */<br>
+static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)<br=
>
+{<br>
+=C2=A0 =C2=A0 GList *allowedrpcs =3D opaque;<br>
+=C2=A0 =C2=A0 const char *name =3D qmp_command_name(cmd);<br>
+<br>
+=C2=A0 =C2=A0 if (g_list_find_custom(allowedrpcs, name, ga_strcmp) =3D=3D =
NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;disabling command: %s&quot;, nam=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_disable_command(&amp;ga_commands, name, &q=
uot;the command is not allowed&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0static bool ga_create_file(const char *path)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int fd =3D open(path, O_CREAT | O_WRONLY, S_IWUSR | S_I=
RUSR);<br>
@@ -497,8 +522,8 @@ void ga_unset_frozen(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;deferred_options.pid_filepath =3D N=
ULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* enable all disabled, non-blocked commands */<br>
-=C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_enable_non_blocked=
, s-&gt;blockedrpcs);<br>
+=C2=A0 =C2=A0 /* enable all disabled, non-blocked and allowed commands */<=
br>
+=C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_enable_non_blocked=
, s);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;frozen =3D false;<br>
=C2=A0 =C2=A0 =C2=A0if (!ga_delete_file(s-&gt;state_filepath_isfrozen)) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;unable to delete %s, fsfr=
eeze may not function properly&quot;,<br>
@@ -984,7 +1009,9 @@ struct GAConfig {<br>
=C2=A0 =C2=A0 =C2=A0const char *service;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0gchar *bliststr; /* blockedrpcs may point to this strin=
g */<br>
+=C2=A0 =C2=A0 gchar *aliststr; /* allowedrpcs may point to this string */<=
br>
=C2=A0 =C2=A0 =C2=A0GList *blockedrpcs;<br>
+=C2=A0 =C2=A0 GList *allowedrpcs;<br>
=C2=A0 =C2=A0 =C2=A0int daemonize;<br>
=C2=A0 =C2=A0 =C2=A0GLogLevelFlags log_level;<br>
=C2=A0 =C2=A0 =C2=A0int dumpconf;<br>
@@ -1055,6 +1082,19 @@ static void config_load(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;blockedrpcs =3D g_list_concat(=
config-&gt;blockedrpcs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0split_list(config-&gt;bliststr, &quot;,&quot;));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, &quot;a=
llow-rpcs&quot;, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;aliststr =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_get_string(keyfile, &=
quot;general&quot;, &quot;allow-rpcs&quot;, &amp;gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;allowedrpcs =3D g_list_concat(confi=
g-&gt;allowedrpcs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
plit_list(config-&gt;aliststr, &quot;,&quot;));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, blockrp=
cs_key, NULL) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_has_key(keyfile, &quot;general&quot=
;, &quot;allow-rpcs&quot;, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;wrong config, using --block-r=
pcs and --allow-rpcs at the&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; same time is not allowed&quot;);<br></blockquote><div><br></div><div><br>=
</div><div>It&#39;s not CLI usage here, it&#39;s the configuration file/key=
s. Please tweak the warning.<br></div><div><br></div><div>Otherwise, lgtm</=
div><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div></div><d=
iv>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 } <br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
=C2=A0end:<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_free(keyfile);<br>
@@ -1115,6 +1155,9 @@ static void config_dump(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D list_join(config-&gt;blockedrpcs, &#39;,&#39;);=
<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_set_string(keyfile, &quot;general&quot;, &qu=
ot;block-rpcs&quot;, tmp);<br>
=C2=A0 =C2=A0 =C2=A0g_free(tmp);<br>
+=C2=A0 =C2=A0 tmp =3D list_join(config-&gt;allowedrpcs, &#39;,&#39;);<br>
+=C2=A0 =C2=A0 g_key_file_set_string(keyfile, &quot;general&quot;, &quot;al=
low-rpcs&quot;, tmp);<br>
+=C2=A0 =C2=A0 g_free(tmp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D g_key_file_to_data(keyfile, NULL, &amp;error);<=
br>
=C2=A0 =C2=A0 =C2=A0if (error) {<br>
@@ -1130,8 +1173,9 @@ static void config_dump(GAConfig *config)<br>
<br>
=C2=A0static void config_parse(GAConfig *config, int argc, char **argv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdm:p:l:f:F::b:s:t:Dr&quot;;<br=
>
+=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdm:p:l:f:F::b:a:s:t:Dr&quot;;<=
br>
=C2=A0 =C2=A0 =C2=A0int opt_ind =3D 0, ch;<br>
+=C2=A0 =C2=A0 bool block_rpcs =3D false, allow_rpcs =3D false;<br>
=C2=A0 =C2=A0 =C2=A0const struct option lopt[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;help&quot;, 0, NULL, &#39;h&#39; =
},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;version&quot;, 0, NULL, &#39;V&#3=
9; },<br>
@@ -1147,6 +1191,7 @@ static void config_parse(GAConfig *config, int argc, =
char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;daemonize&quot;, 0, NULL, &#39;d&=
#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;block-rpcs&quot;, 1, NULL, &#39;b=
&#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;blacklist&quot;, 1, NULL, &#39;b&=
#39; },=C2=A0 /* deprecated alias for &#39;block-rpcs&#39; */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;allow-rpcs&quot;, 1, NULL, &#39;a&#39;=
 },<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;service&quot;, 1, NULL, &#39;s&#3=
9; },<br>
=C2=A0#endif<br>
@@ -1206,6 +1251,17 @@ static void config_parse(GAConfig *config, int argc,=
 char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;blockedrpcs =3D =
g_list_concat(config-&gt;blockedrpcs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0split_list(optarg, &quot;,&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block_rpcs =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;a&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_help_option(optarg)) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_for_each_comma=
nd(&amp;ga_commands, ga_print_cmd, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_SUCCESS)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;allowedrpcs =3D g_lis=
t_concat(config-&gt;allowedrpcs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 split_list(optarg, &quot;,&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allow_rpcs =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#ifdef _WIN32<br>
@@ -1246,6 +1302,12 @@ static void config_parse(GAConfig *config, int argc,=
 char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 if (block_rpcs &amp;&amp; allow_rpcs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;wrong commandline, using --bl=
ock-rpcs and --allow-rpcs at the&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; same time is not allowed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void config_free(GAConfig *config)<br>
@@ -1256,10 +1318,12 @@ static void config_free(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0g_free(config-&gt;state_dir);<br>
=C2=A0 =C2=A0 =C2=A0g_free(config-&gt;channel_path);<br>
=C2=A0 =C2=A0 =C2=A0g_free(config-&gt;bliststr);<br>
+=C2=A0 =C2=A0 g_free(config-&gt;aliststr);<br>
=C2=A0#ifdef CONFIG_FSFREEZE<br>
=C2=A0 =C2=A0 =C2=A0g_free(config-&gt;fsfreeze_hook);<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0g_list_free_full(config-&gt;blockedrpcs, g_free);<br>
+=C2=A0 =C2=A0 g_list_free_full(config-&gt;allowedrpcs, g_free);<br>
=C2=A0 =C2=A0 =C2=A0g_free(config);<br>
=C2=A0}<br>
<br>
@@ -1374,6 +1438,15 @@ static GAState *initialize_agent(GAConfig *config, i=
nt socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (config-&gt;allowedrpcs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disa=
ble_not_allowed, config-&gt;allowedrpcs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;allowedrpcs =3D config-&gt;allowedrpcs;<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Some commands can be blocked due to system limitatio=
n.<br>
+=C2=A0 =C2=A0 =C2=A0* Initialize blockedrpcs list even if allowedrpcs spec=
ified.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0config-&gt;blockedrpcs =3D ga_command_init_blockedrpcs(=
config-&gt;blockedrpcs);<br>
=C2=A0 =C2=A0 =C2=A0if (config-&gt;blockedrpcs) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GList *l =3D config-&gt;blockedrpcs;<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000ff800606001e6b76--

