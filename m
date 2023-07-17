Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F70755F11
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 11:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLKLn-0003na-Uw; Mon, 17 Jul 2023 05:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLKLm-0003nJ-7u
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLKLj-0008V7-Mi
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689585417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=USSmdus9/wmkJ3DMtQXv3dYJXfug3V/lUlMYoKvz98k=;
 b=bID/Vbq/6gdctA6bRulglE1vAffSE26nQBMw3fmNq7CYlHh9Ns8vcGEELlFuriSUuKT3k8
 pB9eSjpemlWcQ1yoOQ7euApxVGzHyTZbqcsXSEZJolyywFYqbj8wkR5e0+1TkhVqzbj8DJ
 d7mO2CpwtHJZSqvvck3rcSZgtYBd68Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-J4HVSUVgOc6e-YWvUCWHNg-1; Mon, 17 Jul 2023 05:16:55 -0400
X-MC-Unique: J4HVSUVgOc6e-YWvUCWHNg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-518676b6d09so2491148a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 02:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689585414; x=1692177414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=USSmdus9/wmkJ3DMtQXv3dYJXfug3V/lUlMYoKvz98k=;
 b=lAZKME1CJxaK5jAwJSjL2P9Vfq6yQDOb/dZn4ANiWpf02+PRPDmpETpZlGAu2bQlHz
 4zim1lghoAWyqVRNcurbo4v5MG7yG0eWLXn4MPpMijrhl6u/0F9xl81djxdoNSIG5fcZ
 fxtU4ZUxVBpmTBvz7yd2KOZ5OiYLoUocKM8oHSOOtcnnhvtstKEvaBEOGSfU26r9y9Uu
 hcvZYAk2uEc4FLvPNwFOz061CKezQ2AHhERvmC6iYh7ul2CWT1XNYuw5qMQBzHMpTrI9
 FvQ/beqA9AVpWWlCvgQE6+nDsO78x5XqCUUVdtz+l0UBQ24s72x0/5nHnFmIPjCddpVN
 ewGA==
X-Gm-Message-State: ABy/qLYEw8u4eWGpslNDz+KnJDlubgI5nRNQTdFm8SBuDMzr8CVXJNBl
 c+SKuJZOZ8vuic7aOYc1PdMYlCjtwp/UZR18mGufGCRJcmUrl6/PpNzPG9PZNc5B5cEIgkDPtmx
 YkqMssbJwBDN1yB9nu/qawob/k4HagYk=
X-Received: by 2002:aa7:d7d1:0:b0:51b:c6d8:71b5 with SMTP id
 e17-20020aa7d7d1000000b0051bc6d871b5mr11141146eds.22.1689585413817; 
 Mon, 17 Jul 2023 02:16:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqko7F+EdgN57zVsKSGNCiTf8Uw8UgIGNTf24YVQ4avxhVb5/+T3dM8PPCZEI2NsiGNDFNkzCWdxqwsy+BvSk=
X-Received: by 2002:aa7:d7d1:0:b0:51b:c6d8:71b5 with SMTP id
 e17-20020aa7d7d1000000b0051bc6d871b5mr11141108eds.22.1689585413223; Mon, 17
 Jul 2023 02:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
 <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
In-Reply-To: <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Jul 2023 13:16:41 +0400
Message-ID: <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005f88b50600ab427f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000005f88b50600ab427f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 17, 2023 at 12:54=E2=80=AFPM Gao,Shiyuan <gaoshiyuan@baidu.com>=
 wrote:

> Hi,
> > Hi Shiyuan
> >
> > On Mon, Jul 17, 2023 at 7:16=E2=80=AFAM Shiyuan Gao <gaoshiyuan@baidu.c=
om>
> wrote:
> >
> > > When only use PS/2 mouse without usb-tablet, the mouse pointer of the
> > > guest on the VNC will work badly that the cursor of VNC is inconsiste=
nt
> > > with the mouse pointer of guest.
> > >
> > >
> > Afaik, VNC doesn't support client-side drawing of guest mouse (there ar=
e
> no
> > message to set guest mouse position). So the guest mouse should be draw=
n
> by
> > the server, and currently QEMU doesn't do it.
> >
> >
> > > The reason is the PS/2 mouse use relative coordinates and we can't kn=
ow
> > > the initial position of the guest mouse pointer.
> > >
> >
> > It's not just about the initial position.
>
> Now pointer_event use the cursor of VNC init the vs->last_x, vs->last_y
> when
> connect the VNC and the relative coordinates is based on VNC cursor. If t=
he
> initial position of VNC cursor is inconsistent with guest mouse, the
> inconsistency will keep. I think the root cause is we cann't know the
> postion
> of the guest mouse pointer.
>

last_x/last_y is only used when the client doesn't support relative motion
(pointer-motion change pseudo encoding): it doesn't have a direct relation
with the guest pointer position, it's only use to compute the relative
motion of the client pointer as a fallback.


> >
> > >
> > >
> > So move the guest mouse pointer to (0, 0) of the screen when connect th=
e
> > > VNC, and then move the mouse pointer to the cursor of VNC(absolute
> > > coordinates are also relative coordinates).
> > >
> > >
> > It's hardly a solution, you still have no clue what will be the guest
> mouse
> > position.
>
> We have no clue what will be the guest mouse position, we can move the
> guest
> mouse to (0,0) each connect the VNC. Now, the cursor of VNC will be the
> relative coordinates. In a way, this is a quirk to know the guest mouse
> position.
>

There is no guarantee the guest pointer will be at (0,0) though, and that
doesn't explain how that would help. Which client are you using? Are you
drawing the guest cursor? This can't be done currently with the lack of a
message to tell the guest mouse position. (moving / sync-ing the client
cursor position would be even worse in many ways)


> >
> >
> > > On windows VM, also need disable "Enhance Pointer Precision" Option i=
n
> > > "Pointer Options" (Control Panel -> Mouse).
> > >
> > >
> > Apparently, this option doesn't have much to do with relative mouse
> motion.
> > Can you explain what it does with this change?
>
> Emmm, I don't know why this can solve the problem. It's quite effective a=
nd
> get this way from
>
> https://forum.proxmox.com/threads/is-it-possible-not-to-use-usbdevice-tab=
let.1498/
> .
>
> Only use this way, we need to manually align the VNC cursor with the gues=
t
> mouse.
>

It's a bit vague what the "VNC cursor" mean. If you mean the client cursor
position, there is no way to align / sync with the guest without an extra
message to inform the client of its position. There is even a comment about
that in vnc.c  /* can we ask the client(s) to move the pointer ??? */)



> >
> > Which guest OS are you using? Hopefully they all support either
> usb-tablet
> > or vmmouse extension for absolute positioning. Otherwise, I'd suggest
> using
> > Spice, which has those messages for client side guest-mouse drawing.
> >
>
> Yeah, I know the best way is use a absolute positioning. We need remove
> all usb devices,
> I can only use the PS/2 mouse.
>

Can't you use vmmouse extension?


>
> Anyway, when connecting to VNC, move the mouse to the upper left corner,
> at least not
> to make things worse.
>
> >
> > > Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
> > > ---
> > >  hw/input/ps2.c | 2 +-
> > >  ui/vnc.c       | 5 +++++
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> > > index 45af76a837..e1f44bd298 100644
> > > --- a/hw/input/ps2.c
> > > +++ b/hw/input/ps2.c
> > > @@ -77,7 +77,7 @@
> > >  #define MOUSE_STATUS_ENABLED    0x20
> > >  #define MOUSE_STATUS_SCALE21    0x10
> > >
> > > -#define PS2_QUEUE_SIZE      16  /* Queue size required by PS/2
> protocol */
> > > +#define PS2_QUEUE_SIZE      32  /* Queue size required by PS/2
> protocol */
> > >  #define PS2_QUEUE_HEADROOM  8   /* Queue size for keyboard command
> > > replies */
> > >
> > >  /* Bits for 'modifiers' field in PS2KbdState */
> > > diff --git a/ui/vnc.c b/ui/vnc.c
> > > index 92964dcc0c..a1a6048ee4 100644
> > > --- a/ui/vnc.c
> > > +++ b/ui/vnc.c
> > > @@ -1816,6 +1816,11 @@ static void pointer_event(VncState *vs, int
> > > button_mask, int x, int y)
> > >          if (vs->last_x !=3D -1) {
> > >              qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x);
> > >              qemu_input_queue_rel(con, INPUT_AXIS_Y, y - vs->last_y);
> > > +        } else {
> > > +            qemu_input_queue_rel(con, INPUT_AXIS_X, 0 - width);
> > > +            qemu_input_queue_rel(con, INPUT_AXIS_Y, 0 - height);
> > > +            x =3D 0;
> > > +            y =3D 0;
> > >          }
> > >          vs->last_x =3D x;
> > >          vs->last_y =3D y;
> > > --
> > > 2.27.0
> > >
> > >
>
>

--0000000000005f88b50600ab427f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 12:54=E2=80=
=AFPM Gao,Shiyuan &lt;<a href=3D"mailto:gaoshiyuan@baidu.com">gaoshiyuan@ba=
idu.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi,<br>
&gt; Hi Shiyuan<br>
&gt;<br>
&gt; On Mon, Jul 17, 2023 at 7:16=E2=80=AFAM Shiyuan Gao &lt;<a href=3D"mai=
lto:gaoshiyuan@baidu.com" target=3D"_blank">gaoshiyuan@baidu.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; &gt; When only use PS/2 mouse without usb-tablet, the mouse pointer of=
 the<br>
&gt; &gt; guest on the VNC will work badly that the cursor of VNC is incons=
istent<br>
&gt; &gt; with the mouse pointer of guest.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Afaik, VNC doesn&#39;t support client-side drawing of guest mouse (the=
re are no<br>
&gt; message to set guest mouse position). So the guest mouse should be dra=
wn by<br>
&gt; the server, and currently QEMU doesn&#39;t do it.<br>
&gt;<br>
&gt;<br>
&gt; &gt; The reason is the PS/2 mouse use relative coordinates and we can&=
#39;t know<br>
&gt; &gt; the initial position of the guest mouse pointer.<br>
&gt; &gt;<br>
&gt;<br>
&gt; It&#39;s not just about the initial position.<br>
<br>
Now pointer_event use the cursor of VNC init the vs-&gt;last_x, vs-&gt;last=
_y when<br>
connect the VNC and the relative coordinates is based on VNC cursor. If the=
<br>
initial position of VNC cursor is inconsistent with guest mouse, the<br>
inconsistency will keep. I think the root cause is we cann&#39;t know the p=
ostion<br>
of the guest mouse pointer.<br></blockquote><div><br></div><div>last_x/last=
_y is only used when the client doesn&#39;t support relative motion (pointe=
r-motion change pseudo encoding): it doesn&#39;t have a direct relation wit=
h the guest pointer position, it&#39;s only use to compute the relative mot=
ion of the client pointer as a fallback.<br></div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; So move the guest mouse pointer to (0, 0) of the screen when connect t=
he<br>
&gt; &gt; VNC, and then move the mouse pointer to the cursor of VNC(absolut=
e<br>
&gt; &gt; coordinates are also relative coordinates).<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; It&#39;s hardly a solution, you still have no clue what will be the gu=
est mouse<br>
&gt; position.<br>
<br>
We have no clue what will be the guest mouse position, we can move the gues=
t<br>
mouse to (0,0) each connect the VNC. Now, the cursor of VNC will be the<br>
relative coordinates. In a way, this is a quirk to know the guest mouse pos=
ition.<br></blockquote><div><br></div><div>There is no guarantee the guest =
pointer will be at (0,0) though, and that doesn&#39;t explain how that woul=
d help. Which client are you using? Are you drawing the guest cursor? This =
can&#39;t be done currently with the lack of a message to tell the guest mo=
use position. (moving / sync-ing the client cursor position would be even w=
orse in many ways)<br></div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt;<br>
&gt;<br>
&gt; &gt; On windows VM, also need disable &quot;Enhance Pointer Precision&=
quot; Option in<br>
&gt; &gt; &quot;Pointer Options&quot; (Control Panel -&gt; Mouse).<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Apparently, this option doesn&#39;t have much to do with relative mous=
e motion.<br>
&gt; Can you explain what it does with this change?<br>
<br>
Emmm, I don&#39;t know why this can solve the problem. It&#39;s quite effec=
tive and<br>
get this way from<br>
<a href=3D"https://forum.proxmox.com/threads/is-it-possible-not-to-use-usbd=
evice-tablet.1498/" rel=3D"noreferrer" target=3D"_blank">https://forum.prox=
mox.com/threads/is-it-possible-not-to-use-usbdevice-tablet.1498/</a>.<br>
<br>
Only use this way, we need to manually align the VNC cursor with the guest =
mouse.<br></blockquote><div><br></div><div>It&#39;s a bit vague what the &q=
uot;VNC cursor&quot; mean. If you mean the client cursor position, there is=
 no way to align / sync with the guest without an extra message to inform t=
he client of its position. There is even a comment about that in vnc.c=C2=
=A0 /* can we ask the client(s) to move the pointer ??? */)<br></div><div><=
br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Which guest OS are you using? Hopefully they all support either usb-ta=
blet<br>
&gt; or vmmouse extension for absolute positioning. Otherwise, I&#39;d sugg=
est using<br>
&gt; Spice, which has those messages for client side guest-mouse drawing.<b=
r>
&gt;<br>
<br>
Yeah, I know the best way is use a absolute positioning. We need remove all=
 usb devices,<br>
I can only use the PS/2 mouse.<br></blockquote><div><br></div><div>Can&#39;=
t you use vmmouse extension?</div><div>=C2=A0<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Anyway, when connecting to VNC, move the mouse to the upper left corner, at=
 least not<br>
to make things worse.<br>
<br>
&gt;<br>
&gt; &gt; Signed-off-by: Shiyuan Gao &lt;<a href=3D"mailto:gaoshiyuan@baidu=
.com" target=3D"_blank">gaoshiyuan@baidu.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/input/ps2.c | 2 +-<br>
&gt; &gt;=C2=A0 ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 +++++<br>
&gt; &gt;=C2=A0 2 files changed, 6 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/input/ps2.c b/hw/input/ps2.c<br>
&gt; &gt; index 45af76a837..e1f44bd298 100644<br>
&gt; &gt; --- a/hw/input/ps2.c<br>
&gt; &gt; +++ b/hw/input/ps2.c<br>
&gt; &gt; @@ -77,7 +77,7 @@<br>
&gt; &gt;=C2=A0 #define MOUSE_STATUS_ENABLED=C2=A0 =C2=A0 0x20<br>
&gt; &gt;=C2=A0 #define MOUSE_STATUS_SCALE21=C2=A0 =C2=A0 0x10<br>
&gt; &gt;<br>
&gt; &gt; -#define PS2_QUEUE_SIZE=C2=A0 =C2=A0 =C2=A0 16=C2=A0 /* Queue siz=
e required by PS/2 protocol */<br>
&gt; &gt; +#define PS2_QUEUE_SIZE=C2=A0 =C2=A0 =C2=A0 32=C2=A0 /* Queue siz=
e required by PS/2 protocol */<br>
&gt; &gt;=C2=A0 #define PS2_QUEUE_HEADROOM=C2=A0 8=C2=A0 =C2=A0/* Queue siz=
e for keyboard command<br>
&gt; &gt; replies */<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 /* Bits for &#39;modifiers&#39; field in PS2KbdState */<br>
&gt; &gt; diff --git a/ui/vnc.c b/ui/vnc.c<br>
&gt; &gt; index 92964dcc0c..a1a6048ee4 100644<br>
&gt; &gt; --- a/ui/vnc.c<br>
&gt; &gt; +++ b/ui/vnc.c<br>
&gt; &gt; @@ -1816,6 +1816,11 @@ static void pointer_event(VncState *vs, in=
t<br>
&gt; &gt; button_mask, int x, int y)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vs-&gt;last_x !=3D -1) {<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_=
rel(con, INPUT_AXIS_X, x - vs-&gt;last_x);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_=
rel(con, INPUT_AXIS_Y, y - vs-&gt;last_y);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(c=
on, INPUT_AXIS_X, 0 - width);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(c=
on, INPUT_AXIS_Y, 0 - height);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;last_x =3D x;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;last_y =3D y;<br>
&gt; &gt; --<br>
&gt; &gt; 2.27.0<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div></div>

--0000000000005f88b50600ab427f--


