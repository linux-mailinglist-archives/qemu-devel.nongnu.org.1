Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD0B96ED18
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 10:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTx5-0001R1-DB; Fri, 06 Sep 2024 04:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smTx2-0001Iw-Qj
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smTx1-0003EY-Dx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725609854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+stJx0Agx1+csL/PfOaGPAATnCpl2+3LhOUZyIB6jVs=;
 b=G3cM1QXH3qeWpD23QvWR3DZnqUhhTCguXWI0UyVBloUSkd/8DPsqtrR+TAyyTpo6qzK11A
 zBm8rwWk27vfFWDj+k34oGWk7UiUQuqbgo6SiBCgKj4JNllOy2zrfWSUhDOOaGRasjS2LE
 EyIYjYOqqaKsSDkstrGwaA8TfwYVDWk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-ce9099kLOF-k_lzNCvyKOQ-1; Fri, 06 Sep 2024 04:04:12 -0400
X-MC-Unique: ce9099kLOF-k_lzNCvyKOQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5356d0f6cdcso1642085e87.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 01:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725609851; x=1726214651;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+stJx0Agx1+csL/PfOaGPAATnCpl2+3LhOUZyIB6jVs=;
 b=cYJzvpGpx4bmwqRxXqIawBthXrS5z0FCdv6aFjTLtjeYQKHFMYWu71z21T7xFDq7Y/
 7fuLM9uC1/2L4rDrAQr/b25kUmuOUcP4YHglJL1B6PcX3eG2l0RC3U75lApirAnhZK5i
 Ga+ByYbIjimhvT+MM4yMBua9pqsv7ip+yjRMtx6HQpj2+O8GEOwxuYQdtPVTgWqwF6Nx
 Yzyw3gaZe/BfURvtfAaCurm036e+O2mCKh8dZIjxLJDKM6QwBB/6E9a1Fz0TccAUjL2a
 E6HjmTHl27V0CzfMdNS2L198iDryoVfj7WUkFyAQUhAsTwUDkgRegHENJTvoZlOmTgFD
 c18Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8L/6danzJ/EacVkYLCCxrhNzfV2MLSHWKn9+n4E5+TnU4yII8sYdu8DFwNwWnYnRAu9+OcMcL4G7B@nongnu.org
X-Gm-Message-State: AOJu0Yz26Wn4/dRv+1c+j7M5oJAuVIVeb69bufHRwFoWOSIqAdPf3xlG
 d5G6QxyZL7Ue9a9O9KuGNfErx5cE49VIXYFnQMlUwJwdjn1HsLfPWyWY1idC5P5tMovnXGhBvPh
 pzC58SnXIbQws4D5/KXvJRXX4J2XRDFiGSNDw/QA78ATQ8tERrIYq
X-Received: by 2002:a05:6512:3f12:b0:533:4785:82ab with SMTP id
 2adb3069b0e04-536587a67a8mr975432e87.1.1725609850633; 
 Fri, 06 Sep 2024 01:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfK8LUGQSSvUzl57BaMAfl7Pbh+peZbqnTaQI+CrVoqIoCgSPJ0odIxHfi9vQ7Argilt2rNQ==
X-Received: by 2002:a05:6512:3f12:b0:533:4785:82ab with SMTP id
 2adb3069b0e04-536587a67a8mr975401e87.1.1725609850002; 
 Fri, 06 Sep 2024 01:04:10 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-115-52.web.vodafone.de.
 [109.43.115.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7a1a4326sm152010266b.37.2024.09.06.01.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 01:04:09 -0700 (PDT)
Message-ID: <d4e13631-e468-4bd1-81e7-bb3bf8e2d495@redhat.com>
Date: Fri, 6 Sep 2024 10:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tests/qtest/boot-order-test: Make the machine name
 mandatory in this test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org
References: <20240905191434.694440-1-thuth@redhat.com>
 <20240905191434.694440-4-thuth@redhat.com>
 <639f1017-4e74-4fdc-89a6-6aeca6c0737c@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <639f1017-4e74-4fdc-89a6-6aeca6c0737c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 06/09/2024 09.59, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 5/9/24 21:14, Thomas Huth wrote:
>> Let's make sure that we always pass a machine name to the test_boot_orders()
>> function, so we can check whether the machine is available in the binary
>> and skip the test in case it is not included in the build.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/qtest/boot-order-test.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.c
>> index 8f2b6ef05a..c67b8cfe16 100644
>> --- a/tests/qtest/boot-order-test.c
>> +++ b/tests/qtest/boot-order-test.c
>> @@ -31,7 +31,7 @@ static void test_a_boot_order(const char *machine,
>>       uint64_t actual;
>>       QTestState *qts;
>> -    if (machine && !qtest_has_machine(machine)) {
>> +    if (!qtest_has_machine(machine)) {
> 
> Should we defer the NULL check to qtest_has_machine_with_env()?
> It uses g_str_equal() which is described as:
> 
>    Note that this function is primarily meant as a hash table
>    comparison function. For a general-purpose, NULL-safe string
>    comparison function, see g_strcmp0().
> 
> Better switch to g_strcmp0() in qtest_has_machine_with_env()?

What would be the intended meaning of the function when it is called with 
"NULL" ? Use the default machine? Skip the test? ... I think it is rather an 
error to call it with NULL, so it's OK if the test crashes here since it 
should never happen?

  Thomas



