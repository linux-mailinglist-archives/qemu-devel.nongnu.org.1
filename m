Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99A07858C5
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 15:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnhO-000192-31; Wed, 23 Aug 2023 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnhE-00018E-Ga
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:14:52 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnhB-0005BK-L1
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:14:51 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso744190266b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692796487; x=1693401287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/MnCdS9A/UvZeuzDB0yy4EYxPNv3DR7lwYkFK4+8Uhs=;
 b=nb+rqMaAHGOBsFrVMSu4n99Kdb/nQKmeIrz8Tbc8E9DIARTzW6dcnu4Cr7vg0jC6GH
 1mzLNfxp/Jrf39yjX5rUziQdr78Spj0NbZ7Oqyvdsd0sMyHzP4QaUVjHzyNOnHHKauPp
 Qkk73jFTmtmxJh+h0aJJwvQt9dcfYjgvI1BVqLD9kYZbBib7ciTRHFI4HKut29DNtK1s
 27oLR4lad+V/zzLSOCq2VHyjro66pnbcIfMBiuJ/KrjroJRAG2uy57jd00krt178jjcj
 EyeUpFkIWN5TEYo0rkthB39lnY0NGVkfY8oLc2d+H6MyK90hmSZrjtx5sLJI/+5y4M15
 /mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692796487; x=1693401287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/MnCdS9A/UvZeuzDB0yy4EYxPNv3DR7lwYkFK4+8Uhs=;
 b=ftzCX8sxkQldDccXJ1HEVo16OW7kToBhbbrOURtsle5QAUiMOybJg04bV9MnC6mMZd
 Amh1OUOxD69Qgs9jZSbL7IfJzlkqzbIjPxhi105mK/8fXBA5tVIMptbVR9j1e1BGDxkE
 ARZvow52JCOc3wsNEND4eQVEDFy/+XEQ7MWygs4SNG80GXLIhq6Ly905tuXu+HxoHQdb
 QFCNQKB/x1bV19V2JB8zc5qvrUEfYyukBpWkBcHAXFTTtSzeN14GNt4rcpOfqXq643bg
 5+pzYaxe1fNPdS3fZj33ABZgqAQTCafrfeoPjrq8J1dLqmW0D9I3LdeMT1nB8ujt43KV
 KnGA==
X-Gm-Message-State: AOJu0YwQkYKuzUsA6S90IZSWjM/27AKCyUBgAqpzD/kS18O6lT6+vYqU
 flo8OhXhec6GvfeQ9OwRxGSnHw==
X-Google-Smtp-Source: AGHT+IHXWJFzynT4VP3msOsvFmj6b/m9g7KR7ehnJzwNmEToJv+Yt0sF22JYvZKmreQF+59N3n60fQ==
X-Received: by 2002:a17:907:a0c7:b0:99d:ddae:f75e with SMTP id
 hw7-20020a170907a0c700b0099dddaef75emr7670760ejc.57.1692796487383; 
 Wed, 23 Aug 2023 06:14:47 -0700 (PDT)
Received: from [192.168.69.115] (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 k15-20020a1709063fcf00b00977eec7b7e8sm9815030ejj.68.2023.08.23.06.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 06:14:46 -0700 (PDT)
Message-ID: <6d4f5e8c-82ae-4396-3c4e-fe0bfd721341@linaro.org>
Date: Wed, 23 Aug 2023 15:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/7] tcg/tcg-op: Document bswap32() byte pattern
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-3-philmd@linaro.org>
 <fd59f5e2-c125-6d12-cbd5-a12e3aca37ce@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <fd59f5e2-c125-6d12-cbd5-a12e3aca37ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 22/8/23 18:00, Richard Henderson wrote:
> On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tcg/tcg-op.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)


>> +/*
>> + * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
>> + *
>> + * Byte pattern:  bswap32_i64(xxxxabcd) -> ....dcba     (TCG_BSWAP_OZ)
>> + *                bswap32_i64(xxxxabcd) -> ssssdcba     (TCG_BSWAP_OS)
>> + *                bswap32_i64(xxxxabcd) -> xxxxdcba
>> + */
> 
> Again, TCG_BSWAP_IZ.

Whether TCG_BSWAP_IZ is set or not doesn't change the result, at the
end we have:

   bswap32_i64(xxxxabcd) -> ....dcba     (TCG_BSWAP_OS not set)
   bswap32_i64(xxxxabcd) -> ssssdcba     (TCG_BSWAP_OS set)

