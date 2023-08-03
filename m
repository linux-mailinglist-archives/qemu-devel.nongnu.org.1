Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D186576E9A4
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRY6b-0005l9-TF; Thu, 03 Aug 2023 09:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRY6Z-0005kS-8g
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:11:03 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRY6W-00040k-Ii
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:11:02 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5217ad95029so1161853a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691068258; x=1691673058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aPgR+8Z6FioSmVj22N+KAX6A9dIrTcOc4laBdi8RaGA=;
 b=pdYYfdk2n66pSLShBcYwQ8DhrVKeacgnDr0T6rjcd3StrcbErxCQ/KfYs8ypDVGsM+
 n7aqrCrnNApdYcqo8eDN/V+ZjpReCi6Y2csLNdV+gUz8/UDMHICgE3N/hkrkxzrC3rtJ
 8viev0CSKI4FlIlJNkRhAJWjmx6cx8Uwyr+/W7Y5G5HQfJ6UwAREzOduROAOJat6lICb
 0csUdO9e6NBB6FlfNn4Rbc1epES78oNICBBcZh8d0wCGBEhUHPC9g4U4KhP5AEqI1zp5
 r0JNfxALgdKkJS6qDDdLzmG136CbDah/WBKFtpUxjRSQF1jIJEX3ZgI3FDBuMdECzudH
 RHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691068258; x=1691673058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aPgR+8Z6FioSmVj22N+KAX6A9dIrTcOc4laBdi8RaGA=;
 b=JQvfy2WH6z4O4nQKk9BtV83v5wlhd+wMuWM/ygkiufSzLfP7ykz3sG3KadDM3xvQ9o
 6z+Y7XjTepjhTcz8hSXr92lL2EWsy8fChaLRLfIDgeHdU6jIbBg9Ef9nxlVHP8mu2lW/
 tA6NZKh+Ado3ra+7F9TBe7dRLfmmyRTqF9LhYPzL2ZJdXO+9akKrnu8NT7IJ1q5H1tIo
 3j7dSB7OTxCSutIjBKSLiyLcEn6Gd5oROhEZDV1DaKynsAp/55ZwxsGY+vyhtg9VEoKY
 oD9TToIwCh9ykNVsvJQiQueRt3YoagPQbMvMMnnLPmvNTVi9iJ1LBydXdc1N6iJ5Zi2B
 VZlg==
X-Gm-Message-State: ABy/qLYy/d9N5ANSr1vD1/H4SUWcLsP/XGS3f/+kVLUU3pqoM09hO4b8
 Gac4B7sX+2dSeifQji+yYqDgnXt2EqLYkzf/wLmbDQ==
X-Google-Smtp-Source: APBJJlFKeheUN08Uzb02eKMfRzrLphI0rjoCn12M7yB/5E+43muHWM0COykbWrm5IDcobxBIWgLUBR4moAbJooRZW+k=
X-Received: by 2002:a05:6402:553:b0:522:2061:bc84 with SMTP id
 i19-20020a056402055300b005222061bc84mr8060824edx.24.1691068257709; Thu, 03
 Aug 2023 06:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230727162621.445400-1-richard.henderson@linaro.org>
In-Reply-To: <20230727162621.445400-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 14:10:46 +0100
Message-ID: <CAFEAcA_wYBSiBRy6HQaRh7k=UFrnQ=EwSQQ2e=7PJUzfyVp-ng@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Do not use gen_mte_checkN in trans_STGP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 27 Jul 2023 at 17:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> STGP writes to tag memory, it does not check it.
> This happened to work because we wrote tag memory first
> so that the check always succeeded.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 41 +++++++++++++---------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 5fa1257d32..dfd18e19ca 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -3020,37 +3020,17 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
>          tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
>      }
>
> -    if (!s->ata) {
> -        /*
> -         * TODO: We could rely on the stores below, at least for
> -         * system mode, if we arrange to add MO_ALIGN_16.
> -         */
> -        gen_helper_stg_stub(cpu_env, dirty_addr);
> -    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> -        gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
> -    } else {
> -        gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
> -    }
> -
> -    mop = finalize_memop(s, MO_64);
> -    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << MO_64, mop);
> -
> +    clean_addr = clean_data_tbi(s, dirty_addr);
>      tcg_rt = cpu_reg(s, a->rt);
>      tcg_rt2 = cpu_reg(s, a->rt2);
>
>      /*
> -     * STGP is defined as two 8-byte memory operations and one tag operation.
> -     * We implement it as one single 16-byte memory operation for convenience.
> -     * Rebuild mop as for STP.
> -     * TODO: The atomicity with LSE2 is stronger than required.
> -     * Need a form of MO_ATOM_WITHIN16_PAIR that never requires
> -     * 16-byte atomicity.
> +     * STGP is defined as two 8-byte memory operations, aligned to TAG_GRANULE,
> +     * and one tag operation.  We implement it as one single aligned 16-byte
> +     * memory operation for convenience.  Note that the alignment ensures
> +     * MO_ATOM_IFALIGN_PAIR produces 8-byte atomicity for the memory store.
>       */
> -    mop = MO_128;
> -    if (s->align_mem) {
> -        mop |= MO_ALIGN_8;
> -    }
> -    mop = finalize_memop_pair(s, mop);
> +    mop = MO_128 | MO_ALIGN | MO_ATOM_IFALIGN_PAIR;

So here we're implicitly assuming TAG_GRANULE is 16 and
then relying on the codegen for a MO_128 | MO_ALIGN
operation to give us the alignment fault if the guest
address isn't aligned to the tag granule, right ?

Previously we also put s->be_data into the MemOp
(via finalize_memop_pair() calling finalize_memop_atom()).
Don't we still need to do that ? (We do explicitly swap
the two i64s into the i128 in different orders depending
on the be_data setting, but I think that is to handle
MO_128 | MO_BE giving a true BE 128 bit store, whereas
what we're implementing is two BE 64 bit stores.)


>      tmp = tcg_temp_new_i128();
>      if (s->be_data == MO_LE) {
> @@ -3060,6 +3040,15 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
>      }
>      tcg_gen_qemu_st_i128(tmp, clean_addr, get_mem_index(s), mop);

thanks
-- PMM

