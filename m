Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C35267109EE
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:18:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q282I-0004Ly-94; Thu, 25 May 2023 06:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q282H-0004Lf-05
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:17:33 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q282F-0005s4-CB
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:17:32 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51440706e59so792705a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685009850; x=1687601850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PuZf9HDcnxXAdRIqM2oTJUVEk2qTt+8Pet41yqkOSA=;
 b=DLwBlSJsqV62fX+zA/LAA6JHGEvm3Lx/LC9uV7pdID0krkg2S7YFdKedl8QbgEg6nx
 4m2zIhQ6y95RrdpmHdGtRzTR7O66PKAUOW3DRlF5/gADuydT20NpSufFLqraTJoXei1i
 Z9q1GaG5mgpdvwM9NVE/ZDX/Swx5lQl1kTBU0ChTSBvb0V4+gMMg8MKcYnwYqYOGECW5
 yvvPq0OzrMSm2tCywlW5gvWx/Wp1r/RcBzAn5GaT2ByctveRnosbOOHLzJnHw8ctKVDH
 9MU7Zy16698yPvND80q65WXfCd1CmF+5a0sVOigYH8sVcFLEXrTQMg8MyEfcx4f8hkni
 bu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685009850; x=1687601850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PuZf9HDcnxXAdRIqM2oTJUVEk2qTt+8Pet41yqkOSA=;
 b=DyNv0wqyypreAoDwz25u/J6cAam+wuvey5TBtlUThDaAxvu4Sxn7zYQ4bY687cPPYh
 1VXywM2Gh05pWJnSnsrxkKeCwWeyLpQDLoS2XTPKfhOqC3Bei9ioWSb9K8VtV+OPNDqj
 Lx8GAYWC/rCdfYkFD/YL/fjJvaSklnu8bBux2t7I6Rv/f4efyzdXAnMpJuHd43r8jUic
 eC3kjVwcvvUsKc7pLrOA1NSdCVhjApf+aYOxRhk1JtwQc4XukZ014bvGLaT+zHhuAFCS
 i7U+dl1g6gTTM5U9JRKIib+Tq4Bi5qknO6EbKc2gXXNs6F6moWIrb0eLfwaBtUlqT50h
 W8AA==
X-Gm-Message-State: AC+VfDxu+LvL4JIjDQl9ISzvyqbzbSHvh3JEumY1LIfp+tiRQKVnsV83
 uosy4BtJvMPBuif0E8LEj9KdS3Jz37zYNWjez45QLQ==
X-Google-Smtp-Source: ACHHUZ7l+Z6czGAAvmKK7KV5tv9qhurEyqHZj5dWhrKSjBFtcw0rc6Lg/xVtMjtZYBXdvuBEV42qX+aby0K8GKD0tR0=
X-Received: by 2002:aa7:c2d8:0:b0:50b:cc52:3fd3 with SMTP id
 m24-20020aa7c2d8000000b0050bcc523fd3mr3512143edp.41.1685009849687; Thu, 25
 May 2023 03:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230524143714.565792-1-chigot@adacore.com>
In-Reply-To: <20230524143714.565792-1-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 11:17:18 +0100
Message-ID: <CAFEAcA8K_6LKnm9O0EhVMeusWO9z1bjunYiKcXT=hVmROehFDA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xlnx-zynqmp: fix unsigned error when checking the
 RPUs number
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 24 May 2023 at 15:37, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> When passing --smp with a number lower than XLNX_ZYNQMP_NUM_APU_CPUS,
> the expression (ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS) will result
> in a positive number as ms->smp.cpus is a unsigned int.
> This will raise the following error afterwards, as Qemu will try to
> instantiate some additional RPUs.
>   | $ qemu-system-aarch64 --smp 1 -M xlnx-zcu102
>   | **
>   | ERROR:../src/tcg/tcg.c:777:tcg_register_thread:
>   |   assertion failed: (n < tcg_max_ctxs)
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> ---
>  hw/arm/xlnx-zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 335cfc417d..5905a33015 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -213,7 +213,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, =
XlnxZynqMPState *s,
>                                     const char *boot_cpu, Error **errp)
>  {
>      int i;
> -    int num_rpus =3D MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
> +    int num_rpus =3D MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
>                         XLNX_ZYNQMP_NUM_RPU_CPUS);

Applied to target-arm.next, thanks.

-- PMM

