Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2B828398
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:59:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN8sK-0005rW-F8; Tue, 09 Jan 2024 04:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8sG-0005rL-Qh
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:58:20 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8sF-0004eJ-2j
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:58:20 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d509222c11so7750405ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 01:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704794296; x=1705399096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YseRKKQFSzdDy9gl2pqQfajs8QCJKgkIsrKgczkQDCg=;
 b=MBFEOK1bJpFNzaHpcxSBqMTfT35hlcHLwOORT/K49sni0nvurPi8ya4pdwh3wPmB8z
 ctj/uDG6k3syuTaIOewAkww5k6o3ro8yc/s3jxi3yX9eyIK1yWxIicJe5VRVC8/vuwwQ
 qvSoIGu4MZ3N9/+2uaYS5cy+kIof5nnYJNVsakLSwvlF10NJ2RiYANc4YT8Fj+P4bDVE
 sFPLN2vhtnEJz8dwMGOQs55Fuq0YOCdckZEj6MxsmyVlPum3wUqb+OZ77ELLSKM7bRSd
 KOgS4cKg2Cxougtf1/JNVsxCyHGBbg0qUNJwY3zIyfhCdaxXn7J8AfXmsDVPUz3ISZrT
 U2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704794296; x=1705399096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YseRKKQFSzdDy9gl2pqQfajs8QCJKgkIsrKgczkQDCg=;
 b=HKe0Bk2JzGytPZLnia0HEQEZqFLi3wQ1Hb9rL2TUYM1TriEBUTHiPkVocEriFv5wnu
 DO0uxPmq6Vx6xT2Kkd3wk1NeYhwtg2ILCAM2YgzD7rENMr1XCAyJgXxzchvn9QdYX1I+
 gFUnmdoE1PqSvEwTyiYo2fvFqnSbwM/0CtiBLPwuAsRiWtyWusD2O0XRz4o8M1fRjq3H
 HUAnnQ5VehJ7YScb9si1t2FlhagM8hIQLAOl7BDRZ0DjdXkFHSjuuVYywFEpJ3GybheQ
 XP5N2zy9uFk9P7/3uY2vVhlN19FboijfZHqm6GSEXstwsNmzOltDtwPsSM6DqYpOr7kU
 KVDw==
X-Gm-Message-State: AOJu0YxbrZ+vpqBq+0Djq2yoOxPRaoFtSRC2nT/lfQ5Vc3bpKWIGS03a
 HEHkdxkoldAyMOk/U1j10AE+Gj0g6Kzd3Q==
X-Google-Smtp-Source: AGHT+IGcZo7ralkQPUJA4rECf97XAt0IYgdflyNlYA4OnUlpOYHzohTYXVtubZ8/czyYoHu/Cnhpmg==
X-Received: by 2002:a17:902:d2cb:b0:1d4:7e51:ff6c with SMTP id
 n11-20020a170902d2cb00b001d47e51ff6cmr2973523plc.121.1704794296593; 
 Tue, 09 Jan 2024 01:58:16 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a1709026b4700b001c9d011581dsm1382600plt.164.2024.01.09.01.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 01:58:16 -0800 (PST)
Message-ID: <3cc1664c-9f5c-4d2f-b8f3-f8880c110e10@linaro.org>
Date: Tue, 9 Jan 2024 20:57:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/hppa/machine: Disable default devices with
 --nodefaults option
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-3-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240107132237.50553-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/8/24 00:22, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add support for the qemu --nodefaults option, which will disable the
> following default devices:
> - lsi53c895a SCSI controller,
> - artist graphics card,
> - LASI 82596 NIC,
> - tulip PCI NIC,
> - second serial PCI card,
> - USB OHCI controller.
> 
> Adding this option is very useful to allow manual testing and
> debugging of the other possible devices on the command line.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/machine.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index b11907617e..8017002a2a 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -346,11 +346,14 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       SysBusDevice *s;
>   
>       /* SCSI disk setup. */
> -    dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
> -    lsi53c8xx_handle_legacy_cmdline(dev);
> +    if (defaults_enabled()) {
> +        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
> +        lsi53c8xx_handle_legacy_cmdline(dev);
> +    }
>   
>       /* Graphics setup. */
> -    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
> +    if (defaults_enabled() && machine->enable_graphics &&
> +        vga_interface_type != VGA_NONE) {
>           vga_interface_created = true;
>           dev = qdev_new("artist");
>           s = SYS_BUS_DEVICE(dev);
> @@ -360,7 +363,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       }
>   
>       /* Network setup. */
> -    if (enable_lasi_lan()) {
> +    if (defaults_enabled() && enable_lasi_lan()) {
>           lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
>                           qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
>       }
> @@ -385,7 +388,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_ID], 0x1227); /* Powerbar */
>   
>       /* create a second serial PCI card when running Astro */
> -    if (!lasi_dev) {
> +    if (defaults_enabled() && !lasi_dev) {
>           pci_dev = pci_new(-1, "pci-serial-4x");
>           qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
>           qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
> @@ -395,7 +398,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       }
>   
>       /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
> -    if (!lasi_dev && machine->enable_graphics) {
> +    if (defaults_enabled() && !lasi_dev && machine->enable_graphics) {
>           pci_create_simple(pci_bus, -1, "pci-ohci");
>           usb_create_simple(usb_bus_find(-1), "usb-kbd");
>           usb_create_simple(usb_bus_find(-1), "usb-mouse");

This almost doubles the uses of default_enabled in the entire tree.  I wonder if some of 
them are redundant or should be using a different test.


r~

