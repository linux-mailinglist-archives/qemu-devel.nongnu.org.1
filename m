Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF085759A32
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9RA-00062Z-Dp; Wed, 19 Jul 2023 11:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM9R6-00060y-1W
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:49:56 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM9R4-00052V-9I
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:49:55 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so12050864e87.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689781791; x=1692373791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rbSy/Y6I+Ie/c77Q5eaPdvBeuXMXwmqKIZjg579cOY4=;
 b=CKQUbGlz0W38gOs3v+1nNOgd2i9OwTNRwUWNA5w4t6IF+uFvd6/ZANkgTazY0yMmLf
 BhgK6BGQNI/0P+7GHRai5MH+mfyrzbR+vR+K1uJcisP5NIyql38k6qzInr5qb3+OEI/R
 rKqbPTjoyBk7AgEiuZuw6rLAPzcnIa7Uz+/GvHdeNVHu5OdQtlPf59FEdrAN28cc3ugY
 nJ9mxua7KmoHmmNeoZuYTzqPoRJUvrKnkxWP2gXnK9loiXgye2/Q1AZrKTNDL/LHA1Ki
 2fYM5bMHt4/52Xhn9EDquWapzu9+QWVztyZkKnSl+rnbnakfHLZCH/e8Q8NOPd7f6pVG
 FJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689781791; x=1692373791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rbSy/Y6I+Ie/c77Q5eaPdvBeuXMXwmqKIZjg579cOY4=;
 b=loekNDU1m82StwoN4pEyj8DFWMRkjkSdDyS3IqLdDDPJNnmNl6pHIcfdO8BbLX9fQi
 H2mRVeW/Xl3bYn4t4bibnuhctgQ2cSVYO4FjgeeRqYLlrSqAz4DN5fZnnlrfTOdmhgMy
 Xxi77Ok0XI0rPZJXmmJUCN/kPAxIRd3qLdpQVMFw2pRzFUaxzwnnniO1Gxze5dz+ju3C
 fpAbl9K4x4SFqJcHwQY3e9Qw6oLeDjsBrnglwpijVICizqWYUlbISF3khV0fSX+YKLfw
 jtUtfXakFTSdcbrnwEJyr2upzL8qr6TJ8ttUS5HDFtghjrZ4LtcN/6K1R72FkYz4b4NK
 dGHA==
X-Gm-Message-State: ABy/qLbwVPU9+Bw7NWTAaD9/O3M5KgEfak7Mz7/zll4opieXNs8xa5Jo
 9jH0xUvOKacPQFmUzqQ8Gse09Q==
X-Google-Smtp-Source: APBJJlGEWcYUTzqkk66Q8tlLK6B1cg2uGt4h//N+Fpz+y6pGdiSzHMywvdTJavIMFoexERBMrnu+3A==
X-Received: by 2002:a19:4f4b:0:b0:4f7:55e4:4665 with SMTP id
 a11-20020a194f4b000000b004f755e44665mr167682lfk.56.1689781791406; 
 Wed, 19 Jul 2023 08:49:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a05600012c300b00313fd294d6csm5731823wrx.7.2023.07.19.08.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 08:49:51 -0700 (PDT)
Message-ID: <d9fc5a39-a8ec-eac2-e6b5-74a45dd38d25@linaro.org>
Date: Wed, 19 Jul 2023 17:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] tests/test-util-filemonitor: Avoid pointless
 allocations
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20230719150103.36634-1-philmd@linaro.org>
 <ZLgDwWSIhK/7N9SP@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZLgDwWSIhK/7N9SP@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 19/7/23 17:39, Daniel P. Berrangé wrote:
> On Wed, Jul 19, 2023 at 05:01:03PM +0200, Philippe Mathieu-Daudé wrote:
>> Coverity reports few resource leaks. While they are
>> harmless, fix them to avoid them showing on the reports.
>>
>> Reported-by: Coverity (CID 1432615: RESOURCE_LEAK)
>> Fixes: 4f370b1098 ("test-util-filemonitor: Skip test on non-x86 Travis containers")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/unit/test-util-filemonitor.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
>> index b629e10857..3ca687860d 100644
>> --- a/tests/unit/test-util-filemonitor.c
>> +++ b/tests/unit/test-util-filemonitor.c
>> @@ -398,7 +398,7 @@ test_file_monitor_events(void)


>>       /*
>>        * This test does not work on Travis LXD containers since some
>>        * syscalls are blocked in that environment.
> 
> Right here is logic that checks the TRAVIS_ARCH env variable.
> 
> IMHO this should just be moved out into the main() method, so
> we don't even start test when under Travis. Just make the whole
> program exits with a skip status on travis.

Clever eh :)


