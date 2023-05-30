Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5986371671A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41J5-00059M-T5; Tue, 30 May 2023 11:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41J1-00057E-U3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:30:39 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41J0-0002MT-CY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:30:39 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2af177f12d1so50696471fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685460635; x=1688052635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iaTrPRGKkkf4z6lCtMi+5SfTV1OeH7LryHKVi7n7wbs=;
 b=PferG3AGtnbIDLLpQWlRBHiDUiPiqgrFSUzYQBYHqtV40ZDzaC84sgZ4dsOLXzFos/
 XIwQ7h0u5eGwCtsEqz2BCLrj2vV1XzyV+tpUY1cQtZAsKO5D1FpJST8k7iDJHNb4xZqs
 Tgk8kX5olh6wd4NLjN3YvGVcToIFxhkb1rl27F3Kh0VtxIjw5OqoTgNa/FzkJ8cYGybA
 PFZw/dVvs2fFfiIMgEsXlRJYfqoAp0sx+U3bkqr3XOsMUbLvBAOoMxm16RVwqr1y0Cwz
 +Emj6KU9AJJMyw/VJceEMqFdOEROmPz0OTZRcIbZwBVpyySjR6SO3bM8KJzs1plwR2Tb
 A0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460635; x=1688052635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iaTrPRGKkkf4z6lCtMi+5SfTV1OeH7LryHKVi7n7wbs=;
 b=ZIyxX91gra7DmNVdmDclfBaD21BxrdTR/JSoN6/8OwIyU9ezi63ujRDPIhEYcT9gSV
 vYZT9njt7U3ERwuigUbBsrQLkCS29l0gx+diiWfnXmHcTX2bi22c9uiIrja5VFync27Z
 txjAnORHN2mUNTZuUvEVBvaAD3W4TGT1M+KeZp5+TKaG3KPRAH4Q+yy/e3VqD0dWGbjf
 fAZp+s9a+HCxAmX3HD0lav9zezLmk4QlvWk5N4OVFNt3e04SD2VcBez/aE6IG0+oecy0
 clZ8zMNSanLmJ1VgbQBWss+WfSmqk4TghMHmm/vTVP6eWU87z3Z1zMkNcGtQeXd1gKwl
 pMog==
X-Gm-Message-State: AC+VfDy8fWRbe14hbjL5KIHPGieziHhl/IlrjGgdfv+n7jyDqbO52zaS
 H2fP+hCXupmPnC9/foOTzs+l9bTU5q1nxD7B1xCRdw==
X-Google-Smtp-Source: ACHHUZ7WMKAQIqoSGoOFDyThRfsgtWM5iHLqsSG0Gud/LMUPQpvmsnes1+ThAlERIXX26K0AAQWPp2XdAybK0HQXb20=
X-Received: by 2002:a2e:9e47:0:b0:2ab:145e:c04a with SMTP id
 g7-20020a2e9e47000000b002ab145ec04amr1152704ljk.17.1685460635032; Tue, 30 May
 2023 08:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-19-richard.henderson@linaro.org>
In-Reply-To: <20230525232558.1758967-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:30:24 +0100
Message-ID: <CAFEAcA-m514=+H6yuWkTWh=NMQFj1Q_4OchA=4KPBaBA=_c8vg@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] tests/tcg/aarch64: Use stz2g in mte-7.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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
> We have many other instances of stg in the testsuite;
> change these to provide an instance of stz2g.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/mte-7.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

