Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A801770A623
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 09:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0GwU-00005p-0p; Sat, 20 May 2023 03:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q0GwR-00005N-I9
 for qemu-devel@nongnu.org; Sat, 20 May 2023 03:23:51 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q0GwP-0005T7-EU
 for qemu-devel@nongnu.org; Sat, 20 May 2023 03:23:51 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2af2602848aso16187381fa.2
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684567427; x=1687159427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6KjHfPZ+5oVUfHJpPiEcXT2aQwdnSQnVd80tLX+j6m8=;
 b=mR7/ZzqfkGtdwccuhQGvz2EWQdO8Py9aS0JYMOcWXc2UYzerCf7kRSjPto2h/6JkwE
 QOwY00wdzQ1QRLktfpo1y75z2JJpBIYhACbmxqZiRT45eVT+sWz6HOwZsC1yEOYwzc9J
 UG9KD6wNmlquUydef7LEAMKj7n8bSM6SK9sr4BOjTDwUJArWLrOg/mdHRw5t1KqZ8JaY
 gxjI984qXrp2YSbvdt2TYG70N0oeotlNd1OIFRygyoFLp1ULlPgAgJdBzwuJ1T7VbbSe
 PtsHQYAKkN4s6DdMk80qa1V4+3ws5hKQ6mZupldcopLCrfESB4yKOH1pOB/s/OXDq0zJ
 Dshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684567427; x=1687159427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KjHfPZ+5oVUfHJpPiEcXT2aQwdnSQnVd80tLX+j6m8=;
 b=Z3zPYx6bj2BzqbcQlWJdlL9pOxV36SDsEf2otDJqnw93GUYvT2US9rmadj+HPLG3xx
 d8QhhQpK0N15dHs36eH0P16RHJR1vlP45sUNVvzaGkUHTGeCj6IrFkCLCS4UX8D/z5TB
 6QEh7b4QpOHzM4ypIcNC5PZzvjjOhSOTA2MClqCgAsvQCtOtKothn+Gq3uKdD2WV3Qxv
 PxTSbpJunX+OS/faXyRjO4HYcZ+FpQ9A191VKIhroSPp8lxk5V76zvKCZI28JwUYyzpU
 3J1IcTpVkLYAyb5D8Kh26ig8E+5eaI5n0QiLEIHWAeWucrOlHdtXOcCuRnmc8ubize7V
 BbxA==
X-Gm-Message-State: AC+VfDyB/BkV90jpeW4YkUISEf1FlEFmQsCAb3L3LUHjNcmSfEv8E6Vt
 NzesBDN0KDGp+EPYRDKikIJg1XqH3/Spu9PBeUI=
X-Google-Smtp-Source: ACHHUZ5LniEXAHtFmFWhedKVvSNtr1gUhBZLlfauB2c5Yam8z4LZ6jCow1QQ6IDG+zmiaUZN7oX4oIWyd2xq4z6HeKI=
X-Received: by 2002:ac2:4850:0:b0:4f2:5007:bd7f with SMTP id
 16-20020ac24850000000b004f25007bd7fmr1452551lfy.36.1684567427016; Sat, 20 May
 2023 00:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230518120258.1394135-1-aesteve@redhat.com>
 <20230518120258.1394135-2-aesteve@redhat.com>
In-Reply-To: <20230518120258.1394135-2-aesteve@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 20 May 2023 11:23:35 +0400
Message-ID: <CAJ+F1CLD6FtZAdAOKrNktTpx-nV+QF04MAiibJJU0z+TSsR+6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] uuid: add hash_func and equal_func
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Fam Zheng <fam@euphon.net>, cohuck@redhat.com
Content-Type: multipart/alternative; boundary="000000000000166e5605fc1aebca"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x22f.google.com
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

--000000000000166e5605fc1aebca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 18, 2023 at 4:03=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:

> Add hash and an equal function to uuid module.
>
> Add a couple simple unit tests for new functions,
> checking collisions for similar UUIDs in the case
> of the hash function, and comparing generated UUIDs
> for the equal function.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/qemu/uuid.h    |  4 ++++
>  tests/unit/test-uuid.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  util/uuid.c            | 38 ++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index dc40ee1fc9..136df682c9 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -96,4 +96,8 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid);
>
>  QemuUUID qemu_uuid_bswap(QemuUUID uuid);
>
> +uint32_t qemu_uuid_hash(const void *uuid);
> +
> +int qemu_uuid_equal(const void *lhv, const void *rhv);
>

There is already qemu_uuid_is_equal()


> +
>  #endif
> diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
> index c111de5fc1..8c865869d5 100644
> --- a/tests/unit/test-uuid.c
> +++ b/tests/unit/test-uuid.c
> @@ -171,6 +171,50 @@ static void test_uuid_unparse_strdup(void)
>      }
>  }
>
> +static void test_uuid_hash(void)
> +{
> +    QemuUUID uuid;
> +    int i;
> +
> +    for (i =3D 0; i < 100; i++) {
> +        qemu_uuid_generate(&uuid);
> +        /* Obtain the UUID hash */
> +        uint32_t hash_a =3D qemu_uuid_hash(&uuid);
> +        int data_idx =3D g_random_int_range(0, 15);
> +        /* Change a single random byte of the UUID */
> +        if (uuid.data[data_idx] < 0xFF) {
> +            uuid.data[data_idx]++;
> +        } else {
> +            uuid.data[data_idx]--;
> +        }
> +        /* Obtain the UUID hash again */
> +        uint32_t hash_b =3D qemu_uuid_hash(&uuid);
> +        /*
> +         * Both hashes shall be different (avoid collision)
> +         * for any change in the UUID fields
> +         */
> +        g_assert_cmpint(hash_a, !=3D, hash_b);
> +    }
> +}
> +
> +static void test_uuid_equal(void)
> +{
> +    QemuUUID uuid_a, uuid_b, uuid_c;
> +    int i;
> +
> +    for (i =3D 0; i < 100; i++) {
> +        qemu_uuid_generate(&uuid_a);
> +        qemu_uuid_generate(&uuid_b);
> +        memcpy(&uuid_c, &uuid_a, sizeof(uuid_a));
> +
> +        g_assert(qemu_uuid_equal(&uuid_a, &uuid_a));
> +        g_assert(qemu_uuid_equal(&uuid_b, &uuid_b));
> +        g_assert(qemu_uuid_equal(&uuid_a, &uuid_c));
> +        g_assert_false(qemu_uuid_equal(&uuid_a, &uuid_b));
> +        g_assert_false(qemu_uuid_equal(NULL, NULL));
> +    }
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -179,6 +223,8 @@ int main(int argc, char **argv)
>      g_test_add_func("/uuid/parse", test_uuid_parse);
>      g_test_add_func("/uuid/unparse", test_uuid_unparse);
>      g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
> +    g_test_add_func("/uuid/hash", test_uuid_hash);
> +    g_test_add_func("/uuid/equal", test_uuid_equal);
>
>      return g_test_run();
>  }
> diff --git a/util/uuid.c b/util/uuid.c
> index b1108dde78..efa9b0a0e4 100644
> --- a/util/uuid.c
> +++ b/util/uuid.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/uuid.h"
>  #include "qemu/bswap.h"
> +#include "qemu/xxhash.h"
>
>  void qemu_uuid_generate(QemuUUID *uuid)
>  {
> @@ -116,3 +117,40 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
>      bswap16s(&uuid.fields.time_high_and_version);
>      return uuid;
>  }
> +
> +uint32_t qemu_uuid_hash(const void *uuid)
> +{
> +    QemuUUID *id =3D (QemuUUID *) uuid;
> +    uint64_t ab =3D (id->fields.time_low) |
> +                  (((uint64_t) id->fields.time_mid) << 32) |
> +                  (((uint64_t) id->fields.time_high_and_version) << 48);
> +    uint64_t cd =3D (id->fields.clock_seq_and_reserved) |
> +                  (id->fields.clock_seq_low << 8);
> +    int i =3D 0, shift =3D 8;
> +
> +    for (; i < 6; i++) {
> +        shift +=3D 8;
> +        cd |=3D ((uint64_t) id->fields.node[i]) << shift;
> +    }
> +
> +    return qemu_xxhash4(ab, cd);
> +
>

That looks quite complex, and I have no idea if this is a good hash or not.

Instead I would implement the traditional "djb" hash over the char[16] data
(see g_str_hash implementation for \0-terminated implementation)


> }
> +
> +int qemu_uuid_equal(const void *lhv, const void *rhv)
> +{
> +    int i;
> +    QemuUUID *lid =3D (QemuUUID *) lhv;
> +    QemuUUID *rid =3D (QemuUUID *) rhv;
> +    if (lid =3D=3D NULL || rid =3D=3D NULL) {
> +        return 0;
> +    }
> +    if (lid =3D=3D rid) {
> +        return 1;
> +    }
> +    for (i =3D 0; i < 16; i++) {
> +        if (lid->data[i] !=3D rid->data[i]) {
> +            return 0;
> +        }
> +    }
> +    return 1;
> +}
> --
> 2.40.0
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000166e5605fc1aebca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 18, 2023 at 4:03=E2=80=
=AFPM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Add hash and an equal function to uuid module.<br>
<br>
Add a couple simple unit tests for new functions,<br>
checking collisions for similar UUIDs in the case<br>
of the hash function, and comparing generated UUIDs<br>
for the equal function.<br>
<br>
Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" targ=
et=3D"_blank">aesteve@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/qemu/uuid.h=C2=A0 =C2=A0 |=C2=A0 4 ++++<br>
=C2=A0tests/unit/test-uuid.c | 46 +++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0util/uuid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 38 +++++++++++=
+++++++++++++++++++++++<br>
=C2=A03 files changed, 88 insertions(+)<br>
<br>
diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h<br>
index dc40ee1fc9..136df682c9 100644<br>
--- a/include/qemu/uuid.h<br>
+++ b/include/qemu/uuid.h<br>
@@ -96,4 +96,8 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid);<br>
<br>
=C2=A0QemuUUID qemu_uuid_bswap(QemuUUID uuid);<br>
<br>
+uint32_t qemu_uuid_hash(const void *uuid);<br>
+<br>
+int qemu_uuid_equal(const void *lhv, const void *rhv);<br></blockquote><di=
v><br></div><div>There is already qemu_uuid_is_equal()</div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#endif<br>
diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c<br>
index c111de5fc1..8c865869d5 100644<br>
--- a/tests/unit/test-uuid.c<br>
+++ b/tests/unit/test-uuid.c<br>
@@ -171,6 +171,50 @@ static void test_uuid_unparse_strdup(void)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void test_uuid_hash(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 100; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Obtain the UUID hash */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t hash_a =3D qemu_uuid_hash(&amp;uuid);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int data_idx =3D g_random_int_range(0, 15);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Change a single random byte of the UUID */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uuid.data[data_idx] &lt; 0xFF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid.data[data_idx]++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid.data[data_idx]--;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Obtain the UUID hash again */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t hash_b =3D qemu_uuid_hash(&amp;uuid);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Both hashes shall be different (avoid =
collision)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* for any change in the UUID fields<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(hash_a, !=3D, hash_b);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void test_uuid_equal(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid_a, uuid_b, uuid_c;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 100; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid_a);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid_b);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;uuid_c, &amp;uuid_a, sizeof(uuid_a=
));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(qemu_uuid_equal(&amp;uuid_a, &amp;uui=
d_a));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(qemu_uuid_equal(&amp;uuid_b, &amp;uui=
d_b));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(qemu_uuid_equal(&amp;uuid_a, &amp;uui=
d_c));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(qemu_uuid_equal(&amp;uuid_a, &a=
mp;uuid_b));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(qemu_uuid_equal(NULL, NULL));<b=
r>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0int main(int argc, char **argv)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
@@ -179,6 +223,8 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_func(&quot;/uuid/parse&quot;, test_uuid_pars=
e);<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_func(&quot;/uuid/unparse&quot;, test_uuid_un=
parse);<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_func(&quot;/uuid/unparse_strdup&quot;, test_=
uuid_unparse_strdup);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/uuid/hash&quot;, test_uuid_hash);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/uuid/equal&quot;, test_uuid_equal);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0return g_test_run();<br>
=C2=A0}<br>
diff --git a/util/uuid.c b/util/uuid.c<br>
index b1108dde78..efa9b0a0e4 100644<br>
--- a/util/uuid.c<br>
+++ b/util/uuid.c<br>
@@ -16,6 +16,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/uuid.h&quot;<br>
=C2=A0#include &quot;qemu/bswap.h&quot;<br>
+#include &quot;qemu/xxhash.h&quot;<br>
<br>
=C2=A0void qemu_uuid_generate(QemuUUID *uuid)<br>
=C2=A0{<br>
@@ -116,3 +117,40 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)<br>
=C2=A0 =C2=A0 =C2=A0bswap16s(&amp;uuid.fields.time_high_and_version);<br>
=C2=A0 =C2=A0 =C2=A0return uuid;<br>
=C2=A0}<br>
+<br>
+uint32_t qemu_uuid_hash(const void *uuid)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID *id =3D (QemuUUID *) uuid;<br>
+=C2=A0 =C2=A0 uint64_t ab =3D (id-&gt;fields.time_low) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((uint64_t=
) id-&gt;fields.time_mid) &lt;&lt; 32) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((uint64_t=
) id-&gt;fields.time_high_and_version) &lt;&lt; 48);<br>
+=C2=A0 =C2=A0 uint64_t cd =3D (id-&gt;fields.clock_seq_and_reserved) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (id-&gt;fie=
lds.clock_seq_low &lt;&lt; 8);<br>
+=C2=A0 =C2=A0 int i =3D 0, shift =3D 8;<br>
+<br>
+=C2=A0 =C2=A0 for (; i &lt; 6; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shift +=3D 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cd |=3D ((uint64_t) id-&gt;fields.node[i]) &lt=
;&lt; shift;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return qemu_xxhash4(ab, cd);<br>
+ <br></blockquote><div><br></div><div>That looks quite complex, and I have=
 no idea if this is a good hash or not.</div><div><br></div><div>Instead I =
would implement the traditional &quot;djb&quot; hash over the char[16] data=
 (see g_str_hash implementation for \0-terminated implementation)<br></div>=
<div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">}<br=
>
+<br>
+int qemu_uuid_equal(const void *lhv, const void *rhv)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 QemuUUID *lid =3D (QemuUUID *) lhv;<br>
+=C2=A0 =C2=A0 QemuUUID *rid =3D (QemuUUID *) rhv;<br>
+=C2=A0 =C2=A0 if (lid =3D=3D NULL || rid =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (lid =3D=3D rid) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 16; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lid-&gt;data[i] !=3D rid-&gt;data[i]) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 1;<br>
+}<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000166e5605fc1aebca--

