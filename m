Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A2703499
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybO6-0004fj-MV; Mon, 15 May 2023 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybO3-0004eq-OO
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:49:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybNo-0002xP-A5
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:49:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-50bcb00a4c2so19980540a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684169350; x=1686761350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jg6bM4ztTQjpSg/eFbvzy6w9qFybXzN2Ynr+LYIPO0c=;
 b=qjEdJXudTpGSPmFqH8QQLqKSR6zokIdMasMiB1Ui/87CMLeC9OLPWrTzvNgEHNa2Hv
 dnzTrwfeGvKee1sj+rrIwhOk74UgL+G+xJ2vSyTij7gDvpmXWXmkDubeeFJMB35ELvZu
 4nEJClZ1K0MY+MqurKvJgLSYy2ckDDoqX6CE48Qq4U1jvJpm2+5j8+wgPgV5Ct1Pt8G5
 z6bVMLLSTXtl92lL7FRcEicUrQp0a6zhwZUY4XQo76Tgb3GCm36PZWKnQgcW3RB6g48t
 yMbSUIHasIcxZ17Uy3dgXXp0ITRn3oTYKaUDKV2mlaGzFFv8pW0SzKOX7wRsKa/8jXYb
 xMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169350; x=1686761350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jg6bM4ztTQjpSg/eFbvzy6w9qFybXzN2Ynr+LYIPO0c=;
 b=YxpuFTBqX1OZE5YIOnb95ZtHH1dlT04kboV6EOQpZL9fHR25l7BXVibRyhqHPE7OPm
 ejPmP7l4meHA1G+k6Mt8ZzPARycdi9u2PsEIhwIrN//XBINg8Agl7RDXL5iadSZmEwKS
 mB3jdgi7CaVvOpltvTeGHZ22RUNSFi2nHnRNzDcFzTLpSO7oOpGaULXSjR9NBhcNRVQF
 N+XT54eHeNAYuu5M3zX5zaVW6/efjzaT6VrMWZtvFYs61OmkaS2I9ihdBhbJ485cqPUQ
 Dl0OOuREjrx9ZE8lsapzTsc6Gx68s4tY3qh0jV4S5+AhCdmUWvPrPRxDTyy4CZlLaVAd
 rC0g==
X-Gm-Message-State: AC+VfDw7iDPAo8Nw/1gSjommm5rQNVkpzww6ZpaXCDCNlKQqGG7mKMQd
 osZXeAvY2PLM5Gu1PuIyqA6PwvZRVbQ9dawnMtBbWg==
X-Google-Smtp-Source: ACHHUZ4icnNqLCJGA4N6iBhVubItM1qBpbb1PB/gg3Bt8iF5IjtVUYGFybhrfRFPZzUBZIA5MDtnjW3TeGUR46NMKic=
X-Received: by 2002:a17:907:6d11:b0:969:93f2:2593 with SMTP id
 sa17-20020a1709076d1100b0096993f22593mr21607526ejc.27.1684169350604; Mon, 15
 May 2023 09:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-4-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 17:48:59 +0100
Message-ID: <CAFEAcA9TeEWiqxQsMvbGsX2ctUSZD8OabFf52QkTuv0XtSL3rQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/54] accel/tcg: Honor atomicity of stores
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Mon, 15 May 2023 at 15:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Dropped r-b because of MO_ATOM_* reorg

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

