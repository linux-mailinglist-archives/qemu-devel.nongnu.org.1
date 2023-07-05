Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D07480C6
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 11:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGyl9-0002kU-3R; Wed, 05 Jul 2023 05:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGyl6-0002kL-8K
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:25:13 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGyl4-0005hD-Dh
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:25:11 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so984737a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688549109; x=1691141109;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wusUozCItvEAXLR2hx6N0ZGGwDr0pjxBu8s8S1hOF7M=;
 b=z2yBZ0ZrzTAh9mPpDWpKZblzyvjuh49LtzXpj+4oaql52ctIycrZcMVdCo1wQ923qS
 bQAjSLl5X1DKHJQ+tVQhkCQsF/2GQyH3s4G9gWVALpRtrnzJBn1sjKBGEVZV8wWp3Sa+
 ka/4v0Neov85wf4bLy5WNHpkENkA4cD1GXDsEIJXUy23BCG0H8X81L2//zkRMBrdInDe
 o1dtJzoXDJKX6ej//KCS/0/BU5gSz4xJOVXoFhzxHSNw5Fpx7HAbvzNSg7judbZ5LVVs
 25zs0lHf3l1fn+6JyywC/TXCBAbMDaY8eyrT0n219Yo04+r5RAxsAwdKpP2JQT9VftWe
 IktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688549109; x=1691141109;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wusUozCItvEAXLR2hx6N0ZGGwDr0pjxBu8s8S1hOF7M=;
 b=ItiaiyJpNHkR2GwfL4F2VRyk4rDZKy0mm4nUspxXgM//wHJWnjCRdk82fSUUSUpvYN
 TklK3213OMbsa/YMxZiCss0/3IA9s++spUc4QAeZSiyrV6DOIgBVVpbrVC3aM+sEt5rQ
 yP3YRI4zSuqhYUHU6R8/lJVbdxuy87EcrvtnDG4V4nhhIHe506SgPLTPHNhNm8MGID/i
 rQ8uPIoKS5Io07KFl2THTs9qsunR93GQtg7b2ssSwTXyC4y/RFVDiKM+yLRfv+t8MbgO
 IZ5uk6z8vVTh+RtYbEOQ0us9Fjfppq2dSvD1JNtpq1QnjCceQaYcwDkVmOx5WE07VjFF
 WBbQ==
X-Gm-Message-State: ABy/qLb3DlEnE2BsfsXhEEgVtN6gdNuNuWe/MKIers0jzigxM6pjIJdQ
 ssxmKkW5nrtaxPDNc5L29hyjVw==
X-Google-Smtp-Source: APBJJlG55JhmfCaMaDJkqpQ5K0ji1VSJDy3IftmX14GEcoMgZMIEDJcDwFIA1fKPPIAsaIVebOyDwQ==
X-Received: by 2002:a05:6402:3550:b0:51d:d08b:ee06 with SMTP id
 f16-20020a056402355000b0051dd08bee06mr1524615edd.8.1688549108888; 
 Wed, 05 Jul 2023 02:25:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 er17-20020a056402449100b0051de20c59d7sm7548903edb.15.2023.07.05.02.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 02:25:08 -0700 (PDT)
Message-ID: <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
Date: Wed, 5 Jul 2023 11:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?John_H=c3=b6gberg?= <john.hogberg@ericsson.com>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <20230704163634.3188465-8-peter.maydell@linaro.org>
 <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Cc'ing John.

On 5/7/23 06:53, Richard Henderson wrote:
> On 7/4/23 18:36, Peter Maydell wrote:
>> +int main(int argc, char **argv)
>> +{
>> +    const char *shm_name = "qemu-test-tcg-aarch64-icivau";
>> +    int fd;
>> +
>> +    fd = shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
> 
> Build failures:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4592433393#L3958
> https://gitlab.com/qemu-project/qemu/-/jobs/4592433395#L4149
> https://gitlab.com/qemu-project/qemu/-/jobs/4592433400#L3694
> 
> 
> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/lib/../lib/librt.a(shm_open.o): in function `shm_open':
> (.text+0x3c): undefined reference to `__shm_directory'
> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: (.text+0xcc): undefined reference to `pthread_setcancelstate'
> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: (.text+0xfc): undefined reference to `pthread_setcancelstate'
> /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/lib/../lib/librt.a(shm_unlink.o): in function `shm_unlink':
> (.text+0x30): undefined reference to `__shm_directory'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:119: icivau] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:50: 
> build-tcg-tests-aarch64-linux-user] Error 2
> 
> It looks like this test needs something else.

Maybe:

icivau: LDFLAGS+=-lrt -pthread

?

