Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776087B3BE4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:22:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKvj-0002b5-W1; Fri, 29 Sep 2023 17:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKvh-0002au-NC
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:21:45 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKvf-0005KR-AB
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:21:45 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-578a62c088cso848569a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022499; x=1696627299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8WcT4KMSKxn8nW/zCSKFRW8WhXzO+eFt3Y5uzjDZ8E=;
 b=ieNvnK2EcGt2tcwdRC2F/ttwxhED2D0jELB2BMCSCrPzLjLQrFUDEWXdqvoht65Ivm
 UO5K4RfaHFGTgbSJMnZ//zRAGRAV+Npd6NZ7WtDgQo7XPp2GCWUVSSeajcJddmVKEaF/
 uqSmHtJzkpHI0biUkg7CfEFuLX0mHVC/62bH2wK2IsyNRTPneki95DX0MZh8ih1FxtxJ
 mmt6D8OJs/pqLSMZg/TTXSKnuODE7vBvdAdoqZlgRcoNFZ7G4ag4ZG0Vv369Yuxw9qBL
 tzlLgwVFDap3wPJEXDtzYqaNOKUq6+g1rN7fA7LU47yV9ZPxwJFQE1DqaySELpJd7j1E
 R/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022499; x=1696627299;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8WcT4KMSKxn8nW/zCSKFRW8WhXzO+eFt3Y5uzjDZ8E=;
 b=h+2ZsusaY3DhjnsyvvryTb/vcXT53APDb4pP6afByOFIDYHeYAiTnWJpZ6RqLksis1
 8rQ9sQGbtsJGCgU0f/HA4ig3m62OWQiKOgrkxox6k4+tcgRNUTEaG03frANsyPVmZVnF
 lmziQ4WT1Z/+hyAqzvVn0eenRagxmVxGpdbAyk8nWYLvHaYuuM+eEL94DVqPkgonlWWS
 Tj7lOqACwe/lsCz2S+jMsXVvKJigmn26RFIHFkwUI4hrXrYFuduAlx89mBCA9INUtahb
 AXIHmjOyzCvtvx7H2Ygm4e6mjgEYvkrbliSDLQJdRR8bgAuD+tUrXrFBMhhI564qiNUI
 gBZQ==
X-Gm-Message-State: AOJu0YyV4K4mr8lHUPECJAwK18b5OLI0oeg+p6HhrBf0C9pWZzddJzK2
 VVrhgwqh6ojpjRWIeZRUYCe3NmOqGi9fcKn0jSI=
X-Google-Smtp-Source: AGHT+IFNRkIRi0LhzcZEEhjmTURPJF85CIzLG9E1DOiDEs1Ee09hv1LaLr26kDuvBYxMl6LEtQKBuQ==
X-Received: by 2002:a17:90a:d14a:b0:268:2af6:e48c with SMTP id
 t10-20020a17090ad14a00b002682af6e48cmr8447317pjw.4.1696022499411; 
 Fri, 29 Sep 2023 14:21:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a17090abe0f00b00256b67208b1sm1892103pjs.56.2023.09.29.14.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:21:38 -0700 (PDT)
Message-ID: <e4f6f9c1-4394-98c4-9145-b8d7e2cb1c68@linaro.org>
Date: Fri, 29 Sep 2023 14:21:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 14/22] target/sparc: Init CPU environment *after*
 accelerator vCPU is realized
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> These fields from the environment don't affect how accelerators
> create their vCPU thread. We can safely reorder them*after*  the
> cpu_exec_realizefn() call. Doing so allows further generic API
> simplification (in the next commit).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/cpu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

