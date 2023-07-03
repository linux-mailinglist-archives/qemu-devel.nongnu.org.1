Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70231745A65
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:36:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGvH-0003k1-10; Mon, 03 Jul 2023 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1qGCpt-0003Xj-VH
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:14:58 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1qGCps-0007et-33
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:14:57 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-55ba5fae2e6so477746a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688364894; x=1690956894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V+4jldnudEBFT3bjhpQUMs49BbJ+34mvXH1GHSb5pvU=;
 b=sHVK1k7NLAkXz8dBJiDHVQ2LIUWsAJwSuo0MQzimZ/Dvwh0BhJuS8yfdRODGfp3xNZ
 TRmKGZlw3hkJAcuNdtP+OfkxacbeaWUS0bFUhwbP56fLBVB/w/4Xn01rEWjzftrdNSLT
 7MnG3G0foqC9lKv1awFTPHNrvpuld1qqwCuF1jbcnCwGri0x12wS4C0Ivnr8y8B+e0CW
 WID34plw36B6AJB7vXSg8sxKJ9HKncKjbOM/BGJ1ilj/EanVpM9Bx8ye4RU1jXA06emU
 lgCFb3yx3jxoHEcTpOTO/bt8GmYdRrJa9Wur+mh5AHkaiLKfZB60yaJf8U6V6LQj1Mrx
 MjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688364894; x=1690956894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+4jldnudEBFT3bjhpQUMs49BbJ+34mvXH1GHSb5pvU=;
 b=kjS0+l3bBExudEEhWxjlNg2ZhkzJHIQBc5/PbYW9N/5QcPr2YeJpwYwubu2uT1w9YE
 83rf7Y75XNmWmz2bcvXFCRai3oOD9whWom7E+ZVPMnBkyPGWxuKVJ1ovpoxzEQvXq8kG
 ZGfuqlW9QryrFoVL/UPtGD/QwX7A4fzs1vaIhIKAH9zd7aII76Dq4NRMFfkhYs7Yhhx8
 nm+geyW+iAZVzyG5lI670omrQanjAe99bP0T5BjAsV9gYql0DSMzd+0VtdMsb7TPW0U6
 tK2s6S0tQK1Qh8xA8gcfFmaZnxxFx+862tJDU9+lF2Aihf3oDBABmhZjA5NUZsQSyyz8
 l7jg==
X-Gm-Message-State: AC+VfDzf481dvqI0bxx/uOqGexfP6e8tysNQUg1yoBi3yXCNegSaEFNY
 p5G8STt0ESLE5FG62cwpGyh39Q==
X-Google-Smtp-Source: ACHHUZ4V981fHetpC3hG/OVILih03h1DPjYYCyZo7EB9wqhtJVauGTRV6zWvd3Gg8+SBa1cKvPVusQ==
X-Received: by 2002:a05:6a20:42a9:b0:116:fd37:c924 with SMTP id
 o41-20020a056a2042a900b00116fd37c924mr13441786pzj.5.1688364893775; 
 Sun, 02 Jul 2023 23:14:53 -0700 (PDT)
Received: from leoy-yangtze.lan ([8.45.48.113])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a62ae11000000b00679dc747738sm11013913pff.10.2023.07.02.23.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 23:14:53 -0700 (PDT)
Date: Mon, 3 Jul 2023 14:14:45 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org
Subject: Re: [PATCH v1 2/2] xen_arm: Initialize RAM and add hi/low memory
 regions
Message-ID: <20230703061445.GA1606549@leoy-yangtze.lan>
References: <20230629174310.14434-3-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629174310.14434-3-vikram.garhwal@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=leo.yan@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Jul 2023 06:36:45 -0400
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

Hi Vikram,

On Thu, Jun 29, 2023 at 10:43:10AM -0700, Oleksandr Tyshchenko wrote:

[...]

>  void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
>  {
>      hw_error("Invalid ioreq type 0x%x\n", req->type);
> @@ -135,6 +170,14 @@ static void xen_arm_init(MachineState *machine)
>  
>      xam->state =  g_new0(XenIOState, 1);
>  
> +    if (machine->ram_size == 0) {
> +        DPRINTF("ram_size not specified. QEMU machine will be started without"
> +                " TPM, IOREQ and Virtio-MMIO backends\n");
> +        return;
> +    }
> +
> +    xen_init_ram(machine);
> +
>      xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
>  
>      xen_create_virtio_mmio_devices(xam);
> @@ -182,6 +225,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = xen_arm_init;
>      mc->max_cpus = 1;
>      mc->default_machine_opts = "accel=xen";
> +    /* Set explicitly here to make sure that real ram_size is passed */
> +    mc->default_ram_size = 0;

This patch fails to apply on my side on QEMU 8.0.0.

>      printf("CHECK for NEW BUILD\n");

The printf sentence is introduced unexpectly, right?

Thanks,
Leo

>  #ifdef CONFIG_TPM
> -- 
> 2.25.1

