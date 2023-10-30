Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14327DBA2C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 13:53:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxRkX-0006dC-NQ; Mon, 30 Oct 2023 08:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxRkV-0006c9-UL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:52:07 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxRkT-0004w0-Ra
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:52:07 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c594196344so64428541fa.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698670324; x=1699275124;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ng2ChuYM/Z2YnskJMQA0+GcGB0Da/VKWSu82n4elek=;
 b=eNCIcRhZa3dPSrQ20kx9M+EBc/jkkTteDcc0+15FZNY71NyPGpoXBe7NxRonrYVPcO
 nlNr8teZaceFhYxGdBhJlxJXlMzThTMQQbaoCokI2ucVv2l3J/GArAdbWdFmFAJ6w83k
 x5V7yLiY7qMa9qYWvBTKZACYyBs0ByyXe0BFUPaFnXVZyRj9a4ztNsnp3qZYgUBzivSc
 LOLKx/BZ4ONADtMir4O0i+PSr3VKJYkeNXJI3YHsiWolYLy8zeEsBFlunUNS2xK4q6GF
 D0K5JOpNzXq73A89jZBtY3VbfcXGbr6kVu9ts8Z5OVD8i/rD189UU62exh3Xkyjiux/+
 PrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698670324; x=1699275124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ng2ChuYM/Z2YnskJMQA0+GcGB0Da/VKWSu82n4elek=;
 b=ISAEYc9um9E1AZ3bcMlPz3JRLn4VZy4Y1MsB6Jk0PXszzoNVL+RLpWYv5P6+ywkoiO
 sfAMy95BjuHlHSv3c2hBKrghZ/JjTo9Yp9SEnB/kNpVLkuHZauss9WS3p7Aym30wkMjB
 QGrapwjdN8yv2YZmPn/zv2UAfAMCq94yXVi1C3vbgZPwewaokkc78E+0yv8gRB77QW7D
 FOqm2zc1bF5dQMupKVSfVQJ4Y3mcTX7ULgyYLaUg2dsdSXSEuWoLmUjloZVQ72eWC8It
 +d3odoAbLMuNxiQzzNqE+O3vaJq5joHSEr+zEP0ENodQeMUtIw1dMhMe1ZyZHdMFLsy2
 GP9A==
X-Gm-Message-State: AOJu0YxLL7cQyfzoo/fAQ37mSPjw3+kpmDGpYytZaZpRILxaN3DNzrrn
 s0A35yQxQAMv4L8z6UqNPyUsjbClwE4fYJi9gu/lXw==
X-Google-Smtp-Source: AGHT+IGLeSfgnYcPx5EhVNej308zXVuBgGU4IIwyzPzz1UV29t2KpuZd4CJzl5MjpiZ4ezgXyPxRaMmrw0k4Rt0kBwc=
X-Received: by 2002:a05:651c:119b:b0:2c5:14d1:a303 with SMTP id
 w27-20020a05651c119b00b002c514d1a303mr6570309ljo.25.1698670323811; Mon, 30
 Oct 2023 05:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
In-Reply-To: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 30 Oct 2023 14:51:51 +0200
Message-ID: <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003ddc1b0608ee810d"
Received-SPF: none client-ip=2a00:1450:4864:20::230;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000003ddc1b0608ee810d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 2:21=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/10/30 21:14, Yuri Benditovich wrote:
> >
> >
> > On Mon, Oct 30, 2023 at 7:14=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> >     implicitly disables RSS even if the user explicitly requests it.
> Return
> >     an error instead of implicitly disabling RSS if RSS is requested bu=
t
> not
> >     available.
> >
> >
> > I think that suggesting RSS feature when in fact it is not available is
> > not a good idea, this rather desinforms the guest.
> > Existing behavior (IMHO) makes more sense.
> > We can extend this discussion if needed, of course.
>
> This change is not to advertise RSS when it's not available; it instead
> reports an error to the user.
>
> For example, think of the following command line:
> qemu-system-x86_64 -device virtio-net,rss=3Don,netdev=3Dn -netdev user,id=
=3Dn
>
> Before this change, it gives no error and the user will not know RSS is
> not available. With this change it now gives an error as follows:
> qemu-system-x86_64: -device virtio-net,rss=3Don,netdev=3Dn: Can't load eB=
PF RSS
>

Does this mean failure to run QEMU if the RSS required in the command line
and EBPF can't be loaded?
(for example if we run the system with kernel < 5.8)?
I'm not sure this is user-friendly behavior...

--0000000000003ddc1b0608ee810d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 2:21=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 2023/10/30 21:14, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, Oct 30, 2023 at 7:14=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"m=
ailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com<=
/a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost requires eBPF for RSS. When eBPF is not avail=
able, virtio-net<br>
&gt;=C2=A0 =C2=A0 =C2=A0implicitly disables RSS even if the user explicitly=
 requests it. Return<br>
&gt;=C2=A0 =C2=A0 =C2=A0an error instead of implicitly disabling RSS if RSS=
 is requested but not<br>
&gt;=C2=A0 =C2=A0 =C2=A0available.<br>
&gt; <br>
&gt; <br>
&gt; I think that suggesting RSS feature when in fact it is not available i=
s <br>
&gt; not a good idea, this rather desinforms the guest.<br>
&gt; Existing behavior (IMHO) makes more sense.<br>
&gt; We can extend this discussion if needed, of course.<br>
<br>
This change is not to advertise RSS when it&#39;s not available; it instead=
 <br>
reports an error to the user.<br>
<br>
For example, think of the following command line:<br>
qemu-system-x86_64 -device virtio-net,rss=3Don,netdev=3Dn -netdev user,id=
=3Dn<br>
<br>
Before this change, it gives no error and the user will not know RSS is <br=
>
not available. With this change it now gives an error as follows:<br>
qemu-system-x86_64: -device virtio-net,rss=3Don,netdev=3Dn: Can&#39;t load =
eBPF RSS<br></blockquote><div><br></div><div>Does this mean failure to run =
QEMU if the RSS required in the command line and EBPF can&#39;t be loaded?<=
/div><div>(for example if we run the system with kernel &lt; 5.8)?</div><di=
v>I&#39;m not sure this is user-friendly behavior...</div></div></div>

--0000000000003ddc1b0608ee810d--

