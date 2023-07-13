Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0D775215C
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJvZv-0002ZC-IE; Thu, 13 Jul 2023 08:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJvZs-0002Ym-7T
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:37:48 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJvZp-0006SZ-IM
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:37:47 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51de9c2bc77so828784a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689251862; x=1691843862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gL/LdaoJcBAttSmAtcelE+5BDRZoiwbHADWdnscB++c=;
 b=E2xARvcJECYMF+Yg8w3l9+bdTxJ/q2TLLGMkZ1BHUTIvqZRYIzuhFHxW0iApXVyOOe
 p1ROz/uXHli09aoAhP0dDXOfpsEF0pf0O75+UESgB+7sOn1iL8cuXL+Gwm62U5Gbi0nK
 Slo73zPEuXQI//HpkXQJ1UbRuC06Ijt87pUU7RF0jbgwh5VXDLlWV2swEWGxC0ZePN3Q
 mnRGWeaEhP93B6Jl/IoDKelrABdVu7aNyBpS8g0DzK68nJLjwaSlKx5jieGtcJQdjQn+
 oujiBN4+PnDmuFLFodBQaJP6rpEzuSeYgLhNLxmvVqGs+upIz4TgSM0ygCuS4EXpY/Qp
 3kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689251862; x=1691843862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gL/LdaoJcBAttSmAtcelE+5BDRZoiwbHADWdnscB++c=;
 b=NhgVm9aX5vNBxADdbIZ1p7MK29UFIWaJL5pWdPrei1CzhzaVIIthXieEy7GOBYxklJ
 FcIbnkolcYZtQwHXhtC6vggqHUYqjWYKp7oX8+9P2w3t6b1sXw5wUga93kX+/mLi/Tn3
 0bND7mCxtR/adb58mM4iEr0vsslenCJ/PHbGKa4VVb2Ub2zuVB9XSSnTivwoqtsxiuGl
 8wUPpCkWU6nMa2MDYonAv0OlzTtELEgnvacp2uV0sPDG8gmsNv5C1wSQokBheaa49hRp
 FSWnlun3nXCPJK1Cog+L8KFyy9c84uru/r/MlEXHPE3lhrtKAz8r06d69RKx1ufZEK0y
 iIYw==
X-Gm-Message-State: ABy/qLaDdzX4LYXBbRRIPYTFw2U4v5vQSnhiN0sPuB4wdd6onL31I9hF
 hsEnHkt1RRFXSmxQIPWGV76eB190NlPhzaVOizH7+FXCb+W7PUKa
X-Google-Smtp-Source: APBJJlGCro/DJzoZMh8ABzEwR1fmYcHenkBrY2JY0PHWQhajwS0OFGJ/fbamEw4G3k7N2tR2QA1jeUnqpx/KPm2xQjY=
X-Received: by 2002:aa7:c60d:0:b0:51d:9195:400f with SMTP id
 h13-20020aa7c60d000000b0051d9195400fmr1648088edq.17.1689251862509; Thu, 13
 Jul 2023 05:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230707102955.5607-1-richard.henderson@linaro.org>
In-Reply-To: <20230707102955.5607-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 13:37:31 +0100
Message-ID: <CAFEAcA__75U_DmeNT8n+yBaR8jfKynMoToWhMj6Wb2VorNS6aA@mail.gmail.com>
Subject: Re: [PATCH] tcg: Fix info_in_idx increment in layout_arg_by_ref
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 7 Jul 2023 at 11:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Off by one error, failing to take into account that layout_arg_1
> already incremeneted info_in_idx for the first piece.  We only
> need care for the n-1 TCG_CALL_ARG_BY_REF_N pieces here.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 313bdea84d2 ("tcg: Add TCG_CALL_{RET,ARG}_BY_REF")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1751
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Tested-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

