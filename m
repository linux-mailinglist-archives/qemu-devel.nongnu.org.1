Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4417B80607D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:14:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcjX-0002B4-Vn; Tue, 05 Dec 2023 16:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1rAcjV-0002AT-Sx; Tue, 05 Dec 2023 16:13:33 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1rAcjT-0002hV-UH; Tue, 05 Dec 2023 16:13:33 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50bf4f97752so3664624e87.1; 
 Tue, 05 Dec 2023 13:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701810809; x=1702415609; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSnts+DjeJW59pYGClkR2eHh3EHs7M5AyvMgXOnU0bs=;
 b=SGSNqq6anBMrO6eULF6VX/a2inucNGUIJKGKOadazemVATtSrJWXMCV7RaEV8V51Kp
 iOHx5MJRlgJlkDoAB26SRQGf5P0RAq0pbeJ69YUGLFrJqOq0LHXoMRjAIgjspjiNty9d
 oopd9YK+ZLQoPS5q6frDT5wG2t0LujeMmP0TN9TXhOuZivtX2x8LZSIjLVOJJm7KWcKK
 wzQ+KWEY9CrRwh9kq7xCnyrTZK5+O7bw27Lc9DTlHEqy/03l7yMwFGYPCColSjUo1+XI
 lL5P/AT6iO89HhHtS4qFqrETI2JgldzBXgj4rZba3PDs7SdWGwhvtto6+QaAFWHBJZYj
 cZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701810809; x=1702415609;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSnts+DjeJW59pYGClkR2eHh3EHs7M5AyvMgXOnU0bs=;
 b=kPj7fs14FthZyNyes/rXs7VrJzvxq8uo9JOCQ+R2NcjDbdgLwT0u0O5BR91XFBRKNG
 pq/Uz21x+yx/gzmhlHp9g3vJfv6yC0NZIIs1XNs9Rx9opxL8G8qNlN3S/mMss7IQEbH/
 UyISgDSoPkwjpV68e7/DxsPEYrr4VlyD/gjsUQXnWcb7fil/nw9vWDzEOpqvZ7y/wrpT
 LYe1x8H/n3NYxu5+k7QTNhj5wVDNzEv8Q2zC5GvkK6S8zA/EfB1Cdh8KjjNHVytNrZuL
 +zGpkpSDhKvzEi981C+Q75XT+DZ/Vp2opUyP/NP57K5jGG8aHOLcafZd+u9l9dQLT4lU
 eI2Q==
X-Gm-Message-State: AOJu0YwKdJuDQ82pXYUrRqB4oPhI7njUaXlYyP68jpJZN/AGhsTKWclJ
 5gPTs/KAQ5GrONDMiqx3qIg=
X-Google-Smtp-Source: AGHT+IGQoh6rojSTmMWfLu+V1GVIDIliJYEpz3/a1y+u1vPvnEu3J8u5qUWOvglzcW3fZhnaX32xpw==
X-Received: by 2002:ac2:5dd4:0:b0:50b:e9ec:4e2c with SMTP id
 x20-20020ac25dd4000000b0050be9ec4e2cmr2904844lfq.104.1701810809243; 
 Tue, 05 Dec 2023 13:13:29 -0800 (PST)
Received: from fralle-msi (217-76-87-105.cust.bredband2.com. [217.76.87.105])
 by smtp.gmail.com with ESMTPSA id
 m12-20020ac24acc000000b0050bc6ab211dsm1660905lfp.208.2023.12.05.13.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:13:29 -0800 (PST)
Date: Tue, 5 Dec 2023 22:13:27 +0100
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, saipavanboddu@gmail.com
Subject: Re: [PATCH 2/2] arm: xlnx-versal-virt: Add machine property ospi-flash
Message-ID: <20231205211327.GC9927@fralle-msi>
References: <20231205095226.2688032-1-sai.pavan.boddu@amd.com>
 <20231205095226.2688032-3-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205095226.2688032-3-sai.pavan.boddu@amd.com>
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

On [2023 Dec 05] Tue 15:22:26, Sai Pavan Boddu wrote:
> This property allows users to change flash model on command line as
> below.
> 
>    ex: "-M xlnx-versal-virt,ospi-flash=mt35xu02gbba"
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/arm/xlnx-versal-virt.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 537118224f..c57cff74d8 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -49,6 +49,7 @@ struct VersalVirt {
>      struct {
>          bool secure;
>      } cfg;
> +    char *ospi_model;
>  };
>  
>  static void fdt_create(VersalVirt *s)
> @@ -637,6 +638,22 @@ static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
>                             &error_fatal);
>  }
>  
> +static char *versal_get_ospi_model(Object *obj, Error **errp)
> +{
> +    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +
> +    return g_strdup(s->ospi_model);
> +}
> +
> +static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
> +{
> +    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +
> +    g_free(s->ospi_model);
> +    s->ospi_model = g_strdup(value);
> +}
> +
> +
>  static void versal_virt_init(MachineState *machine)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
> @@ -736,7 +753,7 @@ static void versal_virt_init(MachineState *machine)
>  
>          spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
>  
> -        flash_dev = qdev_new("mt35xu01g");
> +        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
>          if (dinfo) {
>              qdev_prop_set_drive_err(flash_dev, "drive",
>                                      blk_by_legacy_dinfo(dinfo), &error_fatal);
> @@ -769,6 +786,13 @@ static void versal_virt_machine_instance_init(Object *obj)
>                               0);
>  }
>  
> +static void versal_virt_machine_finalize(Object *obj)
> +{
> +    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +
> +    g_free(s->ospi_model);
> +}
> +
>  static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -780,6 +804,10 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
>      mc->no_cdrom = true;
>      mc->default_ram_id = "ddr";
> +    object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
> +                                   versal_set_ospi_model);
> +    object_class_property_set_description(oc, "ospi-flash",
> +                                          "Change the OSPI Flash model");
>  }
>  
>  static const TypeInfo versal_virt_machine_init_typeinfo = {
> @@ -788,6 +816,7 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
>      .class_init = versal_virt_machine_class_init,
>      .instance_init = versal_virt_machine_instance_init,
>      .instance_size = sizeof(VersalVirt),
> +    .instance_finalize = versal_virt_machine_finalize,
>  };
>  
>  static void versal_virt_machine_init_register_types(void)
> -- 
> 2.25.1
> 

