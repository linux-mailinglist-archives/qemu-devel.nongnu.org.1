Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39779745BF3
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGIRP-000770-MA; Mon, 03 Jul 2023 08:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGIRN-00075W-Fg
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 08:14:01 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGIRL-0006Zi-Oq
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 08:14:01 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fafe87c6fbso6703628e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 05:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688386437; x=1690978437;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEF0pXW9h7RriHVGFv76VvrK8N8NcW237ZKM0zwhNvE=;
 b=wCvZirptVjGesegbPb68SCjjRL7+MwZ/a2jQ3LeMgVpztEm3SP+4r+EI9v6o9yd+aU
 yHgu1hJ4AcE9LW6Tr8++hFswvbloyPh4+DaupaCaBQLpZJjE08pHxOmF7eZ+YDtrNZbu
 J5XXVl0ikdRQWBRbNw0ud8j9KTvozv3f7/0VL8LV67HUObgjbOBP8XjuP3wW6Pqq90LQ
 YIQjOyHyGbxaJ78QpIbp5Gd55y4+r2ORuWsOIRRnTx0utNvlOeFRoR9//bNdf0xZKDXx
 oj7LV6P6SjT+bHHje3AwgWHB/1t8QxJsAyL78kQIpPJ6WnFDbUJ4fpaYoBItWCQtMQ7T
 X9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688386437; x=1690978437;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PEF0pXW9h7RriHVGFv76VvrK8N8NcW237ZKM0zwhNvE=;
 b=SkVQrRbBkVv3agqWcfNro/9p5fp3gprv5geeqUvaukBJZv6L7+C2ctZaXLdU4bS391
 604UlgdnzL824drpDqjXdtiMIf+5A0i2XhPDDFjhrHi57gN+qh9giBfQKlHahoCJQ4En
 A+R3avYrG4/9nm1tPsJGcHPkHVTmAYzzyTE9FDyROAvePMaElQvvXyc8E9jo+t98kuSs
 GY2+Fv8cUBVcLpplLK9C55sHVvZJsfASBvc1vtDrf32LP4zHU+/j5KhS5aZKKDh6rCfT
 ICF/3z6ypfw8iaE8TWrVDnygFMtWQYSjnd2pMR5ZUGxcmK0hyhhnJ1sKnFdRryntte8E
 YS3w==
X-Gm-Message-State: ABy/qLZh9pw0PBY8afZnvi7dbUpAXLLq+eLThFIA2PP0TvCUWWJBmvl3
 4fCRkoqC+k4L/jwmkaJmMcodvg==
X-Google-Smtp-Source: APBJJlGA5oH5JVGTj8TGGcdNBE5smoJ3wLlPdw4mEG1IwSdODN/Lihtf5XfKisFQIhOwZwOSVVpbzQ==
X-Received: by 2002:a05:6512:2815:b0:4fb:893e:8ffc with SMTP id
 cf21-20020a056512281500b004fb893e8ffcmr7981720lfb.17.1688386437172; 
 Mon, 03 Jul 2023 05:13:57 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a5d460e000000b0031433760a92sm3843950wrq.115.2023.07.03.05.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 05:13:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5AEDA1FFBB;
 Mon,  3 Jul 2023 13:13:56 +0100 (BST)
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-10-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC v3 09/10] target/arm: Add support for native library calls
Date: Mon, 03 Jul 2023 13:13:17 +0100
In-reply-to: <20230625212707.1078951-10-fufuyqqqqqq@gmail.com>
Message-ID: <87cz19i457.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> Upon encountering specialized instructions reserved for native calls,
> store the function id and argument types, then invoke helper.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  target/arm/tcg/translate-a64.c | 27 ++++++++++++++++++++++++++-
>  target/arm/tcg/translate.c     | 25 +++++++++++++++++++++++--
>  target/arm/tcg/translate.h     |  6 ++++++
>  3 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 741a608739..24a664b928 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
<snip>
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -34,7 +34,7 @@
>  #include "exec/helper-gen.h"
>  #include "exec/log.h"
>  #include "cpregs.h"
> -
> +#include "native/native-defs.h"
>=20=20
>  #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
>  #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
> @@ -58,6 +58,7 @@ TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
>  TCGv_i64 cpu_exclusive_addr;
>  TCGv_i64 cpu_exclusive_val;
>=20=20
> +

stray whitespace which will often make re-basing patches a pain.

>  #include "exec/gen-icount.h"
>=20=20
>  static const char * const regnames[] =3D
> @@ -1147,12 +1148,32 @@ static inline void gen_hlt(DisasContext *s, int i=
mm)
>       * semihosting, to provide some semblance of security
>       * (and for consistency with our 32-bit semihosting).
>       */
> +    if (native_call_enabled() && (!s->native_call_status)) {
> +        s->native_call_status =3D true;
> +        s->native_call_id =3D imm;
> +        return;
> +    } else if (native_call_enabled() && (s->native_call_status)) {
> +        TCGv_i32 arg1 =3D load_reg(s, 0);
> +        TCGv_i32 arg2 =3D load_reg(s, 1);
> +        TCGv_i32 arg3 =3D load_reg(s, 2);
> +
> +        TCGv_i32 abi_map =3D tcg_constant_i32(imm);
> +        TCGv_i32 func_id =3D tcg_constant_i32(s->native_call_id);
> +        TCGv_i32 res =3D tcg_temp_new_i32();
> +        TCGv_i32 mmu_idx =3D tcg_constant_i32(MMU_USER_IDX);
> +        gen_helper_native_call_i32(res, cpu_env, arg1, arg2, arg3,
> +                                    abi_map, func_id, mmu_idx);
> +
> +        store_reg(s, 0, res);
> +        s->native_call_status =3D false;
> +        s->native_call_id =3D 0;
> +        return;
> +    }
>      if (semihosting_enabled(s->current_el =3D=3D 0) &&
>          (imm =3D=3D (s->thumb ? 0x3c : 0xf000))) {
>          gen_exception_internal_insn(s, EXCP_SEMIHOST);
>          return;
>      }
> -

also here.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

