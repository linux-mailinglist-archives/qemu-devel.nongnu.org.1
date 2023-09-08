Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C557982D5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVNs-0001v1-R1; Fri, 08 Sep 2023 02:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeVNd-0001tC-7p
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:54:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeVNb-0004bd-4m
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=guVLNx0C4aDlj6I675/+SSEM/qwg0Slz2fKTo8we5WA=; b=pFVHQno1tB2PLSdxlhYizdNXmO
 ni3hojskBSwh2vdU6/FU1dENCPknug18/TZ61zjAR3z5ag4RF66Sk6MLrQ+9u77rJYJDKjVoDX3GC
 YosBWMCLy0A47A282kaWwVU7qfGsEceZ/loMnN6tKSqe5riRygtNJPS0PrpQFFVyRk+nIythVT4Nn
 uaWVI5MHJcXRPSbIfYs7VSZLcyhPx9VduTkI9Q7dLwPc9aNS7hC8xybkNXqqIZpwCYhk7f+KKl3Hp
 nWyMBlHPDeO+947Vcyvek7WJz9T7bX3gFIKHOdRkkNnhNSOaP+muU6KhxMz/k+ldktAaoCtjuqZEq
 8s1LkoHCxOV+Y6vBa5KE6Mk5oMabADn3mVj5MTjA2m3IBkdF4jEV2gZ8JTj8sk7E27ymvn0Zcre88
 QaO6KTUgA/oYv2Teo0bAUelbuJzi0fZVsi47sSuniNG08Z7+cKGHsYfkq2cWiz5cO/W9jQhfEjQup
 5B9RW+V0xv7Q/S/va3RhGXhwerdVT1Do6QlY33lqVdFHAosPwzqh8H7kv2EUDtVzMAuHqS6zmeqRI
 bJACur3jOp7y5UFZtRhvx16QN9XplGOeDOU5U8pYtyR6XHo8epUzTIeisbJKmNIUkFQb5NoyDtoTA
 TDN4UYRxTGY6HexUnabJYpivADRuNbOivj2BE9I44=;
Received: from [2a00:23c4:8baf:5f00:cfe1:e4f1:db23:3678]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeVNU-00073p-8t; Fri, 08 Sep 2023 07:54:08 +0100
Message-ID: <f639b4b1-965a-fe9d-a988-2dbd2c1c0e68@ilande.co.uk>
Date: Fri, 8 Sep 2023 07:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
 <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:cfe1:e4f1:db23:3678
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 10/21] q800: add easc bool machine class property to
 switch between ASC and EASC
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 07/07/2023 09:29, Philippe Mathieu-Daudé wrote:

> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>> This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
>> (default) or to original mode. The real Q800 hardware used an EASC chip however
>> a lot of older software only works with the older ASC chip.
>>
>> Adding this as a machine parameter allows QEMU to be used as an developer aid
>> for testing and migrating code from ASC to EASC.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>>   include/hw/m68k/q800.h |  1 +
>>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> 
>> +static bool q800_get_easc(Object *obj, Error **errp)
>> +{
>> +    Q800MachineState *ms = Q800_MACHINE(obj);
>> +
>> +    return ms->easc;
>> +}
> 
> Is the getter useful? Otherwise:

Isn't it a requirement? Otherwise I can see that if we decide to enumerate machine 
properties (similar as to how device properties appear in "info qtree") then it would 
be impossible to display its value. Certainly at the moment we consider that adding 
an object property to an underlying struct effectively makes it "public".

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


ATB,

Mark.


