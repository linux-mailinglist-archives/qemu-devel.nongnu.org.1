Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DC9766EA3
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:46:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNLT-0007Dx-1H; Fri, 28 Jul 2023 09:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPNLQ-0007DQ-7f
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:17:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPNLO-0003sa-40
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:17:23 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98e39784a85so718591866b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690550240; x=1691155040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFbN8q9s4W5AgNtxdnnEe5FyvzzlnPyKwbHX0ggSmbA=;
 b=RSNEGJDUbI2MY085SAOHyDtcupGzld6MMVCEbA8XHBH/XZaskXk/WsnuDN6sEXUymF
 g7X3L3h7RmLx1X2kgAfRW7CWwOwosyv05Y/MZVHjEQaAtb1ej36b59ayLO0tozvuTh6s
 6cZlRtHBO6JAsgZ5MdcVBamN3UtSsnXRdcjtuLnzHsa2U5OtBqA/cMARaZ2BknRahxiB
 9zE1PgjWxU8AHPfDj+PgAXCPa0j3AJsWLdhqlb40YZJAc5D11zk1EWtptY1PU5ljVV3N
 s8i9alcrZN3lWY2vztLQW8GEx5BKShPJHCJwCe38IoZAhviGpl4sFGUN19QH7tc6NWtY
 LcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690550240; x=1691155040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFbN8q9s4W5AgNtxdnnEe5FyvzzlnPyKwbHX0ggSmbA=;
 b=caD2Scl1vD65X3NCZqoUax6oiNhPdWVELFS9yP0ZQNyZ9zzq7/yvUBYELNOMWVE3Mc
 zHyiILU/avWVyd8cjZscHvCF4uB2zBfTtNtySlogl44RH6OipDnQrKq/SXOLImWuTfoz
 hYOy8bWr0wWxQdf1R+Pmr3pc+PfFI3urgeFX5dGrSo6BAZ9u/AXdNNLTnoll4MWze6p+
 S9lECSjt0xfZTwICYz2u9GmGvFheFzEp2m0rwwNZuGIsPpgP2RkDuvXL6a5+i7F3PFzJ
 Tbrogs6I3OO3RmJP+JjneYxtGAHlHBE6+R82fY8QaY2rpKcrW0mTTNCefTJoBn5hPQ2d
 XTww==
X-Gm-Message-State: ABy/qLZcp7eW2TDPWNBZzucEe3Mq5Xn7MShqq/Zr4V1MzXMlLcrBmPFp
 4jPcmy7ActTbZ6ImXkI0geQnrq934/wSNRYXTLYe+Q==
X-Google-Smtp-Source: APBJJlFE6Pezfxd7weBOnFHurey+bc1rXc6xxYLNp+hxU+oFvlAnnRRjoa1hk3cP8cFtR7pDh0pHZgywrXSug+GK4qc=
X-Received: by 2002:a17:907:3e0b:b0:994:fec:e1b7 with SMTP id
 hp11-20020a1709073e0b00b009940fece1b7mr7215592ejc.0.1690550240326; Fri, 28
 Jul 2023 06:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230727162621.445400-1-richard.henderson@linaro.org>
In-Reply-To: <20230727162621.445400-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 14:17:09 +0100
Message-ID: <CAFEAcA_oycCzi9ucp6njiZMs9puO_pshY0xDgT3ed6KQZP=bKg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Do not use gen_mte_checkN in trans_STGP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 27 Jul 2023 at 17:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> STGP writes to tag memory, it does not check it.
> This happened to work because we wrote tag memory first
> so that the check always succeeded.

So this is code cleanup to be more sensible, rather
than a guest visible bug ?

thanks
-- PMM

