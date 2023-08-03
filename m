Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D94EB76EBBB
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYw7-000887-GU; Thu, 03 Aug 2023 10:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYw6-00087q-4G
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:04:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYw4-0006rp-Ev
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:04:17 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31765792c7cso924704f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691071454; x=1691676254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3xeG9kMMEr3zdzw1Jah6ZFg1Wl+lPpIWtYdOFFyuow8=;
 b=rErXynN/OO06CN2uMtMAXKyd9NUpf+hnPtLzO8W09rIgEOKrp7C2IM23H2++EuI896
 Ozd5iXFFgh60rLoHNO6Agq5d2ub9PghuxpbEsGaeawtYBNIJL611LDs3kdnqIsdyfnmQ
 mhmwGwF36z5zS5JJ0F0FbK4r3Febs/Ddx+qXZdO0wpOQfC1rUNGHIbNFPowvKCemyCfC
 35/r1TvvMg6j54l5M4JUtGls2UmO6ffGKDMntMPUeeBQ6yw/XxuMYLP9BvelMF9OhJib
 lnqDj409xNqAXzB3Q1uH0QIKLbnx4ldMNuLYqxuK+vi8Kb5priVNpzacVX1q+16ZUx0v
 r0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691071454; x=1691676254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xeG9kMMEr3zdzw1Jah6ZFg1Wl+lPpIWtYdOFFyuow8=;
 b=XoXFA/hxdMR6UOWryOt6TdIfalnLnBBSTAvHO0jzCa3wCf0QVfGzYJANWY8T+ek6g/
 yr64qg4A/8WNsVjVt2Qa7KgM7VzA+7BOSfl7IFdZEjcPxU5mbXyk0wtF+CT4ebQd27ye
 m9C5aiXby0HZQEtwS8SEmP28BFDgH+eugMEJlnl7CpYBDOrH/AjN13eq4eWRzlZlaIti
 t5S7asqOIkVFetv+t9fYyuamJ6RdsDjn0m4D9mZwz/5Q4PX0jNHzDH3Oj68ZJOn/zykr
 pQMOUk5Ne1yXtycePS6vyZsc4Zwli12NJwTtCWnj/RrP/3H7Xkn2NRbrEl1oF1lXrOvE
 qaVQ==
X-Gm-Message-State: ABy/qLZO//dan1lpBd3DFBjUXg/ivNM14v6JBMnAi6dH609c+8twCTnp
 GihJ+AbUtp54sQAiA0E0LBr7wP3/WIpLbJdkfElK0AAO1zm9lHBG
X-Google-Smtp-Source: APBJJlH2G1R/+vWQ8Ez/5A93Z0yEAsdWX1ngD9NebVSW/7dtDqUjIFa/wBP51+DKtUFoHsbAJNsG1e2Js3ElYI0MwT4=
X-Received: by 2002:adf:f0c4:0:b0:313:ef24:6feb with SMTP id
 x4-20020adff0c4000000b00313ef246febmr6705752wro.3.1691071454387; Thu, 03 Aug
 2023 07:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-7-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-7-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 15:04:03 +0100
Message-ID: <CAFEAcA9OGCPm1F3AvcAJs33YBrMisi0AubJQANZKjWxSQw6+hw@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_BCAST_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

On Mon, 10 Jul 2023 at 15:03, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame broadcast
> controller (CFRAME_BCAST_REG).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  hw/misc/xlnx-versal-cframe-reg.c         | 173 +++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-cframe-reg.h |  17 +++
>  2 files changed, 190 insertions(+)

Missing reset again.

> +static uint64_t cframes_bcast_reg_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
> +                  HWADDR_PRIx "\n", __func__, addr);
> +    return 0;
> +}
> +
> +static void cframes_bcast_reg_write(void *opaque, hwaddr addr, uint64_t value,
> +                      unsigned size)
> +{
> +    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(opaque);
> +    unsigned int idx;
> +
> +    /* 4 32bit words. */
> +    idx = (addr >> 2) & 3;
> +
> +    s->wfifo[idx] = value;
> +
> +    /* Writing to the top word triggers the transmit onto CFI. */
> +    if (idx == 3) {
> +        uint32_t reg_addr = extract32(addr, 4, 6);
> +        XlnxCfiPacket pkt = {
> +            .reg_addr = reg_addr,
> +            .data[0] = s->wfifo[0],
> +            .data[1] = s->wfifo[1],
> +            .data[2] = s->wfifo[2],
> +            .data[3] = s->wfifo[3]
> +        };
> +
> +        for (int i = 0; i < ARRAY_SIZE(s->cfg.cframe); i++) {
> +            if (s->cfg.cframe[i]) {
> +                xlnx_cfi_transfer_packet(s->cfg.cframe[i], &pkt);
> +            }
> +        }
> +
> +        memset(s->wfifo, 0, 4 * sizeof(uint32_t));
> +    }
> +}

> +static void cframes_bcast_fdri_write(void *opaque, hwaddr addr, uint64_t value,
> +                      unsigned size)
> +{
> +    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(opaque);
> +    unsigned int idx;
> +
> +    /* 4 32bit words. */
> +    idx = (addr >> 2) & 3;
> +
> +    s->wfifo[idx] = value;
> +
> +    /* Writing to the top word triggers the transmit onto CFI. */
> +    if (idx == 3) {
> +        XlnxCfiPacket pkt = {
> +            .reg_addr = CFRAME_FDRI,
> +            .data[0] = s->wfifo[0],
> +            .data[1] = s->wfifo[1],
> +            .data[2] = s->wfifo[2],
> +            .data[3] = s->wfifo[3]
> +        };
> +
> +        for (int i = 0; i < ARRAY_SIZE(s->cfg.cframe); i++) {
> +            if (s->cfg.cframe[i]) {
> +                xlnx_cfi_transfer_packet(s->cfg.cframe[i], &pkt);
> +            }
> +        }
> +
> +        memset(s->wfifo, 0, 4 * sizeof(uint32_t));
> +    }
> +}

I feel like I've seen this code structure in several patches:
opportunity to share code ?

thanks
-- PMM

