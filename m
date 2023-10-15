Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C67937C9B23
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 21:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs7BK-0003eP-QE; Sun, 15 Oct 2023 15:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs7BI-0003dw-C4
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 15:53:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs7BG-0005FQ-FK
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 15:53:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso1423765b3a.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697399621; x=1698004421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/xgLIcyglzxXESxRQIFhoSa18qcpBeIkPUWxm83WkUM=;
 b=YZ937dUe6F+ljMjgkBTTHIcohK48CfP9hw6EZ4wejl62eFwV9OO8yRfhzjJPaBK5gx
 XJSoPBcUDuW8wxV08wtZeU+tV4xIm6/G+cqvzB2L7zrJCc1XhV+41hCQk/4oiijgD2wP
 MgCAu62v06FlROP3/wr3F1FZwTix0ooFTJpSGYhnSg1GMRBoMSgG1oftzkE/c2SB1lmG
 Cu5TAvyMwv8Az+SSgsVjtJSvzGP1jPp7K8Icld329Iv62aMiRTvQFKcyTmD7VsbSOznR
 MPtwkXm28ueHTSvk38hoM76Fm7tppcDo1gbTmtJcWcsTuvls19lxMrpectQEzt2KuCLt
 coMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697399621; x=1698004421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/xgLIcyglzxXESxRQIFhoSa18qcpBeIkPUWxm83WkUM=;
 b=ZbyBFl9E/t+n2IFTGCf+B8Vv1/+SRrKyEtXJl5hDqIP41fMoT9SCXq4sg9CHZ0nbww
 NH9YH4oc2s67lrAaV2hkka3BFZPxn7keQtgbP0WmNWHXHMTN6vnVzpw0RqZ5M+vb1NT3
 z61mT6edeyoCEuQw3fC4mSw0ajTGGn0DLA9Qpk84AR6YRPhhgqNJDacc9zOmpOk8OcCZ
 aDgCGcguhwQkxTU2nH6N2SIk0RWx25ISt9d7xTEx6ogxwoMi2ThV6fERmapNb6GW9lDS
 tvYGCVklBlV8rom73t6AmFeawEpUBDnWrhMSnQ//AA9uK13k2aBa7RhQder56XxRuy3e
 0aKw==
X-Gm-Message-State: AOJu0YyogJgS8Vcgng1llkdDHd9H1cKhfexQ7z93aSmJVQ+7ZYU/tjrf
 LyEFxICW/GawLRqem2AN/odIeg==
X-Google-Smtp-Source: AGHT+IEvv8BiWYGwNA17PfnE7MaYe9QlvRw+UreT2nVWS67pa2aJrtYUqaKyDuCTV4kGb4wYwLmLAA==
X-Received: by 2002:a05:6a00:1807:b0:6b3:6bc6:68d1 with SMTP id
 y7-20020a056a00180700b006b36bc668d1mr5859035pfa.11.1697399620791; 
 Sun, 15 Oct 2023 12:53:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b14-20020aa78ece000000b0069337938be8sm238944pfr.110.2023.10.15.12.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 12:53:40 -0700 (PDT)
Message-ID: <b490cd14-2174-44d3-846f-e5e40e468920@linaro.org>
Date: Sun, 15 Oct 2023 12:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/16] util/log: Add -d tb_stats
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-11-richard.henderson@linaro.org>
 <9fcdaa43-7cf4-2b0c-3a29-a71767453702@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9fcdaa43-7cf4-2b0c-3a29-a71767453702@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/23 05:34, Philippe Mathieu-Daudé wrote:
> On 3/10/23 20:30, Richard Henderson wrote:
>> From: Fei Wu <fei2.wu@intel.com>
>>
>> Enable TBStatistics collection from startup.
>>
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> [rth: Change "tb_stats_foo" to "tb_stats:foo"]
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   stubs/tb-stats.c  | 16 ++++++++++++++++
>>   util/log.c        | 36 +++++++++++++++++++++++++++++++-----
>>   stubs/meson.build |  1 +
>>   3 files changed, 48 insertions(+), 5 deletions(-)
>>   create mode 100644 stubs/tb-stats.c
>>
>> diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
>> new file mode 100644
>> index 0000000000..ceaa1622ce
>> --- /dev/null
>> +++ b/stubs/tb-stats.c
>> @@ -0,0 +1,16 @@
>> +/*
>> + * TB Stats Stubs
>> + *
>> + * Copyright (c) 2019
>> + * Written by Alex Bennée <alex.bennee@linaro.org>
>> + *
>> + * This code is licensed under the GNU GPL v2, or later.
>> + */
>> +
>> +
>> +#include "qemu/osdep.h"
>> +#include "tcg/tb-stats.h"
>> +
>> +void tb_stats_init(uint32_t flags)
>> +{
>> +}
> 
> We don't need this stub anymore.

Certainly we do, within the tools and tests.


r~

