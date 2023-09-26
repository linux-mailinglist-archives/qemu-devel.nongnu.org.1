Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543E7AE769
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:07:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql362-0002MM-ER; Tue, 26 Sep 2023 04:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql360-0002Lm-Fl
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:07:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql35q-0008Mk-GT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:07:04 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOzGc-1r1c2B0W3Y-00PPyn; Tue, 26 Sep 2023 10:06:51 +0200
Message-ID: <e893936a-f61b-bcf3-7d7b-7bb51d46144b@vivier.eu>
Date: Tue, 26 Sep 2023 10:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 19/20] q800: add alias for MacOS toolbox ROM at
 0x40000000
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-20-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-20-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nGFiADxMEa2lPJTcdAp+Gdpb17jol2LzAtbrYa3fT1n1pLEVOfr
 LSyB6nLSU59tIfZreyc2399/HHeHIniO5Z5+mRA+kU45vH3cB31+WTKp9JI9X3zP6P1VY0F
 E4BOC2vfQUKCdNPlQa8eVVdy7xTJKhwxqPYsbpPeOoGRQ6eHXZr4lurAIQVbwY5743NR1XI
 Zj+tVzidFist0OPFS+Ieg==
UI-OutboundReport: notjunk:1;M01:P0:aexDQ1CU3hU=;uc5ZncSfnF8kNBykV/rWInlhlJS
 OuT0+nSY5OqKKnYbBx8ITHD+PyvCloBMz1V4HwbNI6vbAbGdJrO1AnUc9ix9A0YkN0yNgLWNz
 TVKMwdnwPEcUgZ/3HvLnrWjn4Ls3EuQYvAjcXJSpcfffPg74sf3QM9EDCiBTQRg7pssSUQyTZ
 j2fhx8iSMljZyaImhOKXkNWhCtxmrp+z6UpWSITipGc8TUX07f1qm4/4Hb/jXP6ouidRKqAYH
 qMWGWv9ItRpm/LYYL2VLrUbX88i198nQhFXvJf0quyjFwuDmcy9Q7Jvt0VG3I5hZVdPinvE8K
 4Q1SsoyQ9xfYguSHu9lLS8YAgocsLwycyVgiTg0zQ0ALKdvejx6VPv6OYlC5mEnfWj8K3FXS5
 oXmgdh1UZcxJrCLtba2woeKemwS6LldvvgDcqJiHE0TyUHBl2Z0O4MPYm8PD4pkgA66f2d/Dw
 CpjOCb5anfCh1N8p8CdaMXHaaNUOoqidHishwcJMY3ukw+V24EJSLsL6FgiLFF/nllf15JyqJ
 bJQv7GwcCK/8hjCA0dBl2QYcfWBRrOI6XUfpRdsulA2kMZaVQ81B8121sx8TQnOO7WXIc6lVx
 rmgMZ7z51jEzoIe3A4Yp/qCsrEToeNgjh9wq4bYEsL71+fHfQJyMxSNx3Isa5l3Oc2mVNOf/m
 D5M8qgU5JciRj6YB14TXwWuJR88+abjAFxCsp02N4tKn2iKMr0BFbxeqreSjIfWGDDJ7rLz+v
 re1diK0oPD/ZAJQmrg5M30iyCNXZNfXydU+pexizfUfNYL/mlobsnkPO44t237IiV28RnqOUY
 ztDwEeN5OZrQmi5tQFADfeaMrr1MyzYAkBYlUtycyFyw3qIJa2qwLb8VJruSUg1npSKt7w4IB
 6+egq/3/G4X/GIg==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
> According to the Apple Quadra 800 Developer Note document, the Quadra 800 ROM
> consists of 2 ROM code sections based at offsets 0x0 and 0x800000. A/UX attempts
> to access the toolbox ROM at the lower offset during startup, so provide a
> memory alias to allow the access to succeed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 5 +++++
>   include/hw/m68k/q800.h | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index b5b2cabc33..87665c6407 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -657,6 +657,11 @@ static void q800_machine_init(MachineState *machine)
>           filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>           memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
>   
> +        memory_region_init_alias(&m->rom_alias, NULL, "m68k_mac.rom-alias",
> +                                 &m->rom, 0, MACROM_SIZE);
> +        memory_region_add_subregion(get_system_memory(), 0x40000000,
> +                                    &m->rom_alias);
> +
>           /* Load MacROM binary */
>           if (filename) {
>               bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE);
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 348eaf4703..a9661f65f6 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -50,6 +50,7 @@ struct Q800MachineState {
>       bool easc;
>       M68kCPU cpu;
>       MemoryRegion rom;
> +    MemoryRegion rom_alias;
>       GLUEState glue;
>       MOS6522Q800VIA1State via1;
>       MOS6522Q800VIA2State via2;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


