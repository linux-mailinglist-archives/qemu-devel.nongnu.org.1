Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB37755EA
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:56:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTeyO-0007d6-Un; Wed, 09 Aug 2023 04:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTeyM-0007cp-6e; Wed, 09 Aug 2023 04:55:18 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTeyJ-0005gb-2h; Wed, 09 Aug 2023 04:55:16 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1bb7297c505so4803093fac.1; 
 Wed, 09 Aug 2023 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691571308; x=1692176108;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgMAbQarehd4ZZgDsy//q6LQl9yPk44s2gJaixCkIh4=;
 b=epwC8edbwLchDUprOeYhaBgURaorxhjkYPj3ikz2g2bkI4sTuzuloAIkeo3P5LqvrN
 SHBd9GMbrZevPXXg3DcNWGO+apy8IOnbrDhYhiQgtv7mdZDZHWbY9NlknoUXpAAja8o4
 Vfa+Eu+u+N6+5W+yNAMtKl/Fbelebs4lfIT5mmv5Zl3snEbtoINbFl8DpcycP7Y4ON2B
 XZu1NHjCPLIkF7b9VkpAtx4WOiwclvft7JAg1MbWgv1Hz9zIiOzCm5SELaLaDqOlujs7
 cIhc5iD/JqRrVcvDL+3aknEGNVpjPQdFELkLjOSzS3P8ek5cOgSFSCiXQVyGkzt7Vm/k
 ACqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691571308; x=1692176108;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WgMAbQarehd4ZZgDsy//q6LQl9yPk44s2gJaixCkIh4=;
 b=I6didUDL7Djifowrl1BHfhKCVResdWjL9pa7wXCa8+l9kQgLwBiGITVOGt4mxNtapO
 BGL9yJ1W+d9ruM3PWz1Ea/5V5FfpJ9WcOAoIHUwcfiB9pD31PllSPivICqriUWwmlzTc
 oJfcUPGvnervR1C2uXL78YqMfBB8ACPZwFG7/6oOCBG8GdVnF+xwo58EXiQQ1XmttFhB
 4KWE5bl0qwpU58x4fcRb8M+XCvLe0LhzqHPyvxd64GM6rFVbsj8cM9QqPzS0ddbmDaro
 IaF47MzMKFEm/EwASW3oSQVgoo16Zo91zuKofB2GUg9CCv2Ntwl3bUtZy7nIcz9mlAWQ
 dl0g==
X-Gm-Message-State: AOJu0Yy1WJ+vekuSrMNyAuucb1zb9tbnqCt1Si21eQ/EG+kZjNA/uQO7
 icRQ+CKO0uuH+PpK0wZQPtU=
X-Google-Smtp-Source: AGHT+IE66dbBZ3KqhOvv9Dmxi/C+Yvb1Dqm6or7u2slEygYetGXc7uPDr8jXDWlwmct2FChhKyymmw==
X-Received: by 2002:a05:6870:b618:b0:1bb:4606:5be with SMTP id
 cm24-20020a056870b61800b001bb460605bemr2574845oab.9.1691571308380; 
 Wed, 09 Aug 2023 01:55:08 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a62e701000000b00666b012baedsm9399294pfh.158.2023.08.09.01.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 01:55:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 18:55:03 +1000
Message-Id: <CUNVZD2821O3.2WFT4M3XQIOIH@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 1/7] tcg/ppc: Untabify tcg-target.c.inc
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-2-richard.henderson@linaro.org>
In-Reply-To: <20230808030250.50602-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Acked-by: Nicholas Piggin <npiggin@gmail.com>

On Tue Aug 8, 2023 at 1:02 PM AEST, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 511e14b180..642d0fd128 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -221,7 +221,7 @@ static inline bool in_range_b(tcg_target_long target)
>  }
> =20
>  static uint32_t reloc_pc24_val(const tcg_insn_unit *pc,
> -			       const tcg_insn_unit *target)
> +                               const tcg_insn_unit *target)
>  {
>      ptrdiff_t disp =3D tcg_ptr_byte_diff(target, pc);
>      tcg_debug_assert(in_range_b(disp));
> @@ -241,7 +241,7 @@ static bool reloc_pc24(tcg_insn_unit *src_rw, const t=
cg_insn_unit *target)
>  }
> =20
>  static uint16_t reloc_pc14_val(const tcg_insn_unit *pc,
> -			       const tcg_insn_unit *target)
> +                               const tcg_insn_unit *target)
>  {
>      ptrdiff_t disp =3D tcg_ptr_byte_diff(target, pc);
>      tcg_debug_assert(disp =3D=3D (int16_t) disp);
> @@ -3587,7 +3587,7 @@ static void expand_vec_mul(TCGType type, unsigned v=
ece, TCGv_vec v0,
>                    tcgv_vec_arg(t1), tcgv_vec_arg(t2));
>          vec_gen_3(INDEX_op_ppc_pkum_vec, type, vece, tcgv_vec_arg(v0),
>                    tcgv_vec_arg(v0), tcgv_vec_arg(t1));
> -	break;
> +        break;
> =20
>      case MO_32:
>          tcg_debug_assert(!have_isa_2_07);


