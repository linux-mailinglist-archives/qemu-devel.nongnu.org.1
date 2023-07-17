Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D76756406
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLO2R-0007Qh-SC; Mon, 17 Jul 2023 09:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLO2D-0007It-5X
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLO28-0007jb-NA
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689599561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPlleiATyCfLy9X9vwiYFckcq5M537FXeFqaluu/0Bw=;
 b=irxQ11TybeYzDUNdBPDzIUKrDbI4M+H9uJY5dXaDQZ7u+17i09uNVmj+KyMGwSynIii/+f
 e7x930SeBks7ydpAS0Fu0bWRhm5IMilP5u/7NaNzy7rM4ef+7W6fDrpeIV21+LRaCTd3Ax
 wbK+P/9OfBXz/kFvQsUBC9YukpX7QXs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-rUGijvXHN0ii3BXmu0Vjbw-1; Mon, 17 Jul 2023 09:12:40 -0400
X-MC-Unique: rUGijvXHN0ii3BXmu0Vjbw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso3026660a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 06:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689599558; x=1692191558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPlleiATyCfLy9X9vwiYFckcq5M537FXeFqaluu/0Bw=;
 b=U3M373E6MxR7QBgA+jvdQWyBAPtzUkUDvvv9KRa40L1mr9vPvLn5M4ufrwXTSrNrvs
 YtmfTk2imoGIFVci0POreemHuoNxC2zsFEct8pKRLU33vftJPhgACVUxrua99VBgyO5S
 3iOqzMcwTPqeWERXTzr+HD7u/rRuBjnoCkshtgpNAPyzsL2r8qjf+HNtjTMWUCYSE+Gt
 o+QoDIuOSbBUF0eJ+oAif3GQl5iXcvgnK9m5E9E+KMUqe3HaSuBCY8Y378+F2hnPn8Ad
 jaLTGXT1tZiAaLcCg73DbN3cTibwHkLjezAMRVj+lpHP4liARKLCUiV//4EyiAmPw3tX
 VRZA==
X-Gm-Message-State: ABy/qLbVJasXAEWiC2RjBMqK40WeDPyVUXDEeNiZylROYDYcQtB6+PB9
 NgADXiqXnZB444v/wc1M7CADmCq1wlV6RyHAZCShCWevZ4HqACtPrq3DoW8lxxvmYI+L9hfEV6n
 nzK2cW34GrY2MD38Xjp30Rk24qhoDi36NDYo75fFfhQ==
X-Received: by 2002:a05:6402:343:b0:51e:12b:b989 with SMTP id
 r3-20020a056402034300b0051e012bb989mr10264932edw.20.1689599558012; 
 Mon, 17 Jul 2023 06:12:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHY218LI08AEotooCrouR8NznttS8lcz3WzPQTPmN35ptvHLOjSteaLW8ClgSJbWPWSiIPMGVj86tllStLL/LQ=
X-Received: by 2002:a05:6402:343:b0:51e:12b:b989 with SMTP id
 r3-20020a056402034300b0051e012bb989mr10264917edw.20.1689599557688; Mon, 17
 Jul 2023 06:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
 <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
 <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
 <F68DBAB0-B1CC-45FC-B1A7-8C62A5885031@baidu.com>
In-Reply-To: <F68DBAB0-B1CC-45FC-B1A7-8C62A5885031@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Jul 2023 17:12:26 +0400
Message-ID: <CAMxuvawBOLcS8SQzPiVgMuyMXFadrqrMzcuA1ddB-uaDd1qZgA@mail.gmail.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000072f4450600ae8d4c"
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

--00000000000072f4450600ae8d4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 17, 2023 at 4:53=E2=80=AFPM Gao,Shiyuan <gaoshiyuan@baidu.com> =
wrote:

> > > > >
> > > > So move the guest mouse pointer to (0, 0) of the screen when connec=
t
> the
> > > > > VNC, and then move the mouse pointer to the cursor of VNC(absolut=
e
> > > > > coordinates are also relative coordinates).
> > > > >
> > > > >
> > > > It's hardly a solution, you still have no clue what will be the gue=
st
> > > mouse
> > > > position.
> > >
> > > We have no clue what will be the guest mouse position, we can move th=
e
> > > guest
> > > mouse to (0,0) each connect the VNC. Now, the cursor of VNC will be t=
he
> > > relative coordinates. In a way, this is a quirk to know the guest mou=
se
> > > position.
> > >
> >
> > There is no guarantee the guest pointer will be at (0,0) though, and th=
at
> > doesn't explain how that would help. Which client are you using? Are yo=
u
> > drawing the guest cursor? This can't be done currently with the lack of=
 a
> > message to tell the guest mouse position. (moving / sync-ing the client
> > cursor position would be even worse in many ways)
>
> Sorry, my description isn't accurate.
>
> When connect the vnc server,
>     vnc_connect
>       -> vs->last_x =3D -1;
>       -> vs->last_y =3D -1;
>
> move client cursor to vnc screen,
>     vnc_client_io
>       ->vnc_client_read
>         ->protocol_client_msg
>           ->pointer_event(x,y)
>             -> qemu_input_queue_rel(con, INPUT_AXIS_X, 0 - width);
>             -> qemu_input_queue_rel(con, INPUT_AXIS_Y, 0 - height);
>             -> x=3D0,y=3D0
>             -> vs->last_x =3D x;vs->last_y =3D y;
>             -> qemu_input_event_sync   // this will inform the guest move
> to (0, 0)
>
> the next event,
>           ->pointer_event(x,y)
>             -> qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x);
>             -> qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x);
>             -> qemu_input_event_sync    // this will inform the guest fro=
m
> (0,0) move to (x,y),
>                                                                  // the
> client cursor and guest mouse will sync.
>

Actually, it will be ( x - vs->last_x, y - vs->last_y), not necessarily (x,
y), unless you also set last_x =3D 0 / last_y =3D 0.

But even then, there is no guarantee the guest position will be a x/y...


> and if the resolution is high, alse need increace the queue size of ps2
> PS2_QUEUE_SIZE.
> Otherwise, if the guest mouse far from the (0,0) before vnc connect, it
> can't move to (0,0).
>
>
Oh indeed, ps2 will queue multiple messages.. another reason you can't do
such big relative moves reliably.


> >
> > > >
> > > >
> > > > > On windows VM, also need disable "Enhance Pointer Precision"
> Option in
> > > > > "Pointer Options" (Control Panel -> Mouse).
> > > > >
> > > > >
> > > > Apparently, this option doesn't have much to do with relative mouse
> > > motion.
> > > > Can you explain what it does with this change?
> > >
> > > Emmm, I don't know why this can solve the problem. It's quite
> effective and
> > > get this way from
> > >
> > >
> https://forum.proxmox.com/threads/is-it-possible-not-to-use-usbdevice-tab=
let.1498/
> > > .
> > >
> > > Only use this way, we need to manually align the VNC cursor with the
> guest
> > > mouse.
> > >
> >
> > It's a bit vague what the "VNC cursor" mean. If you mean the client
> cursor
> > position, there is no way to align / sync with the guest without an ext=
ra
> > message to inform the client of its position. There is even a comment
> about
> > that in vnc.c  /* can we ask the client(s) to move the pointer ??? */)
>
> Sorry, I mean the client cursor position. I found disable "Enhance Pointe=
r
> Precision"
> Option, move cursor to the bound of the VNC screen, they maybe align.
>
> >
> >
> > > >
> > > > Which guest OS are you using? Hopefully they all support either
> > > usb-tablet
> > > > or vmmouse extension for absolute positioning. Otherwise, I'd sugge=
st
> > > using
> > > > Spice, which has those messages for client side guest-mouse drawing=
.
> > > >
> > >
> > > Yeah, I know the best way is use a absolute positioning. We need remo=
ve
> > > all usb devices,
> > > I can only use the PS/2 mouse.
> > >
> >
> > Can't you use vmmouse extension?
>
> Thanks, I will try it. I cann't found the official driver of vmmouse, can=
 I
> install it for free?
>
>
It's been implemented on Linux VM for a long while (first in userspace,
then in kernel since ~2015). But I don't know about the Windows support, it
looks like you need a driver such as provided by VMWave, but it seems
closed-source...  At this point it's probably better to use virtio-input,
which has open-source/free windows drivers.

--00000000000072f4450600ae8d4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 4:53=E2=80=
=AFPM Gao,Shiyuan &lt;<a href=3D"mailto:gaoshiyuan@baidu.com">gaoshiyuan@ba=
idu.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; So move the guest mouse pointer to (0, 0) of the screen when=
 connect the<br>
&gt; &gt; &gt; &gt; VNC, and then move the mouse pointer to the cursor of V=
NC(absolute<br>
&gt; &gt; &gt; &gt; coordinates are also relative coordinates).<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; It&#39;s hardly a solution, you still have no clue what will=
 be the guest<br>
&gt; &gt; mouse<br>
&gt; &gt; &gt; position.<br>
&gt; &gt;<br>
&gt; &gt; We have no clue what will be the guest mouse position, we can mov=
e the<br>
&gt; &gt; guest<br>
&gt; &gt; mouse to (0,0) each connect the VNC. Now, the cursor of VNC will =
be the<br>
&gt; &gt; relative coordinates. In a way, this is a quirk to know the guest=
 mouse<br>
&gt; &gt; position.<br>
&gt; &gt;<br>
&gt;<br>
&gt; There is no guarantee the guest pointer will be at (0,0) though, and t=
hat<br>
&gt; doesn&#39;t explain how that would help. Which client are you using? A=
re you<br>
&gt; drawing the guest cursor? This can&#39;t be done currently with the la=
ck of a<br>
&gt; message to tell the guest mouse position. (moving / sync-ing the clien=
t<br>
&gt; cursor position would be even worse in many ways)<br>
<br>
Sorry, my description isn&#39;t accurate.<br>
<br>
When connect the vnc server,<br>
=C2=A0 =C2=A0 vnc_connect<br>
=C2=A0 =C2=A0 =C2=A0 -&gt; vs-&gt;last_x =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 -&gt; vs-&gt;last_y =3D -1;<br>
<br>
move client cursor to vnc screen,<br>
=C2=A0 =C2=A0 vnc_client_io<br>
=C2=A0 =C2=A0 =C2=A0 -&gt;vnc_client_read<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt;protocol_client_msg<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt;pointer_event(x,y)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; qemu_input_queue_rel(con, I=
NPUT_AXIS_X, 0 - width);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; qemu_input_queue_rel(con, I=
NPUT_AXIS_Y, 0 - height);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; x=3D0,y=3D0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; vs-&gt;last_x =3D x;vs-&gt;=
last_y =3D y;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; qemu_input_event_sync=C2=A0=
 =C2=A0// this will inform the guest move to (0, 0)<br>
<br>
the next event,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt;pointer_event(x,y)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; qemu_input_queue_rel(con, I=
NPUT_AXIS_X, x - vs-&gt;last_x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; qemu_input_queue_rel(con, I=
NPUT_AXIS_X, x - vs-&gt;last_x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; qemu_input_event_sync=C2=A0=
 =C2=A0 // this will inform the guest from (0,0) move to (x,y),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0// the client cursor and guest mouse will sync.<br></blockquote><=
div><br></div><div>Actually, it will be ( x - vs-&gt;last_x, y - vs-&gt;las=
t_y), not necessarily (x, y), unless you also set last_x =3D 0 / last_y =3D=
 0.</div><div><br></div><div>But even then, there is no guarantee the guest=
 position will be a x/y...<br></div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
and if the resolution is high, alse need increace the queue size of ps2 PS2=
_QUEUE_SIZE.<br>
Otherwise, if the guest mouse far from the (0,0) before vnc connect, it can=
&#39;t move to (0,0).<br>
<br></blockquote><div><br></div><div>Oh indeed, ps2 will queue multiple mes=
sages.. another reason you can&#39;t do such big relative moves reliably.</=
div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On windows VM, also need disable &quot;Enhance Pointer =
Precision&quot; Option in<br>
&gt; &gt; &gt; &gt; &quot;Pointer Options&quot; (Control Panel -&gt; Mouse)=
.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; Apparently, this option doesn&#39;t have much to do with rel=
ative mouse<br>
&gt; &gt; motion.<br>
&gt; &gt; &gt; Can you explain what it does with this change?<br>
&gt; &gt;<br>
&gt; &gt; Emmm, I don&#39;t know why this can solve the problem. It&#39;s q=
uite effective and<br>
&gt; &gt; get this way from<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://forum.proxmox.com/threads/is-it-possible-not-t=
o-use-usbdevice-tablet.1498/" rel=3D"noreferrer" target=3D"_blank">https://=
forum.proxmox.com/threads/is-it-possible-not-to-use-usbdevice-tablet.1498/<=
/a><br>
&gt; &gt; .<br>
&gt; &gt;<br>
&gt; &gt; Only use this way, we need to manually align the VNC cursor with =
the guest<br>
&gt; &gt; mouse.<br>
&gt; &gt;<br>
&gt;<br>
&gt; It&#39;s a bit vague what the &quot;VNC cursor&quot; mean. If you mean=
 the client cursor<br>
&gt; position, there is no way to align / sync with the guest without an ex=
tra<br>
&gt; message to inform the client of its position. There is even a comment =
about<br>
&gt; that in vnc.c=C2=A0 /* can we ask the client(s) to move the pointer ??=
? */)<br>
<br>
Sorry, I mean the client cursor position. I found disable &quot;Enhance Poi=
nter Precision&quot;<br>
Option, move cursor to the bound of the VNC screen, they maybe align.<br>
<br>
&gt;<br>
&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Which guest OS are you using? Hopefully they all support eit=
her<br>
&gt; &gt; usb-tablet<br>
&gt; &gt; &gt; or vmmouse extension for absolute positioning. Otherwise, I&=
#39;d suggest<br>
&gt; &gt; using<br>
&gt; &gt; &gt; Spice, which has those messages for client side guest-mouse =
drawing.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Yeah, I know the best way is use a absolute positioning. We need =
remove<br>
&gt; &gt; all usb devices,<br>
&gt; &gt; I can only use the PS/2 mouse.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Can&#39;t you use vmmouse extension?<br>
<br>
Thanks, I will try it. I cann&#39;t found the official driver of vmmouse, c=
an I<br>
install it for free?<br>
<br></blockquote><div><br></div><div>It&#39;s been implemented on Linux VM =
for a long while (first in userspace, then in kernel since ~2015). But I do=
n&#39;t know about the Windows support, it looks like you need a driver suc=
h as provided by VMWave, but it seems closed-source...=C2=A0 At this point =
it&#39;s probably better to use virtio-input, which has open-source/free wi=
ndows drivers.<br></div></div></div>

--00000000000072f4450600ae8d4c--


