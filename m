Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61227711080
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DW9-000862-3y; Thu, 25 May 2023 12:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DW7-000852-LW; Thu, 25 May 2023 12:08:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DW3-0003D3-EJ; Thu, 25 May 2023 12:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1E5TV/LN40tnN+0VNuZKb/zKBbhM0CdHsi/AuDa1W6Q=; b=JhFIRqxsIm0Jm5f/nFIfT+sI/q
 Q3tmsabMy/+gufICOXbr89PJFhbKneHQFpGDtUTlchUlWf9ciDlQmUq2yaD9lAzvUrMZcWncaDF9Z
 d7sNvvlxfBlZbpo3+6osU9a776/ajBWey1AYNUCleWyjV8NrISETH/E/Z3L4/20mv59GUzdJDpXlQ
 1eu3e1tfnWJesRve7sUz8q/s4gwPhQjA7tBoGkncnv4qtncp76o1HxQCw/de8SRoeOemu8q0vD3L1
 PDXL3QCwTl6LnyW2bMKycLMeidS+131IpyY/Pn0dlIiYDrNPg/LR5AbDj9b6vYCGzskZUKV4jotnF
 A4+nXLfzirB3KgM88LpvDHNXPYhyWocVRpKPVehYt+1r4uznhDhe8JZaxeh4Ro8s6tUXI8BRjtA/a
 VBknLIDrMpevLYP4eb3xga+E2erzx0m1US+eGvWhwlXw0lohpLX09fPfoXsCTKXrDQKf3RQcBIbEQ
 UWnq7wniFt4sY5amQ9U7zQ5WrShYjJHeSOdDse3L1CWC03/mu2asGR9I3FzL4uwuwd67rrgT50/ND
 hO+QLsB9y4bdAi1G5wBD9dNV7pf9+mc8OFf8sJ5im2xuCc5/wKjFQVdhmth8HJZc7fnw/7auZhmRj
 iViy4gvWoN5jHXwCmbpkulV2BXZ3JXAGxuh93k1yQ=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DVv-0002GY-1b; Thu, 25 May 2023 17:08:35 +0100
Message-ID: <51acc79c-c8d9-56ba-8fb4-50221557bbf1@ilande.co.uk>
Date: Thu, 25 May 2023 17:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20230523061546.49031-1-philmd@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230523061546.49031-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/ppc/openpic: Do not open-code ROUND_UP() macro
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/05/2023 07:15, Philippe Mathieu-Daudé wrote:

> While reviewing, the ROUND_UP() macro is easier to figure out.
> Besides, the comment confirms we want to round up here.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ppc/openpic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
> index ebdaf8a493..bae8dafe16 100644
> --- a/include/hw/ppc/openpic.h
> +++ b/include/hw/ppc/openpic.h
> @@ -55,7 +55,7 @@ typedef enum IRQType {
>    * Round up to the nearest 64 IRQs so that the queue length
>    * won't change when moving between 32 and 64 bit hosts.
>    */
> -#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
> +#define IRQQUEUE_SIZE_BITS ROUND_UP(OPENPIC_MAX_IRQ, 64)
>   
>   typedef struct IRQQueue {
>       unsigned long *queue;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


