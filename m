Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D08F74D103
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:08:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImrj-0006ol-39; Mon, 10 Jul 2023 05:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qImre-0006mz-IJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:07:26 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qImrP-00029x-Iq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:07:26 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4039a42467fso17398921cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688980030; x=1691572030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqNWJLRQJ85dNiLOVVxJkdJ6PrfeMqO3/s8aOZjZxpc=;
 b=E6H2pVdaTkaTPWzqh6in9JgcZbs1cIQIg/yFA+3pbQrnOvrh/isnKPNOJ2CdcDUL8G
 0s4oMNz/DkEjFOKwSVRrQR7ySU4riusGgNoGVoUYOZ+CjU7WjTKa9F7ouX7g7WuS0YyZ
 bb+JXAFYyppHMnwiPeKlxniMg+Kt9v3LoLAWeXbQ4b5mv0S/8KQ+xuI75gEcjtbgjCR7
 hKwskLpAOzjKPOebhfS3hPJh2SxSb6dh6XiQb2c7LSpTVsNkrhFYmXjoaNewXOHk6Rsv
 5ELN0L8EdHfP4IkIxP1e2QPTKbojFGCIJSXYb4eUbmPKyTKhZ0xukhxwz8G4oslWwhAV
 VWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688980030; x=1691572030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqNWJLRQJ85dNiLOVVxJkdJ6PrfeMqO3/s8aOZjZxpc=;
 b=FOk9pcgjF7XWNQpRcsAqWMI7gWk9weaxCYVvj6vNCXf40JMo2/W1B8COxWg8xh++MZ
 x79ybCrIiVMalkwYVSO4kHHBUmBw5OLvh+WA4VV0bQiZ+t63NwPS9ytFxSpqTQD793f8
 CBDK1AheAL6y6jWxYg4Q7nmd3SsmGLwH4D4dO84443WV3+1/Ooms1lgkASjpLH6fGcj7
 f9RUYi1gvnX36ciwt+Ju/LRvJGoxdOeG1sBX3gMj3F0wWE/jCgaxxDC/7H92F9Gje02J
 TIQ4xl5iW5TlPRbnWZ0xeu8Q37A2Pz956BO87k6LpAhVOejqvBiwlYfIDEMYXt75DOV8
 NQpA==
X-Gm-Message-State: ABy/qLbf17rABPpjBaDvJX7Xw0CrdZzj3HHmjc97zGsjGwp5d2JZqFDg
 tSZVB3nh8GIKcp09cZKrztg8voa8gZEeX660sls=
X-Google-Smtp-Source: APBJJlEwWft6rbN89mpU+TZgMZ/vwJo5l0d5JgioXXw9Xc67MCX7J3SlhMMKdCNjY/I445EgNyNANoBjVZGCLfY/6sw=
X-Received: by 2002:a05:622a:1496:b0:403:a662:a408 with SMTP id
 t22-20020a05622a149600b00403a662a408mr5781286qtx.34.1688980029820; Mon, 10
 Jul 2023 02:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230706083035.623802-1-kkostiuk@redhat.com>
 <20230706083035.623802-2-kkostiuk@redhat.com>
In-Reply-To: <20230706083035.623802-2-kkostiuk@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jul 2023 13:06:58 +0400
Message-ID: <CAJ+F1C+cYtOFQPUU=Jr4LPysmPz20JRXrd+BGdSoBTQ2ub2chg@mail.gmail.com>
Subject: Re: [PATCH 1/3] qga: Rename ga_disable_not_allowed ->
 ga_disable_not_allowed_freeze
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b5eb6906001e4e65"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000b5eb6906001e4e65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 12:31=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qga/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 2b992a55b3..121ff7a748 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -395,7 +395,7 @@ static gint ga_strcmp(gconstpointer str1,
> gconstpointer str2)
>  }
>
>  /* disable commands that aren't safe for fsfreeze */
> -static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
> +static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void
> *opaque)
>  {
>      bool allowed =3D false;
>      int i =3D 0;
> @@ -459,7 +459,7 @@ void ga_set_frozen(GAState *s)
>          return;
>      }
>      /* disable all forbidden (for frozen state) commands */
> -    qmp_for_each_command(&ga_commands, ga_disable_not_allowed, NULL);
> +    qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze,
> NULL);
>      g_warning("disabling logging due to filesystem freeze");
>      ga_disable_logging(s);
>      s->frozen =3D true;
> @@ -1350,7 +1350,7 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>              s->deferred_options.log_filepath =3D config->log_filepath;
>          }
>          ga_disable_logging(s);
> -        qmp_for_each_command(&ga_commands, ga_disable_not_allowed, NULL)=
;
> +        qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze=
,
> NULL);
>      } else {
>          if (config->daemonize) {
>              become_daemon(config->pid_filepath);
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b5eb6906001e4e65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 12:31=E2=80=AF=
PM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk=
@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br></blockquote>=
<div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mail=
to:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><d=
iv>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qga/main.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 2b992a55b3..121ff7a748 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -395,7 +395,7 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer=
 str2)<br>
=C2=A0}<br>
<br>
=C2=A0/* disable commands that aren&#39;t safe for fsfreeze */<br>
-static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)<br=
>
+static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opa=
que)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool allowed =3D false;<br>
=C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
@@ -459,7 +459,7 @@ void ga_set_frozen(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0/* disable all forbidden (for frozen state) commands */=
<br>
-=C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disable_not_allowe=
d, NULL);<br>
+=C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disable_not_allowe=
d_freeze, NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_warning(&quot;disabling logging due to filesystem fre=
eze&quot;);<br>
=C2=A0 =C2=A0 =C2=A0ga_disable_logging(s);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;frozen =3D true;<br>
@@ -1350,7 +1350,7 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;deferred_options.log_=
filepath =3D config-&gt;log_filepath;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_disable_logging(s);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disa=
ble_not_allowed, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disa=
ble_not_allowed_freeze, NULL);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (config-&gt;daemonize) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0become_daemon(config-&gt;pi=
d_filepath);<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000b5eb6906001e4e65--

