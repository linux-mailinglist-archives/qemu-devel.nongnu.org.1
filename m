Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD873576C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEQK-0007P8-HT; Mon, 19 Jun 2023 08:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEQF-0007OR-DT
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:55:56 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEQC-00078M-Oq
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:55:55 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so4983891a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687179350; x=1689771350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AyWRgUMhVO/00WQZnqs/E/q6+630QHqRJiOo8yLErEQ=;
 b=tlx2y5aOX1j+23sh6lojTj73DJJR2TZOihYy1JhE4pv6K/34w2zZCcoX6Qz3iZP3Bn
 zZHHQCYViLjn5Es7EMqwsy5yhznxVOw7wgxC/OYYM6a9LDrpqaXKY0VpzWaejySr+1eb
 kVKgM4dx+WkSnwiHTdATVQkD6guIHH9DHeEGl97yTNa/jDfuaeG/pFuY8FmqMwT7NBdn
 GS4IVEqwX9fH3+HUJ0gxMuSK+yQJPExc7NA3sd3Zir2v/3hJfdvi4fWPjOQUjK560NZ4
 O+1LahcKO3Od4bP3nbctuXfbQZfuAp8SEqZy587GR5CE5NWk3GGW55nLl9pLi6nlp7lt
 hl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687179351; x=1689771351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyWRgUMhVO/00WQZnqs/E/q6+630QHqRJiOo8yLErEQ=;
 b=N4LnLkxc1TBcvVVBaMvI/ChejiOyLN65HbB7pn8LwKESzauJGfgcLH3WoAT3C2UjCT
 GaEKJCoUBvqMxenI4TqjpH5rrv8IBOyfrkMBtegTCaLK1LyxfrxzwhUT2alZ6H7+c5lx
 dbTtmpKGH5Q/ngtjYPKo5mtaPfcZ2a+pit+4qzmzYqxzTF9b90fDsK5vKWIlzfRBkqWH
 JHD4td43AEMSwZCqUYhCWuQd2m0SFyJmAQc3S3dHtPmQvIaKWJcyzyy6RFFClXlFUCpg
 Ftj0zabTS1KCHuU/cGWuLEzdcXeENdqX1dS9YvIkygK8ruliRnrG4cwrB2ueAVhbZyzY
 o7ww==
X-Gm-Message-State: AC+VfDzqat8eLGAhiaSDBYTsizTGdeFJIYnnobGTyIxfboZ8/foC9RZR
 xV0t2Z2DkPVz10O9TUnxNXFZHwxD1+5FQxyJSZhUgA==
X-Google-Smtp-Source: ACHHUZ6Wo2wVFeNpUTiXT94mHVpDs5sKxBCsKN29cUt7mdU4LQrTczeD3SeMuRI49U7XyEXy48r2GyVUOw0AUoN5+B4=
X-Received: by 2002:a05:6402:1a37:b0:51a:4042:6b0a with SMTP id
 be23-20020a0564021a3700b0051a40426b0amr5264112edb.4.1687179350745; Mon, 19
 Jun 2023 05:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230606182414.637467-1-marcin.juszkiewicz@linaro.org>
 <20230606182414.637467-3-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230606182414.637467-3-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 13:55:39 +0100
Message-ID: <CAFEAcA8eGEeMJwUSe5Ok9QvYUReO_awe3-+R5Vbc9MobDc2JLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/sbsa-ref: add GIC ITS to DeviceTree
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 Shashi Mallela <shashi.mallela@linaro.org>
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

On Tue, 6 Jun 2023 at 19:24, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> We need GIC ITS information in DeviceTree so TF-A can pass it to EDK2.
>
> Bumping platform version to 0.2 as this is important hardware change.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> ---
>  hw/arm/sbsa-ref.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 1520cd598c..2bd9e370a7 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -183,8 +183,15 @@ static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
>                                   2, sbsa_ref_memmap[SBSA_GIC_REDIST].base,
>                                   2, sbsa_ref_memmap[SBSA_GIC_REDIST].size);
>
> +    nodename = g_strdup_printf("/intc/its");
> +    qemu_fdt_add_subnode(sms->fdt, nodename);
> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> +                                 2, sbsa_ref_memmap[SBSA_GIC_ITS].base,
> +                                 2, sbsa_ref_memmap[SBSA_GIC_ITS].size);
> +
>      g_free(nodename);
>  }
> +
>  /*
>   * Firmware on this machine only uses ACPI table to load OS, these limited
>   * device tree nodes are just to let firmware know the info which varies from
> @@ -221,7 +228,7 @@ static void create_fdt(SBSAMachineState *sms)
>       *                        fw compatibility.
>       */
>      qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
> -    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 1);
> +    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 2);
>
>      if (ms->numa_state->have_numa_distance) {
>          int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);

We should fold this patch into the previous one.

If we are bumping the version-minor, we should add something
to the documentation that says what the difference between
0.1 and 0.2 is. (And if we can remember what 0.0 was that
would be worth noting.)

thanks
-- PMM

