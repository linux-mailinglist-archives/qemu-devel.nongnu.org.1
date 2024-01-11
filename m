Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE482AA72
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:05:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqzM-0001zh-LH; Thu, 11 Jan 2024 04:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqzE-0001zN-JO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:04:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqzC-0002tx-JU
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704963864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oIRh+2Uy4gZPKUWUpLuXL558IQcW5YiJHTK1psjwnOk=;
 b=AEFq6nZf3VzHhM8/UD4Mo51wprCt4r8OWkQPHsr2xf6/Xg4UsEPjAj7qVBlYpalX3TVCP3
 k85hvibjhscNtZcV/4uWY3ZR2zRMnfF4vC9ZHpMtTjSkV4WDHARXJOlnJwOU7uBemepllq
 F4FqFrVZPqniJubvETfVooDcbw6/dNE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-CLrp0O8mM2eQ_dTCXxmHdg-1; Thu, 11 Jan 2024 04:04:23 -0500
X-MC-Unique: CLrp0O8mM2eQ_dTCXxmHdg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-680c8d21542so106528846d6.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 01:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704963863; x=1705568663;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oIRh+2Uy4gZPKUWUpLuXL558IQcW5YiJHTK1psjwnOk=;
 b=ZZOXBc5p30+eIHv2khLEVhOVZtRGJQz7X8ZSLceCIRfpmfcq5fAhp/af1Dm/RhYIRS
 vHmE2C5CcpbqXDRUUckX8ACBsMhQgCJZtHGnsqBlq9wE/PYTw2A3ahLUKecDl1TuCjyw
 6MTDowgWu+bE0mQTQaKhNhMmf+xIPCyU23zkEpa8f3vGls0WOEpsY2goqSpdLUkH0va/
 EnCFsHS5NUQjlHk8X4bJULydXRtcJfAAU7cN+UpPbmCP5bfqvDphHQFbCjNE10Lb0IA4
 w6vLE/s7pfIFeUkah+Ug8WAWKHm+LSSD1bSQYZB7JpfiKqEdJzevR18OTIEa4xq9ikKI
 VfrA==
X-Gm-Message-State: AOJu0Yw2rzMEpxiv0US48f0SrvEOagfuzXApeT4jaWALlf6GUY6D3G4v
 3MwEiPrYa513GAGilDBqNGhs2lkxSbO4qKzgEBgzsIO8gtEKKTDJYc0pMV8pwoIYFNohKPfK8Bc
 SQ8v+++8goipPqlLUkK4Wqbc=
X-Received: by 2002:a05:6214:19e6:b0:680:a521:d86 with SMTP id
 q6-20020a05621419e600b00680a5210d86mr568768qvc.47.1704963862978; 
 Thu, 11 Jan 2024 01:04:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmB4OzJsukKEQ8atyw0znoZk8f7rR1V6ExPphdgIZsDEDVtfnnm8G4p06K4oO/usgQeoKo2Q==
X-Received: by 2002:a05:6214:19e6:b0:680:a521:d86 with SMTP id
 q6-20020a05621419e600b00680a5210d86mr568754qvc.47.1704963862762; 
 Thu, 11 Jan 2024 01:04:22 -0800 (PST)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a05620a214600b007830ce180basm211239qkm.120.2024.01.11.01.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 01:04:22 -0800 (PST)
Message-ID: <6f17d2f1-6876-4f1c-beb5-c6a4e89340d8@redhat.com>
Date: Thu, 11 Jan 2024 10:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
 <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
 <4cc9ab90-c1bc-03d3-d82e-a763199fa029@loongson.cn>
 <96bdddb5-e15c-469f-b74b-7e82049888f1@redhat.com>
 <3766d853-8dc5-f455-e0ea-dd970c65a6c5@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <3766d853-8dc5-f455-e0ea-dd970c65a6c5@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/01/2024 09.50, gaosong wrote:
> 在 2024/1/11 下午4:20, Thomas Huth 写道:
>> On 11/01/2024 08.37, gaosong wrote:
>>> Hi,
>>>
>>> 在 2024/1/11 下午3:10, Thomas Huth 写道:
>>>> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> Used to test 
>>>>> https://lore.kernel.org/qemu-devel/20231228084051.3235354-1-zhaotianrui@loongson.cn/
>>>>
>>>> So why is it NOTFORMERGE ? Don't we want to test KVM-only builds for 
>>>> loongarch in the long run?
>>>>
>>>>  Thomas
>>>>
>>> I think we can drop this title.
>>>
>>> I tested this job by the latest loongarch kvm patches.  buf I find a 
>>> test-hmp check error.
>> Can you recreate the error manually? i.e. compile with configure 
>> --disable-tcg and then run:
>>
>>  V=2 QTEST_QEMU_BINARY=./qemu-system-loongarch64 tests/qtest/test-hmp
>>
>> That should likely provide you with a hint where it is crashing
>>
>>  Thomas
> Thank you,
> 
> LoongArch no support these cmds  or some problems .
> -    "gva2gpa 0",
> -    "memsave 0 4096 \"/dev/null\"",
> -    "x /8i 0x100",
> -    "xp /16x 0",
> 
> Could we disable these 4 cmds or the test_temp check?
> After we fix the cmds problems, we can enable them.

Even if loongarch does not support one of these commands, it should not 
crash QEMU. So please fix the crashes first before considering to enable the 
KVM-only test in the CI.

  Thanks
   Thomas


