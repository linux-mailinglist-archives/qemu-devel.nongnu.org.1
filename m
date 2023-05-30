Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB48715E9D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yDX-0002pR-J8; Tue, 30 May 2023 08:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yDP-0002jx-17
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:12:39 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yDN-0005Qb-DO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:12:38 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51494659d49so4885148a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685448755; x=1688040755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4/jlGgEm87FBCNta8BpLpBgKVYdmiXVpuZ1sVcQLpME=;
 b=G8lgqMs9U9mfL7gudoEK0wFpXRtmwRi4x/3PHypZ6g2gxJpVzb2duyDFjGPZ0r4Yw6
 B1Vxe47RrS/OU6nZ/uGYmRHhXF8KzIEbAwzucnUIHyTrYQxpKF4K8nX3E6t6TuVYzPg/
 Mn1xkrgzcwbBy4+Q5WJYkLbJs8fe0jrGreoIcb5KkJgXnPO8x3MFDPB8GAuSXGTENWGh
 tQYlrMBDX1HqaxP7niCkn/ZDglsqlbU5LjOvtWQ7+e/rXJXrkQ2b5u1xmmxlm+Kw/w/O
 bUBIQO57J3uUH0eIORYh/DzFnabGCzYlwaHqEh2mKmFI6dleCS4+BPLdRcfR1myMUizT
 KFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685448755; x=1688040755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/jlGgEm87FBCNta8BpLpBgKVYdmiXVpuZ1sVcQLpME=;
 b=lhAb+grqFFg29XNlpC56jYhbx262xvBxcBuMN/GZu6YNJY9WMQxq6yz2VmRg5pvfpA
 o7hq1RB22eRbDxyXQsqOhPKj1l2irckoxTDjuSp30z9xqyM6W2bauw7RZMgQMRJWQc2X
 btCK/A93CsZIed4nT3XBCGrOs84Jac3+9d6DOa2Wx+8bS90zC/FFOwJ/p9NCmF9hT10+
 hAEXZwfecsGhveXzvBUNnGskB+lzxgfmF50+3cELzKoHQssiWT5FrdySg41Nv4Vjw9gm
 Z6+FsjGWEPAb50OnbwmeHRK7u++6Ea4KNGC1z9b5+xgPPQuCB2Bv9jdfq7zP/KJ6Eb6p
 GheQ==
X-Gm-Message-State: AC+VfDyA5xtcn8CPBTZSvzOCEgChmbjt7wpx8zvzqi8g+hN+ySK0B9Sy
 BMk7u0N5M8eCeEZKw4UMzSUG/KWIphIFqZwXW127fw==
X-Google-Smtp-Source: ACHHUZ453psnex6lFmNQehr2k9G25wxV8W77ELN+6ZAmjSyqoKMZYXgh5RPR+J0+EqcTF/NeOLQvHlmsqRrlQKmHejE=
X-Received: by 2002:aa7:c3c8:0:b0:506:82b7:10c3 with SMTP id
 l8-20020aa7c3c8000000b0050682b710c3mr1305507edr.41.1685448755581; Tue, 30 May
 2023 05:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230524191438.172019-1-sergey.kambalin@auriga.com>
In-Reply-To: <20230524191438.172019-1-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 13:12:24 +0100
Message-ID: <CAFEAcA_PH8yAT28s3p7_0rqK9NodJ6gTXxv63J+98XoMQ_nJTg@mail.gmail.com>
Subject: Re: [PATCH] Prepare bcm properties for videocore 4
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 24 May 2023 at 20:15, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Hello!
> Sorry for a quite a big patch, but most of the changes are the same type.
> Most of the patch is about a definition of new constants/structs and replacing
> magic numbers with those constants.
>
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---


> @@ -51,48 +98,48 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>          /* @(value + 8) : Request/response indicator */
>          resplen = 0;
>          switch (tag) {
> -        case 0x00000000: /* End tag */
> +        case RPI_FWREQ_PROPERTY_END: /* End tag */
>              break;
> -        case 0x00000001: /* Get firmware revision */
> +        case RPI_FWREQ_GET_FIRMWARE_REVISION: /* Get firmware revision */
>              stl_le_phys(&s->dma_as, value + 12, 346337);
>              resplen = 4;
>              break;
> -        case 0x00010001: /* Get board model */
> +        case RPI_FWREQ_GET_BOARD_MODEL: /* Get board model */
>              qemu_log_mask(LOG_UNIMP,
>                            "bcm2835_property: 0x%08x get board model NYI\n",
>                            tag);
>              resplen = 4;
>              break;
> -        case 0x00010002: /* Get board revision */
> +        case RPI_FWREQ_GET_BOARD_REVISION: /* Get board revision */

So mostly this is just updating hardcoded constants to
symbolic constants, which is great.

> -        case 0x00038002: /* Set clock rate */
> -        case 0x00038004: /* Set max clock rate */
> -        case 0x00038007: /* Set min clock rate */
> +        case RPI_FWREQ_GET_CLOCKS: /* Get clocks */
> +            /* TODO: add more clock IDs if needed */
> +            stl_le_phys(&s->dma_as, value + 12, 0);
> +            stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_ARM_CLK_ID);
> +            resplen = 8;
> +            break;

But this is adding a new implementation of a new property...

> +
> +        case RPI_FWREQ_SET_CLOCK_RATE: /* Set clock rate */
> +        case RPI_FWREQ_SET_MAX_CLOCK_RATE: /* Set max clock rate */
> +        case RPI_FWREQ_SET_MIN_CLOCK_RATE: /* Set min clock rate */
>              qemu_log_mask(LOG_UNIMP,
>                            "bcm2835_property: 0x%08x set clock rate NYI\n",
>                            tag);

> @@ -295,6 +357,144 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>                                      resplen);
>              break;
>
> +        case RPI_FWREQ_GET_THROTTLED: /* Get throttled */
> +            stl_le_phys(&s->dma_as, value + 12, 0);
> +            resplen = 4;
> +            break;

...and this and the other bits further down in this part of
the patch are new properties too.

New features should be in separate patches from refactoring cleanup,
please.

By the way: when you split up patches you don't need to send them
just one at a time -- you can send a patchset of multiple related
patches.

thanks
-- PMM

