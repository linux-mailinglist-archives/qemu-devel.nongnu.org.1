Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC237BF7E1
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9OR-0007iI-Pd; Tue, 10 Oct 2023 05:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9OQ-0007du-0t
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9OL-00045m-Q2
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696931465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2Q/YWBsCpx2xy/0EQhZzEhe2g3WyDk5e5sPtL7OVlA=;
 b=DQzLeYXSe7wad2xvS1nYMxvtRvtjvZV6rYwNLh69onuTnbXhtm7SFLbno/ACLVqLdSn6Xi
 Cxhtc/RkKLrSefczyGuNhFzugsrRbYu9V1neqo71vHkOcX9WJcOPpdSUrshTxiYX2E1+pS
 R7EjzNN1C/cJpz5AxMK8Tew6o5Sk47I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-hhpOU60uNpqSPqVprBD0xA-1; Tue, 10 Oct 2023 05:51:04 -0400
X-MC-Unique: hhpOU60uNpqSPqVprBD0xA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77435bbb71dso579843385a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696931463; x=1697536263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P2Q/YWBsCpx2xy/0EQhZzEhe2g3WyDk5e5sPtL7OVlA=;
 b=KrNv0dug7EKZ+2t9RGpTzQbI0UxelPcNUbN3k0qeH7wprhGO38CuV8oQUhr0kO2Sr5
 F1RIuZqSO5Ws9jhLflQUHcQ1mPFW2Qiwofv7G9kJxPMTS+lYVGZzPZD/nQPPN77eNDCd
 AW0SYpYdtNcGGMxjGTyGoKZ2LEocLApLokLF4ASUAXQh8NP/2isTKsOEDL81QBybsJ4O
 X3khNX6odhoiwDhuYAti0sOpCh1uuvjd5DXlTPhKv86cCM7/QrOqcDnn9WpRwzoaKqbs
 xdDbgxxhr8d3X+JTZWPMQGvC1bqeZS+RJFXYGolmpW5F1owfGbRrvKm+zyT2ZckYFPST
 PXrQ==
X-Gm-Message-State: AOJu0Yyk5wn/CgDFLGyA9mxIVFnNga7JV9DZ1huzgsee9cCTIVu2p0WX
 uFDplumAVRKntPFqNQAeJZOBFhNh3K2qBZmrPxaZwDwPHn8jo8SKf3vGgEBn7VnwIddDNMvpERX
 tMpnXoI+Ss5S0VOA=
X-Received: by 2002:a05:620a:99c:b0:774:a9b:d62e with SMTP id
 x28-20020a05620a099c00b007740a9bd62emr15961276qkx.46.1696931463513; 
 Tue, 10 Oct 2023 02:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwggATuSm4vio0Z8MHRN+J/xGr4pMkH5MDB4gH2zVITYAi6iLdad3jMAbZdsCHoiCWKg+0Kw==
X-Received: by 2002:a05:620a:99c:b0:774:a9b:d62e with SMTP id
 x28-20020a05620a099c00b007740a9bd62emr15961268qkx.46.1696931463236; 
 Tue, 10 Oct 2023 02:51:03 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 a12-20020a05620a102c00b007759a81d88esm4174875qkk.50.2023.10.10.02.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 02:51:02 -0700 (PDT)
Message-ID: <df3fee4b-ebc1-77d2-a436-a7baf3317a42@redhat.com>
Date: Tue, 10 Oct 2023 11:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] tests/libqtest: Introduce qtest_get_base_arch()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-4-philmd@linaro.org>
 <c3b6a3a6-a320-f2f5-c200-da5b11e18c86@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <c3b6a3a6-a320-f2f5-c200-da5b11e18c86@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/10/2023 10.42, Philippe Mathieu-Daudé wrote:
> On 10/10/23 09:49, Philippe Mathieu-Daudé wrote:
>> While qtest_get_arch() returns the target architecture name,
>> such "i386" or "x86_64", qtest_get_base_arch() return the
>> "base" (or real underlying) architecture, in this example
>> that is "x86".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/libqtest.h |  7 +++++++
>>   tests/qtest/libqtest.c | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
>> index 1e1b42241d..54071e74ec 100644
>> --- a/tests/qtest/libqtest.h
>> +++ b/tests/qtest/libqtest.h
>> @@ -654,6 +654,13 @@ bool qtest_big_endian(QTestState *s);
>>    */
>>   const char *qtest_get_arch(void);
>> +/**
>> + * qtest_get_base_arch:
>> + *
>> + * Returns: The base architecture for the QEMU executable under test.
>> + */
>> +const char *qtest_get_base_arch(void);
>> +
>>   /**
>>    * qtest_get_arch_bits:
>>    *
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index a643a6309c..51cc92af21 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -925,6 +925,34 @@ const char *qtest_get_arch(void)
>>       return end + 1;
>>   }
>> +const char *qtest_get_base_arch(void)
>> +{
>> +    static const struct {
>> +        const char *const arch;
>> +        const char *const base;
>> +    } basearch[] = {
>> +        { "aarch64", "arm" },
>> +        { "i386", "x86" },
>> +        { "loongarch64", "loongarch" },
>> +        { "mipsel", "mips" },
>> +        { "mips64", "mips" },
>> +        { "mips64el", "mips" },
>> +        { "ppc64", "ppc" },
>> +        { "riscv32", "riscv" },
>> +        { "riscv64", "riscv" },
>> +        { "sparc64", "sparc" },
>> +        { "x86_64", "x86" },
>> +    };
>> +    const char *arch = qtest_get_arch();
>> +
>> +    for (unsigned i = 0; i < ARRAY_SIZE(basearch); i++) {
>> +        if (!strcmp(arch, basearch[i].arch)) {
>> +            return basearch[i].base;
>> +        }
>> +    }
>> +    g_assert_not_reached();
> 
> Sorry, I forgot to commit this change:
> 
> -- >8 --
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -950,7 +950,8 @@ const char *qtest_get_base_arch(void)
>               return basearch[i].base;
>           }
>       }
> -    g_assert_not_reached();
> +
> +    return arch;
>   }

I'd maybe also do a caching here, as suggested in the first patch.

  Thomas



