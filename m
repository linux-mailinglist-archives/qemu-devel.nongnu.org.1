Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCED7BFBC5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCAl-00079k-KD; Tue, 10 Oct 2023 08:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqCAj-000790-M6
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:49:13 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqCAi-0003H6-51
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:49:13 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so10027858a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696942150; x=1697546950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ezU20T5B9mNN5+lQdzJsN6+cM3/xCrZDAecqucvFHZg=;
 b=Rq6ptiOY8hRGPmbmo2HbpAfrMiQi+3c/U/ueUwjbIQlwmXT9TThQK2Jq7iy5h570FY
 bSwTWfDSBOXzNjaxJc7PYiIFReVfXe8f3aq+XlxiSBh+m6qRWc7PRSE+QnYePHJtwLkc
 ZI9K1ij5wobbBTMVB2nwSwFmnyROjduuC272Bdhfeb/YZKVJ32EWAPxF5I51Ns1aI+da
 gJb4WRpTssUwyKU6DWI6YrjUN+4izhgZlMBEhH9wyz2LppX0xPcZ2t2u5E4cNCeS4qpc
 +U7Brr2x+pfax76Xesk0fKQNodBZE5DgndsvY9rntXl/2DFIZx5e3KsDYKYkx7snIsS2
 EaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942150; x=1697546950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ezU20T5B9mNN5+lQdzJsN6+cM3/xCrZDAecqucvFHZg=;
 b=maIKgQYrMwBJWogOz0irqjiDYkKK0QUO8sVokdQWKROEavAvc9dlXDESPV2nOjO6F/
 ku7UPVn4LlgIrFvfIW5moZXD/gdMu+/l1QfgLycE+JUvMu/goO2Dj1pUVzESNW9Q76q4
 0ibEE0CO6X75IjpG8zUB+tNkIekqv2c0wix/CMAVmfn6qoaFdVQankYNG44MVADJYyuZ
 tRyGJC3JdhG076iqPX+6esTZECS2GB59hzBTfE91nNMcETQFLmvtmRLrl39nlSmoOtkL
 X3vTquevJPeluacmF3cP3oRgOvHkgJq2zfS3KCyfq0vkqJ8wixM/IkRb4qz9955EcEUh
 0Icw==
X-Gm-Message-State: AOJu0Yw/YH8lYk2g5+7wqE4mzVXpCM0Mf3w+cBz3xQ7SWys0LSp0Uz8l
 6W4NrR74tfOSAQNwgB9VseC7Kg==
X-Google-Smtp-Source: AGHT+IFIpgjFPoWvE4qF39z4+yKruBKnNmQlgYdg7y1VpCR+asbTTCR9HZPtCPs7a1afTtHmC3zrCA==
X-Received: by 2002:a17:906:209d:b0:9ba:246c:1fb6 with SMTP id
 29-20020a170906209d00b009ba246c1fb6mr4737843ejq.76.1696942150564; 
 Tue, 10 Oct 2023 05:49:10 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a17090619d000b00997e99a662bsm8337752ejd.20.2023.10.10.05.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:49:10 -0700 (PDT)
Message-ID: <d854691d-e133-c8cd-a785-959720114100@linaro.org>
Date: Tue, 10 Oct 2023 14:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 07/11] tests/avocado: Add ppc boot tests for non-free
 AIX images
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-8-npiggin@gmail.com> <87h6mypryo.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87h6mypryo.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 10/10/23 14:43, Alex Bennée wrote:
> 
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
>> An AIX image can be provided by setting AIX_IMAGE environment
>> variable when running avocado.
>>
>> It's questionable whether we should carry these in upstream QEMU.
>> It's convenient to see how to run these things, but simple enough
>> to maintain in out of tree branch. I just wanted to see opinions
>> about it.
> 
> Yeah there is no point adding a test no one else can run. We already
> have tests that utilise dead URLs that can only run if you happen to
> have the image in the avocado cache which should arguably be removed.

This isn't quite the same problem. This test image can possibly be
shared among developers within the IBM realm.

>> ---
>>   tests/avocado/ppc_aix.py | 63 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 tests/avocado/ppc_aix.py


