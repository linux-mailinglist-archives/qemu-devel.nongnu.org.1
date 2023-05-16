Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE0A7045B8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyog0-00054M-Ef; Tue, 16 May 2023 03:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pyofu-000548-7u; Tue, 16 May 2023 03:00:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pyofs-0001vK-L8; Tue, 16 May 2023 03:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RM9W/Z3G7POrwdjnLCxC/LWguTOBg0ri71DC3nvuiNc=; b=TEqJzCDE+9PoRcCjPK2rrCOC8A
 aQqK8jyP3ku8QgfTLB1V8sfVKOyWess2g7e0YBjI8VVhYQNT9De3s7veTRv8OZLRB935eeOxLDF9J
 X8o5cnsAtq9qDkfCbsBqV60LGsJpHwfTHsPpdxjmCExjLIDSnvW2g89PEgysgec8HOFFofH5FrUWc
 bzTLIwwgaDCrewiCrtcK8PIybmn4VsUTv3awO+YyMZD/O6ulEwPQmroj4uLjk9LbEhNz0dn3hjpgx
 2mU1NaZMASoQPs4qRAVuvoMkgRk+tX/kbrIWSeZk9izx503ziNnA4Lqv8+2IR4El3m0fAXpKiraIk
 vVHc0/WcpkoG21f3gbYCWqLM2HU4rbCQPUj3Fdh6pN4WlUSh7qOLubqX7AyCG4kRPOxOZ3F4uX79N
 YKcycaILntSmwSHjN9zT8upcL1pnzBEm4vLnRGPQY4dDREfoWpP0pTW9MqypT90P/S/K0GUL6sCLN
 vC+9iruH5HWprWH9FXbWeF9EAB3H0G/5LfZD0OKZgPgTBJd1URJ3/1K6xTH1Mqqkvaf7JiqQ4gWvX
 mwTAQgLgGjLkF5XtW/qwwZ2iWWnYQ5BzKn4zpkbnjpuhsHpwnctb3LAu9h4h1d+aKop6ci2tCvrIg
 cCyNtKowPL31+cBn4Wysap9HqjGbS6Y2AX9sY4wpo=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pyoel-0009kC-CY; Tue, 16 May 2023 07:59:39 +0100
Message-ID: <3334226e-f96e-5f17-2b67-f29bb9f0256a@ilande.co.uk>
Date: Tue, 16 May 2023 08:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, =?UTF-8?B?SmFrdWIgSmVybcOhxZk=?= <jakub@jermar.eu>,
 qemu-stable@nongnu.org
References: <20230515151104.1350155-1-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230515151104.1350155-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] Revert "hw/sparc64/niagara: Use blk_name() instead of
 open-coding it"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
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

Ah so was this a case of replacing something that shouldn't have been replaced in the 
first place, or does it require a follow-up patch?

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

Regardless of the above:

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


