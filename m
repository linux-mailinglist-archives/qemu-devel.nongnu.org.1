Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7A80DB1F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 20:52:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCmJJ-00013r-RV; Mon, 11 Dec 2023 14:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCmJH-00013h-MU
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:51:24 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCmJF-0004AT-HV
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:51:23 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ca0d14976aso65097901fa.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702324279; x=1702929079;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9zr/nLx3aRKvFmPuAX5LTJ1DjqkENwdmLbfKJwJm4KM=;
 b=Zpp83zEo+hXTSjV5DUBsi1hC2fCxFt8Divn9QJrfvC2v6IN47SeFFAau89UCxhCJsH
 I+NKqumeDFKTrKM4JXpS1srYQykxCSysrpLBKQzQN1dI+QT7v3x10UYAnFm88vE6n0gK
 IaMHCOUuxQJXegURg1cLaOw67Xqlkz+Mx4R1ePm20WtFyYpA2kGcho51vD+T3LLXKw8o
 MEPi5R6jDdtCBaI9/2eNCqNzPArk+4VMON+ZBItFYu1r4nAVxGge80LQABM3U26lfdOk
 x9Kdgud7wMAl9TC3NF2/zcH4yftBscJKWxswnGSlXyxxt5t9h6/gvNo4zA1jBovAAvdn
 kuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702324279; x=1702929079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9zr/nLx3aRKvFmPuAX5LTJ1DjqkENwdmLbfKJwJm4KM=;
 b=eOx0ypacVT3BPKORw2v32Rm0tYu9TEyb/GHx+p2jXdbI7D+X9nhrDdUb/SVWO2xoSJ
 IWxvECfEDZJLbtrpYmgzC6cBU91XqM4HMnsZpO4sNxSrfEiEC8qe/kSCXcueA31F6S+s
 0To5iYxltfsrB+pBrhWZJbFTbAyxCCqGoCtZDz4FziqdRg2n5yfIrrQit/JelFsGeYzK
 XdtNhzrgr8qqTzJvoecKVZEWnRTJ8Xy6T0odatVSJVw1ea8Hxm968kEb39uaBFkBm1TV
 LDHsaku8zGewKQkihfTJRASDyKy1sHmMWWsQjzZjkF8L7YbPGpX8RL/fvjyuNyP0zJZv
 ncnA==
X-Gm-Message-State: AOJu0Yz1NH+yczImjoWvFESQo3RLd9++o0y50wpVSwPG9zLD9LYbQVJh
 gmjL3c9p2b0RfmTETp9PZrTSPIfJA1QRZIkhSwnfew==
X-Google-Smtp-Source: AGHT+IECpVHKH+8L64xCp5nN/0blY/0svWBrq2fonCU0iADKb72hCQ86SUett+1vYh0MCYoQgom2kKeSnln7mwFJs/0=
X-Received: by 2002:a2e:b88a:0:b0:2cc:1c21:f729 with SMTP id
 r10-20020a2eb88a000000b002cc1c21f729mr1268278ljp.60.1702324279504; Mon, 11
 Dec 2023 11:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
 <CAOEp5Ofj+a2rqGWw=oLXBqrXqUj6XRc=Je3ScaE5sxZFzaAOdA@mail.gmail.com>
 <431e5902-970b-4fd5-8302-dcc9c4c76bd7@daynix.com>
 <CAOEp5OcW1xrr8EVeiRqQ5OnecxB6xtKJt6hLCqz6GgmSg7CctQ@mail.gmail.com>
 <20231211104224-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231211104224-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 11 Dec 2023 21:51:07 +0200
Message-ID: <CAOEp5OfKnE=qna1FRHqg4y=6Fc=J6U57J3pryV-JBB6TiC-6Hg@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] virtio-net RSS/hash report fixes and improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org, 
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: multipart/alternative; boundary="000000000000f90967060c414120"
Received-SPF: none client-ip=2a00:1450:4864:20::22b;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22b.google.com
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

--000000000000f90967060c414120
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,
Sure, I've reviewed that also, there was a fruitful discussion
till the series r=D0=B5=D0=B0ched its final form.
At the beginning of September we've got the response from Jason that the
series is queued upstream so we were calm and switched to libvirt part ))

Seems like a misunderstanding, let's wait for Jason response.

Thanks,
Yuri




On Mon, Dec 11, 2023 at 5:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Mon, Dec 11, 2023 at 02:34:56PM +0200, Yuri Benditovich wrote:
> > https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05859.html
>
> It's from August, I think it's fair to say it's not going upstream
> unless there's some activity. Yuri did you review that series then?
> Care to ack?
>
> --
> MST
>
>

--000000000000f90967060c414120
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Michael,<div>Sure, I&#39;ve reviewed that also, th=
ere was a fruitful=C2=A0discussion till=C2=A0the=C2=A0series r=D0=B5=D0=B0c=
hed its final form.</div><div>At the beginning of September we&#39;ve got t=
he response from Jason that the series is queued upstream so we were calm a=
nd switched to libvirt part ))</div><div><br></div><div>Seems like a misund=
erstanding,=C2=A0let&#39;s wait for Jason response.</div><div><br></div><di=
v>Thanks,</div><div>Yuri</div><div><br></div><div><br></div><div><br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Dec 11, 2023 at 5:43=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"m=
ailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon, Dec 11, 2023 at 02:34:56PM +020=
0, Yuri Benditovich wrote:<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05=
859.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2023-08/msg05859.html</a><br>
<br>
It&#39;s from August, I think it&#39;s fair to say it&#39;s not going upstr=
eam<br>
unless there&#39;s some activity. Yuri did you review that series then?<br>
Care to ack?<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div>

--000000000000f90967060c414120--

