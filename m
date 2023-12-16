Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489A815BA5
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 21:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEb9V-0004CZ-1J; Sat, 16 Dec 2023 15:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEb9Q-000496-HF
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:20:45 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEb9O-0003w7-8H
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:20:43 -0500
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-54cb4fa667bso2128798a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 12:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702758041; x=1703362841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zr6TFRFqWVdDB6s06mSZC+V44D3rrL8TGs0WnwxxW0g=;
 b=E8Ls4W+B26n63HKiPDOv7pze6Oai/vAe8itdlHxa5ROgMBjqRhA+2HPT0FFq+PwfZ/
 0R0Vp4jJHBc6tIsxYatOXFnwB4+KtjXQ3ELjw/t6R/CYZiirpmflg+MXtRPSCiiRWMpT
 K1JUi4URoMpCIng3Q1oH2Grr+FVvGRKDcJEitmTwiYyPL95NCJL+eAjeEZNEcO70oZpH
 5NLnoUmaZSdLtiI9zOTkRkJYr0eu0SJ/ucCSbu+8S2X+ulnNUJw7/KeTgHG1uMP56qMy
 92PQ2WCZslW9hCcfCWSOxWT0VUcMD/Ye1uWlJdn7jNq5Ftxr/GzlyThARfbe+ZXDQyef
 sWcQ==
X-Gm-Message-State: AOJu0YyOgTxNr60KEO3rt10pnw3RyCGs3N85nPi0jrCSn/ie3RqYr8tY
 ++059sU99oddpfRtYz6Cl6q1SX7xSBQ=
X-Google-Smtp-Source: AGHT+IGJv6rl2oq1tuxI60IMB1IcB+YfpX/ZaJpToRkZSckHzuetyD43oW663C6gusyh9YedrnXDrA==
X-Received: by 2002:a17:906:154:b0:a22:fb34:dab5 with SMTP id
 20-20020a170906015400b00a22fb34dab5mr2663765ejh.67.1702758040684; 
 Sat, 16 Dec 2023 12:20:40 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 ty6-20020a170907c70600b00a1d71c57cb1sm12259732ejc.68.2023.12.16.12.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 12:20:40 -0800 (PST)
Date: Sat, 16 Dec 2023 21:20:38 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 11/12] next-cube.c: replace sysmem with
 get_system_memory() in next_cube_init()
Message-ID: <20231216212038.45ece9fb@fedora>
In-Reply-To: <20231215200009.346212-12-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Fri, 15 Dec 2023 20:00:08 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Removing the intermediate variable helps simplify the code in next_cube_init().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index d9a1f234ec..73deef25ca 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -974,7 +974,6 @@ static void next_cube_init(MachineState *machine)
>      MemoryRegion *dmamem = g_new(MemoryRegion, 1);
>      MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
>      MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
> -    MemoryRegion *sysmem = get_system_memory();
>      const char *bios_name = machine->firmware ?: ROM_FILE;
>      DeviceState *pcdev;
>  
> @@ -996,7 +995,8 @@ static void next_cube_init(MachineState *machine)
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(pcdev), &error_fatal);
>  
>      /* 64MB RAM starting at 0x04000000  */
> -    memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
> +    memory_region_add_subregion(get_system_memory(), 0x04000000,
> +                                machine->ram);
>  
>      /* Framebuffer */
>      sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
> @@ -1010,19 +1010,19 @@ static void next_cube_init(MachineState *machine)
>      /* BMAP memory */
>      memory_region_init_ram_flags_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
>                                             RAM_SHARED, &error_fatal);
> -    memory_region_add_subregion(sysmem, 0x020c0000, bmapm1);
> +    memory_region_add_subregion(get_system_memory(), 0x020c0000, bmapm1);
>      /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
>      memory_region_init_alias(bmapm2, NULL, "next.bmapmem2", bmapm1, 0x0, 64);
> -    memory_region_add_subregion(sysmem, 0x820c0000, bmapm2);
> +    memory_region_add_subregion(get_system_memory(), 0x820c0000, bmapm2);
>  
>      /* KBD */
>      sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
>  
>      /* Load ROM here */
>      memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
> -    memory_region_add_subregion(sysmem, 0x01000000, rom);
> +    memory_region_add_subregion(get_system_memory(), 0x01000000, rom);
>      memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
> -    memory_region_add_subregion(sysmem, 0x0, rom2);
> +    memory_region_add_subregion(get_system_memory(), 0x0, rom2);
>      if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
>          if (!qtest_enabled()) {
>              error_report("Failed to load firmware '%s'.", bios_name);
> @@ -1051,7 +1051,7 @@ static void next_cube_init(MachineState *machine)
>      /* DMA */
>      memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
>                            0x5000);
> -    memory_region_add_subregion(sysmem, 0x02000000, dmamem);
> +    memory_region_add_subregion(get_system_memory(), 0x02000000, dmamem);
>  }

Mostly a matter of taste, but I'd prefer to keep it like it was before - I
dislike calling functions multiple times if one time is sufficient.

 Thomas

