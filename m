Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6C7DB621
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:28:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxOY3-0003cY-77; Mon, 30 Oct 2023 05:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxOXv-0003bf-Uy
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:26:55 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxOXu-0006wl-2Q
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:26:55 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso632697566b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698658012; x=1699262812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=baAZuEBd0Gazwc/rNcdDIkmTQMW4Si9dwvJNEqBAYnc=;
 b=Tg35RfUI69xj3DkU432lCRuCXd+Gg2qKQVoZy4noIM19xohIXBDDdWrgsIB9nnCHkm
 Y4N/1RYvkRaL38HDRnLlQ32+2WVSH5h3sUp/p7jHJnkwn+39U6c2zmKRUl4cNBo4SQ0O
 9AOeMo952Gv+Q3QWwozo0FssLB7U8wjrwq5juxChbpLC2JBPoMjPArLTBQVg6wRqXtQm
 x9YEtBhNgmpOt6au09sA/wASUAPkRHLzd3kPG8JHztK4axJsMU3gsH2lQc37jFJW5HLq
 JNtdW9odzZdRgYr+u3HT64TFu9Z/Kxw6A/9PcFAAd6tt9bzoVm06nGEY9HObA/OZOh4J
 P+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698658012; x=1699262812;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=baAZuEBd0Gazwc/rNcdDIkmTQMW4Si9dwvJNEqBAYnc=;
 b=taD+VGSfM8ZyTn+WKwZSsszVDh9hbY7YEgJsL3/9CiWBH0CkgwEbZrn9wd6143jts9
 inEjGmB9/vsS3MNXwQ+gDQDJQpDNFmpHVs+GZhwbsQ8uJjS8cx/XmLkjRD7rYjjWD5FB
 MQusaAlC7csoIT9S+nBMwoY2GmKg7VdzP6Fz5B8e4EKbrus2mHOgOblVBoR6g26qVKPI
 KRGvZTheN+zXb1UppGpGzapp+3XuKTrCcr9+jnSU6jjpeuKX/6VWg0/jlI6x5/1aHMZH
 Yg1vAFzITwFWIo5rX/rXxALpVsuLom4yOVtQn4uTaNxH8mJSxcOrv6VlYX/hVRKWYP2J
 kdiA==
X-Gm-Message-State: AOJu0Yz0z9PT4pTT0lhvQYIxkEbmw1C5uqwqsmgHdUAnQruBCrzIV96n
 PDajoWYSQHob9rOVx6BtM/F7Vw==
X-Google-Smtp-Source: AGHT+IHkTlJ9pBoc9VHIFGxl1cUyoQKF91GxdHgCqWG+G2vbHyGogvueKFKAsXkZDKkPLSq6ptgB6A==
X-Received: by 2002:a17:907:3ea0:b0:9be:e90:5016 with SMTP id
 hs32-20020a1709073ea000b009be0e905016mr8497753ejc.24.1698658011838; 
 Mon, 30 Oct 2023 02:26:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a1709064e5300b009c7608eb499sm5642486ejw.94.2023.10.30.02.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 02:26:51 -0700 (PDT)
Message-ID: <bb030181-48dc-f5fc-36b1-5c01ebeb0bd9@linaro.org>
Date: Mon, 30 Oct 2023 10:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v9 4/7] hw/isa/vt82c686: Implement PCI IRQ routing
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, ReneEngel80@emailn.de
References: <cover.1678188711.git.balaton@eik.bme.hu>
 <fbb016c7d0e19093335c237e15f5f6c62c4393b4.1678188711.git.balaton@eik.bme.hu>
 <cf4b1c2f-dde1-738e-1e5d-329b9074e58d@linaro.org>
 <38729153-8636-f530-4f5f-b63b10e406a8@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <38729153-8636-f530-4f5f-b63b10e406a8@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/10/23 10:02, BALATON Zoltan wrote:
> On Mon, 30 Oct 2023, Philippe Mathieu-Daudé wrote:
>> On 7/3/23 12:42, BALATON Zoltan wrote:
>>> The real VIA south bridges implement a PCI IRQ router which is 
>>> configured
>>> by the BIOS or the OS. In order to respect these configurations, QEMU
>>> needs to implement it as well. The real chip may allow routing IRQs from
>>> internal functions independently of PCI interrupts but since guests
>>> usually configute it to a single shared interrupt we don't model that
>>> here for simplicity.
>>>
>>> Note: The implementation was taken from piix4_set_irq() in hw/isa/piix4.
>>>
>>> Suggested-by: Bernhard Beschow <shentey@gmail.com>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
>>> Tested-by: Rene Engel <ReneEngel80@emailn.de>
>>> ---
>>>   hw/isa/vt82c686.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 42 insertions(+)
>>
>>
>>> +static int via_isa_get_pci_irq(const ViaISAState *s, int irq_num)
>>> +{
>>> +    switch (irq_num) {
>>> +    case 0:
>>> +        return s->dev.config[0x55] >> 4;
>>> +    case 1:
>>> +        return s->dev.config[0x56] & 0xf;
>>> +    case 2:
>>> +        return s->dev.config[0x56] >> 4;
>>> +    case 3:
>>> +        return s->dev.config[0x57] >> 4;
>>
>> Shouldn't this be & 0xf?
> 
> No, the INTD value is actually in the high byte of reg 0x57. See e.g. 
> page 73 in the VT8231 doc Revision 2.32.

Correct (I was looking at rev 0.8 which is incomplete there).

Thanks,

Phil.

