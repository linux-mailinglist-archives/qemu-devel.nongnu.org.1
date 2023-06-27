Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA173FBD2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:13:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7YZ-0005JD-Iv; Tue, 27 Jun 2023 08:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7YW-0005Ii-4Y
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:12:24 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7YU-00023L-Dp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:12:23 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51d810010deso3014671a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687867941; x=1690459941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+R0bx70T6FRoSzBP92juYNpgA41gealJZHkeJuD1QBk=;
 b=O1yZm554d1l/tG5AFVhQxYYr74GDUBmbAOH6uAFlO9BB49CNYiD+YkQAlXmYH7YAyf
 KVxpMbmdbKHFQEdi+oJXD3OBbgIgEXdj+0ecgzrcjbutzLOwgHF/H4sWu8n5AymjFPai
 MtK30tQplVD3HmmGfW21CjBQzLCNN/jc23/HOKFwLnT1Tn/GKGCKuZENefIz4I0xzZV0
 QsD+bEJZO+bbbwiM9XNl/DQSajiNPahdr7RGvWe9EMxEpwSGf5iQEe9mSDT2Wtw6ZLPI
 ZBk08H8LVRuopQAhDFBiUaVNL19cQnyA0y5Jnw3PvnmgQonACtnR7BCCi2UUsZ1Kq6oL
 1Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867941; x=1690459941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+R0bx70T6FRoSzBP92juYNpgA41gealJZHkeJuD1QBk=;
 b=dqxr0xPvWMgFTyZNV11XgcIIz3cXmsOd3ffQvqMkYDr48wtZ17KQctAihZg4mSCAO1
 NSwlu90kcRjsaBVO4qe4GbfGsJieW+FatRpzPdlbM8ILTrOkqhYKqrJoGuZinoui0Rgf
 XoivONz4u0OEim2KAkZW+8+yj41x76a3KxL1kWJ6FYSXQnUTV+qKaKSuGgFNGPopuDCW
 FZcOzhw0RoR9X5vKTWTIDIMHa2dJMmO7y4Y5T2B14JGJaX6ofncEHCfMVwNY+5F4Pzo1
 0M3fjZctcjut5I3QwL8feWsHrlDTv+7XMsz4sL6NfpH6qLkJxi7x0f8QfWL36JbJ7iid
 Apgw==
X-Gm-Message-State: AC+VfDzBqSupyGJ+CEw+d58vVzxJ6fsNE04jWBfciFvcGKavsmy5bi//
 B+2VYrM0eYl9Xte77kg4xr+zPyBSkRlxzIoiCeJ3lzqhLtdZrwUC
X-Google-Smtp-Source: ACHHUZ428kLCWSwvD9zcLmEQukBcQG8vNufUD8orO/1AyLFYRLCE2kcmpnkBgHwij1at2w6Nd9O9iWRdLSU4uC7KvoE=
X-Received: by 2002:aa7:d405:0:b0:51d:907d:b927 with SMTP id
 z5-20020aa7d405000000b0051d907db927mr4636805edq.11.1687867940809; Tue, 27 Jun
 2023 05:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 13:12:09 +0100
Message-ID: <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 26 Jun 2023 at 08:52, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Add PCI Express information into DeviceTree as part of SBSA-REF
> versioning.
>
> Trusted Firmware will read it and provide to next firmware level.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 0639f97dd5..b87d2ee3b2 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -171,6 +171,25 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>      return arm_cpu_mp_affinity(idx, clustersz);
>  }
>
> +static void sbsa_fdt_add_pcie_node(SBSAMachineState *sms)
> +{
> +    char *nodename;
> +
> +    nodename = g_strdup_printf("/pcie");
> +    qemu_fdt_add_subnode(sms->fdt, nodename);
> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].base,
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].size,
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].base,
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].size,
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].base,
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].size,
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].base,
> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size);
> +
> +    g_free(nodename);


Why do we need to do this? The firmware should just
know exactly where the PCIE windows are, the same way
it knows where the flash, the UART, the RTC etc etc
all are in the memory map.

thanks
-- PMM

