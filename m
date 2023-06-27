Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B4873F4CE
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2VU-0006Tk-3a; Tue, 27 Jun 2023 02:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2VR-0006SB-Ra; Tue, 27 Jun 2023 02:48:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2VQ-0001FF-EV; Tue, 27 Jun 2023 02:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rrEY2KdN2MuFce9gQbYhlHMrKp0zGXSMuX8BBHFXGHk=; b=HPuzbFAjTDdQt7HYxeptFGjla0
 ovMELe+ifJRTxCyQnLpSwxQUnFMdoKjTq7gFKv7jCIjbmqlwi8aU7qFoujNjWnji+79Uj1xhBwgUY
 3E3vWSH3sIfdYKhmLWc9bOQGMlF5mHU6bZg9mSA5DPFC/0uKrf5UTiqhxhc6FosD274FRwhLwrqEs
 QaIu/GXHcPL4PSG2j0nXhaKNeFvJw5//YbSKjIxuzipwF9LHC5Kg9tc2PydOcImkXuqoZVK34UkLQ
 dL/XgzA09m8nGAJ4PrYcsAJ6l/jL6DEAg05NWvAmrsE5vZ8eg6mM/q8bKNWx2yqnDF89a1WkMjhvX
 HLsnUkBnXdHDW8SZMzsbBHK5/7Bi7l6CmpNBrLe7i2rXhO7bAKsoqUNbcmXH7e37WGOt8FDOkdSja
 QsfqGV7AdpcKZS9WHOt5p5dfU9CfttAxQBk7u/HZ1YnHmojnfg2g6Vw5k7VWYdtSZNDqXmDyMT8ZU
 AR+H0GioLlZR2nXQqVY++941120ozoybiA/sdih46Qacr/Gklzb76YWIky3bng+s/FmdRkaD31sdY
 bzfaGbGqXei+LaCCFzvjJGIi+S0tTFG/Y1RH6WVLgd8dgx8dFniRGB2lwuA/H/itrDqXI3IiuwHHS
 CCGUDqs8nS6k+gUYqNMsiQXB0bG11y08wmL9Zenjk=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2V4-000223-8I; Tue, 27 Jun 2023 07:48:34 +0100
Message-ID: <75a93dde-e236-6afd-40b9-26d08094ab3a@ilande.co.uk>
Date: Tue, 27 Jun 2023 07:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, =?UTF-8?B?SmFrdWIgSmVybcOhxZk=?= <jakub@jermar.eu>,
 qemu-stable@nongnu.org
References: <20230515151104.1350155-1-armbru@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230515151104.1350155-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] Revert "hw/sparc64/niagara: Use blk_name() instead of
 open-coding it"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 15/05/2023 16:11, Markus Armbruster wrote:

> This reverts commit 1881f336a33a8a99cb17ab1c57ed953682e8e107.
> 
> This commit breaks "-drive if=pflash,readonly=on,file=image.iso".  It
> claims to merely replace an open-coded version of blk_name() by a
> call, but that's not the case.  Sorry for the inconvenience!
> 
> Reported-by: Jakub Jermář <jakub@jermar.eu>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/sparc64/niagara.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 6725cc61fd..ab3c4ec346 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "block/block_int-common.h"
>   #include "qemu/units.h"
>   #include "cpu.h"
>   #include "hw/boards.h"
> @@ -143,9 +144,10 @@ static void niagara_init(MachineState *machine)
>               memory_region_add_subregion(get_system_memory(),
>                                           NIAGARA_VDISK_BASE, &s->vdisk_ram);
>               dinfo->is_default = 1;
> -            rom_add_file_fixed(blk_name(blk), NIAGARA_VDISK_BASE, -1);
> +            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, -1);
>           } else {
> -            error_report("could not load ram disk '%s'", blk_name(blk));
> +            error_report("could not load ram disk '%s'",
> +                         blk_bs(blk)->filename);
>               exit(1);
>           }
>       }

Thanks - I've queued this to my qemu-sparc branch.


ATB,

Mark.


