Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC037E48D4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RDs-0007zB-8W; Tue, 07 Nov 2023 13:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RDk-0007mr-DH; Tue, 07 Nov 2023 13:54:40 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RDi-0002iM-Dj; Tue, 07 Nov 2023 13:54:39 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ae143e08b1so71024177b3.1; 
 Tue, 07 Nov 2023 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699383277; x=1699988077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UHmV31Lev87Ezs71ZEGTVtqppGVWg13VEdB/gsd5p/U=;
 b=La2RPm44Esi4WKvkZoGvUQXtS7aS42fpTSV1cvTVYEKnX5Ue99i5uwIpIU2V+PJy62
 kbAQWDE+xKCrG3shXU0+KRNAjwdj2PrqW8q0cSawiC5xVyhuD0KN39SEcNb+ZdaFeTVw
 P17io6crsXiLOfc823FFvQXziwq1/KcSaDRcFn9CxOoLQs0PjJWQVHgjeFnleRBLgdaY
 sMyseRbtunXOMBaFWhlqUc2Z35KDO0SZVLC8jj+qa2VA6jxj7lwP+Sn+581gDI79C5FA
 uAROgLNDFGeI09tO4ZVzHNEk9gN9EXKBZctHVTsMW6YUMoFGDN3EzbRyOZT96U4ShoFg
 uGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383277; x=1699988077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UHmV31Lev87Ezs71ZEGTVtqppGVWg13VEdB/gsd5p/U=;
 b=sa7QT24CIqH2Yn5uLAQxhXPS1hqn/y7LU6YCRHlDDNAI6HO3PiHsotWFdaLOSPE5us
 sG4Zg19eq634jlfw3IiDwEYw8gplb+2vC1qSdL9O6F0EVrz9YGc/1bJSwySMvev/8BdM
 8nU1+heJKC4T1tbp6bCIwxB/rj/XCsPInWSqLY3NuJVvJ9dgcxFG8Kh6S67yCQL6iuRF
 8FrzMg8ySP/90N39Gdh48z82VI4UEbNiqHGLUQU/Vp5ArrYslWduNr3Do6DgRrWudssp
 sUqOJDB4VqgOAk6OgWKDrINBmiWKceEfuiOYAC3EryM6VTAJoHhW9v77xD5g/+2Lco1s
 4u6Q==
X-Gm-Message-State: AOJu0Yy8MGG2NrrDmrLXUuHAbYlwK1gq8ZQ3bY/XjHtKL11y/SCQ2D33
 oaKUZX3qE/WP4sDScvFKE+w=
X-Google-Smtp-Source: AGHT+IE2u/sV4glCt5xLIJWvmzgyXfiTdZuqi4j+1JPRrWLE6MxTx2oY+DxHo//EguXubum/Yqsphg==
X-Received: by 2002:a5b:c4a:0:b0:da0:cafa:815b with SMTP id
 d10-20020a5b0c4a000000b00da0cafa815bmr31941284ybr.31.1699383277074; 
 Tue, 07 Nov 2023 10:54:37 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a259111000000b00d7b8a1074d4sm5286568ybl.57.2023.11.07.10.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:54:36 -0800 (PST)
Message-ID: <2c4ec92e-8296-4dcc-a2af-0dd9d3004ac9@gmail.com>
Date: Tue, 7 Nov 2023 15:54:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ppc/pnv: Fix number of I2C engines and ports for
 power9/10
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com
References: <20231025152714.956664-1-milesg@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231025152714.956664-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=danielhb413@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 10/25/23 12:27, Glenn Miles wrote:
> Power9 is supposed to have 4 PIB-connected I2C engines with the
> following number of ports on each engine:
> 
>      0: 2
>      1: 13
>      2: 2
>      3: 2
> 
> Power10 also has 4 engines but has the following number of ports
> on each engine:
> 
>      0: 14
>      1: 14
>      2: 2
>      3: 16
> 
> Current code assumes that they all have the same (maximum) number.
> This can be a problem if software expects to see a certain number
> of ports present (Power Hypervisor seems to care).
> 
> Fixed this by adding separate tables for power9 and power10 that
> map the I2C controller number to the number of I2C buses that should
> be attached for that engine.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
> ([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)
> 
> Changes from v2:
>      - Moved I2C port definitions close to the class definitions
>      - Changed I2C port array type to const
> 
>   hw/ppc/pnv.c              | 12 ++++++++----
>   include/hw/ppc/pnv_chip.h |  6 ++----
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2655b6e506..1a728b92a0 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1626,7 +1626,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>           Object *obj =  OBJECT(&chip9->i2c[i]);
>   
>           object_property_set_int(obj, "engine", i + 1, &error_fatal);
> -        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +        object_property_set_int(obj, "num-busses",
> +                                pcc->i2c_ports_per_engine[i],
>                                   &error_fatal);
>           object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
>           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> @@ -1651,6 +1652,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PnvChipClass *k = PNV_CHIP_CLASS(klass);
> +    static const int i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
>   
>       k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
>       k->cores_mask = POWER9_CORE_MASK;
> @@ -1667,7 +1669,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>       dc->desc = "PowerNV Chip POWER9";
>       k->num_pecs = PNV9_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
> -    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
> +    k->i2c_ports_per_engine = i2c_ports_per_engine;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power9_realize,
>                                       &k->parent_realize);
> @@ -1877,7 +1879,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>           Object *obj =  OBJECT(&chip10->i2c[i]);
>   
>           object_property_set_int(obj, "engine", i + 1, &error_fatal);
> -        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
> +        object_property_set_int(obj, "num-busses",
> +                                pcc->i2c_ports_per_engine[i],
>                                   &error_fatal);
>           object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
>           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
> @@ -1902,6 +1905,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PnvChipClass *k = PNV_CHIP_CLASS(klass);
> +    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
>   
>       k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
>       k->cores_mask = POWER10_CORE_MASK;
> @@ -1918,7 +1922,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>       dc->desc = "PowerNV Chip POWER10";
>       k->num_pecs = PNV10_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> -    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
> +    k->i2c_ports_per_engine = i2c_ports_per_engine;
>   
>       device_class_set_parent_realize(dc, pnv_chip_power10_realize,
>                                       &k->parent_realize);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 5815d96ecf..0ab5c42308 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -88,8 +88,7 @@ struct Pnv9Chip {
>   #define PNV9_CHIP_MAX_PEC 3
>       PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
>   
> -#define PNV9_CHIP_MAX_I2C 3
> -#define PNV9_CHIP_MAX_I2C_PORTS 1
> +#define PNV9_CHIP_MAX_I2C 4
>       PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
>   };
>   
> @@ -122,7 +121,6 @@ struct Pnv10Chip {
>       PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
>   
>   #define PNV10_CHIP_MAX_I2C 4
> -#define PNV10_CHIP_MAX_I2C_PORTS 2
>       PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
>   };
>   
> @@ -140,7 +138,7 @@ struct PnvChipClass {
>       uint32_t     num_phbs;
>   
>       uint32_t     i2c_num_engines;
> -    uint32_t     i2c_num_ports;
> +    const int    *i2c_ports_per_engine;
>   
>       DeviceRealize parent_realize;
>   

