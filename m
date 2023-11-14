Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9E7EB688
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 19:41:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2yKM-0005Dt-TG; Tue, 14 Nov 2023 13:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2yKK-0005DK-FX
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 13:39:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2yKG-0007N9-0y
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 13:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699987191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UObGP3QFNtfIy2GcrKFIqF0pXREqdq7AWbYwSz/+ais=;
 b=aXQuIOXIeDOYXCC3K0CGw8r/L9T2uL4arY7vsyVx7LBjEURU9rucHwA432miHDLu4QGiBj
 V36sa4VQfAZOLmnCxRKY5MB/RaPVBNyY0N6G/UUH8jkE4uhP3I+6NDFZTG/cBiDNkqb1p3
 2G5UP3XTDXL9p+NoK6pF2NKoxB7dfzs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ogwxTBnyPAe0HMZwT-Xcgw-1; Tue, 14 Nov 2023 13:39:47 -0500
X-MC-Unique: ogwxTBnyPAe0HMZwT-Xcgw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5a828bdcfbaso82475547b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 10:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699987187; x=1700591987;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UObGP3QFNtfIy2GcrKFIqF0pXREqdq7AWbYwSz/+ais=;
 b=JLN1iSr6xDfD9E7WA22/hRegUR9KfHI8fUhFN2bT4jDiUdLbbDd0rQgk0OFsfIm1NT
 hw70EWagQy636ewaQp7RWKU3lMkNsyBFRFuxZbZecjwJufE3VlAuenULHtzmwo19WNG+
 hET3wtnUmApwGG9gGgvSU473GClAmgQ10SM2dgrxhHrNmj3A8ZwBxQT3LK8JWCJZvemD
 o3OMRE0Lq+e5BMReE1oQfNxg1ty+TAwsWK7budVloc67p8jCgIHj9QqmXZdZoVu8Reu1
 mqfosjLCHbGvH5JtYQ6ZjxUrQsURlIBvNL09htEvwu9LQL4kkoaXo4SVA/CXMYohpSDz
 KSSw==
X-Gm-Message-State: AOJu0YxDXBweAzJKJ2kDMXVAciFW9cGlO7HUfvY0RokEPP3DWjvgvRF7
 a//pgIA7jO05M4ApK5wBkpSFSjzwh6gK12GyyNjUFjYOpO9uIHaO2BdrSXSCRX6igpnFOoqnXfm
 N9YVLcCLoNHrj2Ao=
X-Received: by 2002:a0d:e213:0:b0:5b3:1d71:6df2 with SMTP id
 l19-20020a0de213000000b005b31d716df2mr11099256ywe.33.1699987187033; 
 Tue, 14 Nov 2023 10:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEuxQI3TmusSkkIf+uaFTbliyRKTcNhS8VCs+oJ3iYdYfWxKgU0JF1HQ+hzmFhWVkZu7jo7A==
X-Received: by 2002:a0d:e213:0:b0:5b3:1d71:6df2 with SMTP id
 l19-20020a0de213000000b005b31d716df2mr11099235ywe.33.1699987186663; 
 Tue, 14 Nov 2023 10:39:46 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 e14-20020a05620a12ce00b007740c0e52edsm2851812qkl.89.2023.11.14.10.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 10:39:46 -0800 (PST)
Message-ID: <8e77b041-a09a-4534-85c0-37d018f137f9@redhat.com>
Date: Tue, 14 Nov 2023 19:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/replay_kernel: Mark the test_x86_64_pc as
 flaky
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231114153019.295131-1-thuth@redhat.com>
 <2ab35329-f45f-437e-9d2a-99ad0fbbccda@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2ab35329-f45f-437e-9d2a-99ad0fbbccda@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 14/11/2023 17.36, Philippe Mathieu-Daudé wrote:
> On 14/11/23 16:30, Thomas Huth wrote:
>> It's failing very often, so don't run this by default anymore
>> until it gets fixed.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/replay_kernel.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
>> index a18610542e..53cb7e5091 100644
>> --- a/tests/avocado/replay_kernel.py
>> +++ b/tests/avocado/replay_kernel.py
>> @@ -81,7 +81,8 @@ def run_rr(self, kernel_path, kernel_command_line, 
>> console_pattern,
>>           logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
>>   class ReplayKernelNormal(ReplayKernelBase):
>> -    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>> +
>> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets 
>> stuck')
>>       def test_x86_64_pc(self):
>>           """
>>           :avocado: tags=arch:x86_64
> 
> Hmm I suspect https://gitlab.com/qemu-project/qemu/-/issues/1961 which
> has a fix ready:
> https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richard.henderson@linaro.org/

I just gave it a try, too, and it does not fix the issue for me.

Is this test still working for anybody?

  Thomas


