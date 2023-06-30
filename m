Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3F74400A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:45:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFHEn-0008Dq-Op; Fri, 30 Jun 2023 12:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHEm-0008Dd-Ef; Fri, 30 Jun 2023 12:44:48 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHEk-0001Cp-IT; Fri, 30 Jun 2023 12:44:48 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1b0249f1322so1783156fac.3; 
 Fri, 30 Jun 2023 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688143484; x=1690735484;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AH0lKP7+dl6XZk5temT6Id7ecO5HMnksTtL7RjXm4H8=;
 b=cF2uIRPX5yw2lup/cbp53ZFRP3yT7brN5mVn9J3xU3v9eqNIPxMsbRjbrSmEhoxysu
 Ny+xwqnB1P2cmkAOlNakhQC0a90oyDBAM02/8UNYK4EY0yAqJdR26KGox5BI7nMn18AL
 X+EM9M6qHDiEa8Y1yFPcGsbQHKU7gp9yW76Oe5CBooXku9CtVGCbHdoh0Eztd3WGbAWT
 Db1r9jnn+Z8k0LjIve5FKvMZnpiDB+g8A1PBNeazvLSFGvnI7vWnm6uFZco82vXC87P5
 mUBsqgZv211B/MBOTiIvosXCsG42j0jJsJwiRCkL6McyzP7/XGqdggPdLZvhwAjjBRWw
 Vjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688143484; x=1690735484;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AH0lKP7+dl6XZk5temT6Id7ecO5HMnksTtL7RjXm4H8=;
 b=FVgpM5d+126jDJhP1ja/hZOWjkJLVcynMOr6JM/WY4BdRJDGi0FHDEwgyaSTt1t7GC
 09XpnqZsnl7sk8gWApjsUBi2Tl48ZoVOKQlwRbW1J/A6fSGOjDhT6e6jpujTeOwJKOMH
 gKczWc3idMTlJ5J/zQYcMuyimUtnL1+ZALfy71SWdbU3/VXQKMOki0MbpILyD9uSy2+A
 pcNGmAZQmqWiE6Du3kTBQT0CjN3DKw2BMCvL3279HdQHsh0IGC+1+/OkY7+S9SZH8Sru
 NeqX9/QXXMlLPrpjm6b9JaLz6qwAcKAMfIqTO3pHtSTVn2XcBupuPdBVAeTXuMNURtwi
 8ccA==
X-Gm-Message-State: ABy/qLZWMHNPnIr3j69/aq29DeAvOqmId2gx/rzqGgXen/cLiSySxM5y
 toiuQSZsulXHEfJmieqSbVejLzKdsl0=
X-Google-Smtp-Source: ACHHUZ5z1KfayHJzQbJAgIo+DP6hlaVFj1YpJ7O/IS2ByZj1U5a0zXKkrK+m1DtbAH5aoZJ8Up15Mg==
X-Received: by 2002:a05:6870:9d05:b0:19f:202b:513c with SMTP id
 pp5-20020a0568709d0500b0019f202b513cmr3942317oab.29.1688143484378; 
 Fri, 30 Jun 2023 09:44:44 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 ne16-20020a056871449000b001a6d15fc52fsm9159922oab.4.2023.06.30.09.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 09:44:44 -0700 (PDT)
Message-ID: <8168ffc8-a20d-b6ad-581e-b0f4a1887468@gmail.com>
Date: Fri, 30 Jun 2023 13:44:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mv64361: Add dummy gigabit ethernet PHY access registers
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230605215145.29458746335@zero.eik.bme.hu>
 <a56d91b8-696f-a56e-904d-cda8a2ec3a16@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <a56d91b8-696f-a56e-904d-cda8a2ec3a16@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/14/23 16:21, BALATON Zoltan wrote:
> On Mon, 5 Jun 2023, BALATON Zoltan wrote:
>> We don't emulate the gigabit ethernet part of the chip but the MorphOS
>> driver accesses these and expects to get some valid looking result
>> otherwise it hangs. Add some minimal dummy implementation to avoid rhis.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> This is only used by MorphOS on pegasos2 so most likely could go via
>> the ppc queue.

And it will.

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel


> 
> Ping?
> 
> Regards,
> BALATON Zoltan
> 
>> hw/pci-host/mv64361.c | 6 ++++++
>> hw/pci-host/mv643xx.h | 3 +++
>> 2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
>> index 19e8031a3f..01bd8c887f 100644
>> --- a/hw/pci-host/mv64361.c
>> +++ b/hw/pci-host/mv64361.c
>> @@ -541,6 +541,12 @@ static uint64_t mv64361_read(void *opaque, hwaddr addr, unsigned int size)
>>             }
>>         }
>>         break;
>> +    case MV64340_ETH_PHY_ADDR:
>> +        ret = 0x98;
>> +        break;
>> +    case MV64340_ETH_SMI:
>> +        ret = BIT(27);
>> +        break;
>>     case MV64340_CUNIT_ARBITER_CONTROL_REG:
>>         ret = 0x11ff0000 | (s->gpp_int_level << 10);
>>         break;
>> diff --git a/hw/pci-host/mv643xx.h b/hw/pci-host/mv643xx.h
>> index cd26a43f18..f2e1baea88 100644
>> --- a/hw/pci-host/mv643xx.h
>> +++ b/hw/pci-host/mv643xx.h
>> @@ -656,6 +656,9 @@
>> /*        Ethernet Unit Registers       */
>> /****************************************/
>>
>> +#define MV64340_ETH_PHY_ADDR                                        0x2000
>> +#define MV64340_ETH_SMI                                             0x2004
>> +
>> /*******************************************/
>> /*          CUNIT  Registers               */
>> /*******************************************/
>>

