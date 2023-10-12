Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 718367C6DCF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:18:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqud1-0001xb-BR; Thu, 12 Oct 2023 08:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqucx-0001xM-FT
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqucr-0001PY-QS
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697113032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ph7n8tJYsbvWTmdp22CfcOsthceY1fT/a81cDKZP4Jw=;
 b=OCy0SeciHjeCRGSrmK/YAJ1YGB4E7J674goLjXVLJJ4lMJS/4VtIWOnQFuqLbr2GcdD7++
 ZzUvFEAhMwuOGv47pOFvsPG6oefs0ypgn4hGUgb2a/58hhjG8Bjubq5a7QZW+Fwgi+UflC
 W58u9Wltxdyn14xIzlgrxs2VRBMmK04=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-6pB4Z-rCPdmSJl_zOuxVgQ-1; Thu, 12 Oct 2023 08:17:01 -0400
X-MC-Unique: 6pB4Z-rCPdmSJl_zOuxVgQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65b13c48253so10034216d6.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113020; x=1697717820;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ph7n8tJYsbvWTmdp22CfcOsthceY1fT/a81cDKZP4Jw=;
 b=PC1pSi9ptVK3QyIGUbaEmrTt/K9+RmfLwAb8hoo+AXADesUGiC2Q/gGqX0tlVhzVvo
 s1cWHpg12WNg8I2fliNfLkdBArmqSQXqyDP2FpDbE2TeMK0BdBw4kLdAqe8kgV/vVzXb
 aSp8yLZ3wmlB7qBAAOKChKULxKcbQdrtxAf3Ls3jvfdHbmsHZP1uPO/AgMNiPEmF7H63
 3z5dgA0WMrSjRDOq4/DN9KBdZ0amd4tNh1VPP70SABhVqo8dduhHByqQ267R9S02KL2F
 zwvGYiMEhsaGqM/O5AUNh9Fd5XHrr3LgcMW/5zwstYWmdlEwF+CAT5qzZhXpbjZPGi6D
 ZRmw==
X-Gm-Message-State: AOJu0YzEi0Pawf4yG/jCe8Vfot5eVOapjijCUQtiRVkab+vNZNI2s0/f
 N7Q/Mc21k2vrH+pq807anNVskRJH3llM2azt5o8tcP/23vp5v/mePlHGxCOQeZvpVrDgCIoiTwV
 Za/JU9oGreM63fQE=
X-Received: by 2002:a05:6214:e49:b0:66d:12a3:ec8c with SMTP id
 o9-20020a0562140e4900b0066d12a3ec8cmr2639430qvc.30.1697113020592; 
 Thu, 12 Oct 2023 05:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfEdiG/eX3G3Zo1uGDbMKZu7FJ8HNtnAZ113aZiyLbLbwhmFEKWF33/9mBNYIvFcoz/gcX1w==
X-Received: by 2002:a05:6214:e49:b0:66d:12a3:ec8c with SMTP id
 o9-20020a0562140e4900b0066d12a3ec8cmr2639410qvc.30.1697113020310; 
 Thu, 12 Oct 2023 05:17:00 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 y14-20020a0ce04e000000b0065b151d5d12sm6493716qvk.126.2023.10.12.05.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 05:17:00 -0700 (PDT)
Message-ID: <82aa015a-ca94-49ce-beec-679cc175b726@redhat.com>
Date: Thu, 12 Oct 2023 14:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Disable the riscv64-debian-cross-container by
 default
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
References: <20231011144224.816549-1-thuth@redhat.com>
 <31a7782f-870b-4ef8-a857-33018b9de0e1@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <31a7782f-870b-4ef8-a857-33018b9de0e1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/10/2023 16.53, Michael Tokarev wrote:
> 11.10.2023 17:42, Thomas Huth wrote:
>> This job is failing since weeks. Let's mark it as manual until
>> it gets fixed.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> I was about to sent something like this about a month ago, but
> got distracted.
> 
> Acked-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks!

>> ---
>>   .gitlab-ci.d/container-cross.yml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/.gitlab-ci.d/container-cross.yml 
>> b/.gitlab-ci.d/container-cross.yml
>> index e0d75d5824..2848166ba3 100644
>> --- a/.gitlab-ci.d/container-cross.yml
>> +++ b/.gitlab-ci.d/container-cross.yml
>> @@ -95,6 +95,7 @@ riscv64-debian-cross-container:
>>     allow_failure: true
>>     variables:
>>       NAME: debian-riscv64-cross
>> +    QEMU_JOB_OPTIONAL: 1
>>   # we can however build TCG tests using a non-sid base
>>   riscv64-debian-test-cross-container:

Drat, looks like I forgot to CC: qemu-devel ... done now, so in case anybody 
else has an opinion on this, please let me know!

  Thomas


