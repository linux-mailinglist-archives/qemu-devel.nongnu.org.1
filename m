Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8773792195
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSX1-0002qv-Bb; Tue, 05 Sep 2023 05:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdSX0-0002qm-6Q
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:39:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdSWx-0000w6-TO
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:39:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so22582055e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693906770; x=1694511570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2aQnsloqfkEt0Tpy/wv4DHI5jNQaAU39mBOeVaw6Vg=;
 b=Bu3AtWK/WN2wRyHnRutMhYVrElaLton+4L7p5T1AmOvQD2B5Fne8BGgp86pOl3k3b0
 qfIl9BEfli/pX0CmJfba/jXoU4ILgHyU2ypID4TcDUj+ax9wJk/HQ/u+RMq/eqUonpYF
 SSWIoxlk49kktNyr9tVzup1jd/vMmzYjOOA7VvzvbIVZ8lYDJJOe4dXCJ3G0EDgjxNWE
 YLyjmtCQo3VWDYqVtpWG0jigFWauMo3ykc5+WQb37AAmm2lkvXR1iZ6jW5ulgRSfSt4m
 jcK5BxyTBaaTyrpcXCYierdy2NoBi9mgO0KVycMYwsFaLc9XqkZFMiytO9AsxoTypoV2
 Q5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693906770; x=1694511570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e2aQnsloqfkEt0Tpy/wv4DHI5jNQaAU39mBOeVaw6Vg=;
 b=lqh4/2R3vkq/Hmmbkgz137YUXUSsHePHd8Z3iyCiYDz4CKxSSqCAjUZcL1E/5h5u4m
 oV+tfDT4N+bf3nq3FG7lSGPXxAWN1xDCXSO39vu0wmXqzfNEDRWmpZd768TfJERw5nf8
 i1ail9XsXtJRQw21LYLESythIFexlNKwTIwaz8yqIeT4vB77QrKFj8syDoyH6qA9ozkA
 k+WXi8TiYfOtsbSFojg+T0Z86tvY5ljOUob64XwT8fIupm4DApSB21ZSq1gWnNtrug/m
 zeiqlxqt3duxthr45V1eQ5meBQhbynUNycKP4YWVKGdqV5/0W7td+kBOMeASqSPBNbuH
 CqiA==
X-Gm-Message-State: AOJu0Yw56wTr0t6FSlqzaa5FpknQuxDnM9kZHCyfUn0KNDtfyfUxgUkS
 2yKsL9+foA41S5HHllR0gIUwWA==
X-Google-Smtp-Source: AGHT+IFHrhG0IoBnoNkMDHlrfg9XL7KrBBMZHnL9SOwPwcAD/PxZ5qamcwXx2/P3GArIXs4xV7ircQ==
X-Received: by 2002:a7b:cb8f:0:b0:3fc:e1:24b5 with SMTP id
 m15-20020a7bcb8f000000b003fc00e124b5mr9411214wmi.23.1693906769970; 
 Tue, 05 Sep 2023 02:39:29 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fedcd02e2asm16332351wmg.35.2023.09.05.02.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:39:29 -0700 (PDT)
Message-ID: <62489e2b-5d03-1650-6337-a4159e88e439@linaro.org>
Date: Tue, 5 Sep 2023 11:39:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] migration/dirtyrate: use QEMU_CLOCK_HOST to report
 start-time
Content-Language: en-US
To: Andrei Gudkov <gudkov.andrei@huawei.com>, qemu-devel@nongnu.org
Cc: yong.huang@smartx.com, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, eblake@redhat.com, armbru@redhat.com
References: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi Andrei,

On 5/9/23 11:18, Andrei Gudkov via wrote:
> Currently query-dirty-rate uses QEMU_CLOCK_REALTIME as
> the source for start-time field. This translates to
> clock_gettime(CLOCK_MONOTONIC), i.e. number of seconds
> since host boot. This is not very useful. The only
> reasonable use case of start-time I can imagine is to
> check whether previously completed measurements are
> too old or not. But this makes sense only if start-time
> is reported as host wall-clock time.
> 
> This patch replaces source of start-time from
> QEMU_CLOCK_REALTIME to QEMU_CLOCK_HOST.
> 
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>   qapi/migration.json   |  4 ++--
>   migration/dirtyrate.c | 15 ++++++---------
>   2 files changed, 8 insertions(+), 11 deletions(-)


> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bccb3515e3..0510d68765 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -259,11 +259,10 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
>       return info;
>   }
>   
> -static void init_dirtyrate_stat(int64_t start_time,
> -                                struct DirtyRateConfig config)
> +static void init_dirtyrate_stat(struct DirtyRateConfig config)
>   {
>       DirtyStat.dirty_rate = -1;
> -    DirtyStat.start_time = start_time;
> +    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
>       DirtyStat.calc_time = config.sample_period_seconds;
>       DirtyStat.sample_pages = config.sample_pages_per_gigabytes;
>   
> @@ -600,7 +599,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
>       record_dirtypages_bitmap(&dirty_pages, true);
>   
>       start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -    DirtyStat.start_time = start_time / 1000;
> +    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;

You can directly use qemu_clock_get_us().


