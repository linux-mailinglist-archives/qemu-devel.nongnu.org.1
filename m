Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0D71670C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41Hv-0004DX-4Y; Tue, 30 May 2023 11:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41Ht-0004D0-Ex
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:29:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41Ho-0001pb-3k
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:29:29 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5148f299105so6970134a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685460562; x=1688052562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9+mbQDFX68G3E3jQzlb7cQlWENF/+5t9iERv400eN7M=;
 b=TyOkjxG+LSacde180KuEKktGIpb1AAM/6HmCPzVCWXfQPB52/nDbYjc2LA27Gh4kpH
 ige2A3mNcZQjZ7ic8K7Fs3ELqau++XT5hUYBJqNCS76GFgIpx8F1FQiaynybGR5Om9C9
 Q2GS3xYv/UXawLUOLQh5eqBrmeD7HUC3MfL8PXib7cHATuOOqlsJXeoPKPjppGJwf8a1
 GDR4bncrM6Csa2vXA/S3pyi2wAAzF59VP3cFq2/YuKygxsx7yGdp3bOwb8vz9lbAHVBg
 kfdxt3Taw6oHM0QBUuEEuCiEd5JH56oxw3gDy47kXB/if1fqkYT69rc6BjVjUGsascEJ
 Wl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460562; x=1688052562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9+mbQDFX68G3E3jQzlb7cQlWENF/+5t9iERv400eN7M=;
 b=dXI92H4EAoV1e4z+6E2VH1tkBRn/rh3Qfq2kq50DtqiyG+T/t2+BQxn3bCvdxY/M6Q
 py/uxw2ttJXUZJ0RC59WVxn+/T7urQUX3jw5i1qOtBgDSOwQAOMSTxmxXdK79D80ZKq8
 5YridXBRmB3KvX+wEWg/VhCBDQn3MTKWY/c7le63cUyDSyQIM+fxYVdHnnbJxoED0olg
 xjFR+s7ZBxh7/3liMC5vgDsS94Ia6CRMFcBG2ux6Y5lP7Fl9Cp9neH3ZvBHq3QdtZkau
 sNvcEvs02QC+D1g99sC8V8K7kwipfGiMQLyfnYlEKtipPFOn5zpJ+AH91SqiJMk3AhhH
 xa1Q==
X-Gm-Message-State: AC+VfDxkxXA4IWQjybNsjQmef8whFNiGi1qBoSNJiV6VjsYgy5ss7C/v
 +uUg6SNPqeGJL1cQyfuTXxWBlGlIw6Mq6RUHKczHL+UaqICh4AHM
X-Google-Smtp-Source: ACHHUZ68T0+5cMAHTuUJhb/99EUuqn+xTBDDjz+S4EmkSKQDX1I5Dg9185TcaUbR0n+p2mkMCFLXrja5blnWmOk/6IE=
X-Received: by 2002:a05:6402:2038:b0:514:9e47:4319 with SMTP id
 ay24-20020a056402203800b005149e474319mr2845808edb.5.1685460562231; Tue, 30
 May 2023 08:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-6-richard.henderson@linaro.org>
In-Reply-To: <20230525232558.1758967-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:29:11 +0100
Message-ID: <CAFEAcA-7PK53g+m4atTfOh1cHBZUqZxynqocL85M_0F1FoupNA@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] target/arm: Use tcg_gen_qemu_{st, ld}_i128 for
 do_fp_{st, ld}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 26 May 2023 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While we don't require 16-byte atomicity here, using a single larger
> operation simplifies the code.  Introduce finalize_memop_asimd for this.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.h     | 24 +++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c | 35 +++++++++++-----------------------
>  2 files changed, 35 insertions(+), 24 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

