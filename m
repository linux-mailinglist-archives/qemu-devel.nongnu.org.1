Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B782B21A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxJ8-0006w0-Ow; Thu, 11 Jan 2024 10:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNxJ6-0006vG-Im
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:49:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNxJ4-00011T-D5
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:49:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e6297a00fso2921405e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704988161; x=1705592961;
 darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gP4MkUJtg2f9z1dhqhkGk/2ZfyqPfjZZ7ETx+Klpo0g=;
 b=HzZXwlCI3Y18zw/CjNqTOjVUzmDNbUe2oz25KtEwg0FCrcHWrVleGHaFVKmbqa7I4H
 TOQ/an7RBprDH7JU9i+xVxmPXs/lVKYfS16emWcVJ0AzM+5+/zdlgOnf1FOFja3UNutF
 RjxXGPncTBMBsPX+sTudF86zqMrHcTKFpJRWEeZtPXWWH1eAgoO+bdlIHrgrneBZkHyG
 gGGImY45s5BZgpRvhw8/uTAu7t0v0+eT7ZDmNgEXJwkkq51jhduJGvSWvvUajsFtD+FL
 2SnD1dYe8zN97+DIBAgehpsBTpTfX6DFO/ENeiMiUM8W/2jg0dOwikTzflOC0wwdj0L+
 78XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704988161; x=1705592961;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gP4MkUJtg2f9z1dhqhkGk/2ZfyqPfjZZ7ETx+Klpo0g=;
 b=JTbf0X9UgvzosKrrbWM3MrqUET0aYJiNaohZr5EggMpQ3cOsHNZ23dMyTGdwt94qzg
 w8RrVvGJYwguEJJQwdlEqtTTga0tnaZh822jEiX8Uf53XXkNN2rZqttv8iEV2GHZpPck
 BMDwuk38vNjtCGtN6O9hkeBhP4WCgh1ey5ty6dBIz/kMk3GYjtqOd3WgyaaQOaz++aW9
 KPGDm9cq4/ywhGsU5RufppuZ77Nqvx8Hl1SYOQEXuneJStjZSO5xK3Z7GHlnYKTtaO3j
 UNnY5pOjTCOmwKuEMD2Fgy5qVHQYm5sSoQY/hNj9+v+Lcn48o7tx2AzRC2t3QK2OGQvh
 IIYQ==
X-Gm-Message-State: AOJu0Yz4+E2Z4J7QWiVNI7YjgcUbBCXEKEIHCvvO3/DwoWaC7E6AEY4+
 vviXL9/+wvqT4ZZAVBfzlqdvQxj+Hifs0A==
X-Google-Smtp-Source: AGHT+IFnjEVkAPDubIzNjSvxUMzPM9gc7UxsgtBc5k7shxzEscPWOC9gvF1uSwxpHCgWCqcBDMixLg==
X-Received: by 2002:a05:600c:1508:b0:40e:43cf:bbe2 with SMTP id
 b8-20020a05600c150800b0040e43cfbbe2mr7214wmg.175.1704988160683; 
 Thu, 11 Jan 2024 07:49:20 -0800 (PST)
Received: from [192.168.1.9] (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a05600c470400b0040e45799541sm6240022wmo.15.2024.01.11.07.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:49:20 -0800 (PST)
Message-ID: <a2a3daf031cef657c62b7ea627d8866fa1742dbb.camel@rivosinc.com>
Subject: Re: [PATCH 3/3] target/riscv: Enable 'B' extension on max CPU type
From: Rob Bradford <rbradford@rivosinc.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Date: Thu, 11 Jan 2024 15:49:19 +0000
In-Reply-To: <ee62a091-5f44-4a25-a724-06393af41807@ventanamicro.com>
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-4-rbradford@rivosinc.com>
 <de442ad9-0479-4a7e-bccf-97fcd081a35e@ventanamicro.com>
 <20240111-558c99b8f3be4297e9ae4118@orel>
 <ee62a091-5f44-4a25-a724-06393af41807@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 2024-01-11 at 11:53 -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 1/11/24 10:02, Andrew Jones wrote:
> > On Wed, Jan 10, 2024 at 03:32:21PM -0300, Daniel Henrique Barboza
> > wrote:
> > >=20
> > >=20
> > > On 1/9/24 14:07, Rob Bradford wrote:
> > > > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > > > ---
> > > > =C2=A0=C2=A0 target/riscv/tcg/tcg-cpu.c | 3 ++-
> > > > =C2=A0=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-
> > > > cpu.c
> > > > index f10871d352..9705daec93 100644
> > > > --- a/target/riscv/tcg/tcg-cpu.c
> > > > +++ b/target/riscv/tcg/tcg-cpu.c
> > > > @@ -999,7 +999,8 @@ static void
> > > > riscv_init_max_cpu_extensions(Object *obj)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const RISCVCPUMultiExtConfig *=
prop;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable RVG, RVJ and RVV tha=
t are disabled by default
> > > > */
> > > > -=C2=A0=C2=A0=C2=A0 riscv_cpu_set_misa(env, env->misa_mxl, env->mis=
a_ext | RVG
> > > > | RVJ | RVV);
> > > > +=C2=A0=C2=A0=C2=A0 riscv_cpu_set_misa(env, env->misa_mxl,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->mis=
a_ext | RVG | RVJ | RVV | RVB);
> > >=20
> > > I'm aware that we decided a while ago the 'max' CPU could only
> > > have non-vendor and
> > > non-experimental extensions enabled. RVB is experimental, so in
> > > theory we shouldn't
> > > enable it.
> > >=20
> > > But RVB is an alias for zba, zbb and zbs, extensions that the
> > > 'max' CPU is already
> > > enabling. In this case I think it's sensible to enable RVB here
> > > since it would
> > > just=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
> > > reflect stuff that it's already happening.
> >=20
> > It's also setting the B bit in misa, which, until this spec is at
> > least
> > frozen, is a reserved bit and reserved bits "must return zero when
> > read".
>=20
> This is a side effect that I wasn't aware of.
>=20
> Rob, given that the 'max' CPU already has the zb* extensions enabled,
> is there any
> other gain in enabling RVB in this CPU? If there isn't I'd rather
> leave this one
> out for now.
>=20

It seems completely reasonable to me to drop it for now.

Thanks for all the feedback,

Rob

>=20
> Thanks,
>=20
> Daniel
>=20
>=20
> >=20
> > I don't want to stand in the way of progress and it seems 99.9%
> > likely
> > that the spec will be frozen and ratified, but, if we want to stick
> > to
> > our policies (which we should document), then even the 'max' cpu
> > type
> > should require x-b be added to the command line if it wants the B
> > bit
> > set in misa.
> >=20
> > Thanks,
> > drew


