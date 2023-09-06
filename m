Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2532B79410E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 18:03:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qduys-0005gE-90; Wed, 06 Sep 2023 12:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qduyM-0005Xq-Jl
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qduyI-0005Cl-TH
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694016095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6Ety4M5RRAjzmXvKNSBM3nyj0JhVvZOI6+C0jlP8Lg=;
 b=iaWe6xx7i3fGOP7jy+/UDVV9zSdWPjLZr2BCmD6+7ync6pGdiFJm5691HzEKjnaMEI6OIu
 jF9U1s0zgFKhwf03jxg+2ItdFaeMCMKhitmDY5iHUi9KNpNboWbkGcwPTYYlNeXnz+ockB
 eTCUStyWtmlsWCa16iH7rQd7IPmW0kQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-XF9tkZvsPsalTywVq4mHRw-1; Wed, 06 Sep 2023 12:01:32 -0400
X-MC-Unique: XF9tkZvsPsalTywVq4mHRw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-68bee35afe0so20522b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 09:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694016090; x=1694620890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6Ety4M5RRAjzmXvKNSBM3nyj0JhVvZOI6+C0jlP8Lg=;
 b=bKinI2MNmudvtqFT1DmokUrHfAyC9xXEK155eeFmzV6mdE5QS4nkwsKF019hC70Ltk
 ORdiVG31CJFOXRVp8a8tZhgUe2iqKrkUmCBs/zxwJ9HsqgZDpPdJhw5mMqDE42DEANi5
 lqQ6CGcUXWjT0FMjsKn9NE96WeqrDP0A79k44xROKegegLEPa5EpJ0PuSYqyOgh6wCi7
 s9WipMAP32cUSzw3/x/R199QR9Og08RY2WuakanyFB7yy3YINJOc9gmrs8pWjHniso7N
 oDmUTRABoATsFMvHVDZ/rKi5Ggr25tOcpbXrPOC0MXZIRAjp4uXBigOx1+tE1Id5Zm9Q
 11Ww==
X-Gm-Message-State: AOJu0YwK1Ow76b5QcHmYzh6iLyDQ1yUnvZXsEC33FmF9QheX9HHAqhUy
 VheiwBIEoVRU/fJMYdQfxaX6P7MnDXP1RKXqUB2xL3RVYvuJzCRq0zLgKhdg/ftwRUs3hRo1lc6
 SJQhGDmTYigjdDEMct7Jdthmk0LZ29+w=
X-Received: by 2002:a05:6a00:2290:b0:682:713e:e520 with SMTP id
 f16-20020a056a00229000b00682713ee520mr17927366pfe.8.1694016090122; 
 Wed, 06 Sep 2023 09:01:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/LDaFbi/X8eT8MGYBc0tUJXJSYMduP0AiZjaWj4d/wBm/bWKLzX2q278G4DfHKYIsNMH2NmT9MFdhOZ1pz0=
X-Received: by 2002:a05:6a00:2290:b0:682:713e:e520 with SMTP id
 f16-20020a056a00229000b00682713ee520mr17927323pfe.8.1694016089676; Wed, 06
 Sep 2023 09:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-4-aesteve@redhat.com>
 <9d5377ba-c987-dce3-2813-d9c98f162d3f@linaro.org>
 <CADSE00Lv7ry403fE573dRv1xdz_-UEgoj1CA6OABXeXnndoP8g@mail.gmail.com>
 <d256b040-d151-05a5-2654-d3b951074984@linaro.org>
In-Reply-To: <d256b040-d151-05a5-2654-d3b951074984@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 18:01:18 +0200
Message-ID: <CADSE00JCo3H6FZOP7ow9kz-_9FUssaCa8LoTF8ZEKDVZYBkXLA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vhost-user: add shared_object msg
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, kraxel@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="00000000000044f6e20604b2db93"
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

--00000000000044f6e20604b2db93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 4:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 6/9/23 16:33, Albert Esteve wrote:
>
> >     I note you  ignored my comment regarding adding a 'Error **'
> argument in
> >     the previous version:
> >
> https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@l=
inaro.org/
> <
> https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@l=
inaro.org/
> >
> >
> > Sorry I missed those comments somehow :/
>
> Ah, I see.
>
> > I'll check them and resend.
>
> You can also object to them, explaining why this isn't really
> useful, if you think so. But first read the big comment in
> include/qapi/error.h.
>
>
Sure, I understand. So far I tend to trust the judgement of the more
experienced
Qemu developers over my own, but if I wouldn't agree with what is suggested
I would object :)
So:
- Regarding the two functions with the same, seems to be solved with the
squash before,
  and it was probably causing the compile error to begin with, so one less
thing to worry about!
- Regarding splitting the commit, sure, no problem. I'll ensure they do
compile separately.
- Regarding the error, I read the long comment in the error file and
checked surrounding code. I think
  you are right and will be better propagating the error.

And I think I would address all your comments with that! Thanks for the
feedback!


> Thanks,
>
> Phil.
>
>

--00000000000044f6e20604b2db93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 4:43=
=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 6/9/23 16:33, Albert Esteve wrote:<br>
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
v><div><br></div><div>And I think I would address all your comments with th=
at! Thanks for the feedback!</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
Thanks,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div>

--00000000000044f6e20604b2db93--


