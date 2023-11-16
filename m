Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA87ED8CB
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:05:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3QnU-0006PD-RB; Wed, 15 Nov 2023 20:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r3QnQ-0006Oq-T2
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:03:52 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r3QnN-0007Wi-EB
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:03:52 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-282ff1a97dcso170924a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 17:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700096505; x=1700701305;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ba+u/1M4G+n4jNG3nxiH6+e104+FX6BEKEDEHFGQPFM=;
 b=ero3ET5ZSRdtV7lCe17liV+OBzBCItegSwMtKMdhG4GzesFtJx6QSCtxdcgxHlBglV
 xojd1Qb0DuK79VEDtngp5HXBqKcBDEeEfXdt4g/paTgEF/emx+iaGuZNUA9OE5AQHQ+O
 DD4Av1/03gOXwoTKK7PCii1moH+8VOZs47klr35hDEUlqglu0Q64MI9Ez9wNd4KfvY89
 lO3Ny8RQ7hCmIFboO1KaJ/aFxGTDTiIVxJ+oix5GiII5AKSQAg9dhfdl/qdWg2en8KxA
 ZTYYZpNCOnsPnuPGPYJfq+hKN0dckq1NExarGHA+mv16/tvWFWflt0m0AvdIBKC+uF5E
 dIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700096505; x=1700701305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ba+u/1M4G+n4jNG3nxiH6+e104+FX6BEKEDEHFGQPFM=;
 b=jkJeN1B0XvQAFzviRSA3oGaRoas4SKdBJs6HvdSgHHHtpbM7vGKWPs6IECXUJqGoiP
 L9C0JScZFR0xymNhlUhJhEiFmQ80TpETkEUpjUMu8tyWsyIAMLo6jyXBSNCatRxG/5aw
 wTAAiCqPz8mD1QyfNHWuMO7D1adJa7d/s76+4ttQ+7bFSd0iRxYqrGe6YRffHPRNY668
 K+Zyw57WcCmS/Vd+vILJfd2g+dn/y08x0Pau7i4WhZWSWG/rt353U/SBz6TjDELNjG7T
 XA7eEik0huv/FdDwpzfgaDqPzn/o0JngtFlm03xLZtkXTiGjHBLMY4mBMwqnQ/+VgEhW
 Z4og==
X-Gm-Message-State: AOJu0YwOHyNUXepWBHbPLgJUkGJ5eydRDw5BdrnQfaSt5hu2WsQbgELj
 rCjjn69DIb7Rl3UTND1zJdCkG1zEeennqnaS4Nk+Q5WJ4qncsN072LxZCA==
X-Google-Smtp-Source: AGHT+IEgdxO69h/AdCKVsKLEJZDYOHrptapG+VrLP3T2zHlw0g82mBaSA1m/TQ5tjs1gzRdfh+Y4A+gOUtDkvtjlC+I=
X-Received: by 2002:a17:90b:4f45:b0:280:2935:af23 with SMTP id
 pj5-20020a17090b4f4500b002802935af23mr13504295pjb.5.1700096504761; Wed, 15
 Nov 2023 17:01:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699793550.git.yong.huang@smartx.com>
In-Reply-To: <cover.1699793550.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 16 Nov 2023 09:01:28 +0800
Message-ID: <CAK9dgmbjF__gwDn+oEehiyS0P2vSGh-onfFXCHsuOGZhzNhc+g@mail.gmail.com>
Subject: Re: [RFC 0/2] vhost-user-test: Add negotiated features check
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000401ff8060a3a901a"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000401ff8060a3a901a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Sun, Nov 12, 2023 at 9:03=E2=80=AFPM Hyman Huang <yong.huang@smartx.com>=
 wrote:

> The patchset "Fix the virtio features negotiation flaw" fix a
> vhost-user negotiation flaw:
> c9bdc449f9 vhost-user: Fix the virtio features negotiation flaw
> bebcac052a vhost-user: Refactor the chr_closed_bh
> 937b7d96e4 vhost-user: Refactor vhost acked features saving
>
> While the test case remain unmerged, the detail reference:
>
> https://lore.kernel.org/qemu-devel/cover.1667232396.git.huangy81@chinatel=
ecom.cn/
>
> Since Michael pointed out that the info virtio makes sense to query
> the negotiation feature, this patchset uses the x-query-virtio-status
> to retrieve the features instead of exporting netdev capabilities and
> information as we did in the previous patchset to aid in confirming
> the negotiation's validity.
>
> To do that, we first introduce an "show-bits" argument for
> x-query-virtio-status such that the feature bits can be used
> directly, and then implement the test case for negotiated features
> check. As we post, the code is divided into two patches.
>
> Please review, thanks,
> Yong
>
> Hyman Huang (2):
>   qapi/virtio: introduce the "show-bits" argument for
>     x-query-virtio-status
>   vhost-user-test: Add negotiated features check
>
>  hw/virtio/virtio-hmp-cmds.c   |   2 +-
>  hw/virtio/virtio-qmp.c        |  21 ++++++-
>  qapi/virtio.json              |  49 ++++++++++++++++-
>  tests/qtest/vhost-user-test.c | 100 ++++++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+), 5 deletions(-)
>
> --
> 2.39.1
>
>

--=20
Best regards

--000000000000401ff8060a3a901a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">ping</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 12, 20=
23 at 9:03=E2=80=AFPM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.c=
om">yong.huang@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">The patc=
hset &quot;Fix the virtio features negotiation flaw&quot; fix a<br>
vhost-user negotiation flaw:<br>
c9bdc449f9 vhost-user: Fix the virtio features negotiation flaw<br>
bebcac052a vhost-user: Refactor the chr_closed_bh<br>
937b7d96e4 vhost-user: Refactor vhost acked features saving<br>
<br>
While the test case remain unmerged, the detail reference:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/cover.1667232396.git.huangy81=
@chinatelecom.cn/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel=
.org/qemu-devel/cover.1667232396.git.huangy81@chinatelecom.cn/</a><br>
<br>
Since Michael pointed out that the info virtio makes sense to query<br>
the negotiation feature, this patchset uses the x-query-virtio-status<br>
to retrieve the features instead of exporting netdev capabilities and<br>
information as we did in the previous patchset to aid in confirming<br>
the negotiation&#39;s validity.<br>
<br>
To do that, we first introduce an &quot;show-bits&quot; argument for<br>
x-query-virtio-status such that the feature bits can be used<br>
directly, and then implement the test case for negotiated features<br>
check. As we post, the code is divided into two patches.<br>
<br>
Please review, thanks,<br>
Yong<br>
<br>
Hyman Huang (2):<br>
=C2=A0 qapi/virtio: introduce the &quot;show-bits&quot; argument for<br>
=C2=A0 =C2=A0 x-query-virtio-status<br>
=C2=A0 vhost-user-test: Add negotiated features check<br>
<br>
=C2=A0hw/virtio/virtio-hmp-cmds.c=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 21 ++++++-<=
br>
=C2=A0qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 49 ++++++++++++++++-<br>
=C2=A0tests/qtest/vhost-user-test.c | 100 +++++++++++++++++++++++++++++++++=
+<br>
=C2=A04 files changed, 167 insertions(+), 5 deletions(-)<br>
<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000401ff8060a3a901a--

