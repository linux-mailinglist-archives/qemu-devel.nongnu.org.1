Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141FA785E89
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 19:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYre6-0002ps-Ss; Wed, 23 Aug 2023 13:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qYre5-0002pk-JZ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:27:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qYrdz-0005KE-Du
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:27:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so5249458f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692811664; x=1693416464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3HVZlighhbdAt2+k8psWTUoYclNfefaHHKE7NVuFHH4=;
 b=G34nAXt596bUHnMUCFPojkuT6kQreAGLvS8Bl5oX5j1BKdPn69+jNDoWFEhsxjLXyc
 jY5adaCK5JFQUqjjXdNJRkwCySeCNfK6EthfSyth1ACylkTZxr2FWmZ60hs9flsBbHLG
 j7mp+bMroLsolfhKvTkm2+7Xue2O+6ICi6WOeKsmj/SZq/70lLj/RMjgv8kPFG5Ss2/Y
 dTdjAfthBPXm22HZkAHe6EJQL7iBoJ/LcV2aBgYWGO/RQKTWjFrcdM5xYje/60fIFpRM
 br8AB7gUvm8kWCccW7znkjrdw6KKPC5jn1SRtL3i4z6qsPG0DZLO7JfP36W6JPZdFt4U
 lzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692811664; x=1693416464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HVZlighhbdAt2+k8psWTUoYclNfefaHHKE7NVuFHH4=;
 b=Kxs/+YodgPEhVeaXg3ST8+nJ+n72nf00hCugBeGMVErHy9fbQTA4Y8iBRbnMryvKHb
 8oEj/3leAFlYG741hEnpz67nKdii+ztiPHcQ94TSQaSFssd+Hg79V0zncgvx9OT72usw
 BNqNioJBp1RexZGCk6edKiHMAupVuBjpFto+vupNlgN4BrUlfY3xfLP6VkIaUmJOLtBt
 77ILcc+R90JPvWwejqOd2s/VEgSnHAtrrGFZET63QiTrOuEcmP7xL9TV5TpgdaNDc4+f
 C+5N+noTIt166cv2O47XaXsxpAliQwP2djTsiDXIwUcsaRIfGtogf2oitH9w6+W3chCb
 dQ8A==
X-Gm-Message-State: AOJu0YwQd0tiwwBrFvFfmZTUYn10+ZL2WQSum2uM9TDA/chsjWBY062G
 +DJgeYaNr32+jlGCnBH8j0dJGBVrk6afOYXO7jFLdQ==
X-Google-Smtp-Source: AGHT+IEe6MieqIk/+Ll4jcvdDxK1gKaAvcT5jl/GZ6K0XWCHDupF8P1erpKjmhAbBpM9rbOqioDAP1K92OJUIbcHihw=
X-Received: by 2002:adf:fd44:0:b0:315:9676:c360 with SMTP id
 h4-20020adffd44000000b003159676c360mr8612518wrs.25.1692811664277; Wed, 23 Aug
 2023 10:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
 <20230626114916.45355529@mobian.usb.local>
 <20230626100819.vtkuuvzg376hktk2@begin>
 <CAJt6XFpDwuim-FF7a5MMibQvJa1YJ=X165n43XEtQaF4356r9w@mail.gmail.com>
 <20230720145415.w7s3ystkrf5gc66y@begin>
 <CAJt6XFosqX8xH_QWX1xZmHPg7vYB8r=m+ERgxQtKzhYT4W0urg@mail.gmail.com>
In-Reply-To: <CAJt6XFosqX8xH_QWX1xZmHPg7vYB8r=m+ERgxQtKzhYT4W0urg@mail.gmail.com>
From: Felix Wu <flwu@google.com>
Date: Wed, 23 Aug 2023 10:27:33 -0700
Message-ID: <CAJt6XFqW4zUvWy6=3WZihkmbp6N-RVczR+5kpLtpxDtLXUBAXQ@mail.gmail.com>
Subject: Re: Tips for local testing guestfwd
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ec598606039a6d6e"
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=flwu@google.com; helo=mail-wr1-x433.google.com
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

--000000000000ec598606039a6d6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update on debugging this thing (already updated
https://gitlab.com/qemu-project/qemu/-/issues/1835):
I saw that `tcp_chr_free_connection` was called after the first response
being successfully sent:
```

slirp_guestfwd_write guestfwd_write: size 80tcp_chr_write
tcp_chr_write: s->state:2tcp_chr_write tcp_chr_write:
len:80qemu_chr_write_parameter len: 80 // tracking
qemu_chr_writeqemu_chr_write_res len: 80 // same
thingtcp_chr_free_connection tcp_chr_free_connection: state: 2,
changing it to disconnecttcp_chr_change_state tcp_chr_change_state:
state: 2, next state: 0 // state 2=3D=3Dconnected, 0=3D=3Ddisconnected.

```
And after that, the state of `SocketChardev` remained disconnected, and
when the 2nd request came in, the `tcp_chr_write` dropped it directly.
Maybe this state machine should be reset after every connection? Not sure.

On Thu, Aug 17, 2023 at 11:58=E2=80=AFAM Felix Wu <flwu@google.com> wrote:

> Hi Samuel,
>
> Thanks for the clarification! I missed the email so didn't reply in time,
> but was able to figure it out.
>
> Hi everyone,
> IPv6 guestfwd works in my local test but it has a weird bug: if you send
> two requests, the first one gets the correct response, but the second one
> gets stuck.
> I am using a simple http server for this test, and just noticed this bug
> also exists in IPv4 guestfwd. I've documented it in
> https://gitlab.com/qemu-project/qemu/-/issues/1835.
>
> Just want to check if anyone has seen the same issue before.
>
> Thanks! Felix
>
> On Thu, Jul 20, 2023 at 7:54=E2=80=AFAM Samuel Thibault <samuel.thibault@=
gnu.org>
> wrote:
>
>> Hello,
>>
>> Felix Wu, le mar. 18 juil. 2023 18:12:16 -0700, a ecrit:
>> > 02 =3D=3D SYN so it looks good. But both tcpdump and wireshark (lookin=
g
>> into packet
>> > dump provided by QEMU invocation)
>>
>> Which packet dump?
>>
>> > I added multiple prints inside slirp and confirmed the ipv6 version of
>> [1] was
>> > reached.
>> > in tcp_output function [2], I got following print:
>> > qemu-system-aarch64: info: Slirp: AF_INET6 out dst ip =3D
>> > fdb5:481:10ce:0:8c41:aaff:fea9:f674, port =3D 52190
>> > qemu-system-aarch64: info: Slirp: AF_INET6 out src ip =3D fec0::105, p=
ort
>> =3D 54322
>> > It looks like there should be something being sent back to the guest,
>>
>> That's what it is.
>>
>> > unless my understanding of tcp_output is wrong.
>>
>> It looks so.
>>
>> > To understand the datapath of guestfwd better, I have the following
>> questions:
>> > 1. What's the meaning of tcp_input and tcp_output? My guess is the
>> following
>> > graph, but I would like to confirm.
>>
>> No, tcp_input is for packets that come from the guest, and tcp_output is
>> for packets that are send to the guest. So it's like that:
>>
>> >         tcp_input    write_cb          host send()
>> > QEMU --------> slirp -----------> QEMU --------------------> host
>> >     <--------        <---------         <-----------------
>> >          tcp_output  slirp_socket_recv    host recv()
>>
>> > 2. I don't see port 6655 in the above process. How does slirp know 665=
5
>> is the
>> > port that needs to be visited on the host side?
>>
>> Slirp itself *doesn't* know that port. The guestfwd piece just calls the
>> SlirpWriteCb when it has data coming from the guest. See the
>> documentation:
>>
>> /* Set up port forwarding between a port in the guest network and a
>>  * callback that will receive the data coming from the port */
>> SLIRP_EXPORT
>> int slirp_add_guestfwd(Slirp *slirp, SlirpWriteCb write_cb, void *opaque=
,
>>                        struct in_addr *guest_addr, int guest_port);
>>
>> and
>>
>> /* This is called by the application for a guestfwd, to provide the data
>> to be
>>  * sent on the forwarded port */
>> SLIRP_EXPORT
>> void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr, int
>> guest_port,
>>                        const uint8_t *buf, int size);
>>
>> Samuel
>>
>

--000000000000ec598606039a6d6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Update on debugging=C2=A0this thing (already updated=C2=A0=
<a rel=3D"nofollow noreferrer noopener" href=3D"https://gitlab.com/qemu-pro=
ject/qemu/-/issues/1835" target=3D"_blank">https://gitlab.com/qemu-project/=
qemu/-/issues/1835</a>):<div>I saw that `tcp_chr_free_connection` was calle=
d after the first response being successfully sent:</div><div>```</div><div=
><pre class=3D"gmail-code gmail-highlight" lang=3D"plaintext"><span lang=3D=
"plaintext" class=3D"gmail-line" id=3D"gmail-LC1">slirp_guestfwd_write gues=
tfwd_write: size 80</span>
<span lang=3D"plaintext" class=3D"gmail-line" id=3D"gmail-LC2">tcp_chr_writ=
e tcp_chr_write: s-&gt;state:2</span>
<span lang=3D"plaintext" class=3D"gmail-line" id=3D"gmail-LC3">tcp_chr_writ=
e tcp_chr_write: len:80</span>
<span lang=3D"plaintext" class=3D"gmail-line" id=3D"gmail-LC4">qemu_chr_wri=
te_parameter len: 80 // tracking qemu_chr_write</span>
<span lang=3D"plaintext" class=3D"gmail-line" id=3D"gmail-LC5">qemu_chr_wri=
te_res len: 80 // same thing</span>
<span lang=3D"plaintext" class=3D"gmail-line" id=3D"gmail-LC6">tcp_chr_free=
_connection tcp_chr_free_connection: state: 2, changing it to disconnect</s=
pan>
<span lang=3D"plaintext" class=3D"gmail-line" id=3D"gmail-LC7">tcp_chr_chan=
ge_state tcp_chr_change_state: state: 2, next state: 0 // state 2=3D=3Dconn=
ected, 0=3D=3Ddisconnected.</span>
</pre></div><div>```</div><div>And after that, the state of `SocketChardev`=
 remained disconnected, and when the 2nd request came in, the `tcp_chr_writ=
e` dropped it directly.</div><div>Maybe this state machine should be reset =
after every connection? Not sure.</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 17, 2023 at 11:58=E2=80=
=AFAM Felix Wu &lt;<a href=3D"mailto:flwu@google.com">flwu@google.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"ltr">Hi Samuel,<div><br></div><div>Thanks for the clarification! I mi=
ssed the email so didn&#39;t reply in time, but was able to figure it out.<=
/div><div><br></div><div>Hi everyone,</div><div>IPv6 guestfwd works in my l=
ocal test but it has a weird bug: if you send two requests, the first one g=
ets the correct response, but the second one gets stuck.</div><div>I am usi=
ng a simple http server for this test, and just noticed this bug also=C2=A0=
exists in=C2=A0IPv4 guestfwd. I&#39;ve documented it in=C2=A0<a rel=3D"nofo=
llow noreferrer noopener" href=3D"https://gitlab.com/qemu-project/qemu/-/is=
sues/1835" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/=
1835</a>.</div><div><br></div><div>Just want to check if anyone has seen th=
e same issue before.</div><div><br></div><div>Thanks! Felix</div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Ju=
l 20, 2023 at 7:54=E2=80=AFAM Samuel Thibault &lt;<a href=3D"mailto:samuel.=
thibault@gnu.org" target=3D"_blank">samuel.thibault@gnu.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
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
</blockquote></div>

--000000000000ec598606039a6d6e--

