Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2074870BFEE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15ol-0000AK-52; Mon, 22 May 2023 09:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q15oi-00007e-Mh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:43:16 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q15og-0004nK-8T
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:43:16 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4effb818c37so6803472e87.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684762992; x=1687354992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FWBrolPX/YMbNiJ5TZKctEhV0G7WroQ/nbDz5Mgf0Tw=;
 b=g+R4di6x2/BwDQt+tIies8jBdTCX+YhYBMa+3Z2ahnWKX2ZZHoS2L4DGe8cxTEnQTz
 fNNDCgCpg7uYA1JrRTuCF5YkhZHaBcYBStwZHqguh9BsxEx6zmyHcxbLoRH0BKIzxXon
 kW7gnMhC1rKbS/qZFiN8YGYe+Wt+eclgnrm+8jiiQBwug7o55ifBN+o/McCWgd79MsIh
 cNizJ0V66TbOAuHYxd2Pr9mLKAC5yYfDi1IHqLjCkptx9CKZp7W3mJDyoYrb4RrxTyaS
 cp3GyQh4DVKWk9eYATShtV+f52BvEGGxTNWnVsqwLBgBriMIMoHihmeWRiuk85oYAbV2
 GW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684762992; x=1687354992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FWBrolPX/YMbNiJ5TZKctEhV0G7WroQ/nbDz5Mgf0Tw=;
 b=LXd/zgFj4jBsxsGgYUgpOpNloUpRnr8cgh1V09aOt99NVAubTWvLlvwCo2mGQ0yagN
 JFIhvCUU5ATVaHn68pxhaQzB5kggeU+KN7Jo32Zip/MjNTGEcnHCJDJ+wlPaByJGijjN
 29XJJ1GjgF51HPJP2gEtpIV/8kmmSSUmHQJ1H9mr5hMHBydas12Ti0peh7uhGpRm7V9x
 lOsWhITZMUsgKyrvncOgmVf5zm7GvO2fYceijfp771QFJmyCWuPnXZ8GhMUh39/PxadY
 5VGZeZvjABwQth6k2pSZXK4CoQXbcI2UPZjquJiNbq08Bwxxro8E1bQ0RVvZfUQQH6ne
 Y+6g==
X-Gm-Message-State: AC+VfDyEWZIBHmvcnBC9uvlRYnkb6ISXYqMx0ZnRtYfrN3U53wdqLhai
 rjDfHPpktgbolm7RJ8Age/y7kvynZKILDomVeWg=
X-Google-Smtp-Source: ACHHUZ5/msEt7orF4zQoCK/9tt2xuRxDvee03zZjZ0e9VdsoooEVsVBDHaDF/ptLePwRy3VScPc7FvY91udj04GCZkg=
X-Received: by 2002:ac2:510c:0:b0:4f3:78af:cb2 with SMTP id
 q12-20020ac2510c000000b004f378af0cb2mr3200410lfb.68.1684762991476; Mon, 22
 May 2023 06:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230518120258.1394135-1-aesteve@redhat.com>
 <20230518120258.1394135-2-aesteve@redhat.com>
 <CAJ+F1CLD6FtZAdAOKrNktTpx-nV+QF04MAiibJJU0z+TSsR+6Q@mail.gmail.com>
 <CADSE00JvaTXf98GazeQk9W5+=2Eym73xp_DeN8siZjWw-GQL7A@mail.gmail.com>
 <CADSE00K63BiEZH=ophPHQ5hSWFzmPsMa-YkxnnRozUsRX0W1-Q@mail.gmail.com>
In-Reply-To: <CADSE00K63BiEZH=ophPHQ5hSWFzmPsMa-YkxnnRozUsRX0W1-Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 May 2023 17:42:59 +0400
Message-ID: <CAJ+F1CJzPY+w5LRE_upwH9Cyq1-b7xtqpzQ+injrs_AQCm0+Fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] uuid: add hash_func and equal_func
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Fam Zheng <fam@euphon.net>, cohuck@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a346bc05fc487399"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12e.google.com
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

--000000000000a346bc05fc487399
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 22, 2023 at 5:41=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:

>
>
>
> On Mon, May 22, 2023 at 3:13=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
>
>>
>>
>>
>> On Sat, May 20, 2023 at 9:36=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
>> marcandre.lureau@gmail.com> wrote:
>>
>>> Hi
>>>
>>> On Thu, May 18, 2023 at 4:03=E2=80=AFPM Albert Esteve <aesteve@redhat.c=
om>
>>> wrote:
>>>
>>>> Add hash and an equal function to uuid module.
>>>>
>>>> Add a couple simple unit tests for new functions,
>>>> checking collisions for similar UUIDs in the case
>>>> of the hash function, and comparing generated UUIDs
>>>> for the equal function.
>>>>
>>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>>> ---
>>>>  include/qemu/uuid.h    |  4 ++++
>>>>  tests/unit/test-uuid.c | 46 +++++++++++++++++++++++++++++++++++++++++=
+
>>>>  util/uuid.c            | 38 ++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 88 insertions(+)
>>>>
>>>> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
>>>> index dc40ee1fc9..136df682c9 100644
>>>> --- a/include/qemu/uuid.h
>>>> +++ b/include/qemu/uuid.h
>>>> @@ -96,4 +96,8 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid)=
;
>>>>
>>>>  QemuUUID qemu_uuid_bswap(QemuUUID uuid);
>>>>
>>>> +uint32_t qemu_uuid_hash(const void *uuid);
>>>> +
>>>> +int qemu_uuid_equal(const void *lhv, const void *rhv);
>>>>
>>>
>>> There is already qemu_uuid_is_equal()
>>>
>>>
>>
>> Agh, true. I'll remove it. Not sure why my brain ignored it as I was
>> reading the code...
>>
>
> One thing to consider here is that the function signature, if we want to
> pass it as a parameter for g_hash_table_new,
> expects void pointers whereas qemu_uuid_is_equal() takes QemuUUID pointer=
s.
>
> How would you suggest proceeding here? Would be better to "overload" (or
> wrap) a call to qemu_uuid_equal() from
> another function that matches the expected signature?  (int
> qemu_uuid_is_equal(void*, void*) is not a good name in that case,
> it should be something that highlights the difference between the two in
> the name) Or should I change the current existing
> function signature?
>

I would wrap the call, next to g_hash_table_new(). Alternatively, just cast
the function.

>
>
>>
>>> +
>>>>  #endif
>>>> diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
>>>> index c111de5fc1..8c865869d5 100644
>>>> --- a/tests/unit/test-uuid.c
>>>> +++ b/tests/unit/test-uuid.c
>>>> @@ -171,6 +171,50 @@ static void test_uuid_unparse_strdup(void)
>>>>      }
>>>>  }
>>>>
>>>> +static void test_uuid_hash(void)
>>>> +{
>>>> +    QemuUUID uuid;
>>>> +    int i;
>>>> +
>>>> +    for (i =3D 0; i < 100; i++) {
>>>> +        qemu_uuid_generate(&uuid);
>>>> +        /* Obtain the UUID hash */
>>>> +        uint32_t hash_a =3D qemu_uuid_hash(&uuid);
>>>> +        int data_idx =3D g_random_int_range(0, 15);
>>>> +        /* Change a single random byte of the UUID */
>>>> +        if (uuid.data[data_idx] < 0xFF) {
>>>> +            uuid.data[data_idx]++;
>>>> +        } else {
>>>> +            uuid.data[data_idx]--;
>>>> +        }
>>>> +        /* Obtain the UUID hash again */
>>>> +        uint32_t hash_b =3D qemu_uuid_hash(&uuid);
>>>> +        /*
>>>> +         * Both hashes shall be different (avoid collision)
>>>> +         * for any change in the UUID fields
>>>> +         */
>>>> +        g_assert_cmpint(hash_a, !=3D, hash_b);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void test_uuid_equal(void)
>>>> +{
>>>> +    QemuUUID uuid_a, uuid_b, uuid_c;
>>>> +    int i;
>>>> +
>>>> +    for (i =3D 0; i < 100; i++) {
>>>> +        qemu_uuid_generate(&uuid_a);
>>>> +        qemu_uuid_generate(&uuid_b);
>>>> +        memcpy(&uuid_c, &uuid_a, sizeof(uuid_a));
>>>> +
>>>> +        g_assert(qemu_uuid_equal(&uuid_a, &uuid_a));
>>>> +        g_assert(qemu_uuid_equal(&uuid_b, &uuid_b));
>>>> +        g_assert(qemu_uuid_equal(&uuid_a, &uuid_c));
>>>> +        g_assert_false(qemu_uuid_equal(&uuid_a, &uuid_b));
>>>> +        g_assert_false(qemu_uuid_equal(NULL, NULL));
>>>> +    }
>>>> +}
>>>> +
>>>>  int main(int argc, char **argv)
>>>>  {
>>>>      g_test_init(&argc, &argv, NULL);
>>>> @@ -179,6 +223,8 @@ int main(int argc, char **argv)
>>>>      g_test_add_func("/uuid/parse", test_uuid_parse);
>>>>      g_test_add_func("/uuid/unparse", test_uuid_unparse);
>>>>      g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup)=
;
>>>> +    g_test_add_func("/uuid/hash", test_uuid_hash);
>>>> +    g_test_add_func("/uuid/equal", test_uuid_equal);
>>>>
>>>>      return g_test_run();
>>>>  }
>>>> diff --git a/util/uuid.c b/util/uuid.c
>>>> index b1108dde78..efa9b0a0e4 100644
>>>> --- a/util/uuid.c
>>>> +++ b/util/uuid.c
>>>> @@ -16,6 +16,7 @@
>>>>  #include "qemu/osdep.h"
>>>>  #include "qemu/uuid.h"
>>>>  #include "qemu/bswap.h"
>>>> +#include "qemu/xxhash.h"
>>>>
>>>>  void qemu_uuid_generate(QemuUUID *uuid)
>>>>  {
>>>> @@ -116,3 +117,40 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
>>>>      bswap16s(&uuid.fields.time_high_and_version);
>>>>      return uuid;
>>>>  }
>>>> +
>>>> +uint32_t qemu_uuid_hash(const void *uuid)
>>>> +{
>>>> +    QemuUUID *id =3D (QemuUUID *) uuid;
>>>> +    uint64_t ab =3D (id->fields.time_low) |
>>>> +                  (((uint64_t) id->fields.time_mid) << 32) |
>>>> +                  (((uint64_t) id->fields.time_high_and_version) <<
>>>> 48);
>>>> +    uint64_t cd =3D (id->fields.clock_seq_and_reserved) |
>>>> +                  (id->fields.clock_seq_low << 8);
>>>> +    int i =3D 0, shift =3D 8;
>>>> +
>>>> +    for (; i < 6; i++) {
>>>> +        shift +=3D 8;
>>>> +        cd |=3D ((uint64_t) id->fields.node[i]) << shift;
>>>> +    }
>>>> +
>>>> +    return qemu_xxhash4(ab, cd);
>>>> +
>>>>
>>>
>>> That looks quite complex, and I have no idea if this is a good hash or
>>> not.
>>>
>>> Instead I would implement the traditional "djb" hash over the char[16]
>>> data (see g_str_hash implementation for \0-terminated implementation)
>>>
>>
>> ok, I'll try to do something like that. Thanks for the suggestion.
>>
>> I looked for any hash library within qemu code and xxhash was one of the
>> options that seemed easier to use.
>>
>>
>>>
>>>
>>>> }
>>>> +
>>>> +int qemu_uuid_equal(const void *lhv, const void *rhv)
>>>> +{
>>>> +    int i;
>>>> +    QemuUUID *lid =3D (QemuUUID *) lhv;
>>>> +    QemuUUID *rid =3D (QemuUUID *) rhv;
>>>> +    if (lid =3D=3D NULL || rid =3D=3D NULL) {
>>>> +        return 0;
>>>> +    }
>>>> +    if (lid =3D=3D rid) {
>>>> +        return 1;
>>>> +    }
>>>> +    for (i =3D 0; i < 16; i++) {
>>>> +        if (lid->data[i] !=3D rid->data[i]) {
>>>> +            return 0;
>>>> +        }
>>>> +    }
>>>> +    return 1;
>>>> +}
>>>> --
>>>> 2.40.0
>>>>
>>>>
>>>
>>> --
>>> Marc-Andr=C3=A9 Lureau
>>>
>>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000a346bc05fc487399
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 22, 2023 at 5:41=E2=80=
=AFPM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"lt=
r"><br></div></div></div><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, May 22, 2023 at 3:13=E2=80=AFPM Alber=
t Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" target=3D"_blank">aestev=
e@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div di=
r=3D"ltr"><br></div></div></div><br></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Sat, May 20, 2023 at 9:36=E2=80=AFAM=
 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com" t=
arget=3D"_blank">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr=
">Hi<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Thu, May 18, 2023 at 4:03=E2=80=AFPM Albert Esteve &lt;<a href=
=3D"mailto:aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add hash=
 and an equal function to uuid module.<br>
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
</div></div></div></blockquote><div><br></div><div>Agh, true. I&#39;ll remo=
ve it. Not sure why my brain ignored it as I was reading the code...</div><=
/div></div></blockquote><div><br></div><div>One thing to consider here is t=
hat the function signature, if we want to pass it as a parameter for=C2=A0g=
_hash_table_new,</div><div>expects void=C2=A0pointers whereas qemu_uuid_is_=
equal() takes QemuUUID pointers.</div><div><br></div><div>How would you sug=
gest proceeding=C2=A0here? Would be better to &quot;overload&quot; (or wrap=
) a call to qemu_uuid_equal() from</div><div>another function that matches =
the expected signature?=C2=A0 (int qemu_uuid_is_equal(void*, void*) is not =
a good name in that case,</div><div>it should be something that highlights =
the difference between the two in the name)=C2=A0Or should I change the cur=
rent existing</div><div>function signature?</div></div></div></blockquote><=
div><br></div><div>I would wrap the call, next to g_hash_table_new(). Alter=
natively, just cast the function. <br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div =
class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
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
</div></div></blockquote><div><br></div><div>ok, I&#39;ll try to do somethi=
ng like that. Thanks for the suggestion.</div><div><br></div><div>I looked =
for any hash library within qemu code and xxhash was one of the options tha=
t seemed easier to use.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div></div=
><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">}<b=
r>
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
</blockquote></div><br clear=3D"all"><br><span>-- </span><br><div dir=3D"lt=
r">Marc-Andr=C3=A9 Lureau<br></div></div>
</blockquote></div></div>
</blockquote></div></div>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000a346bc05fc487399--

