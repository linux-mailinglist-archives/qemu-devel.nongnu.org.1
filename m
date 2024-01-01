Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31382151B
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 20:04:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKNYh-00012O-Sv; Mon, 01 Jan 2024 14:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rKNYf-000120-Q8
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 14:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rKNYe-0007JE-3L
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 14:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704135756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZsopaZnpVnSQzYAabePbvtjo+oQmgwlrp0tUWETiAI=;
 b=YTaG6UbeatSt7TAspPA3ZPLL6ZJlEFPVEHs8k7DnIIVIYYBXKwCuJ7usnH3135eCjDlo9R
 vMXtzDoZcoejT8ZEjBLXMiL6nV1jCBkvoTaKEdeBDc41iNbBJFImWEx1lDQhRN17uq7ch/
 zAyXwLynao/3Ns9kb5vK9hhTb8Ldsl4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-2u5kyko6OoS9GtPhkh9OXQ-1; Mon, 01 Jan 2024 14:02:29 -0500
X-MC-Unique: 2u5kyko6OoS9GtPhkh9OXQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bbc4a68340so4481739b6e.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 11:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704135749; x=1704740549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gZsopaZnpVnSQzYAabePbvtjo+oQmgwlrp0tUWETiAI=;
 b=jrNMMVMZfQYQYIYKKVvz3b0yAOU/v9ZAArOgPhdFmvnHIpP63AX7Z8xqv7zEb5ePUI
 GWl1j3jOuKko204sRXyKQh76l2iM6Lq855cRoG+aQb3CpPQAfpK53kbYYVJdIk3M27VE
 h1ndO9WQA5dwqGgrh0XoYOmIOAUuTkypPbNbOjSv2+iYLaUpcNH5I2xmuMlx5QiAzusQ
 RLPsvzN1y2hmzd+Gw+N+mM8NDp7eIaKFt6o2/cObO8+F53WN0WRVInOvqhjWm+vCecF4
 EmP5AeTG10Ssd0way3PGz2nf4QgZKVwuid4RMCONdn5E5pf+Kogo4Q/W/hoFx6mupTOB
 nWiw==
X-Gm-Message-State: AOJu0Yw+KAZf0wKneG1Q7AZ1qLk93IHR6v/ZTyheArNLR/f9U7CfjGcY
 SMSMVWlHo05cSaNxrevJGAxHxFbuImDIU2Qim3kUkgImbUxEe+wremyRP722cxY40Qb4rrAq6im
 5PRoBz/GdXejualKacuQAarWa493uBU0b7b3RBJg=
X-Received: by 2002:a05:6808:3c93:b0:3bb:c935:3e0e with SMTP id
 gs19-20020a0568083c9300b003bbc9353e0emr10447808oib.73.1704135749013; 
 Mon, 01 Jan 2024 11:02:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqYk9YnmJ6Smknm62ihgPHJ6rx2+4RzcPu1t+EmJGdRxjR3aAGUM+10KUsKh82hhfzsgz9+AubpCzGKgNOdMQ=
X-Received: by 2002:a05:6808:3c93:b0:3bb:c935:3e0e with SMTP id
 gs19-20020a0568083c9300b003bbc9353e0emr10447801oib.73.1704135748773; Mon, 01
 Jan 2024 11:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20231231093918.239549-1-pbonzini@redhat.com>
 <20231231093918.239549-6-pbonzini@redhat.com>
 <0479f7fd-b3d5-a18c-3640-0c679cd8a834@eik.bme.hu>
In-Reply-To: <0479f7fd-b3d5-a18c-3640-0c679cd8a834@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jan 2024 20:02:16 +0100
Message-ID: <CABgObfa3DVVzRa6v=QREyWqhRyLofiiNpp7ZJdu5nv65GrkHBQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] vga: optimize horizontal pel panning in 256-color
 modes
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Hoffmann, Gerd" <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f47e9d060de705c2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000f47e9d060de705c2
Content-Type: text/plain; charset="UTF-8"

Il dom 31 dic 2023, 17:27 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> >     palette = vga->last_palette;
> >     hpel = (hpel >> 1) & 3;
> > +
> > +    /* For 256 color modes, we can adjust the source address and write
> directly
> > +     * to the destination, even if horizontal pel panning is active.
> However,
> > +     * the loop below assumes that the address does not wrap in the
> middle of a
> > +     * plane.  If that happens...
> > +     */
> > +    if (addr + (width >> 3) * 4 < VGA_VRAM_SIZE) {
> > +        addr += hpel * 4;
> > +        hpel = 0;
> > +    }
> > +
> > +    /* ... use the panning buffer as in planar modes.  */
> >     if (hpel) {
> >         width += 8;
> >         d = vga->panning_buf;
>
> Is it possible to do these checks once in vga.c and instead of changing
> the return value of the draw functions pass panning_buf as d if needed?
> Maybe that way the draw funcs could be left unchanged?
>

As of the previous patch it could, here however the logic for whether to
use the panning_buf depends on the drawing function; 8d2 is special and
different from the others.

I can remove the optimization, it's not super Important; but it's kind of
obvious to do it for the VGA 256-color modes, since they're the only ones
with the same bit alignment for all pixels.

Paolo


> Regards,
> BALATON Zoltan
>
>

--000000000000f47e9d060de705c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il dom 31 dic 2023, 17:27 BALATON Zoltan &lt;<a href=3D"mailto=
:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0palette =3D vga-&gt;last_p=
alette;<br>
&gt;=C2=A0 =C2=A0 =C2=A0hpel =3D (hpel &gt;&gt; 1) &amp; 3;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* For 256 color modes, we can adjust the source addres=
s and write directly<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to the destination, even if horizontal pel pann=
ing is active.=C2=A0 However,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* the loop below assumes that the address does no=
t wrap in the middle of a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* plane.=C2=A0 If that happens...<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (addr + (width &gt;&gt; 3) * 4 &lt; VGA_VRAM_SIZE) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr +=3D hpel * 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hpel =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* ... use the panning buffer as in planar modes.=C2=A0=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (hpel) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width +=3D 8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D vga-&gt;panning_buf;<br>
<br>
Is it possible to do these checks once in vga.c and instead of changing <br=
>
the return value of the draw functions pass panning_buf as d if needed? <br=
>
Maybe that way the draw funcs could be left unchanged?<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">As of the previous pa=
tch it could, here however the logic for whether to use the panning_buf dep=
ends on the drawing function; 8d2 is special and different from the others.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">I can remove the optimi=
zation, it&#39;s not super Important; but it&#39;s kind of obvious to do it=
 for the VGA 256-color modes, since they&#39;re the only ones with the same=
 bit alignment for all pixels.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
</blockquote></div></div></div>

--000000000000f47e9d060de705c2--


