Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D632C7212B1
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 22:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Xvq-0004AF-Um; Sat, 03 Jun 2023 16:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5Xvo-00049q-Ie
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:33:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5Xvn-0003KW-3J
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UoNSIjjx5yqVDeCp76CPzT412Xs4s1FHoQBJJFh3ttY=; b=L+I7A/iIus+OFZn35KgvkUUNgP
 bjghhXr3SttJaZnBIq6rCF4hQcVzRKpmzIaP/hK7S7/SZ9l1YfBQfSL4d1DaqUsVfwevpcyK3I/YP
 +jBhiOTV2H5swiEhmaltqOWFCarJLbODcXDLhoWvRroAKZC5TOSHzSYUKTbzl8TNyIOaxWYb587oH
 xfaFBjljNEYdhnf8V5yzsIHoDLBzMFhgSMGOPVf0brXx5TJgdKuY8kJQvld9oCPZo2fQvri/PBDNL
 eGTpoHc0CK+nD465UmQkvb+GY130Zk+6Ci7Ud4CpvMTruMKIKJ2w2kUTf4HZW29Q7xUekFeIfIdPa
 y2U5nWKBbSVzkQYqTnpLIQBvooeVr1e+ITjPuFtj4ySbsEm62+skySmOBVYHXEf86wuZJcZIVYqNw
 2jGPYlG5ijKlUATmGngG6DfloHB18o7/vyA31Lqtz6PqHk4TRVHcXo8T5DMKVng+VtYfteBTPJrK3
 Jz6OXVql25jb9eWG9NjzvG+kc+ZxGrQUep8mYNrzkgvE9GK3DELjkoMM3vPc9HptQvB+eA9QYt2UO
 FjNHwz9cSjQrJ4VIX/666wANJcwJT89Yx9E8sszeXq+IgLT/mYpA4uaSsUnC/UClhIcUdIekS4cov
 /zRbVKZj764Id/nBymmN89BomN9CMdjmcf/skrOxc=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5Xva-000125-HR; Sat, 03 Jun 2023 21:32:50 +0100
Message-ID: <d3ae3873-072b-1a9b-bb74-0486340ba933@ilande.co.uk>
Date: Sat, 3 Jun 2023 21:32:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-22-mark.cave-ayland@ilande.co.uk>
 <3594a2c2-5526-deae-6259-9906d79c5e3c@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <3594a2c2-5526-deae-6259-9906d79c5e3c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 21/23] q800: move macfb device to Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/05/2023 14:55, Philippe Mathieu-Daudé wrote:

> On 31/5/23 14:53, Mark Cave-Ayland wrote:
>> Also change the instantiation of the macfb device to use object_initialize_child().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/q800.c         | 6 ++++--
>>   include/hw/m68k/q800.h | 2 ++
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index 946cb09e30..0e7451e77a 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -449,7 +449,9 @@ static void q800_machine_init(MachineState *machine)
>>       /* framebuffer in nubus slot #9 */
>> -    dev = qdev_new(TYPE_NUBUS_MACFB);
>> +    object_initialize_child(OBJECT(machine), "macfb", &m->macfb,
> 
> Alternatively "framebuffer" or "fb". Regardless,

I'd prefer to keep this as macfb if possible, simply because it matches the 
convention of using the device type as the basis for the object child property name 
throughout the series.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +                            TYPE_NUBUS_MACFB);


ATB,

Mark.


