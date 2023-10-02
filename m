Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 211AD7B4B98
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:45:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCfL-0002Qe-Gj; Mon, 02 Oct 2023 02:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qnCfJ-0002QV-VV
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qnCfH-0002HO-Nx
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696229057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=32prikGAvIeiRGxuPxo//a91K1q+NdKCwO4MuPJPtCg=;
 b=ee5yvjutuf8MjcP4DPOpdCncztx02e6fvHaYLd5xAPzTL6c1tAKQAKjTlhQxzbkTxjG4HX
 CQMoMQ9YQCnts4rGg/Mf7r4X8ZPgpfK7BXk9eTUPW6FGKYaAzCqyrHfjw7o58boTY5Cm7i
 gCasDNiKbzC8VJeC8fFhAkTx9P1kJDg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Z8_1mRPAMh2nfO984HxSOA-1; Mon, 02 Oct 2023 02:44:08 -0400
X-MC-Unique: Z8_1mRPAMh2nfO984HxSOA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-57b6cd1a530so26337209eaf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696229048; x=1696833848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=32prikGAvIeiRGxuPxo//a91K1q+NdKCwO4MuPJPtCg=;
 b=PypGBfvQx2rHD2LXex13Z13xWX5cPsVu88bNy1T0pHATTeA5e5lfe6nTV9Xg2gjBJA
 nstFdH07hTGdy9+R5emglEJGnmvDdJj3GWOZFHPfovColcLPMceT1XQAmsXovPlxgEcp
 wvPpMIH0dMRHvPt1bOn7LpOL92btzOogEb+JfyVutNrVeXj66RbDMkpsgeGMuAhVgKOh
 D9yrX9/qifF0ReLDBtzLEQPoe0W9N2sHm+WYDU3vohPoaaICJOuTU16LqqhjNn0UH4lT
 Jd5BJDjJxPZNRnEKr9/KekCLl9Llg4UtBCER7IyrZn0E9KKtNC9lggNkulNStCgDQyUl
 UQwQ==
X-Gm-Message-State: AOJu0Yy6bsKYJUDKKk1CcnMRxkwAZbV5I0oTQwZNwLTwA2rzxyju+t0x
 vu4slwifdPLBIcQ8c7gYJ2HAv4vn8FfJ2x/PGjc75A+XmH4e7HhvMlJ4rJRJkwY268Esi99blYP
 +rXu1EhTEHpYXrkw9Pmb9PUtV67dQna4=
X-Received: by 2002:a05:6359:2c8e:b0:151:ac8d:bfe7 with SMTP id
 qw14-20020a0563592c8e00b00151ac8dbfe7mr4736578rwb.22.1696229048146; 
 Sun, 01 Oct 2023 23:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnGBQLn+pUFIyg9oTp8MS+F93FwXIIPOfJ2tM90fGWubnJemTbkbLDEg9c1ZSFLn5LKo6U8lvSXlwTShtDWoU=
X-Received: by 2002:a05:6359:2c8e:b0:151:ac8d:bfe7 with SMTP id
 qw14-20020a0563592c8e00b00151ac8dbfe7mr4736567rwb.22.1696229047873; Sun, 01
 Oct 2023 23:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230908154743.809569-1-aesteve@redhat.com>
 <20230908154743.809569-2-aesteve@redhat.com>
 <20231001161500-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231001161500-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 2 Oct 2023 08:43:56 +0200
Message-ID: <CADSE00J3WaoXS1H7+gekRM18mjOX=ZKqYY5i3WLPvzGhB7e8hQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] util/uuid: add a hash function
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 marcandre.lureau@gmail.com, 
 philmd@linaro.org, cohuck@redhat.com, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000db4c5e0606b619e0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000db4c5e0606b619e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 1, 2023 at 10:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Fri, Sep 08, 2023 at 05:47:40PM +0200, Albert Esteve wrote:
> > Add hash function to uuid module using the
> > djb2 hash algorithm.
> >
> > Add a couple simple unit tests for the hash
> > function, checking collisions for similar UUIDs.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  include/qemu/uuid.h    |  2 ++
> >  tests/unit/test-uuid.c | 27 +++++++++++++++++++++++++++
> >  util/uuid.c            | 15 +++++++++++++++
> >  3 files changed, 44 insertions(+)
> >
> > diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> > index dc40ee1fc9..e24a1099e4 100644
> > --- a/include/qemu/uuid.h
> > +++ b/include/qemu/uuid.h
> > @@ -96,4 +96,6 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid);
> >
> >  QemuUUID qemu_uuid_bswap(QemuUUID uuid);
> >
> > +uint32_t qemu_uuid_hash(const void *uuid);
> > +
> >  #endif
> > diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
> > index c111de5fc1..aedc125ae9 100644
> > --- a/tests/unit/test-uuid.c
> > +++ b/tests/unit/test-uuid.c
> > @@ -171,6 +171,32 @@ static void test_uuid_unparse_strdup(void)
> >      }
> >  }
> >
> > +static void test_uuid_hash(void)
> > +{
> > +    QemuUUID uuid;
> > +    int i;
> > +
> > +    for (i =3D 0; i < 100; i++) {
> > +        qemu_uuid_generate(&uuid);
> > +        /* Obtain the UUID hash */
> > +        uint32_t hash_a =3D qemu_uuid_hash(&uuid);
> > +        int data_idx =3D g_random_int_range(0, 15);
> > +        /* Change a single random byte of the UUID */
> > +        if (uuid.data[data_idx] < 0xFF) {
> > +            uuid.data[data_idx]++;
> > +        } else {
> > +            uuid.data[data_idx]--;
> > +        }
> > +        /* Obtain the UUID hash again */
> > +        uint32_t hash_b =3D qemu_uuid_hash(&uuid);
> > +        /*
> > +         * Both hashes shall be different (avoid collision)
> > +         * for any change in the UUID fields
> > +         */
> > +        g_assert_cmpint(hash_a, !=3D, hash_b);
> > +    }
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      g_test_init(&argc, &argv, NULL);
> > @@ -179,6 +205,7 @@ int main(int argc, char **argv)
> >      g_test_add_func("/uuid/parse", test_uuid_parse);
> >      g_test_add_func("/uuid/unparse", test_uuid_unparse);
> >      g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
> > +    g_test_add_func("/uuid/hash", test_uuid_hash);
> >
> >      return g_test_run();
> >  }
> > diff --git a/util/uuid.c b/util/uuid.c
> > index b1108dde78..b366961bc6 100644
> > --- a/util/uuid.c
> > +++ b/util/uuid.c
> > @@ -116,3 +116,18 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
> >      bswap16s(&uuid.fields.time_high_and_version);
> >      return uuid;
> >  }
> > +
> > +/* djb2 hash algorithm */
> > +uint32_t qemu_uuid_hash(const void *uuid)
> > +{
> > +    QemuUUID *qid =3D (QemuUUID *) uuid;
> > +    uint32_t h =3D 5381;
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(qid->data); i++) {
> > +        h =3D (h << 5) + h + qid->data[i];
> > +    }
> > +
> > +    return h;
> > +}
> > +
>
> whitespace error:
>
> .git/rebase-apply/patch:85: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
>

Ok, I will send a new revision.


>
>
>
>
> > --
> > 2.41.0
>
>

--000000000000db4c5e0606b619e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div><br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Oct 1, 2023 at 10=
:15=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri, Sep 08, 2023 at 05:47:40PM +0200, Albert Esteve wrote:<b=
r>
&gt; Add hash function to uuid module using the<br>
&gt; djb2 hash algorithm.<br>
&gt; <br>
&gt; Add a couple simple unit tests for the hash<br>
&gt; function, checking collisions for similar UUIDs.<br>
&gt; <br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/qemu/uuid.h=C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 tests/unit/test-uuid.c | 27 +++++++++++++++++++++++++++<br>
&gt;=C2=A0 util/uuid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15 ++++++=
+++++++++<br>
&gt;=C2=A0 3 files changed, 44 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h<br>
&gt; index dc40ee1fc9..e24a1099e4 100644<br>
&gt; --- a/include/qemu/uuid.h<br>
&gt; +++ b/include/qemu/uuid.h<br>
&gt; @@ -96,4 +96,6 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid)=
;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 QemuUUID qemu_uuid_bswap(QemuUUID uuid);<br>
&gt;=C2=A0 <br>
&gt; +uint32_t qemu_uuid_hash(const void *uuid);<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c<br>
&gt; index c111de5fc1..aedc125ae9 100644<br>
&gt; --- a/tests/unit/test-uuid.c<br>
&gt; +++ b/tests/unit/test-uuid.c<br>
&gt; @@ -171,6 +171,32 @@ static void test_uuid_unparse_strdup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void test_uuid_hash(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QemuUUID uuid;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; 100; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Obtain the UUID hash */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t hash_a =3D qemu_uuid_hash(&amp;u=
uid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int data_idx =3D g_random_int_range(0, 15=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Change a single random byte of the UUI=
D */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uuid.data[data_idx] &lt; 0xFF) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid.data[data_idx]++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid.data[data_idx]--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Obtain the UUID hash again */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t hash_b =3D qemu_uuid_hash(&amp;u=
uid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Both hashes shall be different (a=
void collision)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* for any change in the UUID fields=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(hash_a, !=3D, hash_b);<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
&gt; @@ -179,6 +205,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/uuid/parse&quot;, test_uuid=
_parse);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/uuid/unparse&quot;, test_uu=
id_unparse);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/uuid/unparse_strdup&quot;, =
test_uuid_unparse_strdup);<br>
&gt; +=C2=A0 =C2=A0 g_test_add_func(&quot;/uuid/hash&quot;, test_uuid_hash)=
;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return g_test_run();<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/util/uuid.c b/util/uuid.c<br>
&gt; index b1108dde78..b366961bc6 100644<br>
&gt; --- a/util/uuid.c<br>
&gt; +++ b/util/uuid.c<br>
&gt; @@ -116,3 +116,18 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bswap16s(&amp;uuid.fields.time_high_and_version);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 return uuid;<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +/* djb2 hash algorithm */<br>
&gt; +uint32_t qemu_uuid_hash(const void *uuid)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QemuUUID *qid =3D (QemuUUID *) uuid;<br>
&gt; +=C2=A0 =C2=A0 uint32_t h =3D 5381;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(qid-&gt;data); i++) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D (h &lt;&lt; 5) + h + qid-&gt;data[i=
];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return h;<br>
&gt; +}<br>
&gt; +<br>
<br>
whitespace error:<br>
<br>
.git/rebase-apply/patch:85: new blank line at EOF.<br>
+<br>
warning: 1 line adds whitespace errors.<br></blockquote><div><br></div><div=
>Ok, I will send a new revision.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
<br>
<br>
<br>
&gt; -- <br>
&gt; 2.41.0<br>
<br>
</blockquote></div></div>

--000000000000db4c5e0606b619e0--


