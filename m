Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B2F788155
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRfS-0000Hh-D7; Fri, 25 Aug 2023 03:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qZRfK-0000Fw-Qy; Fri, 25 Aug 2023 03:55:34 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qZRfH-0001oC-O1; Fri, 25 Aug 2023 03:55:34 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50091b91a83so883444e87.3; 
 Fri, 25 Aug 2023 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692950129; x=1693554929;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrO3JrW2o/hWjCpa4E3PAYlU04FLI+l9R8Iu5O/l+pE=;
 b=UhcuYWoJ6+hs2Xh8vxkBMQfNtK4XRiu/4qQQfy+lbYhj10sNbYldn3oFLAb7+ji9bZ
 s83LF6EYqXaWHeHrB756COjWtuxi0L5JPsqEok2rnw0WzlDrXb3uEhB3E1WEL7bsTlV5
 GP5tOqgwnUMoLDJQEH8lGEc9NK8SecQm4kDKXmqdsNYBYz0ohKIdHs+K1RQjKmdsTpFc
 FkpwkZnd6lpY0FZSdJ2zGGoP/Oqqr7QzBm35ZOVe4ntHDw8ZYbsRgj7D+ATvA5EqtOL+
 /R+jyY2Lm6hazatVI2Tfp0ZSKKyWxUUGS6ORAhfxVLeUwXXVQ7h7WYxhGozqpMjClWBH
 1orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692950129; x=1693554929;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrO3JrW2o/hWjCpa4E3PAYlU04FLI+l9R8Iu5O/l+pE=;
 b=hZ0+yhzFv1agvBHdcF05ij3xUqbzQ+QK5Fo+1aSsz3pSw4YIdeOE1Wmo7/YgumajyS
 41CvFBr7k0wzP1OEuxnf+WqgOa5N4YAYBcBXBEkv7XLzouHc/xb/PDLnUuKTKUHNMMsA
 yr9MhqEOvle6w/UxV4xKYRhwObNJqfKhyGPAZqr52sn70MM2cXi8OzXsg9SAcifD9QKt
 rI+r913kZtpVKkiGVc6jMzsOQdyDn/soEe5xQAg/gbDEMsuXn26L6zLSLmgVmGGwW+JK
 SXfN1jDDv3HBrxYD4+SOb0h68Kb1Z/DrnF1bKYs5UBd35CHKW1uGwbZVkBc3RSAW8Tta
 DQxA==
X-Gm-Message-State: AOJu0YysOnW99qKLJhwHIZwQW6HpWHK2xOyeNwMrTRIEnBSCLh9IU4PH
 LsOpISSPZ3xfQ4ERVBy699a1LPYO0sw=
X-Google-Smtp-Source: AGHT+IFg7I91IN040Pbjy6813mp9EnTWvr5CaK5yu+yyT8A4vcqfRR3Eb1EpPLSyn9qZTGCG4TuHxw==
X-Received: by 2002:a05:6512:5c4:b0:500:9f85:7a30 with SMTP id
 o4-20020a05651205c400b005009f857a30mr2809768lfo.26.1692950128605; 
 Fri, 25 Aug 2023 00:55:28 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 l16-20020ac24a90000000b004fbab80ecefsm189902lfp.145.2023.08.25.00.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 00:55:27 -0700 (PDT)
Date: Fri, 25 Aug 2023 09:55:26 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/4] hw/net/rocker: Avoid variable length array
Message-ID: <20230825075524.GO6984@fralle-msi>
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
 <20230824153224.2517486-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824153224.2517486-3-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Aug 24] Thu 16:32:22, Peter Maydell wrote:
> Replace an on-stack variable length array in of_dpa_ig() with
> a g_autofree heap allocation.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/net/rocker/rocker_of_dpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
> index dfe47544694..5e16056be66 100644
> --- a/hw/net/rocker/rocker_of_dpa.c
> +++ b/hw/net/rocker/rocker_of_dpa.c
> @@ -1043,7 +1043,7 @@ static void of_dpa_flow_ig_tbl(OfDpaFlowContext *fc, uint32_t tbl_id)
>  static ssize_t of_dpa_ig(World *world, uint32_t pport,
>                           const struct iovec *iov, int iovcnt)
>  {
> -    struct iovec iov_copy[iovcnt + 2];
> +    g_autofree struct iovec *iov_copy = g_new(struct iovec, iovcnt + 2);
>      OfDpaFlowContext fc = {
>          .of_dpa = world_private(world),
>          .in_pport = pport,
> -- 
> 2.34.1
> 
> 

