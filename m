Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 830BA794150
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 18:19:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdvEm-0000LO-Hd; Wed, 06 Sep 2023 12:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdvEi-0000Kd-HG
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdvEf-00008g-Td
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694017113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mh4N1iziZoCv8RSsylqAM1AQz6nccKJ0y8sxBQTBsQE=;
 b=YTpXBm07bpL+6ZzAjCqDU6XcFUgF5TH5mehiXvnYDt2VrjK2fecG1eUUjsqn1AMjLYhz0F
 TVTjTTW/WLXlS4gk52CFB3tMbymcvFs1myC99AoGrxR0ZgU3nQWBRbGx3u/nxLut4AEk54
 0UOloUq51DENfL6uBAonh0LJ5ZAkxUc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-b_0b0g1DOxmlxDkkYnWGlw-1; Wed, 06 Sep 2023 12:18:31 -0400
X-MC-Unique: b_0b0g1DOxmlxDkkYnWGlw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-570096d89b1so74037a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 09:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694017110; x=1694621910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mh4N1iziZoCv8RSsylqAM1AQz6nccKJ0y8sxBQTBsQE=;
 b=hxFUiszHTisGxhW9PdokLeNx/FwP8j33xPY3mLdOzpYLeJ958f/NK/u4Dp+AsVMANI
 /YjCrIjcbBBuu02KxTgqU+TG2tkFvuGkFfObYizLtNIYJjrtVJT+vw9o6ZZdbHy2NUzc
 dwFD5UwFSRSCQyYs89vrd3BdbHF1PlGBnNRTGhe2PefRpgPiZNBnyQ13YcCLKzlQlVSb
 nODf5C02Hid+mWMhWsoGUWUv7sppadmpEub7Sl+TnbgkV+/a035X5CrbgeNFFKApxdSQ
 TBiAlmg2zWxize+tG/UdRy1dfI6NnleIJZwaOgS/X/NKYdfZcCQ24Y3x4FTR5izisFZg
 NAEA==
X-Gm-Message-State: AOJu0YwvkOEEmPjuZhtMJ5TeeNm8AnqNz/6VWU1I3wNeZVf7VESaa33Z
 3YfUMl8iHjTK2O0SUJ6tAIq+j8cAZsgPpeS/sfqdPWyqXj4ZZGqzHbJs3yrXSS58sgEyfVq5fMV
 N9AKx2tqncS97D9NDLXFJ4dX/FlSvzbE=
X-Received: by 2002:a05:6a20:6a2b:b0:138:92ef:78f9 with SMTP id
 p43-20020a056a206a2b00b0013892ef78f9mr16416554pzk.6.1694017110446; 
 Wed, 06 Sep 2023 09:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfbkyZe0F3SBRVK0/ouRoVm9de8/OcSrI5ECFeu0euWZLdOxUyCkOvItMXp7ErXP2eLMSYUkqA5DZUN8oTAes=
X-Received: by 2002:a05:6a20:6a2b:b0:138:92ef:78f9 with SMTP id
 p43-20020a056a206a2b00b0013892ef78f9mr16416529pzk.6.1694017110120; Wed, 06
 Sep 2023 09:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-4-aesteve@redhat.com>
 <9d5377ba-c987-dce3-2813-d9c98f162d3f@linaro.org>
 <CADSE00Lv7ry403fE573dRv1xdz_-UEgoj1CA6OABXeXnndoP8g@mail.gmail.com>
 <d256b040-d151-05a5-2654-d3b951074984@linaro.org>
 <CADSE00JCo3H6FZOP7ow9kz-_9FUssaCa8LoTF8ZEKDVZYBkXLA@mail.gmail.com>
In-Reply-To: <CADSE00JCo3H6FZOP7ow9kz-_9FUssaCa8LoTF8ZEKDVZYBkXLA@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 18:18:19 +0200
Message-ID: <CADSE00K7=roimgZy4ZnMmQu=vEP13S71BuEctWgfUB0Hv5iF0A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vhost-user: add shared_object msg
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, kraxel@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="00000000000017b18c0604b31895"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000017b18c0604b31895
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 6:01=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:

>
>
> On Wed, Sep 6, 2023 at 4:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
> wrote:
>
>> On 6/9/23 16:33, Albert Esteve wrote:
>>
>> >     I note you  ignored my comment regarding adding a 'Error **'
>> argument in
>> >     the previous version:
>> >
>> https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@=
linaro.org/
>> <
>> https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@=
linaro.org/
>> >
>> >
>> > Sorry I missed those comments somehow :/
>>
>> Ah, I see.
>>
>> > I'll check them and resend.
>>
>> You can also object to them, explaining why this isn't really
>> useful, if you think so. But first read the big comment in
>> include/qapi/error.h.
>>
>>
> Sure, I understand. So far I tend to trust the judgement of the more
> experienced
> Qemu developers over my own, but if I wouldn't agree with what is
> suggested I would object :)
> So:
> - Regarding the two functions with the same, seems to be solved with the
> squash before,
>   and it was probably causing the compile error to begin with, so one les=
s
> thing to worry about!
> - Regarding splitting the commit, sure, no problem. I'll ensure they do
> compile separately.
> - Regarding the error, I read the long comment in the error file and
> checked surrounding code. I think
>   you are right and will be better propagating the error.
>

But I think I will omit the Error propagation for
`vhost_user_backend_handle_shared_object_lookup`.
In this function returning an error code does not necessarily mean that we
should log an error.
So if we pass the local_err from the backend_read function to the handler,
we cannot be sure
when we should actually print the log.
`vhost_backend_handle_iotlb_msg` has the same issue and does not propagate
the error either,
relies solely on `error_report` calls.

Therefore, I will propagate it for `vhost_user_send_resp` and
`vhost_user_backend_send_dmabuf_fd` only.


>
> And I think I would address all your comments with that! Thanks for the
> feedback!
>
>
>> Thanks,
>>
>> Phil.
>>
>>

--00000000000017b18c0604b31895
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 6:01=E2=80=AFPM=
 Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 4:43=
=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 6/9/23 16:33, Albert Esteve wro=
te:<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0I note you=C2=A0 ignored my comment regarding addin=
g a &#39;Error **&#39; argument in<br>
&gt;=C2=A0 =C2=A0 =C2=A0the previous version:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/911ee=
f0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af=
8f0@linaro.org/</a> &lt;<a href=3D"https://lore.kernel.org/qemu-devel/911ee=
f0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af=
8f0@linaro.org/</a>&gt;<br>
&gt; <br>
&gt; Sorry I missed those comments somehow :/<br>
<br>
Ah, I see.<br>
<br>
&gt; I&#39;ll check them and resend.<br>
<br>
You can also object to them, explaining why this isn&#39;t really<br>
useful, if you think so. But first read the big comment in<br>
include/qapi/error.h.<br>
<br></blockquote><div><br></div><div>Sure, I understand. So far I tend to t=
rust the judgement of the more experienced</div><div>Qemu developers over m=
y own, but if I wouldn&#39;t agree with what is suggested I would object :)=
</div><div>So:</div><div>- Regarding the two functions with the same, seems=
 to be solved with the squash=C2=A0before,</div><div>=C2=A0 and it was prob=
ably causing the compile error to begin with, so one less thing to worry ab=
out!</div><div>- Regarding splitting the commit, sure, no problem. I&#39;ll=
 ensure they do compile separately.</div><div>- Regarding the error, I read=
 the long comment in the error file and checked surrounding code. I think</=
div><div>=C2=A0 you are right and will be better propagating the error.</di=
v></div></div></blockquote><div><br></div><div>But I think I will omit the =
Error propagation for `vhost_user_backend_handle_shared_object_lookup`.</di=
v><div>In this function returning an error code does not necessarily mean t=
hat we should log an error.</div><div>So if we pass the local_err from the =
backend_read function to the handler, we cannot be sure</div><div>when we s=
hould actually print the log.</div><div>`vhost_backend_handle_iotlb_msg` ha=
s the same issue and does not propagate the error either,</div><div>relies =
solely on `error_report` calls.</div><div><br></div><div>Therefore, I will =
propagate it for `vhost_user_send_resp` and `vhost_user_backend_send_dmabuf=
_fd` only.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><div>And=
 I think I would address all your comments with that! Thanks for the feedba=
ck!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
Thanks,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--00000000000017b18c0604b31895--


