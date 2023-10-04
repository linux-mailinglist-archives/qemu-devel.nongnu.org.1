Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603C7B8D49
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7Qg-0000fH-Tw; Wed, 04 Oct 2023 15:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7Qd-0000Uh-DA; Wed, 04 Oct 2023 15:21:03 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7Qa-0002Gg-PV; Wed, 04 Oct 2023 15:21:02 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5033918c09eso216348e87.2; 
 Wed, 04 Oct 2023 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696447257; x=1697052057; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tYTiak3/0bWBm11AAZ6N5wEs3JE+pIf/Mh2FyXA03s=;
 b=OBiFe7iP+kS5CpJn5bqfrOfxGou3ZbSGyvACMz7Lmguz8B1Xozpf8BYG7L0JJyezG2
 /wuutQhd/pkp2dVB1L1SJOyJv5IGbndo57DJXxgIbHYpehK8IgpNESmxD5XNhiQxBDB3
 sIvtwCS3ZLI0XGJydLZBplTqXCICiqkc64EtmTzJvcLYrU2/CT9rG+5VG1Z4rLy2zE21
 DPy399YB0lVbJlt1Qc57SiEoI3UVlACuYHC/4ITf0scoqovGkPf4kw5a9Nkc/Fs5hyku
 N+1XnAFDXJLEGGIDkuB3PHWGHuPI4YdNb9flbOkx88D34bHq3UGbRWPqaoSZpU07Mg/O
 XF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696447257; x=1697052057;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tYTiak3/0bWBm11AAZ6N5wEs3JE+pIf/Mh2FyXA03s=;
 b=MX8azrWC0DgOpzRMu+/UKTnByxyzY+P4v6r8VW15AJN3Lcy8SNiPaCNuzR4CpRzqbd
 UaIeFHjy+XdT3Nr0/CRfGC+JwUqvZZV6trG0YOzEH+pa6QW7MpgjPe3kQMGR/37Hw+LM
 hMm6EG46mCVHg9NgUubYCWNqK4kj9wneVzmTY5A+ABDpLIjwewKDyrAqMg5HTZm40pgn
 he6+J6XM9DCDVvSQhTum3EH1dDdu5qlzL+9BbYZVyV+XkC5PSqujzdvtFjeNz6OBqwNp
 CWxt8BuwABBDBlv+FvPxYosEXsvqOcWDymguTn8r2NX6XHw1zvW0AT8FWJ3a8l1n48pi
 oWaw==
X-Gm-Message-State: AOJu0Yz93u9dlctp9XPr5Xt/wSHDv3Yx/5Ecbvi81YGV4yAa5XgPuwvx
 N9PMUm3SKPu9zdI25kRPhV8=
X-Google-Smtp-Source: AGHT+IFeeJRxVdXCtmE/EwbMbvHT8ycv2c+kXv6CugLFk9SMA1Sr2Y0Quq9rGTdwTmxnNhIk6+YKkg==
X-Received: by 2002:a05:6512:39d1:b0:500:ac71:8464 with SMTP id
 k17-20020a05651239d100b00500ac718464mr3433128lfu.66.1696447257377; 
 Wed, 04 Oct 2023 12:20:57 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a2e3813000000b002c182a942f1sm768031lja.139.2023.10.04.12.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 12:20:57 -0700 (PDT)
Date: Wed, 4 Oct 2023 21:20:55 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com, peter.maydell@linaro.org
Subject: Re: [PATCH] xlnx-zynqmp-efuse: hw/nvram: Remove deprecated device
 reset
Message-ID: <20231004192055.GD18959@fralle-msi>
References: <20231004055713.324009-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004055713.324009-1-tong.ho@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x134.google.com
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

On [2023 Oct 03] Tue 22:57:13, Tong Ho wrote:
> This change implements the ResettableClass interface for the device.
> 
> Signed-off-by: Tong Ho <tong.ho@amd.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/nvram/xlnx-zynqmp-efuse.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
> index 228ba0bbfa..3db5f98ec1 100644
> --- a/hw/nvram/xlnx-zynqmp-efuse.c
> +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> @@ -2,6 +2,7 @@
>   * QEMU model of the ZynqMP eFuse
>   *
>   * Copyright (c) 2015 Xilinx Inc.
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
>   *
>   * Written by Edgar E. Iglesias <edgari@xilinx.com>
>   *
> @@ -769,9 +770,9 @@ static void zynqmp_efuse_register_reset(RegisterInfo *reg)
>      register_reset(reg);
>  }
>  
> -static void zynqmp_efuse_reset(DeviceState *dev)
> +static void zynqmp_efuse_reset_hold(Object *obj)
>  {
> -    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(dev);
> +    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
>      unsigned int i;
>  
>      for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> @@ -837,8 +838,9 @@ static Property zynqmp_efuse_props[] = {
>  static void zynqmp_efuse_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
> -    dc->reset = zynqmp_efuse_reset;
> +    rc->phases.hold = zynqmp_efuse_reset_hold;
>      dc->realize = zynqmp_efuse_realize;
>      dc->vmsd = &vmstate_efuse;
>      device_class_set_props(dc, zynqmp_efuse_props);
> -- 
> 2.25.1
> 
> 

