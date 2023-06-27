Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDF73FC32
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:52:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8At-0003RJ-Lp; Tue, 27 Jun 2023 08:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8Aq-0003Ou-Gd
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:52:01 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8Ap-00044D-06
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:52:00 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-98df6bc0048so402916966b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687870317; x=1690462317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+U72R/TXI7GLuOHXVD4jkY5X8nsBntPKZIYDXhuUoEo=;
 b=zaJxLC6TvXt7QiVmtI3NUOK4SAn3xJS+L+7zVUE0l3rBpQ15s615d/FAwegPENfp8M
 xn+cJf9BDMx6Dw4gSfcA3JOiUWjvlZS7TksEJXPAFu04twecjabymAuWSfQ9OwkcPtic
 0Py4TRfOf+yff0xIFbk8V8WcxDSoVXkMNOSOYnET+az85mfWQ5m+IwELiRi9coUw6oHJ
 e/EtTESafbWSK/yto+FSdhq6BprpyOO+Lm+T1MXMtb2t3I6VcJM9pAz8ts0XrCKK1iE1
 GwN+2Mg8RqnJ3UhCIp0e9fZRPofHROFlaSuKxMiapZy8HW3kTf27d4MZheMHB+LY3MtO
 sMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687870317; x=1690462317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+U72R/TXI7GLuOHXVD4jkY5X8nsBntPKZIYDXhuUoEo=;
 b=guVqtHZdsHj2st22dZn2B0hlYF188zhYA4fynJlF1Q7Xa/nk9gp10q4tV2weaF3nMv
 11O/4qudw/xcL/TE/cEC9BRBNa7HdSefqwKmg4RJW5lf1sbsY62rUs4MoS69JB6n/12n
 Dl7a6GZgPJ1u/rk/Im11nhd+gy/aeDa3F3P5s4kWmGolgn0Jyy06QFYYQmK66rn2IHEU
 kKr0Owv1QfRJudN0sv3O1bKRDv6v/wIdTSeU3OZPfZ5aCbvnHGL0ECdwsxmP+OKhCmSL
 8tOC7+NmVXvf+Aa8Oj5iOz6myrH8BlPWCde6WBP23k8zzWX1wSbBIhrbIpndjILAQDgi
 l7wQ==
X-Gm-Message-State: AC+VfDyauJn8yRNCZRCISF5hMq6gKfkgIyEV+pF41baOXxMCQQQIKB9U
 Y7VOn7XKO+Wo0fdjT+M2CH+xUtVz7ii/GQ9HwnLbMw==
X-Google-Smtp-Source: ACHHUZ77S0p/+NixSMYigOaR4K2PbHuQMDJF0yys5DtbDCGteriohrvLipcFCHIXO/CwgeIFYdk16nTJWYKFKYJGNrA=
X-Received: by 2002:a17:906:4fd1:b0:973:ff8d:2a46 with SMTP id
 i17-20020a1709064fd100b00973ff8d2a46mr28239901ejw.3.1687870317489; Tue, 27
 Jun 2023 05:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
 <20230622151201.1578522-3-richard.henderson@linaro.org>
In-Reply-To: <20230622151201.1578522-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 13:51:46 +0100
Message-ID: <CAFEAcA981xiHPn1mn38pHMqRbQB=j6jWX5o3xh-DvmfbMR4kYQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Dump ZA[] when active
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Thu, 22 Jun 2023 at 16:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Always print each matrix row whole, one per line, so that we
> get the entire matrix in the proper shape.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

