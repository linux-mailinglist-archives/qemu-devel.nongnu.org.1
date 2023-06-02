Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BD71F915
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 06:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4w07-0004Ia-Pi; Fri, 02 Jun 2023 00:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4w05-0004IR-P0
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 00:02:53 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4w04-0006t0-6i
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 00:02:53 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6af81142b6dso1502932a34.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 21:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685678571; x=1688270571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXT42PC1uIWrRxogdNu3uLfbr804fzBo9BWphs3Puhk=;
 b=Ov1nh+p4gDf+QHGc0bmzqt91fj/J4CCIdxZrcKP2vNqllmf4pWClvC+PPsAtt5BDZT
 89bg+6Kwr0vNIIQPjN+8VZ9qZTRbxWkOXfZupCvSA0ijONDwL5NEXWgPfzYUoLKI59Es
 cPvuYuTaB2HaT/2BDnm/0uGNAKvAMRiD3tE874ZephI7t1W3QN5O1e4AlC62FlOVdmgj
 4nO0Hc+Rw2A/dWznshz9fdESxYJ1Nxktly+ZIDN2wPJYk/DFOCij4DKUT6JQ9cwmQyhq
 Pheyq9BIWct1efcGgcaXfqMn7dM0KW1uriPPj/fK1kpM5MEl0nSNmR007TuBYxs1wKo5
 YQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685678571; x=1688270571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXT42PC1uIWrRxogdNu3uLfbr804fzBo9BWphs3Puhk=;
 b=Lue3Hlh+lHQqQuvjbo6LUfsnPAyIjRkHbZPjkqoKTV3jsmhLc1n/sFGxAhHv4kSrOu
 4/cqRttQ9ZJOrj4oFx8h9dvPnZV4zKeKuA8tPTRUfz83hKgzldogylkAw3RSRlSll1pa
 XhuCP8xSYjn49/NcLxNgqvSqrustRPTqvMbC4LSsDKV1pXSFXOdYvDqwj/iKZAuvg4NV
 BE6IW1D6KEpCXKeIDQmFR5iuYmXve8iScpwW9i6lM8Oer/2Ae9rQWGcKa55Av4hXSz8V
 xHpceUlfLEJ9rS8aPvFuJBemDYwGISEtGxUP1fQ3XPUhU7ZamOxUgnv2tWZnwtg7YRNF
 ++/Q==
X-Gm-Message-State: AC+VfDzZujoKJJREblf/LzuLNb4Fa6Db5TFFbnaIxHkBpI04Mjqibe+q
 1P5ts4rscet49Cqa0kuWWJKWLw==
X-Google-Smtp-Source: ACHHUZ7FEjgcsHXqunXNnRpnmLclA4yFrwEPPpRuy2uMDeAunfwf27pGrzJBuw6Vkp6yzNutX8TuTw==
X-Received: by 2002:a05:6830:3b07:b0:6b0:49d:15a with SMTP id
 dk7-20020a0568303b0700b006b0049d015amr1397609otb.3.1685678570988; 
 Thu, 01 Jun 2023 21:02:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:a70d:ae79:598f:409b?
 ([2602:ae:1598:4c01:a70d:ae79:598f:409b])
 by smtp.gmail.com with ESMTPSA id
 u25-20020aa78499000000b00627fafe49f9sm63687pfn.106.2023.06.01.21.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 21:02:50 -0700 (PDT)
Message-ID: <14a9b8f2-738f-779d-6167-bfbe71dbd82d@linaro.org>
Date: Thu, 1 Jun 2023 21:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 03/10] accel: collecting TB execution count
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-4-fei2.wu@intel.com>
 <fe705139-31e9-974b-4e45-2f0c653359da@linaro.org>
 <2ef489e6-4412-d792-7a33-153a30db3289@intel.com>
 <1b8dceed-548f-d155-b4fb-80e76408db7d@linaro.org>
 <ea8032cc-63c7-da86-a9d3-7bf0c25ed8c1@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ea8032cc-63c7-da86-a9d3-7bf0c25ed8c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 6/1/23 18:54, Wu, Fei wrote:
>> We are not *checking* the tb->tb_stats->stats_enabled bit except at code
>> generation time, not code execution time.  Therefore nothing ever reads
>> the TB_PAUSED bit (or, correspondingly, the clearing of the other
>> bits).  The setting of the bit is permanent.
>>
> At dump time, it does check stats_enabled e.g. in dump_tb_header(). So
> the question is whether FILTER is necessary at all? If not, we can
> remove FILTER together with PAUSE, and only keep START & STOP in hmp cmd.

Let's start simpler and remove FILTER and PAUSE.


r~

