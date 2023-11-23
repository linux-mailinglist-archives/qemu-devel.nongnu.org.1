Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2709A7F55F3
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 02:35:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ybh-0003ZN-Os; Wed, 22 Nov 2023 20:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5ybe-0003XK-QO; Wed, 22 Nov 2023 20:34:15 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5yba-0002p8-Ln; Wed, 22 Nov 2023 20:34:12 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cf6a67e290so2926305ad.1; 
 Wed, 22 Nov 2023 17:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700703248; x=1701308048; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mazXQhpz60HmEQRRDvrIA5mFjPimOVxTseqcALLXmI=;
 b=EcA+sDqwhufdQIo8tss+ZkusQLbrZQTfSNh6CDNqymBzYaFv1iMKFwSINRtibBDTJd
 qCIsSqEOu6ZZsxEf7q9I2hOI/cLhTWJ7+I/d4JXvuAcHkGHRYWw7elo5ezZXlUMlLFTy
 PXQqH6D3l37JjYodL26Zs4JAPO2KdBRk6bdjWPxbgtO/rJ6Euyfku7gJAgpW1xcX7mLQ
 r+13T26Q6U1UHl1eCz5tWdYR9r+MeUGfrA+92DwXzlNjU4gXq3jl64bLezBcYkiLjKW9
 68DUMDGZd05pc7/Gg/yLCdkVt8Ch2TyU/wGHBR0gAg9ngOyHhD/2Pzq0dIBPSRoX8RH0
 XXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700703248; x=1701308048;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8mazXQhpz60HmEQRRDvrIA5mFjPimOVxTseqcALLXmI=;
 b=fpJsxzKFs1NzXGEVa7HVLjTt40ozUwIf3LQDrpBOl07aQtMdZvT8/Nxf6YcVhkiZD6
 bK4o+RLRibAX+TFZZdiNfdrQu+HrstGkEiDQtjlG9Aur+KghKSiOKqFx8SZyFFxiT9p9
 siibDECFeYui6Vj2ccAfnwe/0YFm/MOjQWI4W3qImcP7ndjZmtC4NsFcJUiDb9Qwc/Zf
 4yLUY+mE0QyMP3ORYD1j6oP3IR95rTXQLs/xMhEwbHXXAiziUDHzlk9kD53BVE9IuaQf
 9YNeBReGf4uPj/MxKRAsy/NOKB4vhBoJYQNExhRhxkqB2UJWN9zozEaiQmDPz1xeK1Cx
 ZECQ==
X-Gm-Message-State: AOJu0YwXOGtaNzLBO0cU+5qV0e8getP9dfRKwhUm6GUG5TDkhk6LKGZl
 tMvjAopjbVB6WXDa/sY4bG4=
X-Google-Smtp-Source: AGHT+IGc+m0Dx0poBeXVy3avTBJY7tIVlJOLwvck69nnP4mfArdozJzKR1zd4rpe5faJkl/HKHgnHg==
X-Received: by 2002:a17:902:e88a:b0:1bf:c59:c944 with SMTP id
 w10-20020a170902e88a00b001bf0c59c944mr4619213plg.22.1700703248340; 
 Wed, 22 Nov 2023 17:34:08 -0800 (PST)
Received: from localhost (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902bc4b00b001c72d5e16acsm69441plz.57.2023.11.22.17.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 17:34:07 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Nov 2023 11:34:02 +1000
Message-Id: <CX5SZFIFSWF1.1INPRPCI76NFA@wheely>
Cc: <qemu-ppc@nongnu.org>, <groug@kaod.org>, <danielhb413@gmail.com>,
 <clg@kaod.org>, <david@gibson.dropbear.id.au>, <saif.abrar@in.ibm.com>
Subject: Re: [PATCH] target/ppc: Update gdbstub to read SPR's CFAR, DEC,
 HDEC, TB-L/U
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Saif Abrar" <saif.abrar@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230918092616.15398-1-saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <20230918092616.15398-1-saif.abrar@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Sep 18, 2023 at 7:26 PM AEST, Saif Abrar wrote:
> SPR's CFAR, DEC, HDEC, TB-L/U are not implemented as part of CPUPPCState.
> Hence, gdbstub is not able to access them using (CPUPPCState *)env->spr[]=
 array.
> Update gdb_get_spr_reg() method to handle these SPR's specifically.
>
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Thanks for this, I have been annoyed by missing those regs when using
gdb at times :)


> ---
>  target/ppc/gdbstub.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 2ad11510bf..eb086c0168 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -412,7 +412,32 @@ static int gdb_get_spr_reg(CPUPPCState *env, GByteAr=
ray *buf, int n)
>      }
> =20
>      len =3D TARGET_LONG_SIZE;
> -    gdb_get_regl(buf, env->spr[reg]);
> +
> +    /* Handle those SPRs that are not part of the env->spr[] array */
> +    target_ulong val;

Could you move this to the of the block with other declarations?

> +    switch (reg) {
> +#if defined(TARGET_PPC64)
> +    case SPR_CFAR:
> +        val =3D env->cfar;
> +        break;
> +#endif
> +    case SPR_HDEC:
> +        val =3D cpu_ppc_load_hdecr(env);
> +        break;
> +    case SPR_TBL:
> +        val =3D cpu_ppc_load_tbl(env);
> +        break;
> +    case SPR_TBU:
> +        val =3D cpu_ppc_load_tbu(env);
> +        break;
> +    case SPR_DECR:
> +        val =3D cpu_ppc_load_decr(env);
> +        break;
> +    default:
> +        val =3D env->spr[reg];
> +    }
> +    gdb_get_regl(buf, val);
> +
>      ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
>      return len;
>  }
> @@ -429,7 +454,18 @@ static int gdb_set_spr_reg(CPUPPCState *env, uint8_t=
 *mem_buf, int n)
> =20
>      len =3D TARGET_LONG_SIZE;
>      ppc_maybe_bswap_register(env, mem_buf, len);
> -    env->spr[reg] =3D ldn_p(mem_buf, len);
> +
> +    /* Handle those SPRs that are not part of the env->spr[] array */
> +    target_ulong val =3D ldn_p(mem_buf, len);
> +    switch (reg) {
> +#if defined(TARGET_PPC64)
> +    case SPR_CFAR:
> +        env->cfar =3D val;
> +        break;
> +#endif

I suppose we could store some time regs here too. (h)decr I have found
useful to change at times to interrupts when debugging Linux timer code.
TB could be similar.

We have a bit of weirdness with our timebase registers though, I'm going
to send out some patches for them. Maybe hold off changing this until
we agree on those.

I'll take this for next release, sorry didn't get to it earlier.

Thanks,
Nick

> +    default:
> +        env->spr[reg] =3D val;
> +    }
> =20
>      return len;
>  }


