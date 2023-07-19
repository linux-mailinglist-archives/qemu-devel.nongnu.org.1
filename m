Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AAF758AB9
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 03:13:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLvk3-0006ZG-7Q; Tue, 18 Jul 2023 21:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qLvk0-0006W2-OE
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:12:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qLvjy-0006UN-J6
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:12:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso6550754f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1689729148; x=1692321148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e5xo6xIZLxdssYcj6bep4g/ZKjYf5/MfO9s1aF+hfT8=;
 b=VkvxhMm0QcG+prZewF5m6bsH1PIJbwqNugq/3nB6KC/qB+Rh1I4o4FRfBTJAwqXinJ
 OXTzsIpNOS0BcLOERkMFNUheeV73wDOXrN+lmT9TOrU/NPll+WJH+LcoDm7seq+N/T6l
 cVfWdFroAJC9YlpoI8uRfgdqP8tfE+1iO3mo73E0OJFXMmpQofBLMcoLrA6uEmrut5th
 0nocDm5x2H+LEw/fjWewG/DI+2/MgL6/ssJ1IFqhAeol01krNGPSj81oA0zvUK3JJO7E
 zRIsz0I0ggom6nwa726sXRMYpqouH8kcWfK36Mj5LD5ubyIRWEhC26gfPArykD5MZw2c
 JjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689729148; x=1692321148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e5xo6xIZLxdssYcj6bep4g/ZKjYf5/MfO9s1aF+hfT8=;
 b=RqELvyXvQugXTY7cLMgGxBeUlf1qZhVQnManID0TCd9UYElJNQnvchKU2ygHDB0pny
 qwqQg5unoF2QGVK9m++aunMoncD3b6Bp2a4cg3SD3hiHUT/AfYGQ/rSA3mcM+CQHdWAh
 b6B0frytA3nUQtX3bZv/IwrVpv6TLFuTERcCrvDYvXU09E6ao+E59xwx6q4w1meoDFJN
 Y8oojDpM7MAMM6tnkma6P4mRBqtrgTVpmnco+KYJG8k78joMWNqv3EUUVhzizFlKkjJI
 NGl7M7PA5qa6xErWvzV59teAnbwC9Arn9h3P7THfR70GoJfV1C24nnz4ehrAJ+ywBI9l
 DdYA==
X-Gm-Message-State: ABy/qLYtSuL/pkO7zXaI2KGfKqkXfuqiL/1rsMGW0eYh/6FQZPj8cql9
 xXxWqOvchfmTmUCHYtVuYkidLEUERPoLtG17L9nTaQ==
X-Google-Smtp-Source: APBJJlExHC3fQVzAkttjFVwyckKV4jqTEb+YphVSmug1MUP10/S4yl8kbk2xRhFI1JfSjFzrpaUo0bahJ6+GTGdg+TI=
X-Received: by 2002:a05:6000:1cce:b0:314:2568:7c9a with SMTP id
 bf14-20020a0560001cce00b0031425687c9amr13850131wrb.17.1689729147784; Tue, 18
 Jul 2023 18:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
 <20230626114916.45355529@mobian.usb.local>
 <20230626100819.vtkuuvzg376hktk2@begin>
In-Reply-To: <20230626100819.vtkuuvzg376hktk2@begin>
From: Felix Wu <flwu@google.com>
Date: Tue, 18 Jul 2023 18:12:16 -0700
Message-ID: <CAJt6XFpDwuim-FF7a5MMibQvJa1YJ=X165n43XEtQaF4356r9w@mail.gmail.com>
Subject: Re: Tips for local testing guestfwd
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009ff2320600ccb92a"
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=flwu@google.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
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

--0000000000009ff2320600ccb92a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am continuing debugging the ipv6 guestfwd feature, and I would like to
understand the behavior of slirp better.

Progress I've made:
Let QEMU take parameter like following:
guestfwd=3Dtcp:[fec0::105]:54322-tcp:[::1]:6655
For slirp side, I basically searched for the appearance of gfwd_list and
made all code traverse the fwd list compatible with ipv6.
With these change, now I can see the packets coming out of the guest OS to
the assigned guest server port via tcpdump:
```
00:38:18.831831 IP6 fdb5:481:10ce:0:8c41:aaff:fea9:f674.52190 >
fec0::105.54322: tcp 0
        0x0000:  600a 1f94 0028 0640 fdb5 0481 10ce 0000  `....(.@........
        0x0010:  8c41 aaff fea9 f674 fec0 0000 0000 0000  .A.....t........
        0x0020:  0000 0000 0000 0105 cbde d432 df6d 8332  ...........2.m.2
        0x0030:  0000 0000 a0*02* fd20 535f 0000 0204 05a0  ........S_.....=
.
        0x0040:  0402 080a b87b fd3b 0000 0000 0103 0307  .....{.;........
```
02 =3D=3D SYN so it looks good. But both tcpdump and wireshark (looking int=
o
packet dump provided by QEMU invocation) didn't see any response and this
packet never reached the host.
I added multiple prints inside slirp and confirmed the ipv6 version of [1]
was reached.
in tcp_output function [2], I got following print:
qemu-system-aarch64: info: Slirp: AF_INET6 out dst ip =3D
fdb5:481:10ce:0:8c41:aaff:fea9:f674, port =3D 52190
qemu-system-aarch64: info: Slirp: AF_INET6 out src ip =3D fec0::105, port =
=3D
54322
It looks like there should be something being sent back to the guest,
unless my understanding of tcp_output is wrong.

To understand the datapath of guestfwd better, I have the following
questions:
1. What's the meaning of tcp_input and tcp_output? My guess is the
following graph, but I would like to confirm.
           tcp_input     tcp_output
QEMU --------> slirp ----------> host
            <--------       <----------
         tcp_output   tcp_input

2. I don't see port 6655 in the above process. How does slirp know 6655 is
the port that needs to be visited on the host side?

Thanks in advance, Felix
[1].
https://gitlab.freedesktop.org/slirp/libslirp/-/blob/master/src/tcp_input.c=
#L630
[2].
https://gitlab.freedesktop.org/slirp/libslirp/-/blob/master/src/tcp_output.=
c#L477


On Mon, Jun 26, 2023 at 3:08=E2=80=AFAM Samuel Thibault <samuel.thibault@gn=
u.org>
wrote:

> Hello,
>
> Felix Wu <flwu@google.com> wrote:
> > 2. I want to understand what ip I should use. Currently I have followin=
g
> > formats for the QEMU invocation in ipv6:
> > ```
> > guestfwd=3Dtcp:[::1]:1234-tcp:[my:host:ip:from:ifconfig]:22
> > ```
> > I know the general form is `guestfwd=3Dtcp:server:port-dev`, where
> > server:port is for guest,
>
> Yes, the address to be used within the guest network. So it needs to be
> within the guest network.
>
> > Is the aforementioned invocation correct?
>
> No, because ::1 isn't in the guest network.
>
> > Or in this case [::1] is the local host address and I should put qemu
> > address for it instead?
>
> You can use whatever IP you want, as long as it's in the guest network.
> e.g. [fec0::1234] if you're with the default fec0::/64 network.
>
> > 3. Is there a default ipv6 address for QEMU instance? I think I need it
> in
> > the invocation.
>
> By default it's address 2 within the prefix, i.e. fec0::2 with the
> default fec0::/64 network.
>
> Samuel
>

--0000000000009ff2320600ccb92a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I am continuing debugging the i=
pv6 guestfwd feature, and I would like to understand the behavior of slirp =
better.</div><div><br></div><div>Progress=C2=A0I&#39;ve made:</div><div>Let=
 QEMU take parameter like following:<br></div><div>guestfwd=3Dtcp:[fec0::10=
5]:54322-tcp:[::1]:6655<br></div><div>For slirp side, I basically searched =
for the appearance=C2=A0of gfwd_list and made all code traverse the fwd lis=
t compatible with ipv6.<br></div><div>With these change, now I can see the =
packets coming out of the guest OS to the assigned guest server port via tc=
pdump:</div><div><span style=3D"color:rgb(32,33,36);font-family:Roboto,Aria=
l,sans-serif;font-size:13px;letter-spacing:0.185714px">```</span></div><div=
><span style=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;fon=
t-size:13px;letter-spacing:0.185714px">00:38:18.831831 IP6 fdb5:481:10ce:0:=
8c41:aaff:fea9:f674.52190 &gt; fec0::105.54322: tcp 0</span><br style=3D"co=
lor:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter=
-spacing:0.185714px"><span style=3D"color:rgb(32,33,36);font-family:Roboto,=
Arial,sans-serif;font-size:13px;letter-spacing:0.185714px">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x0000: =C2=A0600a 1f94 0028 0640 fdb5 0481 10ce 0000 =C2=A0`=
....(.@........</span><br style=3D"color:rgb(32,33,36);font-family:Roboto,A=
rial,sans-serif;font-size:13px;letter-spacing:0.185714px"><span style=3D"co=
lor:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter=
-spacing:0.185714px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0010: =C2=A08c41 aaff fe=
a9 f674 fec0 0000 0000 0000 =C2=A0.A.....t........</span><br style=3D"color=
:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter-sp=
acing:0.185714px"><span style=3D"color:rgb(32,33,36);font-family:Roboto,Ari=
al,sans-serif;font-size:13px;letter-spacing:0.185714px">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x0020: =C2=A00000 0000 0000 0105 cbde d432 df6d 8332 =C2=A0....=
.......2.m.2</span><br style=3D"color:rgb(32,33,36);font-family:Roboto,Aria=
l,sans-serif;font-size:13px;letter-spacing:0.185714px"><span style=3D"color=
:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter-sp=
acing:0.185714px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0030: =C2=A00000 0000 a0*02=
* fd20 535f 0000 0204 05a0 =C2=A0........S_......</span><br style=3D"color:=
rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter-spa=
cing:0.185714px"><span style=3D"color:rgb(32,33,36);font-family:Roboto,Aria=
l,sans-serif;font-size:13px;letter-spacing:0.185714px">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x0040: =C2=A00402 080a b87b fd3b 0000 0000 0103 0307 =C2=A0.....{.=
;........</span><br></div><div>```</div><div>02 =3D=3D SYN so it looks good=
. But both tcpdump and wireshark (looking into packet dump provided by QEMU=
 invocation) didn&#39;t see any response and this packet never reached the =
host.</div><div>I added multiple prints inside slirp and confirmed the ipv6=
 version of [1] was reached.</div><div>in tcp_output function [2], I got fo=
llowing print:</div><div><span style=3D"color:rgb(32,33,36);font-family:Rob=
oto,Arial,sans-serif;font-size:13px;letter-spacing:0.185714px">qemu-system-=
aarch64: info: Slirp: AF_INET6 out dst ip =3D fdb5:481:10ce:0:8c41:aaff:fea=
9:f674, port =3D 52190</span><br style=3D"color:rgb(32,33,36);font-family:R=
oboto,Arial,sans-serif;font-size:13px;letter-spacing:0.185714px"><span styl=
e=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px=
;letter-spacing:0.185714px">qemu-system-aarch64: info: Slirp: AF_INET6 out =
src ip =3D fec0::105, port =3D 54322</span><br></div><div>It looks like the=
re should be something being sent back to the guest, unless my understandin=
g of tcp_output is wrong.</div><div><br></div><div>To understand the datapa=
th of guestfwd better, I have the following questions:</div><div><span styl=
e=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px=
;letter-spacing:0.185714px">1. What&#39;s the meaning of tcp_input and tcp_=
output? My guess is the following graph, but I would like to confirm.</span=
><br style=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-=
size:13px;letter-spacing:0.185714px"><span style=3D"color:rgb(32,33,36);fon=
t-family:Roboto,Arial,sans-serif;font-size:13px;letter-spacing:0.185714px">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcp_input =C2=A0 =C2=A0 tcp_output=
</span><br style=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif=
;font-size:13px;letter-spacing:0.185714px"><span style=3D"color:rgb(32,33,3=
6);font-family:Roboto,Arial,sans-serif;font-size:13px;letter-spacing:0.1857=
14px">QEMU --------&gt; slirp ----------&gt; host</span><br style=3D"color:=
rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter-spa=
cing:0.185714px"><span style=3D"color:rgb(32,33,36);font-family:Roboto,Aria=
l,sans-serif;font-size:13px;letter-spacing:0.185714px">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &lt;-------- =C2=A0 =C2=A0 =C2=A0 &lt;----------</spa=
n><br style=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font=
-size:13px;letter-spacing:0.185714px"><span style=3D"color:rgb(32,33,36);fo=
nt-family:Roboto,Arial,sans-serif;font-size:13px;letter-spacing:0.185714px"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcp_output =C2=A0 tcp_input</span><br></=
div><div><br></div><div>2.=C2=A0<span style=3D"color:rgb(32,33,36);font-fam=
ily:Roboto,Arial,sans-serif;font-size:13px;letter-spacing:0.185714px">I don=
&#39;t see port 6655 in the above=C2=A0process. How does slirp know 6655 is=
 the port that needs to be visited on the host side?</span></div><div><span=
 style=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size=
:13px;letter-spacing:0.185714px"><br></span></div><div><span style=3D"color=
:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter-sp=
acing:0.185714px">Thanks in advance, Felix</span></div><div>[1].<a href=3D"=
https://gitlab.freedesktop.org/slirp/libslirp/-/blob/master/src/tcp_input.c=
#L630">https://gitlab.freedesktop.org/slirp/libslirp/-/blob/master/src/tcp_=
input.c#L630</a></div><div>[2].<a href=3D"https://gitlab.freedesktop.org/sl=
irp/libslirp/-/blob/master/src/tcp_output.c#L477">https://gitlab.freedeskto=
p.org/slirp/libslirp/-/blob/master/src/tcp_output.c#L477</a></div><div><br>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Mon, Jun 26, 2023 at 3:08=E2=80=AFAM Samuel Thibault &lt;<a href=
=3D"mailto:samuel.thibault@gnu.org">samuel.thibault@gnu.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
Felix Wu &lt;<a href=3D"mailto:flwu@google.com" target=3D"_blank">flwu@goog=
le.com</a>&gt; wrote:<br>
&gt; 2. I want to understand what ip I should use. Currently I have followi=
ng<br>
&gt; formats for the QEMU invocation in ipv6:<br>
&gt; ```<br>
&gt; guestfwd=3Dtcp:[::1]:1234-tcp:[my:host:ip:from:ifconfig]:22<br>
&gt; ```<br>
&gt; I know the general form is `guestfwd=3Dtcp:server:port-dev`, where<br>
&gt; server:port is for guest,<br>
<br>
Yes, the address to be used within the guest network. So it needs to be<br>
within the guest network.<br>
<br>
&gt; Is the aforementioned invocation correct?<br>
<br>
No, because ::1 isn&#39;t in the guest network.<br>
<br>
&gt; Or in this case [::1] is the local host address and I should put qemu<=
br>
&gt; address for it instead?<br>
<br>
You can use whatever IP you want, as long as it&#39;s in the guest network.=
<br>
e.g. [fec0::1234] if you&#39;re with the default fec0::/64 network.<br>
<br>
&gt; 3. Is there a default ipv6 address for QEMU instance? I think I need i=
t in<br>
&gt; the invocation.<br>
<br>
By default it&#39;s address 2 within the prefix, i.e. fec0::2 with the<br>
default fec0::/64 network.<br>
<br>
Samuel<br>
</blockquote></div>

--0000000000009ff2320600ccb92a--

