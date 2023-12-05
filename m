Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F9805EF5
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAbZL-00073R-Kx; Tue, 05 Dec 2023 14:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1rAbZJ-00072r-W2; Tue, 05 Dec 2023 14:58:58 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1rAbZI-00069C-Gg; Tue, 05 Dec 2023 14:58:57 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50bf69afa99so3481306e87.3; 
 Tue, 05 Dec 2023 11:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701806333; x=1702411133; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DONy33HVQoYe8nBI7bz9dVQwsdTfkcWQcQcHaJxluDk=;
 b=WJKYJzJKitWUV2yIs/AhayQaVXHm3nvXG0Trvhsj9g8TCbf8ZXLdcAC+DPwoQLz1PP
 nKBYM2BoPCa7neFdzzOFWJ9LhJGvdfpz4MQNiLDeHYEH5Gdg6JjhqEEE+vloT0rCeLDx
 zSMLde34MYP2i91l1B2aPU1blODWs3k11sdf8Klhs1/f42gDMuDJ884saL4YhhzoyBtj
 iha6bLRxBk2R2Qtej7pIJsomO2cRcyAMfWqE3/2Jid+iWyUwZnsiDXOM+c9UsojK2lLQ
 vfEY/N7hMQ5mmLNY8W8u2PSleb+U5oZbnS3mVrUDoHfXv9lJlGXHC5ZOTK+XfjvjzOaA
 dEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701806333; x=1702411133;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DONy33HVQoYe8nBI7bz9dVQwsdTfkcWQcQcHaJxluDk=;
 b=b6+CHIfCuKfjsWyK3Qpau7MAX5oZGtY7CpSXVBeYdY4m/Modo1rNjtA8jtz+h+eO4H
 ucnntCktMeKXv4PF+8uJInXGC7Ho4VPSbC3Sd0IQ1YnFLRBsH125Pmo24DgV0Sw3o6SV
 h1QT5LB9Hf4oM0zeI6OkJ8WCPg9T8T3TK1yVVx87BKcrRlHszW3SOLD2HXSfgYIWfO7E
 Wntl6OjAloDMNxyS2iPLNS+a/YyxbF8A+yC6zshX8EbBB0i2aONiJO7Ihs3TiKxnVVh6
 HApmO69Mo0vXgr6v9SnHok9yQ3iTD5TIRmKC7nrojUgDDzEqB4Yw3+f78Jv+Xy2KMR4y
 fg9Q==
X-Gm-Message-State: AOJu0YwKHD7Mh2o/sVIB+4wDctzX0xWZreZ1KkMv+Fmo4/DABFsLYnnR
 EQwJ+88NriD7KHdoh3YAqTE=
X-Google-Smtp-Source: AGHT+IE0zNx+zUyuWHGyCTvgt0YxhH0yfUOWPJurcL8YhWmwLFTCFryhHYx1Y7cFRmKJBED+j3YUcQ==
X-Received: by 2002:ac2:548f:0:b0:50b:f486:88b3 with SMTP id
 t15-20020ac2548f000000b0050bf48688b3mr2338892lfk.106.1701806333382; 
 Tue, 05 Dec 2023 11:58:53 -0800 (PST)
Received: from fralle-msi (217-76-87-105.cust.bredband2.com. [217.76.87.105])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a197516000000b0050bfbde3901sm570049lfe.297.2023.12.05.11.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 11:58:52 -0800 (PST)
Date: Tue, 5 Dec 2023 20:58:51 +0100
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, saipavanboddu@gmail.com
Subject: Re: [PATCH 1/1] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
Message-ID: <20231205195850.GA9927@fralle-msi>
References: <20231205094802.2683581-1-sai.pavan.boddu@amd.com>
 <20231205094802.2683581-2-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205094802.2683581-2-sai.pavan.boddu@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
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

On [2023 Dec 05] Tue 15:18:02, Sai Pavan Boddu wrote:
> The OSPI DMA reads flash data through the OSPI linear address space (the
> iomem_dac region), because of this the reentrancy guard introduced in
> commit a2e1753b ("memory: prevent dma-reentracy issues") is disabled for
> the memory region.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>


> ---
>  hw/ssi/xlnx-versal-ospi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
> index 1a61679c2f..5123e7dde7 100644
> --- a/hw/ssi/xlnx-versal-ospi.c
> +++ b/hw/ssi/xlnx-versal-ospi.c
> @@ -1772,6 +1772,7 @@ static void xlnx_versal_ospi_init(Object *obj)
>      memory_region_init_io(&s->iomem_dac, obj, &ospi_dac_ops, s,
>                            TYPE_XILINX_VERSAL_OSPI "-dac", 0x20000000);
>      sysbus_init_mmio(sbd, &s->iomem_dac);
> +    s->iomem_dac.disable_reentrancy_guard = true;
>  
>      sysbus_init_irq(sbd, &s->irq);
>  
> -- 
> 2.25.1
> 
> 

