Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D698E7987D3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:28:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebWs-0000ug-LF; Fri, 08 Sep 2023 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebWp-0000uF-SD
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:28:08 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebWk-0002C3-FS
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:28:07 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-500cfb168c6so3369513e87.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694179679; x=1694784479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oLwjVo8aPSj0C0V/pn0VoLRRNC4xP5+LaC1Z/yxQsmU=;
 b=s7SDuBjdGwYc46hDbQ7PDIo20/wqI7r2HnhLFW7T3DBTCRXAv8vx0f+YSKK5X7KlYR
 XlJdOzaq0oYL0rWTMZahz0wqi+aajrfh189CeeKXBwMuQR3moYkXb8PmZFytFpPKAoMA
 JZVDrW2xpJEYYV/SSwHIbRqXPGwzLKyrEFeu1c09EqfeakBz+yHqrHhKCf99PXwZS17i
 T2qV4QhBtdOHLUJPPhQIMDURgsQnYcDnKlBlF7kmQJ6tXIDB923z5UagiZPjQj/sojWq
 0vdI4NERKfFsCZEjmfJLTW0+algTjHh0zndFe2ebk4S6Sy+t2o/g49EA/K5r0hjKPN4f
 glUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694179679; x=1694784479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLwjVo8aPSj0C0V/pn0VoLRRNC4xP5+LaC1Z/yxQsmU=;
 b=BDiKJV2WcoaedU46uvDGDhSaujPonzhjtYwKx3r6jXtYF+sr8jt/lPjJWUz3o9Ry3a
 GsmAVL5apnLjBU8qhWwmbxOv9uaZvnXgMCri2hHJsHOcy76ZK45MglLY67ZBUihmNYGo
 TFK8X0wad5JFB4EjVvxsyqBOcCh4ThcMoqSm0iUoJdcXBHfmb1wREBySwZJM7wINjQpF
 yOCa7Z4uX5h37vIPyOqpZmDOR8znj/8tNfi7+6bIr6o3Lgain/GrpfTUMCVievcnpX2F
 SJYzwTAj8LQQTyh+LEmWZkVxFaCtX8ort0osmOdp1YZjjwDeuntFnW18huw8SLj3uemr
 +10Q==
X-Gm-Message-State: AOJu0YzFuVYB8KlxXI4CLJPAarqom0DJ2KkqRjtNa1d8pFxxtq2q/tMQ
 3G3E0raFw4rzvR4K9MJnGCPfGDezpqJFSrdHt1OPXA==
X-Google-Smtp-Source: AGHT+IGqncpvZa2rMjGowFrfQNx2Rukr7/6u5ZgxjVhvu+jjSCGGVKkRTzaZ3ymHznE6VuPOsVJ5gWFDEX+A0+UllxI=
X-Received: by 2002:a05:6512:3b9e:b0:500:ac3:dd77 with SMTP id
 g30-20020a0565123b9e00b005000ac3dd77mr2162549lfv.10.1694179678953; Fri, 08
 Sep 2023 06:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230831232441.66020-1-richard.henderson@linaro.org>
 <20230831232441.66020-4-richard.henderson@linaro.org>
In-Reply-To: <20230831232441.66020-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:27:48 +0100
Message-ID: <CAFEAcA9ZcaHwq+GFT=z2CTw+MLnMxNrz810CzQyTvEznhZbf3A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] target/arm: Implement HCR_EL2.TIDCP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 1 Sept 2023 at 00:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Perform the check for EL2 enabled in the security space and the
> TIDCP bit in an out-of-line helper.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  1 +
>  target/arm/tcg/op_helper.c     | 13 +++++++++++++
>  target/arm/tcg/translate-a64.c | 16 ++++++++++++++--
>  target/arm/tcg/translate.c     | 27 +++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

