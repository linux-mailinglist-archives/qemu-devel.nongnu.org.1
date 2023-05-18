Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB70708305
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:43:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdgX-0003hb-GT; Thu, 18 May 2023 09:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdgU-0003gd-Tk
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:28:46 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdgT-0005lS-4J
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:28:46 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53033a0b473so1381669a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684416523; x=1687008523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5lmpBZAGQlDf4nQ86UZCzROFddntyxS3XJd9lIeEdGg=;
 b=uRj2hCsAOXa5bSbi9c/zwzww/PcRTz07fShUdD0UZe5DWryK7Y8Z+4VTE0+IRAo7E5
 4XrEkuA0aDLyPbpIDvq0OH+IchTnUZWWzeVpWdKOcy0HjDv69Y/aGpLtgXf+EgW1jE9c
 5FkohclZKMthGz8GHlCrU0ttYPxemQ/kT+oerO4NbtlylxuVkMfMGcq1Mdi9e884R67N
 s7TVVkA8VyqNAiY0CNjxPGWQoXd/StfNdeAfPg+TDtCGxTjB0swUCTvXcdO0rYUMXOEH
 BeZevaTxLWbdiHchX75+PUmlsRaorNv64IXDEr8iUDXhJ/RUigWA5QSWDPk1QvBZ9VX4
 ok2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684416523; x=1687008523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5lmpBZAGQlDf4nQ86UZCzROFddntyxS3XJd9lIeEdGg=;
 b=W0GqUP0DTuCNXNtEkQ8faxsfuJJpKZvlHP6XRYgsk0gIRLRvb6mvsOb59Be1opO1TL
 sB7PwyKAXDlG1QxP9cdmGmbK07zwZS4jrkqRn/TGd7rnCntE7vUX2ipgTHMn24BIDFqQ
 sWe4UXddLW8xSe2d315zB2ifEXnaTcvHkM6HKywzmQehMvGDFH/lfEl3yu16GD/bZG5f
 Vg7btalsQYwvFBCmkmboctTO/lihau8ot4N4EsNs7llhHnS1M/wbUzfVS3QN80pSHUAJ
 4Pi7w8fN43hMLRT81oz50UfPOclmsPlhBFd52vlrzImRW9+FHEpra8vRWrDLzPVOYe4U
 V8Zg==
X-Gm-Message-State: AC+VfDx37gCXYQoe8RA8MMgla2mE28ePeyed4w63HNXfLPOfYv3V47wZ
 1P2rjc2Gt5ndXrFR+g8rOqfBLg==
X-Google-Smtp-Source: ACHHUZ4rEYs0A6nwDXYxxZj68Onm9XXkz/InHk6evSUV/RcjxG5HBLiMhKClKruU4rp5e0mW2bloRg==
X-Received: by 2002:a17:903:2448:b0:1ac:63b6:f1ca with SMTP id
 l8-20020a170903244800b001ac63b6f1camr3573396pls.0.1684416523566; 
 Thu, 18 May 2023 06:28:43 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170902b7ca00b001a9581d3ef5sm1427702plz.97.2023.05.18.06.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 06:28:43 -0700 (PDT)
Message-ID: <17066f6f-066e-7d18-12a4-a17fdccd728d@linaro.org>
Date: Thu, 18 May 2023 06:28:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: tcg-plugins avocado test_aarch64_virt_mem_icount timing out on
 current git?
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAFEAcA_xTp2coWu3b_myODqbF7fs0WBOfVikk+EhXZOqxXsj0g@mail.gmail.com>
 <CAFEAcA_x6hZQ2nXDOEUcixgr62c2A2KQWijJzgGbgk294Q1_xQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_x6hZQ2nXDOEUcixgr62c2A2KQWijJzgGbgk294Q1_xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 06:23, Peter Maydell wrote:
> On Thu, 18 May 2023 at 13:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> This is on current head-of-git:
>>
>> $ (cd build/arm-clang/ && ./tests/venv/bin/avocado run
>> ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount)
>> JOB ID     : b1d82ead55dbac8c1f17d0217a7572c4378e21e3
>> JOB LOG    : /home/petmay01/avocado/job-results/job-2023-05-18T13.02-b1d82ea/job.log
>>   (1/1) ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount:
>> STARTED
>>   (1/1) ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount:
>> INTERRUPTED: timeout (120.01 s)
>> RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1
>> | CANCEL 0
>> JOB TIME   : 121.46 s
>>
>> The job.log contains no useful information (see complaints
>> passim). What's going on here ?
>>
>> (The other plugin tests pass OK, it's just this one that times out.)
> 
> Bisect blames commit fcdab382c8b92bcc
> ("accel/tcg: Widen plugin_gen_empty_mem_callback to i64") --
> see other thread.

Grr, ok, thanks.

r~


