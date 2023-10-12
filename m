Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B107C7151
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxVH-0007r8-6c; Thu, 12 Oct 2023 11:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqxVE-0007pj-MW
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:21:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqxVC-0005NG-Ey
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:21:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4066692ad35so11713405e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697124088; x=1697728888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjyR2skxoLerWvOjTc12Q9nZxZqacnFBKZXqQ66nw+M=;
 b=WVTaNSx6+hId7+4170xTQh5nEF+x5MnTQmBdCqZyMSS+7WbYdLaj/nYvX8n3vtsxeZ
 cHCMLe1ECipueVXyE8HCvUIuTJYdZHlfhRtPv0QjQeTiMzoZh4alYTt8WYKPcK9o3IbV
 xbSZqM5gGvT6aYHenj3JcT50KySpV2G8hOdo1ulcHqR80+OBIOzcgpK663Nd5oNwLQi5
 QdR9MSULA2Neo90edcHi+5pVoNb7xt6UKUmzlVi5+beI1OqA8hmvbrgbEr2xFiKHt3e/
 EXjaT5tVJTJfArQA7wz/HqKRIG3UHQMpHa8xONb3HlrSnJirjwv7tUhjY5hQhYS3aHUM
 3duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124088; x=1697728888;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FjyR2skxoLerWvOjTc12Q9nZxZqacnFBKZXqQ66nw+M=;
 b=UuxuJLFnBpXZIpmX8XBGSx84514hcVpVj3MkhoFhuRJ1blfIRCuqWSXTw2lmBd5Lg2
 ggzJ4L28jlI/EgkgX70f7s9tNBE8AThGvHE1C+KnZoI/KXF49LfDO9RsE2KI5xNdCYYy
 q6wH6necW7132U70T7daEIs4Du+sN5dM7Aco+gsE+5hk9RwHA4IrI7Lfuatt/iPjJVup
 MPw/h1zky0J8nzP2EHF59LbX90fl27sDFtySVbaOOpzOYPUYv7dq1xNJyWnEDbB+epcz
 xfu6MaQVJhvUsuAJHEfIXuRbq1HcZOK21x0uznNoNX2lquRYSH/ZQh8IiZaQRRx18l2k
 RRKg==
X-Gm-Message-State: AOJu0YzK7COWUtC0VY1M/F2WT0AVlBg6pyB3EBwg6PoPcj1cfgw4PI7l
 Uw8X0VVTIGYYFOcVm1nIYyo0qg==
X-Google-Smtp-Source: AGHT+IHTSWZIb/L9POGjVQ85Ln07vf2F4+yXqijddhNR/S9RzDCBY8AlIz5Vt6Iix1AHu13V4XvGfA==
X-Received: by 2002:a05:600c:3652:b0:3fe:d1b9:7ea9 with SMTP id
 y18-20020a05600c365200b003fed1b97ea9mr20793677wmq.36.1697124088428; 
 Thu, 12 Oct 2023 08:21:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a7bc388000000b0040684abb623sm104631wmj.24.2023.10.12.08.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 08:21:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 82C561FFBB;
 Thu, 12 Oct 2023 16:21:27 +0100 (BST)
References: <20231012085710.880440-1-mironov@fintech.ru>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sergey Mironov <mironov@fintech.ru>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] target/arm: Adding a check for the result of
 calling the CPU information check function
Date: Thu, 12 Oct 2023 16:16:11 +0100
In-reply-to: <20231012085710.880440-1-mironov@fintech.ru>
Message-ID: <87pm1jn9xk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Sergey Mironov <mironov@fintech.ru> writes:

> 6 out of 7 calls to get_arm_cp_reginfo() are checked

Yes but we should be careful with asserts (vs if (ri) legs) because I
don't think get_arm_cp_reginfo() guarantees it will always be
successful.

>
> Signed-off-by: Sergey Mironov <mironov@fintech.ru>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 74fbb6e1d7..cffbbaf571 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -198,6 +198,7 @@ static void add_cpreg_to_list(gpointer key, gpointer =
opaque)
>      uint32_t regidx =3D (uintptr_t)key;
>      const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(cpu->cp_regs, regidx);
>=20=20
> +    assert(ri !=3D NULL);

  /* must always succeed as we are iterating the keys of cp_regs */
  assert(ri);

is enough for a !NULL check.

>      if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
>          cpu->cpreg_indexes[cpu->cpreg_array_len] =3D cpreg_to_kvm_id(reg=
idx);
>          /* The value array need not be initialized at this point */

That said we already have an assert that would fire in
init_cpregs_list():

  assert(cpu->cpreg_array_len =3D=3D arraylen);

so I'm not sure what this is adding to ensuring the contract is kept.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

