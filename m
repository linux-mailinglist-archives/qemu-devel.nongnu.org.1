Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1010C719097
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 04:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YEl-00053g-0e; Wed, 31 May 2023 22:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4YEi-0004vd-S8
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:40:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4YEg-0004NC-6v
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:40:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b075e13a5eso2880925ad.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 19:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685587214; x=1688179214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itDNqqim0gz7ylOBEBOoILHcq8T0JBsppFgzSe0askM=;
 b=yBk11ffrUzL/TJmN5btvNu1UpZgm/Ms/J13xGHwDbGM+I4B9u9qY27JEcc/50I+RlV
 dxfpk9Yk9+RdtzykqHwVYAByEQJsFRsGUftC1Bz0SrF+lr9JhkptFKb0wq0Wr+aJUc8m
 iS0GxyvB9wBIYDc74EIN1U5IEm52EwQgtMwDGBSQ3YQFz1IeopLo9Kqo+M0F0xU5sL4t
 MbKKlLHTbcdHxg8Oo26dYN8a4n4woURWoRveGv3uZUkEHcS1/PuKtSl6/7Ah8w6oI1ik
 3KTAbQvFbh/HhYQADdW4YrVAUztMGJk13e2a9YBhvIJRJcm4xjQVcBaNIMNaeBRAmTOW
 ywwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685587214; x=1688179214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=itDNqqim0gz7ylOBEBOoILHcq8T0JBsppFgzSe0askM=;
 b=iF24FXbqD88OfSgprquXqTQDJ0bENEG8Uh1hp46r09dxXCel6BSCtWCHZqmm5TOj4J
 +xNzNQQIDhNA5QzYi/VaO0OlTEG0eZWpmL9mcDsYg6X3h+3XIkcPQIeyngeX2Ip0osxF
 74RhcGqDsxb6VRss2sz3fLX2WsGwOw4Tn83HNG1OWqGgoQjd1RnN0IBV56QSZ4z/7Ldi
 9ZN1RPF0bNroMIWOB04ecfXkTeLZncE+GM/xEgTEH1oZVtgBax7H70vmQqyknkK/xYID
 oc5sUOXYP1H8Oli1n6i9DJBPYbBnUlmUQm4rrgR160qQOWdtBa3SCv/GU4rzN6kMfu1n
 MrvA==
X-Gm-Message-State: AC+VfDxOSq44v3G0PVj21LNdesinXbymVxdvkBEf1gMpmHeRk0rWD2ro
 uwvIzgUGzM42PWkMauOpre9sOA==
X-Google-Smtp-Source: ACHHUZ76KIfT/xBxBTEC13iS31HyP3Ck83qmUIYnzIUcmu7tZmx9K6ZuldAWU3LxZdrc4s3v0AU9wg==
X-Received: by 2002:a17:903:2284:b0:1b0:45e2:ef38 with SMTP id
 b4-20020a170903228400b001b045e2ef38mr8442945plh.26.1685587213847; 
 Wed, 31 May 2023 19:40:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a170902714700b001a260b5319bsm2145007plm.91.2023.05.31.19.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 19:40:13 -0700 (PDT)
Message-ID: <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
Date: Wed, 31 May 2023 19:40:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-9-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/30/23 01:35, Fei Wu wrote:
> +static void do_dump_tbs_info(int total, int sort_by)
> +{
> +    id = 1;
> +    GList *i;
> +    int count = total;
> +
> +    g_list_free(last_search);
> +    last_search = NULL;
> +
> +    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
> +
> +    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs,
> +                                        &sort_by);
> +

Why are you sorting on a list and not an array?
Intuitively, sorting a list of 1 million elements seems like the wrong choice.

Why did you put all the comparisons in one inverse_sort_tbs function, and require 
examining sort_by?  Better would be N sorting functions where sort_by is evaluated once 
before starting the sort.


> +++ b/disas/disas.c
> @@ -8,6 +8,8 @@
>  #include "hw/core/cpu.h"
>  #include "exec/memory.h"
>  
> +#include "qemu/log-for-trace.h"
> +
>  /* Filled in by elfload.c.  Simplistic, but will do for now. */
>  struct syminfo *syminfos = NULL;
>  
> @@ -199,6 +201,24 @@ static void initialize_debug_host(CPUDebug *s)
>  #endif
>  }
>  
> +static int
> +__attribute__((format(printf, 2, 3)))
> +fprintf_log(FILE *a, const char *b, ...)
> +{
> +    va_list ap;
> +    va_start(ap, b);
> +
> +    if (!to_string) {
> +        vfprintf(a, b, ap);
> +    } else {
> +        qemu_vlog(b, ap);
> +    }
> +
> +    va_end(ap);
> +
> +    return 1;
> +}
> +

Not need on this either.  Global variable being checked on each callback, instead of 
selecting the proper callback earlier -- preferably without the global variable.

Did you really need something different than monitor_disas?  You almost certainly want to 
read physical memory and not virtual anyway.

> +void qemu_log_to_monitor(bool enable)
> +{
> +    to_monitor = enable;
> +}
> +
> +void qemu_log_to_string(bool enable, GString *s)
> +{
> +    to_string = enable;
> +    string = s;
> +}

What are these for, and why do you need them?
Why would to_string ever be anything other than (string != NULL)?
Why are you using such very generic names for global variables?


r~

