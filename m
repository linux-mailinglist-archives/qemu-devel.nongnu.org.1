Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21F7874E2
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCs9-0006k0-D7; Thu, 24 Aug 2023 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCs6-0006jT-Lp
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:07:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCs4-0002Mb-Cc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:07:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso416235e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692893262; x=1693498062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Emrzqv3sEGEN4OUrZcmvk9rFKvC9tmhzBGydaZIpnN0=;
 b=J/NhJkApb6ZSRP/KcU7a0s8mNJOb5zvDnMq62V592dgoQePhhom+dypxSf/jnofd+t
 ibqltJJEIX8vpvm3E4SXjf78qZ8tb7LXeBYPK7Kpb2OnUqui/+/vAc86MLgKJi6iM5E2
 S1GH3jBswM4BP03g77XmdHBd1AzHuK6QMyNw6AOZTfpR2UMoL9kaiE0uQFbBcGCCEGj1
 ZxxgNSeReuvbKD34ktvFhasCecyX4A2VbXq25zsi0PtGpoPzCcbutIzOib1Y5IYbEnVu
 qzwRnhUkPl7ObZCCGwlWFUnVO7xgGWchVr0u1JAUlwg/6Q9iWgiQAcWxUDHuSHoOu6F0
 weSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692893262; x=1693498062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Emrzqv3sEGEN4OUrZcmvk9rFKvC9tmhzBGydaZIpnN0=;
 b=Uu7LJwqBXNY8Pdhpaj1HpcV27UnJDEfW34a/ZYP7ZWGqQU/Ve2ZLEvyJHWdmm4EA/J
 B4cJBQW+Fiu/FWqRkeBV0LGHl4VahHQrflwGmGzVlNt0N50P+fAC5Q44c7KQEhTF22q7
 i3F6Dk3RahWJBIb7k+ipHr9rw1cd7Ge2OdEkPMMT/5G+gnHIEWUs+MCaT/d/3yNZtzSX
 UaM5FUpowpiSIH63a2APbELWv5NdplWB7097EuRRqrXvDuZIa+q2gPWxeooRlXjmZNaB
 VziS6BrVb1p5/dLyB6qrQBR0+5BbD867Q1hp/vJ2dfN8UzPFCi6x69L/x1Z8xOQrG01E
 6YcA==
X-Gm-Message-State: AOJu0YzuYhPAScoGSEdnnZ9MPeklFoMsuvxT5x4hrT0W5/OicwDv1m/i
 U3ximugzkNFlfW4x5tA9DOj75w==
X-Google-Smtp-Source: AGHT+IHBt2qRB+sk2n3cYIiWr7ffUq4bKIluSd+7Li7a79jF+rJqoCKoSStbcHPC1mrqF+Z4lUGteA==
X-Received: by 2002:a05:600c:1d1b:b0:3fe:d589:ed78 with SMTP id
 l27-20020a05600c1d1b00b003fed589ed78mr11262892wms.20.1692893262294; 
 Thu, 24 Aug 2023 09:07:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b00401b242e2e6sm911737wml.47.2023.08.24.09.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 09:07:41 -0700 (PDT)
Message-ID: <1cb18092-0f85-0251-6604-d2ff20da72d8@linaro.org>
Date: Thu, 24 Aug 2023 18:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] hw/net/fsl_etsec/rings.c: Avoid variable length array
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, qemu-ppc@nongnu.org
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
 <20230824153224.2517486-2-peter.maydell@linaro.org>
 <663d4cd3-50d5-d5db-bd43-efc55fe6bbf0@linaro.org>
 <CAFEAcA-jswkb6JwPUMuBjvHFPo5YrAZMu5FBt7az_toVsQa=Jg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-jswkb6JwPUMuBjvHFPo5YrAZMu5FBt7az_toVsQa=Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 24/8/23 18:01, Peter Maydell wrote:
> On Thu, 24 Aug 2023 at 16:47, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 24/8/23 17:32, Peter Maydell wrote:
>>> In fill_rx_bd() we create a variable length array of size
>>> etsec->rx_padding. In fact we know that this will never be
>>> larger than 64 bytes, because rx_padding is set in rx_init_frame()
>>> in a way that ensures it is only that large. Use a fixed sized
>>> array and assert that it is big enough.
>>>
>>> Since padd[] is now potentially rather larger than the actual
>>> padding required, adjust the memset() we do on it to match the
>>> size that we write with cpu_physical_memory_write(), rather than
>>> clearing the entire array.
>>>
>>> The codebase has very few VLAs, and if we can get rid of them all we
>>> can make the compiler error on new additions.  This is a defensive
>>> measure against security bugs where an on-stack dynamic allocation
>>> isn't correctly size-checked (e.g.  CVE-2021-3527).
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/net/fsl_etsec/rings.c | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
>>> index 788463f1b62..2f2f359f7a5 100644
>>> --- a/hw/net/fsl_etsec/rings.c
>>> +++ b/hw/net/fsl_etsec/rings.c
>>> @@ -372,6 +372,12 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
>>>        etsec->regs[TSTAT].value |= 1 << (31 - ring_nbr);
>>>    }
>>>
>>> +/*
>>> + * rx_init_frame() ensures we never do more padding than this
>>> + * (checksum plus minimum data packet size)
>>> + */
>>> +#define MAX_RX_PADDING 64


>> Maybe we can add this for clarity:
>>
>> @@ -468,6 +468,6 @@ static void rx_init_frame(eTSEC *etsec, const
>> uint8_t *buf, size_t size)
>>         * minimum MTU size bytes long (64)
>>         */
>> -    if (etsec->rx_buffer_len < 60) {
>> -        etsec->rx_padding += 60 - etsec->rx_buffer_len;
>> +    if (etsec->rx_padding + etsec->rx_buffer_len < MAX_RX_PADDING) {
>> +        etsec->rx_padding = MAX_RX_PADDING - etsec->rx_buffer_len;
>>        }
> 
> I think that's a more confusing way of putting it. What the
> code is doing is "if the packet is too short, pad it to
> the minimum-packet-length", and the clear way to express
> that is "if (packet_len < max) add_more_padding;".
> 
> There is potential to use the constants ETH_ZLEN (60) and
> ETH_FCS_LEN (4) instead of the hard-coded 60 and 4 currently
> in the code, but I felt that was starting to wander a bit
> out of scope of just getting rid of the VLA.

Right. So possibly:

#define MAX_RX_PADDING (ETH_ZLEN + ETH_FCS_LEN)

but 64 is clear enough.

Thanks for the feedback.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


