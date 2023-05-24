Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA670EB08
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 03:52:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1dfB-0004vn-4H; Tue, 23 May 2023 21:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1df6-0004th-G6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 21:51:37 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1df4-0001ib-Hz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 21:51:36 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4361225a745so123019137.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 18:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684893093; x=1687485093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PaT5JBWKLiVkSD4dl1jsmJZf0hxmIMjtdz0wDNpT38Q=;
 b=LSoIHsqff1E+HeVJZUXtuYckCNv+8CtT1s+YeTNAIIhxuOB2tp6sdmf9wniFDe1/e6
 1GNvg3U0i+3vyajIXJ5qZEsd/lTzTiWfi+96+xR6HHZrHL7ND/ADuIogryvhCxn1QfQ/
 +XkgeBQP1YYkZJfaweqYv90/rVZvzZv96xwNpPSMFF4KStjex1JwazTerBw8Qx5vk84+
 fIkQeZfdQDmuOX3paLx3GpL5Mwcqm3r12WXjMpwI6jdxFBooPtywf4JX9J7UNsk14f4V
 eruFxdtjshKZyq4r4sQCICf6wbk+FWkzn+8fnkDKuN7GdKqZKViE1+NF6uL+yHyjV9zk
 HZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684893093; x=1687485093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PaT5JBWKLiVkSD4dl1jsmJZf0hxmIMjtdz0wDNpT38Q=;
 b=hXKGEZ7luF0glL7lCQ1CvQ7Zi3Wmq/vYNP0jCxO6XER0POuilrgNk6+xCSaX3dnUze
 2lQzwHoepn3R1DC5KC7kMwTF8Ie8qII1nKVdDuaJttf4GGxsmKofS+dyDyprKNL43eml
 xnCz1FCZroGnA0FhEnk/cCR4OotCJhERtOc3mXkO80N3WBUmTB8ED0l461SaMYJkqVZm
 vqmlIJbRuZ0FvCmEg6Fw0nyQrACu1tfgaEQUF5Jf2fFLy8uAzAjB+zRdv7CKLQqeDJzA
 E1I3DLlGAx/cEfEE41JYMgnOSePRmcj3Fr1D0JZLtZtSjdcKM2aJ+L1wPd3kWzL8fSbm
 D+pQ==
X-Gm-Message-State: AC+VfDxsT3NMi6SiJlRIce4SKaIsUlXyu8nfqgYa7QeFl4pmklbvdCxd
 9mEvyINpaIXK21WrmQt/kMOup0ZrQCAJ+Oy+orMe4g==
X-Google-Smtp-Source: ACHHUZ7FmxnwhLv2FouxR7P6/mQWDFLonRvc5FnYrX5S77JnYQ2RAabDX7mefrB9YGePEzsng8iUAIn7x1tMefZU4m8=
X-Received: by 2002:a67:cf48:0:b0:42f:f915:8cd with SMTP id
 f8-20020a67cf48000000b0042ff91508cdmr4014967vsm.5.1684893092960; Tue, 23 May
 2023 18:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230523114454.717708-1-tommy.wu@sifive.com>
 <20230523114454.717708-3-tommy.wu@sifive.com>
 <a1c36ae3-7875-0178-fcca-33abed1816f2@iscas.ac.cn>
In-Reply-To: <a1c36ae3-7875-0178-fcca-33abed1816f2@iscas.ac.cn>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Wed, 24 May 2023 09:51:22 +0800
Message-ID: <CANj3q_nn5puBEdfzCgwUtT9bkhUUzopf-2qa0xC7LcRs_i_uhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc: riscv_imsic: Refresh the CSRs xml after
 updating the state of the cpu.
To: Weiwei Li <liweiwei@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 alistair.francis@wdc.com, apatel@ventanamicro.com, palmer@rivosinc.com, 
 dbarboza@ventanamicro.com, bin.meng@windriver.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: multipart/alternative; boundary="0000000000004a716705fc66bec3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=tommy.wu@sifive.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000004a716705fc66bec3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Weiwei Li,
Yes, you're right,  `riscv_refresh_dynamic_csr_xml()`  can only be called
when
cpu->dyn_csr_xml isn't a NULL pointer here.

The cpu->dyn_csr_xml will be set when the cpu is realized.

Best Regards,
Tommy


On Tue, May 23, 2023 at 10:44=E2=80=AFPM Weiwei Li <liweiwei@iscas.ac.cn> w=
rote:

>
> On 2023/5/23 19:44, Tommy Wu wrote:
> > Originally, when we set the ext_smaia to true, we still cannot print th=
e
> > AIA CSRs in the remote gdb debugger, because the dynamic CSR xml is
> > generated when the cpu is realized.
> >
> > This patch refreshes the dynamic CSR xml after we update the ext_smaia,
> > so that we can print the AIA CSRs in the remote gdb debugger.
> >
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >   hw/intc/riscv_imsic.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> > index fea3385b51..97a51d535b 100644
> > --- a/hw/intc/riscv_imsic.c
> > +++ b/hw/intc/riscv_imsic.c
> > @@ -350,6 +350,10 @@ static void riscv_imsic_realize(DeviceState *dev,
> Error **errp)
> >           } else {
> >               rcpu->cfg.ext_smaia =3D true;
> >           }
> > +
> > +        /* Refresh the dynamic csr xml for the gdbstub. */
> > +        riscv_refresh_dynamic_csr_xml(cpu);
> > +
>
> There is an assert in riscv_refresh_dynamic_csr_xml():
>
> +    if (!cpu->dyn_csr_xml) {
> +        g_assert_not_reached();
> +    }
>
> So I think riscv_refresh_dynamic_csr_xml() can only be called when
> cpu->dyn_csr_xml is true here.
>
> Regards,
>
> Weiwei Li
>
> >           riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M :
> PRV_S,
> >                                         riscv_imsic_rmw, imsic);
> >       }
>
>

--0000000000004a716705fc66bec3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Weiwei Li,<br>Yes, you&#39;re right,=C2=A0 `riscv_refre=
sh_dynamic_csr_xml()`=C2=A0 can only be called when<br>cpu-&gt;dyn_csr_xml =
isn&#39;t a NULL pointer here.<div><br></div><div>The cpu-&gt;dyn_csr_xml w=
ill be set when the cpu is realized.</div><div><br></div><div>Best=C2=A0Reg=
ards,</div><div>Tommy</div><div><br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 23, 2023 at 10:44=E2=
=80=AFPM Weiwei Li &lt;<a href=3D"mailto:liweiwei@iscas.ac.cn">liweiwei@isc=
as.ac.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>
On 2023/5/23 19:44, Tommy Wu wrote:<br>
&gt; Originally, when we set the ext_smaia to true, we still cannot print t=
he<br>
&gt; AIA CSRs in the remote gdb debugger, because the dynamic CSR xml is<br=
>
&gt; generated when the cpu is realized.<br>
&gt;<br>
&gt; This patch refreshes the dynamic CSR xml after we update the ext_smaia=
,<br>
&gt; so that we can print the AIA CSRs in the remote gdb debugger.<br>
&gt;<br>
&gt; Signed-off-by: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" tar=
get=3D"_blank">tommy.wu@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/intc/riscv_imsic.c | 4 ++++<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c<br>
&gt; index fea3385b51..97a51d535b 100644<br>
&gt; --- a/hw/intc/riscv_imsic.c<br>
&gt; +++ b/hw/intc/riscv_imsic.c<br>
&gt; @@ -350,6 +350,10 @@ static void riscv_imsic_realize(DeviceState *dev,=
 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcpu-&gt;cfg.ext=
_smaia =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Refresh the dynamic csr xml for the gd=
bstub. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_refresh_dynamic_csr_xml(cpu);<br>
&gt; +<br>
<br>
There is an assert in riscv_refresh_dynamic_csr_xml():<br>
<br>
+=C2=A0 =C2=A0 if (!cpu-&gt;dyn_csr_xml) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br>
<br>
So I think riscv_refresh_dynamic_csr_xml() can only be called when <br>
cpu-&gt;dyn_csr_xml is true here.<br>
<br>
Regards,<br>
<br>
Weiwei Li<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_cpu_set_aia_ireg_rmw_fn(=
env, (imsic-&gt;mmode) ? PRV_M : PRV_S,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0riscv_imsic_rmw, imsic);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--0000000000004a716705fc66bec3--

