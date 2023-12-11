Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12980C9F4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 13:36:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCfVE-00005w-1Y; Mon, 11 Dec 2023 07:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCfVB-00005X-7t
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 07:35:13 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCfV8-0006TG-LE
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 07:35:12 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ca03103155so54210491fa.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702298109; x=1702902909;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GcjtGeBnVUTtAgaRVTM0v6HGT1XjA7S7Hy5Ll5iF2yg=;
 b=M5pr9nv/KtJZVqxc7qTsIOkNr1xnP+cKy3mWHsh1UyZ03etjmu9o7BGACg6xhYQ8mY
 6wDPiiyyA2ugnK0/NST8EjdVuYet3+IYKJ+kH7SFnAhq7S3yhHoaySpw9AuL27Hk8Z4p
 FOGftZC0qHxWAaRO123nxu6gVWgmHA5UEoIxTxdHQxEfLZl0Tx2CyWMGpDuymJI5ztE0
 I3QSwPzakQKrC+Q7BqHxZxazx/ctFPJdirq8+YGGEKs4XhUq9p2gCQCoZ0FGmDkrs0Gs
 7QlKo06RqoTDxZ7m9wpJJDrvHrN5XhlePs3vBwGlSm10MZXwnL1ipH6xSXuUEMJM9gCB
 n07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702298109; x=1702902909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GcjtGeBnVUTtAgaRVTM0v6HGT1XjA7S7Hy5Ll5iF2yg=;
 b=r8dAcTGnPU0TmD/1LldvfLGSHNatyV0l+QT4fAgFvCNnfEHX1VOWXGK/NGAzrrNxbw
 eUg0FtHkoG7DeNZDVchsxq0HfqzRrS30UWfmqB4+mbhUE22Ko+Q3Idg7Gbpr9U+Mbgzc
 Qp01wfvnO1hnU6nkdN9AYCXgZPaQaMtPRN8Gc3zVGm5tIaEAqT8KTJL1qi10PAz9r2ud
 lhzVXvNSJE6A6pW6foACk+2RwFBAP4Yjy53oehJz2dtLngRNr/2A1kumk/aIgOJnn4+P
 yP7E+nWeBOEkOcwqpG28ekexKAiyvSMTRjfji5WotXvgSomkvfDTgDa+l8ca5M3Zou1A
 jL1Q==
X-Gm-Message-State: AOJu0YxU0Cqy/AnYRAPR4jPRXQ0hceuyE1ev2cLPbyHkE0164hlHEIsN
 QkCSEdVFSYfbj4His91yPaeNgMaeyKQ4Pmf6IgDpXg==
X-Google-Smtp-Source: AGHT+IEo7uuiA6nLsi4NVIxFu+IVwuuL9ktHBYxnqpDEp42loeIz8OYdp1KZyXYklxB+DR+Kz1DY8QUmmMVSF82p7IU=
X-Received: by 2002:a2e:a69f:0:b0:2cb:2c00:ea78 with SMTP id
 q31-20020a2ea69f000000b002cb2c00ea78mr730859lje.18.1702298108595; Mon, 11 Dec
 2023 04:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
 <CAOEp5Ofj+a2rqGWw=oLXBqrXqUj6XRc=Je3ScaE5sxZFzaAOdA@mail.gmail.com>
 <431e5902-970b-4fd5-8302-dcc9c4c76bd7@daynix.com>
In-Reply-To: <431e5902-970b-4fd5-8302-dcc9c4c76bd7@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 11 Dec 2023 14:34:56 +0200
Message-ID: <CAOEp5OcW1xrr8EVeiRqQ5OnecxB6xtKJt6hLCqz6GgmSg7CctQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] virtio-net RSS/hash report fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org, 
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: multipart/alternative; boundary="00000000000010a323060c3b2a9b"
Received-SPF: none client-ip=2a00:1450:4864:20::233;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x233.google.com
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

--00000000000010a323060c3b2a9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05859.html

On Mon, Dec 11, 2023 at 2:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/12/11 20:54, Yuri Benditovich wrote:
> > People, I suggest to wait a little and understand what happens with the
> > previous series from Andrew Melnichenko (support for qemu under libvirt
> etc)
>
> Can you share the link to the series?
>
> > According to response from Jason from Sept 8 it was queued but I do not
> > see it in the master branch.
>
> I didn't see it either.
>
> Regards,
> Akihiko Odaki
>

--00000000000010a323060c3b2a9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2=
023-08/msg05859.html">https://lists.gnu.org/archive/html/qemu-devel/2023-08=
/msg05859.html</a><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Dec 11, 2023 at 2:01=E2=80=AFPM Akihiko Odaki=
 &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 2023/12/11 20:54, Yuri Benditovich wrote:<br>
&gt; People, I suggest to wait a little and understand what happens with th=
e <br>
&gt; previous series from Andrew Melnichenko (support for qemu under libvir=
t etc)<br>
<br>
Can you share the link to the series?<br>
<br>
&gt; According to response from Jason from Sept 8 it was queued but I do no=
t <br>
&gt; see it in the master branch.<br>
<br>
I didn&#39;t see it either.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
</blockquote></div>

--00000000000010a323060c3b2a9b--

