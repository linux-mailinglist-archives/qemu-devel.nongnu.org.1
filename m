Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941A183922F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIPE-0003j7-0k; Tue, 23 Jan 2024 10:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSIPB-0003iw-OZ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:09:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSIP8-0001Rq-94
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:09:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40eacb4bfa0so24197045e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706022571; x=1706627371; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uRt5jgQYft+dLeTRhdsOd33FUTT4M8iKYYYMK1T/zc=;
 b=TanDxJtp4J5m9w6DH0MCv/ToixiSgn0F4APxR1agHOY3c3F/USbNCkLBB/t2BAthFi
 wkP9uKzndIOti4MZxyRkyTz8uqxmhyBWH4oKKj/jW5dS01qFyMnJvEQoGCQZlAaXWw+/
 AZRCqfaGkWLFfDikAJbyc7ea95oXbHwU1U5a4G7AKV+kzKh2BRr2B7/5YQQUkmtiO/9x
 V4pl05OCFC+7+/MRwXAUAwDblXTDIgH84IdJRTaowfwdz+JtBlGV/X+m+Jwrjytss8r+
 dbBWRVVbV96LCb3mWlnHAlCe5jOb5TBJeUhGPtfemeZSOrEcAJf3ME8SUuA+t7zDpqtP
 JaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706022571; x=1706627371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uRt5jgQYft+dLeTRhdsOd33FUTT4M8iKYYYMK1T/zc=;
 b=hRFIrdwdta741UB7ylfrnnsoFJx1o2UG/h0vX65JoRiYOYf/BCPkjgvgBJJ4ftZt3m
 6U0QlY8oCL8xvTzGND3WRq214udE09mJ+iBFp8y2mTJA+o6iBwRCuKgs6H14iTHt1Vmo
 XsmhZcMIRgn7wsSBrZ6WhToECYfOVSFiMfEHAU2R7wjO6cFu1B111FILrg8wJbfHVoH3
 6K2rT8zsfU0CR5CoQAmPBNRRvpYiQMcnaPSWJiZ6xOiIOlizVX3PJvrltxpGXdpqLUsq
 hoiB6j9NuOw8N2FI1qH8Yuzmv8qcBdHbsKRo6LrTVe3xFUs2KvQNGj5SGS3O1NYkFCoS
 fIvw==
X-Gm-Message-State: AOJu0YyDPCMzMahH62n5KgCNRypG830nc9vlR3lfJmYCyopatgC+rpMz
 jGc2nbrVyw5RBoHxhFmXQ5r6PG5RFJDrBINA0GAIas3txhleeYcC9T9GmpstN+jYmNamevIfYCw
 57LfS8oMajYjl1+VCcgAWkxcVDCtkSn0S+CUr3w==
X-Google-Smtp-Source: AGHT+IFrt9MZdUsk2kGAp8lqSL7nGBZo1kWHUKqyQqO6upHm9F90d5PEoJW8Z+i7mezTVv3g8pepg0U3HTgfp2yzuLU=
X-Received: by 2002:a05:600c:5715:b0:40e:6256:113b with SMTP id
 jv21-20020a05600c571500b0040e6256113bmr222619wmb.141.1706022570717; Tue, 23
 Jan 2024 07:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20230309200550.3878088-1-richard.henderson@linaro.org>
 <20230309200550.3878088-78-richard.henderson@linaro.org>
In-Reply-To: <20230309200550.3878088-78-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2024 15:09:18 +0000
Message-ID: <CAFEAcA-VGXJCL5XVqYfr6MmvMYX1hL68fd2kMPUz4dfuH9p4WQ@mail.gmail.com>
Subject: Re: [PULL v2 77/91] target/arm: Avoid tcg_const_ptr in
 handle_vec_simd_sqshrn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

On Thu, 9 Mar 2023 at 20:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> It is easy enough to use mov instead of or-with-zero
> and relying on the optimizer to fold away the or.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 2ad7c48901..082a8b82dd 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8459,7 +8459,7 @@ static void handle_vec_simd_sqshrn(DisasContext *s,=
 bool is_scalar, bool is_q,
>      tcg_rn =3D tcg_temp_new_i64();
>      tcg_rd =3D tcg_temp_new_i64();
>      tcg_rd_narrowed =3D tcg_temp_new_i32();
> -    tcg_final =3D tcg_const_i64(0);
> +    tcg_final =3D tcg_temp_new_i64();
>
>      if (round) {
>          tcg_round =3D tcg_constant_i64(1ULL << (shift - 1));
> @@ -8473,7 +8473,11 @@ static void handle_vec_simd_sqshrn(DisasContext *s=
, bool is_scalar, bool is_q,
>                                  false, is_u_shift, size+1, shift);
>          narrowfn(tcg_rd_narrowed, cpu_env, tcg_rd);
>          tcg_gen_extu_i32_i64(tcg_rd, tcg_rd_narrowed);
> -        tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esi=
ze);
> +        if (i =3D=3D 0) {
> +            tcg_gen_mov_i64(tcg_final, tcg_rd);
> +        } else {
> +            tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i,=
 esize);
> +        }

So, it turns out that this causes a regression:
https://gitlab.com/qemu-project/qemu/-/issues/2089

The change here is fine for the vector case, because when
we loop round the subsequent deposit ops will overwrite
the bits of tcg_final above the initial element, whatever
they happen to be in tcg_rd. However, for the scalar case
we only execute this loop once, and so after this change
instead of the high bits of the result being 0, we leave
them as whatever they were in tcg_rd. If the narrow is a
signed version and the result was negative, those high bits
will now be 1 instead of the 0 they should be.

Using
 tcg_gen_extract_i64(tcg_final, tcg_rd, 0, esize);
instead of the tcg_gen_mov_i64() should fix this.

I'll send a patch later this afternoon.

thanks
-- PMM

