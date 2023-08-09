Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F897765D9
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmXH-0004cs-Ae; Wed, 09 Aug 2023 12:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmXE-0004c7-R6
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:59:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmXC-00048P-N0
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:59:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so59702865e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691600385; x=1692205185;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9ebYCN41wBfKyeFxl6H5zJHFCzPWRp12K+L6+19DXc=;
 b=WrFaflDzsyPCFaTuA63xAKYN5MzTLLrNvUqtvXtgpa4iqItA7TBNsMzQ1qXA3KNwle
 x9w8U+Xnt745m3XyWkm72L6tGSUOQKTnXN/iXV/EpL6edakSJ3GhsFm1e0qnXh7CKyf/
 IQFp65oVi5ukleNisEyTZJ/Njf8jSPWw19J0PRRyXdhjni+GCOYHkfk3IwBr1Xo5A4fT
 +Dncb+r8VDlqsAAcpgQtF2S+OADjEMKzTnIkaxx8m8RXdgQ0Cs36JnKzdq+NMbta2G+o
 SvUztQ7JflOijUYXcyquPHlhGcB9qNS6dDzwU9Iqw4n0eUh+BUVCueIz3jrcxPlUoAwO
 EwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691600385; x=1692205185;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H9ebYCN41wBfKyeFxl6H5zJHFCzPWRp12K+L6+19DXc=;
 b=QTxrB6+BXLeF+5pvMA4upeAMqUSqcMYfM8qU+0Kctn71DUd6+VxynyFF83V9VWV5KI
 A4oShzBrk87V6mfpgT3inf8ODjxu5QMRrioSOTr7y0UwAA5ogeCA8N3cM811oEJy4S+1
 cQ24nolFAg8ZwEkZq9TYuPKD11DGPU/LqTpCbqYgBHuLyitNvSqfWQpcbAy7f8NFIKbX
 LRPd1eIL854Ldz3RE3tXpSLfNhMgYCoCoYxDuV0W2pMJR5N5qGTrd+5Xz7Ni2uaC4593
 4OZWlpRf5gRKTjsnOqohPBkb0RnHxHAMj5bvD8gAQr6gwrfiE9xQo9d5ui0LvJiIECfT
 ogSA==
X-Gm-Message-State: AOJu0Yw3EGkkvPy60QAWJdQphVSl29twPsuP8x48FlNCun9WActn0/uy
 KE9GcghuMMXZpJCu/yaWnrT4nw==
X-Google-Smtp-Source: AGHT+IEQ26Rr21aIzrxGr17D0ZpOI6A11AhjEUxIiY6+OQHhYZbNg3ckNqRwjbeEu8t8vni/F8/BWA==
X-Received: by 2002:a05:600c:2811:b0:3fe:2079:196c with SMTP id
 m17-20020a05600c281100b003fe2079196cmr2531244wmb.16.1691600384728; 
 Wed, 09 Aug 2023 09:59:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fbc9b9699dsm2470657wml.45.2023.08.09.09.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 09:59:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB4091FFBB;
 Wed,  9 Aug 2023 17:59:43 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-7-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC v4 06/11] tcg: Add tcg opcodes and helpers for native
 library calls
Date: Wed, 09 Aug 2023 17:41:57 +0100
In-reply-to: <20230808141739.3110740-7-fufuyqqqqqq@gmail.com>
Message-ID: <87cyzw40e8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> This commit implements tcg opcodes and helpers for extracting and
> invoke native functions.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  accel/tcg/tcg-runtime.h     |  22 ++++++
>  include/tcg/tcg-op-common.h |  11 +++
>  include/tcg/tcg.h           |   9 +++
>  tcg/tcg-op.c                | 140 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 182 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 39e68007f9..bda78b4489 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -37,6 +37,28 @@ DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noretu=
rn, env)
>   */
>  #define helper_memset memset
>  DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
> +
> +#define helper_memcpy memcpy
> +DEF_HELPER_FLAGS_3(memcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
> +
> +#define helper_strncpy strncpy
> +DEF_HELPER_FLAGS_3(strncpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
> +
> +#define helper_memcmp memcmp
> +DEF_HELPER_FLAGS_3(memcmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
> +
> +#define helper_strncmp strncmp
> +DEF_HELPER_FLAGS_3(strncmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
> +
> +#define helper_strcpy strcpy
> +DEF_HELPER_FLAGS_2(strcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr)
> +
> +#define helper_strcat strcat
> +DEF_HELPER_FLAGS_2(strcat, TCG_CALL_NO_RWG, ptr, ptr, ptr)
> +
> +#define helper_strcmp strcmp
> +DEF_HELPER_FLAGS_2(strcmp, TCG_CALL_NO_RWG, int, ptr, ptr)
> +
>  #endif /* IN_HELPER_PROTO */
>=20=20
>  DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index be382bbf77..2e712f1573 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -903,6 +903,12 @@ void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGAr=
g offset);
>  void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
>  void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t=
);
>=20=20
> +/* Host <-> guest conversions */
> +void tcg_gen_g2h_i32(TCGv_ptr ret, TCGv_i32 arg);
> +void tcg_gen_g2h_i64(TCGv_ptr ret, TCGv_i64 arg);
> +void tcg_gen_h2g_i32(TCGv_i32 ret, TCGv_ptr arg);
> +void tcg_gen_h2g_i64(TCGv_i64 ret, TCGv_ptr arg);
> +
>  /* Host pointer ops */
>=20=20
>  #if UINTPTR_MAX =3D=3D UINT32_MAX
> @@ -938,6 +944,11 @@ static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv=
_ptr a, intptr_t b)
>      glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
>  }
>=20=20
> +static inline void tcg_gen_subi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
> +{
> +    glue(tcg_gen_subi_, PTR)((NAT)r, (NAT)a, b);
> +}
> +
>  static inline void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
>  {
>      glue(tcg_gen_mov_,PTR)((NAT)d, (NAT)s);
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 0875971719..7c7fafb1cd 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -35,6 +35,9 @@
>  #include "tcg-target.h"
>  #include "tcg/tcg-cond.h"
>  #include "tcg/debug-assert.h"
> +#ifdef CONFIG_USER_ONLY
> +#include "exec/user/guest-base.h"
> +#endif
>=20=20
>  /* XXX: make safe guess about sizes */
>  #define MAX_OP_PER_INSTR 266
> @@ -1148,4 +1151,10 @@ static inline const TCGOpcode *tcg_swap_vecop_list=
(const TCGOpcode *n)
>=20=20
>  bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
>=20=20
> +/* native call */
> +void gen_native_call_i32(const char *fun_name, TCGv_i32 ret,
> +                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3);
> +void gen_native_call_i64(const char *fun_name, TCGv_i64 ret,
> +                         TCGv_i64 arg1, TCGv_i64 arg2, TCGv_i64 arg3);
> +
>  #endif /* TCG_H */
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 7aadb37756..83e3a5682c 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2852,3 +2852,143 @@ void tcg_gen_lookup_and_goto_ptr(void)
>      tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
>      tcg_temp_free_ptr(ptr);
>  }
> +
> +#ifdef CONFIG_USER_ONLY
> +void tcg_gen_g2h_i32(TCGv_ptr ret, TCGv_i32 arg)
> +{
> +    TCGv_ptr temp =3D tcg_temp_new_ptr();
> +    tcg_gen_ext_i32_ptr(temp, arg);
> +    tcg_gen_addi_ptr(ret, temp, guest_base);
> +    tcg_temp_free_ptr(temp);
> +}
> +
> +void tcg_gen_g2h_i64(TCGv_ptr ret, TCGv_i64 arg)
> +{
> +    TCGv_ptr temp =3D tcg_temp_new_ptr();
> +    tcg_gen_trunc_i64_ptr(temp, arg); /* Not sure */
> +    tcg_gen_addi_ptr(ret, temp, guest_base);
> +    tcg_temp_free_ptr(temp);
> +}
> +
> +void tcg_gen_h2g_i32(TCGv_i32 ret, TCGv_ptr arg)
> +{
> +    TCGv_ptr temp =3D tcg_temp_new_ptr();
> +    tcg_gen_subi_ptr(temp, arg, guest_base);
> +    tcg_gen_trunc_ptr_i32(ret, temp);
> +    tcg_temp_free_ptr(temp);
> +}
> +
> +void tcg_gen_h2g_i64(TCGv_i64 ret, TCGv_ptr arg)
> +{
> +    TCGv_ptr temp =3D tcg_temp_new_ptr();
> +    tcg_gen_subi_ptr(temp, arg, guest_base);
> +    tcg_gen_extu_ptr_i64(ret, temp);
> +    tcg_temp_free_ptr(temp);
> +}
> +
> +#else
> +void tcg_gen_g2h_i32(TCGv_ptr ret, TCGv_i32 arg)
> +{

It would be worth adding g_assert_not_reached() to these stubs so any
accidental call gets flagged straight away.

> +}
> +void tcg_gen_g2h_i64(TCGv_ptr ret, TCGv_i64 arg)
> +{
> +}
> +void tcg_gen_h2g_i32(TCGv_i32 ret, TCGv_ptr arg)
> +{
> +}
> +void tcg_gen_h2g_i64(TCGv_i64 ret, TCGv_ptr arg)
> +{
> +}
> +#endif
> +
> +/* p: iptr ; i: i32 ; a: ptr(address) */
> +void gen_native_call_i32(const char *fun_name, TCGv_i32 ret,
> +                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3)
> +{
> +    TCGv_ptr arg1_ptr =3D tcg_temp_new_ptr();
> +    TCGv_ptr arg2_ptr =3D tcg_temp_new_ptr();
> +    TCGv_ptr arg3_ptr =3D tcg_temp_new_ptr();
> +    TCGv_ptr ret_ptr =3D tcg_temp_new_ptr();
> +    tcg_gen_g2h_i32(arg1_ptr, arg1);
> +    if (strcmp(fun_name, "memset") =3D=3D 0) {/* a aip */
> +        tcg_gen_ext_i32_ptr(arg3_ptr, arg3);
> +        gen_helper_memset(ret_ptr, arg1_ptr, arg2, arg3_ptr);
> +        goto ret_ptr;
> +    }
> +    tcg_gen_g2h_i32(arg2_ptr, arg2);
> +    if (strcmp(fun_name, "strcpy") =3D=3D 0) { /* a aa */
> +        gen_helper_strcpy(ret_ptr, arg1_ptr, arg2_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "strcat") =3D=3D 0) { /* a aa */
> +        gen_helper_strcat(ret_ptr, arg1_ptr, arg2_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "strcmp") =3D=3D 0) { /* i aa */
> +        gen_helper_strcmp(ret, arg1_ptr, arg2_ptr);
> +    }
> +    tcg_gen_ext_i32_ptr(arg3_ptr, arg3);
> +    if (strcmp(fun_name, "memcpy") =3D=3D 0) { /* a aap */
> +        gen_helper_memcpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "strncpy") =3D=3D 0) { /* a aap */
> +        gen_helper_strncpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "memcmp") =3D=3D 0) { /* i aap */
> +        gen_helper_memcmp(ret, arg1_ptr, arg2_ptr, arg3_ptr);
> +    } else if (strcmp(fun_name, "strncmp") =3D=3D 0) { /* i aap */
> +        gen_helper_strncmp(ret, arg1_ptr, arg2_ptr, arg3_ptr);
> +    }
> +    return;
> +ret_ptr:
> +    tcg_gen_h2g_i32(ret, ret_ptr);
> +    return;

This is a bit of a messy function considering that most of it is data
driven. I think we could have a table with something like:

   {
     { .func =3D "memset", .helper =3D gen_helper_memset,
       .g2h_arg1 =3D true },
     ...
   }

and then remove the duplication between the two gen_native_calls as
simply having different signatures for their g2h and h2h conversions. If
we ever get to embedding the signatures in the library that would make
things simpler to replace as well I think.


> +}
> +
> +void gen_native_call_i64(const char *fun_name, TCGv_i64 ret,
> +                         TCGv_i64 arg1, TCGv_i64 arg2, TCGv_i64 arg3)
> +{
> +    TCGv_ptr arg1_ptr =3D tcg_temp_new_ptr();
> +    TCGv_ptr arg2_ptr =3D tcg_temp_new_ptr();
> +    TCGv_ptr arg3_ptr =3D tcg_temp_new_ptr();
> +    TCGv_ptr ret_ptr =3D tcg_temp_new_ptr();
> +    TCGv_i32 arg2_i32, ret_i32 =3D tcg_temp_new_i32();
> +    tcg_gen_g2h_i64(arg1_ptr, arg1);
> +    if (strcmp(fun_name, "memset") =3D=3D 0) { /* a aip */
> +        arg2_i32 =3D tcg_temp_new_i32();
> +        tcg_gen_extrl_i64_i32(arg2_i32, arg2);
> +        tcg_gen_trunc_i64_ptr(arg3_ptr, arg3);
> +        gen_helper_memset(ret_ptr, arg1_ptr, arg2_i32, arg3_ptr);
> +        goto ret_ptr;
> +    }
> +    tcg_gen_g2h_i64(arg2_ptr, arg2);
> +    if (strcmp(fun_name, "strcpy") =3D=3D 0) { /* a aa */
> +        gen_helper_strcpy(ret_ptr, arg1_ptr, arg2_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "strcat") =3D=3D 0) { /* a aa */
> +        gen_helper_strcat(ret_ptr, arg1_ptr, arg2_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "strcmp") =3D=3D 0) { /* i aa */
> +        gen_helper_strcmp(ret_i32, arg1_ptr, arg2_ptr);
> +        goto ret_i32;
> +    }
> +    tcg_gen_trunc_i64_ptr(arg3_ptr, arg3);
> +    if (strcmp(fun_name, "memcpy") =3D=3D 0) { /* a aap */
> +        gen_helper_memcpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "strncpy") =3D=3D 0) { /* a aap */
> +        gen_helper_strncpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
> +        goto ret_ptr;
> +    } else if (strcmp(fun_name, "memcmp") =3D=3D 0) { /* i aap */
> +        gen_helper_memcmp(ret_i32, arg1_ptr, arg2_ptr, arg3_ptr);
> +        goto ret_i32;
> +    } else if (strcmp(fun_name, "strncmp") =3D=3D 0) { /* i aap */
> +        gen_helper_strncmp(ret_i32, arg1_ptr, arg2_ptr, arg3_ptr);
> +        goto ret_i32;
> +    }
> +    return;
> +ret_ptr:
> +    tcg_gen_h2g_i64(ret, ret_ptr);
> +    return;
> +ret_i32:
> +    tcg_gen_extu_i32_i64(ret, ret_i32);
> +    return;
> +}


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

