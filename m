Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B0708563
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfyh-0003fk-V6; Thu, 18 May 2023 11:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzfyc-0003fF-Eh
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:55:38 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzfya-0001F3-D7
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:55:37 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-50bcb229adaso3993300a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684425335; x=1687017335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cx1WRH8tnC3hd5LSstBhjt+dKnOjEhVJn6KZV0T3/zg=;
 b=Q9AXP6Ej51+bIerBodhsa/ZKRlTlPM+gOCHmJIOBJHVxKxMsAp4hpbXtG36lfB0PR5
 Jim1YZ0kwMvB5If4CMYYGcoODlUPvvWe8jVRVhbrvW/pzfUojE/+rm70gBvnyBSBSWTg
 KLwB6TXqiuEatc4Kj2cpmI3hD1iKdJuXSe+gDluyXVvyXTvGA6Ib+L6wwSNh3GEv3nGU
 wss/xj9HtmoJBByQwFNDuYGhNHPq+8/R3nmkMIM5Z/L+7YZu751+aAmUmY8nOofTZu9d
 FdsLhKqWvNPdLNokn7YNP6Ly2Qu+saTZLelcCBQJ/Bg4LfnocDMcMo0bccp6xyrLKSKG
 IDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684425335; x=1687017335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cx1WRH8tnC3hd5LSstBhjt+dKnOjEhVJn6KZV0T3/zg=;
 b=WcHZ+RV7CSROH0FpRetXUzKCqvml2xjKvZw5jyz93uVRFHzxHl1iABJ4ZqsgcHdbf3
 U+2BexwYXGvkbxpCz+OKw6wnn3nD3EK08cG0RqoYtrZ7uEJs7ZmjOOwGaV0h54Wt2DKg
 cEirgrGKWy47xAwVBo3vJNzGsc4ZmGIDurXZi//ypKrd/+dRL+AbjAGXRZ/p3JinfEQQ
 1qsCSsfSlyHsdmQuqHdccvMSddtX/JFGYcTV7UKr1lggYlVlS1St3vVEKBJ3DTSktv2d
 VJp8vrr+lQ55Zbl3VAKYSR5fYiTRanFNJRcvb33MBHvGuc9ZJf/4TLg+Q5hvp39dzFDa
 GJtQ==
X-Gm-Message-State: AC+VfDwWM+QTk8SjS2JVdOpWI/LV0+A3sTDjrBMN6eZBYcawy1VoPNFk
 IHznV1J64iXJk+zIFcuUvtOEtfUlk0wtJKaZzFujfQ==
X-Google-Smtp-Source: ACHHUZ53/oXB3b/0a5QmpPEmmg6QfjGRhe4MKOEmeAeP2h9o5ir94gtfq+20IVpGjk27NXb17qbu4Z8MlmFiSojaIuc=
X-Received: by 2002:a05:6402:1050:b0:50b:caf9:4b85 with SMTP id
 e16-20020a056402105000b0050bcaf94b85mr4783867edu.18.1684425334744; Thu, 18
 May 2023 08:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-10-richard.henderson@linaro.org>
In-Reply-To: <20230518044058.2777467-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 16:55:23 +0100
Message-ID: <CAFEAcA85PzSBtyDMEw9wwtd-R7X8Sswf3SoBsQPXXK2hWTA=VA@mail.gmail.com>
Subject: Re: [PATCH 9/9] util: Add cpuinfo-aarch64.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Thu, 18 May 2023 at 05:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the code from tcg/.  The only use of these bits so far
> is with respect to the atomicity of tcg operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

