Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE81716237
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:38:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zYC-0002z2-3P; Tue, 30 May 2023 09:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3zY7-0002ma-4m
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:38:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3zY5-0005Ze-99
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:38:06 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCb2L-1pvR5l3BXH-009iJZ; Tue, 30 May 2023 15:38:02 +0200
Message-ID: <293d2e1f-d8ee-5a17-cbf8-2a7d7b49b6b6@vivier.eu>
Date: Tue, 30 May 2023 15:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 23/30] mac_via: fix rtc command decoding for the PRAM
 seconds registers
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-24-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-24-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BROu9bYPvr+cTQ/so883EY1nFWR0wb8TU6QrzltlDnakN1fPINQ
 SzjynBM7AWl+GLg8cYaTqcmULAnboIO9u3jMv7ONj6wrRnl/dvXV86uLGhSrayNexKJTQbC
 kN2M00qoSHPtLLO+aXTZMwv2V20FnVljL/VGYB56mS30TyJczkkD6pOKQRoyNIB4XOt6z2n
 6kktYOi0ORUH0+SlTTrmA==
UI-OutboundReport: notjunk:1;M01:P0:x6WcZ8FFZTo=;aTqZlf/9SVfGil4d48pT57VnwuX
 Qlj9xMlpfvpVEvySUYQ38+yZWiHCChk9Z7D9yVEBzhtsSnBg3D3H1VxjCCyQTnGCoKAkmUsuy
 /TozCC+QcSjQTrOiZiaDuKhY9DZUlo2MrWRA4cBfZ7bwGBRsCQTtHnJlY1BBNkWiNADbh50cM
 izsH12a5P8mzYGTzyKGnEj3Ue3aPBZ0NBmYhun4X38ho4xOg27L7CtqYMYdARHhZiUZ7SRsXz
 UIwMkhjd9dumaXjLqHmAm7mznU8ErCOaYWSaz9k/Q8/nSz0J2TQjrcXiK4xQa/BCxyT53AIm6
 AqbNvmZXgzkjngHOQQgOaPuGN58VgzHGTryyT2rvUeVWD5+MJsrg3xyROOJMenx/OAnfqW/H6
 i2Z7Y2vuIj3kJhBN99PL7e+j571wOeLTaFN/DQu3j9ZWVp+Pe+90ZqlBPBIf4JnW+fvDxwr2n
 uGdSOFFJY6Dn3oc521vzg30522yx8oqpQmPkUN4zDtRcwDKvQE0EZrVO3jy5ytY2mdaEz74BR
 VSCwCcKf9zgfKFFgExh/RskO8QX5X7a3O5/qXYt+YP6Kxd8CGL1Qc3wHKgE8ZNGPvqmn8HEEc
 EMOFFv7Czjoa4yOQEKJcfqvSmTNQQC4+djAWf7kJUJ2LL3474alyw+heNbPc9KEDS6afcpJBs
 XrBlu4deUtAUGI4SwxExqbRqYkflAM03o4F5i5NmAQ==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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
> Analysis of the MacOS toolbox ROM code shows that on startup it attempts 2
> separate reads of the seconds registers with commands 0x9d...0x91 followed by
> 0x8d..0x81 without resetting the command to its initial value. The PRAM seconds
> value is only accepted when the values of the 2 separate reads match.
> 
>  From this we conclude that bit 4 of the rtc command is not decoded or we don't
> care about its value when reading the PRAM seconds registers. Implement this
> decoding change so that both reads return successfully which allows the MacOS
> toolbox ROM to correctly set the date/time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index d7067030db..5d5334b0f6 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -366,10 +366,10 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
>    *
>    * Command byte    Register addressed by the command
>    *
> - * z0000001        Seconds register 0 (lowest-order byte)
> - * z0000101        Seconds register 1
> - * z0001001        Seconds register 2
> - * z0001101        Seconds register 3 (highest-order byte)
> + * z00x0001        Seconds register 0 (lowest-order byte)
> + * z00x0101        Seconds register 1
> + * z00x1001        Seconds register 2
> + * z00x1101        Seconds register 3 (highest-order byte)
>    * 00110001        Test register (write-only)
>    * 00110101        Write-Protect Register (write-only)
>    * z010aa01        RAM address 100aa ($10-$13) (first 20 bytes only)
> @@ -377,6 +377,7 @@ static void pram_update(MOS6522Q800VIA1State *v1s)
>    * z0111aaa        Extended memory designator and sector number
>    *
>    * For a read request, z=1, for a write z=0
> + * The letter x indicates don't care
>    * The letter a indicates bits whose value depend on what parameter
>    * RAM byte you want to address
>    */
> @@ -393,7 +394,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
>       }
>       if ((value & 0x03) == 0x01) {
>           value >>= 2;
> -        if ((value & 0x1c) == 0) {
> +        if ((value & 0x18) == 0) {
>               /* seconds registers */
>               return read | (REG_0 + (value & 0x03));
>           } else if ((value == 0x0c) && !read) {

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


