Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABE67944CD
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 22:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdzWr-0007f8-Ih; Wed, 06 Sep 2023 16:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qdzWp-0007er-Fx
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:53:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qdzWl-0004Yx-7p
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:53:34 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso2988975e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1694033608; x=1694638408; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ljeWiOBK1YRJqpbJLOZI5OE5Eu/gk5L+xw9UUP2Stp4=;
 b=NnZXxX8mD53QPf0TYNBQt2pZd4Ch4/5sxDIkfAl6o49A19R5F1MTSzHSlBZeMHRI1Z
 EbIxGEBmydN+P9fNluPNj9dWmgwqxaWYVxc22fxWpPi+nUGcienyrJZPZf7ES3eGPGt9
 N6OXSkUDOlrrtFhjMQGIvFlvk7+iXwqBvIxHb66bjEKEhig+NsF9Ngp0KSCKE9mLeIPz
 VfZayt7BX9rVZBXLTUiUV38gmTpL05eU24L2bQkbIs87CFvgS5BUIa+SnYlVek3LAk6N
 viFFgzAWntqKYg+zcXoVS6bJ2cD2xhaDK0S3hQQUX4MNKKBkPJ8JWsvw6B4N4GtWmyHI
 t7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694033608; x=1694638408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ljeWiOBK1YRJqpbJLOZI5OE5Eu/gk5L+xw9UUP2Stp4=;
 b=TcJ9nwmB3kbuFWiqFKn7c0geFRNu/c9vXYe9/E9W6u7p5cgS9/Z2AU8qx4j5ZFXVrc
 kyOYTYWCjdEf3QWpinakJxd7m7fxyr3xV+ju1NTIP4J0vUy6+37EbDktPc9tJg8bhP25
 J55dtaFyPmtr7MUhyFBOAK2YlXHyYDqfFqDvrzrlM2PCjeSF/w1BLZ2G0w04GxnHHz9U
 mf4pRjoZgaE1hwXRBvWSA4asHAbKYiHwF1srbZQlOByEk0lZeCay9KEM4NIUPoszBEZu
 ae4TPBufK0w2/vgE40+qVOUwYrj562s/GM2FKi+fZfgYAUpaadocsdUz5oJlOYElVmfo
 uu/Q==
X-Gm-Message-State: AOJu0Yx1ux+ezmrRCN0WrcwwPBMxk4IZBdAC2x87mu4ON6da4MVmPSRM
 IYFBpqX51BAFa64L07g4Q5vW7/jwXVSaf2uwwI3bEAXCP+I0IyiGGfsKqw==
X-Google-Smtp-Source: AGHT+IHuWOmsSdQeVdS2BkFK1xjvYkGdPyPhBwwwm9Qzh2jk2oZNmBnDSgTceK8zXeK1dWQRnsUyU1YUZYYZy/ZbAiY=
X-Received: by 2002:adf:ef83:0:b0:31d:1833:4130 with SMTP id
 d3-20020adfef83000000b0031d18334130mr3200290wro.71.1694033608091; Wed, 06 Sep
 2023 13:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
 <20230626114916.45355529@mobian.usb.local>
 <20230626100819.vtkuuvzg376hktk2@begin>
 <CAJt6XFpDwuim-FF7a5MMibQvJa1YJ=X165n43XEtQaF4356r9w@mail.gmail.com>
 <20230720145415.w7s3ystkrf5gc66y@begin>
 <CAJt6XFosqX8xH_QWX1xZmHPg7vYB8r=m+ERgxQtKzhYT4W0urg@mail.gmail.com>
 <CAJt6XFqW4zUvWy6=3WZihkmbp6N-RVczR+5kpLtpxDtLXUBAXQ@mail.gmail.com>
In-Reply-To: <CAJt6XFqW4zUvWy6=3WZihkmbp6N-RVczR+5kpLtpxDtLXUBAXQ@mail.gmail.com>
From: Felix Wu <flwu@google.com>
Date: Wed, 6 Sep 2023 13:53:16 -0700
Message-ID: <CAJt6XFp35uMO=KXeghE8khMCcs15pW1CsKNFuhcrSd5AqAJHxA@mail.gmail.com>
Subject: Re: Tips for local testing guestfwd
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007360490604b6ef55"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=flwu@google.com; helo=mail-wm1-x329.google.com
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

--0000000000007360490604b6ef55
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I noticed why the chardev socket backend disconnects, and I would like to
make this a RFC to see how I should fix it.
Current scenario after boot-up:

   1. tcp_chr_read_poll keeps polling the slirp_socket_can_recv, and
   slirp_socket_can_recv returns 0 since slirp_find_ctl_socket couldn't
   find the guestfwd socket.
   2. The returned 0 in step 1 was assigned to the s->max_size (s is
SocketChardev
   *), and the socket chardev handler won't read since readable size is 0.
   3. When the 1st request is sent, the guestfwd socket is added into the
   slirp's socket list, instead of 0, tcp_chr_read_poll will return the
   result of sopreprbuf > 0.
   4. tcp_chr_read reads the thing.
   5. tcp_chr_read_poll still returns things > 0, which is the output of
   sopreprbuf.
   6. tcp_chr_read reads the thing again, but there's nothing in the
   buffer, so it's unhappy, and closes the connection.
   7. any follow-up requests won't be handled.

These tcp_chr* functions are in fle [1], and slirp_* are in fle [2].

My questions:
1. Since this thing doesn't work on 2nd and later requests, I want to know
how this thing is supposed to work, and to avoid asking people vaguely, I
will provide my though following and please correct me if I am wrong:
a. The state machine in chardev socket should maintain a connected
state (s->state
=3D=3D TCP_CHARDEV_STATE_CONNECTED), this means no change in [1].
b. slirp_socket_can_recv should return 0 once all data is read instead of
outcome from sopreprbuf. This means I need to remove the socket or change
its state to no file descriptor [3], namely somehow reset it.
c. When a new request comes in, it will need to add the socket back to this
slirp instance's socket list, populate its file descriptor, and establish
the connection.

b and c sounds convoluted so I want to check.

2. What is the outcome of sopreprbuf function [3]?
Since it's returned to the tcp_chr_read_poll function, I thought it's the
readable bytes in the socket, but in my test I noticed following thing:

tcp_chr_read_poll_size : s->max_size: 132480
tcp_chr_read : size: 2076
tcp_chr_read_poll_size : s->max_size: 129600
tcp_chr_read : size: 0

Even there's not remaining things in the buffer (read size 0), it's still
non-zero, and thus the read function keeps reading it until it becomes
unhappy.
Also, 132480-129600 =3D 2880 vs 2076, the read byte doesn't match.

Either I need to go with the way in question 1, b.c. steps, or I don't need
to delete the socket, but the sopreprbuf wasn't proper to be used there and
I need to correct it.
Also updated https://gitlab.com/qemu-project/qemu/-/issues/1835.

Any feedback will be appreciated, thanks!
Felix

[1].
https://gitlab.com/qemu-project/qemu/-/blob/master/chardev/char-socket.c#L1=
41
[2].
https://gitlab.freedesktop.org/slirp/libslirp/-/blob/master/src/slirp.c#L15=
82
[3].
https://gitlab.freedesktop.org/slirp/libslirp/-/blob/master/src/socket.h#L2=
21

On Wed, Aug 23, 2023 at 10:27=E2=80=AFAM Felix Wu <flwu@google.com> wrote:

> Update on debugging this thing (already updated
> https://gitlab.com/qemu-project/qemu/-/issues/1835):
> I saw that `tcp_chr_free_connection` was called after the first response
> being successfully sent:
> ```
>
> slirp_guestfwd_write guestfwd_write: size 80tcp_chr_write tcp_chr_write: =
s->state:2tcp_chr_write tcp_chr_write: len:80qemu_chr_write_parameter len: =
80 // tracking qemu_chr_writeqemu_chr_write_res len: 80 // same thingtcp_ch=
r_free_connection tcp_chr_free_connection: state: 2, changing it to disconn=
ecttcp_chr_change_state tcp_chr_change_state: state: 2, next state: 0 // st=
ate 2=3D=3Dconnected, 0=3D=3Ddisconnected.
>
> ```
> And after that, the state of `SocketChardev` remained disconnected, and
> when the 2nd request came in, the `tcp_chr_write` dropped it directly.
> Maybe this state machine should be reset after every connection? Not sure=
.
>
> On Thu, Aug 17, 2023 at 11:58=E2=80=AFAM Felix Wu <flwu@google.com> wrote=
:
>
>> Hi Samuel,
>>
>> Thanks for the clarification! I missed the email so didn't reply in time=
,
>> but was able to figure it out.
>>
>> Hi everyone,
>> IPv6 guestfwd works in my local test but it has a weird bug: if you send
>> two requests, the first one gets the correct response, but the second on=
e
>> gets stuck.
>> I am using a simple http server for this test, and just noticed this bug
>> also exists in IPv4 guestfwd. I've documented it in
>> https://gitlab.com/qemu-project/qemu/-/issues/1835.
>>
>> Just want to check if anyone has seen the same issue before.
>>
>> Thanks! Felix
>>
>> On Thu, Jul 20, 2023 at 7:54=E2=80=AFAM Samuel Thibault <samuel.thibault=
@gnu.org>
>> wrote:
>>
>>> Hello,
>>>
>>> Felix Wu, le mar. 18 juil. 2023 18:12:16 -0700, a ecrit:
>>> > 02 =3D=3D SYN so it looks good. But both tcpdump and wireshark (looki=
ng
>>> into packet
>>> > dump provided by QEMU invocation)
>>>
>>> Which packet dump?
>>>
>>> > I added multiple prints inside slirp and confirmed the ipv6 version o=
f
>>> [1] was
>>> > reached.
>>> > in tcp_output function [2], I got following print:
>>> > qemu-system-aarch64: info: Slirp: AF_INET6 out dst ip =3D
>>> > fdb5:481:10ce:0:8c41:aaff:fea9:f674, port =3D 52190
>>> > qemu-system-aarch64: info: Slirp: AF_INET6 out src ip =3D fec0::105,
>>> port =3D 54322
>>> > It looks like there should be something being sent back to the guest,
>>>
>>> That's what it is.
>>>
>>> > unless my understanding of tcp_output is wrong.
>>>
>>> It looks so.
>>>
>>> > To understand the datapath of guestfwd better, I have the following
>>> questions:
>>> > 1. What's the meaning of tcp_input and tcp_output? My guess is the
>>> following
>>> > graph, but I would like to confirm.
>>>
>>> No, tcp_input is for packets that come from the guest, and tcp_output i=
s
>>> for packets that are send to the guest. So it's like that:
>>>
>>> >         tcp_input    write_cb          host send()
>>> > QEMU --------> slirp -----------> QEMU --------------------> host
>>> >     <--------        <---------         <-----------------
>>> >          tcp_output  slirp_socket_recv    host recv()
>>>
>>> > 2. I don't see port 6655 in the above process. How does slirp know
>>> 6655 is the
>>> > port that needs to be visited on the host side?
>>>
>>> Slirp itself *doesn't* know that port. The guestfwd piece just calls th=
e
>>> SlirpWriteCb when it has data coming from the guest. See the
>>> documentation:
>>>
>>> /* Set up port forwarding between a port in the guest network and a
>>>  * callback that will receive the data coming from the port */
>>> SLIRP_EXPORT
>>> int slirp_add_guestfwd(Slirp *slirp, SlirpWriteCb write_cb, void *opaqu=
e,
>>>                        struct in_addr *guest_addr, int guest_port);
>>>
>>> and
>>>
>>> /* This is called by the application for a guestfwd, to provide the dat=
a
>>> to be
>>>  * sent on the forwarded port */
>>> SLIRP_EXPORT
>>> void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr, int
>>> guest_port,
>>>                        const uint8_t *buf, int size);
>>>
>>> Samuel
>>>
>>

--0000000000007360490604b6ef55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I noticed why the chardev socket backend disconnec=
ts, and I would like to make this a RFC to see how I should fix it.</div><d=
iv>Current scenario=C2=A0after boot-up:</div><div><ol><li><code>tcp_chr_rea=
d_poll</code>=C2=A0keeps polling the <code>slirp_socket_can_recv</code>, an=
d <code>slirp_socket_can_recv</code> returns 0 since <code>slirp_find_ctl_s=
ocket</code> couldn&#39;t find the guestfwd socket.</li>
<li>The returned 0 in step 1 was assigned to the s-&gt;max_size (s is <code=
>SocketChardev *</code>), and the socket chardev handler won&#39;t read sin=
ce readable size is 0.</li>
<li>When the 1st request is sent, the guestfwd socket is added into the sli=
rp&#39;s socket list, instead of 0, <code>tcp_chr_read_poll</code> will ret=
urn the result of <code>sopreprbuf</code> &gt; 0.</li>
<li>
<code>tcp_chr_read</code> reads the thing.</li>
<li>
<code>tcp_chr_read_poll</code> still returns things &gt; 0, which is the ou=
tput of <code>sopreprbuf</code>.</li>
<li>
<code>tcp_chr_read</code> reads the thing again, but there&#39;s nothing in=
 the buffer, so it&#39;s unhappy, and closes the connection.</li>
<li>any follow-up requests won&#39;t be handled.</li></ol><div>These=C2=A0<=
span style=3D"font-family:monospace">tcp_chr*=C2=A0</span>functions are in =
fle [1], and=C2=A0<span style=3D"font-family:monospace">slirp_*=C2=A0</span=
>are in fle [2].</div></div><div><br></div><div>My questions:</div><div>1. =
Since this thing doesn&#39;t=C2=A0work on 2nd and later requests, I want to=
 know how this thing is supposed to work, and to avoid asking people vaguel=
y, I will provide my though following and please correct me if I am wrong:<=
/div><div>a. The state machine in chardev socket should maintain a connecte=
d state (<font face=3D"monospace">s-&gt;state =3D=3D TCP_CHARDEV_STATE_CONN=
ECTED</font>), this means no change in [1].</div><div>b.=C2=A0<span style=
=3D"font-family:monospace">slirp_socket_can_recv </span><font face=3D"arial=
, sans-serif">should return 0 once all data is read instead of outcome from=
=C2=A0</font><font face=3D"monospace">sopreprbuf</font>. This means I need =
to remove the socket or change its state to no file descriptor [3], namely =
somehow reset it.</div><div>c. When a new request comes in, it will need to=
 add the socket back to this slirp instance&#39;s socket list, populate its=
 file descriptor, and establish the connection.</div><div><br></div><div>b =
and c sounds convoluted so I want to check.</div><div><br></div><div>2. Wha=
t is the outcome of <font face=3D"monospace">sopreprbuf</font>=C2=A0functio=
n [3]?</div><div>Since it&#39;s returned to the=C2=A0<span style=3D"font-fa=
mily:monospace">tcp_chr_read_poll </span><font face=3D"arial, sans-serif">f=
unction, I thought it&#39;s the readable bytes in the socket, but in my tes=
t I noticed following thing:</font></div><div><font face=3D"arial, sans-ser=
if"><br></font></div><font face=3D"monospace">tcp_chr_read_poll_size : s-&g=
t;max_size: 132480<br>tcp_chr_read : size: 2076</font><div><font face=3D"mo=
nospace">tcp_chr_read_poll_size : s-&gt;max_size: 129600</font></div><div><=
span style=3D"font-family:monospace">tcp_chr_read : size: 0</span><font fac=
e=3D"monospace"><br></font><div><br></div><div>Even there&#39;s not remaini=
ng things in the buffer (read size 0), it&#39;s still non-zero, and thus th=
e read function keeps reading it until it becomes unhappy.</div><div>Also,=
=C2=A0<span style=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-seri=
f;font-size:13px;letter-spacing:0.185714px">132480-129600 =3D 2880 vs 2076,=
 the read byte doesn&#39;t match.</span></div><div><span style=3D"color:rgb=
(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;letter-spacin=
g:0.185714px"><br></span></div><div><span style=3D"color:rgb(32,33,36);font=
-family:Roboto,Arial,sans-serif;font-size:13px;letter-spacing:0.185714px">E=
ither I need to go with the way in question 1, b.c. steps, or I don&#39;t n=
eed to delete the socket, but the=C2=A0</span><span style=3D"font-family:mo=
nospace">sopreprbuf </span><font face=3D"arial, sans-serif">wasn&#39;t prop=
er to be used there and I need to correct it.</font></div><div>Also updated=
=C2=A0<a rel=3D"nofollow noreferrer noopener" href=3D"https://gitlab.com/qe=
mu-project/qemu/-/issues/1835" target=3D"_blank">https://gitlab.com/qemu-pr=
oject/qemu/-/issues/1835</a>.<font face=3D"arial, sans-serif"><br></font></=
div><div><br></div><div><font face=3D"arial, sans-serif">Any feedback will =
be appreciated, thanks!</font></div><div><font face=3D"arial, sans-serif">F=
elix</font></div><div><br><div>[1].=C2=A0<a href=3D"https://gitlab.com/qemu=
-project/qemu/-/blob/master/chardev/char-socket.c#L141">https://gitlab.com/=
qemu-project/qemu/-/blob/master/chardev/char-socket.c#L141</a></div><div>[2=
].=C2=A0<a href=3D"https://gitlab.freedesktop.org/slirp/libslirp/-/blob/mas=
ter/src/slirp.c#L1582">https://gitlab.freedesktop.org/slirp/libslirp/-/blob=
/master/src/slirp.c#L1582</a></div><div>[3].=C2=A0<a href=3D"https://gitlab=
.freedesktop.org/slirp/libslirp/-/blob/master/src/socket.h#L221">https://gi=
tlab.freedesktop.org/slirp/libslirp/-/blob/master/src/socket.h#L221</a></di=
v></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Aug 23, 2023 at 10:27=E2=80=AFAM Felix Wu &lt;<a hr=
ef=3D"mailto:flwu@google.com">flwu@google.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Update on deb=
ugging=C2=A0this thing (already updated=C2=A0<a rel=3D"nofollow noreferrer =
noopener" href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1835" targe=
t=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/1835</a>):<div>I=
 saw that `tcp_chr_free_connection` was called after the first response bei=
ng successfully sent:</div><div>```</div><div><pre lang=3D"plaintext"><span=
 lang=3D"plaintext" id=3D"m_-6822987951129619377gmail-LC1">slirp_guestfwd_w=
rite guestfwd_write: size 80</span>
<span lang=3D"plaintext" id=3D"m_-6822987951129619377gmail-LC2">tcp_chr_wri=
te tcp_chr_write: s-&gt;state:2</span>
<span lang=3D"plaintext" id=3D"m_-6822987951129619377gmail-LC3">tcp_chr_wri=
te tcp_chr_write: len:80</span>
<span lang=3D"plaintext" id=3D"m_-6822987951129619377gmail-LC4">qemu_chr_wr=
ite_parameter len: 80 // tracking qemu_chr_write</span>
<span lang=3D"plaintext" id=3D"m_-6822987951129619377gmail-LC5">qemu_chr_wr=
ite_res len: 80 // same thing</span>
<span lang=3D"plaintext" id=3D"m_-6822987951129619377gmail-LC6">tcp_chr_fre=
e_connection tcp_chr_free_connection: state: 2, changing it to disconnect</=
span>
<span lang=3D"plaintext" id=3D"m_-6822987951129619377gmail-LC7">tcp_chr_cha=
nge_state tcp_chr_change_state: state: 2, next state: 0 // state 2=3D=3Dcon=
nected, 0=3D=3Ddisconnected.</span>
</pre></div><div>```</div><div>And after that, the state of `SocketChardev`=
 remained disconnected, and when the 2nd request came in, the `tcp_chr_writ=
e` dropped it directly.</div><div>Maybe this state machine should be reset =
after every connection? Not sure.</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 17, 2023 at 11:58=E2=80=
=AFAM Felix Wu &lt;<a href=3D"mailto:flwu@google.com" target=3D"_blank">flw=
u@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr">Hi Samuel,<div><br></div><div>Thanks for the c=
larification! I missed the email so didn&#39;t reply in time, but was able =
to figure it out.</div><div><br></div><div>Hi everyone,</div><div>IPv6 gues=
tfwd works in my local test but it has a weird bug: if you send two request=
s, the first one gets the correct response, but the second one gets stuck.<=
/div><div>I am using a simple http server for this test, and just noticed t=
his bug also=C2=A0exists in=C2=A0IPv4 guestfwd. I&#39;ve documented it in=
=C2=A0<a rel=3D"nofollow noreferrer noopener" href=3D"https://gitlab.com/qe=
mu-project/qemu/-/issues/1835" target=3D"_blank">https://gitlab.com/qemu-pr=
oject/qemu/-/issues/1835</a>.</div><div><br></div><div>Just want to check i=
f anyone has seen the same issue before.</div><div><br></div><div>Thanks! F=
elix</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Thu, Jul 20, 2023 at 7:54=E2=80=AFAM Samuel Thibault &lt;<a hr=
ef=3D"mailto:samuel.thibault@gnu.org" target=3D"_blank">samuel.thibault@gnu=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hello,<br>
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
</blockquote></div>

--0000000000007360490604b6ef55--

