Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A953974F5B3
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGOd-0000HR-VZ; Tue, 11 Jul 2023 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGOc-0000GI-5x
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:39:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGOa-0003XQ-Jg
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:39:25 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51e590a8d0bso3219345a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689093563; x=1691685563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q304/FRQeotYRiGDNsMplK+tOo7tXr4cUQyn27ARwTE=;
 b=KV6VKRhdEH6cWzRFjEOqGh6MJ6nFoGuHVAdi3NPSWeh/ELtU0isbwMBcnYLEpzmxIx
 k2r2pBi7xkFY5+Ku4RD6XtFVIDTk/XTWRHfi9RgR4qr7l9oGGLY9MoKFX50FivnxE4fT
 vZw41dlKA/edrxbknA/l9+rykKOVraVcDZP30tvrfqXn0GFFoX9i/HpLiqkBwtdeG8aQ
 jcJYmbdfpK2UsK2hJ2/dOFIOfx5Lg03POlU1OAxkOfxvrHSSGqTWRjXbUQV6gs4JIF7Y
 /ldI2efHl41AB4FIrYBIVgH5N179pymAsbaxV30z9/PWORKH3ED+CHtXQoxYPauWEFf+
 /ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689093563; x=1691685563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q304/FRQeotYRiGDNsMplK+tOo7tXr4cUQyn27ARwTE=;
 b=kZNohPnCPt8HMF9AptGwD7Hwsyb71PCj1jVk2/839jDkDXiJ1yzq+Jd2V2RKS2lkPY
 kN2s1pjdCFOCWtEiJPZkz/v+pX/jBzNQG4L6ShORpJdcBcuogKFH/sLCYzi3LZkOEcdl
 HQhEnXjNLfNJ/hny+C1k9slngRl3/6gDjBz9uGmlWkMa5mlB40Vwu1z/lpweIhkwHclF
 2XAi+WHX0zwkMQSWUJk0S9ZcvtkXs27ESBUWULZ/tWgDLJRtf+gyDfE8vJpKc3kNnnME
 8mc/HrjefMgZxu1IiPZ/5OXqWw7kona+Uqr6EMdANjt1oG7gg76N7gXRXOQTE5hOgxTo
 y89w==
X-Gm-Message-State: ABy/qLYuDYhfdVEiDxRqhEvBU8IMINK+ys8E8pxPnKsHc4TPyxHwNOSI
 HP/ypn8t8zEvwTiM+pVuYJI+9FKdN/pVxUNaUVfErw==
X-Google-Smtp-Source: APBJJlEh/LOGZaUGnKLzgh4VMy7MdaUec4Wj883Brlam94L8k/d6cVmCbToFInxEhKxn/vaumPyTIcfMZ3B7/qUQU3A=
X-Received: by 2002:aa7:cf08:0:b0:51b:d567:cfed with SMTP id
 a8-20020aa7cf08000000b0051bd567cfedmr18113133edy.5.1689093562926; Tue, 11 Jul
 2023 09:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230626153945.76180-1-richard.henderson@linaro.org>
 <20230626153945.76180-3-richard.henderson@linaro.org>
In-Reply-To: <20230626153945.76180-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2023 17:39:12 +0100
Message-ID: <CAFEAcA9EEqXPa7xoi3rXduBsGUj5wn1aXjBSBHrmdxVPq-aPEQ@mail.gmail.com>
Subject: Re: [PULL 02/22] accel/tcg/translate-all.c: Widen pc and cs_base
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 26 Jun 2023 at 16:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Anton Johansson <anjo@rev.ng>
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230621135633.1649-3-anjo@rev.ng>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> @@ -634,10 +634,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>      cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_LAST_IO | n;
>
>      if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
> -        target_ulong pc = log_pc(cpu, tb);
> +        vaddr pc = log_pc(cpu, tb);
>          if (qemu_log_in_addr_range(pc)) {
> -            qemu_log("cpu_io_recompile: rewound execution of TB to "
> -                     TARGET_FMT_lx "\n", pc);
> +            qemu_log("cpu_io_recompile: rewound execution of TB to %"
> +                     VADDR_PRIx "\n", pc);

TARGET_FMT_lx includes a width specifier so the value is
left-zero-padded to the appropriate width (depending
on the size of the PC on the target). VADDR_PRIx does
not zero-pad. Intentional change?

thanks
-- PMM

