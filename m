Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445697B5C22
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPbI-0003bi-Kp; Mon, 02 Oct 2023 16:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnPbG-0003aw-5V; Mon, 02 Oct 2023 16:33:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnPbE-0001cb-6p; Mon, 02 Oct 2023 16:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mc1JwN4Y+UA2wgTx4mFveSql5qXOMLBlHRtLaAKFYnU=; b=tipL0uis0mijhtHIYiLUONrZOw
 B1aURK4mVbWS30DaHH0dfBppN5r4pVhPxbPZlTD1w3JPhjGhKAYYbBwbspmysNGBvKT8BIdSAhQjQ
 bqAtjns8G8kj7DL+qZn+bhoOmvf3B2pPH/erh1ap83QDeWrS7pwgUESbM9ssOurNfFvyIk3U80Pcg
 jsA+jmpGKZWvc+B/jz5lVrW6LerkJNh4SeIvjKfT7KKa81hH43cLhSOSFpOz7qJabvW5sYD6nOuw6
 DkEgBMEmzZsqINKaZLok0ERyiFqQFnYBPp2BPgq3jdyRUSGfrbDehUu4GHnfD9kBv7IoUwt4PnlEa
 y1jWcsirUhg4mphXlYbif17xBvx2QpOcHix6eG2pfMYtKRAc4SB+WHtmTCf9KLKwpHelu7qt0NcWY
 1Z8GRrYwgIJFQNnunTd4GZEa+zhh9G4yRuDjLpegpR8PiPYJr64CMnNM9UdoYQIsU8SzJUzIh6JE4
 LvVDdhlNILbvZwY28IhDajHKcOJZL8JmhscJ4RWJw1HZ1Tl9spak5vMvpPao6LbsaE6b7Xls494J6
 My+Tfbr/qtOkk6PiBc9AQ94bF1WkS3rfESIOTk92MIVdsHcPd8SI3J/mNKiDHj1ED6QlyFT7K3Ahr
 wM2JvIYQh5bm/BKwsDeAvMBJwSikjo9QVgMCAcM+A=;
Received: from [2a00:23c4:8baf:5f00:6e88:9d14:ed78:b8e4]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnPav-0003OR-G7; Mon, 02 Oct 2023 21:32:49 +0100
Message-ID: <95aeb16d-a08b-16e3-946d-b2f6ab2b5a65@ilande.co.uk>
Date: Mon, 2 Oct 2023 21:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231002155143.400668-1-clg@kaod.org>
 <20231002155143.400668-7-clg@kaod.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20231002155143.400668-7-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:6e88:9d14:ed78:b8e4
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 6/8] MAINTAINERS: Add fw_cfg.c to PPC mac99 machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/10/2023 16:51, Cédric Le Goater wrote:

> The hw/ppc/fw_cfg.c file contains the implementation of
> fw_cfg_arch_key_name(), used by the common nvram model. List it under
> mac99 machine next to the mac_nvram model.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 814352191305..d00f39ac9440 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1388,6 +1388,7 @@ F: hw/pci-bridge/dec.[hc]
>   F: hw/misc/macio/
>   F: hw/misc/mos6522.c
>   F: hw/nvram/mac_nvram.c
> +F: hw/ppc/fw_cfg.c
>   F: hw/input/adb*
>   F: include/hw/misc/macio/
>   F: include/hw/misc/mos6522.h

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


