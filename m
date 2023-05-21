Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0C70AE6E
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:10:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0keo-00051n-9e; Sun, 21 May 2023 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0kel-00051P-5G
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:07:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0kco-0006eS-Cq
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:07:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d2ca9ef0cso2051524b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684681526; x=1687273526;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kauN85zUEcijoU9C0IuXVfoqSTj2H4oWskwS+fpAtkM=;
 b=ZQejgiE8mXpC2HhLyCm98/4nU8g8mBH5RALgFG7yJGu7M0QiZdkLNFliiy4KMAHpKE
 Jw3U5YCZpXkcFgXT7RDt4GHBE9P7H1vbIDKgWhfNiNvOEfK0Y/v6uEPNXtGtnVT1ubxZ
 wjOC06l6s/SnZItrjzqeTi4g8itXmSKh0/PQi/Dj4mIY6P/wXbe/Irkrl2mSnn1+0z79
 RmQsXBusuFhG96xqSexg0/hy5uTglxbXNP85Qhzfo840aJXRZzLWlTSW4xJU3KjvnUIf
 bpawry0YCEeT76id7FkazD/TAx8oSrAiwOxgoTYm5M+cX8BtkTlTZ8JnCFVO2dCwgTtE
 WA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684681526; x=1687273526;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kauN85zUEcijoU9C0IuXVfoqSTj2H4oWskwS+fpAtkM=;
 b=kQWHEuJ+xLAkCRfPgsyVeKC1e+IgLO3kMf8XXTFUZI4L9COb6qiZCBgGzHDafiDrIW
 05oOGzD53kgJ5SARXDpfAQQgCc7j+vY/ZBRbNug0AhteWiIS6cvPHDUikzWirujpbq1S
 6EtsuYZJH0NU7EmIdIPMEVn6L6hgJQgOkKjWGg95E6TYWMZ7edkXVEx0LWEUg9+uR6cO
 anTHtDzpVQ3CkxE2IsuOJGLauk7Q6t+PAiPZddEzvYP9XUK/1pwGbxAj+yhSA8/9hyhm
 bXmQKzeLSxilEsrpArxhC4tZgPNIx3M6a4BIOPl3JtO+q0yByxQOKZ07eSB2IZsNiC6E
 JQSQ==
X-Gm-Message-State: AC+VfDzQZE1U2nTn81aOAoJ55yythftRg4Z2ytYBMfDB8aAuaUFHV7tL
 46Uf/qR8gjIUe0ADO7iEj5Z2Ng==
X-Google-Smtp-Source: ACHHUZ7vTLZY9Ycis8TXJAvZl5TrahzQR4fVJQdZLaUuHQX3Ziy2+2/zlwaJR06y4vjcAWvFHtrLuw==
X-Received: by 2002:aa7:88d6:0:b0:62d:cfd4:e440 with SMTP id
 k22-20020aa788d6000000b0062dcfd4e440mr11416956pff.8.1684681526242; 
 Sun, 21 May 2023 08:05:26 -0700 (PDT)
Received: from [10.40.30.162] ([66.172.120.86])
 by smtp.gmail.com with ESMTPSA id
 k25-20020aa792d9000000b00649ac17779csm2617583pfa.160.2023.05.21.08.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 08:05:25 -0700 (PDT)
Message-ID: <dddfb5fc-31b6-9561-5d71-1e83534dc269@linaro.org>
Date: Sun, 21 May 2023 08:05:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/27] util: Add cpuinfo-i386.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-3-richard.henderson@linaro.org>
 <b51a6df0-b53b-c6dc-b496-0c320aad463d@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b51a6df0-b53b-c6dc-b496-0c320aad463d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/21/23 04:28, Philippe Mathieu-Daudé wrote:
> On 20/5/23 18:26, Richard Henderson wrote:
>> Add cpuinfo.h for i386 and x86_64, and the initialization
>> for that in util/.  Populate that with a slightly altered
>> copy of the tcg host probing code.  Other uses of cpuid.h
>> will be adjusted one patch at a time.
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   host/include/i386/host/cpuinfo.h   | 38 ++++++++++++
>>   host/include/x86_64/host/cpuinfo.h |  1 +
>>   util/cpuinfo-i386.c                | 97 ++++++++++++++++++++++++++++++
>>   util/meson.build                   |  4 ++
>>   4 files changed, 140 insertions(+)
>>   create mode 100644 host/include/i386/host/cpuinfo.h
>>   create mode 100644 host/include/x86_64/host/cpuinfo.h
>>   create mode 100644 util/cpuinfo-i386.c
> 
> Missing F: entry in MAINTAINERS file. We probably need new sections.

What would you put there?


r~

