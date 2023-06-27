Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B9873FC33
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:52:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8AR-0003J2-9N; Tue, 27 Jun 2023 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8AO-0003Ij-SK
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:51:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8AL-0003x8-PS
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:51:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51d80c5c834so5750129a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687870288; x=1690462288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o0L0dRE9bMRfCfCRYqs+jE+kdeiZ7fWkAOI/bfCX2sU=;
 b=dFbeQfKUJsPPzlymgn220SgwrwuMw+CBtZT9vVxPYB3mJQLRs1YJF+iTgUYd6Dxqak
 srB+tvKB4j2C+lmsHvP4Vcy6jVE70artuqC42BQkbJx0UinXtLHm5phZ6aSIov6BAJ3/
 IJ2iR+P5tCZ4RbWrGKwl3C30APvcko+Dqs+eZamS9gOSHNABf58BnhTC4vJ5CBd3tOR0
 hNbzDPqpqRi4TH5cVA4QkuJqCiXz7viATyjPjyqkAR6xC5TJn/D3hYjylAhuEx47j0RY
 6BqOhxWE9B+kxr1uaRuMq+lItGepCIx7WAaJAGXcqT7CcBpRXu5YFIrESYSzZSfCBTIo
 10bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687870288; x=1690462288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o0L0dRE9bMRfCfCRYqs+jE+kdeiZ7fWkAOI/bfCX2sU=;
 b=Hi0XuSEYJss7Z5XraEiZcSyqy4QhmVqDJyzvXLDOUeYCQhrzoBXs0eCMsJtfus5An4
 v4TRIZ9IjHlT8r1wi9s4OKY2/sBfPu/U7MCANgFyPBoSkNspeW23atJgo1YS52vQjJlP
 N63SdDpaMNgIxogqCRVC5TkKd+K0YYSd8YSTlv3adN9epAdR0vocOO5wq28GIRsquxOm
 +UVr2W0UIgTGUg23rhjE4sOcrSjazZsAPtoOwNe2/IssVvRGjjOO3AAiT+dy9/YzCbdn
 kOqRZ7siHpXPXlnZ3ltXXtxDjPhhmO+ZgbgpjGPzXv6AqPyuI87DrEhyg0ITAAP/bnbP
 CdUA==
X-Gm-Message-State: AC+VfDyX1K824dq4GglHh7RXwzqzSHUFWAZdG0qcX3XpMKxGjd/8OTZm
 NAjJhcywwefrHbEMt1gc+aCAPnj4dhMHo+zkM07nwaIA/ajtTI4H
X-Google-Smtp-Source: ACHHUZ4XFlQ/DD+colcJ2bVhTbF8gcN7Oh+bCV1nYifVC+udXxNnKyNYPeVBskaviZpb2hYZ8BXG4iZkCbx2HyJnyaM=
X-Received: by 2002:a05:6402:5241:b0:51a:4d22:dadc with SMTP id
 t1-20020a056402524100b0051a4d22dadcmr27235833edd.12.1687870287991; Tue, 27
 Jun 2023 05:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
 <20230622151201.1578522-2-richard.henderson@linaro.org>
In-Reply-To: <20230622151201.1578522-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 13:51:17 +0100
Message-ID: <CAFEAcA-t4=HsmM_XCQx0uEDzA-Ux+RYx17ySvimiNgXqep3Bgw@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/arm: Avoid splitting Zregs across lines in dump
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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
> Allow the line length to extend to 548 columns.  While annoyingly wide,
> it's still less confusing than the continuations we print.  Also, the
> default VL used by Linux (and max for A64FX) uses only 140 columns.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

