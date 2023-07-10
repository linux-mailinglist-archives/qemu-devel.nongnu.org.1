Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3A74D1A1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInHO-0002UL-FK; Mon, 10 Jul 2023 05:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qInHJ-0002K9-PA; Mon, 10 Jul 2023 05:33:58 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qInHI-0007Qo-0T; Mon, 10 Jul 2023 05:33:57 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b7279544edso3311417a34.0; 
 Mon, 10 Jul 2023 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688981633; x=1691573633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EFnvFj52HHy5O9y/vfjTFb0gilUusvIfftTWh5seQ7c=;
 b=Wyv2xmiMYoW4+9Q7P7/9ctdimBJYiHWcP1JfZoETI5S645mfFv3rP6PYhqeKhS3I+A
 0XublXW8Hbpu5AAEWnIK1/jdsENAaxqy8mVu6oECpYYkZ+Dr5cERo+uvLRjXwo+DxcMJ
 qMJ4Cu3T/oXhvMzVjhQehhvQnOc6KntXeZ1YAdJR/GwT2DcE4rRA4ZtilsJU5Xtst8pE
 usBBdAvj6ZZPGKrYCX5DYHQslGA4JAQjZZ8dZQyR9GJ1yi/D2JJeH89fFORkFFUSZ5lI
 A2l6nBjXcpYc2bgbNFSdUJ05osN3dGmlICZhjff1LzPjO6DlwlQ/LM/lRFQLTG06c468
 KcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688981633; x=1691573633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EFnvFj52HHy5O9y/vfjTFb0gilUusvIfftTWh5seQ7c=;
 b=kuOj8FAY8pgVra8wZDkEaUxgrRE7+glvXbti1sHl3/XX4bMM+lToZix6XI5E3dmjRn
 Hot9brEprA5TJEG8ZUCEYDQjrhhZ3Jnj/LiYCYsQrlLSf7JpFS02tGA1zkqutApjQ/hh
 iZUu6odMauuhQnJ4TgMNpSWbXZZ2y+ew+PMhasLz35yw3fkslLdSZ4uI0qRuJn61w1Hb
 N4ZWePX0kS9qnCGpXUAvC5gGTAgEtfSK2+y59h14/G9tPC9zBSW48yY9d7hefMR8STQS
 0QbSB7M6wE/4UeSez8IesGQGX7y7kk7UjuPDt2UOAoXndGovyp79DzFZmgOtkVualAmm
 AXZw==
X-Gm-Message-State: ABy/qLalZtkaSAHcEh6SGMP2lKpSk21ev8HbXliXlH2PrOSNgiiDT2s1
 tdYAzFL74/Y718zEAtSkSMo=
X-Google-Smtp-Source: APBJJlG9X+N++rzLM5bieCTg0qp/KMNkryWmdhZeD4dv4ZPPbhZlmHR0eHwNfw6ZRM0ofOmJVyP/Ag==
X-Received: by 2002:a05:6870:e243:b0:187:e563:77b9 with SMTP id
 d3-20020a056870e24300b00187e56377b9mr12707499oac.45.1688981633131; 
 Mon, 10 Jul 2023 02:33:53 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 d17-20020a05683018f100b006b94fb2762asm1305922otf.23.2023.07.10.02.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 02:33:52 -0700 (PDT)
Message-ID: <92c81c75-881d-ba11-e864-a78c34b4f451@gmail.com>
Date: Mon, 10 Jul 2023 06:33:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] ppc/pnv: Add QME region for P10
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230707071213.9924-1-joel@jms.id.au>
 <CTWE73ZF1T37.IQUBV31TU3LF@wheely>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <CTWE73ZF1T37.IQUBV31TU3LF@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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



On 7/7/23 22:16, Nicholas Piggin wrote:
> On Fri Jul 7, 2023 at 5:12 PM AEST, Joel Stanley wrote:
>> The Quad Management Engine (QME) manages power related settings for its
>> quad. The xscom region is separate from the quad xscoms, therefore a new
>> region is added. The xscoms in a QME select a given core by selecting
>> the forth nibble.
>>
>> Implement dummy reads for the stop state history (SSH) and special
>> wakeup (SPWU) registers. This quietens some sxcom errors when skiboot
>> boots on p10.
>>
>> Power9 does not have a QME.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> 
> Nice, already merged but looks good to me. Just one thing...
> 
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index a4c9d95dc5d3..9bc64635471e 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -127,6 +127,17 @@ struct PnvXScomInterfaceClass {
>>   #define PNV10_XSCOM_EC(proc)                    \
>>       ((0x2 << 16) | ((1 << (3 - (proc))) << 12))
>>   
>> +#define PNV10_XSCOM_QME(chiplet) \
>> +        (PNV10_XSCOM_EQ(chiplet) | (0xE << 16))
>> +
>> +/*
>> + * Make the region larger by 0x1000 (instead of starting at an offset) so the
>> + * modelled addresses start from 0
>> + */
>> +#define PNV10_XSCOM_QME_BASE(core)     \
>> +    ((uint64_t) PNV10_XSCOM_QME(PNV10_XSCOM_EQ_CHIPLET(core)))
>> +#define PNV10_XSCOM_QME_SIZE        (0x8000 + 0x1000)
> 
> I couldn't work out this comment.

FWIW if a comment is inaccurate/wrong it is OK to fix it during the code
freeze window. No need to hold it until after 8.1 is released. Thanks,


Daniel

> 
> Thanks,
> Nick
> 

