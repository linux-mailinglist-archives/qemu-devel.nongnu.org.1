Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96EB136F6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Jul 2025 10:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJYF-0002Rk-5W; Mon, 28 Jul 2025 04:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugJTv-0007CL-Hq
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugJTs-0004Wp-Pk
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753692310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbpWOrN5c/KQBiPj1NyLn6YvqBm8gkXULliylyqmWSM=;
 b=aMbBqqtihq1av86t27xHFfchXIeT4vAfS3WbJKfVNUzwN8DFWdb3lUCz4J3V5Sjm07XC2B
 kusd/inLV1g0hjnQhiLuCyS6fANWBZpGVLp0U3FZtzgjWPiF/qOOUej3QexlX1hJ70Qk0k
 JL++wtfRWm+kn8KP4BO2kKKOCaLk3fk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-SvZzChCEMqinskQ7V3ofLQ-1; Mon, 28 Jul 2025 04:45:07 -0400
X-MC-Unique: SvZzChCEMqinskQ7V3ofLQ-1
X-Mimecast-MFC-AGG-ID: SvZzChCEMqinskQ7V3ofLQ_1753692307
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3132e7266d3so4508957a91.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 01:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753692306; x=1754297106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IbpWOrN5c/KQBiPj1NyLn6YvqBm8gkXULliylyqmWSM=;
 b=V3V0mO2s9hTEgomkdX4E2ROLQd/UicltqaB8FM1A5E2pc34uiPRMPJud0B7QLctdIj
 7W9Rom8P6eqNh5VOvvpLhvsQSt3tmZJCj4JOXChe306CzjKx14LoTSy7QHNkK1yfxbgd
 adEC+HfMFTI0z9Hl1AUY5/FzrtRfoQmNW3n5E/KlF1e/OlrcdY/eSbY1ihy1U1feTCDc
 rjH9rBkBfXFC102yi7xuXa3EHphm+rKUaURPV9wqp+asSttrWEXyxkM8wM2gvGuM/BVi
 rH4uNfTGkQ/8qdMHumlrSuJUprTLa5pd02sIj2707o0Y/+Up8z7GqbKdIySQCYnCxmVG
 P5ew==
X-Gm-Message-State: AOJu0Yw124q7Qmmg0s4asEXdULC2Uil489EG3Qd8V5rRrFOXtq2VkLnt
 JZWTivLcSweGY+ZGgYz8NvLVnpAySyr0BoJeh19TPQrDnLqYFH2kMIAZurD9mTe0QLei0LyZihO
 tRbhL9vBxA2BqmdSFE+7QqCeYzG1shfsETNausknW9w2vUIexZWfwKK4y2byL/emq610b2MeWmE
 N7lbxwvtPZQyYkTcETNVrbwfTXmJcH3gFi42N92l63Fg==
X-Gm-Gg: ASbGnctuswEiQ3SK8KKnTgHGaKr3Vhd7nSxa/akr0BtfLsmj2qsNkm28gvPXIT1AI5D
 RxF4E6BaaSdD752CD39kIxW7m4hyNviqPINTealouKFLWA7TtcAd5G7uDvf2nCBOIzwKfxFKp5a
 JhSg3sQoJaROtXaBILo9ekEOLqH94U0Jv1aHzgvVM3re8ToPgjNcgvYg==
X-Received: by 2002:a17:90b:4d8f:b0:312:959:dc42 with SMTP id
 98e67ed59e1d1-31e77866ee1mr17617342a91.11.1753692306335; 
 Mon, 28 Jul 2025 01:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwMKOs5fB6lw4MJZ5uLRe3NI9bPTbCf5zGf7ft9vqsGJRnGcBA3yhY10Dq5IggvQ2VHTgcJGKJilvgmY5ATOE=
X-Received: by 2002:a17:90b:4d8f:b0:312:959:dc42 with SMTP id
 98e67ed59e1d1-31e77866ee1mr17617291a91.11.1753692305828; Mon, 28 Jul 2025
 01:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-1-d52704443975@redhat.com>
 <CAMxuvaznYbcpxc7dtDP5yVBzVcDJpVWVXHeWxB1zo0bfdBuw2g@mail.gmail.com>
In-Reply-To: <CAMxuvaznYbcpxc7dtDP5yVBzVcDJpVWVXHeWxB1zo0bfdBuw2g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 12:44:53 +0400
X-Gm-Features: Ac12FXxdoiugxE4605nAKbAAyBR4SsHGkfKiAQ-kl062G9tEYfKD4Vx4h9zQRKk
Message-ID: <CAMxuvawsX6ePZV=ek7d0rDwpJYQJmNwiFKhTetLW6u1PW6cTbA@mail.gmail.com>
Subject: Re: [PATCH v7 01/24] migration: push Error **errp into
 vmstate_subsection_load()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000ef496f063af94e76"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000ef496f063af94e76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jul 25, 2025 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

>
>
> On Fri, Jul 25, 2025 at 4:19=E2=80=AFPM Arun Menon <armenon@redhat.com> w=
rote:
>
>> This is an incremental step in converting vmstate loading
>> code to report error via Error objects instead of directly
>> printing it to console/monitor.
>> It is ensured that vmstate_subsection_load() must report an error
>> in errp, in case of failure.
>>
>> Signed-off-by: Arun Menon <armenon@redhat.com>
>> ---
>>  migration/vmstate.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index
>> 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f2747906d=
df9aca891b
>> 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const
>> VMStateDescription *vmsd,
>>                                     void *opaque, JSONWriter *vmdesc,
>>                                     Error **errp);
>>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescriptio=
n
>> *vmsd,
>> -                                   void *opaque);
>> +                                   void *opaque, Error **errp);
>>
>>  /* Whether this field should exist for either save or load the VM? */
>>  static bool
>> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const
>> VMStateDescription *vmsd,
>>          field++;
>>      }
>>      assert(field->flags =3D=3D VMS_END);
>> -    ret =3D vmstate_subsection_load(f, vmsd, opaque);
>> +    ret =3D vmstate_subsection_load(f, vmsd, opaque, NULL);
>>      if (ret !=3D 0) {
>>          qemu_file_set_error(f, ret);
>>          return ret;
>> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription *
>> const *sub,
>>  }
>>
>>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescriptio=
n
>> *vmsd,
>> -                                   void *opaque)
>> +                                   void *opaque, Error **errp)
>>  {
>>      trace_vmstate_subsection_load(vmsd->name);
>>
>> @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, cons=
t
>> VMStateDescription *vmsd,
>>          sub_vmsd =3D vmstate_get_subsection(vmsd->subsections, idstr);
>>          if (sub_vmsd =3D=3D NULL) {
>>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
>> "(lookup)");
>> +            error_setg(errp, "VM subsection '%s' in '%s' does not exist=
",
>> +                       idstr, vmsd->name);
>>              return -ENOENT;
>>          }
>>          qemu_file_skip(f, 1); /* subsection */
>> @@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, cons=
t
>> VMStateDescription *vmsd,
>>          ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id);
>>          if (ret) {
>>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
>> "(child)");
>> +            error_setg(errp,
>> +                       "Loading VM subsection '%s' in '%s' failed : %d"=
,
>>
>
> extra space before ":"
>
> other than that
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

Actually, almost systematically when you introduce an extra **errp
argument, you should ERRP_GUARD() in the function (see include/qapi/error.h
doc). Was this discussed before? Can you update the following patches too?


>
>> +                       idstr, vmsd->name, ret);
>>              return ret;
>>          }
>>      }
>>
>> --
>> 2.50.0
>>
>>

--000000000000ef496f063af94e76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25, 2025=
 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Fri, Jul 25, 2025 at 4:19=E2=80=AFPM Arun Men=
on &lt;<a href=3D"mailto:armenon@redhat.com" target=3D"_blank">armenon@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">This is an incremental step in converting vmstate loading<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that vmstate_subsection_load() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/vmstate.c | 11 ++++++++---<br>
=C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/migration/vmstate.c b/migration/vmstate.c<br>
index 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f27479=
06ddf9aca891b 100644<br>
--- a/migration/vmstate.c<br>
+++ b/migration/vmstate.c<br>
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMS=
tateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, JSONWrit=
er *vmdesc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp);<br>
=C2=A0static int vmstate_subsection_load(QEMUFile *f, const VMStateDescript=
ion *vmsd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **e=
rrp);<br>
<br>
=C2=A0/* Whether this field should exist for either save or load the VM? */=
<br>
=C2=A0static bool<br>
@@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescri=
ption *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0assert(field-&gt;flags =3D=3D VMS_END);<br>
-=C2=A0 =C2=A0 ret =3D vmstate_subsection_load(f, vmsd, opaque);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_subsection_load(f, vmsd, opaque, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_set_error(f, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
@@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * const=
 *sub,<br>
=C2=A0}<br>
<br>
=C2=A0static int vmstate_subsection_load(QEMUFile *f, const VMStateDescript=
ion *vmsd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0trace_vmstate_subsection_load(vmsd-&gt;name);<br>
<br>
@@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const V=
MStateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sub_vmsd =3D vmstate_get_subsection(vmsd-=
&gt;subsections, idstr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sub_vmsd =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_subsection_lo=
ad_bad(vmsd-&gt;name, idstr, &quot;(lookup)&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;VM subsec=
tion &#39;%s&#39; in &#39;%s&#39; does not exist&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0idstr, vmsd-&gt;name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOENT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_skip(f, 1); /* subsection */<br=
>
@@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, const V=
MStateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmstate_load_state(f, sub_vmsd, o=
paque, version_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_subsection_lo=
ad_bad(vmsd-&gt;name, idstr, &quot;(child)&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Loading VM subsection &#39;%s&#39; in &#39;%s&#39; failed :=
 %d&quot;,<br></blockquote><div><br></div><div>extra space before &quot;:&q=
uot;</div><div><br></div><div>other than that</div><div>Reviewed-by: Marc-A=
ndr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=
=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</div></div></div></blockquo=
te><div><br></div><div>Actually, almost systematically when you introduce a=
n extra **errp argument, you should ERRP_GUARD() in the function (see=C2=A0=
include/qapi/error.h doc). Was this discussed before? Can you update the fo=
llowing patches too?</div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0idstr, vmsd-&gt;name, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>
</blockquote></div></div>
</div>

--000000000000ef496f063af94e76--


