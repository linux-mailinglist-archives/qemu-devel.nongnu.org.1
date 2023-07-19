Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC4759723
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7NI-0004TZ-F6; Wed, 19 Jul 2023 09:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7NE-0004SV-Ho
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7ND-0002nO-2h
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689773866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cz4+f+KIMtsW6wq8hQt9Rh7365exwgzjl+yduZhGTAY=;
 b=Zyf6M1UZBPagLLlhoW8XEYCRO7ZH93Oxwmv0lVh+P4yjHjStTU8gaKgLnTh+NkMkFXAU9e
 RDXJ5Z3QRzxUIfX6vjFK1iBRS/PpVsx4xTsiq4CVOhcofZO0d/lRAVKVktddK3aSW0p5E2
 f8oXik4z8BxX7ziKZJVi3BUzQWd6wDs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-eq7Tt5LcPUW6eyevJUeAXg-1; Wed, 19 Jul 2023 09:37:12 -0400
X-MC-Unique: eq7Tt5LcPUW6eyevJUeAXg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdde92299so36448425e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689773825; x=1692365825;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cz4+f+KIMtsW6wq8hQt9Rh7365exwgzjl+yduZhGTAY=;
 b=RoSd4RB5ovLg4YU1QrZRPOxc8G2Vk1iiqK4UzkwCLjXsbKR3TZAyWfPNZVVT/JO4nq
 4L6wJSShUJBiFb/9VynBdumZP+va4oq9B91978Fw/k1enHd7zHRrsWMSq7/9bPoSq194
 fKhVCoCq+HzI7DnqFYrI3qiJJorsjc1kg1W+e34cUA0QWq/dICSJtXQTlOoXvPs+m7AK
 /cefluAA0fAFLjKHuzDBlsuBWSQVg/dwioxX/OcC34vh9/eyAXXZHOp4GvqnYv63CMDC
 dASW9hin4cF5NdGydJn10mDatasUEmofjebzSh5kXLAHpRpjnt8CSz3/+FfvyBvJTwPV
 BGkQ==
X-Gm-Message-State: ABy/qLYyXfnN0Wx/rcg4MV993ef+7dNrIclyybEMphb4MAqEFLwoKMqK
 6n/oGI62Wm4yYh6tc3MbfolXNwkZht2+arlZYxfby5nxJuzoYDC9sHHr17NVfP/MGYMjVHXBqOW
 IO0FTb4irjsNgJKc=
X-Received: by 2002:a7b:c7c5:0:b0:3f8:2777:15e with SMTP id
 z5-20020a7bc7c5000000b003f82777015emr4377519wmk.31.1689773825410; 
 Wed, 19 Jul 2023 06:37:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEHvaGKlGVf9q38Yica4/pLqBZ2SrAymYZNHSGx+kZYIUCE8xWFEmrkCuu65bhN+LtKgxe+rA==
X-Received: by 2002:a7b:c7c5:0:b0:3f8:2777:15e with SMTP id
 z5-20020a7bc7c5000000b003f82777015emr4377500wmk.31.1689773825058; 
 Wed, 19 Jul 2023 06:37:05 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 v22-20020a1cf716000000b003fbc9371193sm1769797wmh.13.2023.07.19.06.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:37:04 -0700 (PDT)
Message-ID: <587fc88c-1b56-67f7-cfb1-58cea57df1a6@redhat.com>
Date: Wed, 19 Jul 2023 15:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/12] qtest: bump prom-env-test timeout to 3 minutes
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-8-berrange@redhat.com>
 <7fd24e86-46ae-28d1-912a-eb7a42ea6493@redhat.com>
In-Reply-To: <7fd24e86-46ae-28d1-912a-eb7a42ea6493@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/07/2023 15.22, Thomas Huth wrote:
> On 17/07/2023 20.28, Daniel P. Berrangé wrote:
>> The prom-env-test takes about 1 + 1/2 minutes in a --enable-debug
>> build. Bumping to 3 minutes will give more headroom.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   tests/qtest/meson.build | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index c6da428dc5..095c98820e 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -5,6 +5,7 @@ slow_qtests = {
>>     'qom-test' : 900,
>>     'test-hmp' : 240,
>>     'pxe-test': 180,
>> +  'prom-env-test': 180,
>>   }
>>   qtests_generic = [
> 
> I tested your patches, and initially, everything looked good now. But this 
> prom-env-test them reminded me that we run some additional tests in the 
> "SPEED=slow" mode ... I guess we have to take these into consideration, too?
> 
> I now did a "configure --enable-debug" build and then ran:
> 
>   make -j$(nproc) check-qtest-ppc64 SPEED=slow
> 
> and indeed, this prom-env-test is now timing out there. Also the 
> device-introspect-test was timing out in SPEED=slow mode. Should we bump the 
> timeout for those, or could this maybe be handled via the TIMEOUT_MULTIPLIER 
> in the final patch?

I've now done a full check-qtest run with SPEED=slow and --enable-debug,
and these tests are timing out:

  14/131 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test            TIMEOUT        300.02s   killed by signal 15 SIGTERM
  89/131 qemu:qtest+qtest-s390x / qtest-s390x/device-introspect-test        TIMEOUT         60.01s   killed by signal 15 SIGTERM
103/131 qemu:qtest+qtest-ppc64 / qtest-ppc64/device-introspect-test        TIMEOUT         60.02s   killed by signal 15 SIGTERM
108/131 qemu:qtest+qtest-ppc64 / qtest-ppc64/pxe-test                      TIMEOUT        180.02s   killed by signal 15 SIGTERM
129/131 qemu:qtest+qtest-x86_64 / qtest-x86_64/device-introspect-test      TIMEOUT         60.05s   killed by signal 15 SIGTERM
130/131 qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-test    TIMEOUT         60.01s   killed by signal 15 SIGTERM

  Thomas


