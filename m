Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913B7A2F05
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 11:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhRZC-0007bp-RK; Sat, 16 Sep 2023 05:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qhRZB-0007bb-2L; Sat, 16 Sep 2023 05:26:17 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qhRZ8-0006Br-Cn; Sat, 16 Sep 2023 05:26:16 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso3373712a12.3; 
 Sat, 16 Sep 2023 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694856372; x=1695461172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KRQfI5qQvvUoDhheHKWnDUAK2fiyxZ85hutxnpZHL9s=;
 b=cbmWT65ZxTRkdwGqYavW8CFlYLAA98rvhXGo4ghcauj0r/J4JO/ZUQV6s5Vb+pjcgX
 NBbSdoW45oWAOS0tGVbp8+vi6XXoC38L6ntaso8jMy8ED1m3d8WmHWoPtv3yDl1DJ/7M
 5n29QKC8wredhUs0obgOsQEvc/+KQSCgOeX7umBr6v1jR9sMFWoJ9y/lk/rKXnMAcC1x
 E/kQ5HAMJwe5L8hypcHOuAI3P+yg/bTFKsrWOPQw8YuncbyLyxwUhRlxiIaRTwrdnbHR
 Fb1UXP3QtF2Gdrm0Y/+SqkowKfkKvXVCDqkVrC1kvYYyL9kpTjmBzqm9uO/uAtUXSpjL
 IkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694856372; x=1695461172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KRQfI5qQvvUoDhheHKWnDUAK2fiyxZ85hutxnpZHL9s=;
 b=bvY3xkyrf2I/C+LrvcQQhjAT3MztjtUIDGuKRxgv3FJ1Au3cbXf//CqVh8gFl0ECDR
 Vzijmhi1gV3K3SR+GoujZMAiTWQINHHgfNFLLu1ncvx3eVVKkkjINR8iN8M8xoloJghZ
 KRnCa30yix4ma0Mc8PwS5VXlrIjchM0qy26a3n4edNuXh7/H2+K8O1kOsGm/NL/3tl8/
 k3aP5li8hRc3H5D1TEtmaGkZJIsG4guFHn2JD1JwSL7euFINRj4F2JoFS2AGQLfXj1O4
 0Uw2ZUQ5UE7bvGor2bjMzRmysFhM10sz6d4hGglkFMWPDS4C8yIOo1ulZEf3C8nJh0HZ
 iDZQ==
X-Gm-Message-State: AOJu0YxcCFucyVZxDH1o5j0+p+4xTf8TmPuqJhmvIiSK6UjKkrzdLnPo
 prvvO7asidECLHmGmAwdHXrdgj0rJZ9FGm//Zzw=
X-Google-Smtp-Source: AGHT+IG76znz9ymI5L1ugufhSS86KJblFctIoF8pwqvR6jyK5lx56c3tto7fVjibumAT3Hg7uuK1dhcnZRueZPs7AeE=
X-Received: by 2002:a05:6402:b32:b0:522:2782:537 with SMTP id
 bo18-20020a0564020b3200b0052227820537mr3131420edb.15.1694856371793; Sat, 16
 Sep 2023 02:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
 <20230905201425.118918-6-strahinja.p.jankovic@gmail.com>
 <CAFEAcA-601OV-RDDy4V+b7+2Ciyer8LSRiz+tfLHMWBTgwXvPg@mail.gmail.com>
In-Reply-To: <CAFEAcA-601OV-RDDy4V+b7+2Ciyer8LSRiz+tfLHMWBTgwXvPg@mail.gmail.com>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Sat, 16 Sep 2023 11:26:00 +0200
Message-ID: <CABtshVTOAwtSZKyNQtmM+=5NG8d5RLQ8=ef9MB=4qkF62aw2BA@mail.gmail.com>
Subject: Re: [RFC Patch 5/5] hw/input: Add Allwinner-A10 PS2 emulation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Beniamino Galvani <b.galvani@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000fc72760605767fae"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fc72760605767fae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thank you for your comments.

I used the PL050 component as a starting point, but I did not clean things
up well after I saw it working. I will clean it up before sending the new
patch version.

On Fri, Sep 15, 2023 at 4:23=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 5 Sept 2023 at 21:14, Strahinja Jankovic
> <strahinjapjankovic@gmail.com> wrote:
> >
> > Add emulation for PS2-0 and PS2-1 for keyboard/mouse.
> >
> > Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
>
>
>
> > +static int allwinner_a10_ps2_fctl_is_irq(AwA10PS2State *s)
> > +{
> > +    return (s->regs[REG_INDEX(REG_FCTL)] & FIELD_REG_FCTL_TXRDY_IEN) |=
|
> > +        (s->pending &&
> > +         (s->regs[REG_INDEX(REG_FCTL)] & FIELD_REG_FCTL_RXRDY_IEN));
>
> It looks a little odd that you need a separate s->pending bool here.
> Sometimes hardware does odd things, but the most usual situation
> is that the pending status of an interrupt is directly reflected
> in a register bit somewhere, and "is the interrupt high" logic
> is then just "is the pending bit set and is the enable bit set".
> Often the bit positions are deliberately the same in the two
> registers and then "is an interrupt set" is something like
>   if (s->regs[REG_INDEX(REG_FCTL)] & s->regs[REG_INDEX(REG_FSTS)] &
>       (TXRDY_IEN | RXRDY_IEN))
>
>
Yes, that makes sense. I will try to improve this.


>
> > +}
> > +
> > +static void allwinner_a10_ps2_update_irq(AwA10PS2State *s)
> > +{
> > +    int level =3D (s->regs[REG_INDEX(REG_GCTL)] & FIELD_REG_GCTL_INT_E=
N)
> &&
> > +        allwinner_a10_ps2_fctl_is_irq(s);
> > +
> > +    qemu_set_irq(s->irq, level);
> > +}
> > +
> > +static void allwinner_a10_ps2_set_irq(void *opaque, int n, int level)
> > +{
> > +    AwA10PS2State *s =3D (AwA10PS2State *)opaque;
> > +
> > +    s->pending =3D level;
> > +    allwinner_a10_ps2_update_irq(s);
> > +}
> > +
> > +static uint64_t allwinner_a10_ps2_read(void *opaque, hwaddr offset,
> > +                                       unsigned size)
> > +{
> > +    AwA10PS2State *s =3D AW_A10_PS2(opaque);
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +
> > +    switch (offset) {
> > +    case REG_FSTS:
> > +        {
> > +            uint32_t stat =3D FIELD_REG_FSTS_TX_RDY;
> > +            if (s->pending) {
> > +                stat |=3D FIELD_REG_FSTS_RX_LEVEL1 |
> FIELD_REG_FSTS_RX_RDY;
> > +            }
> > +            return stat;
>
> The logic here also suggests that the code would be simpler if you
> keep the TX_RDY and RX_RDY state directly in this register value,
> rather than hardcoding TX_RDY to always-set and keeping RX_RDY
> in a separate pending field.
>
>
That makes sense, I'll fix it.


> > +        }
> > +        break;
> > +    case REG_DATA:
> > +        if (s->pending) {
> > +            s->last =3D ps2_read_data(s->ps2dev);
> > +        }
> > +        return s->last;
>
> You could keep the last returned data in s->regs[REG_IDX(REG_DATA)]
> and avoid having to have an extra s->last field in the state struct.
>
>
Ok.


> > +    case REG_GCTL:
> > +        {
> > +            if (allwinner_a10_ps2_fctl_is_irq(s)) {
> > +                s->regs[idx] |=3D FIELD_REG_GCTL_INT_FLAG;
> > +            } else {
> > +                s->regs[idx] &=3D FIELD_REG_GCTL_INT_FLAG;
> > +            }
> > +        }
> > +        break;
> > +    case REG_LCTL:
> > +    case REG_LSTS:
> > +    case REG_FCTL:
> > +    case REG_CLKDR:
> > +        break;
> > +    case 0x1C ... AW_A10_PS2_IOSIZE:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        return 0;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented read offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        return 0;
> > +    }
> > +
> > +    return s->regs[idx];
> > +}
> > +
> > +static void allwinner_a10_ps2_write(void *opaque, hwaddr offset,
> > +                                   uint64_t val, unsigned size)
> > +{
> > +    AwA10PS2State *s =3D AW_A10_PS2(opaque);
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +
> > +    s->regs[idx] =3D (uint32_t) val;
> > +
> > +    switch (offset) {
> > +    case REG_GCTL:
> > +        allwinner_a10_ps2_update_irq(s);
> > +        s->regs[idx] &=3D ~FIELD_REG_GCTL_SOFT_RST;
> > +        break;
> > +    case REG_DATA:
> > +        /* ??? This should toggle the TX interrupt line.  */
> > +        /* ??? This means kbd/mouse can block each other.  */
>
> I don't understand this comment. It looks like it was cut-and-pasted
> from another device where it was originally written in 2005 (and
> I don't understand it there either). We should either understand
> what we mean here, or else not have the comment at all...
>
>
Yes, unfortunately I missed this one before sending it out...


> > +        if (s->is_mouse) {
> > +            ps2_write_mouse(PS2_MOUSE_DEVICE(s->ps2dev), val);
> > +        } else {
> > +            ps2_write_keyboard(PS2_KBD_DEVICE(s->ps2dev), val);
> > +        }
> > +        break;
> > +    case REG_LCTL:
> > +    case REG_LSTS:
> > +    case REG_FCTL:
> > +    case REG_FSTS:
> > +    case REG_CLKDR:
> > +        break;
> > +    case 0x1C ... AW_A10_PS2_IOSIZE:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        break;
> > +    }
> > +}
>
> thanks
> -- PMM
>

Thanks!

Best regards,
Strahinja

--000000000000fc72760605767fae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><div><br></div><div>Thank you for your=
 comments.</div><div><br></div><div>I used the PL050 component as a startin=
g point, but I did not clean things up well after I saw it working. I will =
clean it up before sending the new patch version.</div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 15, 2023 at 4:=
23=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org"=
>peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Tue, 5 Sept 2023 at 21:14, Strahinja Jankovic<b=
r>
&lt;<a href=3D"mailto:strahinjapjankovic@gmail.com" target=3D"_blank">strah=
injapjankovic@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add emulation for PS2-0 and PS2-1 for keyboard/mouse.<br>
&gt;<br>
&gt; Signed-off-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.ja=
nkovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&gt;<=
br>
<br>
<br>
<br>
&gt; +static int allwinner_a10_ps2_fctl_is_irq(AwA10PS2State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return (s-&gt;regs[REG_INDEX(REG_FCTL)] &amp; FIELD_REG=
_FCTL_TXRDY_IEN) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;pending &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;regs[REG_INDEX(REG_FCTL)] &a=
mp; FIELD_REG_FCTL_RXRDY_IEN));<br>
<br>
It looks a little odd that you need a separate s-&gt;pending bool here.<br>
Sometimes hardware does odd things, but the most usual situation<br>
is that the pending status of an interrupt is directly reflected<br>
in a register bit somewhere, and &quot;is the interrupt high&quot; logic<br=
>
is then just &quot;is the pending bit set and is the enable bit set&quot;.<=
br>
Often the bit positions are deliberately the same in the two<br>
registers and then &quot;is an interrupt set&quot; is something like<br>
=C2=A0 if (s-&gt;regs[REG_INDEX(REG_FCTL)] &amp; s-&gt;regs[REG_INDEX(REG_F=
STS)] &amp;<br>
=C2=A0 =C2=A0 =C2=A0 (TXRDY_IEN | RXRDY_IEN))<br><br></blockquote><div><br>=
</div><div>Yes, that makes sense. I will try to improve this.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_ps2_update_irq(AwA10PS2State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int level =3D (s-&gt;regs[REG_INDEX(REG_GCTL)] &amp; FI=
ELD_REG_GCTL_INT_EN) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_ps2_fctl_is_irq(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, level);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_ps2_set_irq(void *opaque, int n, int level)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10PS2State *s =3D (AwA10PS2State *)opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pending =3D level;<br>
&gt; +=C2=A0 =C2=A0 allwinner_a10_ps2_update_irq(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t allwinner_a10_ps2_read(void *opaque, hwaddr offset,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsig=
ned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10PS2State *s =3D AW_A10_PS2(opaque);<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_FSTS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t stat =3D FIELD_REG=
_FSTS_TX_RDY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat |=3D FIE=
LD_REG_FSTS_RX_LEVEL1 | FIELD_REG_FSTS_RX_RDY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return stat;<br>
<br>
The logic here also suggests that the code would be simpler if you<br>
keep the TX_RDY and RX_RDY state directly in this register value,<br>
rather than hardcoding TX_RDY to always-set and keeping RX_RDY<br>
in a separate pending field.<br>
<br></blockquote><div><br></div><div>That makes sense, I&#39;ll fix it.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_DATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;last =3D ps2_read_dat=
a(s-&gt;ps2dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;last;<br>
<br>
You could keep the last returned data in s-&gt;regs[REG_IDX(REG_DATA)]<br>
and avoid having to have an extra s-&gt;last field in the state struct.<br>
<br></blockquote><div><br></div><div>Ok.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 case REG_GCTL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (allwinner_a10_ps2_fctl_=
is_irq(s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[id=
x] |=3D FIELD_REG_GCTL_INT_FLAG;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[id=
x] &amp;=3D FIELD_REG_GCTL_INT_FLAG;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_LCTL:<br>
&gt; +=C2=A0 =C2=A0 case REG_LSTS:<br>
&gt; +=C2=A0 =C2=A0 case REG_FCTL:<br>
&gt; +=C2=A0 =C2=A0 case REG_CLKDR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x1C ... AW_A10_PS2_IOSIZE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: unimpl=
emented read offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;regs[idx];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_ps2_write(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsig=
ned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10PS2State *s =3D AW_A10_PS2(opaque);<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[idx] =3D (uint32_t) val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_GCTL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_ps2_update_irq(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[idx] &amp;=3D ~FIELD_REG_GCTL_=
SOFT_RST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_DATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? This should toggle the TX interrup=
t line.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? This means kbd/mouse can block eac=
h other.=C2=A0 */<br>
<br>
I don&#39;t understand this comment. It looks like it was cut-and-pasted<br=
>
from another device where it was originally written in 2005 (and<br>
I don&#39;t understand it there either). We should either understand<br>
what we mean here, or else not have the comment at all...<br>
<br></blockquote><div><br></div><div>Yes, unfortunately I missed this one b=
efore sending it out...</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;is_mouse) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ps2_write_mouse(PS2_MOUSE_D=
EVICE(s-&gt;ps2dev), val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ps2_write_keyboard(PS2_KBD_=
DEVICE(s-&gt;ps2dev), val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_LCTL:<br>
&gt; +=C2=A0 =C2=A0 case REG_LSTS:<br>
&gt; +=C2=A0 =C2=A0 case REG_FCTL:<br>
&gt; +=C2=A0 =C2=A0 case REG_FSTS:<br>
&gt; +=C2=A0 =C2=A0 case REG_CLKDR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x1C ... AW_A10_PS2_IOSIZE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: unimpl=
emented write offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div>Thanks!</div><div><br></div><div=
>Best regards,</div><div>Strahinja</div><div>=C2=A0</div></div></div>

--000000000000fc72760605767fae--

