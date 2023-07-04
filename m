Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E87472BB
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGg3h-0007H3-SJ; Tue, 04 Jul 2023 09:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGg3f-0007FW-8x
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:27:07 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGg3c-0000v2-F0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:27:06 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b6ef64342aso22826881fa.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688477222; x=1691069222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zGA5mEEEInKa/leBJTZrGJNNhHAe1LeFPYLWkwjPHO4=;
 b=lLp4B6jeAeXgEKvlrQ46WBeYeYNdNFV5ZrQe1P9jbOGhWZSczA2vcTlKQ1ggVlhl+s
 IkPTPuUtstx+fCI1hhBTvuSRlOT0Oob9My4Z79g4Ns3oygM0O+4beCfscKgA3QonRKG1
 gxQ0Thr5H6nrQLiuz2x0MotPrmQPLqhCt2RiPQTaEsZVFM7+sZgTxMrefbJYE7HG4pia
 4OzgLN/P99DNnJehvK0ADrVKHAhG/SXNAqpcOwbi9wapUqNedsVOHIpVQSiGjyOcrVTV
 KQp+T2NOrOH+8ZNsI4/aojj62wf9ziYXtU754N4sJ8dpuQrWLzK6LGKP8H1aWnHBBR6G
 t7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688477222; x=1691069222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zGA5mEEEInKa/leBJTZrGJNNhHAe1LeFPYLWkwjPHO4=;
 b=bJwFCAEd5ZYEAufObhOSNiQf1QdR52WQ+AV/td8FwPquOp6r+AW9mp9WcZjEoEX/bd
 3W+b3IkqfmDiLCH/uMEqrwyk+jhflArK8l/rlB418oErGxBgvLoT5mVdbkRnc9PINTFk
 2mawAZQDzyV4M8grd62I/pSXFpqU2luuPJoFsylDIGF80eBg/td13CW0AH1R0E3MANdo
 TOm5jL6TAxG770rJgwkym43cR3HzYBsj3uj7TIp8KfXTQ2OizlfMsC/NpXGFolvFwgln
 REYw61ZTlJqOU+E3ee+qLOEu46OuVCB8Lr5ZTKcOvAJSbAr+Ml4SjYldqjIaVZpVshf1
 lMjA==
X-Gm-Message-State: ABy/qLagniOLzb700NrEyE8+0PIO8HVqmZkczGkBwtr6W+XtvuHkASSM
 sRqj7vg8sTx+nWiNSWhu0mHtNrzsyyJlCGj9yLOoHc+Mjv2oUinr
X-Google-Smtp-Source: APBJJlGBzQSbta5RQdK94wCWmtSpGNI8eRicBeEqFS1XgtpQT5hF4RvsG1cHp/tQFiHWU9X1u9GFhxZC9Bo1cpyNuiQ=
X-Received: by 2002:a19:8c05:0:b0:4f8:56cd:da8c with SMTP id
 o5-20020a198c05000000b004f856cdda8cmr9018938lfd.34.1688477222388; Tue, 04 Jul
 2023 06:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230623144410.1837261-1-peter.maydell@linaro.org>
In-Reply-To: <20230623144410.1837261-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:26:51 +0100
Message-ID: <CAFEAcA_mezDNCR0JwsURzZ1gSeAk64H81CVOzWPyur94uEFfKg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Remove pointless NULL check in clock_adjtime
 handling
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

Laurent, ping? This patch has been reviewed.

thanks
-- PMM

On Fri, 23 Jun 2023 at 15:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the code for TARGET_NR_clock_adjtime, we set the pointer phtx to
> the address of the local variable htx.  This means it can never be
> NULL, but later in the code we check it for NULL anyway.  Coverity
> complains about this (CID 1507683) because the NULL check comes after
> a call to clock_adjtime() that assumes it is non-NULL.
>
> Since phtx is always &htx, and is used only in three places, it's not
> really necessary.  Remove it, bringing the code structure in to line
> with that for TARGET_NR_clock_adjtime64, which already uses a simple
> '&htx' when it wants a pointer to 'htx'.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f2cb101d83c..7b2f9f7340e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10935,16 +10935,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
>      case TARGET_NR_clock_adjtime:
>          {
> -            struct timex htx, *phtx = &htx;
> +            struct timex htx;
>
> -            if (target_to_host_timex(phtx, arg2) != 0) {
> +            if (target_to_host_timex(&htx, arg2) != 0) {
>                  return -TARGET_EFAULT;
>              }
> -            ret = get_errno(clock_adjtime(arg1, phtx));
> -            if (!is_error(ret) && phtx) {
> -                if (host_to_target_timex(arg2, phtx) != 0) {
> -                    return -TARGET_EFAULT;
> -                }
> +            ret = get_errno(clock_adjtime(arg1, &htx));
> +            if (!is_error(ret) && host_to_target_timex(arg2, &htx)) {
> +                return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> --

