Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A32687BFBCE
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:52:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCDA-0001LO-6J; Tue, 10 Oct 2023 08:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqCD6-0001HK-UN
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:51:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqCD5-0004Gb-Cm
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:51:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-406619b53caso52027265e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696942298; x=1697547098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KsJArOHAN2cwtI11AhYTzL4+oI2lHJ+UTI21gazpbN8=;
 b=hcgJ06Tc+NP0Bd9QnR4GWr920WmONb1w+LpP8zuxutF0ejp2M/yw53g7QihbuQTcpG
 BuGq2j9I8laInUeioHOxk+ZYFCPhBoWe363Eucbte/vkTPM+NUMnAeWD+Ma3rCoxgV76
 /LBoixy++Fnl+ZeSOgSzqVARlKGRzQorUXN9Njngg0Ra+DXnVVF+at3wj219u8bX3i63
 4L534ISbzq5iKrmWzaPx7XG3V37LJAobOcGR7npmkTarsCxjgvwfEnLScvi14VKQFen0
 bpL7UfW6zgkyw21taAAFkGL1cyQrzwsx9kkY3t9quwFnRXHz5YTZAifU24EBa2FgoW7z
 HPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942298; x=1697547098;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KsJArOHAN2cwtI11AhYTzL4+oI2lHJ+UTI21gazpbN8=;
 b=j22aACjylhjO0yhetp8wEVpHOJsARGKZzgX3SWjK+oazKLGdEe2NnK/Pmk8vnCizxf
 7DPAZtgLcAiS/xekrLqa0EQOWcqsTCxo1vJYHEps3bwhnp+GWbtgex8HEgOZW4fF7OR9
 fasbaPDjv+iA/ntU3SPhW6ybb8FyaotBqRYmJkFvCKLUM7l7kMo7eH71Rwx1dQ2UZ5Vz
 IYB1kjUW4GIW+q8XrlhH/TUF4yYIB3QbkvQRA6hSqLlZ1lixgi/GIWnIH2x8ccaeTXtE
 14RvRLEbQMGm4G0OG4mZG46XEgfi2VPpSEMWjYxTB69LLeZ34Yw99yPXM3tTX0x0Vqly
 nL1A==
X-Gm-Message-State: AOJu0YwRa8UqOoJEM1M2TDC49Bv6u5bUr8BYX+YcubFSjLDRV/RV/acy
 naVwfWoPm0wPPieOPc4dDTLqlA==
X-Google-Smtp-Source: AGHT+IGNdEqXEpliabHovL3RMqX7oexLhy401JdrAvNJhJlKfNLF92/BRkk+YrEgoY5grKamEdcpuw==
X-Received: by 2002:a05:600c:20b:b0:406:177e:5de8 with SMTP id
 11-20020a05600c020b00b00406177e5de8mr16171604wmi.35.1696942297835; 
 Tue, 10 Oct 2023 05:51:37 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 k21-20020adfb355000000b003296b913bbesm12065937wrd.12.2023.10.10.05.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:51:37 -0700 (PDT)
Message-ID: <6c800198-6562-afef-8d48-8d23dd45c67f@linaro.org>
Date: Tue, 10 Oct 2023 14:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/6] hw/display/vga: Clean up global variable shadowing
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20231010115048.11856-1-philmd@linaro.org>
 <20231010115048.11856-4-philmd@linaro.org>
 <0FFB0F58-830E-47D6-BC07-E668EDE2692C@redhat.com>
 <5e31c60b-08f9-0bb5-b35b-849695364751@linaro.org>
In-Reply-To: <5e31c60b-08f9-0bb5-b35b-849695364751@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 10/10/23 14:50, Philippe Mathieu-Daudé wrote:
> On 10/10/23 14:46, Ani Sinha wrote:
>>
>>
>>> On 10-Oct-2023, at 5:20 PM, Philippe Mathieu-Daudé 
>>> <philmd@linaro.org> wrote:
>>>
>>> Rename 'address_space' -> 'legacy_io' and
>>> 'address_space_io' -> 'io' to fix:
>>
>> This works but why not replace address_space with legacy_address_space 
>> instead?
> 
> I'd rather avoid using 'address_space' for MemoryRegion, since we
> also have an AddressSpace type.
> 
> Besides, both regions are mapped in I/O space.

That said, I should clarify that in the patch description.

> 
>>
>>>
>>>   hw/display/vga.c:2307:29: error: declaration shadows a variable in 
>>> the global scope [-Werror,-Wshadow]
>>>                 MemoryRegion *address_space_io, bool init_vga_ports)
>>>                             ^
>>>   include/exec/address-spaces.h:35:21: note: previous declaration is 
>>> here
>>>   extern AddressSpace address_space_io;
>>>                       ^
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/display/vga_int.h |  4 ++--
>>> hw/display/vga.c     | 12 ++++++------
>>> 2 files changed, 8 insertions(+), 8 deletions(-)
> 


