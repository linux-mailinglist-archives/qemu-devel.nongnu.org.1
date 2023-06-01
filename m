Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00B718FED
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 03:19:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Wx7-0002lt-04; Wed, 31 May 2023 21:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Wx4-0002lW-Hm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:18:06 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Wx2-0004De-W0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:18:06 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6af70ff2761so337220a34.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 18:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685582283; x=1688174283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRH6v4Dk14Wm87Z/nQQld7oPHwpZBmEbwacYB2BaKyU=;
 b=BhuZfJ2jI7rYBu6khFTqMOB8hCfN5YBh5F9yK9L8UEl7cdtvQa/7tethxxNr93spj2
 IgiW2fApYXk9qyl9KOz7TLGhsLFTnu5zSKgr/HyHRAaNeC9QcdMePJuVGAb30aZe8i0g
 XbHT+FSkUpElUH47g/LhW9AM48rKlsMc99yosdGo7OPUpb4vx5fZpDwTM81FmyfeXpYE
 9D9H/LwwMxvViOavuCyy2wesqBSatuldQwPmqQ4RjLhaTlqVvG6EGTN107kv+lF/TYE+
 q8y4nvsHMsGqy++MDC/9eohBOH+XIeASlwFMrYwKi6yS/KnJcxkI1QQvGIUkGq7nsBEt
 uBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685582283; x=1688174283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRH6v4Dk14Wm87Z/nQQld7oPHwpZBmEbwacYB2BaKyU=;
 b=jEjH7wo2tp/kHPaDK5fFWM4jJNWFvQ0pzFfPQ1NaoPyi1JaMw0Ls7uqnvZUdQb24Ul
 9eTLU+RwcCKEllVEzYX4iBX2thiLudP83b37sD62osu3TifIcjNEAVC6tTIFGRUMq1K+
 5nbCsZBTM11H46p34By4vtzY9SEScjUtvb1FTQ0xvC8aBq/GuUdExvfO2tp/Wgu6CRB+
 G8WSWC8nYkkPiGEw9S1l6pZOmy8+KP85D3pFfJdnK+A90grc0CV1zWJ0E17DlC4zBm1l
 wH4Rr5hl/O1AD+V9Z1RhEC5Ppd+ChX2I6KTBtD2dxue5OJSDyr5LAInKl67Xqk3MO9aF
 YXww==
X-Gm-Message-State: AC+VfDxCZuhA6hbQjRopBTe3bxbGYu2bmK43lt2TnuoOX5wrCg4m7mbL
 8DVvYgw0f/gllz4G/eiGsvNuIw==
X-Google-Smtp-Source: ACHHUZ5+QWPbHzSVIfVcgYYggoSXKumIFfLLmERr/w4ZfNr/SKIFaOaXH1ws84uCvRasEDYWgxos8Q==
X-Received: by 2002:a9d:6188:0:b0:6ac:a839:4da3 with SMTP id
 g8-20020a9d6188000000b006aca8394da3mr3595327otk.23.1685582283480; 
 Wed, 31 May 2023 18:18:03 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a62ee0a000000b0064d5b82f987sm4003355pfi.140.2023.05.31.18.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 18:18:03 -0700 (PDT)
Message-ID: <4c32a2e4-1370-b81f-9fec-2603648c60c3@linaro.org>
Date: Wed, 31 May 2023 18:18:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 05/10] debug: add -d tb_stats to control TBStatistics
 collection:
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-6-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-6-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
>   -d tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]
> 
> "dump_limit" is used to limit the number of dumped TBStats in
> linux-user mode.

Why is user-mode special?

> 
> [all+jit+exec+time] control the profilling level used
> by the TBStats. Can be used as follow:
> 
> -d tb_stats
> -d tb_stats,level=jit+time

Comma is already used to separate different -d options.
You should not overload that.

"level" doesn't make sense for things that aren't hierarchical.

What's wrong with tb-stats-{all,jit,time,exec}?


r~

