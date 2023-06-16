Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A847329C0
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 10:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA4o5-0001I6-Oa; Fri, 16 Jun 2023 04:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qA4o2-0001Hv-Ri
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:27:43 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qA4o0-0007Mv-Na
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:27:42 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so475510e87.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686904057; x=1689496057;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gU/YOrBP4VOIcRDV1e0X16iyZ/JTJqA+PUZrtstpL90=;
 b=BIezPss2fOvsJT1ACXQqHBt7Ws3BRVquxVhlrNU09fZTjpRFasr82ofKqVdrhB5H4m
 4iWDyTqThsYs9RnUdRJjEmcFMjmjvhEICycIPUC6ecAtTV5Y9uTixAGQ1F65yRKoLrcd
 JeVcuOFvDdoDygNC/VKVxFXwiEY7KNQU3eqO2yEZ9y+6+3PN4IrvMM9LhI3PfHavVg+I
 bvIfpZ1tqDSjGUwCsp17cRm81gsuxVngQw1ZVm5jpDdXznjx06gsGs1UQNXfNF6hNWJ0
 UnN2ESmwc7IPmpWmyC7o7/NAv3xTeB+ms9fbjC5newl1ZwqUf7ATOZAoISUW3AfPVqtp
 LqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686904057; x=1689496057;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gU/YOrBP4VOIcRDV1e0X16iyZ/JTJqA+PUZrtstpL90=;
 b=Tv+IGx3wRdWzN70+rZYXIV/IS8nmG2S2SVOzZpvhVCYB37PIKZQCL7gMnSSIXCrZDW
 3qa0MeHt1LxJPIW+AYSk1MqhP+Sz4p4l9oOMSO4YydKAGMpjVCbglHpxELXepXg6hS1D
 qb0AWUQK2X2uUqL7W7I/dR9U0QXBCx+iUFcKdT9iUGsMmwe+pPwxtorbD6K1VuQp7o88
 j8Xc7FuN/jhOh8kCThNYSH7F0jrz3p0POX30DnpS90EltIZvAjJaAeb2awZEWaDxMnJg
 edKQAFTL70TeNKziclEo78ZpEujPPjnPOjC87HlxoWlqVEcmunjGJTEcerrbs/BvlopP
 /Nog==
X-Gm-Message-State: AC+VfDzylETWF0qbi+HpGPbT1EvyrQ1UWQO51pgXJSd/55QCb5yFMayq
 bqaAOKRoUrGs9ynYPcvRuVJCKFrx9LQ=
X-Google-Smtp-Source: ACHHUZ68CanCbYQrohjFiu03xraERPF3SGwHK8IRt9iIzvdG+UCTvF5LzAvbmgLmryqP9gwotI7riA==
X-Received: by 2002:a05:6512:1c5:b0:4f6:217a:5615 with SMTP id
 f5-20020a05651201c500b004f6217a5615mr671872lfp.38.1686904056332; 
 Fri, 16 Jun 2023 01:27:36 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 o7-20020ac24947000000b004efe9fc130esm459957lfi.251.2023.06.16.01.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jun 2023 01:27:36 -0700 (PDT)
Date: Fri, 16 Jun 2023 10:27:34 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Kinsey Moore <kinsey.moore@oarcorp.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/xlnx: Connect secondary CGEM IRQs
Message-ID: <20230616082734.GH6984@fralle-msi>
References: <20230615134847.4157666-1-kinsey.moore@oarcorp.com>
 <20230615134847.4157666-2-kinsey.moore@oarcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615134847.4157666-2-kinsey.moore@oarcorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x130.google.com
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

Hi Kinsey,

On [2023 Jun 15] Thu 08:48:47, Kinsey Moore wrote:
> The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
> platforms have two priority queues with separate interrupt sources for
> each. If the interrupt source for the second priority queue is not
> connected, they work in polling mode only. This change connects the
> second interrupt source for platforms where it is available. This patch
> has been tested using the lwIP stack with a Xilinx-supplied driver from
> their embeddedsw repository.
> 
> Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
> ---
>  hw/arm/xlnx-versal.c | 1 +
>  hw/arm/xlnx-zynqmp.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 60bf5fe657..a9e06b7fd1 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -272,6 +272,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>          memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
>  
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[irqs[i]]);

This is correct (thanks!) but the lines need to be connected through a
qemu_or_irq (in both places), you can look into this commit: c74ccb5dd6 for an
example (and reason).

Best regards,
Francisco

>          g_free(name);
>      }
>  }
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 5905a33015..b919b38e91 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -635,6 +635,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
>                             gic_spi[gem_intr[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 1,
> +                           gic_spi[gem_intr[i]]);
>      }
>  
>      for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
> -- 
> 2.30.2
> 
> 

