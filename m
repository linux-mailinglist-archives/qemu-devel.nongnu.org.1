Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B9729756
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zew-0001Qa-8I; Fri, 09 Jun 2023 06:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Zeu-0001LH-Dk
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:56 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Zes-0001FG-Qe
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:56 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5169f920a9dso3584337a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307673; x=1688899673;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SjrKHZRw5MDSGFKiEkN6qciN5iHax7Z8Vmz7MzHCH8k=;
 b=DCdRcAQnzK1IjV2kH8rpv+3GGJizMSl5lHNF1jKlCigtiu/9/V+VtFdb6KuCs5YeVX
 DgiA9t7LlhbOibbJ0/1v4XlXotvw9wwUHDVJ6fHKTFTjy3ySX+GNY3m0i0xzSlhaPs4G
 torcOqoQCH+Ah9BEA1s2AMaXAFTv/PSm1ZahNAm6yTXsaUP9HBTT3af8+hXO64yuQGjU
 sdrRu4/NwInHVUR3vWuUvSoNVHCLhg/RF6w62BJE8v3ARrGVpGKatFpijdL+VDLg/DjR
 pD+7P2hSLEQEGPmGYGcTiJpyv5M61sIvbaxE3RgTDxOlPtD9KrDqJcaTSXxQftY2yfJT
 Tl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307673; x=1688899673;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SjrKHZRw5MDSGFKiEkN6qciN5iHax7Z8Vmz7MzHCH8k=;
 b=ZxFnRUxz4ENmJtgrA2sCsGEUg08znspS2pc4XXF5CQgHxoxegCGahT3JC8jJfFiMgS
 gBZVbnhl9F0aLm0SeLOEfDL7NSpdghMSoYl7tOci1DJ5TRNYIq2NPnD7AWFbr6AQTZle
 3t8tkC9zezSAgerD97DdeI8jTIHQPJLM66zeukYuiBB17jRj/AEM8ElnROtBIe+qXN8Q
 5ssfl+0qOkSL/vW07rmciyNoTMM6WXxGRCqNwGy5iV59jArTfy4kLCEIV1gG5RaRd5wT
 pQkIsadpDQ2L+63UWjUSromPaay9aCkhJxqfSfgQoG43gQJuViTM55gIDJkkTEyf2Y8X
 YR4g==
X-Gm-Message-State: AC+VfDw6daoM5EJb6TaJohhcDutykJHsAg9a89qzYtHpNWqCC+B7gVKQ
 YKLlgR9+0pT4BImQ5Ig460xWjPU5+fzGyzfIF00eO9Rm8XMV88UO
X-Google-Smtp-Source: ACHHUZ6OLlXAqRgtLN3I99wYJm0Y8iieUwY/VBVSTURBTv7QhIVlhxgQmfZBcn9i4+sinBCsmmokD72ixP6/slB9Nh0=
X-Received: by 2002:a05:6402:254e:b0:510:e8dc:f2a7 with SMTP id
 l14-20020a056402254e00b00510e8dcf2a7mr4698330edb.7.1686307673228; Fri, 09 Jun
 2023 03:47:53 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Jun 2023 11:47:42 +0100
Message-ID: <CAFEAcA8CsmTHXDf80fP_wAXG8_5J-AUeJqMRH5Nr23cF+ST8TA@mail.gmail.com>
Subject: arm: couple of finalize_memop related oddities
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

I noticed a couple of finalize_memop related oddities while I
was rebasing my decodetree series:

(1) in disas_ldst_reg_imm9(), we calculate a memop, but then
when we call gen_mte_check1_mmuidx() we don't pass the memop
as that function's memop argument, we just pass size. Everywhere
else that calls gen_mte_check* functions passes memop. Intentional?

(2) disas_ldst_reg_roffset() and disas_ldst_reg_unsigned_imm()
use finalize_memop() for both vector and normal register
loads/stores. Should they be using finalize_memop_asimd()
for the vector versions?

(3) disas_ldst_multiple_struct() and disas_ldst_single_struct()
use finalize_memop() even though they always load/store
vector registers. Should they be using finalize_memop_asimd() ?

thanks
-- PMM

