Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB025778ED5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 14:13:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUR18-0008OE-N2; Fri, 11 Aug 2023 08:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUR16-0008LY-0I
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:13:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUR13-0004Lc-4K
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:13:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so2413712a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691755995; x=1692360795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YQrYePtzB9CE7rSQfMEhjs/n92b/nORl3809bFHFByo=;
 b=Mef8+DEHn6KxV2gD8ZNvsiYgcvi1Ct34cjzOZDukgFWoIEXdcwm9N+uUQFayACJX0L
 8M3oEhY2xaB6ELUQ501qvzfqR2SvYiePNVpojjelaSVayRnpgvKSdYk2a9sB9nxelzzC
 ho2judO/JSTcknmukx4ToDmjhkrgB0YrZnFzepXZ1dxosFi7sWVQ/GaYxZSP9DFWc3Uq
 t662Q7Oq5cvPWa4ec4NcV6C3D+uR4xUGzCPRDTkgD/kqpoTcRLke3144agoX8AzcIqXw
 +cEVrDCyAopJjAOZFNV/Q3uY+6VS+RRReTH0ffeL+S4n3eSnSE3rw3IptzN5tNWDs6Hu
 TP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691755995; x=1692360795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQrYePtzB9CE7rSQfMEhjs/n92b/nORl3809bFHFByo=;
 b=WR4azOdcFE4caXBwF4qqI/AQoG+HPbHEV3WYZqEmZbSB0oZOpPYc3jdVjS4nYKNjFY
 T5wcsRQNdncjgfQ1jm1LPF6CKLpbr7RvvkVi2Zql5yD2KVtTPDTLf+ssnSFrBs64PgQu
 bCpdMnBfNrlA8pjoxdEVoNQTeLp7xRnvR1GdabdEvDsSmMPjmyHpJ9TdLqb5fWoYYfyY
 H93vC2BIUwBhMu6pLkm5HSdIzSwkiTFKp1Rp6VYI+bQHOosNABvPfmsHdilzBUuJ2D8J
 UZ8O74qpyu2qpuYlKBJxs5mBSlAIBeu4lJZ9tg8wafenlpiuXkJEZ/J0FYiJ+YGOdivb
 wfVQ==
X-Gm-Message-State: AOJu0YwIlS+nSeiKJiIE2AuOeXaURFfKlZIj3w+s9WtaDgzLLEznCwPE
 GjfwQwyHmHwlJHDWgylrEXrkY1T+VAADd2HKcKKzRg==
X-Google-Smtp-Source: AGHT+IFHgYz06MHGeOs8U9jo/Cp/1YSy1OkmdVwIDR+itXP4Gvm1euz9PzxgG/xIlRX+bXvXMbPWQO+B7xC5dCP9eR8=
X-Received: by 2002:aa7:c0cc:0:b0:523:100b:462b with SMTP id
 j12-20020aa7c0cc000000b00523100b462bmr1499853edp.5.1691755995108; Fri, 11 Aug
 2023 05:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-25-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 13:13:04 +0100
Message-ID: <CAFEAcA_HUQSyJfT9e4RxJq5CxUDPH5PJpPGV=M+SQV_QfdSfcQ@mail.gmail.com>
Subject: Re: [PATCH 24/24] tcg/i386: Implement negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |  4 ++--
>  tcg/i386/tcg-target.c.inc | 27 +++++++++++++++++++--------
>  2 files changed, 21 insertions(+), 10 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

