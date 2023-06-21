Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9227386A5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:18:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByew-00070W-1m; Wed, 21 Jun 2023 10:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qByeu-00070O-8T
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:18:08 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qByes-0005cq-GS
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:18:08 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso765862566b.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687357084; x=1689949084;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TQ+aXEmKgFEn7tJ4vAhc3WH24tyhsAlVp0/QyUnd2WE=;
 b=FmdWo7kfX4YwdupWmW1KltEBU4sMiCR5mzABXNmuwHCrbjecyKWZjzAZmIhq0GFMcW
 WxE8P8AOxRxi0xjmDe8g9Yzn5JM8+p5DWlvGaEAuE5Q5tzz+Dpb9shINHX7FCfiLUmB6
 Wlnx9fVCTNmHLB2bEDF42MtPgylyVtjLZZsVvS5epKzQaPoQ3cvo8Fu21P0yw3IAJUst
 1bCQ8rlKXDCh/f/CbHZsP1dbYgl4clS5VCMCBrEvUU6sR00JojTYIbPWg7jBe0MgSzY9
 QrESG6JhQsHycjhazZEPlx3PI1qRqO0JquARktc6lMehMyIGjSxt7NY5Ta8l88lJtFfI
 ftCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687357084; x=1689949084;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TQ+aXEmKgFEn7tJ4vAhc3WH24tyhsAlVp0/QyUnd2WE=;
 b=FAp5O8g7BjRJIP4qAMLiAXs2Tq8KNyo9oCSpTdQCyqT6qJgP5HTpiZVtn0EtG4POuw
 ASDoiZMAiuNGAKkheTJcwC87MO4Li5YsTF0ZiZSsB583Ta6ey3ifbD4OpkxqJcXsrPvo
 PMlK2LVnTJvO2YGPLllpWTglMAEYDDWwjChX8Q8rHw2z1xWgrnJRzInHyOp8iOPCnUi1
 Xmvbzz2TsGyVb9l/i7yFOA3oKQ5kJ4dwXhUEyx+Emm77dwpL83PTrwR95U5Uww2IoOK+
 5cM5pmMImQsqAKar9TwxGpukIMX9Jxf6gECRAVDD/xQ/Th3vz9QBGPHhdGLmOH/v1u5a
 x3Ow==
X-Gm-Message-State: AC+VfDwUMxIJUTqa1DoHjhUnohubfc73WluOB1bAtlBMF3xuSTolpSGX
 K4aqiU3j/0a5CZtIGpd6Q0tJDw==
X-Google-Smtp-Source: ACHHUZ7GHgVZPLv74V9A0JBXyb63ISH35q5m9mnDiy+CXgVavLBKFzrIqKTJXJm+UaUIHTFDTaicnQ==
X-Received: by 2002:a17:907:6e1d:b0:988:8786:f573 with SMTP id
 sd29-20020a1709076e1d00b009888786f573mr9391407ejc.35.1687357083384; 
 Wed, 21 Jun 2023 07:18:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 ks25-20020a170906f85900b0098864f474cesm3207067ejb.126.2023.06.21.07.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 07:18:03 -0700 (PDT)
Message-ID: <e4d548bf-bc37-4f7b-f0cc-d9684639810b@linaro.org>
Date: Wed, 21 Jun 2023 16:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.1] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230405185922.2122668-1-richard.henderson@linaro.org>
 <2d46a274-8234-a635-81ca-c79c2969cb7b@linaro.org>
 <fc35257d-8af0-8aa1-af88-982c7506bfa5@ilande.co.uk>
 <a5c261f4-b3e5-314f-b28f-dfac54a0bed8@linaro.org>
 <f7d45693-78db-261b-f016-c198a7c98d97@linaro.org>
 <0489cb19-8d5e-7cdd-4c98-12fea8afa0d1@ilande.co.uk>
 <e4c9cd2d-7992-5506-1c10-638e97a66f0e@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e4c9cd2d-7992-5506-1c10-638e97a66f0e@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/6/23 15:47, Mark Cave-Ayland wrote:
> On 21/06/2023 10:14, Mark Cave-Ayland wrote:
> 
>> On 19/06/2023 16:41, Richard Henderson wrote:
>>
>>> On 5/11/23 13:02, Richard Henderson wrote:
>>>> On 5/11/23 09:40, Mark Cave-Ayland wrote:
>>>>> Obviously nothing notionally against this patch, however if you 
>>>>> could give me a few days to run my OpenBIOS SPARC32/SPARC64 boot 
>>>>> tests against git master with this patch applied to double-check 
>>>>> there are no regressions, that would be great.
>>>>
>>>> No problem.  I just didn't want it to get lost.
>>>
>>> Ping for results?
>>>
>>> r~
>>
>> Sorry I haven't had a chance to test this yet - I'll try and get to it 
>> later today.
> 
> I got as far as running my OpenBIOS sparc32 tests, and I'm seeing an 
> issue with my Solaris 8 image in that the mouse is frozen when booting 
> into the GUI with this patch applied so looks like something still isn't 
> right here :(

Could you isolate the 4 changes [*] to see which one breaks?

[*] 
https://lore.kernel.org/qemu-devel/676ac594-77c6-3953-7355-1b96a09d93df@linaro.org/

