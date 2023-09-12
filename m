Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BEC79D633
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6BO-0003fO-AY; Tue, 12 Sep 2023 12:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg6BE-0003el-QP
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:24:02 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg6BB-0004EG-6A
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:24:00 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a9cd066db5so745373766b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694535834; x=1695140634; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zMayzYKzU97jiOAAncdxm8PQcmBi6tmYeUc4gSGN6b0=;
 b=LFTY9qW7GNbY9n2Hm+arL7VYVsDGYhlfDtrNvAt1uF2e42sa3cVmUGsuv0u+HL1wyc
 6YzppcNn5zHW6n89l5IjZbtX0Y+ommNPFZLQN9RGYP42q/WriDa5unFhCAzyk+RovIXA
 bHCh8mdH51dlIe/UdQKsU5B1sYZTxow2uWESInOa0kPj81FwNMnR7jI57fRF1we/wweR
 vSwzQU03pscTMkKMRFTf58cfMqVs6swKq9utcURS5Gpsrjpo1UGz8HAcK3rj1DCgWV3r
 BmyXLq/d/fTvPPW1WJX1TQKHl0oFEib7vQwrmQn5nSLUmb8VMXC972VMehd8WUMSFuGj
 t+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694535834; x=1695140634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMayzYKzU97jiOAAncdxm8PQcmBi6tmYeUc4gSGN6b0=;
 b=E+U8r6CfTNdfjZB56cGeij00lqfiiZgdFqkTxi28TX1snsgDom8Wq4sKbzjhXithH9
 nt0AHqb8x96CK8equpliTqKkfBS9A4AlYQa/1W4ko36pOQccJ88lnyhEaj1vTX7S2bmh
 pZhVVP+fxi0d9CvgpcL/rd/I7x/j7rgrXV6S8NybM7cBqDgtYTWhukc7OwMswRzZztF6
 9VbjJXE/CzKNqAu/fb0ozt5U1uvl8+fyG1wAdqknm9Uk8oarwEC5t44YgYxfjtf47rT3
 viJqU1UETmlHWZxq0i3eZUBHpsjR5Tfl55XEtK+jBc5tmD2r5ozt1CaVSa5YzRGhn191
 VpQw==
X-Gm-Message-State: AOJu0YxAF+8Nald7BO6YzsT7CFuyoBY4uQeWRPUIsiHVJ+dvx1lsfxsj
 FV4fwjICd6JONYhA5oan6NUGarVq0RbruWTkNs8BSA==
X-Google-Smtp-Source: AGHT+IFgJtkSNqK3XKYlajliFJRYo5IsDRjBDjynDbpXSoPH2KzYPAV6jIGy5GiJFLeRyGqTk+PgiF9+QpsAVFMlJfQ=
X-Received: by 2002:aa7:c6d0:0:b0:525:5a65:6dfa with SMTP id
 b16-20020aa7c6d0000000b005255a656dfamr101661eds.14.1694535834238; Tue, 12 Sep
 2023 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230816142516.469743-1-richard.henderson@linaro.org>
 <20230816142516.469743-4-richard.henderson@linaro.org>
In-Reply-To: <20230816142516.469743-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 17:23:42 +0100
Message-ID: <CAFEAcA9_St7e4G=BC2k_f8oWKphiD+3P6fEOKzW=vBGSijiKTA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tcg/aarch64: Emit BTI insns at jump landing pads
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Wed, 16 Aug 2023 at 15:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The prologue is entered via "call"; the epilogue, each tb,
> and each goto_tb continuation point are all reached via "jump".
>
> As tcg_out_goto_long is only used by tcg_out_exit_tb, merge
> the two functions.  Change the indirect register used to
> TCG_REG_TMP1, aka X16, so that the BTI condition created
> is "jump" instead of "jump or call".

TCG_REG_TMP1 is X17, not X16...

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>  static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
>  {
> +    const tcg_insn_unit *target;
> +    ptrdiff_t offset;
> +
>      /* Reuse the zeroing that exists for goto_ptr.  */
>      if (a0 == 0) {
> -        tcg_out_goto_long(s, tcg_code_gen_epilogue);
> +        target = tcg_code_gen_epilogue;
>      } else {
>          tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
> -        tcg_out_goto_long(s, tb_ret_addr);
> +        target = tb_ret_addr;
> +    }
> +
> +    offset = tcg_pcrel_diff(s, target) >> 2;
> +    if (offset == sextract64(offset, 0, 26)) {
> +        tcg_out_insn(s, 3206, B, offset);
> +    } else {
> +        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP1, (intptr_t)target);
> +        tcg_out_insn(s, 3207, BR, TCG_REG_TMP1);

Since it's now important that the tempreg we have here is
one of X16/X17 in order to get the right BTI behaviour,
I think a build-time assert of this would be helpful.
That will catch the possibility that we forget about this
and decide to rearrange which registers we use as
tempregs later.

>      }
>  }
>
> @@ -1970,6 +1984,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>      tcg_out32(s, I3206_B);
>      tcg_out_insn(s, 3207, BR, TCG_REG_TMP0);
>      set_jmp_reset_offset(s, which);
> +    tcg_out_bti(s, BTI_J);
>  }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

"Did we miss anywhere that should have had a BTI insn"
is a bit tricky to review, but I assume you've done enough
testing on a BTI-enabled host to catch that.

thanks
-- PMM

