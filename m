Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B27EE48B
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:45:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3eXd-0002Gl-46; Thu, 16 Nov 2023 10:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3eXa-0002GT-51
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:44:26 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3eXX-0001zZ-Cu
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:44:25 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso140512766b.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700149461; x=1700754261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fWQnUEhRJrxW01oguvF8ZMZ9FfRiBaREpNV93GqJxUQ=;
 b=tvad7VcLbPMq5ZSC2E56CCoOdCF3VPG9qoVJT6b+9X4ScP30Q0j3LuzwkdPoQbJEqk
 s/b/hdVRDfGF1scTr8LI916k/qBBSlZ42X+XtPcpRZOulhq9aV3a51UjoihKEF1TGruw
 f8/B/FAjzh8UHpVje6lu4/ysO8KVpAtEVbNrO5R7XRe6i0Nx97qu9c0lVw3ADHHZ15ro
 FduIPUTcQmx0yIq6nwDSzIo3B48PXqPZ+ry9djlkiDYM7Z59EcqBqUvu8d9D/7CHRwBC
 heKf1LWwOoxARQO+5rDdeKRv8dz2sSNO72EZfJyrp+3abpVz4C00F9XPfqI+mZyNzOMJ
 UhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149461; x=1700754261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fWQnUEhRJrxW01oguvF8ZMZ9FfRiBaREpNV93GqJxUQ=;
 b=SVEzwFFzEH0MCBcix34X4z/TqOh0rLeTbGVEs24Q7YDo/Zr4KFVcuX6zby+XWmD2mp
 P0fpPPRW7ydywhuSeEE/wcjZS7mWad46a9N6oIYsKdk5D6S2eN+MtlKZVvfslan/wQwU
 QyV3hQuhk8vGUlvs4r/LX6ZCzXmFQ8KEVFUY3MzF3/guVvyZmcc5nL/aCH4ysyITDGmT
 LX8pjacAlQoTeHMqXVL+CgEIM5f6FcMsXMYPYIWAQlT91O+2ktEBCZ46/MQSwGpxVJEt
 UKyMff+OYNXz6mIFgZq+pK4XfnAAPFTBlJlbLRQBrJ1ivCfYwJAsV+NAZYuw+ppAcbLz
 Ckvg==
X-Gm-Message-State: AOJu0YzWTyZxFyoQrKOFJoDQw4qoU6medn0gg4bnXQhXwmpbZOkIFbeO
 B8kuYuvrlODbbOqalrYCG8OxRg==
X-Google-Smtp-Source: AGHT+IFPKTzY6LdnH9IRdXJvnEmp2IGjdP10xizKTmXIH8VPns3mzV4jWsDPIrCYGeus6hV2Pk3tHQ==
X-Received: by 2002:a17:907:72ca:b0:9e8:b694:3312 with SMTP id
 du10-20020a17090772ca00b009e8b6943312mr2577037ejc.14.1700149461303; 
 Thu, 16 Nov 2023 07:44:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 fi5-20020a170906da0500b009e5db336137sm8634527ejb.196.2023.11.16.07.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 07:44:20 -0800 (PST)
Message-ID: <89ee4de6-db99-4434-8422-77b1923296b0@linaro.org>
Date: Thu, 16 Nov 2023 16:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping TX FIFO
Content-Language: en-US
To: Francisco Iglesias <francisco.iglesias@amd.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Anton Kochkov <anton.kochkov@proton.me>, Qiang Liu <cyruscyliu@gmail.com>
References: <20231115151711.89170-1-philmd@linaro.org>
 <9282e81c-51a6-46be-bcfa-dfec2f04a817@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9282e81c-51a6-46be-bcfa-dfec2f04a817@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Francisco,

On 16/11/23 15:17, Francisco Iglesias wrote:
> Hi Philippe, good catch!

Well this was fuzzed by Qiang Liu.

> On 2023-11-15 16:17, Philippe Mathieu-Daudé wrote:
>> Per 
>> https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Message-Format
>>
>>    Message Format
>>
>>    The same message format is used for RXFIFO, TXFIFO, and TXHPB.
>>    Each message includes four words (16 bytes). Software must read
>>    and write all four words regardless of the actual number of data
>>    bytes and valid fields in the message.
>>
>> There is no mention in this reference manual about what the
>> hardware does when not all four words are written. To fix the
>> reported underflow behavior when DATA2 register is written,
>> I choose to fill the data with the previous content of the
>> ID / DLC / DATA1 registers, which is how I expect hardware
>> would do.
>>
>> Note there is no hardware flag raised under such condition.
>>
>> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
>> Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1425
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Tested with the CAN tests from 'make check-qtest-aarch64'
>> ---
>>   hw/net/can/xlnx-zynqmp-can.c | 49 +++++++++++++++++++++++++++++++++---
>>   1 file changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
>> index e93e6c5e19..58938b574e 100644
>> --- a/hw/net/can/xlnx-zynqmp-can.c
>> +++ b/hw/net/can/xlnx-zynqmp-can.c
>> @@ -434,6 +434,51 @@ static bool tx_ready_check(XlnxZynqMPCANState *s)
>>       return true;
>>   }
>> +static void read_tx_frame(XlnxZynqMPCANState *s, Fifo32 *fifo, 
>> uint32_t *data)
>> +{
>> +    unsigned used = fifo32_num_used(fifo);
> 
> For the case when there are multiple frames in the fifo we need to swap 
> above to:
> 
> unsigned used = fifo32_num_used(fifo) > CAN_FRAME_SIZE ? 0 : 
> fifo32_num_used(fifo);

Isn't this ...

> With above minor modification:
> 
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> 
> Best regards,
> Francisco
> 
>> +    bool is_txhpb = fifo == &s->txhpb_fifo;
>> +
>> +    assert(used > 0);
>> +    used %= CAN_FRAME_SIZE;

... done here?

>> +    /*
>> +     * Frame Message Format
>> +     *
>> +     * Each frame includes four words (16 bytes). Software must read 
>> and write
>> +     * all four words regardless of the actual number of data bytes 
>> and valid
>> +     * fields in the message.
>> +     * If software misbehave (not writting all four words), we use 
>> the previous
>> +     * registers content to initialize each missing word.
>> +     */
>> +    if (used > 0) {
>> +        /* ID, DLC, DATA1 missing */
>> +        data[0] = s->regs[is_txhpb ? R_TXHPB_ID : R_TXFIFO_ID];
>> +    } else {
>> +        data[0] = fifo32_pop(fifo);
>> +    }
>> +    if (used == 1 || used == 2) {
>> +        /* DLC, DATA1 missing */
>> +        data[1] = s->regs[is_txhpb ? R_TXHPB_DLC : R_TXFIFO_DLC];
>> +    } else {
>> +        data[1] = fifo32_pop(fifo);
>> +    }
>> +    if (used == 1) {
>> +        /* DATA1 missing */
>> +        data[2] = s->regs[is_txhpb ? R_TXHPB_DATA1 : R_TXFIFO_DATA1];
>> +    } else {
>> +        data[2] = fifo32_pop(fifo);
>> +    }
>> +    /* DATA2 triggered the transfer thus is always available */
>> +    data[3] = fifo32_pop(fifo);
>> +
>> +    if (used) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Incomplete CAN frame (only %u/%u slots 
>> used)\n",
>> +                      TYPE_XLNX_ZYNQMP_CAN, used, CAN_FRAME_SIZE);
>> +    }
>> +}


