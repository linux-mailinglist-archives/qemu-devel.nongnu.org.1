Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A37BD968
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoHF-0001Oy-OR; Mon, 09 Oct 2023 07:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpoHD-0001On-My
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:18:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpoHA-0006k1-QA
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:18:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1EDAF7456AC;
 Mon,  9 Oct 2023 13:17:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DE8437456A7; Mon,  9 Oct 2023 13:17:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DBEAD745681;
 Mon,  9 Oct 2023 13:17:18 +0200 (CEST)
Date: Mon, 9 Oct 2023 13:17:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Corey Minyard <cminyard@mvista.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] hw/mips/malta: Use sdram_type enum from
 'hw/i2c/smbus_eeprom.h'
In-Reply-To: <20231009092127.49778-1-philmd@linaro.org>
Message-ID: <64068121-6c7b-9e5a-7c43-95b339c4c99e@eik.bme.hu>
References: <20231009092127.49778-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1204168738-1696850238=:71180"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1204168738-1696850238=:71180
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Oct 2023, Philippe Mathieu-Daudé wrote:
> Since commit 93198b6cad ("i2c: Split smbus into parts") the SDRAM
> types are enumerated as sdram_type in "hw/i2c/smbus_eeprom.h".
>
> Using the enum removes this global shadow warning:
>
>  hw/mips/malta.c:209:12: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>      enum { SDR = 0x4, DDR2 = 0x8 } type;
>             ^
>  include/hw/i2c/smbus_eeprom.h:33:19: note: previous declaration is here
>  enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
>                    ^
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/mips/malta.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index dac27fad9d..62d04ed113 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -206,7 +206,7 @@ static eeprom24c0x_t spd_eeprom = {
>
> static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
> {
> -    enum { SDR = 0x4, DDR2 = 0x8 } type;
> +    enum sdram_type type;
>     uint8_t *spd = spd_eeprom.contents;
>     uint8_t nbanks = 0;
>     uint16_t density = 0;
>
--3866299591-1204168738-1696850238=:71180--

