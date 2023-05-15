Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E0E70332C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyb8I-0001jk-AI; Mon, 15 May 2023 12:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyb82-0001cn-SB
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:32:54 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyb80-0007kG-SI
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:32:54 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-50bc3088b7aso24181923a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684168371; x=1686760371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KtCvB/whD3aPva64LZ/n3GRmBLQPNzBmCk3KhtlRHzc=;
 b=p+Zdh4tL4N652Sz4G2ZeRLd3N8lAHuvDVUVtUe3kDXXuVGHoHNkim3XlhHdwMn6bvI
 OmqKphtDH1UrN809yH4/F5wfY7HPxQyY7Oa8hDCfBTQQLH1NlI7u/GNoN97hQ9ZlWOdx
 0yQepVnG1CNKbvS7Vg3mvh/0B15Xkv3M7o4CUnN1XmCYhew50dc1Du5KV2JAN8HfE6tH
 PpiUCVgg7ssaEScdHMWIXxpY1qqqJa3+RD4CfDqOYTNu0n3QCOPoHE56PglfPU6tQdlR
 +FlQ+msVCcAsFSaqIeCt1y0fZzE6cFhpOKgf7F3wYMT5PWzRJVyCwH2cuy//+rAvjqdy
 xqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684168371; x=1686760371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KtCvB/whD3aPva64LZ/n3GRmBLQPNzBmCk3KhtlRHzc=;
 b=ZNbUpMpBiAFpdq4h27OqDfCuoEqgvi49+uQsrjiPnq4y4ZgZVrnvyJBr+02CpSTKaB
 2tfnWxK02d2Ily6yc0qPspBV4qxTEWCAy5KQQE2tnaC+DXGRuq4dk8CuwfGhDF+Hf5qr
 N1aAAFeEukFObaGqaDxzJMO72fjnizRGBzxyI6lH9uPh6opNzeUUfHe7pa6q17JzJ8Y8
 0Ll71gaeMIHkeGfHQDeHhdI3I71x03Wg+vnWiQsx8izGRsDeqz3bnRIzQ/w+4qOxIWTi
 KDoFhTavArVkvssKy9mfpnuMDZ5aDg8IvevKoYUqjpg3Xl/bnjcH6OWo2z16MOs6OlGo
 b++g==
X-Gm-Message-State: AC+VfDzUuNahH9axP/o2Z+U86Z0vZTXAwRHIY8QDrbYpqpOsJG3b37oG
 N+SokTBgGCqnEbhEteh4gK3VU9N8p+7v4f8/DXQLVA==
X-Google-Smtp-Source: ACHHUZ73FhhGxUpG1jpvuQ8CdLTiRdbphPP2XvzdQ84SSROCCJlyrUVHfbo9lXNqlHR50AtZDKdmXMisMR87N9WuEoo=
X-Received: by 2002:aa7:cf95:0:b0:50b:c4f0:c200 with SMTP id
 z21-20020aa7cf95000000b0050bc4f0c200mr28050794edx.41.1684168371228; Mon, 15
 May 2023 09:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-2-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 17:32:40 +0100
Message-ID: <CAFEAcA_gBrw9EvQf6srCmcVXEeS2Jh3=+PWj6G3B566h81uw=A@mail.gmail.com>
Subject: Re: [PATCH v5 01/54] include/exec/memop: Add MO_ATOM_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 15 May 2023 at 15:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This field may be used to describe the precise atomicity requirements
> of the guest, which may then be used to constrain the methods by which
> it may be emulated by the host.


> @@ -2330,17 +2339,23 @@ static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
>              case INDEX_op_qemu_ld_i64:
>              case INDEX_op_qemu_st_i64:
>                  {
> +                    const char *s_al, *s_op, *s_at = NULL;

Do we need this NULL initializer? We seem to immediately assign
to s_at below, same as we do for s_al and s_op.

>                      MemOpIdx oi = op->args[k++];
>                      MemOp op = get_memop(oi);
>                      unsigned ix = get_mmuidx(oi);
>
> -                    if (op & ~(MO_AMASK | MO_BSWAP | MO_SSIZE)) {
> -                        col += ne_fprintf(f, ",$0x%x,%u", op, ix);
> +                    s_al = alignment_name[(op & MO_AMASK) >> MO_ASHIFT];
> +                    s_op = ldst_name[op & (MO_BSWAP | MO_SSIZE)];
> +                    s_at = atom_name[(op & MO_ATOM_MASK) >> MO_ATOM_SHIFT];
> +                    op &= ~(MO_AMASK | MO_BSWAP | MO_SSIZE | MO_ATOM_MASK);
> +
> +                    /* If all fields are accounted for, print symbolically. */
> +                    if (!op && s_al && s_op && s_at) {
> +                        col += ne_fprintf(f, ",%s%s%s,%u",
> +                                          s_at, s_al, s_op, ix);
>                      } else {
> -                        const char *s_al, *s_op;
> -                        s_al = alignment_name[(op & MO_AMASK) >> MO_ASHIFT];
> -                        s_op = ldst_name[op & (MO_BSWAP | MO_SSIZE)];
> -                        col += ne_fprintf(f, ",%s%s,%u", s_al, s_op, ix);
> +                        op = get_memop(oi);
> +                        col += ne_fprintf(f, ",$0x%x,%u", op, ix);
>                      }
>                      i = 1;
>                  }

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

