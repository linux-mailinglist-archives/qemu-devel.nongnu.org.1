Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4B7492C0
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 02:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHD8j-00044A-FE; Wed, 05 Jul 2023 20:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHD8X-00042W-UP; Wed, 05 Jul 2023 20:46:21 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHD8V-0005PN-CF; Wed, 05 Jul 2023 20:46:21 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1b3f722fdafso216181fac.3; 
 Wed, 05 Jul 2023 17:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688604376; x=1691196376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xgd0J0M/LOGIAR3jh60MvZK3voHCoMGU0yevT4UJBd8=;
 b=LvhA2xVS1odaT9QTfZYLZo/obPgCvXMNo8LB6BhOD3qQOvctOb3tq1KK1HeuldM0nB
 ijSZTK9kC6+XuySn/TIMLPU5kaQ+g2KKWSulEtagWZBDXzBj5DYiWFkDMYoXDserefCb
 H+TdKua6/51FWI52FmZPc51T3/yW3UTDJmFnJVjCt/8uDLESWeOq8k1hHHfjzrFDmLJR
 s/VOhfP/FpqYj+x5l+DQ9o5CtTLhIe8wbvrq7I7EdxqMKpQwtfsVuXI2ILt3Dv4/p472
 4OpXF799JmNR1vWk/o0VBs2mlY4hLBqcz3UIYaWYsuicP0umELiuuHKBVdkrJEaZwVWi
 2aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688604376; x=1691196376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xgd0J0M/LOGIAR3jh60MvZK3voHCoMGU0yevT4UJBd8=;
 b=fU3jGmv5QPA/D34O9P9VJ6mAQhHUFiOKI7m9ncn2JfvgEbPN1BpmMMgVjV5BvAn+cM
 aiSNnKuqPKVQ/Se0Ak6ivI8qVG1KjqSrBSs93Cb0q6K/OaiPElMCKaStdQBMR0JlAyCY
 G+UGgOV8UeR8BsI77RHG7WPbxHKkRvyRi1v+B74iNX1v/caSbnr6tWfnfoY3uILsnOCy
 8Zr/KqC9PxBhX9gLMpyCxQxmvQHRBUOIMQwW+Jj4oCzlObXJRVtGC6+Da2GyraEMG8S5
 iic02oIx+pEAvzqr5yRqXEcA1tMQrk6yvMKEEMEJYir/BL6rJsYA9i9/1CRQAwH8wJ5G
 Uu7g==
X-Gm-Message-State: ABy/qLblh7Ix8DvaanCTLPngY426SotZMPkDZ+TcsgKIFgp5O3oxJ56+
 sMzN0BV869Ovh6sLmw6fg88=
X-Google-Smtp-Source: APBJJlGQooJ+1jNjp0o4nGCPLw2nwvce/uyladwfHo25duaLLDEMccrqmBAx0Uj4jr4pPbyykkWIaw==
X-Received: by 2002:a05:6870:e392:b0:1b0:57f8:dab0 with SMTP id
 x18-20020a056870e39200b001b057f8dab0mr855182oad.17.1688604376155; 
 Wed, 05 Jul 2023 17:46:16 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 dt1-20020a0568705a8100b001b053e47bb3sm223441oab.43.2023.07.05.17.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 17:46:15 -0700 (PDT)
Message-ID: <f82474d1-c442-451b-b800-c89d062e60cf@gmail.com>
Date: Wed, 5 Jul 2023 21:46:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/14] ppc/sam460ex: Remove address_space_mem local
 variable
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1688586835.git.balaton@eik.bme.hu>
 <d134d64f13258d1f157b445fedb1e86cf3abb606.1688586835.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <d134d64f13258d1f157b445fedb1e86cf3abb606.1688586835.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.089,
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



On 7/5/23 17:12, BALATON Zoltan wrote:
> Some places already use  get_system_memory() directly so replace the
> remaining uses and drop the local variable.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   hw/ppc/sam460ex.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index aaa8d2f4a5..f098226974 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -266,7 +266,6 @@ static void main_cpu_reset(void *opaque)
>   
>   static void sam460ex_init(MachineState *machine)
>   {
> -    MemoryRegion *address_space_mem = get_system_memory();
>       MemoryRegion *isa = g_new(MemoryRegion, 1);
>       MemoryRegion *l2cache_ram = g_new(MemoryRegion, 1);
>       DeviceState *uic[4];
> @@ -406,7 +405,8 @@ static void sam460ex_init(MachineState *machine)
>       /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
>       memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram", 256 * KiB,
>                              &error_abort);
> -    memory_region_add_subregion(address_space_mem, 0x400000000LL, l2cache_ram);
> +    memory_region_add_subregion(get_system_memory(), 0x400000000LL,
> +                                l2cache_ram);
>   
>       /* USB */
>       sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400,
> @@ -444,13 +444,13 @@ static void sam460ex_init(MachineState *machine)
>       /* SoC has 4 UARTs
>        * but board has only one wired and two are present in fdt */
>       if (serial_hd(0) != NULL) {
> -        serial_mm_init(address_space_mem, 0x4ef600300, 0,
> +        serial_mm_init(get_system_memory(), 0x4ef600300, 0,
>                          qdev_get_gpio_in(uic[1], 1),
>                          PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
>                          DEVICE_BIG_ENDIAN);
>       }
>       if (serial_hd(1) != NULL) {
> -        serial_mm_init(address_space_mem, 0x4ef600400, 0,
> +        serial_mm_init(get_system_memory(), 0x4ef600400, 0,
>                          qdev_get_gpio_in(uic[0], 1),
>                          PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
>                          DEVICE_BIG_ENDIAN);

