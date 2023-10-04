Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6CE7B8D4A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:22:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7S1-0003jN-7B; Wed, 04 Oct 2023 15:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7Rl-0003SU-CU; Wed, 04 Oct 2023 15:22:13 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7Rg-0002TI-9K; Wed, 04 Oct 2023 15:22:12 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-504a7f9204eso234096e87.3; 
 Wed, 04 Oct 2023 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696447324; x=1697052124; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/FXvH4AVeLIX4JBWjI7WQhiI1KBXoKB/o0+b6JzizA=;
 b=jvHFkOjNnTnwV9vJ3BDhc8fugyevOcuLIwfHyj/8zR67YefLLPdj/9414XuHWFJiv/
 LIcyAAjNBOOMfKKK1RZOBOOlhSv5RlXX9i+YB3JIAfuFJunwgQWe5ycdghs9N5NAbTg5
 eb6AEsGH/16T4QUacAWQPnr2lZWyFwee8MG4IU9goJyaTCElb5gvUl/zsnr19CLUMjtw
 af0jnQxcq8YHqAMjWZX948TBEMY1UupbvDlzTt4OcoABJNHwjlwnwkhcYeWYB7LtqY/I
 JXnnBRF2DebOSiBf8talSN+jlOWz15lXukAH5SFagBfdWxgoyipm3f4vb4cEfjBn+o7m
 nRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696447324; x=1697052124;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/FXvH4AVeLIX4JBWjI7WQhiI1KBXoKB/o0+b6JzizA=;
 b=fvoGko9DyPr6m+yABfEDCXmfWPQSO54C2TNezchiyySz7cdLU4F1lnIw87YrxosHwF
 aJp1b/rk8UgHlFHhPrhPHtQv0oBGtdadA5mhFVtRKHqOIYaOUAeSzfv35Ec4DkSgPbtB
 pMQZ0r6BAjZXUE7D9Ujxhc0yoqr0RNdtKYSavqMwsSZTbEDBDEV/EOIeWB5TejauJLIw
 0WclXBYSFLzI4GoSNb+Evmyb9G0qeuEtq7Ns4J4qK3Gi3IoeEUtp4+BxlzIi3GkUMWZB
 ICB81iY1b0ECUwkaJ53XNU9cB3j2ZsuWyBy2fAjekmA4UWik8RjLLctvmqihwKABY43M
 +5vg==
X-Gm-Message-State: AOJu0Yyt79nAI03L1jWaFxecL+Jq+u7b+s6ClwHIKK6BC8uDW0pzJH/v
 ituMkw1T+S8xEpFplk/F2ks=
X-Google-Smtp-Source: AGHT+IE2UHZPF/1mFMcgjN3fDZO3KpVD3j/Mant69uN/Kjg/D4JpcYrJ4150v3cn58DpyCUXWatPGg==
X-Received: by 2002:a05:6512:3095:b0:503:2a53:7480 with SMTP id
 z21-20020a056512309500b005032a537480mr3187139lfd.49.1696447324370; 
 Wed, 04 Oct 2023 12:22:04 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 c22-20020ac25316000000b00502d7365e8fsm715351lfh.137.2023.10.04.12.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 12:22:04 -0700 (PDT)
Date: Wed, 4 Oct 2023 21:22:02 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com, peter.maydell@linaro.org
Subject: Re: [PATCH] xlnx-bbram: hw/nvram: Use dot in device type name
Message-ID: <20231004192202.GF18959@fralle-msi>
References: <20231003052139.199665-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003052139.199665-1-tong.ho@amd.com>
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

On [2023 Oct 02] Mon 22:21:39, Tong Ho wrote:
> This replaces the comma (,) to dot (.) in the device type name
> so the name can be used with the 'driver=' command line option.
> 
> Signed-off-by: Tong Ho <tong.ho@amd.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  include/hw/nvram/xlnx-bbram.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
> index 87d59ef3c0..6fc13f8cc1 100644
> --- a/include/hw/nvram/xlnx-bbram.h
> +++ b/include/hw/nvram/xlnx-bbram.h
> @@ -34,7 +34,7 @@
>  
>  #define RMAX_XLNX_BBRAM ((0x4c / 4) + 1)
>  
> -#define TYPE_XLNX_BBRAM "xlnx,bbram-ctrl"
> +#define TYPE_XLNX_BBRAM "xlnx.bbram-ctrl"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxBBRam, XLNX_BBRAM);
>  
>  struct XlnxBBRam {
> -- 
> 2.25.1
> 
> 

