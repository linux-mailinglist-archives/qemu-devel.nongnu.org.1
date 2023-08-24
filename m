Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAEA787521
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:21:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZD3N-00074p-Hg; Thu, 24 Aug 2023 12:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZD3K-000749-PY
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:19:22 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZD3I-00046Y-B8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:19:22 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4ff882397ecso10770382e87.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692893958; x=1693498758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eaqahD3Pv/BaTH4xQ70BxCZK0BBJwVqOquZQEtuY+00=;
 b=EG6N+hscK8lTHXeKccxaL0V3BHBxze5TgTnWu8oVQqthFKTWkLqHwzUtsNiDlLnVBK
 ohNKkCRRuiCnTG1orSrNVGZIL6oR0P48czsO+o6cRBZOARJGWwJd77amp8bmqH7+CNYU
 mOHi3XPOJDijZEbrMHUO8BFFGXHgMjxokvuXYuKL+rg36c7uNr8CxvXiRRh4cySUhpyx
 FqBhluEYq9YkKoBfzVSs4EDFVfPz4OilwcTwsoCVULaSYPfHREWLA2qBd2h0KprphVWu
 m5t7ZV426aaicIV0J058tMLeZ1LY/OdhNihn511NFfIkETiIDItSt9CVg8esNxaBavgZ
 JhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692893958; x=1693498758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eaqahD3Pv/BaTH4xQ70BxCZK0BBJwVqOquZQEtuY+00=;
 b=KVOqb2DhqAgCdthuOPMirzqGmbsBzVepbiJUBkqmsF4Zu87NuvqoHAXj3nGJScvEz7
 y7IGhUx/z7QGgZC25dXAIFLomh2MXhK9G6fnFVQay/1k7V5a7ygFiCaAA3YyNX04i+/2
 +bZU/tRprGQoauoVhGJYG+u4YCWdtcrixxLqIOdA9c8T776tnnVjJ/ieNDAKvXBJf5Ol
 nZbqGJL7jeF+TGojwhaF7/21PTsVR+r35Sg33QgtiDPTcfOAEHtQDF41aRAssR7mIAWr
 maFmMbpJ0JoHEwlk9IHl7OM2rqJO9+lTr5UpSq1a8Sk2r7ai4B2ZbbjgCbP1mLu+xX9R
 mXzA==
X-Gm-Message-State: AOJu0Yw9JBN7B1GFK2fSbedd3D7XvG2aurRAIag/oJ+ISbVQKshAD8h8
 OStpS1+ChEtE90IrwMY/OFjn8nNUa247bkC9AmPcTQENGcpBOema
X-Google-Smtp-Source: AGHT+IH41icN8LUYsLfef01vwy8ON5AZgcGSlhxJmsvweoCdv11c2aYpyPPzJKyXQ93H11rLmcMMmMTFT8+sjPWp6Qg=
X-Received: by 2002:a19:e001:0:b0:500:a2d0:51ba with SMTP id
 x1-20020a19e001000000b00500a2d051bamr1038373lfg.44.1692893958317; Thu, 24 Aug
 2023 09:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214031.171020-1-richard.henderson@linaro.org>
 <20230811214031.171020-11-richard.henderson@linaro.org>
In-Reply-To: <20230811214031.171020-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 17:19:07 +0100
Message-ID: <CAFEAcA9MMyV2zb5WPETyWokFU-tBNbFKhqHiESRWvWB5qK5nVg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] target/arm: Implement FEAT_HPDS2 as a no-op
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Fri, 11 Aug 2023 at 22:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This feature allows the operating system to set TCR_ELx.HWU*
> to allow the implementation to use the PBHA bits from the
> block and page descriptors for for IMPLEMENTATION DEFINED
> purposes.  Since QEMU has no need to use these bits, we may
> simply ignore them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

