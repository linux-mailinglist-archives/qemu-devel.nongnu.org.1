Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DA72DB70
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 09:47:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8yk9-0005FD-SG; Tue, 13 Jun 2023 03:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8yk7-0005F1-QB
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:47:07 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8yk6-0001x7-0R
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:47:07 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-463992996d2so1551609e0c.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686642424; x=1689234424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uqJ4s6wD3eoGyJZpE3BdtPf5LKSHQBUo5g/oSgno0TM=;
 b=gRmTsQ/16PAsD6IyvklTMIO4ZfM2r+bKN8HPvHMRKunA+cuTjB9gx/j32szk/aLOPO
 dSKmlHGzTaVFz1jti0PmBNB8uTmq/LKZUD+54vho7Haeo3y54pgb3BVG+yKnOTTA0tE3
 OxubQvKvAIsxNPemCisNYhAVCkk7WORhY3gVyIhc+pZ4XBXjeaiUvChEA3/ZUSNL01X0
 fKP6qXmddacpSLTirqqIFM2KeHcUYwVz99ndf8ZPmJLOpjZdtCT+k+VsWafG/34Agj7N
 rk5e90zgu9ySTY+z01jlSJDVvXfeH8FALPIM9eTUASR9UOwSl/1Gw+hWQIsuE83xYkLD
 IruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686642424; x=1689234424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uqJ4s6wD3eoGyJZpE3BdtPf5LKSHQBUo5g/oSgno0TM=;
 b=ZNpXCQp0gjU1+ZcNxE6TCW1wNBjKsOrWeapJwLUEs5sg4TKG5pDvDKXY1ASbmCIAiD
 VjyYrw3+OEuRdvjZEMuGreBS5ZVNy+iKhf9WS8rMN7PgPZDzygtGRuck7wA28k3Y3yVJ
 Qzs/612WuGkIyk9fI4MsgTwqs5WAFk5KpPylKE8hjG5beY6bfggGRQLvLH3kdMZS7AED
 EQmjLAw7NzXvSvcqYlMFhI8yaOTyJfoqED2w0MQoYEpaTdUgdLEW4CS672SzuBsrAceo
 AcahqKj8HsXwb+aTp061G2eehVUz9zyeybPq4VsQEE+GMROvuP/pK3hXSsg1Fpi0Zo2M
 BGjQ==
X-Gm-Message-State: AC+VfDwpeJhovCKOvAmmtjiuCuCCEKUlQ6Dm2Mis6yd8bFM2rw/fNz2u
 5pXQQFOTX5TeXydQGZKvUY/1aMORI0u8/0AnWcI=
X-Google-Smtp-Source: ACHHUZ5uQbxOPC+SVseDefnY6lJMtBkKJuPpod79fU1X8lhsCE76+GTtJMSCZCh1X02H+hVFjGUP64ozPejpyqz/eKU=
X-Received: by 2002:a1f:c1cc:0:b0:45e:4ef7:f7f8 with SMTP id
 r195-20020a1fc1cc000000b0045e4ef7f7f8mr5513201vkf.8.1686642424457; Tue, 13
 Jun 2023 00:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
 <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
From: Bernhard Beschow <shentey@gmail.com>
Date: Tue, 13 Jun 2023 09:46:53 +0200
Message-ID: <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="00000000000092b03d05fdfe0aca"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=shentey@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000092b03d05fdfe0aca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 3:01=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Sun, 11 Jun 2023 12:33:59 +0200
> Bernhard Beschow <shentey@gmail.com> wrote:
>
> > Fixes the following clangd warning (-Winitializer-overrides):
> >
> >   q35.c:297:19: Initializer overrides prior initialization of this
> subobject
> >   q35.c:292:19: previous initialization is here
> >
> > Settle on native endian which causes the least overhead.
> indeed it doesn't matter which way we read all ones, so that should work.
> but does it really matter (I mean the overhead/what workload)?
> If not, I'd prefer explicit LE as it's now to be consistent
> the the rest of memops on Q35.
>

I got a comment from Michael about this in [1], so I've changed it. I don't
mind changing it either way.

Best regards,
Bernhard

[1]
https://patchew.org/QEMU/20230214131441.101760-1-shentey@gmail.com/20230214=
131441.101760-3-shentey@gmail.com/#20230301164339-mutt-send-email-mst@kerne=
l.org

>
> >
> > Fixes: bafc90bdc594 ("q35: implement TSEG")
> > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> > ---
> >  hw/pci-host/q35.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index fd18920e7f..859c197f25 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -290,7 +290,6 @@ static const MemoryRegionOps blackhole_ops =3D {
> >      .valid.max_access_size =3D 4,
> >      .impl.min_access_size =3D 4,
> >      .impl.max_access_size =3D 4,
> > -    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >  };
> >
> >  /* PCIe MMCFG */
>
>

--00000000000092b03d05fdfe0aca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 12, 2023 at 3:01=E2=80=AFPM I=
gor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com=
</a>&gt; wrote:</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Sun, 11 Jun 2023 12:33:59 +0200<br>
Bernhard Beschow &lt;<a href=3D"mailto:shentey@gmail.com" target=3D"_blank"=
>shentey@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Fixes the following clangd warning (-Winitializer-overrides):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0q35.c:297:19: Initializer overrides prior initialization o=
f this subobject<br>
&gt;=C2=A0 =C2=A0q35.c:292:19: previous initialization is here<br>
&gt; <br>
&gt; Settle on native endian which causes the least overhead.<br>
indeed it doesn&#39;t matter which way we read all ones, so that should wor=
k.<br>
but does it really matter (I mean the overhead/what workload)?<br>
If not, I&#39;d prefer explicit LE as it&#39;s now to be consistent<br>
the the rest of memops on Q35.<br></blockquote><div><br></div><div>I got a =
comment from Michael about this in [1], so I&#39;ve changed it. I don&#39;t=
 mind changing it either way.</div><div><br></div><div>Best regards,</div><=
div>Bernhard<br></div><div><br></div><div>[1] <a href=3D"https://patchew.or=
g/QEMU/20230214131441.101760-1-shentey@gmail.com/20230214131441.101760-3-sh=
entey@gmail.com/#20230301164339-mutt-send-email-mst@kernel.org">https://pat=
chew.org/QEMU/20230214131441.101760-1-shentey@gmail.com/20230214131441.1017=
60-3-shentey@gmail.com/#20230301164339-mutt-send-email-mst@kernel.org</a> <=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Fixes: bafc90bdc594 (&quot;q35: implement TSEG&quot;)<br>
&gt; Signed-off-by: Bernhard Beschow &lt;<a href=3D"mailto:shentey@gmail.co=
m" target=3D"_blank">shentey@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/pci-host/q35.c | 1 -<br>
&gt;=C2=A0 1 file changed, 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c<br>
&gt; index fd18920e7f..859c197f25 100644<br>
&gt; --- a/hw/pci-host/q35.c<br>
&gt; +++ b/hw/pci-host/q35.c<br>
&gt; @@ -290,7 +290,6 @@ static const MemoryRegionOps blackhole_ops =3D {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 .valid.max_access_size =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .impl.max_access_size =3D 4,<br>
&gt; -=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* PCIe MMCFG */<br>
<br>
</blockquote></div></div>

--00000000000092b03d05fdfe0aca--

