Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE177FE40
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 21:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWiD9-0006Tt-JO; Thu, 17 Aug 2023 14:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qWiD1-0006Qy-Sv
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:59:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qWiCy-0005Fb-Qu
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:59:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3197808bb08so159575f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692298737; x=1692903537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oOHEq0rT07+tCIviFqR7He0NeZ/Xif82w+756j0pUiA=;
 b=ieLIVaR+/4rLgBI/ABi4fEcvKcYAqFadIRxp1T1kz0tlvw+GuEhccuxa2HPq94mdL+
 JUe/Z2HaCjdlPyaF4nSq1vUyQ6otQiEJUdoOfYXihM7+Vj3wKdsW+tVvNEcL1mJjcj5q
 hlZIJP7nPl7+saF5NKlfuDVh09a2PtpReTBRhxyvC2SjTdyxAtVuA5OfFbhUNiy2trxV
 XUfoeV90BErtplxteK7sJJsC5tyZccFxmkHt/eZa7S4LGFU0EoPmz9xhW94oPegOLq5c
 E7SQNt5XZ+2gMt8n2suui1pEFSuQYg8ep5P0iajbbzV3kn64Mflht/jD14JUis/iaNYB
 Oeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298737; x=1692903537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oOHEq0rT07+tCIviFqR7He0NeZ/Xif82w+756j0pUiA=;
 b=RB7SG4hV9nnoqUvrYTT0rKypjUWUPT+7NHsZpgOdY2QfxBqydWJO1b6LwWfZqhtKNz
 GnUxmgzWcOG905YinzBAUEyYpmN8fs+UZ4iIj/3rAVrNvhU1x7ce5Itc6FCiImQp+YFU
 j5QlEC3z6h0HcZqjIYRsFIdEyXZ8v1lFCM8G6IS3u8xcTL2usob7Xk/GMRWc+qL9vHzw
 5J0p5aM3dZE80chhs1mURpBxjcED1aPHbN5BwpbB+o7gvnZ0KA/iR3sPZF1glVW8nSwO
 Pc7FKC3/Oi02CEL/TgErzxehN63+HP95o9Sx9Rjnu3gjj152hCLykTEZQnkq/n1lB/JW
 T7bg==
X-Gm-Message-State: AOJu0YzXoz1T6DfiCD7HXwhGVhfNj1UOWIey0fN5kiERcQjBKDATlNEE
 4mqgN3NFyrHGGzMEa/B5GYA9vTHVW/grtKWFN9Mwbw==
X-Google-Smtp-Source: AGHT+IES7OFkq6scL/CV3unm8ylMFW6SR/cJCDV6GXo5Dmtz6S4mVHkuoSP5oiXcmZfxDLgJnDCOOPa9EOYruwd725I=
X-Received: by 2002:a5d:678f:0:b0:319:8dcf:5c0f with SMTP id
 v15-20020a5d678f000000b003198dcf5c0fmr286411wru.16.1692298737187; Thu, 17 Aug
 2023 11:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
 <20230626114916.45355529@mobian.usb.local>
 <20230626100819.vtkuuvzg376hktk2@begin>
 <CAJt6XFpDwuim-FF7a5MMibQvJa1YJ=X165n43XEtQaF4356r9w@mail.gmail.com>
 <20230720145415.w7s3ystkrf5gc66y@begin>
In-Reply-To: <20230720145415.w7s3ystkrf5gc66y@begin>
From: Felix Wu <flwu@google.com>
Date: Thu, 17 Aug 2023 11:58:45 -0700
Message-ID: <CAJt6XFosqX8xH_QWX1xZmHPg7vYB8r=m+ERgxQtKzhYT4W0urg@mail.gmail.com>
Subject: Re: Tips for local testing guestfwd
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000016409906032301a8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=flwu@google.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000016409906032301a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

Thanks for the clarification! I missed the email so didn't reply in time,
but was able to figure it out.

Hi everyone,
IPv6 guestfwd works in my local test but it has a weird bug: if you send
two requests, the first one gets the correct response, but the second one
gets stuck.
I am using a simple http server for this test, and just noticed this bug
also exists in IPv4 guestfwd. I've documented it in
https://gitlab.com/qemu-project/qemu/-/issues/1835.

Just want to check if anyone has seen the same issue before.

Thanks! Felix

On Thu, Jul 20, 2023 at 7:54=E2=80=AFAM Samuel Thibault <samuel.thibault@gn=
u.org>
wrote:

> Hello,
>
> Felix Wu, le mar. 18 juil. 2023 18:12:16 -0700, a ecrit:
> > 02 =3D=3D SYN so it looks good. But both tcpdump and wireshark (looking=
 into
> packet
> > dump provided by QEMU invocation)
>
> Which packet dump?
>
> > I added multiple prints inside slirp and confirmed the ipv6 version of
> [1] was
> > reached.
> > in tcp_output function [2], I got following print:
> > qemu-system-aarch64: info: Slirp: AF_INET6 out dst ip =3D
> > fdb5:481:10ce:0:8c41:aaff:fea9:f674, port =3D 52190
> > qemu-system-aarch64: info: Slirp: AF_INET6 out src ip =3D fec0::105, po=
rt
> =3D 54322
> > It looks like there should be something being sent back to the guest,
>
> That's what it is.
>
> > unless my understanding of tcp_output is wrong.
>
> It looks so.
>
> > To understand the datapath of guestfwd better, I have the following
> questions:
> > 1. What's the meaning of tcp_input and tcp_output? My guess is the
> following
> > graph, but I would like to confirm.
>
> No, tcp_input is for packets that come from the guest, and tcp_output is
> for packets that are send to the guest. So it's like that:
>
> >         tcp_input    write_cb          host send()
> > QEMU --------> slirp -----------> QEMU --------------------> host
> >     <--------        <---------         <-----------------
> >          tcp_output  slirp_socket_recv    host recv()
>
> > 2. I don't see port 6655 in the above process. How does slirp know 6655
> is the
> > port that needs to be visited on the host side?
>
> Slirp itself *doesn't* know that port. The guestfwd piece just calls the
> SlirpWriteCb when it has data coming from the guest. See the
> documentation:
>
> /* Set up port forwarding between a port in the guest network and a
>  * callback that will receive the data coming from the port */
> SLIRP_EXPORT
> int slirp_add_guestfwd(Slirp *slirp, SlirpWriteCb write_cb, void *opaque,
>                        struct in_addr *guest_addr, int guest_port);
>
> and
>
> /* This is called by the application for a guestfwd, to provide the data
> to be
>  * sent on the forwarded port */
> SLIRP_EXPORT
> void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr, int
> guest_port,
>                        const uint8_t *buf, int size);
>
> Samuel
>

--00000000000016409906032301a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Samuel,<div><br></div><div>Thanks for the clarification=
! I missed the email so didn&#39;t reply in time, but was able to figure it=
 out.</div><div><br></div><div>Hi everyone,</div><div>IPv6 guestfwd works i=
n my local test but it has a weird bug: if you send two requests, the first=
 one gets the correct response, but the second one gets stuck.</div><div>I =
am using a simple http server for this test, and just noticed this bug also=
=C2=A0exists in=C2=A0IPv4 guestfwd. I&#39;ve documented it in=C2=A0<a rel=
=3D"nofollow noreferrer noopener" href=3D"https://gitlab.com/qemu-project/q=
emu/-/issues/1835" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-=
/issues/1835</a>.</div><div><br></div><div>Just want to check if anyone has=
 seen the same issue before.</div><div><br></div><div>Thanks! Felix</div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Thu, Jul 20, 2023 at 7:54=E2=80=AFAM Samuel Thibault &lt;<a href=3D"mailto=
:samuel.thibault@gnu.org">samuel.thibault@gnu.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
Felix Wu, le mar. 18 juil. 2023 18:12:16 -0700, a ecrit:<br>
&gt; 02 =3D=3D SYN so it looks good. But both tcpdump and wireshark (lookin=
g into packet<br>
&gt; dump provided by QEMU invocation)<br>
<br>
Which packet dump?<br>
<br>
&gt; I added multiple prints inside slirp and confirmed the ipv6 version of=
 [1] was<br>
&gt; reached.<br>
&gt; in tcp_output function [2], I got following print:<br>
&gt; qemu-system-aarch64: info: Slirp: AF_INET6 out dst ip =3D<br>
&gt; fdb5:481:10ce:0:8c41:aaff:fea9:f674, port =3D 52190<br>
&gt; qemu-system-aarch64: info: Slirp: AF_INET6 out src ip =3D fec0::105, p=
ort =3D 54322<br>
&gt; It looks like there should be something being sent back to the guest,<=
br>
<br>
That&#39;s what it is.<br>
<br>
&gt; unless my understanding of tcp_output is wrong.<br>
<br>
It looks so.<br>
<br>
&gt; To understand the datapath of guestfwd better, I have the following qu=
estions:<br>
&gt; 1. What&#39;s the meaning of tcp_input and tcp_output? My guess is the=
 following<br>
&gt; graph, but I would like to confirm.<br>
<br>
No, tcp_input is for packets that come from the guest, and tcp_output is<br=
>
for packets that are send to the guest. So it&#39;s like that:<br>
<br>
&gt; =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0tcp_input=C2=A0 =C2=A0 write_cb=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host send()<br>
&gt; QEMU --------&gt; slirp -----------&gt; QEMU --------------------&gt; =
host<br>
&gt; =C2=A0 =C2=A0 &lt;-------- =C2=A0=C2=A0 =C2=A0 =C2=A0 &lt;---------=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;-----------------<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcp_output =C2=A0slirp_socket_recv=
=C2=A0 =C2=A0 host recv()<br>
<br>
&gt; 2.=C2=A0I don&#39;t see port 6655 in the above=C2=A0process. How does =
slirp know 6655 is the<br>
&gt; port that needs to be visited on the host side?<br>
<br>
Slirp itself *doesn&#39;t* know that port. The guestfwd piece just calls th=
e<br>
SlirpWriteCb when it has data coming from the guest. See the<br>
documentation:<br>
<br>
/* Set up port forwarding between a port in the guest network and a<br>
=C2=A0* callback that will receive the data coming from the port */<br>
SLIRP_EXPORT<br>
int slirp_add_guestfwd(Slirp *slirp, SlirpWriteCb write_cb, void *opaque,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct in_addr *guest_addr, int guest_port);<br>
<br>
and <br>
<br>
/* This is called by the application for a guestfwd, to provide the data to=
 be<br>
=C2=A0* sent on the forwarded port */<br>
SLIRP_EXPORT<br>
void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr, int guest_p=
ort,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const uint8_t *buf, int size);<br>
<br>
Samuel<br>
</blockquote></div>

--00000000000016409906032301a8--

