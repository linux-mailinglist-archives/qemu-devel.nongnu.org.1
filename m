Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055F7191A9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 06:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ZkK-0007bk-34; Thu, 01 Jun 2023 00:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4ZkE-0007bM-9i
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 00:17:02 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Zk8-00068z-Nj
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 00:17:02 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2566ed9328eso220133a91.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 21:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685593015; x=1688185015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUfNiZs8QB61rPIJ8npWFJqcw9z7fL8ycKfRuWV2zlI=;
 b=Xd6AepsnqVSJSxcg37AdMYET4so78Q+4P7cTA7+8SLWv8K1AbFgeuH67MKaDBvLlSh
 Rq4MuFMVkjrhpRbIJFd3vhO+pi99HENHMgDAbnpOj0Q6bB8g2L8Y57KlIaxJm/nVfnoE
 Qu3XjTFsA14pK+zo4Uku4+rYQPyLfyoTffU8HNupUj/DhS5erL7V9AZ4m3BMW23QNuao
 Sr5JDXMjhjkEarNPmJCM/dRn/d1nVOPBYTiRjPNOxJH80CvHNr9XoafMw9SVxPRY6Raq
 inPXSEC96HqVcHeXjgcR5pPCakBzZ2R8X6ENOnEIZZ9EVs5fpyFLP5nM1EGxQqAbTN6J
 dbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685593015; x=1688185015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUfNiZs8QB61rPIJ8npWFJqcw9z7fL8ycKfRuWV2zlI=;
 b=a7MfKSkD3dnBz6MKjyh7fiywiGbd1hr63VCzESF3tKEvysAww/Cb/208Sl6GwUZvhg
 pMdumpT9Me5jC1RVNM1tNUkL8MLmk5CzJoEffOWhO+JhaTmt1f8pel2uhTjwl7WuzfuP
 9gq6HMqzpWzlc+zsAfKr/Kzj4O1FiXvuzY4SlE1EKlwYKSOdobTGZeByH0N6a1X74a3O
 App6RVmSkQFhQTNYqdaqc5nl/diqqwpZvjEsvPF5xvb6MqvMPrbn7NRWGof1KO90aL7q
 liapVUE7YiSBl0OnkQ+5/VkUAEV8PUUG4IIw3Ra8Hjb/hp/0yC7feDZc/Y6iaODBh5Ic
 9lTw==
X-Gm-Message-State: AC+VfDxFiP2c3bhFM1mMZJ1yDh6zZZ0olsWR71VwDqX1fa1riBlQPcOp
 ORvKkNTs1TXAuA3UQkFh/Uk6jA==
X-Google-Smtp-Source: ACHHUZ5+HVBsogIGUYuIlker96K4SL9UFaLbnXdsluTHE6fv/11hy4uVgLANmZnBme6SISj0Uima0g==
X-Received: by 2002:a17:90a:fd0f:b0:256:c3dc:dae6 with SMTP id
 cv15-20020a17090afd0f00b00256c3dcdae6mr6876292pjb.31.1685593014835; 
 Wed, 31 May 2023 21:16:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 gk7-20020a17090b118700b002532eef4fc5sm332533pjb.34.2023.05.31.21.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 21:16:54 -0700 (PDT)
Message-ID: <62b50a3a-1e03-ef88-ed39-89cf61048122@linaro.org>
Date: Wed, 31 May 2023 21:16:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] accel/tcg: introduce TBStatistics structure
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-3-fei2.wu@intel.com>
 <b4859236-58eb-7709-235f-5096aeb9861f@linaro.org>
 <eb173080-68e6-df4b-f070-49315a09242c@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <eb173080-68e6-df4b-f070-49315a09242c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/31/23 20:19, Wu, Fei wrote:
> On 6/1/2023 8:01 AM, Richard Henderson wrote:
>> On 5/30/23 01:35, Fei Wu wrote:
>>> +/* TBStatistic collection controls */
>>> +enum TBStatsStatus {
>>> +    TB_STATS_DISABLED = 0,
>>> +    TB_STATS_RUNNING,
>>> +    TB_STATS_PAUSED,
>>> +    TB_STATS_STOPPED
>>> +};
>>
>> I don't see what PAUSED or STOPPED actually do.
>> As far as I can see, stats are either being collected or not: a boolean.
>>
> If STOPPED, clean_tbstats() gets called, all the tbstats history is
> destroyed, but it's not for PAUSED.

But it doesn't PAUSE everything either, since (1) code is built into each tb, and (2) each 
tb->tb_stats->stats_enabled neither changed.  Indeed, tb_stats_collection_enabled() is 
only checked in a fraction of the places stats are collected.


r~


