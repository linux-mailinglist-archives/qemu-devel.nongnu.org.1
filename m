Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466970E2C1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Vq4-0004Ij-C4; Tue, 23 May 2023 13:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q1Vq2-0004I7-A1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:30:22 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q1Vpz-0007HQ-IP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:30:22 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f4bd608cf4so146704e87.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684863013; x=1687455013;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0pabE7NQiyY2gNvPqjKOjWLJIy9hK2vs/rDgVs//+QM=;
 b=DUvtk56hS19HpM26azZ//QrbFtFPA4dOZrHSs4GKWvhFm/0lIUNq1T88eGskoLmqm3
 x96jxsTzTs/0E26KrA2LrEKC0Rr/MKrGRxx4FR6dgISfglxwwy5p6rAPcThoLWjya2NN
 hy3fWnWoA0ddBtCoeuk2LGDjwzGd5/ZQyhLIxHVrUxBhCslZoXNmFCKbEBEVH/mykNnO
 oLUJkLSqBTBqKlL3UqLkGgXUH3+P1EWqRYY18e0UE8jLzlpjZjDAs+lF/Ot/SsR4BscX
 zzDNx8C3XSm4cGi6YcwhszhunfAGJH0TE7G7u4sYnUhEdXhN8EscDwTMQtkTVQJpIvum
 8Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684863013; x=1687455013;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0pabE7NQiyY2gNvPqjKOjWLJIy9hK2vs/rDgVs//+QM=;
 b=TJng49sCvZVCo2s2x7bg09Q8yffZS/YmahSJ+qMVz7R/zdGjIAWserk7V6MdJ7kJ/Y
 /5hDTUA80jInvy3JOeC887bSct4/Oti3oiqxkqVzC9nzuRqHXcZkD6u67/uxaB6wNPYl
 2ty7kbbJ72s5g04DJ223J7WsyLH/UHxUnOawntuKRGHmGBGJ5SZ0Y/CIxk+5xGkIP6go
 GHvORpgTD9rYk+GjV2CLugiQfkRH4Qj1AKIqulLBtJFg4tjUP3eSDWMlWuTD7uV/6C4b
 lC6bG2k9v2TqUYyzRDIDHXgCAiSCve5pXMwX19Tdk3fIM1N/dcejMeZTymwjGFMZWkg/
 Gzfw==
X-Gm-Message-State: AC+VfDzL4VDjV9qNJ6QRcN63HnF+sSVSq9bVT+c594mL9Z5QUhjZ2cUY
 fV8h7/oJdxYjh6XIHSPBwy1m/A==
X-Google-Smtp-Source: ACHHUZ5cmZh3i7hCJdzJn4VOdK+ScwUFyUs1/K07NQGZKInVP4UubSx+T6wLxqbwY8iQR8XlDLIalQ==
X-Received: by 2002:ac2:4c8a:0:b0:4f3:78e5:fe93 with SMTP id
 d10-20020ac24c8a000000b004f378e5fe93mr4878524lfl.6.1684863013373; 
 Tue, 23 May 2023 10:30:13 -0700 (PDT)
Received: from [192.168.200.206] (83.21.125.167.ipv4.supernova.orange.pl.
 [83.21.125.167]) by smtp.gmail.com with ESMTPSA id
 j14-20020ac253ae000000b004f2391fe9a6sm1412487lfh.266.2023.05.23.10.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:30:12 -0700 (PDT)
Message-ID: <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
Date: Tue, 23 May 2023 19:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
Content-Language: pl-PL, en-GB, en-HK
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
 <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 23.05.2023 o 19:11, Thomas Huth pisze:
> On 23/05/2023 17.56, Marcin Juszkiewicz wrote:
>> We moved from VGA to Bochs to have PCIe card.
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> ---
>>   docs/system/arm/sbsa.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
>> index b499d7e927..fea4992df2 100644
>> --- a/docs/system/arm/sbsa.rst
>> +++ b/docs/system/arm/sbsa.rst
>> @@ -27,6 +27,6 @@ The sbsa-ref board supports:
>>     - System bus EHCI controller
>>     - CDROM and hard disc on AHCI bus
>>     - E1000E ethernet card on PCIe bus
>> -  - VGA display adaptor on PCIe bus
>> +  - Bochs display adaptor on PCIe bus
>>     - A generic SBSA watchdog device
> 
> While you're at it, I'd suggest to replace "adaptor" with "adapter" 
> which seems to be way more common in the QEMU sources:
> 
> $ grep -r adaptor * | wc -l
> 5
> $ grep -r adapter * | wc -l
> 385
> 
> With that changed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks. changed.


> PS: An idea for another patch: I think the "config SBSA_REF" in 
> hw/arm/Kconfig should select BOCHS_DISPLAY now, since this board seems 
> to always require this card now 

Thanks, patch sent.

> (is there a reason why it can't be disabled with "-vga none" or "-nodefaults"?)

That's something I need to check how it should be done. Should it also 
drop default_nic?



