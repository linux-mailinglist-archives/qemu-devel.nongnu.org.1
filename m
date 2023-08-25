Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ABA7881B4
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRvi-00033T-FI; Fri, 25 Aug 2023 04:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZRvZ-00032D-GG; Fri, 25 Aug 2023 04:12:22 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZRvX-0004mh-78; Fri, 25 Aug 2023 04:12:21 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26934bc3059so1257854a91.1; 
 Fri, 25 Aug 2023 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692951137; x=1693555937;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwqaC+jBdI6czPFgR85mQckP4s4+552iOnCtWtNBqaE=;
 b=V3yJovPjSB+VJghIZlMh3NsQpDiWAyzwOdgk1u5K7IH4SdrS/lpbI2cB5yqbLKHHoq
 Hstvs8egRQYLZJ2kxfovRtdvOOi8TvvjpvdFTp5FL/44KwlWxnwr5M7byZvRTM+TEtGj
 YLIC/f2N3FMHWZR8vg4qUVQ44tPuLkQFO8+jV3hmjM/zuIqPXioudBbn85eCD7BGwpBn
 CkVzqSGLl4UkhbkGgRCjxBrusfLuU4wPgoiPSz6xC3lHMVOsoBC8HO2Po9T5AUrQzjm+
 dQ/ZWXcYWsIDugbthNk1px4bm6mCe3F57BatYgNkH4Oz59ky8d7wvyRmrJ1+aEDeR0O+
 mNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692951137; x=1693555937;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uwqaC+jBdI6czPFgR85mQckP4s4+552iOnCtWtNBqaE=;
 b=GS2cE5ihT+xn2u4c1Fv9O5ISqhGogrwD93aSz1dnymKy0N16BQz9GjhaRno+AdDos7
 EOrhqinunv55L+7zcEW/qERMDCh1jF77zUUcP7K/EbeBTHO+MbH/2cmQJsBpJCN154fl
 qJAcGEhiSNEjxaRo56kKaBq66xLoS+xkugvp/j7y7nli7B7+OuGzppO/82pnKBSnNPDF
 KVkry4gxz1VaGYGeorX+i63HFd3nV3xyxDaWHlRyqs97AtS0997hAziIjx9Qd9lWqF1r
 /6KMx6he14VOP0+9cWbAM4ikMzhE8oH61k0RyswphP3b+TYu3Rc4ncteTmO69k/3I8LH
 Q8DA==
X-Gm-Message-State: AOJu0YzxyoMFgOhzJYOU81OQbvrBWvmX7E+ikozOHqrCAwk4m4Y/Lk0k
 Agb/P8PM+RXhQDlerxGbpGE=
X-Google-Smtp-Source: AGHT+IFHNbB8F9BRr5zqoImOeg00sLBs3qQ7AKTooUfX6seNZ27Go0X9VMPQW6W1IRm0PKluVuX3PQ==
X-Received: by 2002:a17:90b:4f48:b0:269:a96:981a with SMTP id
 pj8-20020a17090b4f4800b002690a96981amr26569293pjb.5.1692951137297; 
 Fri, 25 Aug 2023 01:12:17 -0700 (PDT)
Received: from localhost ([1.146.69.243]) by smtp.gmail.com with ESMTPSA id
 a10-20020a170902900a00b001b850c9d7b3sm1023330plp.249.2023.08.25.01.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 01:12:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Aug 2023 18:12:08 +1000
Message-Id: <CV1H37J4R9QM.3FSAO1X6DSGQM@wheely>
Cc: <qemu-ppc@nongnu.org>
Subject: Re: [PATCH] target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230821025935.401914-1-richard.henderson@linaro.org>
In-Reply-To: <20230821025935.401914-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

On Mon Aug 21, 2023 at 12:59 PM AEST, Richard Henderson wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1779
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Should go to qemu-stable I would say? Thanks for fixing.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> ---
>  target/ppc/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index 424f2e1741..48257f7225 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -59,6 +59,7 @@ void ppc_store_vscr(CPUPPCState *env, uint32_t vscr)
>      env->vscr_sat.u64[0] =3D vscr & (1u << VSCR_SAT);
>      env->vscr_sat.u64[1] =3D 0;
>      set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
> +    set_flush_inputs_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
>  }
> =20
>  uint32_t ppc_get_vscr(CPUPPCState *env)


