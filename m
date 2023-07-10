Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B774D139
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIn2T-0005JB-6a; Mon, 10 Jul 2023 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qIn2L-0005I2-SN
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:18:30 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qIn2I-0005xI-M3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:18:29 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-40388dc19ecso18783041cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688980702; x=1691572702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PK8jGb+DgT9n49EZtX9PUkDR6Ko1AxCJH7U6KUJV4J4=;
 b=jxjOLRYLoEdk7oJQxkQFEtZ/HvpQEND+0JKFk0xYoitZnuR/I8z3BNGtVIM3HK/IyN
 lAuBflV69580m0WbvO8z+FKxXuV1kdIcmbXn5UQ/DOFJ6JjPagIuTuVOkaY0iIpNJpm9
 o2SDaLXlDvQFKIcCRHphOYCtlon22d5aQVflqDFumBsQBOHz0CoDskMbPxk5bopdNQkF
 Y/csxWFOftG76izd5+gwpAV41zYvmaaGAD5SR6wJwhWxFhQ3p/nxTPTpxfJhMRg+xfGX
 +2X4S+61pIVyPp240iEPhWiAN6GxzpDLcoFB9bIekxx6ch/27p/VOqD/iaXYaNYqztEk
 hapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688980702; x=1691572702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PK8jGb+DgT9n49EZtX9PUkDR6Ko1AxCJH7U6KUJV4J4=;
 b=TdTMaY67+BDQJ4u/0Z6bqax3/DkW6hGzZ/sJh4X6SwWk8Ez5TcPiIywAb6ua8ydTsK
 0Lu5NB++bK5HW5AR/MSFeqUoB0z2yli0fbBvCwSbLtXZ3VQCUuW1YkflZzBoqxqqT0t3
 eXgCcqiNjnaNSbhlltauWNAVL548sZa+aOepGCREuKp1Jp0elSvTRHOaXdGCi034WWYp
 sug+Nb9w2zcVaztc0inAampqgfFJLchA3t38aXDbQskE+B2Hwl/jXoJVtmoax8dF0tiW
 6tXuoYox4TW+7IQwHNk6mJi/ube7q3cGYijKwq++0Ynlpe8Dwbe8RxOj/8p53KvyW6Ps
 BOHA==
X-Gm-Message-State: ABy/qLY/Cpr6LVvkYUEzAA3xSTqP0FmQN7HjFwPWp7QfNUz7FjZk2l3j
 rWwFf9bBVeyKaHCKd0mwRHRAGpnLXAvJ8OkTQ/BZT8ALSKc=
X-Google-Smtp-Source: APBJJlE8m5vZb2kEFQaAzyJcRG5Mztdkibf9otIDL8xbY0hgufSdvzLzcHYkK0isNOqwCs1nNHcDkCQGFbc4fv4mvgs=
X-Received: by 2002:a05:622a:1b9e:b0:3f5:7cfa:f5e9 with SMTP id
 bp30-20020a05622a1b9e00b003f57cfaf5e9mr12941272qtb.13.1688980702628; Mon, 10
 Jul 2023 02:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230706083035.623802-1-kkostiuk@redhat.com>
 <20230706083035.623802-4-kkostiuk@redhat.com>
In-Reply-To: <20230706083035.623802-4-kkostiuk@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jul 2023 13:18:10 +0400
Message-ID: <CAJ+F1C+p1F7SewqxGRTqddZPA=W56bxtJPrGkg8j7QSZDpRg8w@mail.gmail.com>
Subject: Re: [PATCH 3/3] qga: Add tests for --allow-rpcs option
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000d0136e06001e76db"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

--000000000000d0136e06001e76db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 12:32=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/unit/test-qga.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
> index 360b4cab23..671e83cb86 100644
> --- a/tests/unit/test-qga.c
> +++ b/tests/unit/test-qga.c
> @@ -665,6 +665,36 @@ static void test_qga_blockedrpcs(gconstpointer data)
>      fixture_tear_down(&fix, NULL);
>  }
>
> +static void test_qga_allowedrpcs(gconstpointer data)
> +{
> +    TestFixture fix;
> +    QDict *ret, *error;
> +    const gchar *class, *desc;
> +
> +    fixture_setup(&fix, "-a guest-ping,guest-get-time", NULL);
> +
> +    /* check allowed RPCs */
> +    ret =3D qmp_fd(fix.fd, "{'execute': 'guest-ping'}");
> +    qmp_assert_no_error(ret);
> +    qobject_unref(ret);
> +
> +    ret =3D qmp_fd(fix.fd, "{'execute': 'guest-get-time'}");
> +    qmp_assert_no_error(ret);
> +    qobject_unref(ret);
> +
> +    /* check something else */
> +    ret =3D qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
> +    g_assert_nonnull(ret);
> +    error =3D qdict_get_qdict(ret, "error");
> +    class =3D qdict_get_try_str(error, "class");
> +    desc =3D qdict_get_try_str(error, "desc");
> +    g_assert_cmpstr(class, =3D=3D, "CommandNotFound");
> +    g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
> +    qobject_unref(ret);
> +
> +    fixture_tear_down(&fix, NULL);
> +}
> +
>  static void test_qga_config(gconstpointer data)
>  {
>      GError *error =3D NULL;
> @@ -1090,6 +1120,7 @@ int main(int argc, char **argv)
>                           test_qga_fsfreeze_status);
>
>      g_test_add_data_func("/qga/blockedrpcs", NULL, test_qga_blockedrpcs)=
;
> +    g_test_add_data_func("/qga/allowedrpcs", NULL, test_qga_allowedrpcs)=
;
>      g_test_add_data_func("/qga/config", NULL, test_qga_config);
>      g_test_add_data_func("/qga/guest-exec", &fix, test_qga_guest_exec);
>      g_test_add_data_func("/qga/guest-exec-separated", &fix,
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d0136e06001e76db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 12:32=E2=80=AF=
PM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk=
@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br></blockquote>=
<div><br></div><div><br></div><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau=
 &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat=
.com</a>&gt;</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
---<br>
=C2=A0tests/unit/test-qga.c | 31 +++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 31 insertions(+)<br>
<br>
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c<br>
index 360b4cab23..671e83cb86 100644<br>
--- a/tests/unit/test-qga.c<br>
+++ b/tests/unit/test-qga.c<br>
@@ -665,6 +665,36 @@ static void test_qga_blockedrpcs(gconstpointer data)<b=
r>
=C2=A0 =C2=A0 =C2=A0fixture_tear_down(&amp;fix, NULL);<br>
=C2=A0}<br>
<br>
+static void test_qga_allowedrpcs(gconstpointer data)<br>
+{<br>
+=C2=A0 =C2=A0 TestFixture fix;<br>
+=C2=A0 =C2=A0 QDict *ret, *error;<br>
+=C2=A0 =C2=A0 const gchar *class, *desc;<br>
+<br>
+=C2=A0 =C2=A0 fixture_setup(&amp;fix, &quot;-a guest-ping,guest-get-time&q=
uot;, NULL);<br>
+<br>
+=C2=A0 =C2=A0 /* check allowed RPCs */<br>
+=C2=A0 =C2=A0 ret =3D qmp_fd(fix.fd, &quot;{&#39;execute&#39;: &#39;guest-=
ping&#39;}&quot;);<br>
+=C2=A0 =C2=A0 qmp_assert_no_error(ret);<br>
+=C2=A0 =C2=A0 qobject_unref(ret);<br>
+<br>
+=C2=A0 =C2=A0 ret =3D qmp_fd(fix.fd, &quot;{&#39;execute&#39;: &#39;guest-=
get-time&#39;}&quot;);<br>
+=C2=A0 =C2=A0 qmp_assert_no_error(ret);<br>
+=C2=A0 =C2=A0 qobject_unref(ret);<br>
+<br>
+=C2=A0 =C2=A0 /* check something else */<br>
+=C2=A0 =C2=A0 ret =3D qmp_fd(fix.fd, &quot;{&#39;execute&#39;: &#39;guest-=
get-fsinfo&#39;}&quot;);<br>
+=C2=A0 =C2=A0 g_assert_nonnull(ret);<br>
+=C2=A0 =C2=A0 error =3D qdict_get_qdict(ret, &quot;error&quot;);<br>
+=C2=A0 =C2=A0 class =3D qdict_get_try_str(error, &quot;class&quot;);<br>
+=C2=A0 =C2=A0 desc =3D qdict_get_try_str(error, &quot;desc&quot;);<br>
+=C2=A0 =C2=A0 g_assert_cmpstr(class, =3D=3D, &quot;CommandNotFound&quot;);=
<br>
+=C2=A0 =C2=A0 g_assert_nonnull(g_strstr_len(desc, -1, &quot;has been disab=
led&quot;));<br>
+=C2=A0 =C2=A0 qobject_unref(ret);<br>
+<br>
+=C2=A0 =C2=A0 fixture_tear_down(&amp;fix, NULL);<br>
+}<br>
+<br>
=C2=A0static void test_qga_config(gconstpointer data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GError *error =3D NULL;<br>
@@ -1090,6 +1120,7 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 test_qga_fsfreeze_status);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_data_func(&quot;/qga/blockedrpcs&quot;, NULL=
, test_qga_blockedrpcs);<br>
+=C2=A0 =C2=A0 g_test_add_data_func(&quot;/qga/allowedrpcs&quot;, NULL, tes=
t_qga_allowedrpcs);<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_data_func(&quot;/qga/config&quot;, NULL, tes=
t_qga_config);<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_data_func(&quot;/qga/guest-exec&quot;, &amp;=
fix, test_qga_guest_exec);<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_data_func(&quot;/qga/guest-exec-separated&qu=
ot;, &amp;fix,<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d0136e06001e76db--

