Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DF7EBD02
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 07:20:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r39GI-0004AO-CV; Wed, 15 Nov 2023 01:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r39GA-00043q-Bi
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r39G7-0007yE-80
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700029218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YuTvJBgGWZdD8yO9Vx5pXSdc+8jo/8x+GtRVXZh8JEM=;
 b=MnK8gTCgiksivemSrtZVeQjqKyL6OiH21kqAwInJLR5fEIubH8kVyGvmIsQdG3AjfHbFXZ
 tLkedPF5FjynSBR96zmEpIdz6OTfJLe1elYcFFyjDHMMAD2T1yiTOU9vgAl/Q4UBdL5nde
 7W4UvZ3hfYox0lpLwrtomoICSw2hS+U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-G4IDOrUYN4uhMLQxFaeuvQ-1; Wed, 15 Nov 2023 01:20:16 -0500
X-MC-Unique: G4IDOrUYN4uhMLQxFaeuvQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4092164eceeso40249365e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 22:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700029215; x=1700634015;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YuTvJBgGWZdD8yO9Vx5pXSdc+8jo/8x+GtRVXZh8JEM=;
 b=ToG8ogUbtEwb+Q55ncPIYOChhsLL/ixLKfB8L7RtUX5SkYdKL+Q35ef8ZCOqfGNCzr
 1EKNTFBetf9xuBwlNWA2OjpBiKEL4aM9JN7WIa4Vhf/P2/TRscwRCQT8GELKqFerrZ+c
 tXvETpg5PybrKOefQqCkV0LwmGOMbtO/UufjgOVflxi9Xg15oym1EMdBGeTzF+dYTiqV
 CYqiZH7NwS8uZDTkRTEIsQS4mkA+yiBUfu87hyoI9RhgBoMG+7RMBXa2fTQ8368lZI9O
 YB07Y2gd4RYI7HceWHr0RhOD9DVn/v9U9M36R/5lzmPNMD/mvVnRbk1aVZkMAGFpSPEM
 wMGQ==
X-Gm-Message-State: AOJu0YzxQx5sSxZj+xoKpQp5E6gM5mARaxoDxAwi2FKOIWFbjTb2aSn8
 2aN2p9hYQdL/qqVJdxn7yf2MAa5Qt311DDl9J42JcvB0OHAsScMS+kXAuANghaOaoy959T8lqDA
 meQJ/bGDzWOGHDjE=
X-Received: by 2002:a05:600c:3b13:b0:40a:4c7e:6f37 with SMTP id
 m19-20020a05600c3b1300b0040a4c7e6f37mr8777359wms.20.1700029215535; 
 Tue, 14 Nov 2023 22:20:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5vuQ2mZf5cV6fxWfdGicndmfZI8HTqPYxjwzSzulNqBL7v1Xh1xjwQnDn5q2/eSfaVoAteQ==
X-Received: by 2002:a05:600c:3b13:b0:40a:4c7e:6f37 with SMTP id
 m19-20020a05600c3b1300b0040a4c7e6f37mr8777340wms.20.1700029215144; 
 Tue, 14 Nov 2023 22:20:15 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 p37-20020a05600c1da500b004064ac107cfsm14055749wms.39.2023.11.14.22.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 22:20:14 -0800 (PST)
Message-ID: <ff6f2d1f-dc7a-408c-a6d8-19e5fec9fea6@redhat.com>
Date: Wed, 15 Nov 2023 07:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/intel_iommu: Add asset hashes to avoid
 warnings
Content-Language: en-US
To: eric.auger@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20231114143531.291820-1-thuth@redhat.com>
 <5f09ba2a-3e62-454a-8665-0f80508b5168@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5f09ba2a-3e62-454a-8665-0f80508b5168@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 14/11/2023 21.42, Eric Auger wrote:
> Hi Thomas,
> 
> On 11/14/23 15:35, Thomas Huth wrote:
>> The intel_iommu test is currently succeeding with annoying warnings.
> nit: you may have precised the nature of the warning or quotes

The annoying warnings look like this (in the summary):

  (031/174) tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu: WARN: 
Test passed but there were warnings during execution. Check the log for 
details. (67.87 s)
  (032/174) tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict: 
WARN: Test passed but there were warnings during execution. Check the log 
for details. (55.83 s)
  (033/174) 
tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict_cm: WARN: 
Test passed but there were warnings during execution. Check the log for 
details. (56.01 s)
  (034/174) tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt: 
WARN: Test passed but there were warnings during execution. Check the log 
for details. (54.06 s)

... not too helpful to quote them in the commit log, I guess...

>> Add the proper asset hashes to avoid those.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/intel_iommu.py | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
>> index 474d62f6bf..77635ab56c 100644
>> --- a/tests/avocado/intel_iommu.py
>> +++ b/tests/avocado/intel_iommu.py
>> @@ -54,9 +54,11 @@ def common_vm_setup(self, custom_kernel=None):
>>               return
>>   
>>           kernel_url = self.distro.pxeboot_url + 'vmlinuz'
>> +        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
>>           initrd_url = self.distro.pxeboot_url + 'initrd.img'
>> -        self.kernel_path = self.fetch_asset(kernel_url)
>> -        self.initrd_path = self.fetch_asset(initrd_url)
>> +        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
>> +        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> +        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>>   
>>       def run_and_check(self):
>>           if self.kernel_path:
> Besides,
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

  Thomas


