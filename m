Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A93AB7165FD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:04:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40sG-0002h1-SS; Tue, 30 May 2023 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40rb-0002Vy-A9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:02:22 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40rV-0002wM-3S
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:02:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5148e4a2f17so6891852a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685458931; x=1688050931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WvRiAGwAXrcfflCp779qlTCaXnCRZ+XkL/ghHtaAr1M=;
 b=rLfJXhVL5WDRkoyAU9LUWewyv+B1crBGJyjlp8+ewtrFMM8wU6qJE9jO2v1wdMp3c7
 lTvIfIH1WGGCyVLxRG33GMLS+DKxUONlXVDIHItfCJdorjdq4zDnr08L1aVN19cHpW8q
 SJnHgQkkCxLbq4h6a1gDj42QnEBzL98E3IhdqtDm4cLxdJlyW0M99X9byUqLHOyPhnoU
 SVlDHISdgmhuH+CIZlJu90a4a6zbzWEmYlN6QAcMDodkt9NI1GH1R5/w2/N9GD5VNDNz
 xMYRM1+4iGzK21tgF67PGcN/wqEh0uTCRNvpVHoz+CGQOfACWOl5XtwfwLDJ7gmlKSLP
 lUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458931; x=1688050931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WvRiAGwAXrcfflCp779qlTCaXnCRZ+XkL/ghHtaAr1M=;
 b=QUbH6vkpu21Qv193gsJn2JPAsW0BscYPlZupXi72l6uVz/VCOv2wzFm2uL0ZaNfO7Y
 exW6PkzQ/qktwNSWOkSOBtljnR99yqHfHbeLFeC1hpqpzhNot9tsA9Cf2j97SskEXLL1
 z+a3jMiiuxmvqtpImx1y5yDJ06Iw2xqq5hQ+rrOgfBNiAFCXnV02C5b/Ch2iWOFJoMz0
 +1k1c2rc4buFWu36wvCd6TFTg4mHHkn2JPcvA+o37RJyKI7WYl4AtRgl9N80xXBvXtb9
 89Vkmf/z5um2Kg7v86rBlkr3ifVWhjWnNOAtau3fZ68Fh/sZdlmgCiSzWQsbScsKNeKe
 TlSQ==
X-Gm-Message-State: AC+VfDwgOV3wHsgyQlE4EwmzSts3yjCL5CvDbgcadAj4cJUUCuIcwRp9
 Zmp5/vgmkm/iq9KcufnjsHrnfEPrXKd7bX2GsaTIaA==
X-Google-Smtp-Source: ACHHUZ4OLCVKrfVtEAZGaijuk2iJiFLiPZZm8Y7Rbf8PH2BOjzBd6++nejhGq4OXF7+wyIETq/63t32cgi4QDI87UnY=
X-Received: by 2002:a05:6402:642:b0:514:960e:6 with SMTP id
 u2-20020a056402064200b00514960e0006mr2017955edx.10.1685458931173; Tue, 30 May
 2023 08:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-6-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:02:00 +0100
Message-ID: <CAFEAcA_bQFAqyS+9BTRZt5nEJZYThBRXuDCX1jfrgwLjybwxbA@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] tcg/i386: Support 128-bit load/store
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Fri, 26 May 2023 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |   4 +-
>  tcg/i386/tcg-target.c.inc | 191 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 190 insertions(+), 5 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

