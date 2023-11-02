Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4727DEEA9
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 10:11:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyThy-0004gD-HQ; Thu, 02 Nov 2023 05:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyThw-0004fq-9s
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:09:44 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyThu-0003Zx-3m
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:09:43 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso10064201fa.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698916180; x=1699520980;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U2nWwmmtAy6EWIJ0uFwVcUBxmCZA/kFzcbNcHasMqjc=;
 b=gUwHgDzr3HGKxfyxWk72ZNuMDQtjQxV8ccZrsVOEq7cz+3TujQsg5E6Q5jAz3GlZYD
 mv6und6oXKPnEqOb+uLLy+JFxrfglIEU2WKi2rSiRndPSXTZWALZHG0wkedb3Q8dtH3o
 jkvCPAhr4XtQmBOt3KV3EpL9zAHp71Dgb1+jQO8s3eXb7RfDAkAMDE2xAIP1fHL0CPlf
 7pWXN1E0J7Ck70v6eQqmjPNCbcWNiByzD5LJiWGagtySXA+GJgnGM2vOzuSbrZr5hHZe
 CWvhxyAEDlrMncPGgsgeVCI5MfWZt5ZPBtXz0UzWDFQeJb1hluvIUL4IIoToqWKnjOy7
 DA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698916180; x=1699520980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2nWwmmtAy6EWIJ0uFwVcUBxmCZA/kFzcbNcHasMqjc=;
 b=ICGWLVRNi7fLbdiJw6c38dW61Ed4p4wIXa9JGvZQrk/LorWGDAUzDLjiUP15DRsXBM
 ICgUo1pxw01wbicraSBTAfaV9DS28+LWn6L9T161Q2lgMjN9sSoF8SFnC87A8vZezLmY
 MNm9VSZOhrzRJ+Ryixsai9RI0W1J9y80Y9Z7T3hAk2bbmyotbaQ+NFvoWPGRwALmBLKW
 ICwj5HT6T8kVOlisKkh5sje8NDqrteoK7sPhh19OWx0XJ66sKHg9SwCjV6DhKY+8p9rL
 dPU2rHELa/Eg8soSijFD07+jmdXEhtd6Z6gXcYccgXzRlB//b/LmHGz6bybEoAN+vWI4
 4h8w==
X-Gm-Message-State: AOJu0Yw+PCry/MRk/wjuiXwfPcJKFYUin88RwlFEaU6ly11byVAh8T3A
 P7Knoo1o7H3TqhPhDBOYAbYwaYSIuntgPl2ZZA3QCg==
X-Google-Smtp-Source: AGHT+IH6w0NQLfqB/M8sxZ36l0dZO6Jr5oqw59Gcu9aEVwTAS7m0EnN7DZcYYYFIxTs4K2citw4a72eWhmOpm1lsX4I=
X-Received: by 2002:a2e:a7d2:0:b0:2b9:4b2e:5420 with SMTP id
 x18-20020a2ea7d2000000b002b94b2e5420mr17076947ljp.52.1698916179766; Thu, 02
 Nov 2023 02:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
In-Reply-To: <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 2 Nov 2023 11:09:27 +0200
Message-ID: <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000660170060927bf3d"
Received-SPF: none client-ip=2a00:1450:4864:20::234;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x234.google.com
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

--000000000000660170060927bf3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Probably we mix two different patches in this discussion.
Focusing on the patch in the e-mail header:

IMO it is not acceptable to fail QEMU run for one feature that we can't
make active when we silently drop all other features in such a case.

On Wed, Nov 1, 2023 at 11:15=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/11/01 18:09, Michael S. Tsirkin wrote:
> > On Wed, Nov 01, 2023 at 05:35:50PM +0900, Akihiko Odaki wrote:
> >> On 2023/11/01 15:38, Michael S. Tsirkin wrote:
> >>> On Wed, Nov 01, 2023 at 01:50:00PM +0900, Akihiko Odaki wrote:
> >>>> We had another discussion regarding migration for patch "virtio-net:
> Do not
> >>>> clear VIRTIO_NET_F_HASH_REPORT". It does change the runtime behavior
> so we
> >>>> need to take migration into account. I still think the patch does no=
t
> >>>> require a compatibility flag since it only exposes a new feature and
> does
> >>>> not prevent migrating from old QEMU that exposes less features. It
> instead
> >>>> fixes the case where migrating between hosts with different tap
> feature
> >>>> sets.
> >>>
> >>> When in doubt, add a compat flag.
> >>
> >> Personally I'm confident about the migration compatibility with patch
> >> "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT". virtio-net alread=
y
> does
> >> the same thing when the tap implementation on the destination implemen=
ts
> >> virtio-net header support while the counterpart of the source does not=
.
> >
> > Trust me there's been so many times where we were very sure and
> > problems come up later. Just don't enable new functionality for
> > old machine types, problem solved. Why is this hard?
>
> I see. I'll add a compatibility flag for VIRTIO_NET_F_HASH_REPORT
> exposure; it should be quite easy.
>

--000000000000660170060927bf3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Probably we mix two different patches in this discussion.<=
div><div>Focusing on the patch in the e-mail header:</div><div><br></div><d=
iv>IMO it is not acceptable to fail QEMU run for one feature that we can&#3=
9;t make active when we silently drop all other features in such a case.</d=
iv></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Wed, Nov 1, 2023 at 11:15=E2=80=AFAM Akihiko Odaki &lt;<a href=
=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2023/11/01 =
18:09, Michael S. Tsirkin wrote:<br>
&gt; On Wed, Nov 01, 2023 at 05:35:50PM +0900, Akihiko Odaki wrote:<br>
&gt;&gt; On 2023/11/01 15:38, Michael S. Tsirkin wrote:<br>
&gt;&gt;&gt; On Wed, Nov 01, 2023 at 01:50:00PM +0900, Akihiko Odaki wrote:=
<br>
&gt;&gt;&gt;&gt; We had another discussion regarding migration for patch &q=
uot;virtio-net: Do not<br>
&gt;&gt;&gt;&gt; clear VIRTIO_NET_F_HASH_REPORT&quot;. It does change the r=
untime behavior so we<br>
&gt;&gt;&gt;&gt; need to take migration into account. I still think the pat=
ch does not<br>
&gt;&gt;&gt;&gt; require a compatibility flag since it only exposes a new f=
eature and does<br>
&gt;&gt;&gt;&gt; not prevent migrating from old QEMU that exposes less feat=
ures. It instead<br>
&gt;&gt;&gt;&gt; fixes the case where migrating between hosts with differen=
t tap feature<br>
&gt;&gt;&gt;&gt; sets.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; When in doubt, add a compat flag.<br>
&gt;&gt;<br>
&gt;&gt; Personally I&#39;m confident about the migration compatibility wit=
h patch<br>
&gt;&gt; &quot;virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT&quot;. vir=
tio-net already does<br>
&gt;&gt; the same thing when the tap implementation on the destination impl=
ements<br>
&gt;&gt; virtio-net header support while the counterpart of the source does=
 not.<br>
&gt; <br>
&gt; Trust me there&#39;s been so many times where we were very sure and<br=
>
&gt; problems come up later. Just don&#39;t enable new functionality for<br=
>
&gt; old machine types, problem solved. Why is this hard?<br>
<br>
I see. I&#39;ll add a compatibility flag for VIRTIO_NET_F_HASH_REPORT <br>
exposure; it should be quite easy.<br>
</blockquote></div>

--000000000000660170060927bf3d--

