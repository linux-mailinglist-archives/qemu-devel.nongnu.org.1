Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2906A7B8D48
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7Qz-0001WL-2b; Wed, 04 Oct 2023 15:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7Qx-0001N2-Dv; Wed, 04 Oct 2023 15:21:23 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7Qv-0002M8-Ji; Wed, 04 Oct 2023 15:21:23 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50444e756deso250690e87.0; 
 Wed, 04 Oct 2023 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696447279; x=1697052079; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CT8CjkyW/qAVTukpqo9XqNgrhGiKGcDkIGDpw65wGGc=;
 b=k9a1Y1FNzkTzCzd9CEYF5q0ufRrrvjv/e+E0YC4LnHFlWhJ251CirXRPD2Eukmrrq4
 TkvMOYY9qNdUMj1bbFt8RLJ7vIFAf7wSPRjiF32yMa8MYDFJRboSjbnls6DMFgngyww9
 /tUZmyR8zRdFIamiyXPwamrJRtkscoRrr7+uhLF9N2dU+hKNgBbnO64y6czm1KuY9tqh
 R5ri0azuMF0DGgSnUbf3N3lN1FRZYCSzTHbRahv1bW9Eg699jrYNbybGSy9RDeS2lHpC
 CCjrAcgIhcZaJz81U6t/oWJreBx40sE7+/OcrtOIFz+vwPuCCmswh5eCREAdMagTR0Ng
 QDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696447279; x=1697052079;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CT8CjkyW/qAVTukpqo9XqNgrhGiKGcDkIGDpw65wGGc=;
 b=w4U9RtE2Q7hSpJVcJSezygX4bb5yKkX2CP/d6CnSjP/cuCO0J7lARZlcP3tRa/JI+2
 VMQ07/AIjszJgC7gHIlTXSt/0FVX6BFvyaTme0YKSa4EQhSKkkGOfuuHVHnhe8voguvj
 z4VhWI9t8HMQkr56oeXHWAcrq8eK3P/5J620GSBdHIx+I2HKrwFDqg72g2r4lDfpk/is
 KirlV4u4RPspTjK/IuH9XDoYUAeFdNNXqnc3f1Lm6FWHkpjR82gwjGWl46LlJ4BgUGMY
 hDNIIlVu+nizpNhvviXHQFd5vFbptnm28MpKDDlKAeOtFlguQ54Yp7LEUa+VNyf9a/0X
 fRaA==
X-Gm-Message-State: AOJu0Yzk/A7etP8XXTAtdCCeebqqsKaa1NgoBpdLjq2vRBRYZO5Og8/4
 HeFROWuGuIDEz+hSngAl3xZiW6mdMcw=
X-Google-Smtp-Source: AGHT+IHFHwriAgAV4UMe5N6e5UpAHgCnsRRvxJ05QoCsqYttnieq8LTfld99wmLexTivWYna0wUZpw==
X-Received: by 2002:a05:6512:1104:b0:505:6ede:20ab with SMTP id
 l4-20020a056512110400b005056ede20abmr3363545lfg.53.1696447279486; 
 Wed, 04 Oct 2023 12:21:19 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 n14-20020ac2490e000000b004fe3bd81278sm714788lfi.70.2023.10.04.12.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 12:21:19 -0700 (PDT)
Date: Wed, 4 Oct 2023 21:21:17 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com, peter.maydell@linaro.org
Subject: Re: [PATCH] xlnx-versal-efuse: hw/nvram: Remove deprecated device
 reset
Message-ID: <20231004192117.GE18959@fralle-msi>
References: <20231004055339.323833-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004055339.323833-1-tong.ho@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
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

On [2023 Oct 03] Tue 22:53:39, Tong Ho wrote:
> This change implements the ResettableClass interface for the device.
> 
> Signed-off-by: Tong Ho <tong.ho@amd.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/nvram/xlnx-versal-efuse-ctrl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
> index b35ba65ab5..beb5661c35 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -2,6 +2,7 @@
>   * QEMU model of the Versal eFuse controller
>   *
>   * Copyright (c) 2020 Xilinx Inc.
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
> @@ -657,9 +658,9 @@ static void efuse_ctrl_register_reset(RegisterInfo *reg)
>      register_reset(reg);
>  }
>  
> -static void efuse_ctrl_reset(DeviceState *dev)
> +static void efuse_ctrl_reset_hold(Object *obj)
>  {
> -    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(dev);
> +    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
>      unsigned int i;
>  
>      for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> @@ -749,8 +750,9 @@ static Property efuse_ctrl_props[] = {
>  static void efuse_ctrl_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
> -    dc->reset = efuse_ctrl_reset;
> +    rc->phases.hold = efuse_ctrl_reset_hold;
>      dc->realize = efuse_ctrl_realize;
>      dc->vmsd = &vmstate_efuse_ctrl;
>      device_class_set_props(dc, efuse_ctrl_props);
> -- 
> 2.25.1
> 
> 

