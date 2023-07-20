Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7175B431
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWW0-0004KU-Ep; Thu, 20 Jul 2023 12:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWVz-0004K6-0u
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:28:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWVw-0003f7-J7
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:28:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e56749750so1372398a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689870506; x=1690475306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NmG4z32DKSrMHBIzEuBhLqUfjW/cR/ysKSc5rHDmPNM=;
 b=Tn9hholpY9DmEQbrqfqM3sSiTQiYYKHo3vLEYM3gsrUifodYq3/ncVgUCeOyP2jAr0
 010LZdTRIjNheTCY4r4Fuw4OaCAiR60+YI2dEiDVtuf+LPg3xn1nElBTBvrpPWfcEDPm
 HbpSDA9mfYG5vechdR8lZIcY5X33J1vEmJ8kFNqjmDDHyDhiiAojBYhniUlYI7RuiOtV
 jo2mih1E6Zbr82dMAYUwcd5IuQnZZZ0tr/Hdz+jdd1AVZoQU12k4Ry2zrBPoYGDifxHK
 y6sysGa7C7sElFRWecdB5vRsWhfTttzz++EOVPmbdvlGeJrOJIdurPsyBAzo9AMkms4D
 4bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689870506; x=1690475306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmG4z32DKSrMHBIzEuBhLqUfjW/cR/ysKSc5rHDmPNM=;
 b=KJ4yQ5Mq4hojoU+NIY6RJFf1oPNuILCq5sUaS8GFtmVXP0cSID8896VCSBpMYTqSB3
 15mQqHojAGGwR66b2jC5FPg6CCeqvt462SjqY3KBFzInJRmex7sB1WrdGZ8HN945PXmG
 QHgM33SF3TK41ZuqUeE2EtPKf3FD1pi7gQtL6ECOiHJKZJEQQpl5a0flfnQfkGwN5QVD
 Ha9cRqBJ1hVaL09dWKcoJyBPBWVLc6sSSNMJXpcrcafJD19Q/T+MYnEybkax8nH98nPN
 qD2Hyi+yAs/qo3B+/cBya3RO7i8zGd/z0TN2+/K4awYHbxANSvNOyILfVz7y74oQJfFR
 1bHw==
X-Gm-Message-State: ABy/qLb0YNwY5i9sw6CgJjGRLmX7YS0Y39jmPJ12Pyiin/RksUcau7Xu
 zQzWJM9s1/ABrP3vXZ7kI/ZVv7sl//gRx8kpbDMHCA==
X-Google-Smtp-Source: APBJJlG7dK6iHavjpYiSQ6IgZkb2CuIdtEJ7UDXkGBZaBVG6PLqRDud2Z/0oyXP1w3bJSwGCKc/kpIciFOwLiZop5ug=
X-Received: by 2002:aa7:d54e:0:b0:521:d770:4753 with SMTP id
 u14-20020aa7d54e000000b00521d7704753mr2145797edr.13.1689870506685; Thu, 20
 Jul 2023 09:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <20230719153018.1456180-3-jean-philippe@linaro.org>
In-Reply-To: <20230719153018.1456180-3-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 17:28:15 +0100
Message-ID: <CAFEAcA-qPRSrLievcUZsCJQ3MO0AzdfrkMM6gs+PHK-mZq51fw@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/arm/ptw: Load stage-2 tables from realm
 physical space
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> In realm state, stage-2 translation tables are fetched from the realm
> physical address space (R_PGRQD).
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  target/arm/ptw.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index d1de934702..6318e13b98 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -164,7 +164,11 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
>       * an NS stage 1+2 lookup while the NS bit is 0.)
>       */
>      if (!arm_is_secure_below_el3(env) || !arm_el_is_aa64(env, 3)) {
> -        return ARMMMUIdx_Phys_NS;
> +        if (arm_security_space_below_el3(env) == ARMSS_Realm) {
> +            return ARMMMUIdx_Phys_Realm;
> +        } else {
> +            return ARMMMUIdx_Phys_NS;
> +        }
>      }
>      if (stage2idx == ARMMMUIdx_Stage2_S) {
>          s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);

This isn't wrong, but arm_is_secure_below_el3()
calls arm_security_space_below_el3(), so we kinda
duplicate work there. I think we should instead have:

    if (!arm_el_is_aa64(env, 3)) {
        return ARMMMUIdx_Phys_NS;
    }

    switch (arm_security_space_below_el3(env)) {
    case ARMSS_NonSecure:
        return ARMMUIdx_Phys_NS;
    case ARMSS_Realm:
        return ARMMMUIdx_Phys_Realm;
    case ARMSS_Secure:
        [existing code to look at the SW/NSW bits]
        return s2walk_secure ? ...;
    default:
        g_assert_not_reached();
    }

The comment above the function also needs tweaking
to say "SCR_EL3.NS or SCR_EL3.NSE bits" (we do already
do the TLB flush in scr_write).

thanks
-- PMM

