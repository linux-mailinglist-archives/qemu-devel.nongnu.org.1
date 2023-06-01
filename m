Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D4719FD9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:25:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jEy-0001MG-9v; Thu, 01 Jun 2023 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4jEs-0001M1-PL
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:25:18 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4jEq-0007Uy-SS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:25:18 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-517bdc9e81dso341699a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685629515; x=1688221515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XK4zC6zDptNSceVeMxIXLIIIsSOHcXYFcLfpAzKsYrE=;
 b=jAxdgjrBnPKaLTF+6A7Q9lFglRC3ueoC9eLfHADy0wvfVF9USBnWhuQYM76MWiGHQp
 7P05piPZdXdOh1s34iQEDRgF3vHMDZbupJbH829lWkG+mlGUsh56Z5gh9OxXuWvkgMlG
 YEjdJ9QcXQFEnKh8rE+Qe1+284mGoxWvqFbE2UWe1elrNkxHGeFWL8/1lrTUbwPPT6Ki
 oCCLo3tO3iMXBQOB1gaPwoVVpLPqXWJphbKVp/6RK4WDxFnHKjIVkWIOjAgcpjC1N/UL
 nTKygNObwaZrvUXXPQBWaoJ0KL8uNbtyIH77/8Z+sBePhLCpJ31B+41wZayuicGzJRIZ
 YTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685629515; x=1688221515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XK4zC6zDptNSceVeMxIXLIIIsSOHcXYFcLfpAzKsYrE=;
 b=SgD3TM7seWaQDNIWFAcKIAu17WPqfOKw20QPDfEA5VElhcuR9ib1I1TCOMNe2If3zH
 vbGZvuMi2d/VfoPDGRcfiLGq5KbELrVY5vLQzf/ChV34cDNYcBv2Co+aiPFP+ChAk//8
 HLpC0QvkmsqTH/Fy8OOHbUg3YjL5Ge05MWVWpviAQLQxlIqAB3w5rQ/jejBRrFUcX8Xu
 UDhJEVrXZ2oTM7TdvpacFGX0E9SLBiZ6YF9YARPDOZLQvL5/y4R7t/hYF0gCcXJ5LMJL
 2Ai7mBaJ3x2LB5fcORAw5y9eLuqJOK/NZL/dlxGVxf57Ri1wfSprs6FSckk2kUlLvel0
 70KQ==
X-Gm-Message-State: AC+VfDy6CWyTjspJFTm3VSZNoHuNtVA0wUzAsoCLGTexWdaV0ov3Dv5Z
 6IgwzEotf/NLUai4LGRaKYaErgejJBEHQk9elWI=
X-Google-Smtp-Source: ACHHUZ5i5fDc7I8trpwlVzbiXp8TXxM0/0z5oFkJ3LwITY3ZEFl1DZp7OEq2NofTnoOsPZS7Jb77Ow==
X-Received: by 2002:a05:6a20:1447:b0:10b:e39a:b50e with SMTP id
 a7-20020a056a20144700b0010be39ab50emr8105023pzi.36.1685629514897; 
 Thu, 01 Jun 2023 07:25:14 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 m15-20020aa7900f000000b0064d59e194b3sm5116227pfo.113.2023.06.01.07.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 07:25:14 -0700 (PDT)
Message-ID: <a35314aa-d9ea-0a8f-5dd5-65418b9287ba@linaro.org>
Date: Thu, 1 Jun 2023 07:25:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 06/10] monitor: adding tb_stats hmp command
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-7-fei2.wu@intel.com>
 <f37aae7f-7b90-af71-a188-bac4e7bf851f@linaro.org>
 <ec13fd0a-ef33-44fe-0171-7ce20fcb6a85@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ec13fd0a-ef33-44fe-0171-7ce20fcb6a85@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 6/1/23 00:20, Wu, Fei wrote:
> On 6/1/2023 9:23 AM, Richard Henderson wrote:
>> On 5/30/23 01:35, Fei Wu wrote:
>>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>>
>>> Adding tb_stats [start|pause|stop|filter] command to hmp.
>>> This allows controlling the collection of statistics.
>>> It is also possible to set the level of collection:
>>> all, jit, or exec.
>>>
>>> tb_stats filter allow to only collect statistics for the TB
>>> in the last_search list.
>>>
>>> The goal of this command is to allow the dynamic exploration
>>> of the TCG behavior and quality. Therefore, for now, a
>>> corresponding QMP command is not worthwhile.
>>>
>>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>>> Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
>>> Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
>>> [AJB: fix authorship]
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>> ---
>>
>>
>> I still don't see what pause does.
>>
> maybe it's necessary to discuss the user scenario, I suppose the
> original design is for this case:
> * start
> * pause - there are some interesting stats we want to keep
> * not interested timeline
> * start again - continue to investigate the interesting ones

This use case seems very complicated.  Perhaps start with something simpler.

>>>    enum TBStatsStatus {
>>>        TB_STATS_DISABLED = 0,
>>>        TB_STATS_RUNNING,
>>> -    TB_STATS_PAUSED,
>>> -    TB_STATS_STOPPED
>>> +    TB_STATS_PAUSED
>>>    };
>>
>> Why?
>>
> STOPPED is the same as DISABLED.

Then this should be squashed back to patch 2, so that it is never added.

>> Why isn't all of this in monitor.c?
>> It's not used or usable from user-only mode.
>>
> closer to tb-stats, or closer to monitor? It seems to me monitor.c only
> contains the shim layer of qmp/hmp, the real stuffs which are large
> enough are put together with their logic part, e.g. dump_exec_info().

I mean accel/tcg/monitor.c, which is built only when there exists a monitor.


r~

