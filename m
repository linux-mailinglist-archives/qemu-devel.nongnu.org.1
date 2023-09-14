Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 700077A090B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoCU-0006Aw-S7; Thu, 14 Sep 2023 11:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qgoCS-00067d-P6
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:24:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qgoCQ-0001eQ-UM
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:24:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-404773f2501so1442255e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694705049; x=1695309849; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6sakCjyOjzqHhR3CcEqZlqRPiVTdIvwbyRiiVCqWrmU=;
 b=LwEqWrppcfSHMMlS36z9NmN9uWOe889T7KIG0Rzf3EZntaKAIPA6qnLg91TBH5FhFn
 Y8Fae1c7NYvI5i55KiVxwgY78IWdbC7cBYbjFBsNb4tkbq1OIa7sEuGK1q2cmeQA/R1v
 iaRTk1BVhQQbJ2cKU8NoHRWaB9BOlujIk/5q29cOxeIYY/yOpKNJ16agxcKeQaIvSIBL
 gQuJ2MUbFJU1/KSxjS0aqv8gBO0eTsa8jh36eeCg6Dt1Gz9q8BYG7abSURE4nQdcVDd0
 w5Nuwx/oqd46mxLkrNxER6Xbd7+0kHM0dAeVHx1wFNZorWiW4Of05Qp47lpDHGJwF8Hj
 pNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694705049; x=1695309849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sakCjyOjzqHhR3CcEqZlqRPiVTdIvwbyRiiVCqWrmU=;
 b=njsc+TBM+Ey2PSJwD2fgzBQmp8xMBTKvczwijdSTtm2A8yZEBgnP2DU4rhUdRvIn0r
 VHapFve2yREEk7BaroWFr7HAguBqNpTyDZjSgFQG3XpFDut30HvGdjmGFhYhyViNMiBf
 Qf0Uok9USqWdaIx5SZgDsK4ZgLaN0y0XzerzJme6nAazYajpDkM5NgXYTfPpZ/YGjLDQ
 okecyXisnKB6v9kZ1ptPX13ToQ7h/sJTXXiFDjH+2DxolbB6ua57iE3S9KVNASRbFvsz
 S0cisXdS2K1dF7OcbSD0cUQgWWj03Xzgz3VGIjnmlBBMDCOQO4KPKxrnaXjSfcR7uFb9
 v+vA==
X-Gm-Message-State: AOJu0YxoUybrb96wDkoj0YLWIwrATBeQPHxRMFO3+g1WaKH3jWsOyWVs
 CFkXMHP9utaisxwXr6l/nEm5jw==
X-Google-Smtp-Source: AGHT+IG233p9Vdz021pVsPgNKU6wr/f3oR4Eul7tUikEc6PZ2w8OqjnlHjmwn9W6/zsraTpVIy8DNQ==
X-Received: by 2002:a05:6000:1846:b0:31f:d95d:20a6 with SMTP id
 c6-20020a056000184600b0031fd95d20a6mr2571981wri.12.1694705048839; 
 Thu, 14 Sep 2023 08:24:08 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a056000004300b0031fba0a746bsm2056808wrx.9.2023.09.14.08.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:24:08 -0700 (PDT)
Date: Thu, 14 Sep 2023 17:24:07 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [PATCH v2] target/riscv: update checks on writing pmpcfg for
 Smepmp version 1.0
Message-ID: <20230914-cb9bcd81a83afb82fa971d89@orel>
References: <20230908083834.628708-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908083834.628708-1-alvinga@andestech.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 08, 2023 at 04:38:34PM +0800, Alvin Chang wrote:
> Current checks on writing pmpcfg for Smepmp follows Smepmp version
> 0.9.1. However, Smepmp specification has already been ratified, and
> there are some differences between version 0.9.1 and 1.0. In this commit
> we update the checks of writing pmpcfg to follow Smepmp version 1.0.
> 
> When mseccfg.MML is set, the constraints to modify PMP rules are:
> 1. Locked rules connot be removed or modified until a PMP reset, unless
>    mseccfg.RLB is set.
> 2. From Smepmp specification version 1.0, chapter 2 section 4b:
>    Adding a rule with executable privileges that either is M-mode-only
>    or a locked Shared-Region is not possible and such pmpcfg writes are
>    ignored, leaving pmpcfg unchanged.
> 
> The commit transfers the value of pmpcfg into the index of the Smepmp
> truth table, and checks the rules by aforementioned specification
> changes.
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
> Changes from v1: Convert ePMP over to Smepmp.
> 
>  target/riscv/pmp.c | 51 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 9d8db493e6..d1c3fc1e4f 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -98,16 +98,49 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>                  locked = false;
>              }
>  
> -            /* mseccfg.MML is set */
> -            if (MSECCFG_MML_ISSET(env)) {
> -                /* not adding execute bit */
> -                if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
> -                    locked = false;
> -                }
> -                /* shared region and not adding X bit */
> -                if ((val & PMP_LOCK) != PMP_LOCK &&
> -                    (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
> +            /*
> +             * mseccfg.MML is set. Locked rules cannot be removed or modified
> +             * until a PMP reset. Besides, from Smepmp specification version 1.0
> +             * , chapter 2 section 4b says:
> +             * Adding a rule with executable privileges that either is
> +             * M-mode-only or a locked Shared-Region is not possible and such
> +             * pmpcfg writes are ignored, leaving pmpcfg unchanged.
> +             */
> +            if (MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index)) {
> +                /*
> +                 * Convert the PMP permissions to match the truth table in the
> +                 * ePMP spec.
> +                 */
> +                const uint8_t epmp_operation =
> +                    ((val & PMP_LOCK) >> 4) | ((val & PMP_READ) << 2) |
> +                    (val & PMP_WRITE) | ((val & PMP_EXEC) >> 2);
> +
> +                switch (epmp_operation) {
> +                /* pmpcfg.L = 0. Neither M-mode-only nor locked Shared-Region */
> +                case 0:
> +                case 1:
> +                case 2:
> +                case 3:
> +                case 4:
> +                case 5:
> +                case 6:
> +                case 7:
> +                /* pmpcfg.L = 1 and pmpcfg.X = 0 (but case 10 is not allowed) */
> +                case 8:

case 0 ... 8:

> +                case 12:
> +                case 14:
> +                /* pmpcfg.LRWX = 1111 */
> +                case 15:  /* Read-only locked Shared-Region on all modes */
>                      locked = false;
> +                    break;
> +                /* Other rules which add new code regions are not allowed */
> +                case 9:
> +                case 10:  /* Execute-only locked Shared-Region on all modes */
> +                case 11:

case 9 ... 11:

And why not put these cases in numerical order?

> +                case 13:
> +                    break;
> +                default:
> +                    g_assert_not_reached();
>                  }
>              }
>          } else {
> -- 
> 2.34.1
> 
>

It looks like this patch has overlap with 

https://lore.kernel.org/all/20230907062440.1174224-1-mchitale@ventanamicro.com/

Maybe you and Mayuresh can work together on a final patch.

Thanks,
drew

