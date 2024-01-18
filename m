Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3275831E51
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 18:22:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQW4t-0002Ux-PZ; Thu, 18 Jan 2024 12:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rQW4r-0002UZ-2E
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:21:17 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rQW4p-0003oV-9a
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:21:16 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5fc2e997804so61670217b3.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 09:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705598473; x=1706203273;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pa5sGR9Z3Vq29YykmMl5lAz7CVoGlVrI8qxa+rfd10c=;
 b=BnOi9ov0xK+sOm7QVL3XN4MYhqIfTMe/D8LbsvSpSoLSS+g+Edwss0WjwSixvdJH20
 kYdj7Vf4f/0kHtWhFajeX3bRuPI7QooHb3lRYRqBai8OAjGg7Bd2mOtAxuxnB87olwns
 ArN8fRBTa0OmDGi0oFHM7mTvTOXi/x0NbM8FZwyWOupiyIlky6nX3lBsuBq+CicpdW/Q
 FuhXI45ftjyQr6W4VjH5KIoOBxue5IO7aNpbgS9wrVnRpu+RqYJnTp6ixl0cjmEkF+u2
 HqehXZzJSl/6/hDif1csQXuiAbYy9NEAMioQ6v5TV+70IFc8EOx+EUx6/z6Z+GMcZD5c
 YZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705598473; x=1706203273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pa5sGR9Z3Vq29YykmMl5lAz7CVoGlVrI8qxa+rfd10c=;
 b=JKrc2SPs2G0vh/WncNXFZ7zBu5FU5OrSDcGk0gOW8YPp2h4dypvbTJCfOc8WFCwBmi
 MY/+5d/hx49yQdJ1sw/uZ01Fm/uleZbVG2AZ0w92RDu1OJunp/nKwDM9OFHkkl9vAUgB
 MgCs6EAMJ5Dgk4vf9OAf27onBGlBArIllhWCAGjiRw/+JT2lByI+Woo2Or9mwRUOMolN
 j6LeBBmZVDdmbmFhbTwWK2ynTngk8O1L4KkJROOtfWjTuxWwvfKZVrmZaaX8Uxe05Xza
 0MhQn8BnyWwvRsg/B5wM9S5tsoA2NpPYebPiijNCljzCgCZu9c4YusaNU34UaYTzjkSm
 DsWQ==
X-Gm-Message-State: AOJu0YzFVt9+Z2PcMECev9IWS9J5tS2AQqoe9g/47wRjiR9IIEMh7Gmf
 PzFGSJhAdvCsBYTQZ4JqhGV6Ll5NF1E2B4g74Yf8Ki3KXUUPPuzLlIuR7pfqGPFWbasZe6KObam
 Gj1V3cFq97oeEoM39IELLcbF7JlIK5J5635xdbw==
X-Google-Smtp-Source: AGHT+IFUK+nQ/P5YWe2QiOgElsSIUQgzapBnG6guCHS7/1bZqZIgQvyM2vVeRFeKMFcalWauj1QE8AZLrP4C/mikj9I=
X-Received: by 2002:a25:ac46:0:b0:dc2:48af:bf01 with SMTP id
 r6-20020a25ac46000000b00dc248afbf01mr1033194ybd.29.1705598473433; Thu, 18 Jan
 2024 09:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20240109102930.405323-1-me@deliversmonkey.space>
 <20240109102930.405323-4-me@deliversmonkey.space>
In-Reply-To: <20240109102930.405323-4-me@deliversmonkey.space>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 18 Jan 2024 09:21:00 -0800
Message-ID: <CAKC1njSLR614zQk0_DAgYN1jjdg=0eUa7N1AEwwXZVNN6BwjmA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=debug@rivosinc.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 9, 2024 at 2:31=E2=80=AFAM Alexey Baturo <baturo.alexey@gmail.c=
om> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---

> +
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +{
> +    bool virt_mem_en =3D false;
> +#ifndef CONFIG_USER_ONLY
> +    int satp_mode =3D 0;
> +    int priv_mode =3D cpu_address_mode(env);
> +    /* Get current PMM field */
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        satp_mode =3D get_field(env->satp, SATP32_MODE);
> +    } else {
> +        satp_mode =3D get_field(env->satp, SATP64_MODE);
> +    }
> +    virt_mem_en =3D ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=3D P=
RV_M));
> +#endif
> +    return virt_mem_en;

Obsessing a little bit on how to test PM enabled binaries with qemu-user.
If we return false above then we're not allowed to test binaries with
pointer masking enabled with qemu-user.
That use case is not required?

> +}
> +
> +int riscv_pm_get_pmlen(RISCVPmPmm pmm)
> +{
> +    switch (pmm) {
> +    case PMM_FIELD_DISABLED:
> +        return 0;
> +    case PMM_FIELD_PMLEN7:
> +        return 7;
> +    case PMM_FIELD_PMLEN16:
> +        return 16;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>
>  /*
> --
> 2.34.1
>
>

