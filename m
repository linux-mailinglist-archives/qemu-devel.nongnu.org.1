Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DA715CD4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xKE-0002wL-0Y; Tue, 30 May 2023 07:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xKA-0002vu-P1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:15:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xK8-0002hI-WE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:15:34 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOiU5-1pjEyc3G0t-00QEWi; Tue, 30 May 2023 13:15:29 +0200
Message-ID: <47e22af9-2083-bf1a-c3e0-d39c9a3c70e7@vivier.eu>
Date: Tue, 30 May 2023 13:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/30] q800: fix up minor spacing issues in hw_compat_q800
 GlobalProperty array
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-2-mark.cave-ayland@ilande.co.uk>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bblz+/XKThbnTSX2PrlxxLeBk3puFBDNvA2nLUhrNz+TO7YAbNM
 m0J98tvgJLdUNDy6RBQFg/cHyXU5Ydu8VEkvvekRYJKgf8qZkYycNCzhM+Ggj/13HrYVd7q
 973FBP83uHB9LrlhLBGGHora/nKMf0IR3BYjWASBvXLZZKJaW5ktAZFAV0DnQUId4xVYKNZ
 u/qTFmwiRqL4+VFPCf5Lg==
UI-OutboundReport: notjunk:1;M01:P0:3Bo7LisydZQ=;lMPo5ZM/EQkz6zuo7UInpaO8qAq
 BbCSS3ICouIrpW37bl8X7jDdCD7L2hiIDY+Hccwb4oEBLXHoYQXNis+iIAWDAoj2rNSu0L0iH
 sgPgeerpyL9fPhaJrQzBOf+mbUuemv77xhjiFktBkQMvvgbsV0nU6/1HYmcfGVXo2KQAUGkUl
 bME0izj/lxt8j71XeNkQV4Tw+0uuU3qM2Xgt/57Pg7Wk+P0xkoiFwS3UWSygJ8SwLxlv45KpT
 vQed8LY2nNmaoZmUdHeQLL3f4xlJPvY31NpOxfrVA5/3Hlw/U2grWdxTaNJebosyHbLPIEfKz
 C+7nzsYw1gCVMslZ+WkIUMI9fgdwhDWCP40VVtU0TDex5mvPepY+EO6XniWT3575Pyh0UE/PM
 67ghK/zYtcjq8neslGp0AiSaYTdZqVbGu1FVIl4GpOS+K0g3NuBf0GpexCghSFxXJu19gac9/
 H2o6EqVmQIDX9mOKj9b2iBTlhmgnwnD+AuO0ddS0jZK3jcnu7BK2VhuiSF2CUB2/F6eN5uzQy
 HZ1XJ6SU9ztgm/ezNgQR/8/XOqJGO988gqSMkMNhUM0AxDahEe/EZlUxue3uQ+zAuwSxfRE/v
 3uldvC1O+f+UmaX6y2wcvkD8droEEQ3UKEhpSQ5oL5eZdpA94hYMSop6l1E0sGIJ4RIRFlEcB
 fUs0PZEer1t/8sZ1bePS3m+N/JTemOds9lQj0ZmVvg==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> Ensure there is a space before the final closing brace for all global
> properties.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index b35ecafbc7..1aead224e2 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -719,14 +719,14 @@ static void q800_init(MachineState *machine)
>   }
>   
>   static GlobalProperty hw_compat_q800[] = {
> -    { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on"},
> +    { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
>       { "scsi-hd", "vendor", " SEAGATE" },
>       { "scsi-hd", "product", "          ST225N" },
>       { "scsi-hd", "ver", "1.0 " },
> -    { "scsi-cd", "quirk_mode_page_apple_vendor", "on"},
> -    { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on"},
> -    { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on"},
> -    { "scsi-cd", "quirk_mode_page_truncated", "on"},
> +    { "scsi-cd", "quirk_mode_page_apple_vendor", "on" },
> +    { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on" },
> +    { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on" },
> +    { "scsi-cd", "quirk_mode_page_truncated", "on" },
>       { "scsi-cd", "vendor", "MATSHITA" },
>       { "scsi-cd", "product", "CD-ROM CR-8005" },
>       { "scsi-cd", "ver", "1.0k" },

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


