Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A0B79880C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebko-0000ao-Hk; Fri, 08 Sep 2023 09:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebkm-0000ad-LL
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:42:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebkk-0005Yk-HZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:42:32 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so2838764a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694180548; x=1694785348; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MdihRmGVf653hvyytkSn9JMWlM4kTYEnM3FpjmKGCO0=;
 b=sb0UieANwhWQ0ZF8CTWGkuGYyrhhJ0/u3mGlzzOXukI7Ygpn4JuuUbuYYGLlfNu0zB
 NdnGamNbACOSXCmqNbaCJFyxVZ7hfdHbnmNTzp6khaqzq09qiTCIyDro0HhYjJLDLg5g
 bQpl+U9aqKck6GTlZbc3vSORh41WIyelUnr2SGCoW8WiZNiuPTk2uwye5eKrU8TgJf67
 WKFE9c+z68S/YERLuV7eSHHa4ZxIrdYdzocd6+cK1BB0O78wJJ/0ghsy+1elxaBUiF00
 n2CHHgmujsiW5knDHkH9sHBbMfHLFmJkCRDb4v6r3nGV7YvjS13bR8oSsX9z+NI3+NeI
 95bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694180548; x=1694785348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdihRmGVf653hvyytkSn9JMWlM4kTYEnM3FpjmKGCO0=;
 b=BkQiS1aeKnta5rg4mEjNmRgg9BJT6uIn/8h8zARWSG6+FpG/aPs4PYJ5OIN5r50+yP
 fKlFU/Yi9meie8YRk4UXv7Hm5r4G2bjJTSuGLa2VkCg0ViE6RGIBMMLNL/JfenVcXFzc
 htcPq9ImL47HwI+yTWhv5FB2uWICDsEyk3AhUqkYRRMrSzc6Z7cpkrsN2k01h0/2iqei
 kySuHYyJmRwjjRyXAHYHRMfIzTSZrXmFJGbO5CA9CKm7CEjeh8yBsWJ1L/UzCaxjYA5V
 q0EQ8dCMSSbG/UevOfwsTzHX9txI52GWsDwfZOHKAzzzGt9RWGMqy3drqpn7nMEZNpDG
 q9oQ==
X-Gm-Message-State: AOJu0Ywm/djwh/Sn34J738SrNiM7WsZLhG9kXZ0wk0j93whf6yiF0NpM
 wFXNCn+noWnBcIOycYxrbBAv0OA4d6CLuDsbknzTHQ==
X-Google-Smtp-Source: AGHT+IHPImvHhLvhuz9CMp+/tOYgBMBYd3C6anQqla4q/WtD1ChUx5WQO9tqrar6aj/ljVp0Q27EmCWvNPNbXIfzUnY=
X-Received: by 2002:aa7:c502:0:b0:52c:b469:bb01 with SMTP id
 o2-20020aa7c502000000b0052cb469bb01mr1821062edq.38.1694180548550; Fri, 08 Sep
 2023 06:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230831232441.66020-1-richard.henderson@linaro.org>
 <20230831232441.66020-5-richard.henderson@linaro.org>
In-Reply-To: <20230831232441.66020-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:42:17 +0100
Message-ID: <CAFEAcA-Yb0tn0oemVChWkUmQM4YavWQhSHiMDYY1=NNMyBQyNA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] target/arm: Implement FEAT_TIDCP1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 1 Sept 2023 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/system/arm/emulation.rst  |  1 +
>  target/arm/cpu.h               |  5 +++++
>  target/arm/helper.h            |  1 +
>  target/arm/tcg/cpu64.c         |  1 +
>  target/arm/tcg/op_helper.c     | 20 ++++++++++++++++++++
>  target/arm/tcg/translate-a64.c |  5 +++++
>  target/arm/tcg/translate.c     |  6 ++++++
>  7 files changed, 39 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

