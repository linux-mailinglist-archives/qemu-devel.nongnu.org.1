Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA282D8E7
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 13:33:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPM4F-0000fo-LZ; Mon, 15 Jan 2024 07:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1rPM4A-0000fL-Mg; Mon, 15 Jan 2024 07:27:46 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1rPM48-0001Yy-SE; Mon, 15 Jan 2024 07:27:46 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bb9d54575cso6186544b6e.2; 
 Mon, 15 Jan 2024 04:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705321663; x=1705926463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ErQr9PlCsLWI8TxuouZWuEGVdB9M1Kny0aBK/rujuI4=;
 b=LwfEYyuWts0MbdGKuSTV2eFumjcy76KgGNeAUm6AkxSLCPzXqFOaU9XohxnBY6uRno
 i7BubHsF+i5Wb6B36+rWGxh7kpUe3sOcUU9c87kB+nM75FyC477J4Ts3dNc/xG9g9zr5
 4XJnpfm8xHxQIhtRmrcvvGdS4fbWuhnY7nezi6DTxttSq0hTP5AYJwJ2IP1mOKGVjYwQ
 hzZWs3bn4jDFxJd5+dYVF55cXavZygPAwidwMlkq7PKEkkMxMMhXmrsBE66+gpl/rozY
 rGyehO+qZ5YpPTqLTnwxcQ8aBF6PKhph0AXK6K0Lv45NBlv4+sL0aR1/PZ11s8CQCT1t
 XSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705321663; x=1705926463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ErQr9PlCsLWI8TxuouZWuEGVdB9M1Kny0aBK/rujuI4=;
 b=JHHPGPqYh1bUDZGQcpx6RtmzZwgxS9yfN1vVIkFYK0ZQEkGef1qKM/60cCXO5tf63Q
 TAtcQbBM9vYBf6Rj0RTt4f8xfWmPB4OAv7WS0u7l8ieD5wEJQ3wRmEMvj7OT9178wCKx
 OpKS9MaNQn5yqrgoHqNdJCW1IH8zW3tmAL3xVUShfoJiGV9AFQj84tV3XEnJMQDf2PcH
 9nocJDti7GezOxsr4aW9lCkRZVqBt2KYEpwTMqzqQNFBJvdGmI/TkYn4eq3CAJi5bDhV
 pl3NKljkM5Fv/naLaaXJHCU9e5znwyQFOvdhGzrxy9f5vGp26N2+XxJ+oN7R78CWEjGe
 yjXQ==
X-Gm-Message-State: AOJu0Yw9s92W8K/s567XGuNNWuiy6Npm604P2N+hN8C9NXgkPvI3GY97
 mjKIO9e0O4DE9F75Z/N0nu8=
X-Google-Smtp-Source: AGHT+IE2yeScTE9WTR39fjqKpV76psQBdSXipREZYcbdLdJNfpyZX3OEjG92jYoRDsBCn2AbF6S2xQ==
X-Received: by 2002:a05:6358:6151:b0:175:c391:cc7e with SMTP id
 17-20020a056358615100b00175c391cc7emr3479144rwt.17.1705321662655; 
 Mon, 15 Jan 2024 04:27:42 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 b6-20020aa78106000000b006db11bab9d9sm7468511pfi.202.2024.01.15.04.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 04:27:42 -0800 (PST)
Message-ID: <8e0b44e6-2e13-9abd-7d38-a488ff71448d@gmail.com>
Date: Mon, 10 Jul 2023 06:32:17 -0300
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.884,
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

FWIW if a comment is inaccurate/wrong it is fine to patch it during the code
freeze if needed.


Thanks,

Daniel


> 
> Thanks,
> Nick
> 

