Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D81716235
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zXw-0002L2-8k; Tue, 30 May 2023 09:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3zXI-0000de-NC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:37:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3zXG-0005HZ-84
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:37:16 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MvJwN-1qL6wd017B-00rIn2; Tue, 30 May 2023 15:37:06 +0200
Message-ID: <c0a2cebe-ff31-dadb-ba9a-dda729469f40@vivier.eu>
Date: Tue, 30 May 2023 15:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 22/30] mac_via: fix rtc command decoding from PRAM
 addresses 0x0 to 0xf
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-23-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-23-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qpQts5dKJbTQh4wfSkHaAUM5gZx6tDkZ0BZHr3FrfiMgZTKi9vt
 nIKJcJ1W5Fj/Ds2VL5wbeDGJSQjr+AC4AV4d+G/224IGCS4EoeSE8yDAQlSC8+PE3aSu0iD
 wJzV5W3G5Oy0TLKxfLYWNZYn9O/7aBbqq9avk8yPrzGpANj7tw6IRnVwvoxm3JwRGKi1s/k
 AvAmfOWFNAVlP8viAcpXg==
UI-OutboundReport: notjunk:1;M01:P0:OpvuT5630IY=;0HLk4nlTm3bKfJoosLBTNv7MQVo
 9CH/i6P+js7OssLFh3Z/rHHJAxlrWXjkkDICcFRDytsm8g/afbvgfZP8qTn9Q5bBOD1YS6ATT
 ACB6r3L9bSTUjTOFJx0ibIotGjEL+ZoVphYAwhIPmam2k4v8T+dI5vdPkogpz3+PklTiqgi9l
 LjveM2dFguFZmc3IzPAmH9TsoS9Ktzbc67clCiXV6N3OpuhN4cedDty1QhCweIEEUKwiWOSFW
 X4Y09+bXaFyGivvEPAmX//oEtIGw7MJsJ54AhIJk3hsGMx8A8haalIsUPXatFPEGyAIv8+J5E
 Fs4AhQapL31xeOTd6lH3yLXYu/qgLBYxs5/MLqEZcxMW8WSEPkdMw17mwvo6RnmQb7SIJfYx6
 Zs1KqjHW6wyuO9JjhYuPOMdyGBoXYpk+UxgdgvVYchiUK7AjXBi4JAhBnheobIqB5vhQLvocd
 DI64x4UEsizB8tFQMOva3mHY5j+MFyv8n2kts1ZISsfKqlWPrXOApCCwADLTWuN8JqKCgbiuB
 qV/cFmV+PeiI8PT3MCh0O5ZRCTNA/b55X2hVUNtVw0ZT0OQ9AEFm5AiveI4KfiNiPa5fxy3Pw
 GVu7M/OaZAwTZUjWQraYsgxXU2i/+nqks0JKtOyz3aSRclaVMO/mDz/chm87AishpY0FbGs1j
 r1/TsgyC/hmWq8+Ji3QOpsU1YsSR4aRRQ1fy/msAkw==
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
> A comparison between the rtc command table included in the comment and the code
> itself shows that the decoding for PRAM addresses 0x0 to 0xf is being done on
> the raw command, and not the shifted version held in value.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 62f0988537..d7067030db 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -403,7 +403,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
>           } else if ((value & 0x1c) == 0x08) {
>               /* RAM address 0x10 to 0x13 */
>               return read | (REG_PRAM_ADDR + 0x10 + (value & 0x03));
> -        } else if ((value & 0x43) == 0x41) {
> +        } else if ((value & 0x10) == 0x10) {
>               /* RAM address 0x00 to 0x0f */
>               return read | (REG_PRAM_ADDR + (value & 0x0f));
>           }

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


