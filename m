Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AACC746107
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMqC-0004C0-SD; Mon, 03 Jul 2023 12:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qGMq9-0004Ba-Sq
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:55:54 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qGMq7-0003ZE-Gb
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:55:53 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b5c231c23aso75177921fa.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1688403348; x=1690995348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NNfbdUqM5KbTmuCCFVpK/nmBokcpTVNbBCVI2hpUUrg=;
 b=rSkbhgbDz7B5ahyAfZ9MFkmS5+ggKKMVM/OBHwjlyH7iEjo3C9cXlEuwREjXIaBUoI
 tlOUanID0mK1b+tyImyTTD0HMeQap4vUquYFejv7Id24izDzDJs0KIZZ4Eaou9X7P/Jr
 /NJUy2wROW/ie2mj9RFDH1ukD4jU+JcqAsV0StCnCmqhGfhK/b+j05aSmvNfYrMsmrh8
 Og0W6Nn8UlPR651vhIW9SJPJwfpFuInivEMNNj5EVfq7ps8+elfjpJNZrjjTs/o3uonr
 ilvsyDSi0mr1AofzjkuXwki1VNCRo7I2iW8eZEcPnGsmMJJzf3TtEY75BwQlCSvcf/Vx
 K7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688403348; x=1690995348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NNfbdUqM5KbTmuCCFVpK/nmBokcpTVNbBCVI2hpUUrg=;
 b=UxxEux6ZME8Jhh478VcdjvwYRveqm871zA9cMlihxXUasBhPXxVQrjyVJMN85VCUHi
 3AVq/Hx2F/uFg2zUmz9k6MuCQIlMuCPYzAuDRqr2kPUPQWSYZa74nFdnaXRY8qWVB41r
 5pjkZdceAoOUtalUOx6zFqUZSBuCQYLNaS9vtiJX6HoUyq/6CdrRJTqHWP9X49vSc/Eq
 wLY5tj1OP8LQqk9n6BU1onikyPW4txctfx058h2cXsEARpNiLa5fj6MUPXgseYl0K4QI
 WmunJSC+Al8XkA2FU5Yz3A+LOTS9K8NmxO5RIreKTQSCauE3lY1MR/UIdjMbeP1eXlf1
 WeLA==
X-Gm-Message-State: ABy/qLYK+swZhwwcOg6g20wbycXRW4w48UPKB6bOqVucvCxOaVeHQLv0
 777ZRb0CJTlfTgu1bYomyO90gonnXYI1PIkJfmTq4g==
X-Google-Smtp-Source: APBJJlFozWGomRFa5nfqO5nJEF2/Y/Ya3CPxC7/2G+rA0XqwtdAjcxkEzE9ix7CjNfrrERl6Qu074ZDV+rW5Fv5gkZw=
X-Received: by 2002:a2e:9483:0:b0:2b6:a682:9aa5 with SMTP id
 c3-20020a2e9483000000b002b6a6829aa5mr5951529ljh.38.1688403348549; Mon, 03 Jul
 2023 09:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-5-fufuyqqqqqq@gmail.com> <87ilb1gd9h.fsf@linaro.org>
In-Reply-To: <87ilb1gd9h.fsf@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 3 Jul 2023 10:55:37 -0600
Message-ID: <CANCZdfrDpAkVgm7p5uFo=W3Kd1_DqWPt7j301zp3WBPR3pOEFQ@mail.gmail.com>
Subject: Re: [RFC v3 04/10] linux-user: Implement envlist_appendenv
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Yeqi Fu <fufuyqqqqqq@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d408aa05ff980953"
Received-SPF: none client-ip=2a00:1450:4864:20::232;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000d408aa05ff980953
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 3, 2023, 10:40 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

>
> Yeqi Fu <fufuyqqqqqq@gmail.com> writes:
>
> > Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> > ---
> >  include/qemu/envlist.h |  1 +
> >  util/envlist.c         | 61 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+)
> >
> > diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h
> > index 6006dfae44..865eb18e17 100644
> > --- a/include/qemu/envlist.h
> > +++ b/include/qemu/envlist.h
> > @@ -7,6 +7,7 @@ envlist_t *envlist_create(void);
> >  void envlist_free(envlist_t *);
> >  int envlist_setenv(envlist_t *, const char *);
> >  int envlist_unsetenv(envlist_t *, const char *);
> > +int envlist_appendenv(envlist_t *, const char *, const char *);
> >  int envlist_parse_set(envlist_t *, const char *);
> >  int envlist_parse_unset(envlist_t *, const char *);
> >  char **envlist_to_environ(const envlist_t *, size_t *);
> > diff --git a/util/envlist.c b/util/envlist.c
> > index db937c0427..635c9c4fab 100644
> > --- a/util/envlist.c
> > +++ b/util/envlist.c
> > @@ -201,6 +201,67 @@ envlist_unsetenv(envlist_t *envlist, const char
> *env)
> >      return (0);
>

No parens here

>  }
> >
> > +/*
> > + * Appends environment value to envlist. If the environment
> > + * variable already exists, the new value is appended to the
> > + * existing one.
> > + *
> > + * Returns 0 in success, errno otherwise.
> > + */
> > +int
> > +envlist_appendenv(envlist_t *envlist, const char *env, const char
> *separator)
> > +{
> > +    struct envlist_entry *entry =3D NULL;
> > +    const char *eq_sign;
> > +    size_t envname_len;
> > +
> > +    if ((envlist =3D=3D NULL) || (env =3D=3D NULL) || (separator =3D=
=3D NULL)) {
> > +        return (EINVAL);
>
> No () around the EINVAL needed here.
>

And elsewhere...

Warner

> +    }
> > +
> > +    /* find out first equals sign in given env */
> > +    eq_sign =3D strchr(env, '=3D');
> > +    if (eq_sign =3D=3D NULL) {
> > +        return (EINVAL);
> > +    }
> > +
> > +    if (strchr(eq_sign + 1, '=3D') !=3D NULL) {
> > +        return (EINVAL);
> > +    }
> > +
> > +    envname_len =3D eq_sign - env + 1;
> > +
> > +    /*
> > +     * If there already exists variable with given name,
> > +     * we append the new value to the existing one.
> > +     */
> > +    for (entry =3D envlist->el_entries.lh_first; entry !=3D NULL;
> > +        entry =3D entry->ev_link.le_next) {
> > +        if (strncmp(entry->ev_var, env, envname_len) =3D=3D 0) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (entry !=3D NULL) {
> > +        char *new_env_value =3D NULL;
> > +        size_t new_env_len =3D strlen(entry->ev_var) + strlen(eq_sign)
> > +            + strlen(separator) + 1;
> > +        new_env_value =3D g_malloc(new_env_len);
> > +        strcpy(new_env_value, entry->ev_var);
> > +        strcat(new_env_value, separator);
> > +        strcat(new_env_value, eq_sign + 1);
> > +        g_free((char *)entry->ev_var);
> > +        entry->ev_var =3D new_env_value;
> > +    } else {
> > +        envlist->el_count++;
> > +        entry =3D g_malloc(sizeof(*entry));
> > +        entry->ev_var =3D g_strdup(env);
> > +        QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
> > +    }
> > +
> > +    return (0);
> > +}
> > +
>
> We really should add something to tests/unit/test-env to check the
> various operations work as expected.
>
>
> >  /*
> >   * Returns given envlist as array of strings (in same form that
> >   * global variable environ is).  Caller must free returned memory
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--000000000000d408aa05ff980953
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Jul 3, 2023, 10:40 AM Alex Benn=C3=A9e &lt;<a =
href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><br>
Yeqi Fu &lt;<a href=3D"mailto:fufuyqqqqqq@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">fufuyqqqqqq@gmail.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: Yeqi Fu &lt;<a href=3D"mailto:fufuyqqqqqq@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">fufuyqqqqqq@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/qemu/envlist.h |=C2=A0 1 +<br>
&gt;=C2=A0 util/envlist.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 61 +++++++++++=
+++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 62 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h<br>
&gt; index 6006dfae44..865eb18e17 100644<br>
&gt; --- a/include/qemu/envlist.h<br>
&gt; +++ b/include/qemu/envlist.h<br>
&gt; @@ -7,6 +7,7 @@ envlist_t *envlist_create(void);<br>
&gt;=C2=A0 void envlist_free(envlist_t *);<br>
&gt;=C2=A0 int envlist_setenv(envlist_t *, const char *);<br>
&gt;=C2=A0 int envlist_unsetenv(envlist_t *, const char *);<br>
&gt; +int envlist_appendenv(envlist_t *, const char *, const char *);<br>
&gt;=C2=A0 int envlist_parse_set(envlist_t *, const char *);<br>
&gt;=C2=A0 int envlist_parse_unset(envlist_t *, const char *);<br>
&gt;=C2=A0 char **envlist_to_environ(const envlist_t *, size_t *);<br>
&gt; diff --git a/util/envlist.c b/util/envlist.c<br>
&gt; index db937c0427..635c9c4fab 100644<br>
&gt; --- a/util/envlist.c<br>
&gt; +++ b/util/envlist.c<br>
&gt; @@ -201,6 +201,67 @@ envlist_unsetenv(envlist_t *envlist, const char *=
env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return (0);<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">No parens here</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * Appends environment value to envlist. If the environment<br>
&gt; + * variable already exists, the new value is appended to the<br>
&gt; + * existing one.<br>
&gt; + *<br>
&gt; + * Returns 0 in success, errno otherwise.<br>
&gt; + */<br>
&gt; +int<br>
&gt; +envlist_appendenv(envlist_t *envlist, const char *env, const char *se=
parator)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct envlist_entry *entry =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *eq_sign;<br>
&gt; +=C2=A0 =C2=A0 size_t envname_len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((envlist =3D=3D NULL) || (env =3D=3D NULL) || (sepa=
rator =3D=3D NULL)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (EINVAL);<br>
<br>
No () around the EINVAL needed here.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">And elsewhere...</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Warner=C2=A0</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* find out first equals sign in given env */<br>
&gt; +=C2=A0 =C2=A0 eq_sign =3D strchr(env, &#39;=3D&#39;);<br>
&gt; +=C2=A0 =C2=A0 if (eq_sign =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (EINVAL);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (strchr(eq_sign + 1, &#39;=3D&#39;) !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (EINVAL);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 envname_len =3D eq_sign - env + 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If there already exists variable with given nam=
e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* we append the new value to the existing one.<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 for (entry =3D envlist-&gt;el_entries.lh_first; entry !=
=3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D entry-&gt;ev_link.le_next) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strncmp(entry-&gt;ev_var, env, envnam=
e_len) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (entry !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *new_env_value =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t new_env_len =3D strlen(entry-&gt;e=
v_var) + strlen(eq_sign)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + strlen(separator) + 1;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_env_value =3D g_malloc(new_env_len);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy(new_env_value, entry-&gt;ev_var);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strcat(new_env_value, separator);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strcat(new_env_value, eq_sign + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free((char *)entry-&gt;ev_var);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;ev_var =3D new_env_value;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 envlist-&gt;el_count++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D g_malloc(sizeof(*entry));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;ev_var =3D g_strdup(env);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIST_INSERT_HEAD(&amp;envlist-&gt;el_ent=
ries, entry, ev_link);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (0);<br>
&gt; +}<br>
&gt; +<br>
<br>
We really should add something to tests/unit/test-env to check the<br>
various operations work as expected.<br>
<br>
<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Returns given envlist as array of strings (in same form =
that<br>
&gt;=C2=A0 =C2=A0* global variable environ is).=C2=A0 Caller must free retu=
rned memory<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div></div>

--000000000000d408aa05ff980953--

