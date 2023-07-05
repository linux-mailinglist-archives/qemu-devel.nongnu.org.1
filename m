Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6281748E23
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 21:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8Mj-0002ZQ-Dw; Wed, 05 Jul 2023 15:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qH8Mh-0002ZI-3j
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 15:40:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qH8Mf-0002c1-IZ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 15:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0q/qhyCoyVLrkiYMpJ+GtQoTaSBCOQwRM6Y6LAEnKxs=; b=Fef6M6onfVQcK2jMIlA/qvwRcr
 h/cckdfJnSxu3VDRIFmJ9/v5JgnXqcW4EpznOBFtwXh9FE3JmQYhuVq2R5pIn1jGRtq04+NHfWXA+
 bCAnHSbxaQySQXfb+lwZvj7kTPCtYZIWrhOVvnSl6EP2MkIihy/CHZmKL80PCUYhAy7Vn9lbZrrXT
 wUX/2zj6rW/o+BTPYFB+Omk+jkyV0/dQobm6MNSwoepHuQNN6Jth+6g01Fh5Lg2OBYv6DF4B+B5+O
 s0Vq7BIMsN/38bpaF39/calyXPpULJD+AA0s65CeewAniLbNKZG6PtVxL3PUBytDlHqZMlCb9zJ4C
 Pc+wD80VlW6MRaPXwH7RNWxbha9q+AuJAjv+2WgUmvXl91j88F2otW7zBhj95dUmgYQz96amlyaIa
 mAIxmasKcz6m/dI3mDUYZN+lbO1W2DpuyvZs0TNViGCr25IhB4pqCFnWT0fWrHArTn4tSf0XFqLU5
 kvwRvGJHG6wgG/9OHjFlE84ciNA56Xek30VeMCZLhurHucLNIrTIod5hxiYbVCWRiXnaNE1BWc+XK
 qqaF/rb05H0n17/5z+esbUZKZ0tq+Mvhd5dm/ng9OUY3Qx1ukZeYzWMLXfr7jBypvMjJpW5wawmyR
 tnO/r5N1ixmX6KhqRxwd0bRwN2LIp6MxjoaxswaNA=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qH8MK-0008fi-Vw; Wed, 05 Jul 2023 20:40:21 +0100
Message-ID: <979bbe89-b673-1782-ccde-8fe5f364cda1@ilande.co.uk>
Date: Wed, 5 Jul 2023 20:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-12-mark.cave-ayland@ilande.co.uk>
 <575796cd-6460-b9ea-bfcf-8f27fadf0920@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <575796cd-6460-b9ea-bfcf-8f27fadf0920@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 11/21] swim: add trace events for IWM and ISM registers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 03/07/2023 09:26, Philippe Mathieu-Daudé wrote:

> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/block/swim.c       | 14 ++++++++++++++
>>   hw/block/trace-events |  7 +++++++
>>   2 files changed, 21 insertions(+)
> 
> 
>> @@ -267,6 +275,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t 
>> value,
>>       reg >>= REG_SHIFT;
>>       swimctrl->regs[reg >> 1] = reg & 1;
>> +    trace_swim_iwmctrl_write((reg >> 1), size, (reg & 1));
>>       if (swimctrl->regs[IWM_Q6] &&
>>           swimctrl->regs[IWM_Q7]) {
>> @@ -297,6 +306,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t 
>> value,
>>                   if (value == 0x57) {
>>                       swimctrl->mode = SWIM_MODE_SWIM;
>>                       swimctrl->iwm_switch = 0;
>> +                    trace_swim_iwm_switch();
>>                   }
>>                   break;
>>               }
>> @@ -312,6 +322,7 @@ static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned 
>> size)
>>       swimctrl->regs[reg >> 1] = reg & 1;
>> +    trace_swim_iwmctrl_read((reg >> 1), size, (reg & 1));
>>       return 0;
>>   }
> 
> 
>> +swim_swimctrl_read(int reg, const char *name, unsigned size, uint64_t value) 
>> "reg=%d [%s] size=%u value=0x%"PRIx64
>> +swim_swimctrl_write(int reg, const char *name, unsigned size, uint64_t value) 
>> "reg=%d [%s] size=%u value=0x%"PRIx64
>> +swim_iwmctrl_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u 
>> value=0x%"PRIx64
>> +swim_iwmctrl_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u 
>> value=0x%"PRIx64
> 
> For these 2 functions, 'value' is 1 bit so could be 'unsigned' ;)

Indeed. In fact I'd be inclined to make them "unsigned int" just to be sure there is 
no confusion :)

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


ATB,

Mark.


