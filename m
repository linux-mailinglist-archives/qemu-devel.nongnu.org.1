Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120870F994
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pzh-0003Q6-V4; Wed, 24 May 2023 11:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1pzc-00036C-BV; Wed, 24 May 2023 11:01:36 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1pzY-0007GI-0y; Wed, 24 May 2023 11:01:33 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f3edc05aa5so1033910e87.3; 
 Wed, 24 May 2023 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684940489; x=1687532489;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fnZcFpA1raT2phgdxzy0J18VWQN6dw0vNhg65nImvOA=;
 b=s2TPJpDLv+7hzz4Sa/mELmja9sg5jq8G7nllinXuD4NyrZegvLkTmCpY0TZ2AAbAGT
 hhzmU3lVWLCvvjyIYhyuEx2g20kp3xASRsd9h9hq2oEcq1/jOvCVmnPkW3tsAMjC2YcR
 ZKf68cLnc6LVPaka+Zi2MsHqBU4OmZPWm34WO1KUgJHK1qYbiucqCqOxVs5pAq9qql5p
 I2y3dFM7BhYS2Z+iHCwneawYrCKBga1h8cjc60K6NCG6r8oX4P/tMPvFJPOAJAandsNj
 EOqv0PDTO83UkWISmDHvyJwsu9pKHF5+/AT7ZzVM6W/i0WZghcgMTM/Wpka562uR70dh
 j3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940489; x=1687532489;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fnZcFpA1raT2phgdxzy0J18VWQN6dw0vNhg65nImvOA=;
 b=ct926i0IhtXFxpiYDbO4RAqihtGf13Bpn3ZWdcFEb/Tq05517ZwWK+2MSLwtpwOdun
 NVSI+Jr9DwH66jnCGIdaxYJ31VheMPNov+9LD+7j9SMF/CzmLj6McvLK9lGXpiFOpiK6
 R8xdlxtSIjDev8YVEz9dTMvkwGDq4p508aXNOpBwipRvVvWUnGO7zNn/1pIQdxb2JVp9
 p+f3F0BADKjJHz8X5xZSU/llHIc9TzEAOR4sjXsGqPzbDNrqad0Xtar9NGKwmW3whDwi
 4VR+SH4z04/ve1KulKjkCqnYcOPgHd47nWR8W3nNE1G3ys+Su3WM30bghcHpkJJz44Ri
 wnRg==
X-Gm-Message-State: AC+VfDzfFUJnvWWKbq3p5TzSyN3wPidD96piw7vPIatB5v1ir8g+l//7
 6+8A7R264Z4Tyk9vYAr6sP0=
X-Google-Smtp-Source: ACHHUZ6JPHF4kiizBrDtH6RwYBdBClY7qsU2L6JQq/XwtDZLQcUHIGeFeCn6Jp7QU/VBPRRLOZ3BdQ==
X-Received: by 2002:ac2:44d4:0:b0:4f4:7a2:643b with SMTP id
 d20-20020ac244d4000000b004f407a2643bmr2916317lfm.14.1684940488463; 
 Wed, 24 May 2023 08:01:28 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 u17-20020ac25191000000b004f1400630d3sm1736043lfi.35.2023.05.24.08.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:01:28 -0700 (PDT)
Date: Wed, 24 May 2023 17:01:26 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, peter.maydell@linaro.org
Subject: Re: [PATCH] hw/arm/xlnx-zynqmp: fix unsigned error when checking the
 RPUs number
Message-ID: <20230524150126.GG6984@fralle-msi>
References: <20230524143714.565792-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524143714.565792-1-chigot@adacore.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_WELCOMELIST=-0.01,
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

On [2023 May 24] Wed 16:37:14, Clément Chigot wrote:
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
> Signed-off-by: Clément Chigot <chigot@adacore.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/arm/xlnx-zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 335cfc417d..5905a33015 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -213,7 +213,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
>                                     const char *boot_cpu, Error **errp)
>  {
>      int i;
> -    int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
> +    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
>                         XLNX_ZYNQMP_NUM_RPU_CPUS);
>  
>      if (num_rpus <= 0) {
> -- 
> 2.25.1
> 
> 

