Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768D7565D3
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOrr-0004DM-4E; Mon, 17 Jul 2023 10:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLOrp-0004Cm-Ax
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLOrn-00071u-5z
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689602781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7cwKJQBK4yq3wtHf1uhI+YHLdUAi3dLnU/OBqoLQnng=;
 b=igM/GsveMKGaO02O++5/u6tJxZJyKUPp2wBIKzEJv8fcDGDS6OJqs6NX5pC9mHe+ihHFGS
 ANOfNsiaDtRm+oAuKl10tzARaCPOZtj3YZZ8IJnx1tDdM33EjSNIzSDSx/FAo5wzD6J9Na
 pUfXfi6aZ/qS74QAcwWDv2cNG/SXhnU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-m29JWvBBNTeu9S74IW4Dng-1; Mon, 17 Jul 2023 10:05:54 -0400
X-MC-Unique: m29JWvBBNTeu9S74IW4Dng-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so2675172a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689602742; x=1692194742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7cwKJQBK4yq3wtHf1uhI+YHLdUAi3dLnU/OBqoLQnng=;
 b=SHnjkcZUJog6Q4K0AOPcjyFztkNgA2PyanaUQp4RvnqpFJDT3S1EISkifp9HYfn26I
 adAju9xvtx8Zum31IXtH90CiD0BMXEdjixiZyVOAuzoyY17MU2wq2lCbqQOKXFerqnAD
 AQXGnPfJJOD4e1u0+vPhCMP4Nu+4Zvld5KFKD/ODeuVVuZNQSL6v6EY+fzqibJavI8mW
 BGTPENe5YRzwUa1a6JWc3xxVgCNkwYnNm3P7AVPOcRO0iSJkhsV86b0AHh8m1yE6Cmfh
 MGgRZc5g6xZHEY3Rw5QS42RyIl9blLrlXaeLtmy1Vak89DxaSVzlSqZpqphTnicMdLTo
 QRkg==
X-Gm-Message-State: ABy/qLZ3dOOKzYMXuT1gO7/rNfLKYDYF/TglGUdbQ75tWAF9igR2Cuvy
 ulL/Nu3BHrLD44UiXje7YrUGMMyjVQZaImGyuNA92+kzTfg+vY+jL0lYK/sE747bLR5Hi7h3fX0
 vIsDtzW94xLf3Mad0J+eQrep3G5Z4MqY=
X-Received: by 2002:aa7:d905:0:b0:521:8817:cc4c with SMTP id
 a5-20020aa7d905000000b005218817cc4cmr4547876edr.38.1689602742496; 
 Mon, 17 Jul 2023 07:05:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZ9j1F4os8301vjnc+hWS/dxujDd71kTT8ObvYUqPSV4wpmiaPAfFvMF+jHdM9rvCIl7YoOUbIFGfe1+Fwto4=
X-Received: by 2002:aa7:d905:0:b0:521:8817:cc4c with SMTP id
 a5-20020aa7d905000000b005218817cc4cmr4547854edr.38.1689602742222; Mon, 17 Jul
 2023 07:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
 <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
 <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
 <F68DBAB0-B1CC-45FC-B1A7-8C62A5885031@baidu.com>
 <CAMxuvawBOLcS8SQzPiVgMuyMXFadrqrMzcuA1ddB-uaDd1qZgA@mail.gmail.com>
 <3AC28C88-5682-4EBD-8996-5125FAF5F2A4@baidu.com>
In-Reply-To: <3AC28C88-5682-4EBD-8996-5125FAF5F2A4@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Jul 2023 18:05:30 +0400
Message-ID: <CAMxuvazXYgKeaBoJxqxEEM2opiYAqQA=2Zg_6K2kUFUTSmjwog@mail.gmail.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004315730600af4b2d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000004315730600af4b2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 17, 2023 at 5:43=E2=80=AFPM Gao,Shiyuan <gaoshiyuan@baidu.com> =
wrote:

> > Hi
> >
> > On Mon, Jul 17, 2023 at 4:53=E2=80=AFPM Gao,Shiyuan <gaoshiyuan@baidu.c=
om>
> wrote:
> >
> > > > > > >
> > > > > > So move the guest mouse pointer to (0, 0) of the screen when
> connect
> > > the
> > > > > > > VNC, and then move the mouse pointer to the cursor of
> VNC(absolute
> > > > > > > coordinates are also relative coordinates).
> > > > > > >
> > > > > > >
> > > > > > It's hardly a solution, you still have no clue what will be the
> guest
> > > > > mouse
> > > > > > position.
> > > > >
> > > > > We have no clue what will be the guest mouse position, we can mov=
e
> the
> > > > > guest
> > > > > mouse to (0,0) each connect the VNC. Now, the cursor of VNC will
> be the
> > > > > relative coordinates. In a way, this is a quirk to know the guest
> mouse
> > > > > position.
> > > > >
> > > >
> > > > There is no guarantee the guest pointer will be at (0,0) though, an=
d
> that
> > > > doesn't explain how that would help. Which client are you using? Ar=
e
> you
> > > > drawing the guest cursor? This can't be done currently with the lac=
k
> of a
> > > > message to tell the guest mouse position. (moving / sync-ing the
> client
> > > > cursor position would be even worse in many ways)
> > >
> > > Sorry, my description isn't accurate.
> > >
> > > When connect the vnc server,
> > >     vnc_connect
> > >       -> vs->last_x =3D -1;
> > >       -> vs->last_y =3D -1;
> > >
> > > move client cursor to vnc screen,
> > >     vnc_client_io
> > >       ->vnc_client_read
> > >         ->protocol_client_msg
> > >           ->pointer_event(x,y)
> > >             -> qemu_input_queue_rel(con, INPUT_AXIS_X, 0 - width);
> > >             -> qemu_input_queue_rel(con, INPUT_AXIS_Y, 0 - height);
> > >             -> x=3D0,y=3D0
> > >             -> vs->last_x =3D x;vs->last_y =3D y;
> > >             -> qemu_input_event_sync   // this will inform the guest
> move
> > > to (0, 0)
> > >
> > > the next event,
> > >           ->pointer_event(x,y)
> > >             -> qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x=
);
> > >             -> qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x=
);
> > >             -> qemu_input_event_sync    // this will inform the guest
> from
> > > (0,0) move to (x,y),
> > >                                                                  // t=
he
> > > client cursor and guest mouse will sync.
> > >
> >
> > Actually, it will be ( x - vs->last_x, y - vs->last_y), not necessarily
> (x,
> > y), unless you also set last_x =3D 0 / last_y =3D 0.
>
> yes, set last_x =3D 0 / last_y =3D 0 and only the first time enter
> pointer_event.
>
>          if (vs->last_x !=3D -1) {
>              qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x);
>              qemu_input_queue_rel(con, INPUT_AXIS_Y, y - vs->last_y);
> +        } else {
> +            qemu_input_queue_rel(con, INPUT_AXIS_X, 0 - width);
> +            qemu_input_queue_rel(con, INPUT_AXIS_Y, 0 - height);
> +            x =3D 0;
> +            y =3D 0;
>          }
>          vs->last_x =3D x;
>          vs->last_y =3D y;
>
> >
> > But even then, there is no guarantee the guest position will be a x/y..=
.
> >
>
> Emmm, compared to the current implementation, it is at least getting
> closer.
> The current state is simply unbearable.
>
> > It's been implemented on Linux VM for a long while (first in userspace,
> > then in kernel since ~2015). But I don't know about the Windows support=
,
> it
> > looks like you need a driver such as provided by VMWave, but it seems
> > closed-source...  At this point it's probably better to use virtio-inpu=
t,
> > which has open-source/free windows drivers.
>
> Thanks, I tried install vmmouse driver in windows success and reboot.
> However 'info mice' as
> follows and don't have vmmouse (absolute).
>
> * Mouse #2: QEMU PS/2 Mouse
>
> The guest mouse isn't sync with client cursor...
>

Look if you have "dev: vmmouse, id " in "info qtree" or set -machine
vmport=3Don.

--0000000000004315730600af4b2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 5:43=E2=80=
=AFPM Gao,Shiyuan &lt;<a href=3D"mailto:gaoshiyuan@baidu.com">gaoshiyuan@ba=
idu.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">&gt; Hi<br>
&gt;<br>
&gt; On Mon, Jul 17, 2023 at 4:53=E2=80=AFPM Gao,Shiyuan &lt;<a href=3D"mai=
lto:gaoshiyuan@baidu.com" target=3D"_blank">gaoshiyuan@baidu.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; So move the guest mouse pointer to (0, 0) of the s=
creen when connect<br>
&gt; &gt; the<br>
&gt; &gt; &gt; &gt; &gt; &gt; VNC, and then move the mouse pointer to the c=
ursor of VNC(absolute<br>
&gt; &gt; &gt; &gt; &gt; &gt; coordinates are also relative coordinates).<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; It&#39;s hardly a solution, you still have no clue=
 what will be the guest<br>
&gt; &gt; &gt; &gt; mouse<br>
&gt; &gt; &gt; &gt; &gt; position.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; We have no clue what will be the guest mouse position, =
we can move the<br>
&gt; &gt; &gt; &gt; guest<br>
&gt; &gt; &gt; &gt; mouse to (0,0) each connect the VNC. Now, the cursor of=
 VNC will be the<br>
&gt; &gt; &gt; &gt; relative coordinates. In a way, this is a quirk to know=
 the guest mouse<br>
&gt; &gt; &gt; &gt; position.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There is no guarantee the guest pointer will be at (0,0) tho=
ugh, and that<br>
&gt; &gt; &gt; doesn&#39;t explain how that would help. Which client are yo=
u using? Are you<br>
&gt; &gt; &gt; drawing the guest cursor? This can&#39;t be done currently w=
ith the lack of a<br>
&gt; &gt; &gt; message to tell the guest mouse position. (moving / sync-ing=
 the client<br>
&gt; &gt; &gt; cursor position would be even worse in many ways)<br>
&gt; &gt;<br>
&gt; &gt; Sorry, my description isn&#39;t accurate.<br>
&gt; &gt;<br>
&gt; &gt; When connect the vnc server,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0vnc_connect<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; vs-&gt;last_x =3D -1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; vs-&gt;last_y =3D -1;<br>
&gt; &gt;<br>
&gt; &gt; move client cursor to vnc screen,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0vnc_client_io<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;vnc_client_read<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;protocol_client_msg<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;pointer_event(x,y)<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; qemu_input_q=
ueue_rel(con, INPUT_AXIS_X, 0 - width);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; qemu_input_q=
ueue_rel(con, INPUT_AXIS_Y, 0 - height);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; x=3D0,y=3D0<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; vs-&gt;last_=
x =3D x;vs-&gt;last_y =3D y;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; qemu_input_e=
vent_sync=C2=A0 =C2=A0// this will inform the guest move<br>
&gt; &gt; to (0, 0)<br>
&gt; &gt;<br>
&gt; &gt; the next event,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;pointer_event(x,y)<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; qemu_input_q=
ueue_rel(con, INPUT_AXIS_X, x - vs-&gt;last_x);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; qemu_input_q=
ueue_rel(con, INPUT_AXIS_X, x - vs-&gt;last_x);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; qemu_input_e=
vent_sync=C2=A0 =C2=A0 // this will inform the guest from<br>
&gt; &gt; (0,0) move to (x,y),<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 // the<br>
&gt; &gt; client cursor and guest mouse will sync.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Actually, it will be ( x - vs-&gt;last_x, y - vs-&gt;last_y), not nece=
ssarily (x,<br>
&gt; y), unless you also set last_x =3D 0 / last_y =3D 0.<br>
<br>
yes, set last_x =3D 0 / last_y =3D 0 and only the first time enter pointer_=
event.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vs-&gt;last_x !=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_queue_rel(con, I=
NPUT_AXIS_X, x - vs-&gt;last_x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_queue_rel(con, I=
NPUT_AXIS_Y, y - vs-&gt;last_y);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(con, INPUT_=
AXIS_X, 0 - width);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(con, INPUT_=
AXIS_Y, 0 - height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vs-&gt;last_x =3D x;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vs-&gt;last_y =3D y;<br>
<br>
&gt;<br>
&gt; But even then, there is no guarantee the guest position will be a x/y.=
..<br>
&gt;<br>
<br>
Emmm, compared to the current implementation, it is at least getting closer=
.<br>
The current state is simply unbearable.<br>
<br>
&gt; It&#39;s been implemented on Linux VM for a long while (first in users=
pace,<br>
&gt; then in kernel since ~2015). But I don&#39;t know about the Windows su=
pport, it<br>
&gt; looks like you need a driver such as provided by VMWave, but it seems<=
br>
&gt; closed-source...=C2=A0 At this point it&#39;s probably better to use v=
irtio-input,<br>
&gt; which has open-source/free windows drivers.<br>
<br>
Thanks, I tried install vmmouse driver in windows success and reboot. Howev=
er &#39;info mice&#39; as<br>
follows and don&#39;t have vmmouse (absolute).<br>
<br>
* Mouse #2: QEMU PS/2 Mouse<br>
<br>
The guest mouse isn&#39;t sync with client cursor...<br></blockquote><div><=
br></div><div>Look if you have &quot;dev: vmmouse, id &quot; in &quot;info =
qtree&quot; or set -machine vmport=3Don. <br></div></div></div>

--0000000000004315730600af4b2d--


